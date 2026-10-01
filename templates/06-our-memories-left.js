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
