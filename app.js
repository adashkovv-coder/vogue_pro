/* ============================================================
   ЛОГИКА ПРИЛОЖЕНИЯ
   ============================================================ */

import { TEMPLATES, getTemplate, getCategories } from './templates/registry.js';

const $  = (s,r=document) => r.querySelector(s);
const $$ = (s,r=document) => Array.from(r.querySelectorAll(s));
const esc = s => String(s==null?'':s)
  .replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));


/* ============================================================
   ⚡ АВТО-УЛУЧШЕНИЕ ФОТО
   Апскейл до 1800px + лёгкий sharpen + контраст + насыщенность
   ============================================================ */

const MIN_SIDE = 1800;       // минимальная сторона после обработки
const JPEG_QUALITY = 0.94;   // качество выходного JPEG

async function enhanceImage(file){
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const img = new Image();
      img.onload = () => {
        try {
          const result = processImage(img);
          resolve(result);
        } catch(err){
          console.warn('Enhance failed, fallback to raw:', err);
          resolve(e.target.result);
        }
      };
      img.onerror = () => resolve(e.target.result);
      img.src = e.target.result;
    };
    reader.readAsDataURL(file);
  });
}

function processImage(img){
  // 1. Считаем целевой размер (не уменьшаем, но апскейлим до MIN_SIDE)
  let w = img.naturalWidth;
  let h = img.naturalHeight;
  const minDim = Math.min(w, h);
  const maxDim = Math.max(w, h);

  // Если изображение меньше 1800px по любой стороне — апскейлим
  if (maxDim < MIN_SIDE) {
    const scale = MIN_SIDE / maxDim;
    w = Math.round(w * scale);
    h = Math.round(h * scale);
  } else if (minDim < 900) {
    // Если одна сторона слишком маленькая — апскейлим пропорционально
    const scale = 900 / minDim;
    w = Math.round(w * scale);
    h = Math.round(h * scale);
  }

  // Ограничиваем максимум — чтобы не раздувать память
  const MAX_SIDE = 3200;
  if (Math.max(w, h) > MAX_SIDE){
    const s = MAX_SIDE / Math.max(w, h);
    w = Math.round(w * s);
    h = Math.round(h * s);
  }

  // 2. Рисуем на canvas с хорошей интерполяцией
  const canvas = document.createElement('canvas');
  canvas.width = w;
  canvas.height = h;
  const ctx = canvas.getContext('2d');
  ctx.imageSmoothingEnabled = true;
  ctx.imageSmoothingQuality = 'high';
  ctx.drawImage(img, 0, 0, w, h);

  // 3. Лёгкое улучшение: контраст + насыщенность + яркость через CSS-фильтр
  //    (применяем через отдельный canvas-фильтр, если поддерживается)
  const tmp = document.createElement('canvas');
  tmp.width = w;
  tmp.height = h;
  const tctx = tmp.getContext('2d');

  // ctx.filter поддерживается в современных браузерах
  if ('filter' in tctx){
    tctx.filter = 'contrast(1.06) saturate(1.08) brightness(1.02)';
    tctx.drawImage(canvas, 0, 0);
  } else {
    tctx.drawImage(canvas, 0, 0);
  }

  // 4. Лёгкий sharpen (unsharp mask) через ImageData
  const imageData = tctx.getImageData(0, 0, w, h);
  const sharpened = unsharpMask(imageData, w, h, 0.55, 1);
  tctx.putImageData(sharpened, 0, 0);

  // 5. Сохраняем как JPEG
  return tmp.toDataURL('image/jpeg', JPEG_QUALITY);
}

