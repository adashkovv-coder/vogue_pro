export default {
  id: 'malenkaya',
  name: 'Маленькая (продолжение)',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'}
  ],
  defaults: {photo1:null,photo2:null,photo3:null,photo4:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mk-page">
      <div class="mk-script">тво</div>
      <div class="mk-line">НЬКАЯ</div>
      <div class="mk-photo mk-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="mk-photo mk-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="mk-photo mk-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="mk-photo mk-p4 ${e('photo4')}" style="${p('photo4')}"></div>
    </div>`;
  }
};
