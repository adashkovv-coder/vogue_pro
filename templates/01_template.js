/* ============================================================
   ШАБЛОН-ЗАГОТОВКА
   Скопируй → назови NN-имя.js → заполни → добавь в registry.js
   ============================================================ */

export default {
  id: 'my-template',              // ← уникальный ID (латиница, дефисы)
  name: 'Название шаблона',       // ← отображается в галерее
  category: 'Обложки',            // ← Обложки / Развороты / Фото / Текст / Зодиак
  fields: [
    { key:'photo', label:'Фото',             type:'image' },
    { key:'title', label:'Заголовок',        type:'text' },
    { key:'text',  label:'Текст',            type:'textarea' }
  ],
  defaults: {
    photo: null,
    title: 'Заголовок',
    text:  'Описание'
  },
  render(c, no){
    const photo = c.photo ? `background-image:url('${c.photo}')` : '';
    return `
      <div class="page">
        <div class="photo-full ${c.photo?'':'empty'}"
             style="${photo}">
          ${c.photo?'':'<span>Фото</span>'}
        </div>
        <div class="text-tl">${c.title || ''}</div>
        <div class="text-bl">${c.text || ''}</div>
        <div class="folio"><span>Vogue</span><span>${no}</span></div>
      </div>
    `;
  }
};
