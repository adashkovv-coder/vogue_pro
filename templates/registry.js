/* ============================================================
   РЕЕСТР ВСЕХ ШАБЛОНОВ
   ============================================================
   Чтобы добавить новый шаблон:
   1. Создай файл templates/NN-имя.js по образцу _template.js
   2. Добавь строку import ниже
   3. Добавь переменную в массив TEMPLATES
   ============================================================ */

import t01 from './01-birthday-vogue.js';

// ⬇️ Импортируй новые здесь, по мере готовности
// import t02 from './02-....js';
// import t03 from './03-....js';

export const TEMPLATES = [
  t01,
  // ⬇️ И добавляй их сюда
  // t02, t03,
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
