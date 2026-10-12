// АВТО-РЕЕСТР: все файлы templates/*.js подхватываются автоматически
const modules = import.meta.glob('./*.js', { eager: true });

export const TEMPLATES = Object.entries(modules)
  .filter(([path]) => !path.includes('registry.js'))
  .map(([, mod]) => mod.default)
  .filter(t => t && t.id && t.name && typeof t.render === 'function')
  .sort((a, b) => a.id.localeCompare(b.id));

export const getTemplate = id => TEMPLATES.find(t => t.id === id);
export const getCategories = () => ['Все', ...new Set(TEMPLATES.map(t => t.category).filter(Boolean))];
