export default {
  id: 'her-vibe',
  name: 'Her Vibe',
  category: 'Коллажи',
  fields: [
    {key:'title',label:'Заголовок (скрипт)',type:'text'},
    {key:'photos',label:'Загрузить 8 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8']}
  ],
  defaults: {title:'Her vibe',photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null,photo7:null,photo8:null},
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page hv-page">
      <div class="hv-title">${c.title||''}</div>
      <div class="hv-grid">
        <div class="hvi h1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="hvi h2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="hvi h3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="hvi h4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="hvi h5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="hvi h6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="hvi h7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="hvi h8 ${e('photo8')}" style="${p('photo8')}"></div>
      </div>
    </div>`;
  }
};
