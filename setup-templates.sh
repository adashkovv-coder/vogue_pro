#!/bin/bash
echo "▬▬▬ Установка 15 шаблонов ▬▬▬"

# ============ ШАБЛОН 06 — OUR MEMORIES ============
cat > templates/06-our-memories.js << 'EOF'
export default {
  id: 'our-memories',
  name: 'Our Memories',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},{key:'photo10',label:'Фото 10',type:'image'},
    {key:'title1',label:'Надпись (курсив)',type:'text'},
    {key:'title2',label:'Заголовок (крупно)',type:'text'}
  ],
  defaults: {
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null,photo9:null,photo10:null,
    title1:'OUR',title2:'MEMORIES'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mem-page">
      <div class="mem-title"><span class="mt-script">${c.title1||''}</span><span class="mt-serif">${c.title2||''}</span></div>
      <div class="mem-grid">
        <div class="mg-item mg-a ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mg-item mg-b ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mg-item mg-c ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mg-item mg-d ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mg-item mg-e ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mg-item mg-f ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mg-item mg-g ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="mg-item mg-h ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="mg-item mg-i ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="mg-item mg-j ${e('photo10')}" style="${p('photo10')}"></div>
      </div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 07 — BESTIES ============
cat > templates/07-besties.js << 'EOF'
export default {
  id: 'besties',
  name: 'Besties',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'quote',label:'Цитата снизу',type:'textarea'}
  ],
  defaults: {
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,
    quote:'"A FRIENDS KNOWS THE SONG IN MY HEART AND SINGS IT IN ME WHEN MY MEMORY FAILS"'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page best-page">
      <div class="best-title t1">BESTIES</div>
      <div class="best-title t2">BESTIES</div>
      <div class="best-title t3">BESTIES</div>
      <div class="best-grid">
        <div class="bg-item ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="bg-item ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="bg-item ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="bg-item ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="bg-item ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="bg-item ${e('photo6')}" style="${p('photo6')}"></div>
      </div>
      <div class="best-quote">${c.quote||''}</div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 08 — PHOTO GRID ============
cat > templates/08-photo-grid.js << 'EOF'
export default {
  id: 'photo-grid',
  name: 'Фото-сетка',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'}
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

# ============ ШАБЛОН 09 — FAVOURITE ============
cat > templates/09-favourite.js << 'EOF'
export default {
  id: 'favourite',
  name: 'Favourite',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'title',label:'Заголовок',type:'text'},
    {key:'label1',label:'Подпись 1',type:'text'},
    {key:'label2',label:'Подпись 2',type:'text'},
    {key:'label3',label:'Подпись 3',type:'text'}
  ],
  defaults: {
    photo1:null,photo2:null,photo3:null,
    title:'FAVOURITE',label1:'FLOWER',label2:'DRINK',label3:'SEASON'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page fav-page">
      <div class="fav-title">${c.title||''}</div>
      <div class="fav-item fav-i1">
        <div class="fav-label">${c.label1||''}</div>
        <div class="fav-photo ${e('photo1')}" style="${p('photo1')}"></div>
      </div>
      <div class="fav-item fav-i2">
        <div class="fav-label">${c.label2||''}</div>
        <div class="fav-photo ${e('photo2')}" style="${p('photo2')}"></div>
      </div>
      <div class="fav-item fav-i3">
        <div class="fav-label">${c.label3||''}</div>
        <div class="fav-photo ${e('photo3')}" style="${p('photo3')}"></div>
      </div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 10 — HER SONGS ============
cat > templates/10-her-songs.js << 'EOF'
export default {
  id: 'her-songs',
  name: 'Her Songs',
  category: 'Музыка',
  fields: [
    {key:'title',label:'Заголовок (HER)',type:'text'},
    {key:'subtitle',label:'Подзаголовок (SONGS)',type:'text'},
    {key:'song1',label:'Песня 1',type:'text'},{key:'artist1',label:'Исполнитель 1',type:'text'},
    {key:'song2',label:'Песня 2',type:'text'},{key:'artist2',label:'Исполнитель 2',type:'text'},
    {key:'song3',label:'Песня 3',type:'text'},{key:'artist3',label:'Исполнитель 3',type:'text'},
    {key:'song4',label:'Песня 4',type:'text'},{key:'artist4',label:'Исполнитель 4',type:'text'}
  ],
  defaults: {
    title:'HER',subtitle:'SONGS',
    song1:"Yeah, my boyfriend's pretty cool", artist1:'Brooklyn Baby',
    song2:'I wrote you a note, but I didn\'t send it', artist2:'Sweet',
    song3:"I'm pretty when I cry", artist3:'Pretty When You Cry',
    song4:'Hot summer nights, mid-July', artist4:'Young And Beautiful'
  },
  render(c, no){
    return `<div class="page hs-page">
      <div class="hs-title">${c.title||''}</div>
      <div class="hs-subtitle">${c.subtitle||''}</div>
      <div class="hs-card hs-c1"><div class="hs-song">${c.song1||''}</div><div class="hs-artist">${c.artist1||''}</div></div>
      <div class="hs-card hs-c2"><div class="hs-song">${c.song2||''}</div><div class="hs-artist">${c.artist2||''}</div></div>
      <div class="hs-card hs-c3"><div class="hs-song">${c.song3||''}</div><div class="hs-artist">${c.artist3||''}</div></div>
      <div class="hs-card hs-c4"><div class="hs-song">${c.song4||''}</div><div class="hs-artist">${c.artist4||''}</div></div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 11 — ANNA'S PLAYLIST ============
cat > templates/11-annas-playlist.js << 'EOF'
export default {
  id: 'annas-playlist',
  name: "Anna's Playlist",
  category: 'Обложки',
  fields: [
    {key:'photo',label:'Фото на фоне',type:'image'},
    {key:'name',label:'Имя',type:'text'},
    {key:'script',label:'Надпись курсивом',type:'text'},
    {key:'date',label:'Дата/время',type:'text'}
  ],
  defaults: {
    photo:null,name:"ANNA'S",script:'Playlist',date:'06.30.2026 19:27'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page ap-page">
      <div class="ap-photo ${e}" style="${p}"></div>
      <div class="ap-title"><span class="ap-name">${c.name||''}</span><span class="ap-script">${c.script||''}</span></div>
      <div class="ap-date">${c.date||''}</div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 12 — BIRTHDAY COVER ============
cat > templates/12-birthday-cover.js << 'EOF'
export default {
  id: 'birthday-cover',
  name: 'Birthday (портрет)',
  category: 'Обложки',
  fields: [
    {key:'photo',label:'Фото на фоне',type:'image'},
    {key:'title',label:'BIRTHDAY',type:'text'},
    {key:'script',label:'Подпись (курсив)',type:'textarea'}
  ],
  defaults: {
    photo:null,title:'BIRTHDAY',script:'the end of this magazine\nbut not the end of the story'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page bc-page">
      <div class="bc-photo ${e}" style="${p}"></div>
      <div class="bc-title">${c.title||''}</div>
      <div class="bc-script">${(c.script||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 13 — HER VIBE ============
cat > templates/13-her-vibe.js << 'EOF'
export default {
  id: 'her-vibe',
  name: 'Her Vibe',
  category: 'Коллажи',
  fields: [
    {key:'title',label:'Заголовок (скрипт)',type:'text'},
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'}
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

# ============ ШАБЛОН 14 — ТВОЯ ЛЮБОВЬ ============
cat > templates/14-tvoya-lyubov.js << 'EOF'
export default {
  id: 'tvoya-lyubov',
  name: 'Твоя любовь',
  category: 'Текст',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'title',label:'Заголовок',type:'textarea'},
    {key:'script',label:'Скрипт (курсив)',type:'textarea'}
  ],
  defaults: {
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,
    title:'Твоя любовь это так красиво',
    script:'твоя любовь\nвозвращала в детство,\nдарила все, чего не хватало'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page tl-page">
      <div class="tl-photo tl-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="tl-photo tl-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="tl-photo tl-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="tl-photo tl-p4 ${e('photo4')}" style="${p('photo4')}"></div>
      <div class="tl-photo tl-p5 ${e('photo5')}" style="${p('photo5')}"></div>
      <div class="tl-title">${(c.title||'').replace(/\n/g,'<br>')}</div>
      <div class="tl-script">${(c.script||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 15 — ZODIAC STAR MAP ============
cat > templates/15-zodiac-map.js << 'EOF'
export default {
  id: 'zodiac-map',
  name: 'Зодиак · карта',
  category: 'Зодиак',
  fields: [
    {key:'starMap',label:'Карта звёзд (PNG)',type:'image'},
    {key:'text',label:'Текст под картой',type:'textarea'}
  ],
  defaults: {
    starMap:null,
    text:'Девушка-Весы — это сочетание нежности, красоты и внутренней силы. Она ценит гармонию, умеет находить общий язык с людьми и старается видеть прекрасное даже в мелочах.'
  },
  render(c, no){
    const p = c.starMap ? `background-image:url('${c.starMap}')` : '';
    const e = c.starMap ? '' : 'empty';
    return `<div class="page zm-page">
      <div class="zm-map ${e}" style="${p}"></div>
      <div class="zm-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 16 — ДЕТСТВО ============
cat > templates/16-detstvo.js << 'EOF'
export default {
  id: 'detstvo',
  name: 'Детство',
  category: 'Текст',
  fields: [
    {key:'script',label:'Скрипт-заголовок',type:'text'},
    {key:'line1',label:'Строка 1',type:'text'},
    {key:'line2',label:'Строка 2',type:'text'},
    {key:'photo',label:'Фото (сердечко)',type:'image'},
    {key:'text',label:'Текст снизу',type:'textarea'}
  ],
  defaults: {
    script:'детство.',line1:'МАЛЕНЬКАЯ',line2:'ТЫ.',
    photo:null,
    text:'Детство — это время, когда мир кажется огромным и полным чудес. Просыпаешься рано, едва солнце заглядывает в окно, и сразу хочется бежать во двор — играть с друзьями в прятки или гонять мяч. Каждый день — новое приключение.'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page dt-page">
      <div class="dt-script">${c.script||''}</div>
      <div class="dt-line1">${c.line1||''}</div>
      <div class="dt-line2">${c.line2||''}<span class="dt-heart ${e}" style="${p}"></span></div>
      <div class="dt-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 17 — МАЛЕНЬКАЯ ТЫ (продолжение) ============
cat > templates/17-malenkaya.js << 'EOF'
export default {
  id: 'malenkaya',
  name: 'Маленькая (продолжение)',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'}
  ],
  defaults: {photo1:null,photo2:null,photo3:null,photo4:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mk-page">
      <div class="mk-script">тво</div>
      <div class="mk-line">НЬКАЯ</div>
      <div class="mk-photo mk-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="mk-photo mk-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="mk-photo mk-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="mk-photo mk-p4 ${e('photo4')}" style="${p('photo4')}"></div>
    </div>`;
  }
};
EOF

# ============ ШАБЛОН 18 — COLLAGE ROUNDED ============
cat > templates/18-collage-rounded.js << 'EOF'
export default {
  id: 'collage-rounded',
  name: 'Коллаж (скруглённый)',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},{key:'photo10',label:'Фото 10',type:'image'}
  ],
  defaults: {photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null,photo9:null,photo10:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page cr-page">
      <div class="cr-grid">
        <div class="cri c1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="cri c2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="cri c3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="cri c4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="cri c5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="cri c6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="cri c7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="cri c8 ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="cri c9 ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="cri c10 ${e('photo10')}" style="${p('photo10')}"></div>
      </div>
    </div>`;
  }
};
EOF

echo "✅ 15 шаблонов создано"

# ============ ОБНОВЛЯЕМ REGISTRY ============
cat > templates/registry.js << 'EOF'
import t01 from './01-birthday-vogue.js';
import t02 from './02-whos-that-girl.js';
import t03 from './04-to-friend.js';
import t04 from './05-love-quote.js';
import t05 from './06-our-memories.js';
import t06 from './07-besties.js';
import t07 from './08-photo-grid.js';
import t08 from './09-favourite.js';
import t09 from './10-her-songs.js';
import t10 from './11-annas-playlist.js';
import t11 from './12-birthday-cover.js';
import t12 from './13-her-vibe.js';
import t13 from './14-tvoya-lyubov.js';
import t14 from './15-zodiac-map.js';
import t15 from './16-detstvo.js';
import t16 from './17-malenkaya.js';
import t17 from './18-collage-rounded.js';

export const TEMPLATES = [
  t01, t02, t03, t04, t05, t06, t07, t08,
  t09, t10, t11, t12, t13, t14, t15, t16, t17
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
EOF

echo "✅ registry.js обновлён (17 шаблонов)"

# ============ ДОБАВЛЯЕМ CSS ============
cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 06 — OUR MEMORIES ═══════════════════ */
.mem-page{background:#fff;padding:60px 60px;font-family:'Modern No 20',serif;}
.mem-title{text-align:center;margin-bottom:40px;position:relative;height:110px;}
.mt-script{font-family:'Great Vibes',cursive;font-size:64px;color:#715D44;position:absolute;left:50%;transform:translateX(-90%);top:0;z-index:2;}
.mt-serif{font-size:120px;font-weight:400;letter-spacing:.02em;position:absolute;left:50%;transform:translateX(-45%);top:0;}
.mem-grid{display:grid;grid-template-columns:repeat(4,1fr);grid-auto-rows:230px;gap:10px;}
.mg-item{background-size:cover;background-position:center;background-color:#f0ede8;}
.mg-item.empty{background:#f0ede8;}
.mg-a{grid-column:span 2;grid-row:span 2;}
.mg-b{grid-column:span 2;}
.mg-c{}
.mg-d{}
.mg-e{grid-column:span 2;}
.mg-f{grid-row:span 2;}
.mg-g{}
.mg-h{}
.mg-i{grid-column:span 2;}
.mg-j{}

/* ═══════════════════ ШАБЛОН 07 — BESTIES ═══════════════════ */
.best-page{background:#fff;padding:30px 60px 60px;font-family:'Rubik',sans-serif;}
.best-title{font-family:'Rubik One','Inter',sans-serif;font-weight:900;font-size:110px;line-height:.95;text-transform:uppercase;color:#111;letter-spacing:-.02em;text-align:center;}
.best-title.t2,.best-title.t3{color:transparent;-webkit-text-stroke:3px #111;}
.best-title.t2{margin-top:-10px;}
.best-title.t3{margin-top:-10px;}
.best-grid{display:grid;grid-template-columns:repeat(3,1fr);grid-auto-rows:250px;gap:10px;margin-top:30px;}
.bg-item{background-size:cover;background-position:center;background-color:#f0ede8;}
.best-quote{margin-top:30px;font-family:'Rubik',sans-serif;font-size:18px;font-weight:700;text-align:center;text-transform:uppercase;line-height:1.4;letter-spacing:.02em;}

/* ═══════════════════ ШАБЛОН 08 — PHOTO GRID ═══════════════════ */
.pg-page{background:#fff;padding:40px;}
.pg-grid{display:grid;grid-template-columns:repeat(3,1fr);grid-auto-rows:250px;gap:12px;}
.pgi{background-size:cover;background-position:center;background-color:#f0ede8;border-radius:8px;}
.pgi.empty{background:#f0ede8;}

/* ═══════════════════ ШАБЛОН 09 — FAVOURITE ═══════════════════ */
.fav-page{background:#fff;padding:50px 60px;position:relative;font-family:'Modern No 20',serif;}
.fav-title{font-size:150px;font-weight:400;line-height:1;margin-bottom:30px;letter-spacing:-.01em;}
.fav-item{display:grid;grid-template-columns:70px 1fr;gap:30px;margin-bottom:20px;align-items:center;}
.fav-label{writing-mode:vertical-rl;transform:rotate(180deg);font-size:52px;font-weight:400;letter-spacing:.05em;text-align:center;text-transform:uppercase;}
.fav-photo{height:280px;background-size:cover;background-position:center;background-color:#f0ede8;border-radius:60px;}
.fav-photo.empty{background:#f0ede8;}

/* ═══════════════════ ШАБЛОН 10 — HER SONGS ═══════════════════ */
.hs-page{background:#292F23;color:#DDC795;position:relative;overflow:hidden;font-family:'Italiana','Playfair Display',serif;padding:60px;}
.hs-title{font-size:180px;line-height:1;position:absolute;top:40px;right:60px;}
.hs-subtitle{font-size:140px;line-height:1;position:absolute;bottom:60px;left:60px;letter-spacing:.05em;}
.hs-card{position:absolute;padding:24px 28px;background:#fff;color:#111;width:320px;box-shadow:0 12px 40px rgba(0,0,0,.3);}
.hs-card:nth-child(odd){background:#f5e8e4;}
.hs-song{font-size:20px;font-weight:600;line-height:1.3;margin-bottom:10px;}
.hs-artist{font-size:14px;opacity:.6;}
.hs-c1{top:180px;left:80px;transform:rotate(-4deg);}
.hs-c2{top:360px;right:150px;transform:rotate(5deg);}
.hs-c3{bottom:360px;left:150px;transform:rotate(-3deg);background:#8B9EB5!important;color:#fff;}
.hs-c4{bottom:180px;right:80px;transform:rotate(6deg);background:#6B8DB5!important;color:#fff;}

/* ═══════════════════ ШАБЛОН 11 — ANNA'S PLAYLIST ═══════════════════ */
.ap-page{background:#1a1a1a;position:relative;overflow:hidden;}
.ap-photo{position:absolute;inset:0;background-size:cover;background-position:center;}
.ap-photo.empty{background:#2a2a2a;}
.ap-title{position:absolute;top:50px;left:60px;z-index:5;color:#fff;}
.ap-name{font-family:'Italiana',serif;font-size:130px;font-weight:400;letter-spacing:.02em;display:inline-block;line-height:1;}
.ap-script{font-family:'Great Vibes',cursive;font-size:110px;color:#DDC795;margin-left:30px;display:inline-block;line-height:1;}
.ap-date{position:absolute;bottom:60px;right:60px;font-family:'Courier New',monospace;font-size:32px;color:#e85a3b;text-shadow:0 2px 12px rgba(0,0,0,.6);z-index:5;}

/* ═══════════════════ ШАБЛОН 12 — BIRTHDAY COVER ═══════════════════ */
.bc-page{background:#d8c8bc;position:relative;overflow:hidden;}
.bc-photo{position:absolute;inset:0;background-size:cover;background-position:center;}
.bc-photo.empty{background:#d8c8bc;}
.bc-title{position:absolute;bottom:130px;left:60px;font-family:'Modern No 20',serif;font-size:80px;font-weight:400;color:#fff;letter-spacing:.02em;text-shadow:0 2px 18px rgba(0,0,0,.3);z-index:5;}
.bc-script{position:absolute;bottom:40px;left:60px;font-family:'Petit Formal Script',cursive;font-size:32px;color:#fff;line-height:1.15;text-shadow:0 2px 14px rgba(0,0,0,.4);z-index:5;}

/* ═══════════════════ ШАБЛОН 13 — HER VIBE ═══════════════════ */
.hv-page{background:#fff;padding:50px 60px;font-family:'Playfair Display',serif;}
.hv-title{font-family:'Pinyon Script',cursive;font-size:140px;line-height:1;text-align:center;margin-bottom:30px;}
.hv-grid{display:grid;grid-template-columns:repeat(4,1fr);grid-auto-rows:220px;gap:12px;}
.hvi{background-size:cover;background-position:center;background-color:#f0ede8;}
.hvi.h1{grid-column:span 2;grid-row:span 2;}
.hvi.h2{}
.hvi.h3{}
.hvi.h4{grid-column:span 2;}
.hvi.h5{}
.hvi.h6{}
.hvi.h7{}
.hvi.h8{}

/* ═══════════════════ ШАБЛОН 14 — ТВОЯ ЛЮБОВЬ ═══════════════════ */
.tl-page{background:#000;color:#fff;position:relative;padding:40px;}
.tl-photo{position:absolute;background-size:cover;background-position:center;background-color:#222;}
.tl-p1{left:45px;top:40px;width:300px;height:420px;}
.tl-p2{left:45px;top:480px;width:280px;height:380px;}
.tl-p3{left:45px;bottom:60px;width:300px;height:400px;}
.tl-p4{left:390px;top:40px;width:470px;height:350px;}
.tl-p5{left:390px;bottom:60px;width:470px;height:350px;}
.tl-title{position:absolute;right:60px;top:400px;width:300px;font-family:'Modern No 20',serif;font-size:56px;line-height:1.05;font-weight:400;}
.tl-script{position:absolute;right:60px;bottom:200px;width:300px;font-family:'Caveat',cursive;font-size:38px;line-height:1.2;color:#E8D5B7;}

/* ═══════════════════ ШАБЛОН 15 — ZODIAC MAP ═══════════════════ */
.zm-page{background:#000;color:#fff;position:relative;padding:40px;font-family:'Playfair Display',serif;}
.zm-map{width:100%;height:600px;background-size:contain;background-position:center;background-repeat:no-repeat;margin-bottom:30px;}
.zm-map.empty{background:#111;border:1px solid #333;border-radius:50%;}
.zm-text{font-family:'Caveat',cursive;font-size:36px;line-height:1.4;text-align:center;padding:0 40px;}

/* ═══════════════════ ШАБЛОН 16 — ДЕТСТВО ═══════════════════ */
.dt-page{background:#fff;padding:60px 80px;font-family:'Playfair Display',serif;position:relative;}
.dt-script{font-family:'Great Vibes',cursive;font-size:180px;color:#D899C3;line-height:.9;letter-spacing:-.02em;}
.dt-line1{font-family:'Times New Roman',serif;font-size:130px;color:#D899C3;line-height:1;letter-spacing:.02em;}
.dt-line2{font-family:'Times New Roman',serif;font-size:130px;color:#D899C3;line-height:1;letter-spacing:.02em;position:relative;display:inline-block;}
.dt-heart{position:absolute;right:-200px;top:-30px;width:150px;height:130px;background-size:contain;background-repeat:no-repeat;background-position:center;display:inline-block;}
.dt-text{margin-top:60px;font-family:'Modern No 20',serif;font-size:20px;line-height:1.6;color:#111;max-width:640px;}

/* ═══════════════════ ШАБЛОН 17 — МАЛЕНЬКАЯ ═══════════════════ */
.mk-page{background:#fff;padding:40px;position:relative;font-family:'Playfair Display',serif;}
.mk-script{font-family:'Great Vibes',cursive;font-size:220px;color:#D899C3;line-height:.9;position:absolute;top:-40px;left:-80px;z-index:2;}
.mk-line{font-family:'Times New Roman',serif;font-size:180px;color:#D899C3;line-height:1;position:absolute;top:180px;left:-40px;z-index:1;}
.mk-photo{position:absolute;background-size:cover;background-position:center;background-color:#f0ede8;border-radius:8px;}
.mk-p1{right:80px;top:80px;width:340px;height:260px;}
.mk-p2{right:80px;top:380px;width:300px;height:400px;}
.mk-p3{right:430px;bottom:80px;width:280px;height:220px;}
.mk-p4{right:80px;bottom:80px;width:280px;height:280px;}

/* ═══════════════════ ШАБЛОН 18 — COLLAGE ROUNDED ═══════════════════ */
.cr-page{background:#fff;padding:40px;}
.cr-grid{display:grid;grid-template-columns:repeat(3,1fr);grid-auto-rows:230px;gap:16px;}
.cri{background-size:cover;background-position:center;background-color:#f0ede8;border-radius:50px;}
.cri.empty{background:#f0ede8;}
.cri.c1{grid-row:span 2;}
.cri.c5{grid-column:span 2;}
.cri.c8{grid-row:span 2;}
EOF

echo "✅ styles.css обновлён (13 шаблонов CSS)"
echo ""
echo "▬▬▬▬▬▬▬▬▬▬ ГОТОВО ▬▬▬▬▬▬▬▬▬▬"
echo "Теперь выполни:"
echo "  git add ."
echo "  git commit -m 'Add 13 new templates'"
echo "  git push"
