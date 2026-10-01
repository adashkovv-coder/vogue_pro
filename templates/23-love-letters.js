export default {
  id: 'love-letters',
  name: 'LOVE (буквы)',
  category: 'Коллажи',
  fields: [
    {key:'photos',label:'Загрузить 3 фото',type:'photos',
      slots:['photo1','photo2','photo3']}
  ],
  defaults: {photo1:null,photo2:null,photo3:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page love-letters-page">
      <div class="ll-photo ll-p1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="ll-photo ll-p2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="ll-photo ll-p3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="ll-word"><span>L</span><span>O</span><span>V</span><span>E</span></div>
    </div>`;
  }
};
