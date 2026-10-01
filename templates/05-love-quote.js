/* ============================================================
   ШАБЛОН 05 — LOVE QUOTE
   Фиксированная картинка на весь A4. Дизайн из Figma.
   Источник: assets/love.png
   ============================================================ */

export default {
  id: 'love-quote',
  name: 'Love Quote',
  category: 'Цитаты',
  fields: [],           // нет редактируемых полей — дизайн фиксирован
  defaults: {},
  render(c, no){
    return `<div class="page love-quote">
      <img class="lq-image" src="assets/love.png" alt="">
    </div>`;
  }
};
