export default {
  id: 'sixteen-things-right',
  name: '16 вещей (правая)',
  category: 'Текст',
  fields: [
    {key:'photo',label:'Фото (верх справа)',type:'image'},
    {key:'bow',label:'Бантик (PNG)',type:'image'},
    {key:'text8',label:'Пункт 8',type:'textarea'},
    {key:'text9',label:'Пункт 9',type:'textarea'},
    {key:'text10',label:'Пункт 10',type:'textarea'},
    {key:'text11',label:'Пункт 11',type:'textarea'},
    {key:'text12',label:'Пункт 12',type:'textarea'},
    {key:'text13',label:'Пункт 13',type:'textarea'},
    {key:'text14',label:'Пункт 14',type:'textarea'},
    {key:'text15',label:'Пункт 15',type:'textarea'},
    {key:'text16',label:'Пункт 16',type:'textarea'}
  ],
  defaults: {
    photo:null,bow:null,
    text8:'8. я люблю тебя за то, как ты любишь — безусловно, целиком, без оговорок «но». Не за что-то, а несмотря ни на что. Так, как любят в книгах, только по-настоящему.',
    text9:'9. я люблю тебя за твою честность — ты не говоришь того, чего не думаешь, и не молчишь, когда важно сказать. Бывает, твои слова ранят, но за ними нет зла, только желание, чтобы между нами не было стен.',
    text10:'10. я люблю тебя за то, что ты умеешь смеяться над собой. Ты не превращаешь ошибку в драму, а провал — в трагедию. Рядом с тобой становится легче быть неидеальным.',
    text11:'11. я люблю тебя за твою способность начинать заново — после неудачи, после дня, когда всё пошло не так. Ты плачешь, злишься, падаешь — а потом встаёшь, завариваешь чай и говоришь: «Ладно. Попробуем ещё раз.»',
    text12:'12. я люблю тебя за твою нежность — в незаметных жестах. В том, как ты накрываешь мою руку своей, когда чувствуешь, что мне тревожно.',
    text13:'13. я люблю тебя за то, как ты видишь мир — не чёрно-белым, не упрощённым, а живым. Ты замечаешь красоту там, где другие проходят мимо.',
    text14:'14. я люблю тебя за твой ум — живой, тёплый, любопытный. Ты задаёшь вопросы, на которые другие не догадываются спросить.',
    text15:'15. я люблю тебя за твоё упрямство — да, именно за него. Ты не сдаёшься, когда важно, стоишь на своём не из гордости, а из принципов.',
    text16:'16. и вообще я люблю в тебе все, абсолютно всё и всегда буду на твоей стороне, знай это, ведь если бы не ты, где бы я нашла подругу лучше.'
  },
  render(c, no){
    const ph = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    const bow = c.bow ? `<img class="st-bow st-bow--right" src="${c.bow}" alt="">` : '';
    return `<div class="page st-page st-page--right">
      <div class="st-photo st-photo--right ${e}" style="${ph}"></div>
      ${bow}
      <div class="st-text sr-t8">${(c.text8||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t9">${(c.text9||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t10">${(c.text10||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t11">${(c.text11||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t12">${(c.text12||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t13">${(c.text13||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t14">${(c.text14||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t15">${(c.text15||'').replace(/\n/g,'<br>')}</div>
      <div class="st-text sr-t16">${(c.text16||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
