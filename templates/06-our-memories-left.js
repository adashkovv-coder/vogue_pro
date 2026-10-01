export default {
  id: 'our-memories-left',
  name: 'Our Memories (левая)',
  category: 'Коллажи',
  fields: [
    {key:'word1',label:'Слово курсивом (OUR)',type:'text'},
    {key:'word2',label:'Слово основное (MEMO…)',type:'text'},
    {key:'photos',label:'Загрузить 9 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9']}
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
