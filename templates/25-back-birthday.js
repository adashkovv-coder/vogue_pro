/* ============================================================
   ШАБЛОН 25 — BACK BIRTHDAY (задняя обложка)
   Figma Frame 2678: 2481×3507 → A4 794×1123
   ============================================================ */
export default {
  id: 'back-birthday',
  name: 'Birthday (задник)',
  category: 'Задние обложки',
  fields: [
    {key:'photo',label:'Фото на фоне',type:'image'},
    {key:'title',label:'Заголовок (BIRTHDAY)',type:'text'},
    {key:'subtitle',label:'Подпись курсивом',type:'textarea'}
  ],
  defaults: {
    photo:null,
    title:'BIRTHDAY',
    subtitle:'the end of this magazine\nbut not the end of the story'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page back-bday-page">
      <div class="bb-photo ${e}" style="${p}"></div>
      <div class="bb-title">${c.title||''}</div>
      <div class="bb-subtitle">${(c.subtitle||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
