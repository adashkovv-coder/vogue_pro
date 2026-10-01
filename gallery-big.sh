#!/bin/bash
echo "▬▬▬ Делаю галерею крупной и удобной ▬▬▬"

# ═══ УДАЛЯЕМ СТАРЫЙ CSS ГАЛЕРЕИ ═══
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

# Удаляем блоки: modal, gallery-grid, gallery-item, category-filter
patterns = [
    r'/\* =+ ГАЛЕРЕЯ =+ \*/.*?(?=/\* =+ БАЗОВАЯ A4)',
    r'/\* =+ МОДАЛЬНОЕ ОКНО ГАЛЕРЕИ =+ \*/.*?(?=/\* =+ БАЗОВАЯ A4)',
]
for p in patterns:
    css = re.sub(p, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS галереи удалён")
PY_EOF

# ═══ ДОБАВЛЯЕМ НОВЫЙ CSS ═══
cat >> styles.css << 'EOF'

/* ═══════════════════════════════════════════════════════════════
   ГАЛЕРЕЯ ШАБЛОНОВ — крупная, удобная
   ═══════════════════════════════════════════════════════════════ */
.modal{
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,.75);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
  padding: 20px;
  backdrop-filter: blur(6px);
}
.modal.hidden{ display: none; }

.modal__inner{
  background: #fff;
  border-radius: 20px;
  width: 100%;
  max-width: 1400px;
  height: 92vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 24px 80px rgba(0,0,0,.4);
}

