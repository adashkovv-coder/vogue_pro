export default {
  id: '02-example',
  name: 'Простой разворот',
  category: 'Развороты',
  fields: [
    { key: 'photo', type: 'photo',    label: 'Фото' },
    { key: 'title', type: 'text',     label: 'Заголовок' },
    { key: 'text',  type: 'textarea', label: 'Текст' },
  ],
  defaults: { title: 'Заголовок', text: 'Текст страницы...' },
  render(d) {
    const g = (k) => d[k] ?? this.defaults[k] ?? '';
    const photo = g('photo')
      ? `<img src="${g('photo')}" style="width:100%;height:100%;object-fit:cover;">`
      : `<div style="width:100%;height:100%;background:#f0ede8;display:flex;align-items:center;justify-content:center;color:#999;">Фото</div>`;
    return `
      <div class="tpl" style="width:794px;height:1123px;padding:60px;display:flex;flex-direction:column;gap:30px;background:#fff;">
        <div style="flex:1;overflow:hidden;border-radius:12px;">${photo}</div>
        <h1 style="font-family:'ModernNo20',serif;font-size:48px;font-weight:400;letter-spacing:2px;">${g('title')}</h1>
        <p style="font-family:'PetitFormalScript',cursive;font-size:24px;line-height:1.5;color:#333;">${(g('text')||'').replace(/\n/g,'<br>')}</p>
      </div>
    `;
  }
};
