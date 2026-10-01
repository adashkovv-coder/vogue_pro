export default {
  id: 'detstvo',
  name: 'Детство',
  category: 'Текст',
  fields: [
    {key:'script',label:'Скрипт-заголовок',type:'text'},
    {key:'line1',label:'Строка 1',type:'text'},
    {key:'line2',label:'Строка 2',type:'text'},
    {key:'photo',label:'Фото (сердечко)',type:'image'},
    {key:'text',label:'Текст снизу',type:'textarea'}
  ],
  defaults: {
    script:'детство.',line1:'МАЛЕНЬКАЯ',line2:'ТЫ.',
    photo:null,
    text:'Детство — это время, когда мир кажется огромным и полным чудес. Просыпаешься рано, едва солнце заглядывает в окно, и сразу хочется бежать во двор — играть с друзьями в прятки или гонять мяч. Каждый день — новое приключение.'
  },
  render(c, no){
    const p = c.photo ? `background-image:url('${c.photo}')` : '';
    const e = c.photo ? '' : 'empty';
    return `<div class="page dt-page">
      <div class="dt-script">${c.script||''}</div>
      <div class="dt-line1">${c.line1||''}</div>
      <div class="dt-line2">${c.line2||''}<span class="dt-heart ${e}" style="${p}"></span></div>
      <div class="dt-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
