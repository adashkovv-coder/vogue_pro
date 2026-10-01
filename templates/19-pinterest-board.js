export default {
  id: 'pinterest-board',
  name: 'Pinterest доска',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок строка 1 (жирный)',type:'text'},
    {key:'title2',label:'Заголовок строка 2',type:'text'},
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},{key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},{key:'photo10',label:'Фото 10',type:'image'},
    {key:'photo11',label:'Фото 11',type:'image'}
  ],
  defaults: {
    title1:'Она, если была бы доской',title2:'на Pinterest',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,
    photo7:null,photo8:null,photo9:null,photo10:null,photo11:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page pinterest-page">
      <div class="pin-title">
        <div class="pin-title-bold">${c.title1||''}</div>
        <div class="pin-title-line">${c.title2||''}</div>
      </div>
      <div class="pin-grid">
        <div class="pin-item pin-1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="pin-item pin-2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="pin-item pin-3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="pin-item pin-4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="pin-item pin-5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="pin-item pin-6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="pin-item pin-7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="pin-item pin-8 ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="pin-item pin-9 ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="pin-item pin-10 ${e('photo10')}" style="${p('photo10')}"></div>
        <div class="pin-item pin-11 ${e('photo11')}" style="${p('photo11')}"></div>
      </div>
    </div>`;
  }
};
