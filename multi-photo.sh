#!/bin/bash
echo "▬▬▬ Включаю мультизагрузку фото для коллажей ▬▬▬"

# ═══════════════════ ОБНОВЛЯЕМ APP.JS ═══════════════════
cat > app.js << 'EOF'
/* ============================================================
   ЛОГИКА ПРИЛОЖЕНИЯ
   ============================================================ */

import { TEMPLATES, getTemplate, getCategories } from './templates/registry.js';

const $  = (s,r=document) => r.querySelector(s);
const $$ = (s,r=document) => Array.from(r.querySelectorAll(s));
const esc = s => String(s==null?'':s)
  .replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));

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

  /* ── Много фото ── */
  if (t.dataset.photos){
    const slots = (t.dataset.slots || '').split(',').filter(Boolean);
    const files = Array.from(t.files || []);
    if (!files.length || !slots.length) return;

    const total = Math.min(files.length, slots.length);
    let loaded = 0;

    files.slice(0, total).forEach((file, idx) => {
      const r = new FileReader();
      r.onload = () => {
        p.content[slots[idx]] = r.result;
        loaded++;
        if (loaded === total){
          renderEditor();  // перерисуем — фото загрузились все
        }
      };
      r.readAsDataURL(file);
    });
  }

  /* ── Одно фото ── */
  if (t.dataset.photo){
    const f = t.files && t.files[0];
    if (!f) return;
    const r = new FileReader();
    r.onload = () => {
      p.content[t.dataset.photo] = r.result;
      renderEditor();
    };
    r.readAsDataURL(f);
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
EOF

echo "✅ app.js обновлён — мультизагрузка + сохранение фокуса"

# ═══════════════════ ОБНОВЛЯЕМ ШАБЛОНЫ ═══════════════════

# --- 06 OUR MEMORIES LEFT (9 фото) ---
cat > templates/06-our-memories-left.js << 'EOF'
export default {
  id: 'our-memories-left',
  name: 'Our Memories (левая)',
  category: 'Коллажи',
  fields: [
    {key:'word1',label:'Слово курсивом (OUR)',type:'text'},
    {key:'word2',label:'Слово основное (MEMO…)',type:'text'},
    {key:'photos',label:'Загрузить 9 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9']}
  ],
  defaults: {
    word1:'OUR', word2:'MEMORIES',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,
    photo6:null,photo7:null,photo8:null,photo9:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mem-page">
      <div class="mem-title">
        <span class="mem-our">${c.word1||''}</span>
        <span class="mem-memories">${c.word2||''}</span>
      </div>
      <div class="mem-grid">
        <div class="mem-cell mem-1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mem-cell mem-2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mem-cell mem-3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mem-cell mem-4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mem-cell mem-5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mem-cell mem-6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mem-cell mem-7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="mem-cell mem-8 ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="mem-cell mem-9 ${e('photo9')}" style="${p('photo9')}"></div>
      </div>
    </div>`;
  }
};
EOF

# --- 06b MEMORIES RIGHT (7 фото) ---
cat > templates/06b-memories-right.js << 'EOF'
export default {
  id: 'memories-right',
  name: 'Memories (правая)',
  category: 'Коллажи',
  fields: [
    {key:'word',label:'Слово (RIES)',type:'text'},
    {key:'photos',label:'Загрузить 7 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7']}
  ],
  defaults: {
    word:'RIES',
    photo1:null,photo2:null,photo3:null,photo4:null,
    photo5:null,photo6:null,photo7:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mem-page mem-page--right">
      <div class="mem-title mem-title--right">
        <span class="mem-memories mem-memories--right">${c.word||''}</span>
      </div>
      <div class="mem-grid mem-grid--right">
        <div class="mem-cell mem-r1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mem-cell mem-r2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mem-cell mem-r3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mem-cell mem-r4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mem-cell mem-r5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mem-cell mem-r6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mem-cell mem-r7 ${e('photo7')}" style="${p('photo7')}"></div>
      </div>
    </div>`;
  }
};
EOF

