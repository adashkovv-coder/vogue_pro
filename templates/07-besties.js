/* ============================================================
   ШАБЛОН 07 — BESTIES
   Figma Frame 2714: 2481×3507 → A4 794×1123
   Шрифт: Rubik (Black / 900) — как "Rubik One"
   Обводка: -webkit-text-stroke
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
