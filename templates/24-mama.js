export default {
  id: 'mama-heart',
  name: 'Мама (сердечко)',
  category: 'Коллажи',
  fields: [
    {key:'script1',label:'Надпись слева (курсив)',type:'text'},
    {key:'script2',label:'Надпись справа (курсив)',type:'text'},
    {key:'title',label:'Заголовок',type:'text'},
    {key:'photo1',label:'Фото 1 (большое)',type:'image'},
    {key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},
    {key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},
    {key:'photo6',label:'Фото 6',type:'image'},
    {key:'photo7',label:'Фото 7',type:'image'},
    {key:'photo8',label:'Фото 8',type:'image'},
    {key:'photo9',label:'Фото 9',type:'image'},
    {key:'photo10',label:'Фото 10',type:'image'},
    {key:'text',label:'Поздравление',type:'textarea'},
    {key:'sign',label:'Подпись (курсив)',type:'text'}
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
        <div class="mh mh-1 ${e('photo1')}" style="${p('photo1')}"></div>
        <div class="mh mh-2 ${e('photo2')}" style="${p('photo2')}"></div>
        <div class="mh mh-3 ${e('photo3')}" style="${p('photo3')}"></div>
        <div class="mh mh-4 ${e('photo4')}" style="${p('photo4')}"></div>
        <div class="mh mh-5 ${e('photo5')}" style="${p('photo5')}"></div>
        <div class="mh mh-6 ${e('photo6')}" style="${p('photo6')}"></div>
        <div class="mh mh-7 ${e('photo7')}" style="${p('photo7')}"></div>
        <div class="mh mh-8 ${e('photo8')}" style="${p('photo8')}"></div>
        <div class="mh mh-9 ${e('photo9')}" style="${p('photo9')}"></div>
        <div class="mh mh-10 ${e('photo10')}" style="${p('photo10')}"></div>
      </div>

      <div class="mama-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
      <div class="mama-sign">${c.sign||''}</div>
    </div>`;
  }
};