/* ═══ ШАПКА ═══ */
.modal__head{
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 28px;
  border-bottom: 1px solid #eee;
  flex-shrink: 0;
  background: #fff;
}
.modal__title{
  font-family: 'Playfair Display', serif;
  font-size: 24px;
  font-weight: 600;
  letter-spacing: -.005em;
}
.modal__title span{
  color: #a49c90;
  font-size: 14px;
  font-weight: 400;
  margin-left: 10px;
}
.modal__close{
  background: none;
  border: none;
  font-size: 26px;
  width: 42px;
  height: 42px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: .2s;
  color: #111;
}
.modal__close:hover{ background: #f4f1ec; }

/* ═══ ФИЛЬТР ═══ */
.category-filter{
  display: flex;
  gap: 8px;
  padding: 16px 28px;
  overflow-x: auto;
  border-bottom: 1px solid #f0ece5;
  background: #fbfaf8;
  flex-shrink: 0;
  scrollbar-width: none;
}
.category-filter::-webkit-scrollbar{ display: none; }

.cat-chip{
  background: #fff;
  border: 1px solid #e3ddd3;
  border-radius: 100px;
  padding: 9px 20px;
  font-size: 12px;
  letter-spacing: .12em;
  text-transform: uppercase;
  color: #6f6862;
  white-space: nowrap;
  font-weight: 500;
  cursor: pointer;
  transition: .2s;
  font-family: 'Inter', sans-serif;
}
.cat-chip:hover{ border-color: #111; color: #111; }
.cat-chip.active{ background: #111; color: #fff; border-color: #111; }

/* ═══ СЕТКА — 3 в ряд, крупные превью ═══ */
.gallery-grid{
  padding: 24px 28px 60px;
  overflow-y: auto;
  flex: 1;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  align-content: flex-start;
}

/* Красивый скроллбар */
.gallery-grid::-webkit-scrollbar{ width: 10px; }
.gallery-grid::-webkit-scrollbar-track{ background: #f4f1ec; }
.gallery-grid::-webkit-scrollbar-thumb{
  background: #cfc8bd;
  border-radius: 100px;
  border: 2px solid #f4f1ec;
}
.gallery-grid::-webkit-scrollbar-thumb:hover{ background: #b8b0a3; }

/* ═══ КАРТОЧКА ШАБЛОНА ═══ */
.gallery-item{
  cursor: pointer;
  border-radius: 14px;
  overflow: hidden;
  border: 2px solid transparent;
  background: #fff;
  transition: .25s cubic-bezier(.2,.7,.3,1);
  box-shadow: 0 4px 20px rgba(0,0,0,.06);
}
.gallery-item:hover{
  border-color: #c97a7a;
  transform: translateY(-4px);
  box-shadow: 0 16px 40px rgba(0,0,0,.15);
}
.gallery-item.active-tpl{
  border-color: #111;
  box-shadow: 0 12px 32px rgba(0,0,0,.2);
}

.gallery-item .thumb-wrap{
  width: 100%;
  aspect-ratio: 794/1123;
  background: #fff;
  overflow: hidden;
  position: relative;
  border-bottom: 1px solid #f0ece5;
}
.gallery-item .thumb-wrap .thumb-scaler{
  transform-origin: top left;
  width: 794px;
  height: 1123px;
  pointer-events: none;
}

.gallery-item .g-meta{
  padding: 14px 18px;
  background: #fbfaf8;
}
.gallery-item .g-name{
  font-family: 'Playfair Display', serif;
  font-size: 15px;
  font-weight: 600;
  color: #111;
  line-height: 1.25;
}
.gallery-item .g-cat{
  font-size: 10px;
  letter-spacing: .2em;
  text-transform: uppercase;
  color: #a49c90;
  margin-top: 4px;
  font-family: 'Inter', sans-serif;
}

/* ═══════════════════════════════════════════════════════════════
   МОБИЛЬНАЯ ВЕРСИЯ — 2 в ряд, крупные превью
   ═══════════════════════════════════════════════════════════════ */
@media (max-width: 900px){
  .gallery-grid{
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
    padding: 16px 14px 40px;
  }
  .modal__inner{
    height: 96vh;
    border-radius: 14px;
  }
  .modal__head{ padding: 16px 18px; }
  .modal__title{ font-size: 18px; }
  .modal__title span{ font-size: 12px; margin-left: 6px; }
  .modal__close{ width: 36px; height: 36px; font-size: 20px; }

  .category-filter{
    padding: 12px 14px;
    gap: 6px;
  }
  .cat-chip{
    padding: 8px 14px;
    font-size: 10px;
    letter-spacing: .1em;
  }

  .gallery-item .g-meta{ padding: 10px 12px; }
  .gallery-item .g-name{ font-size: 13px; }
  .gallery-item .g-cat{ font-size: 9px; }
}

@media (max-width: 500px){
  .modal{ padding: 0; }
  .modal__inner{
    height: 100vh;
    max-height: 100vh;
    border-radius: 0;
  }
  .gallery-grid{
    grid-template-columns: repeat(2, 1fr);
    gap: 10px;
    padding: 12px 10px 30px;
  }
}
EOF

echo "✅ Новый CSS галереи добавлен"

# ═══ PATCH APP.JS — подгонка размера превью под новую сетку ═══
python3 - << 'PY_EOF'
import re
with open('app.js', 'r', encoding='utf-8') as f:
    js = f.read()

# Заменяем функцию renderGallery на новую — с учётом крупных превью
old = """function renderGallery(){
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
}"""

new = """function renderGallery(){
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

  // Подгоняем масштаб каждого превью под ширину его контейнера
  requestAnimationFrame(() => {
    requestAnimationFrame(() => {
      $$('.gallery-item .thumb-wrap').forEach(el => {
        const w = el.clientWidth;
        if (!w) return;
        const s = w / 794;
        const sc = el.querySelector('.thumb-scaler');
        if (sc) sc.style.transform = `scale(${s})`;
      });
    });
  });
}

/* Пересчёт превью при изменении размера окна */
let resizeTimer;
window.addEventListener('resize', () => {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(() => {
    if (!$('#gallery-modal').classList.contains('hidden')){
      $$('.gallery-item .thumb-wrap').forEach(el => {
        const w = el.clientWidth;
        if (!w) return;
        const s = w / 794;
        const sc = el.querySelector('.thumb-scaler');
        if (sc) sc.style.transform = `scale(${s})`;
      });
    }
  }, 180);
});"""

js = js.replace(old, new)

with open('app.js', 'w', encoding='utf-8') as f:
    f.write(js)
print("✅ app.js обновлён — крупные превью")
PY_EOF

# ═══ PUSH ═══
git add .
git commit -m "Bigger template gallery: 3 cols desktop, 2 cols mobile" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
