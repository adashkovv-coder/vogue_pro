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
