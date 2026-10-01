#!/bin/bash
echo "▬▬▬ Включаю авто-улучшение фото ▬▬▬"

# ═══ ПАТЧИМ APP.JS — добавляем обработку изображений ═══
python3 - << 'PY_EOF'
import re
with open('app.js', 'r', encoding='utf-8') as f:
    js = f.read()

# Ищем маркер — вставляем функции ПЕРЕД первой функцией show()
marker = "function show(id){"

enhance_functions = '''
/* ============================================================
   ⚡ АВТО-УЛУЧШЕНИЕ ФОТО
   Апскейл до 1800px + лёгкий sharpen + контраст + насыщенность
   ============================================================ */

const MIN_SIDE = 1800;       // минимальная сторона после обработки
const JPEG_QUALITY = 0.94;   // качество выходного JPEG

async function enhanceImage(file){
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const img = new Image();
      img.onload = () => {
        try {
          const result = processImage(img);
          resolve(result);
        } catch(err){
          console.warn('Enhance failed, fallback to raw:', err);
          resolve(e.target.result);
        }
      };
      img.onerror = () => resolve(e.target.result);
      img.src = e.target.result;
    };
    reader.readAsDataURL(file);
  });
}

function processImage(img){
  // 1. Считаем целевой размер (не уменьшаем, но апскейлим до MIN_SIDE)
  let w = img.naturalWidth;
  let h = img.naturalHeight;
  const minDim = Math.min(w, h);
  const maxDim = Math.max(w, h);

  // Если изображение меньше 1800px по любой стороне — апскейлим
  if (maxDim < MIN_SIDE) {
    const scale = MIN_SIDE / maxDim;
    w = Math.round(w * scale);
    h = Math.round(h * scale);
  } else if (minDim < 900) {
    // Если одна сторона слишком маленькая — апскейлим пропорционально
    const scale = 900 / minDim;
    w = Math.round(w * scale);
    h = Math.round(h * scale);
  }

  // Ограничиваем максимум — чтобы не раздувать память
  const MAX_SIDE = 3200;
  if (Math.max(w, h) > MAX_SIDE){
    const s = MAX_SIDE / Math.max(w, h);
    w = Math.round(w * s);
    h = Math.round(h * s);
  }

  // 2. Рисуем на canvas с хорошей интерполяцией
  const canvas = document.createElement('canvas');
  canvas.width = w;
  canvas.height = h;
  const ctx = canvas.getContext('2d');
  ctx.imageSmoothingEnabled = true;
  ctx.imageSmoothingQuality = 'high';
  ctx.drawImage(img, 0, 0, w, h);

  // 3. Лёгкое улучшение: контраст + насыщенность + яркость через CSS-фильтр
  //    (применяем через отдельный canvas-фильтр, если поддерживается)
  const tmp = document.createElement('canvas');
  tmp.width = w;
  tmp.height = h;
  const tctx = tmp.getContext('2d');

  // ctx.filter поддерживается в современных браузерах
  if ('filter' in tctx){
    tctx.filter = 'contrast(1.06) saturate(1.08) brightness(1.02)';
    tctx.drawImage(canvas, 0, 0);
  } else {
    tctx.drawImage(canvas, 0, 0);
  }

  // 4. Лёгкий sharpen (unsharp mask) через ImageData
  const imageData = tctx.getImageData(0, 0, w, h);
  const sharpened = unsharpMask(imageData, w, h, 0.55, 1);
  tctx.putImageData(sharpened, 0, 0);

  // 5. Сохраняем как JPEG
  return tmp.toDataURL('image/jpeg', JPEG_QUALITY);
}

/* Простой unsharp mask: размытие + вычитание + добавление */
function unsharpMask(imageData, w, h, amount, radius){
  const src = imageData.data;
  const out = new Uint8ClampedArray(src.length);

  // Лёгкое box-blur 3x3
  const blurred = new Uint8ClampedArray(src.length);
  for (let y = 0; y < h; y++){
    for (let x = 0; x < w; x++){
      let r = 0, g = 0, b = 0, n = 0;
      for (let dy = -1; dy <= 1; dy++){
        for (let dx = -1; dx <= 1; dx++){
          const nx = x + dx, ny = y + dy;
          if (nx < 0 || nx >= w || ny < 0 || ny >= h) continue;
          const i = (ny * w + nx) * 4;
          r += src[i]; g += src[i+1]; b += src[i+2]; n++;
        }
      }
      const i = (y * w + x) * 4;
      blurred[i]   = r / n;
      blurred[i+1] = g / n;
      blurred[i+2] = b / n;
      blurred[i+3] = src[i+3];
    }
  }

  // Sharpening: out = src + amount * (src - blurred)
  for (let i = 0; i < src.length; i += 4){
    out[i]   = Math.min(255, Math.max(0, src[i]   + amount * (src[i]   - blurred[i])));
    out[i+1] = Math.min(255, Math.max(0, src[i+1] + amount * (src[i+1] - blurred[i+1])));
    out[i+2] = Math.min(255, Math.max(0, src[i+2] + amount * (src[i+2] - blurred[i+2])));
    out[i+3] = src[i+3];
  }

  return new ImageData(out, w, h);
}

'''

