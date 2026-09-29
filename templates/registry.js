/* ============================================================
   РЕЕСТР ВСЕХ ШАБЛОНОВ
   ============================================================
   Чтобы добавить шаблон:
   1. Создай файл templates/NN-имя.js (по образцу _template.js)
   2. Раскомментируй строку import ниже и подставь имя файла
   3. Добавь переменную в массив TEMPLATES
   ============================================================ */

// import t01 from './01-cover-vogue.js';
// import t02 from './02-birthday-vogue.js';
// import t03 from './03-whos-that-girl.js';
// import t04 from './04-libra-zodiac.js';

export const TEMPLATES = [
  // t01,
  // t02,
  // t03,
  // t04,
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
