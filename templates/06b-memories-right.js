export default {
  id: 'memories-right',
  name: 'Memories (правая)',
  category: 'Коллажи',
  fields: [
    {key:'word',label:'Слово (RIES)',type:'text'},
    {key:'photos',label:'Загрузить 7 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7']}
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
