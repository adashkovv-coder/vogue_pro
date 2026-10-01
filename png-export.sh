#!/bin/bash
echo "▬▬▬ Добавляю экспорт PNG (отдельно + ZIP) ▬▬▬"

# ═══ ДОБАВЛЯЕМ БИБЛИОТЕКУ JSZip в index.html ═══
python3 - << 'PY_EOF'
with open('index.html', 'r', encoding='utf-8') as f:
    html = f.read()

# Проверяем, есть ли jsPDF и html2canvas
if 'jszip' not in html.lower():
    # Вставляем JSZip после jspdf
    old = '<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>'
    new = old + '\n<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>'
    if old in html:
        html = html.replace(old, new)
        print("✅ JSZip подключён в index.html")
    else:
        print("⚠ Не нашёл jspdf — добавь JSZip вручную")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(html)
PY_EOF

# ═══ ДОБАВЛЯЕМ КНОПКИ В ТОПБАР ═══
python3 - << 'PY_EOF'
with open('index.html', 'r', encoding='utf-8') as f:
    html = f.read()

old = '''    <div class="topbar-actions">
      <button class="btn btn--ghost" id="btn-editor-back">Назад</button>
      <button class="btn btn--primary" id="btn-pdf">Скачать PDF</button>
    </div>'''

new = '''    <div class="topbar-actions">
      <button class="btn btn--ghost" id="btn-editor-back">Назад</button>
      <button class="btn btn--ghost" id="btn-png-current">PNG · текущая</button>
      <button class="btn btn--ghost" id="btn-png-all">PNG · все</button>
      <button class="btn btn--primary" id="btn-pdf">PDF</button>
    </div>'''

if old in html:
    html = html.replace(old, new)
    print("✅ Кнопки PNG добавлены в топбар")
else:
    print("⚠ Не нашёл блок кнопок — заменю вручную не получилось")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(html)
PY_EOF

# ═══ ДОБАВЛЯЕМ ЛОГИКУ В APP.JS ═══
python3 - << 'PY_EOF'
with open('app.js', 'r', encoding='utf-8') as f:
    js = f.read()

# Добавляем функции экспорта в конец файла
js += '''

/* ============================================================
   ЭКСПОРТ PNG
   ============================================================ */

/* ── Утилита: рендер страницы → canvas → blob ── */
async function pageToBlob(page, pageNum){
  const holder = document.getElementById('render-holder');
  holder.innerHTML = '';

  const d = document.createElement('div');
  d.innerHTML = renderPage(page, pageNum).trim();
  const node = d.firstElementChild;
  holder.appendChild(node);

  // Ждём перерисовки
  await new Promise(r => setTimeout(r, 120));

  const canvas = await html2canvas(node, {
    scale: 2,
    backgroundColor: '#ffffff',
    logging: false,
    useCORS: true,
    width: 794,
    height: 1123,
    windowWidth: 794,
    windowHeight: 1123
  });

  return new Promise((resolve) => {
    canvas.toBlob((blob) => resolve(blob), 'image/png', 1.0);
  });
}

function downloadBlob(blob, filename){
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}

/* ── Скачать ТЕКУЩУЮ страницу в PNG ── */
document.getElementById('btn-png-current').addEventListener('click', async () => {
  const btn = document.getElementById('btn-png-current');
  const origText = btn.textContent;

  btn.disabled = true;
  btn.textContent = 'Готовим…';

  try {
    const p = state.pages[state.activeIndex];
    const no = state.activeIndex + 1;
    const blob = await pageToBlob(p, no);
    const safeName = (getTemplate(p.templateId)?.name || 'page').replace(/[^\\wа-яА-ЯёЁ\\-]/g, '_');
    downloadBlob(blob, `VOGUE_page_${String(no).padStart(2,'0')}_${safeName}.png`);
    btn.textContent = 'Готово ✓';
  } catch(err){
    console.error(err);
    btn.textContent = 'Ошибка';
  } finally {
    setTimeout(() => {
      btn.disabled = false;
      btn.textContent = origText;
    }, 1500);
  }
});

/* ── Скачать ВСЕ страницы одним ZIP ── */
document.getElementById('btn-png-all').addEventListener('click', async () => {
  const btn = document.getElementById('btn-png-all');
  const origText = btn.textContent;
  btn.disabled = true;

  try {
    const zip = new JSZip();
    const folder = zip.folder('VOGUE_journal');

    for (let i = 0; i < state.pages.length; i++){
      btn.textContent = `PNG ${i+1}/${state.pages.length}`;
      const p = state.pages[i];
      const no = i + 1;
      const blob = await pageToBlob(p, no);

      const tpl = getTemplate(p.templateId);
      const safeName = (tpl?.name || 'page').replace(/[^\\wа-яА-ЯёЁ\\-]/g, '_');
      const filename = `${String(no).padStart(2,'0')}_${safeName}.png`;
      folder.file(filename, blob);
    }

    btn.textContent = 'Собираю ZIP…';
    const zipBlob = await zip.generateAsync({ type: 'blob', compression: 'DEFLATE' });
    downloadBlob(zipBlob, 'VOGUE_journal_PNG.zip');
    btn.textContent = 'Готово ✓';
  } catch(err){
    console.error(err);
    btn.textContent = 'Ошибка';
  } finally {
    document.getElementById('render-holder').innerHTML = '';
    setTimeout(() => {
      btn.disabled = false;
      btn.textContent = origText;
    }, 1500);
  }
});
'''

with open('app.js', 'w', encoding='utf-8') as f:
    f.write(js)
print("✅ app.js обновлён — экспорт PNG")
PY_EOF

# ═══ CSS — МОБИЛЬНАЯ АДАПТАЦИЯ КНОПОК ═══
cat >> styles.css << 'EOF'

/* ═══════════════════ PNG КНОПКИ — адаптив ═══════════════════ */
@media (max-width: 768px){
  .topbar-actions{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px;
    width: 100%;
  }
  .topbar-actions .btn{
    padding: 10px 14px;
    font-size: 10px;
    letter-spacing: .14em;
  }
  #btn-editor-back{ grid-column: 1 / 3; }
  #btn-png-current{ grid-column: 1 / 2; }
  #btn-png-all{ grid-column: 2 / 3; }
  #btn-pdf{ grid-column: 1 / 3; }
}
EOF

echo "✅ CSS обновлён"

# ═══ PUSH ═══
git add .
git commit -m "Add PNG export: current page + all pages as ZIP" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
