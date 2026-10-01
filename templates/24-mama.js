export default {
  id: 'mama-heart',
  name: 'Мама (сердечко)',
  category: 'Коллажи',
  fields: [
    {key:'script1',label:'Надпись слева',type:'text'},
    {key:'script2',label:'Надпись справа',type:'text'},
    {key:'title',label:'Заголовок',type:'text'},
    {key:'photos',label:'Загрузить 10 фото',type:'photos',
      slots:['photo1','photo2','photo3','photo4','photo5','photo6','photo7','photo8','photo9','photo10']},
    {key:'text',label:'Поздравление',type:'textarea'},
    {key:'sign',label:'Подпись',type:'text'}
  ],
  defaults: {
    script1:'лучшая',script2:'на свете',title:'Мама',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,
    photo6:null,photo7:null,photo8:null,photo9:null,photo10:null,
    text:'Пусть жизнь дарит тебе столько же тепла\nсколько ты подарила мне\nТы - мое самое большое счастье!',
    sign:'С любовью, твоя доченька'
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page mama-page">
      <div class="mama-script1">${c.script1||''}</div>
      <div class="mama-script2">${c.script2||''}</div>
      <div class="mama-title">${c.title||''}</div>
      <div class="mama-heart">
        ${[1,2,3,4,5,6,7,8,9,10].map(i => `<div class="mh mh-${i} ${e('photo'+i)}" style="${p('photo'+i)}"></div>`).join('')}
      </div>
      <div class="mama-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
      <div class="mama-sign">${c.sign||''}</div>
    </div>`;
  }
};
