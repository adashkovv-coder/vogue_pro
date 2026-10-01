export default {
  id: 'friendship-years',
  name: 'Дружба сквозь года',
  category: 'Коллажи',
  fields: [
    {key:'title1',label:'Заголовок строка 1',type:'text'},
    {key:'title2',label:'Заголовок строка 2',type:'text'},
    {key:'year1',label:'Год 1',type:'text'},{key:'year2',label:'Год 2',type:'text'},
    {key:'year3',label:'Год 3',type:'text'},{key:'year4',label:'Год 4',type:'text'},
    {key:'year5',label:'Год 5',type:'text'},{key:'year6',label:'Год 6',type:'text'},
    {key:'year7',label:'Год 7',type:'text'},
    {key:'photo1',label:'Фото 1',type:'image'},{key:'photo2',label:'Фото 2',type:'image'},
    {key:'photo3',label:'Фото 3',type:'image'},{key:'photo4',label:'Фото 4',type:'image'},
    {key:'photo5',label:'Фото 5',type:'image'},{key:'photo6',label:'Фото 6',type:'image'}
  ],
  defaults: {
    title1:'Наша дружба',title2:'сквозь года',
    year1:'2020',year2:'2021',year3:'2022',year4:'2023',year5:'2024',year6:'2025',year7:'2026',
    photo1:null,photo2:null,photo3:null,photo4:null,photo5:null,photo6:null
  },
  render(c, no){
    const p = k => c[k] ? `background-image:url('${c[k]}')` : '';
    const e = k => c[k] ? '' : 'empty';
    return `<div class="page friendship-page">
      <div class="fr-title">${c.title1||''}</div>
      <div class="fr-subtitle">${c.title2||''}</div>
      <div class="fr-item fr-i1 ${e('photo1')}" style="${p('photo1')}"></div>
      <div class="fr-year fr-y1">${c.year1||''}</div>
      <div class="fr-item fr-i2 ${e('photo2')}" style="${p('photo2')}"></div>
      <div class="fr-year fr-y2">${c.year2||''}</div>
      <div class="fr-item fr-i3 ${e('photo3')}" style="${p('photo3')}"></div>
      <div class="fr-year fr-y3">${c.year3||''}</div>
      <div class="fr-item fr-i4 ${e('photo4')}" style="${p('photo4')}"></div>
      <div class="fr-year fr-y4">${c.year4||''}</div>
      <div class="fr-item fr-i5 ${e('photo5')}" style="${p('photo5')}"></div>
      <div class="fr-year fr-y5">${c.year5||''}</div>
      <div class="fr-item fr-i6 ${e('photo6')}" style="${p('photo6')}"></div>
      <div class="fr-year fr-y6">${c.year6||''}</div>
      <div class="fr-year fr-y7">${c.year7||''}</div>
    </div>`;
  }
};
