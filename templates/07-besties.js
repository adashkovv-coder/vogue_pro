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
