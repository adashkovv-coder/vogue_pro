#!/bin/bash
echo "▬▬▬ Исправляю баги + добавляю 2 шаблона + мобильная версия ▬▬▬"

# ============ ФИКС APP.JS — убираем перерисовку формы при вводе ============
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

/* ============================================================
   СОСТОЯНИЕ
   ============================================================ */
const state = {
  pageCount: 12,
  pages: [],
  activeIndex: 0,
  filter: 'Все'
};

function blankPage(templateId){
  const tpl = getTemplate(templateId);
  return {
    templateId,
    content: tpl ? {...tpl.defaults} : {}
  };
}

/* ============================================================
   РЕНДЕР ОДНОЙ СТРАНИЦЫ
   ============================================================ */
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

/* ============================================================
   ИНИЦИАЛИЗАЦИЯ ЖУРНАЛА
   ============================================================ */
function initPages(){
  const n = state.pageCount;
  const covers = TEMPLATES.filter(t => t.category === 'Обложки');
  const backs  = TEMPLATES.filter(t => t.category === 'Задние обложки');
  const others = TEMPLATES.filter(t =>
    t.category !== 'Обложки' && t.category !== 'Задние обложки'
  );

  const coverTpl = covers[0] || TEMPLATES[0] || null;
  const backTpl  = backs[0]  || TEMPLATES[TEMPLATES.length-1] || null;

  const pages = [];

  if (coverTpl) pages.push(blankPage(coverTpl.id));
  else          pages.push({ templateId:null, content:{} });

  for (let i = 0; i < n - 2; i++){
    if (others.length){
      pages.push(blankPage(others[i % others.length].id));
    } else if (TEMPLATES.length){
      pages.push(blankPage(TEMPLATES[i % TEMPLATES.length].id));
    } else {
      pages.push({ templateId:null, content:{} });
    }
  }

  if (backTpl) pages.push(blankPage(backTpl.id));
  else         pages.push({ templateId:null, content:{} });

  state.pages = pages;
  state.activeIndex = 0;
}

/* ============================================================
   РЕНДЕР РЕДАКТОРА
   ============================================================ */
