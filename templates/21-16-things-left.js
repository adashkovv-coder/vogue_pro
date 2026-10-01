export default {
  id: 'sixteen-things-left',
  name: '16 вещей (левая)',
  category: 'Текст',
  fields: [
    {key:'script',label:'Скрипт-заголовок',type:'text'},
    {key:'line1',label:'Строка 1',type:'text'},
    {key:'line2accent',label:'Строка 2 (акцент)',type:'text'},
    {key:'line3',label:'Строка 3',type:'text'},
    {key:'photo',label:'Фото (правая часть)',type:'image'},
    {key:'bow',label:'Бантик (PNG)',type:'image'},
    {key:'text1',label:'Пункт 1',type:'textarea'},
    {key:'text2',label:'Пункт 2',type:'textarea'},
    {key:'text3',label:'Пункт 3',type:'textarea'},
    {key:'text4',label:'Пункт 4',type:'textarea'},
    {key:'text5',label:'Пункт 5',type:'textarea'},
    {key:'text6',label:'Пункт 6',type:'textarea'},
    {key:'text7',label:'Пункт 7',type:'textarea'}
  ],
  defaults: {
    script:'16 вещей,',line1:'КОТОРЫЕ Я',line2accent:'ЛЮБЛЮ',line3:'в ней',
    photo:null,bow:null,
    text1:'1. я люблю тебя за твою заботу о близких, так как ты их не оставляешь в беде.',
    text2:'2. я знаю, как ты стараешься помочь мне в чем-то, поддержать, за это я тебя очень ценю, спасибо тебе.',
    text3:'3. я люблю тебя за твою правду, ведь ты всегда помогаешь снять розовые очки, когда я чего-то не вижу.',
    text4:'4. я знаю, что тебе трудно открываться людям, доверять, но я так благодарна что ты делишься со мной своими переживаниями.',
    text5:'5. я люблю тебя за то, что ты всегда на моей стороне, даже если я не права, я знаю что ты объяснишь мне в чем моя неправота.',
    text6:'6. я знаю и понимаю насколько тебе бывает тяжело и я хочу разделять эти трудности вместе с тобой, ты супер сильная, за это я тебя и люблю.',
    text7:'7. я люблю в тебе искренность, доброту и заботливость, которой ты делишься в самые нужные этапы в моей жизни.'
  },
  render(c, no){
    const ph = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    const bow = c.bow ? `<img class="st-bow" src="${c.bow}" alt="">` : '';
    return `<div class="page st-page">
      <div class="st-header">
        <div class="st-script">${c.script||''}</div>
        <div class="st-line1">${c.line1||''}<span class="st-accent"> ${c.line2accent||''}</span></div>
        <div class="st-line3">${c.line3||''}</div>
      </div>
      <div class="st-photo ${e}" style="${ph}"></div>
      ${bow}
      <div class="st-text st-t1">${(c.text1||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t2">${(c.text2||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t3">${(c.text3||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t4">${(c.text4||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t5">${(c.text5||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t6">${(c.text6||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text st-t7">${(c.text7||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
