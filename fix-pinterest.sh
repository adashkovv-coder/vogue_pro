#!/bin/bash
echo "▬▬▬ Фикс Pinterest + новый задник ▬▬▬"

# ═══ PINTEREST — используем точные координаты из Figma ═══
cat > templates/19-pinterest-board.js << 'EOF'
/* ============================================================
   ШАБЛОН 19 — PINTEREST BOARD
   Figma Frame 2669: 2481×3507 → A4 794×1123 (×0.32)
   Фото на абсолютных координатах — ничего не летает
   ============================================================ */
export default {
  id: 'pinterest-board',
  name: 'Pinterest доска',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок (жирный)',type:'text'},
    {key:'title2',label:'Заголовок 2-я строка',type:'text'},
    {key:'photos',label:'Загрузить 11 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10','photo11']}
  ],
  defaults: {
    title1:'Она, если была бы доской',
    title2:'на Pinterest',
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
      <div class="pin-item pin-1  ${e('photo1')}"  style="${p('photo1')}"></div>
      <div class="pin-item pin-2  ${e('photo2')}"  style="${p('photo2')}"></div>
      <div class="pin-item pin-3  ${e('photo3')}"  style="${p('photo3')}"></div>
      <div class="pin-item pin-4  ${e('photo4')}"  style="${p('photo4')}"></div>
      <div class="pin-item pin-5  ${e('photo5')}"  style="${p('photo5')}"></div>
      <div class="pin-item pin-6  ${e('photo6')}"  style="${p('photo6')}"></div>
      <div class="pin-item pin-7  ${e('photo7')}"  style="${p('photo7')}"></div>
      <div class="pin-item pin-8  ${e('photo8')}"  style="${p('photo8')}"></div>
      <div class="pin-item pin-9  ${e('photo9')}"  style="${p('photo9')}"></div>
      <div class="pin-item pin-10 ${e('photo10')}" style="${p('photo10')}"></div>
      <div class="pin-item pin-11 ${e('photo11')}" style="${p('photo11')}"></div>
    </div>`;
  }
};
EOF

echo "✅ 19-pinterest-board.js перезаписан"

# ═══ НОВЫЙ ШАБЛОН 25 — ЗАДНЯЯ ОБЛОЖКА "BIRTHDAY" ═══
cat > templates/25-back-birthday.js << 'EOF'
/* ============================================================
   ШАБЛОН 25 — BACK BIRTHDAY (задняя обложка)
   Figma Frame 2678: 2481×3507 → A4 794×1123
   ============================================================ */
export default {
  id: 'back-birthday',
  name: 'Birthday (задник)',
  category: 'Задние обложки',
  fields: [
    {key:'photo',label:'Фото на фоне',type:'image'},
    {key:'title',label:'Заголовок (BIRTHDAY)',type:'text'},
    {key:'subtitle',label:'Подпись курсивом',type:'textarea'}
  ],
  defaults: {
    photo:null,
    title:'BIRTHDAY',
    subtitle:'the end of this magazine\nbut not the end of the story'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page back-bday-page">
      <div class="bb-photo ${e}" style="${p}"></div>
      <div class="bb-title">${c.title||''}</div>
      <div class="bb-subtitle">${(c.subtitle||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

echo "✅ 25-back-birthday.js создан"

# ═══ REGISTRY ═══
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
import t21 from './21-16-things-left.js';
import t22 from './22-16-things-right.js';
import t23 from './23-love-letters.js';
import t24 from './24-mama.js';
import t25 from './25-back-birthday.js';

export const TEMPLATES = [
  t01, t02, t03, t04, t05, t06, t07, t08,
  t09, t10, t11, t12, t13, t14, t15, t16,
  t17, t18, t19, t20, t21, t22, t23, t24, t25
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
EOF

echo "✅ registry.js обновлён (25 шаблонов)"

# ═══ CSS — УДАЛЯЕМ СТАРЫЙ PINTEREST ═══
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

pattern = r'/\* ═+ ШАБЛОН 19 — PINTEREST BOARD ═+ \*/.*?(?=/\* ═+ ШАБЛОН 20)'
css = re.sub(pattern, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS Pinterest удалён")
PY_EOF

# ═══ ДОБАВЛЯЕМ НОВЫЙ CSS ═══
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 19 — PINTEREST BOARD (v2, абсолют) ═══════════════════ */
.pinterest-page{
  background: #fff;
  position: relative;
  overflow: hidden;
  font-family: 'Times New Roman', Georgia, serif;
  color: #000;
}

/* ─── ЗАГОЛОВОК ─── */
.pin-title{
  position: absolute;
  top: 26px;
  left: 0;
  right: 0;
  text-align: center;
  z-index: 5;
  line-height: 1.02;
}
.pin-title-bold{
  font-size: 54px;
  font-weight: 700;
  letter-spacing: -.005em;
  margin-bottom: 2px;
}
.pin-title-line{
  font-size: 54px;
  font-weight: 400;
  letter-spacing: -.005em;
}

/* ─── ФОТО — точные координаты из Figma (× 0.32) ─── */
.pin-item{
  position: absolute;
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
  border-radius: 26px;
}
.pin-item.empty{
  background: #f0ede8;
  position: absolute;
}
.pin-item.empty::after{
  content: 'ФОТО';
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Inter', sans-serif;
  font-size: 9px;
  letter-spacing: .3em;
  color: #c0b8aa;
}

/* Координаты: left, top, width, height (все /3.125) */
.pin-1  { left: 525px; top: 181px; width: 205px; height: 205px; }
.pin-2  { left:  64px; top: 402px; width: 183px; height: 183px; }
.pin-3  { left:  64px; top: 831px; width: 190px; height: 190px; }
.pin-4  { left:  68px; top: 181px; width: 170px; height: 180px; }
.pin-5  { left: 282px; top: 174px; width: 199px; height: 199px; }
.pin-6  { left: 499px; top: 409px; width: 231px; height: 231px; }
.pin-7  { left:  64px; top: 625px; width: 174px; height: 174px; }
.pin-8  { left: 267px; top: 402px; width: 212px; height: 209px; }
.pin-9  { left: 267px; top: 826px; width: 201px; height: 201px; }
.pin-10 { left: 487px; top: 675px; width: 243px; height: 352px; }
.pin-11 { left: 261px; top: 640px; width: 206px; height: 147px; }

/* ═══════════════════ ШАБЛОН 25 — BACK BIRTHDAY ═══════════════════ */
.back-bday-page{
  background: #1a1f14;
  position: relative;
  overflow: hidden;
}
.bb-photo{
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  background-color: #2a3320;
}
.bb-photo.empty{ background: #2a3320; }

.bb-title{
  position: absolute;
  top: 52px;
  left: 22px;
  font-family: 'Modern No 20', 'Playfair Display', Georgia, serif;
  font-size: 96px;
  font-weight: 400;
  color: #fff;
  letter-spacing: .01em;
  line-height: 1;
  text-shadow: 0 2px 20px rgba(0,0,0,.5);
  z-index: 5;
}
.bb-subtitle{
  position: absolute;
  top: 140px;
  left: 22px;
  font-family: 'Petit Formal Script', cursive;
  font-size: 32px;
  line-height: 1.2;
  color: #fff;
  text-shadow: 0 1px 14px rgba(0,0,0,.5);
  z-index: 5;
}
EOF

echo "✅ Новый CSS добавлен"

# ═══ PUSH ═══
echo ""
git add .
git commit -m "Fix Pinterest (absolute coords) + add back-birthday template" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
