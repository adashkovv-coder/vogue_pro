/* ============================================================
   РЕЕСТР ВСЕХ ШАБЛОНОВ
   ============================================================ */

import t01 from './01-birthday-vogue.js';
import t02 from './02-whos-that-girl.js';
import t03 from './04-to-friend.js';
import t04 from './05-love-quote.js';

export const TEMPLATES = [
  t01,
  t02,
  t03,
  t04,
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
