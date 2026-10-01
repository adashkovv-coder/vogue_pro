#!/bin/bash
echo "▬▬▬ Фикс Besties: плотные фото + scribble-эффект ▬▬▬"

# ═══ ОБНОВЛЯЕМ ШАБЛОН — добавляем SVG-фильтр ═══
cat > templates/07-besties.js << 'EOF'
/* ============================================================
   ШАБЛОН 07 — BESTIES
   Figma Frame 2714
   Нижние 2 строки — с эффектом "рукописного" контура (SVG filter)
   ============================================================ */
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

    // SVG-фильтр для эффекта "дрожащей руки"
    const svgFilter = `
      <svg width="0" height="0" style="position:absolute">
        <defs>
          <filter id="scribble" x="-5%" y="-5%" width="110%" height="110%">
            <feTurbulence type="turbulence" baseFrequency="0.028" numOctaves="2" seed="3" result="turb"/>
            <feDisplacementMap in="SourceGraphic" in2="turb" scale="3.2" xChannelSelector="R" yChannelSelector="G"/>
          </filter>
          <filter id="scribble2" x="-5%" y="-5%" width="110%" height="110%">
            <feTurbulence type="turbulence" baseFrequency="0.035" numOctaves="2" seed="7" result="turb"/>
            <feDisplacementMap in="SourceGraphic" in2="turb" scale="3.8" xChannelSelector="R" yChannelSelector="G"/>
          </filter>
        </defs>
      </svg>`;

    return `<div class="page best-page">
      ${svgFilter}
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

echo "✅ 07-besties.js обновлён (с SVG-фильтром)"

# ═══ УДАЛЯЕМ СТАРЫЙ CSS BESTIES ═══
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

pattern = r'/\* ═+ ШАБЛОН 07 — BESTIES ═+ \*/.*?(?=/\* ═+ ШАБЛОН 08)'
css = re.sub(pattern, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS BESTIES удалён")
PY_EOF

# ═══ ДОБАВЛЯЕМ НОВЫЙ CSS ═══
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 07 — BESTIES (v3) ═══════════════════ */
.best-page{
  background: #fff;
  padding: 18px 0 0;    /* без боковых отступов — фото в край страницы */
  font-family: 'Rubik', sans-serif;
  color: #000;
  overflow: hidden;
  position: relative;
  display: flex;
  flex-direction: column;
  height: 100%;
}

/* ═══ ЗАГОЛОВКИ BESTIES ═══ */
.best-title{
  text-align: center;
  text-transform: uppercase;
  white-space: nowrap;
  overflow: hidden;
  line-height: .82;
  letter-spacing: -.015em;
  padding: 0 40px;
}

/* Верхний — сплошной жирный */
.best-title--solid{
  font-family: 'Rubik', sans-serif;
  font-weight: 900;
  font-size: 128px;
  color: #000;
  letter-spacing: -.02em;
  margin-bottom: -10px;
}

/* Нижние — контурные + scribble-эффект */
.best-title--outline{
  font-family: 'Rubik', sans-serif;
  font-weight: 900;
  font-size: 128px;
  color: transparent;
  -webkit-text-stroke: 3px #000;
  text-stroke: 3px #000;
  letter-spacing: -.02em;
}
.best-title--outline.o1{
  margin-bottom: -12px;
  filter: url(#scribble);
}
.best-title--outline.o2{
  filter: url(#scribble2);
  margin-bottom: 14px;
}

/* ═══ СЕТКА ФОТО — без щелей, до самого низа ═══ */
.best-grid{
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: 1fr 1.15fr;
  gap: 0;                 /* ← без щелей между фото */
  flex: 1;
  min-height: 0;
  margin: 0;
}

.bg-item{
  background-size: cover;
  background-position: center;
  background-color: #e9e5de;
}
.bg-item.empty{
  background: #e9e5de;
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

/* Раскладка: верх — большое + маленькое, низ — три фото */
.bg-a{ grid-column: 1 / 5; grid-row: 1 / 2; }
.bg-b{ grid-column: 5 / 7; grid-row: 1 / 2; }
.bg-c{ grid-column: 1 / 3; grid-row: 2 / 3; }
.bg-d{ grid-column: 3 / 5; grid-row: 2 / 3; }
.bg-e{ grid-column: 5 / 7; grid-row: 2 / 3; }

/* ═══ ЦИТАТА — почти в самом низу, маленький отступ ═══ */
.best-quote{
  font-family: 'Rubik', sans-serif;
  font-weight: 700;
  font-size: 13px;
  line-height: 1.35;
  text-align: center;
  letter-spacing: .04em;
  text-transform: uppercase;
  padding: 14px 40px 18px;
  color: #000;
  margin-top: 0;
  flex-shrink: 0;
  background: #fff;
}
EOF

echo "✅ Новый CSS BESTIES v3 добавлен"

# ═══ PUSH ═══
echo ""
echo "→ git add / commit / push..."
git add .
git commit -m "Besties v3: dense photos + scribble outline filter" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Обнови сайт: Ctrl+Shift+R"
