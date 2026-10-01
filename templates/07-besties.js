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
