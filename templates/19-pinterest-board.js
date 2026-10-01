export default {
  id: 'pinterest-board',
  name: 'Pinterest доска',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок строка 1',type:'text'},
    {key:'title2',label:'Заголовок строка 2',type:'text'},
    {key:'photos',label:'Загрузить 11 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10','photo11']}
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
        ${[1,2,3,4,5,6,7,8,9,10,11].map(i => `<div class="pin-item pin-${i} ${e('photo'+i)}" style="${p('photo'+i)}"></div>`).join('')}
      </div>
    </div>`;
  }
};
