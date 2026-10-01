#!/bin/bash
echo "▬▬▬ Добавляю 4 новых шаблона ▬▬▬"

# ═══════════════════ ШАБЛОН 21 — 16 ВЕЩЕЙ (левая) ═══════════════════
cat > templates/21-16-things-left.js << 'EOF'
export default {
  id: 'sixteen-things-left',
  name: '16 вещей (левая)',
  category: 'Текст',
  fields: [
    {key:'script',label:'Скрипт-заголовок',type:'text'},
    {key:'line1',label:'Строка 1',type:'text'},
    {key:'line2accent',label:'Строка 2 (акцент)',type:'text'},
    {key:'line3',label:'Строка 3',type:'text'},
    {key:'photo',label:'Фото (правая часть)',type:'image'},
    {key:'bow',label:'Бантик (PNG)',type:'image'},
    {key:'text1',label:'Пункт 1',type:'textarea'},
    {key:'text2',label:'Пункт 2',type:'textarea'},
    {key:'text3',label:'Пункт 3',type:'textarea'},
    {key:'text4',label:'Пункт 4',type:'textarea'},
    {key:'text5',label:'Пункт 5',type:'textarea'},
    {key:'text6',label:'Пункт 6',type:'textarea'},
    {key:'text7',label:'Пункт 7',type:'textarea'}
  ],
  defaults: {
    script:'16 вещей,',line1:'КОТОРЫЕ Я',line2accent:'ЛЮБЛЮ',line3:'в ней',
    photo:null,bow:null,
    text1:'1. я люблю тебя за твою заботу о близких, так как ты их не оставляешь в беде.',
    text2:'2. я знаю, как ты стараешься помочь мне в чем-то, поддержать, за это я тебя очень ценю, спасибо тебе.',
    text3:'3. я люблю тебя за твою правду, ведь ты всегда помогаешь снять розовые очки, когда я чего-то не вижу.',
    text4:'4. я знаю, что тебе трудно открываться людям, доверять, но я так благодарна что ты делишься со мной своими переживаниями.',
    text5:'5. я люблю тебя за то, что ты всегда на моей стороне, даже если я не права, я знаю что ты объяснишь мне в чем моя неправота.',
    text6:'6. я знаю и понимаю насколько тебе бывает тяжело и я хочу разделять эти трудности вместе с тобой, ты супер сильная, за это я тебя и люблю.',
    text7:'7. я люблю в тебе искренность, доброту и заботливость, которой ты делишься в самые нужные этапы в моей жизни.'
  },
  render(c, no){
    const ph = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    const bow = c.bow ? `<img class="st-bow" src="${c.bow}" alt="">` : '';
    return `<div class="page st-page">
      <div class="st-header">
        <div class="st-script">${c.script||''}</div>
        <div class="st-line1">${c.line1||''}<span class="st-accent"> ${c.line2accent||''}</span></div>
        <div class="st-line3">${c.line3||''}</div>
      </div>
      <div class="st-photo ${e}" style="${ph}"></div>
      ${bow}
      <div class="st-text st-t1">${(c.text1||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t2">${(c.text2||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t3">${(c.text3||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t4">${(c.text4||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t5">${(c.text5||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t6">${(c.text6||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t7">${(c.text7||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

# ═══════════════════ ШАБЛОН 22 — 16 ВЕЩЕЙ (правая) ═══════════════════
cat > templates/22-16-things-right.js << 'EOF'
export default {
  id: 'sixteen-things-right',
  name: '16 вещей (правая)',
  category: 'Текст',
  fields: [
    {key:'photo',label:'Фото (верх справа)',type:'image'},
    {key:'bow',label:'Бантик (PNG)',type:'image'},
    {key:'text8',label:'Пункт 8',type:'textarea'},
    {key:'text9',label:'Пункт 9',type:'textarea'},
    {key:'text10',label:'Пункт 10',type:'textarea'},
    {key:'text11',label:'Пункт 11',type:'textarea'},
    {key:'text12',label:'Пункт 12',type:'textarea'},
    {key:'text13',label:'Пункт 13',type:'textarea'},
    {key:'text14',label:'Пункт 14',type:'textarea'},
    {key:'text15',label:'Пункт 15',type:'textarea'},
    {key:'text16',label:'Пункт 16',type:'textarea'}
  ],
  defaults: {
    photo:null,bow:null,
    text8:'8. я люблю тебя за то, как ты любишь — безусловно, целиком, без оговорок «но». Не за что-то, а несмотря ни на что. Так, как любят в книгах, только по-настоящему.',
    text9:'9. я люблю тебя за твою честность — ты не говоришь того, чего не думаешь, и не молчишь, когда важно сказать. Бывает, твои слова ранят, но за ними нет зла, только желание, чтобы между нами не было стен.',
    text10:'10. я люблю тебя за то, что ты умеешь смеяться над собой. Ты не превращаешь ошибку в драму, а провал — в трагедию. Рядом с тобой становится легче быть неидеальным.',
    text11:'11. я люблю тебя за твою способность начинать заново — после неудачи, после дня, когда всё пошло не так. Ты плачешь, злишься, падаешь — а потом встаёшь, завариваешь чай и говоришь: «Ладно. Попробуем ещё раз.»',
    text12:'12. я люблю тебя за твою нежность — в незаметных жестах. В том, как ты накрываешь мою руку своей, когда чувствуешь, что мне тревожно.',
    text13:'13. я люблю тебя за то, как ты видишь мир — не чёрно-белым, не упрощённым, а живым. Ты замечаешь красоту там, где другие проходят мимо.',
    text14:'14. я люблю тебя за твой ум — живой, тёплый, любопытный. Ты задаёшь вопросы, на которые другие не догадываются спросить.',
    text15:'15. я люблю тебя за твоё упрямство — да, именно за него. Ты не сдаёшься, когда важно, стоишь на своём не из гордости, а из принципов.',
    text16:'16. и вообще я люблю в тебе все, абсолютно всё и всегда буду на твоей стороне, знай это, ведь если бы не ты, где бы я нашла подругу лучше.'
  },
  render(c, no){
    const ph = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    const bow = c.bow ? `<img class="st-bow st-bow--right" src="${c.bow}" alt="">` : '';
    return `<div class="page st-page st-page--right">
      <div class="st-photo st-photo--right ${e}" style="${ph}"></div>
      ${bow}
      <div class="st-text sr-t8">${(c.text8||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t9">${(c.text9||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t10">${(c.text10||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t11">${(c.text11||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t12">${(c.text12||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t13">${(c.text13||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t14">${(c.text14||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t15">${(c.text15||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t16">${(c.text16||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

# ═══════════════════ ШАБЛОН 23 — LOVE (вертикальные буквы) ═══════════════════
cat > templates/23-love-letters.js << 'EOF'
export default {
  id: 'love-letters',
  name: 'LOVE (буквы)',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1 (верх)',type:'image'},
    {key:'photo2',label:'Фото 2 (центр)',type:'image'},
    {key:'photo3',label:'Фото 3 (низ)',type:'image'}
  ],
  defaults: {photo1:null,photo2:null,photo3:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page love-letters-page">
      <div class="ll-photo ll-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="ll-photo ll-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="ll-photo ll-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="ll-word">
        <span>L</span>
        <span>O</span>
        <span>V</span>
        <span>E</span>
      </div>
    </div>`;
  }
};
EOF

# ═══════════════════ ШАБЛОН 24 — МАМА (сердечко из фото) ═══════════════════
cat > templates/24-mama.js << 'EOF'
export default {
  id: 'mama-heart',
  name: 'Мама (сердечко)',
  category: 'Коллажи',
  fields: [
    {key:'script1',label:'Надпись слева (курсив)',type:'text'},
    {key:'script2',label:'Надпись справа (курсив)',type:'text'},
    {key:'title',label:'Заголовок',type:'text'},
    {key:'photo1',label:'Фото 1 (большое)',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},
    {key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},
    {key:'photo10',label:'Фото 10',type:'image'},
    {key:'text',label:'Поздравление',type:'textarea'},
    {key:'sign',label:'Подпись (курсив)',type:'text'}
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
        <div class="mh mh-1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mh mh-2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mh mh-3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mh mh-4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mh mh-5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mh mh-6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mh mh-7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="mh mh-8 ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="mh mh-9 ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="mh mh-10 ${e('photo10')}" style="${p('photo10')}"></div>
      </div>

      <div class="mama-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
      <div class="mama-sign">${c.sign||''}</div>
    </div>`;
  }
};
EOF

echo "✅ Созданы 21, 22, 23, 24 шаблоны"

# ═══════════════════ REGISTRY ═══════════════════
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

export const TEMPLATES = [
  t01, t02, t03, t04, t05, t06, t07, t08,
  t09, t10, t11, t12, t13, t14, t15, t16,
  t17, t18, t19, t20, t21, t22, t23, t24
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
EOF

echo "✅ registry.js обновлён (24 шаблона)"

# ═══════════════════ CSS ═══════════════════
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 21 — 16 ВЕЩЕЙ (левая) ═══════════════════ */
.st-page{
  background: #fff;
  padding: 30px 30px 30px 38px;
  font-family: 'Times New Roman', Georgia, serif;
  color: #000;
  position: relative;
  overflow: hidden;
}
.st-header{
  position: absolute;
  top: 26px; left: 38px;
  z-index: 5;
  line-height: 1;
}
.st-script{
  font-family: 'Great Vibes', cursive;
  font-size: 66px;
  line-height: 1;
  margin-bottom: 6px;
}
.st-line1{
  font-family: 'Playfair Display', Georgia, serif;
  font-style: italic;
  font-weight: 700;
  font-size: 38px;
  line-height: 1;
}
.st-accent{ color: #DD9DB4; }
.st-line3{
  font-family: 'Playfair Display', Georgia, serif;
  font-style: italic;
  font-weight: 700;
  font-size: 34px;
  margin-top: 4px;
}
.st-photo{
  position: absolute;
  right: 0; top: 340px;
  width: 380px; height: 560px;
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
  border-radius: 400px 0 0 400px;
}
.st-photo.empty{ background: #f0ede8; }

.st-bow{
  position: absolute;
  right: 340px; top: 360px;
  width: 78px; height: auto;
  z-index: 4;
}
.st-bow--right{
  right: auto; left: 380px; top: 700px;
}

.st-text{
  position: relative;
  font-size: 15px;
  font-style: italic;
  line-height: 1.45;
  color: #111;
  padding: 0 4px;
  z-index: 3;
}
.st-text span.hi, .st-text b {
  color: #DD9DB4;
  font-style: italic;
}

/* Раскладка левой страницы */
.st-t1{ margin: 8px 420px 0 0; padding-top: 0; }
.st-t2{ margin: 12px 220px 0 0; }
.st-t3{ margin: 12px 0 0 260px; }
.st-t4{ margin: 12px 200px 0 220px; }
.st-t5{ margin: 12px 420px 0 0; }
.st-t6{ margin: 12px 420px 0 0; }
.st-t7{ margin: 12px 420px 0 0; }

/* Заголовок страницы — отступ сверху под правые пункты */
.st-t1{ position: absolute; top: 145px; right: 320px; left: auto; width: 300px; margin: 0; }
.st-t2{ position: absolute; top: 380px; left: 260px; width: 260px; margin: 0; }
.st-t3{ position: absolute; top: 250px; right: 20px; width: 260px; margin: 0; }
.st-t4{ position: absolute; top: 570px; right: 20px; width: 300px; margin: 0; }
.st-t5{ position: absolute; top: 480px; left: 44px; width: 260px; margin: 0; }
.st-t6{ position: absolute; top: 720px; left: 44px; width: 260px; margin: 0; }
.st-t7{ position: absolute; bottom: 40px; left: 44px; width: 280px; margin: 0; }

/* ═══════════════════ ШАБЛОН 22 — 16 ВЕЩЕЙ (правая) ═══════════════════ */
.st-page--right{ padding: 30px; }

.st-photo--right{
  position: absolute;
  right: 0; top: 0;
  width: 340px; height: 500px;
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
  border-radius: 0 0 0 340px;
}
.st-photo--right.empty{ background: #f0ede8; }

.st-text.sr-t8,  .st-text.sr-t9,  .st-text.sr-t10,
.st-text.sr-t11, .st-text.sr-t12,.st-text.sr-t13,
.st-text.sr-t14, .st-text.sr-t15,.st-text.sr-t16{
  position: absolute;
  width: 300px;
  font-size: 15px;
}

.sr-t8  { top: 30px;  left: 40px; width: 320px; }
.sr-t9  { top: 180px; left: 40px; width: 320px; }
.sr-t10 { top: 350px; left: 40px; width: 300px; }
.sr-t11 { top: 520px; left: 40px; width: 320px; }
.sr-t12 { top: 760px; left: 40px; width: 320px; }
.sr-t13 { top: 30px;  right: 40px; width: 320px; }
.sr-t14 { top: 550px; right: 40px; width: 320px; }
.sr-t15 { top: 680px; right: 40px; width: 320px; }
.sr-t16 { bottom: 60px; left: 40px; width: 700px; }

/* ═══════════════════ ШАБЛОН 23 — LOVE (вертикальные буквы) ═══════════════════ */
.love-letters-page{
  position: relative;
  background: #000;
  padding: 30px;
}
.ll-photo{
  position: absolute;
  left: 30px; right: 30px;
  background-size: cover;
  background-position: center;
  background-color: #222;
}
.ll-photo.empty{ background: #222; }
.ll-p1{ top: 30px;  height: 340px; }
.ll-p2{ top: 390px; height: 340px; }
.ll-p3{ top: 750px; height: 340px; }

.ll-word{
  position: absolute;
  top: 90px; left: 50%;
  transform: translateX(-50%);
  z-index: 5;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  pointer-events: none;
}
.ll-word span{
  font-family: 'Modern No 20', 'Playfair Display', serif;
  font-size: 180px;
  line-height: .85;
  color: #fff;
  text-shadow: 0 4px 24px rgba(0,0,0,.6);
}

/* ═══════════════════ ШАБЛОН 24 — МАМА (сердечко) ═══════════════════ */
.mama-page{
  background: #fff;
  padding: 40px 40px 30px;
  position: relative;
  font-family: 'Great Vibes', cursive;
  overflow: hidden;
}
.mama-script1{
  position: absolute;
  top: 30px; left: 70px;
  font-size: 40px;
  color: #111;
}
.mama-script2{
  position: absolute;
  top: 30px; right: 70px;
  font-size: 40px;
  color: #111;
}
.mama-title{
  font-family: 'Great Vibes', cursive;
  font-size: 92px;
  color: #922020;
  text-align: center;
  margin: 10px 0 24px;
  line-height: 1;
}

.mama-heart{
  position: relative;
  width: 100%;
  height: 620px;
  margin: 0 auto 20px;
}
.mh{
  position: absolute;
  background-size: cover;
  background-position: center;
  background-color: #f0ede8;
  border: 2px solid #fff;
  box-shadow: 0 4px 14px rgba(0,0,0,.08);
}
.mh.empty{ background: #f0ede8; }
.mh-1{ left: 38%; top: 0;   width: 24%; height: 22%; }
.mh-2{ left: 20%; top: 8%;   width: 16%; height: 18%; }
.mh-3{ left: 64%; top: 8%;   width: 16%; height: 18%; }
.mh-4{ left: 8%;  top: 26%;  width: 14%; height: 18%; }
.mh-5{ right: 8%; top: 26%;  width: 14%; height: 18%; }
.mh-6{ left: 20%; top: 44%;  width: 16%; height: 20%; }
.mh-7{ right: 20%; top: 44%; width: 16%; height: 20%; }
.mh-8{ left: 33%; top: 62%;  width: 14%; height: 18%; }
.mh-9{ right: 33%; top: 62%; width: 14%; height: 18%; }
.mh-10{ left: 42%; top: 78%; width: 16%; height: 20%; }

.mama-text{
  font-family: 'Inter', sans-serif;
  font-weight: 200;
  font-size: 14px;
  line-height: 1.5;
  text-align: center;
  color: #111;
  margin: 20px 0 14px;
}
.mama-sign{
  font-family: 'Great Vibes', cursive;
  font-size: 42px;
  color: #111;
  text-align: center;
  margin-bottom: 10px;
}
EOF

echo "✅ CSS добавлен"

# ═══════════════════ PUSH ═══════════════════
echo ""
echo "→ git add / commit / push..."
git add .
git commit -m "Add templates: 16 things (left/right), LOVE letters, Mama heart" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Обнови сайт: Ctrl+Shift+R"
