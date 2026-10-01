/* ============================================================
   ШАБЛОН 05 — TO FRIEND (Письмо подруге)
   Типографическая страница: фото + рукописные вставки + жирный акцент
   Координаты из Figma (2481×3507) × 0.32 → A4 (794×1123)
   ============================================================ */

export default {
  id: 'to-friend',
  name: 'Письмо подруге',
  category: 'Развороты',
  fields: [
    { key: 'photo',    label: 'Фото (левая часть)',    type: 'image' },
    { key: 'topText',  label: 'Верхний текст (курсив)', type: 'textarea' },
    { key: 'word1',    label: 'Слово 1 (ТЫ)',           type: 'text' },
    { key: 'word2',    label: 'Слово 2 (ПАХНЕШЬ)',      type: 'text' },
    { key: 'script1',  label: 'Рукописное 1 (Как)',     type: 'text' },
    { key: 'script2',  label: 'Рукописное 2 (счастье)', type: 'text' },
    { key: 'script3',  label: 'Рукописное 3 (первого взгляда)', type: 'text' },
    { key: 'word3',    label: 'Слово 3 (КАК)',          type: 'text' },
    { key: 'word4',    label: 'Слово 4 (ЛЮБОВЬ)',       type: 'text' }
  ],
  defaults: {
    photo: null,
    topText: 'С каждым днем я понимаю что выбрала правильную подругу-тебя. Я люблю тебя, спасибо, что мы когда то стали ближе общаться и теперь дружим. Ты для меня всегда отдельный занимаешь уголок в сердечке',
    word1: 'ТЫ',
    word2: 'ПАХНЕШЬ',
    script1: 'Как',
    script2: 'счастье',
    script3: 'первого взгляда',
    word3: 'КАК',
    word4: 'ЛЮБОВЬ'
  },
  render(c, no) {
    const photo = c.photo ? `background-image:url('${c.photo}')` : '';
    const photoCls = c.photo ? '' : 'empty';
    const photoMsg = c.photo ? '' : '<span>Фото</span>';

    return `
      <div class="page to-friend">
        <div class="tf-top">${(c.topText || '').replace(/\n/g, '<br>')}</div>

        <div class="tf-photo ${photoCls}" style="${photo}">${photoMsg}</div>

        <div class="tf-typography">
          <div class="tf-word">${c.word1 || ''}</div>
          <div class="tf-word">${c.word2 || ''}</div>
          <div class="tf-script-row">
            <span class="tf-script tf-script--small">${c.script1 || ''}</span>
            <span class="tf-script tf-script--big">${c.script2 || ''}</span>
          </div>
          <div class="tf-script tf-script--tiny">${c.script3 || ''}</div>
          <div class="tf-word tf-word--mt">${c.word3 || ''}</div>
          <div class="tf-word">${c.word4 || ''}</div>
        </div>
      </div>
    `;
  }
};