/* Простой unsharp mask: размытие + вычитание + добавление */
function unsharpMask(imageData, w, h, amount, radius){
  const src = imageData.data;
  const out = new Uint8ClampedArray(src.length);

  // Лёгкое box-blur 3x3
  const blurred = new Uint8ClampedArray(src.length);
  for (let y = 0; y < h; y++){
    for (let x = 0; x < w; x++){
      let r = 0, g = 0, b = 0, n = 0;
      for (let dy = -1; dy <= 1; dy++){
        for (let dx = -1; dx <= 1; dx++){
          const nx = x + dx, ny = y + dy;
          if (nx < 0 || nx >= w || ny < 0 || ny >= h) continue;
          const i = (ny * w + nx) * 4;
          r += src[i]; g += src[i+1]; b += src[i+2]; n++;
        }
      }
      const i = (y * w + x) * 4;
      blurred[i]   = r / n;
      blurred[i+1] = g / n;
      blurred[i+2] = b / n;
      blurred[i+3] = src[i+3];
    }
  }

  // Sharpening: out = src + amount * (src - blurred)
  for (let i = 0; i < src.length; i += 4){
    out[i]   = Math.min(255, Math.max(0, src[i]   + amount * (src[i]   - blurred[i])));
    out[i+1] = Math.min(255, Math.max(0, src[i+1] + amount * (src[i+1] - blurred[i+1])));
    out[i+2] = Math.min(255, Math.max(0, src[i+2] + amount * (src[i+2] - blurred[i+2])));
    out[i+3] = src[i+3];
  }

  return new ImageData(out, w, h);
}

function show(id){
  $$('.screen').forEach(s => s.classList.toggle('active', s.id === id));
  window.scrollTo(0,0);
}

const state = { pageCount: 12, pages: [], activeIndex: 0, filter: 'Все' };

function blankPage(templateId){
  const tpl = getTemplate(templateId);
  return { templateId, content: tpl ? {...tpl.defaults} : {} };
}

function renderPage(page, no){
  const tpl = getTemplate(page.templateId);
  if (!tpl){
    return `<div class="page" style="background:#f4f1ec;">
      <div style="position:absolute;inset:0;display:flex;align-items:center;justify-content:center;flex-direction:column;gap:14px;">
        <div style="font-family:'Playfair Display',serif;font-size:24px;color:#a49c90;">Шаблон не выбран</div>
        <div style="font-family:'Inter',sans-serif;font-size:11px;letter-spacing:.24em;text-transform:uppercase;color:#c0b8aa;">Нажмите «Сменить шаблон»</div>
      </div>
    </div>`;
  }
  return tpl.render(page.content || {}, no);
}

function initPages(){
  const n = state.pageCount;
  const covers = TEMPLATES.filter(t => t.category === 'Обложки');
  const backs  = TEMPLATES.filter(t => t.category === 'Задние обложки');
  const others = TEMPLATES.filter(t => t.category !== 'Обложки' && t.category !== 'Задние обложки');

  const coverTpl = covers[0] || TEMPLATES[0] || null;
  const backTpl  = backs[0]  || TEMPLATES[TEMPLATES.length-1] || null;

  const pages = [];
  if (coverTpl) pages.push(blankPage(coverTpl.id));
  else          pages.push({ templateId:null, content:{} });

  for (let i = 0; i < n - 2; i++){
    if (others.length) pages.push(blankPage(others[i % others.length].id));
    else if (TEMPLATES.length) pages.push(blankPage(TEMPLATES[i % TEMPLATES.length].id));
    else pages.push({ templateId:null, content:{} });
  }

  if (backTpl) pages.push(blankPage(backTpl.id));
  else         pages.push({ templateId:null, content:{} });

  state.pages = pages;
  state.activeIndex = 0;
}

function renderPageList(){
  $('#page-list').innerHTML = state.pages.map((p, i) => {
    const tpl = getTemplate(p.templateId);
    return `<li class="page-item ${i===state.activeIndex?'active':''}" data-index="${i}">
      <span class="page-num">${i+1}</span>
      <div class="page-thumb-mini"><div class="thumb-scaler">${renderPage(p, i+1)}</div></div>
      <div class="page-name">${esc(tpl?.name || 'Пусто')}</div>
    </li>`;
  }).join('');

  requestAnimationFrame(() => {
    $$('.page-thumb-mini').forEach(el => {
      const s = el.clientWidth / 794;
      const sc = el.querySelector('.thumb-scaler');
      if (sc) sc.style.transform = `scale(${s})`;
    });
  });
}

// ⚡ Обновляет только превью — форма НЕ перерисовывается
function refreshStage(){
  const p = state.pages[state.activeIndex];
  const sc = $('#stage-preview').querySelector('.thumb-scaler');
  if (sc) sc.innerHTML = renderPage(p, state.activeIndex+1);
}
function refreshActiveThumb(){
  const li = $(`.page-item[data-index="${state.activeIndex}"] .thumb-scaler`);
  if (li) li.innerHTML = renderPage(state.pages[state.activeIndex], state.activeIndex+1);
}

