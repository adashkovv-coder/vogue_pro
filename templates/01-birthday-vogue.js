const S = 0.32; // Figma 2481×3507 → A4 794×1123

export default {
  id: '01-birthday-vogue',
  name: 'Birthday Vogue',
  category: 'Обложки',
  fields: [
    { key: 'photo',  type: 'photo',    label: 'Фото на обложку' },
    { key: 'vogue',  type: 'text',     label: 'Заголовок (VOGUE)' },
    { key: 'name',   type: 'text',     label: 'Имя (вертикально)' },
    { key: 'word1',  type: 'text',     label: 'Слово 1 (Love)' },
    { key: 'word2',  type: 'text',     label: 'Слово 2 (Life)' },
    { key: 'script', type: 'text',     label: 'Курсив (Love)' },
    { key: 'quote1', type: 'textarea', label: 'Цитата левая' },
    { key: 'quote2', type: 'textarea', label: 'Цитата правая 1' },
    { key: 'quote3', type: 'textarea', label: 'Цитата правая 2' },
  ],
  defaults: {
    vogue: 'VOGUE',
    name: 'ULIANA',
    word1: 'Love',
    word2: 'Life',
    script: 'Love',
    quote1: 'If she loves, she loves with all her heart. She is loyal to her loved ones and will never betray them',
    quote2: "Love is her everything. And that's all we know about her",
    quote3: 'Her life is an ocean filled with love, care, and happiness.',
  },
  render(d) {
    const g = (k) => d[k] ?? this.defaults[k] ?? '';
    const photo = g('photo')
      ? `background-image:url('${g('photo')}');background-size:cover;background-position:center;`
      : 'background:#e8e5e0;';

    return `
      <div class="tpl" style="width:794px;height:1123px;position:relative;overflow:hidden;background:#000;">
        <div style="position:absolute;inset:0;${photo}"></div>
        <div style="position:absolute;inset:0;background:rgba(0,0,0,.25);"></div>

        <div style="position:absolute;left:${22*S}px;top:${14*S}px;color:#F4F4F4;font-family:'ModernNo20',serif;font-size:${700*S}px;line-height:1;white-space:nowrap;pointer-events:none;">${g('vogue')}</div>

        <div style="position:absolute;left:${16*S}px;top:${1030*S}px;transform:rotate(-90deg);transform-origin:top left;color:#fff;font-family:'ModernNo20',serif;font-size:${300*S}px;line-height:1;white-space:nowrap;">${g('name')}</div>

        <div style="position:absolute;left:${642*S}px;top:${338*S}px;color:#fff;font-family:'ModernNo20',serif;font-size:${140*S}px;line-height:1;">${g('word1')}</div>
        <div style="position:absolute;left:${642*S}px;top:${520*S}px;color:#fff;font-family:'ModernNo20',serif;font-size:${140*S}px;line-height:1;">${g('word2')}</div>

        <div style="position:absolute;left:${214*S}px;top:${111*S}px;color:#fff;font-family:'PetitFormalScript',cursive;font-size:${80*S}px;line-height:1;">${g('script')}</div>

        <div style="position:absolute;left:${16*S}px;top:${542*S}px;width:${610*S}px;color:#fff;font-family:'PetitFormalScript',cursive;font-size:${60*S}px;line-height:1.3;">${(g('quote1') || '').replace(/\n/g, '<br>')}</div>
        <div style="position:absolute;left:${589*S}px;top:${403*S}px;width:${610*S}px;color:#fff;font-family:'PetitFormalScript',cursive;font-size:${60*S}px;line-height:1.3;">${(g('quote2') || '').replace(/\n/g, '<br>')}</div>
        <div style="position:absolute;left:${589*S}px;top:${585*S}px;width:${610*S}px;color:#fff;font-family:'PetitFormalScript',cursive;font-size:${60*S}px;line-height:1.3;">${(g('quote3') || '').replace(/\n/g, '<br>')}</div>
      </div>
    `;
  }
};
