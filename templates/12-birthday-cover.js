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
