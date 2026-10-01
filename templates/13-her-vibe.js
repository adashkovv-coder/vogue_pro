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
