export default {
  id: 'zodiac-map',
  name: 'Зодиак · карта',
  category: 'Зодиак',
  fields: [
    {key:'starMap',label:'Карта звёзд (PNG)',type:'image'},
    {key:'text',label:'Текст под картой',type:'textarea'}
  ],
  defaults: {
    starMap:null,
    text:'Девушка-Весы — это сочетание нежности, красоты и внутренней силы. Она ценит гармонию, умеет находить общий язык с людьми и старается видеть прекрасное даже в мелочах.'
  },
  render(c, no){
    const p = c.starMap ? `background-image:url('${c.starMap}')` : '';
    const e = c.starMap ? '' : 'empty';
    return `<div class="page zm-page">
      <div class="zm-map ${e}" style="${p}"></div>
      <div class="zm-text">${(c.text||'').replace(/\n/g,'<br>')}</div>
    </div>`;
  }
};