function renderStage(){
  const p = state.pages[state.activeIndex];
  const tpl = getTemplate(p.templateId);

  $('#stage-title').textContent = `Страница ${state.activeIndex+1} из ${state.pages.length}`;
  const wrap = $('#stage-preview');
  wrap.innerHTML = `<div class="thumb-scaler">${renderPage(p, state.activeIndex+1)}</div>`;

  requestAnimationFrame(() => {
    const s = wrap.clientWidth / 794;
    const sc = wrap.querySelector('.thumb-scaler');
    if (sc) sc.style.transform = `scale(${s})`;
    wrap.style.height = (1123 * s) + 'px';
  });

  $('#tpl-name').textContent = tpl?.name || '—';
  $('#tpl-cat').textContent = tpl?.category || '';
  renderFields();
}

function renderFields(){
  const p = state.pages[state.activeIndex];
  const tpl = getTemplate(p.templateId);
  const box = $('#form-fields');

  if (!tpl){
    box.innerHTML = '<p style="color:#8a8378;font-size:13px;line-height:1.6;">Шаблон не выбран. Нажмите «Сменить шаблон», чтобы выбрать.</p>';
    return;
  }
  if (!tpl.fields || !tpl.fields.length){
    box.innerHTML = '<p style="color:#8a8378;font-size:13px;">У этого шаблона нет редактируемых полей.</p>';
    return;
  }

  box.innerHTML = tpl.fields.map(f => {
    const val = p.content[f.key] ?? '';

    /* ══ ОДНО ФОТО ══ */
    if (f.type === 'image'){
      const has = !!val;
      return `<div class="field"><label>${esc(f.label)}</label>
        <div class="file-row">
          <label class="file-btn">
            <input type="file" accept="image/*" data-photo="${f.key}" hidden>
            <span>${has ? 'Заменить' : 'Загрузить фото'}</span>
          </label>
          ${has ? `<button class="mini-btn" type="button" data-photo-clear="${f.key}">Удалить</button>` : ''}
        </div></div>`;
    }

    /* ══ МНОГО ФОТО — одно поле на все слоты ══ */
    if (f.type === 'photos'){
      const slots = f.slots || [];
      const filled = slots.filter(k => p.content[k]).length;
      return `<div class="field">
        <label>${esc(f.label)} <span class="field-count">${filled} / ${slots.length}</span></label>
        <div class="file-row">
          <label class="file-btn file-btn--multi">
            <input type="file" accept="image/*" multiple data-photos="${f.key}" data-slots="${slots.join(',')}" hidden>
            <span>${filled ? 'Заменить все' : `Загрузить ${slots.length} фото`}</span>
          </label>
          ${filled ? `<button class="mini-btn" type="button" data-photos-clear="${slots.join(',')}">Очистить</button>` : ''}
        </div>
        <div class="photos-preview">
          ${slots.map((k,i) => {
            const has = !!p.content[k];
            return `<div class="pp-item ${has?'':'empty'}" style="${has?`background-image:url('${p.content[k]}')`:''}">
              <span class="pp-num">${i+1}</span>
              ${has?`<button type="button" class="pp-del" data-photo-del="${k}">✕</button>`:''}
            </div>`;
          }).join('')}
        </div>
      </div>`;
    }

    if (f.type === 'textarea'){
      return `<div class="field"><label>${esc(f.label)}</label>
        <textarea rows="4" data-text="${f.key}">${esc(val)}</textarea></div>`;
    }

    return `<div class="field"><label>${esc(f.label)}</label>
      <input type="text" data-text="${f.key}" value="${esc(val)}"></div>`;
  }).join('');
}

function renderEditor(){
  renderPageList();
  renderStage();
  $('#topbar-info').textContent = `${state.pages.length} стр. · A4`;
}

