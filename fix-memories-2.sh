#!/bin/bash
echo "▬▬▬ Пересобираю OUR MEMORIES строго по Figma ▬▬▬"

# ============ ЛЕВАЯ СТРАНИЦА — "MEMO..." с обрезкой справа ============
cat > templates/06-our-memories-left.js << 'EOF'
/* ============================================================
   ШАБЛОН 06 — OUR MEMORIES (левая страница)
   Figma Frame 2000: 2481×3507 → A4 794×1123
   Слово "MEMORIES" продолжается на правой странице
   ============================================================ */
export default {
  id: 'our-memories-left',
  name: 'Our Memories (левая)',
  category: 'Коллажи',
  fields: [
    {key:'word1',label:'Слово курсивом (OUR)',type:'text'},
    {key:'word2',label:'Слово основное (MEMO...)',type:'text'},
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

# ============ ПРАВАЯ СТРАНИЦА — "...RIES" с обрезкой слева ============
cat > templates/06b-memories-right.js << 'EOF'
/* ============================================================
   ШАБЛОН 06B — MEMORIES (правая страница)
   Figma Frame 2002: 2481×3507 → A4 794×1123
   Продолжение слова "MEMORIES" с левой страницы
   ============================================================ */
export default {
  id: 'memories-right',
  name: 'Memories (правая)',
  category: 'Коллажи',
  fields: [
    {key:'word',label:'Слово основное (RIES)',type:'text'},
    {key:'photo1',label:'Фото 1',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'}
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

echo "✅ Обновлены оба шаблона"

# ============ УДАЛЯЕМ СТАРЫЙ CSS MEM-PAGE И ДОБАВЛЯЕМ НОВЫЙ ============
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

# Удаляем старый блок про MEM
pattern = r'/\* ═+ ШАБЛОН 06 — OUR MEMORIES \(левая\) ═+ \*/.*?(?=/\* ═+ ШАБЛОН 07)'
css = re.sub(pattern, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS MEMORIES удалён")
PY_EOF

cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 06 — OUR MEMORIES / MEMORIES (разворот) ═══════════════════ */
.mem-page{
  background: #fff;
  padding: 22px 0 30px 36px;  /* правый отступ = 0, слово уходит за край */
  font-family: 'Modern No 20', Georgia, serif;
  color: #000;
  overflow: hidden;
  position: relative;
}

.mem-page--right{
  padding: 22px 36px 30px 0;  /* левый отступ = 0 */
}

/* ─── Заголовок ─── */
.mem-title{
  display: flex;
  align-items: baseline;
  gap: 12px;
  margin-bottom: 20px;
  height: 118px;
  overflow: visible;   /* слово обрезается краем страницы, а не overflow */
  white-space: nowrap;
  padding-right: 0;
}

.mem-our{
  font-family: 'Great Vibes', cursive;
  font-size: 76px;
  color: #715D44;
  line-height: 1;
  flex-shrink: 0;
  padding-bottom: 6px;
  letter-spacing: .02em;
}

.mem-memories{
  font-family: 'Modern No 20', Georgia, serif;
  font-size: 152px;
  font-weight: 400;
  line-height: .9;
  letter-spacing: -.005em;
  color: #000;
  flex-shrink: 0;
  /* обрезание: слово шире страницы → край обрезает его */
  display: inline-block;
}

.mem-memories--right{
  /* на правой стороне показываем "хвост" слова */
  margin-left: -180px;   /* ← сдвигает RIES влево, чтобы читалось с середины */
}

.mem-title--right{
  justify-content: flex-start;
  padding-left: 0;
  margin-left: 0;
}

/* ─── Сетка ЛЕВОЙ страницы ─── */
.mem-grid{
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: 175px;
  gap: 7px;
}

.mem-page--right .mem-grid{
  /* правая страница: 3 колонки */
  grid-template-columns: repeat(3, 1fr);
  padding-right: 0;
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

/* ─── Раскладка левой страницы (9 фото) ─── */
.mem-1{ grid-column: span 2; grid-row: span 2; }
.mem-2{ grid-column: span 1; grid-row: span 1; }
.mem-3{ grid-column: span 1; grid-row: span 1; }
.mem-4{ grid-column: span 1; grid-row: span 1; }
.mem-5{ grid-column: span 1; grid-row: span 1; }
.mem-6{ grid-column: span 1; grid-row: span 1; }
.mem-7{ grid-column: span 1; grid-row: span 1; }
.mem-8{ grid-column: span 1; grid-row: span 1; }
.mem-9{ grid-column: span 1; grid-row: span 1; }

/* ─── Раскладка правой страницы (7 фото) ─── */
.mem-r1{ grid-column: span 1; grid-row: span 2; }
.mem-r2{ grid-column: span 1; grid-row: span 1; }
.mem-r3{ grid-column: span 1; grid-row: span 1; }
.mem-r4{ grid-column: span 1; grid-row: span 1; }
.mem-r5{ grid-column: span 1; grid-row: span 1; }
.mem-r6{ grid-column: span 1; grid-row: span 1; }
.mem-r7{ grid-column: span 1; grid-row: span 1; }
EOF

echo "✅ Новый CSS добавлен"
echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Теперь: git add . && git commit -m 'Fix Memories split' && git push"
