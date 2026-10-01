#!/bin/bash
echo "▬▬▬ Синхронизация с гит и перезапись Love Quote ▬▬▬"

# Синхронизируем с гит
echo "→ Скачиваю последнюю версию с GitHub..."
git pull origin main --no-edit || echo "⚠ Не удалось сделать pull — продолжаю локально"

# ============ ПЕРЕЗАПИСЫВАЕМ ШАБЛОН ============
cat > templates/05-love-quote.js << 'EOF'
/* ============================================================
   ШАБЛОН 05 — LOVE QUOTE
   Фиксированная картинка на весь A4. Дизайн из Figma.
   Источник: assets/love.png
   ============================================================ */

export default {
  id: 'love-quote',
  name: 'Love Quote',
  category: 'Цитаты',
  fields: [],           // нет редактируемых полей — дизайн фиксирован
  defaults: {},
  render(c, no){
    return `<div class="page love-quote">
      <img class="lq-image" src="assets/love.png" alt="">
    </div>`;
  }
};
EOF

echo "✅ 05-love-quote.js перезаписан"

# ============ УДАЛЯЕМ СТАРЫЙ CSS И ДОБАВЛЯЕМ НОВЫЙ ============
python3 - << 'PY_EOF'
import re
with open('styles.css', 'r', encoding='utf-8') as f:
    css = f.read()

# Удаляем старый блок про love-quote
pattern = r'/\* ═+ ШАБЛОН 05 — LOVE QUOTE.*?(?=/\* ═+ ШАБЛОН 06)'
css = re.sub(pattern, '', css, flags=re.DOTALL)

# На случай, если блок назван по-другому
pattern2 = r'/\* =+ ШАБЛОН 05 — LOVE QUOTE =+ \*/.*?(?=/\* =+ ШАБЛОН 06)'
css = re.sub(pattern2, '', css, flags=re.DOTALL)

with open('styles.css', 'w', encoding='utf-8') as f:
    f.write(css)
print("✅ Старый CSS Love Quote удалён")
PY_EOF

cat >> styles.css << 'EOF'

/* ═══════════════════ ШАБЛОН 05 — LOVE QUOTE (фиксированная картинка) ═══════════════════ */
.love-quote {
  background: #3B0A14;   /* фолбэк — цвет бордо, если картинка не загрузилась */
  position: relative;
  overflow: hidden;
}

.love-quote .lq-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  display: block;
}
EOF

echo "✅ Новый CSS добавлен"

# ============ ПРОВЕРЯЕМ, ЧТО КАРТИНКА НА МЕСТЕ ============
echo ""
echo "→ Проверяю наличие assets/love.png..."
if [ -f "assets/love.png" ]; then
  SIZE=$(du -h assets/love.png | cut -f1)
  echo "  ✅ Найдено: assets/love.png ($SIZE)"
else
  echo "  ❌ ФАЙЛ assets/love.png НЕ НАЙДЕН!"
  echo "  Залей его в папку assets/ и перезапусти скрипт."
fi

# ============ ДЕЛАЕМ КОММИТ И ПУШ ============
echo ""
echo "→ Делаю коммит и пуш..."
git add .
git commit -m "Fix Love Quote: use fixed image from assets/love.png" || echo "⚠ Нечего коммитить"
git push origin main || echo "⚠ Не удалось запушить"

echo ""
echo "▬▬▬ ГОТОВО ▬▬▬"
echo "Через минуту обнови сайт (Ctrl+F5) и проверь шаблон Love Quote."
