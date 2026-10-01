export default {
  id: 'collage-rounded',
  name: 'Коллаж (скруглённый)',
  category: 'Коллажи',
  fields: [
    {key:'photos',label:'Загрузить 10 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10']}
  ],
  defaults: {photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null,photo9:null,photo10:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page cr-page">
      <div class="cr-grid">
        ${[1,2,3,4,5,6,7,8,9,10].map(i => `<div class="cri c${i} ${e('photo'+i)}" style="${p('photo'+i)}"></div>`).join('')}
      </div>
    </div>`;
  }
};
