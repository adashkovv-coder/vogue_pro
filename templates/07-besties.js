/* ============================================================
   ШАБЛОН 07 — BESTIES (v4)
   Более крупные буквы, тонкий скрибл-эффект, отступы у фото
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

    const svgFilter = `
      <svg width="0" height="0" style="position:absolute">
        <defs>
          <filter id="scribbleA" x="-10%" y="-10%" width="120%" height="120%">
            <feTurbulence type="fractalNoise" baseFrequency="0.018" numOctaves="1" seed="2" result="t1"/>
            <feDisplacementMap in="SourceGraphic" in2="t1" scale="2.2" xChannelSelector="R" yChannelSelector="G"/>
          </filter>
          <filter id="scribbleB" x="-10%" y="-10%" width="120%" height="120%">
            <feTurbulence type="fractalNoise" baseFrequency="0.022" numOctaves="1" seed="5" result="t2"/>
            <feDisplacementMap in="SourceGraphic" in2="t2" scale="2.6" xChannelSelector="R" yChannelSelector="G"/>
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
