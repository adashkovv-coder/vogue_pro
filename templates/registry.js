import t01 from './01-birthday-vogue.js';
import t02 from './02-whos-that-girl.js';
import t03 from './04-to-friend.js';
import t04 from './05-love-quote.js';
import t05 from './06-our-memories-left.js';
import t06 from './06b-memories-right.js';
import t07 from './07-besties.js';
import t08 from './08-photo-grid.js';
import t09 from './09-favourite.js';
import t10 from './10-her-songs.js';
import t11 from './11-annas-playlist.js';
import t12 from './12-birthday-cover.js';
import t13 from './13-her-vibe.js';
import t14 from './14-tvoya-lyubov.js';
import t15 from './15-zodiac-map.js';
import t16 from './16-detstvo.js';
import t17 from './17-malenkaya.js';
import t18 from './18-collage-rounded.js';

export const TEMPLATES = [
  t01, t02, t03, t04, t05, t06, t07, t08,
  t09, t10, t11, t12, t13, t14, t15, t16, t17, t18
];

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category))];
