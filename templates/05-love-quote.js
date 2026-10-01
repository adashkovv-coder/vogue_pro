/* ============================================================
   ШАБЛОН 05 — LOVE QUOTE
   Типографическая страница с надписью "ЛЮБОВЬ" и цитатой.
   Координаты пересчитаны из Figma (2481×3507) в A4 (794×1123).
   ============================================================ */

export default {
  id: 'love-quote',
  name: 'Love Quote',
  category: 'Цитаты',
  fields: [
    { key: 'love_part1', label: 'Часть 1 (ЛЮБ)', type: 'text' },
    { key: 'love_part2', label: 'Часть 2 (БО)', type: 'text' },
    { key: 'love_part3', label: 'Часть 3 (ВЬ)', type: 'text' },
    { key: 'quote', label: 'Цитата', type: 'textarea' }
  ],
  defaults: {
    love_part1: 'ЛЮБ',
    love_part2: 'БО',
    love_part3: 'ВЬ',
    quote: 'Не красота вызывает любовь, а любовь заставляет видеть красоту.'
  },
  render(c, no) {
    return `
      <div class="page love-quote">
        <div class="lq-text lq-text--1">${c.love_part1 || ''}</div>
        <div class="lq-text lq-text--2">${c.love_part2 || ''}</div>
        <div class="lq-text lq-text--3">${c.love_part3 || ''}</div>
        <div class="lq-quote">${c.quote || ''}</div>
      </div>
    `;
  }
};