# --- 07 BESTIES (5 фото) ---
cat > templates/07-besties.js << 'EOF'
export default {
  id: 'besties',
  name: 'Besties',
  category: 'Коллажи',
  fields: [
    { key:'word',  label:'Заголовок', type:'text' },
    { key:'quote', label:'Цитата снизу', type:'textarea' },
    { key:'photos',label:'Загрузить 5 фото', type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5'] }
  ],
  defaults: {
    word: 'BESTIES',
    quote: '“A FRIENDS KNOWS THE SONG IN MY HEART AND SINGS IT IN ME WHEN MY MEMORY FAILS”',
    photo1:null, photo2:null, photo3:null, photo4:null, photo5:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    const w = c.word || 'BESTIES';
    return `<div class="page best-page">
      <div class="best-title best-title--solid">${w}</div>
      <div class="best-title best-title--outline o1">${w}</div>
      <div class="best-title best-title--outline o2">${w}</div>
      <div class="best-grid">
        <div class="bg-item bg-a ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="bg-item bg-b ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="bg-item bg-c ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="bg-item bg-d ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="bg-item bg-e ${e('photo5')}" style="${p('photo5')}"></div>
      </div>
      <div class="best-quote">${c.quote || ''}</div>
    </div>`;
  }
};
EOF

# --- 08 PHOTO GRID (8 фото) ---
cat > templates/08-photo-grid.js << 'EOF'
export default {
  id: 'photo-grid',
  name: 'Фото-сетка',
  category: 'Коллажи',
  fields: [
    {key:'photos',label:'Загрузить 8 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8']}
  ],
  defaults: {photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page pg-page">
      <div class="pg-grid">
        <div class="pgi ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="pgi ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="pgi ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="pgi ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="pgi ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="pgi ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="pgi ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="pgi ${e('photo8')}" style="${p('photo8')}"></div>
      </div>
    </div>`;
  }
};
EOF

# --- 13 HER VIBE (8 фото) ---
cat > templates/13-her-vibe.js << 'EOF'
export default {
  id: 'her-vibe',
  name: 'Her Vibe',
  category: 'Коллажи',
  fields: [
    {key:'title',label:'Заголовок (скрипт)',type:'text'},
    {key:'photos',label:'Загрузить 8 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8']}
  ],
  defaults: {title:'Her vibe',photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page hv-page">
      <div class="hv-title">${c.title||''}</div>
      <div class="hv-grid">
        <div class="hvi h1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="hvi h2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="hvi h3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="hvi h4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="hvi h5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="hvi h6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="hvi h7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="hvi h8 ${e('photo8')}" style="${p('photo8')}"></div>
      </div>
    </div>`;
  }
};
EOF

# --- 18 COLLAGE ROUNDED (10 фото) ---
cat > templates/18-collage-rounded.js << 'EOF'
export default {
  id: 'collage-rounded',
  name: 'Коллаж (скруглённый)',
  category: 'Коллажи',
  fields: [
    {key:'photos',label:'Загрузить 10 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10']}
  ],
  defaults: {photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null,photo9:null,photo10:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page cr-page">
      <div class="cr-grid">
        ${[1,2,3,4,5,6,7,8,9,10].map(i => `<div class="cri c${i} ${e('photo'+i)}" style="${p('photo'+i)}"></div>`).join('')}
      </div>
    </div>`;
  }
};
EOF

# --- 19 PINTEREST BOARD (11 фото) ---
cat > templates/19-pinterest-board.js << 'EOF'
export default {
  id: 'pinterest-board',
  name: 'Pinterest доска',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок строка 1',type:'text'},
    {key:'title2',label:'Заголовок строка 2',type:'text'},
    {key:'photos',label:'Загрузить 11 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10','photo11']}
  ],
  defaults: {
    title1:'Она, если была бы доской',title2:'на Pinterest',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,
    photo7:null,photo8:null,photo9:null,photo10:null,photo11:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page pinterest-page">
      <div class="pin-title">
        <div class="pin-title-bold">${c.title1||''}</div>
        <div class="pin-title-line">${c.title2||''}</div>
      </div>
      <div class="pin-grid">
        ${[1,2,3,4,5,6,7,8,9,10,11].map(i => `<div class="pin-item pin-${i} ${e('photo'+i)}" style="${p('photo'+i)}"></div>`).join('')}
      </div>
    </div>`;
  }
};
EOF

# --- 20 FRIENDSHIP YEARS (6 фото) ---
cat > templates/20-friendship-years.js << 'EOF'
export default {
  id: 'friendship-years',
  name: 'Дружба сквозь года',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок 1',type:'text'},
    {key:'title2',label:'Заголовок 2',type:'text'},
    {key:'year1',label:'Год 1',type:'text'},{key:'year2',label:'Год 2',type:'text'},
    {key:'year3',label:'Год 3',type:'text'},{key:'year4',label:'Год 4',type:'text'},
    {key:'year5',label:'Год 5',type:'text'},{key:'year6',label:'Год 6',type:'text'},
    {key:'year7',label:'Год 7',type:'text'},
    {key:'photos',label:'Загрузить 6 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6']}
  ],
  defaults: {
    title1:'Наша дружба',title2:'сквозь года',
    year1:'2020',year2:'2021',year3:'2022',year4:'2023',year5:'2024',year6:'2025',year7:'2026',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page friendship-page">
      <div class="fr-title">${c.title1||''}</div>
      <div class="fr-subtitle">${c.title2||''}</div>
      <div class="fr-item fr-i1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="fr-year fr-y1">${c.year1||''}</div>
      <div class="fr-item fr-i2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="fr-year fr-y2">${c.year2||''}</div>
      <div class="fr-item fr-i3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="fr-year fr-y3">${c.year3||''}</div>
      <div class="fr-item fr-i4 ${e('photo4')}" style="${p('photo4')}"></div>
      <div class="fr-year fr-y4">${c.year4||''}</div>
      <div class="fr-item fr-i5 ${e('photo5')}" style="${p('photo5')}"></div>
      <div class="fr-year fr-y5">${c.year5||''}</div>
      <div class="fr-item fr-i6 ${e('photo6')}" style="${p('photo6')}"></div>
      <div class="fr-year fr-y6">${c.year6||''}</div>
      <div class="fr-year fr-y7">${c.year7||''}</div>
    </div>`;
  }
};
EOF

# --- 23 LOVE LETTERS (3 фото) ---
cat > templates/23-love-letters.js << 'EOF'
export default {
  id: 'love-letters',
  name: 'LOVE (буквы)',
  category: 'Коллажи',
  fields: [
    {key:'photos',label:'Загрузить 3 фото',type:'photos',
      slots:['photo1','photo2','photo3']}
  ],
  defaults: {photo1:null,photo2:null,photo3:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page love-letters-page">
      <div class="ll-photo ll-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="ll-photo ll-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="ll-photo ll-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="ll-word"><span>L</span><span>O</span><span>V</span><span>E</span></div>
    </div>`;
  }
};
EOF