js = js.replace(marker, enhance_functions + marker)

# ═══ ЗАМЕНЯЕМ ЗАГРУЗКУ ОДНОГО ФОТО ═══
old_single = """  /* ── Одно фото ── */
  if (t.dataset.photo){
    const f = t.files && t.files[0];
    if (!f) return;
    const r = new FileReader();
    r.onload = () => {
      p.content[t.dataset.photo] = r.result;
      renderEditor();
    };
    r.readAsDataURL(f);
  }"""

new_single = """  /* ── Одно фото — с улучшением ── */
  if (t.dataset.photo){
    const f = t.files && t.files[0];
    if (!f) return;
    enhanceImage(f).then((dataURL) => {
      p.content[t.dataset.photo] = dataURL;
      renderEditor();
    });
  }"""

js = js.replace(old_single, new_single)

# ═══ ЗАМЕНЯЕМ ЗАГРУЗКУ МНОГО ФОТО ═══
old_multi = """  /* ── Много фото ── */
  if (t.dataset.photos){
    const slots = (t.dataset.slots || '').split(',').filter(Boolean);
    const files = Array.from(t.files || []);
    if (!files.length || !slots.length) return;

    const total = Math.min(files.length, slots.length);
    let loaded = 0;

    files.slice(0, total).forEach((file, idx) => {
      const r = new FileReader();
      r.onload = () => {
        p.content[slots[idx]] = r.result;
        loaded++;
        if (loaded === total){
          renderEditor();  // перерисуем — фото загрузились все
        }
      };
      r.readAsDataURL(file);
    });
  }"""

new_multi = """  /* ── Много фото — все с улучшением ── */
  if (t.dataset.photos){
    const slots = (t.dataset.slots || '').split(',').filter(Boolean);
    const files = Array.from(t.files || []);
    if (!files.length || !slots.length) return;

    const total = Math.min(files.length, slots.length);

    // Показываем прогресс
    const statusEl = document.getElementById('photo-status');
    if (statusEl) statusEl.textContent = `Улучшаю 0/${total}…`;

    Promise.all(
      files.slice(0, total).map((file, idx) =>
        enhanceImage(file).then((dataURL) => {
          p.content[slots[idx]] = dataURL;
          if (statusEl) statusEl.textContent = `Улучшаю ${idx+1}/${total}…`;
        })
      )
    ).then(() => {
      if (statusEl) statusEl.textContent = `✓ ${total} фото улучшено`;
      renderEditor();
      setTimeout(() => { if (statusEl) statusEl.textContent = ''; }, 2500);
    });
  }"""

js = js.replace(old_multi, new_multi)

with open('app.js', 'w', encoding='utf-8') as f:
    f.write(js)

print("✅ app.js обновлён — авто-улучшение фото")
PY_EOF

# ═══ ДОБАВЛЯЕМ СТАТУС-БАР В ФОРМЕ ═══
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

# Добавляем стиль статуса
css += '''

/* ═══════════════════ СТАТУС УЛУЧШЕНИЯ ФОТО ═══════════════════ */
#photo-status{
  display: inline-block;
  margin-left: 10px;
  font-family: 'Inter', sans-serif;
  font-size: 11px;
  color: #c97a7a;
  letter-spacing: .05em;
  font-style: italic;
  vertical-align: middle;
}
'''

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Стиль статуса добавлен")
PY_EOF

# ═══ ДОБАВЛЯЕМ ЭЛЕМЕНТ СТАТУСА В HTML ═══
python3 - << 'PY_EOF'
with open('index.html', 'r', encoding='utf-8') as f:
    html = f.read()

# Ищем топбар и добавляем туда статус
old = '<div class="topbar-info" id="topbar-info"></div>'
new = '<div class="topbar-info" id="topbar-info"></div><span id="photo-status"></span>'

if old in html:
    html = html.replace(old, new)
    print("✅ Статус-бар добавлен в топбар")
else:
    print("⚠ Не нашёл топбар — статус появится динамически")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(html)
PY_EOF

# ═══ PUSH ═══
echo ""
git add .
git commit -m "Auto-enhance uploaded photos: upscale + sharpen + contrast" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