/* ══ ГАЛЕРЕЯ ══ */
function openGallery(){
  if (!TEMPLATES.length){ alert('Пока нет шаблонов'); return; }
  state.filter = 'Все';
  renderCategories();
  renderGallery();
  $('#modal-page-label').textContent = `· страница ${state.activeIndex+1}`;
  $('#gallery-modal').classList.remove('hidden');
}
function closeGallery(){ $('#gallery-modal').classList.add('hidden'); }

function renderCategories(){
  $('#category-filter').innerHTML = getCategories().map(c =>
    `<button class="cat-chip ${state.filter===c?'active':''}" data-cat="${esc(c)}">${esc(c)}</button>`
  ).join('');
}

function renderGallery(){
  const curId = state.pages[state.activeIndex].templateId;
  let list = TEMPLATES;
  if (state.filter !== 'Все') list = list.filter(t => t.category === state.filter);

  $('#gallery-grid').innerHTML = list.map(t => {
    const sample = { templateId: t.id, content: {...t.defaults} };
    return `<div class="gallery-item ${t.id===curId?'active-tpl':''}" data-tpl="${t.id}">
      <div class="thumb-wrap"><div class="thumb-scaler">${renderPage(sample, 1)}</div></div>
      <div class="g-meta">
        <div class="g-name">${esc(t.name)}</div>
        <div class="g-cat">${esc(t.category)}</div>
      </div>
    </div>`;
  }).join('');

  requestAnimationFrame(() => {
    $$('.gallery-item .thumb-wrap').forEach(el => {
      const s = el.clientWidth / 794;
      const sc = el.querySelector('.thumb-scaler');
      if (sc) sc.style.transform = `scale(${s})`;
    });
  });
}

function applyTemplate(tplId){
  const p = state.pages[state.activeIndex];
  const newTpl = getTemplate(tplId);
  if (!newTpl) return;
  const newContent = {...newTpl.defaults};
  Object.keys(p.content || {}).forEach(k => {
    if (k in newContent) newContent[k] = p.content[k];
  });
  p.templateId = tplId;
  p.content = newContent;
  closeGallery();
  renderEditor();
}

/* ══ СОБЫТИЯ ══ */
$('#page-list').addEventListener('click', e => {
  const item = e.target.closest('.page-item');
  if (!item) return;
  state.activeIndex = parseInt(item.dataset.index, 10);
  renderEditor();
});

/* ⚡ ВВОД ТЕКСТА — без перерисовки формы */
$('#form-fields').addEventListener('input', e => {
  const t = e.target;
  if (!t.dataset.text) return;
  state.pages[state.activeIndex].content[t.dataset.text] = t.value;
  refreshStage();
  refreshActiveThumb();
});

/* ⚡ ЗАГРУЗКА ФАЙЛОВ */
$('#form-fields').addEventListener('change', e => {
  const t = e.target;
  const p = state.pages[state.activeIndex];

  /* ── Много фото — все с улучшением ── */
  if (t.dataset.photos){
    const slots = (t.dataset.slots || '').split(',').filter(Boolean);
    const files = Array.from(t.files || []);
    if (!files.length || !slots.length) return;

    const total = Math.min(files.length, slots.length);

    // Показываем прогресс
    const statusEl = document.getElementById('photo-status');
    if (statusEl) statusEl.textContent = `Улучшаю 0/${total}…`;

    Promise.all(
      files.slice(0, total).map((file, idx) =>
        enhanceImage(file).then((dataURL) => {
          p.content[slots[idx]] = dataURL;
          if (statusEl) statusEl.textContent = `Улучшаю ${idx+1}/${total}…`;
        })
      )
    ).then(() => {
      if (statusEl) statusEl.textContent = `✓ ${total} фото улучшено`;
      renderEditor();
      setTimeout(() => { if (statusEl) statusEl.textContent = ''; }, 2500);
    });
  }

  /* ── Одно фото — с улучшением ── */
  if (t.dataset.photo){
    const f = t.files && t.files[0];
    if (!f) return;
    enhanceImage(f).then((dataURL) => {
      p.content[t.dataset.photo] = dataURL;
      renderEditor();
    });
  }

  if (t.dataset.text){
    p.content[t.dataset.text] = t.value;
    refreshStage();
    refreshActiveThumb();
  }
});

