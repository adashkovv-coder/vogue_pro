#!/bin/bash
echo "▬▬▬ PNG в высоком разрешении 2481×3507 ▬▬▬"

# ═══ ПАТЧИМ APP.JS — меняем scale и размеры в pageToBlob ═══
python3 - << 'PY_EOF'
with open('app.js', 'r', encoding='utf-8') as f:
    js = f.read()

old = """async function pageToBlob(page, pageNum){
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
}"""

new = """async function pageToBlob(page, pageNum){
  const holder = document.getElementById('render-holder');
  holder.innerHTML = '';

  const d = document.createElement('div');
  d.innerHTML = renderPage(page, pageNum).trim();
  const node = d.firstElementChild;
  holder.appendChild(node);

  // Ждём перерисовки
  await new Promise(r => setTimeout(r, 150));

  // ⚡ Высокое разрешение: 2481×3507 (как в Figma)
  // Базовый размер страницы — 794×1123, значит scale ≈ 3.125
  const SCALE = 2481 / 794;  // ≈ 3.125

  const canvas = await html2canvas(node, {
    scale: SCALE,
    backgroundColor: '#ffffff',
    logging: false,
    useCORS: true,
    width: 794,
    height: 1123,
    windowWidth: 794,
    windowHeight: 1123
  });

  // На всякий случай — принудительно ресайзим до точных 2481×3507
  const targetW = 2481;
  const targetH = 3507;

  let finalCanvas = canvas;
  if (canvas.width !== targetW || canvas.height !== targetH){
    const fixed = document.createElement('canvas');
    fixed.width = targetW;
    fixed.height = targetH;
    const ctx = fixed.getContext('2d');
    ctx.imageSmoothingEnabled = true;
    ctx.imageSmoothingQuality = 'high';
    ctx.drawImage(canvas, 0, 0, targetW, targetH);
    finalCanvas = fixed;
  }

  return new Promise((resolve) => {
    finalCanvas.toBlob((blob) => resolve(blob), 'image/png', 1.0);
  });
}"""

if old in js:
    js = js.replace(old, new)
    print("✅ pageToBlob обновлён — 2481×3507")
else:
    print("❌ Не нашёл pageToBlob в app.js")

with open('app.js', 'w', encoding='utf-8') as f:
    f.write(js)
PY_EOF

# ═══ ТАКЖЕ ПАТЧИМ PDF — чтобы каждая страница была в максимальном качестве ═══
python3 - << 'PY_EOF'
with open('app.js', 'r', encoding='utf-8') as f:
    js = f.read()

# Ищем блок PDF и повышаем scale
old = """      const canvas = await html2canvas(nodes[i], {
        scale: 2,
        backgroundColor: '#ffffff',
        logging: false,
        useCORS: true,
        width: 794, height: 1123,
        windowWidth: 794, windowHeight: 1123
      });

      const img = canvas.toDataURL('image/jpeg', 0.92);"""

new = """      const canvas = await html2canvas(nodes[i], {
        scale: 3.125,                    // ≈ 2481 / 794 — высокое разрешение
        backgroundColor: '#ffffff',
        logging: false,
        useCORS: true,
        width: 794, height: 1123,
        windowWidth: 794, windowHeight: 1123
      });

      const img = canvas.toDataURL('image/jpeg', 0.95);   // максимальное качество"""

if old in js:
    js = js.replace(old, new)
    print("✅ PDF обновлён — scale 3.125")
else:
    print("⚠ Не нашёл блок PDF (не критично)")

with open('app.js', 'w', encoding='utf-8') as f:
    f.write(js)
PY_EOF

# ═══ PUSH ═══
echo ""
git add .
git commit -m "PNG export at 2481x3507 (Figma resolution) + PDF scale 3.125" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "PNG теперь: 2481×3507 px (максимальное качество)"
echo "PDF теперь: scale 3.125 (плотность ~300 dpi для A4)"
