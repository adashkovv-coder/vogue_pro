import { TEMPLATES, getTemplate, getCategories } from './templates/registry.js';

const PAGE_OPTIONS = [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24];
const state = { totalPages: 0, activePage: 0, filter: 'Все', pages: [] };

const $ = (s) => document.querySelector(s);
const esc = (s) => String(s ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));

function init() { renderPageOptions(); bindEvents(); }

function renderPageOptions() {
  $('#page-options').innerHTML = PAGE_OPTIONS.map(n => `<button class="page-opt" data-n="${n}">${n}</button>`).join('');
}

function bindEvents() {
  $('#page-options').addEventListener('click', e => {
    const btn = e.target.closest('.page-opt');
    if (!btn) return;
    document.querySelectorAll('.page-opt').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    state.totalPages = +btn.dataset.n;
    $('#btn-start').disabled = false;
  });

  $('#btn-start').addEventListener('click', startJournal);
  $('#btn-back').addEventListener('click', () => { if (confirm('Вернуться? Прогресс потеряется.')) location.reload(); });
  $('#btn-pdf').addEventListener('click', () => window.print());

  $('#category-filter').addEventListener('click', e => {
    const btn = e.target.closest('.cat-btn');
    if (!btn) return;
    state.filter = btn.dataset.cat;
    renderCategories();
    renderGallery();
  });

  $('#gallery-grid').addEventListener('click', e => {
    const item = e.target.closest('.gallery-item');
    if (!item) return;
    pickTemplate(item.dataset.tpl);
  });

  $('#modal-close').addEventListener('click', closeGallery);
  $('#gallery-modal').addEventListener('click', e => { if (e.target.id === 'gallery-modal') closeGallery(); });

  $('#form-fields').addEventListener('input', e => {
    const el = e.target;
    if (!el.dataset.key) return;
    const page = state.pages[state.activePage];
    if (!page) return;
    page.content[el.dataset.key] = el.value;
    renderStage();
  });

  $('#form-fields').addEventListener('change', e => {
    const el = e.target;
    if (el.type !== 'file' || !el.dataset.key) return;
    const file = el.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = ev => {
      const page = state.pages[state.activePage];
      page.content[el.dataset.key] = ev.target.result;
      renderForm();
      renderStage();
      renderPageList();
    };
    reader.readAsDataURL(file);
  });
}

function startJournal() {
  state.pages = Array.from({ length: state.totalPages }, () => ({ templateId: null, content: {} }));
  state.activePage = 0;
  show('screen-editor');
  renderPageList(); renderStage(); renderForm(); updateCounter();
}

function show(id) {
  document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
  $('#' + id).classList.add('active');
}

function renderPageList() {
  $('#page-list').innerHTML = state.pages.map((p, i) => {
    const tpl = p.templateId ? getTemplate(p.templateId) : null;
    const cls = ['page-thumb', i === state.activePage ? 'active' : '', p.templateId ? 'filled' : ''].filter(Boolean).join(' ');
    return `<div class="${cls}" data-i="${i}">
      <span class="page-thumb__num">${i + 1}</span>
      ${tpl ? esc(tpl.name) : '—'}
    </div>`;
  }).join('');
  $('#page-list').querySelectorAll('.page-thumb').forEach(el => { el.onclick = () => selectPage(+el.dataset.i); });
}

function selectPage(i) { state.activePage = i; renderPageList(); renderStage(); renderForm(); updateCounter(); }

function updateCounter() {
  const filled = state.pages.filter(p => p.templateId).length;
  $('#page-counter').textContent = `${filled} / ${state.totalPages}`;
}

function renderStage() {
  const page = state.pages[state.activePage];
  if (!page) { $('#stage-page').innerHTML = ''; return; }
  if (!page.templateId) {
    $('#stage-page').innerHTML = `<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#999;font-size:14px;flex-direction:column;gap:16px;">
      <div style="font-size:40px;">+</div>
      <div>Выберите шаблон</div>
      <button class="btn-primary" onclick="openGallery()">Выбрать шаблон</button>
    </div>`;
    return;
  }
  const tpl = getTemplate(page.templateId);
  if (!tpl) return;
  try { $('#stage-page').innerHTML = tpl.render(page.content); }
  catch (e) { $('#stage-page').innerHTML = `<div style="padding:20px;color:red;font-family:monospace;">Ошибка шаблона: ${esc(e.message)}</div>`; }
}

function renderForm() {
  const page = state.pages[state.activePage];
  if (!page || !page.templateId) { $('#form-fields').innerHTML = '<div class="empty-msg">Выберите шаблон,<br>чтобы заполнить поля</div>'; return; }
  const tpl = getTemplate(page.templateId);
  const c = page.content;
  $('#form-fields').innerHTML = `
    <div style="margin-bottom:20px;">
      <div style="font-size:11px;text-transform:uppercase;letter-spacing:1.5px;color:#999;">Шаблон</div>
      <div style="font-size:16px;font-weight:500;margin-top:4px;">${esc(tpl.name)}</div>
    </div>
    ${tpl.fields.map(f => renderField(f, c[f.key])).join('')}
    <button class="btn-ghost" style="width:100%;margin-top:16px;" id="btn-change">Заменить шаблон</button>
  `;
  $('#btn-change').onclick = () => openGallery();
}

function renderField(f, value) {
  const v = value ?? '';
  if (f.type === 'photo' || f.type === 'image') {
    const thumb = v ? `<img src="${esc(v)}" class="thumb">` : '';
    return `<div class="field-group"><label>${esc(f.label)}</label>
      <input type="file" accept="image/*" data-key="${esc(f.key)}">${thumb}</div>`;
  }
  if (f.type === 'textarea') {
    return `<div class="field-group"><label>${esc(f.label)}</label>
      <textarea rows="4" data-key="${esc(f.key)}">${esc(v)}</textarea></div>`;
  }
  return `<div class="field-group"><label>${esc(f.label)}</label>
    <input type="text" data-key="${esc(f.key)}" value="${esc(v)}"></div>`;
}

function openGallery() { state.filter = 'Все'; renderCategories(); renderGallery(); $('#gallery-modal').classList.remove('hidden'); }
window.openGallery = openGallery;
function closeGallery() { $('#gallery-modal').classList.add('hidden'); }

function renderCategories() {
  $('#category-filter').innerHTML = getCategories().map(c =>
    `<button class="cat-btn ${c === state.filter ? 'active' : ''}" data-cat="${esc(c)}">${esc(c)}</button>`
  ).join('');
}

function renderGallery() {
  const list = state.filter === 'Все' ? TEMPLATES : TEMPLATES.filter(t => t.category === state.filter);
  $('#gallery-grid').innerHTML = list.map(t => `<div class="gallery-item" data-tpl="${esc(t.id)}">
    <div class="gallery-item__preview"><div class="gallery-item__placeholder">${esc(t.name)}</div></div>
    <div class="gallery-item__name">${esc(t.name)}</div>
    <div class="gallery-item__cat">${esc(t.category)}</div>
  </div>`).join('');
}

function pickTemplate(templateId) {
  const page = state.pages[state.activePage];
  if (!page) return;
  page.templateId = templateId;
  page.content = {};
  closeGallery();
  renderPageList(); renderStage(); renderForm(); updateCounter();
}

init();