/* ⚡ КЛИКИ: удалить фото / очистить все */
$('#form-fields').addEventListener('click', e => {
  const p = state.pages[state.activeIndex];

  const cd = e.target.closest('[data-photo-del]');
  if (cd){
    p.content[cd.dataset.photoDel] = null;
    renderEditor();
    return;
  }

  const cc = e.target.closest('[data-photo-clear]');
  if (cc){
    p.content[cc.dataset.photoClear] = null;
    renderEditor();
    return;
  }

  const pc = e.target.closest('[data-photos-clear]');
  if (pc){
    pc.dataset.photosClear.split(',').forEach(k => p.content[k] = null);
    renderEditor();
    return;
  }
});

$('#btn-change-tpl').addEventListener('click', openGallery);
$('#modal-close').addEventListener('click', closeGallery);
$('#gallery-modal').addEventListener('click', e => {
  if (e.target === $('#gallery-modal')) closeGallery();
});
$('#category-filter').addEventListener('click', e => {
  const chip = e.target.closest('.cat-chip');
  if (!chip) return;
  state.filter = chip.dataset.cat;
  renderCategories();
  renderGallery();
});
$('#gallery-grid').addEventListener('click', e => {
  const item = e.target.closest('.gallery-item');
  if (!item) return;
  applyTemplate(item.dataset.tpl);
});

/* ══ КОЛИЧЕСТВО СТРАНИЦ ══ */
function renderPageOptions(){
  const opts = [4,8,12,16,20,24,28,32,36,40];
  $('#page-options').innerHTML = opts.map(n =>
    `<button class="page-opt ${n===state.pageCount?'active':''}" data-n="${n}">
      <b>${n}</b><span>страниц</span>
    </button>`).join('');
}
$('#page-options').addEventListener('click', e => {
  const b = e.target.closest('.page-opt');
  if (!b) return;
  state.pageCount = parseInt(b.dataset.n, 10);
  renderPageOptions();
});

/* ══ НАВИГАЦИЯ ══ */
$('#btn-start').addEventListener('click', () => { renderPageOptions(); show('screen-pages'); });
$('#btn-back-1').addEventListener('click', () => show('screen-start'));
$('#btn-editor-back').addEventListener('click', () => { renderPageOptions(); show('screen-pages'); });
$('#btn-to-editor').addEventListener('click', async () => {
  for (const t of TEMPLATES){
    if (typeof t.preload === 'function'){
      try { await t.preload(); } catch(e){ console.warn('preload failed', t.id, e); }
    }
  }
  initPages();
  renderEditor();
  show('screen-editor');
});

/* ══ PDF ══ */
$('#btn-pdf').addEventListener('click', downloadPDF);
async function downloadPDF(){
  const btn = $('#btn-pdf');
  const holder = $('#render-holder');
  btn.disabled = true;
  btn.textContent = 'Готовим…';
  holder.innerHTML = '';

  const nodes = state.pages.map((p, i) => {
    const d = document.createElement('div');
    d.innerHTML = renderPage(p, i+1).trim();
    const node = d.firstElementChild;
    holder.appendChild(node);
    return node;
  });

  await new Promise(r => setTimeout(r, 400));
  const pdf = new window.jspdf.jsPDF({unit:'mm', format:'a4', orientation:'portrait', compress:true});

  try {
    for (let i=0;i<nodes.length;i++){
      btn.textContent = `Стр. ${i+1}/${nodes.length}`;
      await new Promise(r => setTimeout(r, 0));
      const canvas = await html2canvas(nodes[i], {
        scale: 2, backgroundColor: '#ffffff', logging: false, useCORS: true,
        width: 794, height: 1123, windowWidth: 794, windowHeight: 1123
      });
      const img = canvas.toDataURL('image/jpeg', 0.92);
      if (i > 0) pdf.addPage();
      pdf.addImage(img, 'JPEG', 0, 0, 210, 297, undefined, 'FAST');
    }
    pdf.save('VOGUE_journal.pdf');
    btn.textContent = 'Готово ✓';
  } catch(err){
    console.error(err);
    btn.textContent = 'Ошибка';
  } finally {
    holder.innerHTML = '';
    setTimeout(() => { btn.disabled = false; btn.textContent = 'Скачать PDF'; }, 1500);
  }
}
