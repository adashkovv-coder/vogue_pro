export default {
  id: 'tvoya-lyubov',
  name: 'Твоя любовь',
  category: 'Текст',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'title',label:'Заголовок',type:'textarea'},
    {key:'script',label:'Скрипт (курсив)',type:'textarea'}
  ],
  defaults: {
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,
    title:'Твоя любовь это так красиво',
    script:'твоя любовь\nвозвращала в детство,\nдарила все, чего не хватало'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page tl-page">
      <div class="tl-photo tl-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="tl-photo tl-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="tl-photo tl-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="tl-photo tl-p4 ${e('photo4')}" style="${p('photo4')}"></div>
      <div class="tl-photo tl-p5 ${e('photo5')}" style="${p('photo5')}"></div>
      <div class="tl-title">${(c.title||'').replace(/\n/g,'<br>')}</div>
      <div class="tl-script">${(c.script||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
