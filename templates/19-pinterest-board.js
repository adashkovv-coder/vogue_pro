/* ============================================================
   ШАБЛОН 19 — PINTEREST BOARD
   Figma Frame 2669: 2481×3507 → A4 794×1123 (×0.32)
   Фото на абсолютных координатах — ничего не летает
   ============================================================ */
export default {
  id: 'pinterest-board',
  name: 'Pinterest доска',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок (жирный)',type:'text'},
    {key:'title2',label:'Заголовок 2-я строка',type:'text'},
    {key:'photos',label:'Загрузить 11 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10','photo11']}
  ],
  defaults: {
    title1:'Она, если была бы доской',
    title2:'на Pinterest',
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
      <div class="pin-item pin-1  ${e('photo1')}"  style="${p('photo1')}"></div>
      <div class="pin-item pin-2  ${e('photo2')}"  style="${p('photo2')}"></div>
      <div class="pin-item pin-3  ${e('photo3')}"  style="${p('photo3')}"></div>
      <div class="pin-item pin-4  ${e('photo4')}"  style="${p('photo4')}"></div>
      <div class="pin-item pin-5  ${e('photo5')}"  style="${p('photo5')}"></div>
      <div class="pin-item pin-6  ${e('photo6')}"  style="${p('photo6')}"></div>
      <div class="pin-item pin-7  ${e('photo7')}"  style="${p('photo7')}"></div>
      <div class="pin-item pin-8  ${e('photo8')}"  style="${p('photo8')}"></div>
      <div class="pin-item pin-9  ${e('photo9')}"  style="${p('photo9')}"></div>
      <div class="pin-item pin-10 ${e('photo10')}" style="${p('photo10')}"></div>
      <div class="pin-item pin-11 ${e('photo11')}" style="${p('photo11')}"></div>
    </div>`;
  }
};
