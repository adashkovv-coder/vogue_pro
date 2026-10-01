#!/bin/bash
echo "▬▬▬ Пересобираю BESTIES ▬▬▬"

# ============ НОВЫЙ ШАБЛОН 07 — BESTIES ============
cat > templates/07-besties.js << 'EOF'
/* ============================================================
   ШАБЛОН 07 — BESTIES
   Figma Frame 2714: 2481×3507 → A4 794×1123
   Шрифты: Rubik Mono One (жирный), Rubik (обводка)
   ============================================================ */
export default {
  id: 'besties',
  name: 'Besties',
  category: 'Коллажи',
  fields: [
    { key:'word',   label:'Заголовок',        type:'text' },
    { key:'quote',  label:'Цитата снизу',     type:'textarea' },
    { key:'photo1', label:'Фото 1 (верх, широкое)', type:'image' },
    { key:'photo2', label:'Фото 2 (верх, право)', type:'image' },
    { key:'photo3', label:'Фото 3 (низ, лево)',   type:'image' },
    { key:'photo4', label:'Фото 4 (низ, центр)',  type:'image' },
    { key:'photo5', label:'Фото 5 (низ, право)',  type:'image' }
  ],
  defaults: {
    word: 'BESTIES',
    quote: '“A FRIENDS KNOWS THE SONG IN MY HEART AND SINGS IT IN ME WHEN MY MEMORY FAILS”',
    photo1:null, photo2:null, photo3:null, photo4:null, photo5:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    const word = c.word || 'BESTIES';
    return `<div class="page best-page">
      <div class="best-title best-title--solid">${word}</div>
      <div class="best-title best-title--outline o1">${word}</div>
      <div class="best-title best-title--outline o2">${word}</div>

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

echo "✅ 07-besties.js обновлён"

# ============ ОБНОВЛЯЕМ INDEX.HTML — ДОБАВЛЯЕМ ШРИФТЫ ============
# Ищем строку с Google Fonts и заменяем
python3 - << 'PY_EOF'
import re
with open('index.html', 'r', encoding='utf-8') as f:
    html = f.read()

# Регулярка для поиска строки <link href="...fonts.googleapis.com...">
pattern = r'<link href="https://fonts\.googleapis\.com/css2\?[^"]+" rel="stylesheet">'

new_link = '<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,900;1,400;1,500&family=Inter:wght@300;400;500;600;700&family=Oswald:wght@400;500;600;700&family=Caveat:wght@400;500;600;700&family=Great+Vibes&family=Rubik:wght@400;500;600;700;800;900&family=Rubik+Mono+One&family=Italiana&family=Pinyon+Script&display=swap" rel="stylesheet">'

html_new, n = re.subn(pattern, new_link, html)

if n == 0:
    # не нашли по этому паттерну — попробуем найти через 'fonts.googleapis.com'
    pattern2 = r'<link[^>]*fonts\.googleapis\.com[^>]*>'
    html_new, n = re.subn(pattern2, new_link, html)

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(html_new)

print(f"✅ index.html обновлён — добавлены шрифты Rubik, Rubik Mono One, Italiana, Pinyon Script (замен: {n})")
PY_EOF

# ============ ОБНОВЛЯЕМ CSS ============
# Удаляем старый блок BESTIES
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

# Удаляем старый блок про besties
pattern = r'/\* ═+ ШАБЛОН 07 — BESTIES ═+ \*/.*?(?=/\* ═+ ШАБЛОН 08)'
css = re.sub(pattern, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS BESTIES удалён")
PY_EOF

# Добавляем новый CSS в конец
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 07 — BESTIES ═══════════════════ */
.best-page{
  background: #fff;
  padding: 30px 40px 40px;
  font-family: 'Rubik', sans-serif;
  color: #000;
  overflow: hidden;
  position: relative;
}

/* ==== ЗАГОЛОВКИ BESTIES ==== */
.best-title{
  text-align: center;
  line-height: .92;
  letter-spacing: -.02em;
  text-transform: uppercase;
  white-space: nowrap;
  overflow: hidden;
}

/* Верхний — жирный, сплошной */
.best-title--solid{
  font-family: 'Rubik Mono One', 'Rubik', sans-serif;
  font-weight: 400; /* Rubik Mono One только Regular */
  font-size: 112px;
  color: #000;
  margin-bottom: -20px;
}

/* Нижние два — контурные */
.best-title--outline{
  font-family: 'Rubik', sans-serif;
  font-weight: 900;
  font-size: 118px;
  color: transparent;
  -webkit-text-stroke: 2.5px #000;
  text-stroke: 2.5px #000;
  line-height: .9;
}
.best-title--outline.o1{
  margin-bottom: -14px;
}
.best-title--outline.o2{
  margin-bottom: 24px;
}

/* ==== СЕТКА ФОТО ==== */
.best-grid{
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: 190px 230px;
  gap: 8px;
  margin-top: 8px;
}

.bg-item{
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
}
.bg-item.empty{
  background: #f0ede8;
  position: relative;
}
.bg-item.empty::after{
  content: 'ФОТО';
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  letter-spacing: .3em;
  color: #c0b8aa;
}

/* Раскладка: верх — 2 фото (большое + маленькое), низ — 3 фото */
.bg-a{ grid-column: 1 / 5; grid-row: 1 / 2; }  /* большое верх */
.bg-b{ grid-column: 5 / 7; grid-row: 1 / 2; }  /* маленькое верх */

.bg-c{ grid-column: 1 / 3; grid-row: 2 / 3; }  /* лево */
.bg-d{ grid-column: 3 / 5; grid-row: 2 / 3; }  /* центр */
.bg-e{ grid-column: 5 / 7; grid-row: 2 / 3; }  /* право */

/* ==== ЦИТАТА ==== */
.best-quote{
  margin-top: 26px;
  font-family: 'Rubik Mono One', 'Rubik', sans-serif;
  font-size: 15px;
  line-height: 1.35;
  text-align: center;
  letter-spacing: .01em;
  text-transform: uppercase;
  padding: 0 20px;
  color: #000;
}
EOF

echo "✅ Новый CSS BESTIES добавлен"
echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Теперь: git add . && git commit -m 'Fix Besties with Rubik fonts' && git push"
