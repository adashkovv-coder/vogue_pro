export default {
  id: 'her-songs',
  name: 'Her Songs',
  category: 'Музыка',
  fields: [
    {key:'title',label:'Заголовок (HER)',type:'text'},
    {key:'subtitle',label:'Подзаголовок (SONGS)',type:'text'},
    {key:'song1',label:'Песня 1',type:'text'},{key:'artist1',label:'Исполнитель 1',type:'text'},
    {key:'song2',label:'Песня 2',type:'text'},{key:'artist2',label:'Исполнитель 2',type:'text'},
    {key:'song3',label:'Песня 3',type:'text'},{key:'artist3',label:'Исполнитель 3',type:'text'},
    {key:'song4',label:'Песня 4',type:'text'},{key:'artist4',label:'Исполнитель 4',type:'text'}
  ],
  defaults: {
    title:'HER',subtitle:'SONGS',
    song1:"Yeah, my boyfriend's pretty cool", artist1:'Brooklyn Baby',
    song2:'I wrote you a note, but I didn\'t send it', artist2:'Sweet',
    song3:"I'm pretty when I cry", artist3:'Pretty When You Cry',
    song4:'Hot summer nights, mid-July', artist4:'Young And Beautiful'
  },
  render(c, no){
    return `<div class="page hs-page">
      <div class="hs-title">${c.title||''}</div>
      <div class="hs-subtitle">${c.subtitle||''}</div>
      <div class="hs-card hs-c1"><div class="hs-song">${c.song1||''}</div><div class="hs-artist">${c.artist1||''}</div></div>
      <div class="hs-card hs-c2"><div class="hs-song">${c.song2||''}</div><div class="hs-artist">${c.artist2||''}</div></div>
      <div class="hs-card hs-c3"><div class="hs-song">${c.song3||''}</div><div class="hs-artist">${c.artist3||''}</div></div>
      <div class="hs-card hs-c4"><div class="hs-song">${c.song4||''}</div><div class="hs-artist">${c.artist4||''}</div></div>
    </div>`;
  }
};