# --- 24 MAMA (10 фото) ---
cat > templates/24-mama.js << 'EOF'
export default {
  id: 'mama-heart',
  name: 'Мама (сердечко)',
  category: 'Коллажи',
  fields: [
    {key:'script1',label:'Надпись слева',type:'text'},
    {key:'script2',label:'Надпись справа',type:'text'},
    {key:'title',label:'Заголовок',type:'text'},
    {key:'photos',label:'Загрузить 10 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10']},
    {key:'text',label:'Поздравление',type:'textarea'},
    {key:'sign',label:'Подпись',type:'text'}
  ],
  defaults: {
    script1:'лучшая',script2:'на свете',title:'Мама',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,
    photo6:null,photo7:null,photo8:null,photo9:null,photo10:null,
    text:'Пусть жизнь дарит тебе столько же тепла\nсколько ты подарила мне\nТы - мое самое большое счастье!',
    sign:'С любовью, твоя доченька'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mama-page">
      <div class="mama-script1">${c.script1||''}</div>
      <div class="mama-script2">${c.script2||''}</div>
      <div class="mama-title">${c.title||''}</div>
      <div class="mama-heart">
        ${[1,2,3,4,5,6,7,8,9,10].map(i => `<div class="mh mh-${i} ${e('photo'+i)}" style="${p('photo'+i)}"></div>`).join('')}
      </div>
      <div class="mama-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
      <div class="mama-sign">${c.sign||''}</div>
    </div>`;
  }
};
EOF

echo "✅ 10 шаблонов переведены на мультизагрузку"

# ═══════════════════ CSS ДЛЯ PREVIEW ═══════════════════
cat >> styles.css << 'EOF'

/* ═══════════════════ МУЛЬТИЗАГРУЗКА ФОТО ═══════════════════ */
.field-count{
  color: #a49c90;
  font-size: 10px;
  letter-spacing: .1em;
  margin-left: 6px;
  font-weight: 400;
}

.file-btn--multi{
  border-style: solid;
  border-color: #c97a7a;
  color: #c97a7a;
  background: #fdf5f5;
}
.file-btn--multi:hover{
  background: #c97a7a;
  color: #fff;
}

.photos-preview{
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 6px;
  margin-top: 10px;
}
.pp-item{
  position: relative;
  aspect-ratio: 1;
  background-size: cover;
  background-position: center;
  background-color: #f8f5f0;
  border-radius: 8px;
  border: 1px solid #e2ddd3;
  overflow: hidden;
}
.pp-item.empty{
  display: flex;
  align-items: center;
  justify-content: center;
  border-style: dashed;
}
.pp-num{
  position: absolute;
  bottom: 3px;
  left: 4px;
  font-family: 'Inter', sans-serif;
  font-size: 9px;
  color: #8a8378;
  background: rgba(255,255,255,.85);
  padding: 1px 5px;
  border-radius: 3px;
  letter-spacing: .05em;
}
.pp-item.empty .pp-num{
  position: static;
  background: none;
  color: #c0b8aa;
  font-size: 13px;
  font-weight: 500;
}
.pp-del{
  position: absolute;
  top: 3px;
  right: 3px;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: rgba(0,0,0,.6);
  color: #fff;
  font-size: 11px;
  line-height: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  opacity: 0;
  transition: opacity .15s;
  padding: 0;
}
.pp-item:hover .pp-del{ opacity: 1; }
.pp-item.empty .pp-del{ display: none; }
EOF

echo "✅ CSS для превью добавлен"

# ═══════════════════ PUSH ═══════════════════
echo ""
echo "→ git add / commit / push..."
git add .
git commit -m "Multi-photo upload for collages — 5-11 photos at once" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Обнови сайт: Ctrl+Shift+R"
