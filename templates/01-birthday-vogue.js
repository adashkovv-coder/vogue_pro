/* ============================================================
   ШАБЛОН 01 — BIRTHDAY VOGUE
   Координаты из Figma (2481×3507) пересчитаны в A4 (794×1123).
   Коэффициент: 794/2481 ≈ 0.32
   ============================================================ */

export default {
  id: 'birthday-vogue',
  name: 'Birthday Vogue',
  category: 'Обложки',
  fields: [
    { key:'photo',      label:'Фото обложки',                type:'image' },
    { key:'t1',         label:'BIRTHDAY (сверху)',           type:'text' },
    { key:'t2',         label:'VOGUE (справа)',              type:'text' },
    { key:'scriptTop',  label:'Скрипт под BIRTHDAY',         type:'textarea' },
    { key:'num',        label:'Число (возраст)',             type:'text' },
    { key:'sp1',        label:'special (правая колонка)',    type:'text' },
    { key:'sp2',        label:'edition (правая колонка)',    type:'text' },
    { key:'rightNote',  label:'THE BIRTHDAY OF THE MOST…',   type:'textarea' },
    { key:'rightScript',label:'For the most beloved',        type:'textarea' },
    { key:'name',       label:'Имя (внизу)',                 type:'text' },
    { key:'tagline',    label:'Tagline (курсив)',            type:'text' }
  ],
  defaults: {
    photo:null,
    t1:'BIRTHDAY',
    t2:'VOGUE',
    scriptTop:'happy birthday irina! 20 never looked so good!',
    num:'20',
    sp1:'special',
    sp2:'edition',
    rightNote:'THE BIRTHDAY OF THE MOST BEAUTIFUL',
    rightScript:'For the most\nbeloved',
    name:'IRINA',
    tagline:'beautiful, sweet and attractive'
  },
  render(c, no){
    const photo = c.photo ? `background-image:url('${c.photo}')` : '';
    const emptyCls = c.photo ? '' : 'empty';
    const emptyMsg = c.photo ? '' : '<span>Фото</span>';
    return `
      <div class="page bday-vogue">
        <div class="bday-photo ${emptyCls}" style="${photo}">${emptyMsg}</div>

        <div class="bday-t1">${(c.t1||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-t2">${(c.t2||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-script-top">${(c.scriptTop||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-num">${(c.num||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-sp1">${(c.sp1||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-sp2">${(c.sp2||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-right-note">${(c.rightNote||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-right-script">${(c.rightScript||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-name">${(c.name||'').replace(/\n/g,'<br>')}</div>
        <div class="bday-tagline">${(c.tagline||'').replace(/\n/g,'<br>')}</div>
      </div>
    `;
  }
};
