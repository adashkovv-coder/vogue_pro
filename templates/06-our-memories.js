export default {
  id: 'our-memories',
  name: 'Our Memories',
  category: 'Коллажи',
  fields: [
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},{key:'photo10',label:'Фото 10',type:'image'},
    {key:'title1',label:'Надпись (курсив)',type:'text'},
    {key:'title2',label:'Заголовок (крупно)',type:'text'}
  ],
  defaults: {
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null,photo9:null,photo10:null,
    title1:'OUR',title2:'MEMORIES'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mem-page">
      <div class="mem-title"><span class="mt-script">${c.title1||''}</span><span class="mt-serif">${c.title2||''}</span></div>
      <div class="mem-grid">
        <div class="mg-item mg-a ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mg-item mg-b ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mg-item mg-c ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mg-item mg-d ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mg-item mg-e ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mg-item mg-f ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mg-item mg-g ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="mg-item mg-h ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="mg-item mg-i ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="mg-item mg-j ${e('photo10')}" style="${p('photo10')}"></div>
      </div>
    </div>`;
  }
};
