export default {
  id: 'annas-playlist',
  name: "Anna's Playlist",
  category: 'Обложки',
  fields: [
    {key:'photo',label:'Фото на фоне',type:'image'},
    {key:'name',label:'Имя',type:'text'},
    {key:'script',label:'Надпись курсивом',type:'text'},
    {key:'date',label:'Дата/время',type:'text'}
  ],
  defaults: {
    photo:null,name:"ANNA'S",script:'Playlist',date:'06.30.2026 19:27'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page ap-page">
      <div class="ap-photo ${e}" style="${p}"></div>
      <div class="ap-title"><span class="ap-name">${c.name||''}</span><span class="ap-script">${c.script||''}</span></div>
      <div class="ap-date">${c.date||''}</div>
    </div>`;
  }
};