function renderPageList(){
  $('#page-list').innerHTML = state.pages.map((p, i) => {
    const tpl = getTemplate(p.templateId);
    return `<li class="page-item ${i===state.activeIndex?'active':''}" data-index="${i}">
      <span class="page-num">${i+1}</span>
      <div class="page-thumb-mini">
        <div class="thumb-scaler">${renderPage(p, i+1)}</div>
      </div>
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

// ⚡ Обновляет только превью (без пересоздания формы)
function refreshStage(){
  const p = state.pages[state.activeIndex];
  const wrap = $('#stage-preview');
  const sc = wrap.querySelector('.thumb-scaler');
  if (!sc) return;
  sc.innerHTML = renderPage(p, state.activeIndex+1);
}

// ⚡ Обновляет только миниатюру активной страницы в списке
function refreshActiveThumb(){
  const li = $(`.page-item[data-index="${state.activeIndex}"] .thumb-scaler`);
  if (!li) return;
  li.innerHTML = renderPage(state.pages[state.activeIndex], state.activeIndex+1);
}

function renderStage(){
  const p = state.pages[state.activeIndex];
  const tpl = getTemplate(p.templateId);

  $('#stage-title').textContent =
    `Страница ${state.activeIndex+1} из ${state.pages.length}`;

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

    if (f.type === 'image'){
      const has = !!val;
      return `<div class="field"><label>${esc(f.label)}</label>
        <div class="file-row">
          <label class="file-btn">
            <input type="file" accept="image/*" data-photo="${f.key}" hidden>
            <span>${has ? 'Заменить' : 'Загрузить фото'}</span>
          </label>
          ${has ? `<button class="mini-btn" data-photo-clear="${f.key}">Удалить</button>` : ''}
        </div></div>`;
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

/* ============================================================
   ГАЛЕРЕЯ ШАБЛОНОВ
   ============================================================ */
function openGallery(){
  if (!TEMPLATES.length){
    alert('Пока нет ни одного шаблона. Добавьте их в templates/registry.js');
    return;
  }
  state.filter = 'Все';
  renderCategories();
  renderGallery();
  $('#modal-page-label').textContent = `· страница ${state.activeIndex+1}`;
  $('#gallery-modal').classList.remove('hidden');
}
function closeGallery(){
  $('#gallery-modal').classList.add('hidden');
}

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

/* ============================================================
   СОБЫТИЯ
   ============================================================ */
$('#page-list').addEventListener('click', e => {
  const item = e.target.closest('.page-item');
  if (!item) return;
  state.activeIndex = parseInt(item.dataset.index, 10);
  renderEditor();
});

/* ⚡ ГЛАВНЫЙ ФИКС: обновляем только превью, НЕ трогаем форму */
$('#form-fields').addEventListener('input', e => {
  const t = e.target;
  const p = state.pages[state.activeIndex];
  if (t.dataset.text){
    p.content[t.dataset.text] = t.value;
    refreshStage();         // обновляем только большое превью
    refreshActiveThumb();   // и миниатюру в списке
  }
});

$('#form-fields').addEventListener('change', e => {
  const t = e.target;
  const p = state.pages[state.activeIndex];

  if (t.dataset.photo){
    const f = t.files && t.files[0];
    if (!f) return;
    const r = new FileReader();
    r.onload = () => {
      p.content[t.dataset.photo] = r.result;
      renderEditor();       // фото — можно перерисовать
    };
    r.readAsDataURL(f);
  }

  if (t.dataset.text){
    p.content[t.dataset.text] = t.value;
    refreshStage();
    refreshActiveThumb();
  }
});

$('#form-fields').addEventListener('click', e => {
  const c = e.target.closest('[data-photo-clear]');
  if (c){
    state.pages[state.activeIndex].content[c.dataset.photoClear] = null;
    renderEditor();
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

/* ============================================================
   ВЫБОР КОЛИЧЕСТВА СТРАНИЦ
   ============================================================ */
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

/* ============================================================
   НАВИГАЦИЯ
   ============================================================ */
$('#btn-start').addEventListener('click', () => {
  renderPageOptions();
  show('screen-pages');
});
$('#btn-back-1').addEventListener('click', () => show('screen-start'));
$('#btn-editor-back').addEventListener('click', () => {
  renderPageOptions();
  show('screen-pages');
});
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

/* ============================================================
   PDF
   ============================================================ */
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

  const pdf = new window.jspdf.jsPDF({
    unit:'mm', format:'a4', orientation:'portrait', compress:true
  });

  try {
    for (let i=0;i<nodes.length;i++){
      btn.textContent = `Стр. ${i+1}/${nodes.length}`;
      await new Promise(r => setTimeout(r, 0));

      const canvas = await html2canvas(nodes[i], {
        scale: 2,
        backgroundColor: '#ffffff',
        logging: false,
        useCORS: true,
        width: 794, height: 1123,
        windowWidth: 794, windowHeight: 1123
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
    setTimeout(() => {
      btn.disabled = false;
      btn.textContent = 'Скачать PDF';
    }, 1500);
  }
}
EOF

echo "✅ app.js исправлен — форма больше не теряет фокус"

# ============ ДОБАВЛЯЕМ 2 НОВЫХ ШАБЛОНА ============

# --- ШАБЛОН 19 — PINTEREST BOARD ---
cat > templates/19-pinterest-board.js << 'EOF'
export default {
  id: 'pinterest-board',
  name: 'Pinterest доска',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок строка 1 (жирный)',type:'text'},
    {key:'title2',label:'Заголовок строка 2',type:'text'},
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},{key:'photo10',label:'Фото 10',type:'image'},
    {key:'photo11',label:'Фото 11',type:'image'}
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
        <div class="pin-item pin-1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="pin-item pin-2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="pin-item pin-3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="pin-item pin-4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="pin-item pin-5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="pin-item pin-6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="pin-item pin-7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="pin-item pin-8 ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="pin-item pin-9 ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="pin-item pin-10 ${e('photo10')}" style="${p('photo10')}"></div>
        <div class="pin-item pin-11 ${e('photo11')}" style="${p('photo11')}"></div>
      </div>
    </div>`;
  }
};
EOF

# --- ШАБЛОН 20 — НАША ДРУЖБА СКВОЗЬ ГОДА ---
cat > templates/20-friendship-years.js << 'EOF'
export default {
  id: 'friendship-years',
  name: 'Дружба сквозь года',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок строка 1',type:'text'},
    {key:'title2',label:'Заголовок строка 2',type:'text'},
    {key:'year1',label:'Год 1',type:'text'},{key:'year2',label:'Год 2',type:'text'},
    {key:'year3',label:'Год 3',type:'text'},{key:'year4',label:'Год 4',type:'text'},
    {key:'year5',label:'Год 5',type:'text'},{key:'year6',label:'Год 6',type:'text'},
    {key:'year7',label:'Год 7',type:'text'},
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'}
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

echo "✅ Созданы 19-pinterest-board.js и 20-friendship-years.js"

# ============ ОБНОВЛЯЕМ REGISTRY ============
cat > templates/registry.js << 'EOF'
import t01 from './01-birthday-vogue.js';
import t02 from './02-whos-that-girl.js';
import t03 from './04-to-friend.js';
import t04 from './05-love-quote.js';
import t05 from './06-our-memories-left.js';
import t06 from './06b-memories-right.js';
import t07 from './07-besties.js';
import t08 from './08-photo-grid.js';
import t09 from './09-favourite.js';
import t10 from './10-her-songs.js';
import t11 from './11-annas-playlist.js';
import t12 from './12-birthday-cover.js';
import t13 from './13-her-vibe.js';
import t14 from './14-tvoya-lyubov.js';
import t15 from './15-zodiac-map.js';
import t16 from './16-detstvo.js';
import t17 from './17-malenkaya.js';
import t18 from './18-collage-rounded.js';
import t19 from './19-pinterest-board.js';
import t20 from './20-friendship-years.js';

export const TEMPLATES = [
  t01, t02, t03, t04, t05, t06, t07, t08,
  t09, t10, t11, t12, t13, t14, t15, t16,
  t17, t18, t19, t20
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
EOF

echo "✅ registry.js обновлён (20 шаблонов)"

# ============ ДОБАВЛЯЕМ CSS ============
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 19 — PINTEREST BOARD ═══════════════════ */
.pinterest-page{
  background: #fff;
  padding: 40px 36px;
  font-family: 'Times New Roman', Georgia, serif;
  color: #000;
}
.pin-title{
  text-align: center;
  margin-bottom: 30px;
}
.pin-title-bold{
  font-size: 62px;
  font-weight: 700;
  line-height: 1.05;
  margin-bottom: 4px;
}
.pin-title-line{
  font-size: 62px;
  font-weight: 400;
  line-height: 1.05;
}
.pin-grid{
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: 175px;
  gap: 14px;
}
.pin-item{
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
  border-radius: 24px;
}
.pin-item.empty{ background: #f0ede8; }
.pin-1{ grid-column: 1; grid-row: 1; }
.pin-2{ grid-column: 2; grid-row: 1 / 3; }
.pin-3{ grid-column: 3 / 5; grid-row: 1; }
.pin-4{ grid-column: 1; grid-row: 2 / 4; }
.pin-5{ grid-column: 3; grid-row: 2 / 4; }
.pin-6{ grid-column: 4; grid-row: 2 / 4; }
.pin-7{ grid-column: 1; grid-row: 4 / 6; }
.pin-8{ grid-column: 2; grid-row: 3 / 5; }
.pin-9{ grid-column: 3; grid-row: 4 / 5; }
.pin-10{ grid-column: 3 / 5; grid-row: 5 / 7; }
.pin-11{ grid-column: 1; grid-row: 6 / 8; }

/* ═══════════════════ ШАБЛОН 20 — ДРУЖБА СКВОЗЬ ГОДА ═══════════════════ */
.friendship-page{
  background: #000;
  color: #fff;
  position: relative;
  overflow: hidden;
  font-family: 'Times New Roman', Georgia, serif;
}
.fr-title{
  position: absolute;
  top: 20px; left: 50px;
  font-size: 110px;
  font-style: italic;
  line-height: 1;
  z-index: 5;
}
.fr-subtitle{
  position: absolute;
  top: 150px; right: 80px;
  font-size: 82px;
  font-style: italic;
  font-weight: 700;
  z-index: 5;
}
.fr-item{
  position: absolute;
  background-size: cover;
  background-position: center;
  background-color: #222;
}
.fr-item.empty{ background: #222; }
.fr-i1{ left: 45px; top: 340px; width: 200px; height: 260px; }
.fr-i2{ left: 45px; top: 660px; width: 200px; height: 260px; }
.fr-i3{ left: 320px; top: 500px; width: 240px; height: 300px; }
.fr-i4{ right: 45px; top: 340px; width: 200px; height: 260px; }
.fr-i5{ right: 45px; top: 660px; width: 200px; height: 260px; }
.fr-i6{ left: 50%; transform: translateX(-50%); bottom: 60px; width: 240px; height: 180px; }
.fr-year{
  position: absolute;
  font-family: 'Great Vibes', cursive;
  font-size: 58px;
  color: #fff;
  z-index: 5;
}
.fr-y1{ left: 60px; top: 620px; }
.fr-y2{ left: 60px; top: 940px; }
.fr-y3{ left: 360px; top: 820px; }
.fr-y4{ right: 60px; top: 620px; }
.fr-y5{ right: 60px; top: 940px; }
.fr-y6{ left: 50%; transform: translateX(-50%); bottom: 30px; }
.fr-y7{ left: 50%; transform: translateX(-50%); bottom: 200px; color: #fff; font-size: 66px; }
EOF

echo "✅ CSS добавлен"

# ============ МОБИЛЬНАЯ ВЕРСИЯ — улучшения ============
cat >> styles.css << 'EOF'

/* ═══════════════════ МОБИЛЬНАЯ ВЕРСИЯ ═══════════════════ */
@media (max-width: 768px){
  .editor{
    grid-template-columns: 1fr;
    padding: 10px;
    gap: 14px;
  }
  .sidebar{
    position: static;
    max-height: none;
    padding: 10px;
  }
  .page-list{
    flex-direction: row;
    overflow-x: auto;
    gap: 8px;
    padding-bottom: 6px;
  }
  .page-item{
    flex-direction: column;
    padding: 6px;
    min-width: 80px;
    flex-shrink: 0;
  }
  .page-num{ font-size: 12px; }
  .page-thumb-mini{ width: 70px; height: 100px; }
  .page-name{ font-size: 9px; max-width: 70px; }

  .stage{ padding: 14px; }
  .stage-preview{ max-width: 100%; }
  .stage-actions{ flex-direction: column; width: 100%; }
  .stage-actions .btn{ width: 100%; }

  .form-panel{
    position: static;
    max-height: none;
    padding: 14px;
  }
  .form-fields{ overflow: visible; }

  .topbar{
    flex-wrap: wrap;
    padding: 10px 16px;
    gap: 10px;
  }
  .topbar-brand{ font-size: 16px; }
  .topbar-info{ font-size: 10px; }
  .topbar-actions{ margin-left: 0; width: 100%; justify-content: space-between; }
  .topbar .btn{ padding: 9px 16px; font-size: 10px; }

  .modal__inner{ max-height: 95vh; }
  .modal__head{ padding: 14px 18px; }
  .modal__title{ font-size: 18px; }
  .gallery-grid{
    grid-template-columns: repeat(2, 1fr);
    padding: 14px;
    gap: 12px;
  }
  .category-filter{ padding: 10px 14px; gap: 6px; }
  .cat-chip{ padding: 6px 12px; font-size: 10px; }

  .center-wrap h1{ font-size: 34px; }
  .page-opt{ width: 84px; padding: 14px 6px; }
  .page-opt b{ font-size: 22px; }
}
EOF

echo "✅ Мобильные стили добавлены"

# ============ ПУШ В GIT ============
echo ""
echo "→ git add / commit / push..."
git add .
git commit -m "Fix input bug + add Pinterest & Friendship templates + mobile UX" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo ""
echo "Что сделано:"
echo "  ✅ Форма больше не закрывается при вводе"
echo "  ✅ Добавлены шаблоны: Pinterest доска, Дружба сквозь года"
echo "  ✅ Улучшена мобильная версия"
echo ""
echo "Открой сайт и нажми Ctrl+Shift+R"
