#!/bin/bash
echo "▬▬▬ Пересобираю Our Memories (2 шаблона) ▬▬▬"

# Удаляем старый объединённый шаблон
rm -f templates/06-our-memories.js

# ============ ЛЕВАЯ СТРАНИЦА — OUR MEMORIES ============
cat > templates/06-our-memories-left.js << 'EOF'
/* ============================================================
   ШАБЛОН 06 — OUR MEMORIES (левая страница)
   Figma Frame 2000: 2481×3507 → A4 794×1123
   ============================================================ */
export default {
  id: 'our-memories-left',
  name: 'Our Memories (левая)',
  category: 'Коллажи',
  fields: [
    {key:'word1',label:'Слово курсивом',type:'text'},
    {key:'word2',label:'Слово основное',type:'text'},
    {key:'photo1',label:'Фото 1 (большое)',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},
    {key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'}
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

# ============ ПРАВАЯ СТРАНИЦА — MEMORIES ============
cat > templates/06b-memories-right.js << 'EOF'
/* ============================================================
   ШАБЛОН 06B — MEMORIES (правая страница)
   Figma Frame 2002: 2481×3507 → A4 794×1123
   ============================================================ */
export default {
  id: 'memories-right',
  name: 'Memories (правая)',
  category: 'Коллажи',
  fields: [
    {key:'word',label:'Заголовок',type:'text'},
    {key:'photo1',label:'Фото 1 (большое)',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},
    {key:'photo8',label:'Фото 8',type:'image'}
  ],
  defaults: {
    word:'MEMORIES',
    photo1:null,photo2:null,photo3:null,photo4:null,
    photo5:null,photo6:null,photo7:null,photo8:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mem-page mem-page--right">
      <div class="mem-title mem-title--right">
        <span class="mem-memories">${c.word||''}</span>
      </div>
      <div class="mem-grid mem-grid--right">
        <div class="mem-cell mem-r1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mem-cell mem-r2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mem-cell mem-r3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mem-cell mem-r4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mem-cell mem-r5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mem-cell mem-r6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mem-cell mem-r7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="mem-cell mem-r8 ${e('photo8')}" style="${p('photo8')}"></div>
      </div>
    </div>`;
  }
};
EOF

echo "✅ Созданы 06-our-memories-left.js и 06b-memories-right.js"

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

export const TEMPLATES = [
  t01, t02, t03, t04, t05, t06, t07, t08,
  t09, t10, t11, t12, t13, t14, t15, t16, t17, t18
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
EOF

echo "✅ registry.js обновлён (18 шаблонов)"

# ============ УДАЛЯЕМ СТАРЫЙ CSS БЛОК И ДОБАВЛЯЕМ НОВЫЙ ============
# Ищем блок про .mem-page в styles.css и удаляем его
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

# Удаляем старый блок про mem-page (от /* ... OUR MEMORIES ... */ до /* ... BESTIES ... */)
pattern = r'/\* ═+ ШАБЛОН 06 — OUR MEMORIES ═+ \*/.*?(?=/\* ═+ ШАБЛОН 07)'
css = re.sub(pattern, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS про MEMORIES удалён")
PY_EOF

# Добавляем новый CSS в конец
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 06 — OUR MEMORIES (левая) ═══════════════════ */
.mem-page{
  background: #fff;
  padding: 30px 40px 40px;
  font-family: 'Modern No 20', serif;
  color: #000;
  overflow: hidden;
}

.mem-title{
  display: flex;
  align-items: baseline;
  gap: 14px;
  margin-bottom: 22px;
  white-space: nowrap;
  overflow: hidden;
  height: 130px;
}

.mem-our{
  font-family: 'Great Vibes', cursive;
  font-size: 82px;
  color: #715D44;
  line-height: 1;
  flex-shrink: 0;
  padding-bottom: 8px;
}

.mem-memories{
  font-family: 'Modern No 20', Georgia, serif;
  font-size: 168px;
  font-weight: 400;
  line-height: .85;
  letter-spacing: -.01em;
  color: #000;
  flex-shrink: 0;
}

/* Сетка левой страницы: 4 колонки, авто-строки */
.mem-grid{
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: 185px;
  gap: 8px;
}

.mem-cell{
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
}
.mem-cell.empty{
  background: #f0ede8;
  position: relative;
}
.mem-cell.empty::after{
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

/* Раскладка левой страницы */
.mem-1{ grid-column: span 2; grid-row: span 2; }
.mem-2{ grid-column: span 1; grid-row: span 1; }
.mem-3{ grid-column: span 1; grid-row: span 1; }
.mem-4{ grid-column: span 1; grid-row: span 1; }
.mem-5{ grid-column: span 1; grid-row: span 1; }
.mem-6{ grid-column: span 1; grid-row: span 1; }
.mem-7{ grid-column: span 1; grid-row: span 1; }
.mem-8{ grid-column: span 1; grid-row: span 1; }
.mem-9{ grid-column: span 1; grid-row: span 1; }

/* ═══════════════════ ШАБЛОН 06B — MEMORIES (правая) ═══════════════════ */
.mem-page--right{
  padding: 30px 40px 40px;
}

.mem-title--right{
  justify-content: flex-end;
  padding-right: 0;
}

.mem-grid--right{
  grid-template-columns: repeat(3, 1fr);
  grid-auto-rows: 200px;
}

/* Раскладка правой страницы */
.mem-r1{ grid-column: span 1; grid-row: span 2; }
.mem-r2{ grid-column: span 1; grid-row: span 1; }
.mem-r3{ grid-column: span 1; grid-row: span 1; }
.mem-r4{ grid-column: span 1; grid-row: span 1; }
.mem-r5{ grid-column: span 1; grid-row: span 1; }
.mem-r6{ grid-column: span 1; grid-row: span 1; }
.mem-r7{ grid-column: span 1; grid-row: span 1; }
.mem-r8{ grid-column: span 1; grid-row: span 1; }
EOF

echo "✅ CSS добавлен"
echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Теперь: git add . && git commit -m 'Rebuild Our Memories' && git push"
