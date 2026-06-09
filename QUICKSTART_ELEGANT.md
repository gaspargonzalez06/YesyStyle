# 🚀 Inicio Rápido - YesyStyle Eventos Elegantes

## Paso 1: Actualizar Información de Contacto

Abre `lib/features/events/data/services_data.dart` y actualiza:

```dart
static const String whatsappNumber = '+525512345678'; // TU NÚMERO
static const String instagramHandle = '@yesystyle_eventos'; // TU USUARIO
```

## Paso 2: Activar la Nueva Landing Page

Opción A - Reemplazar la landing actual:

1. Elimina o renombra: `lib/features/events/presentation/pages/landing_page.dart`
2. Renombra: `landing_page_elegant.dart` a `landing_page.dart`

Opción B - Actualizar el router:

En `lib/core/router/app_router.dart`:

```dart
import '../../../features/events/presentation/pages/landing_page_elegant.dart';

// En la ruta principal:
GoRoute(
  path: '/',
  builder: (context, state) => const LandingPageElegant(),
),
```

## Paso 3: Instalar Dependencias

```bash
flutter pub get
```

## Paso 4: Ejecutar la Aplicación

```bash
flutter run -d chrome
```

## 🎨 Personalización Rápida

### Cambiar Nombre de la Empresa
En `landing_page_elegant.dart`, busca y reemplaza "YesyStyle" con tu nombre.

### Modificar Servicios
Edita `lib/features/events/data/services_data.dart`:
- Títulos
- Descripciones  
- Características
- Emojis

### Ajustar Colores
Edita `lib/core/constants/app_colors.dart` para cambiar la paleta completa.

## 📁 Archivos Importantes

```
lib/
├── core/
│   ├── constants/
│   │   └── app_colors.dart          # 🎨 Paleta de colores
│   └── theme/
│       └── app_theme.dart            # 🎨 Tema global
├── features/
│   └── events/
│       ├── data/
│       │   └── services_data.dart    # 📝 Contenido de servicios
│       ├── domain/
│       │   └── models/
│       │       └── service_category.dart  # 📦 Modelo de datos
│       └── presentation/
│           └── pages/
│               └── landing_page_elegant.dart  # 🏠 Página principal
└── shared/
    └── widgets/
        ├── contact_buttons.dart      # 📱 Botones contacto
        └── service_card.dart         # 🎴 Cards de servicio
```

## ✅ Checklist Antes de Publicar

- [ ] Actualizar número de WhatsApp
- [ ] Actualizar handle de Instagram
- [ ] Personalizar nombre de empresa
- [ ] Revisar/modificar servicios ofrecidos
- [ ] Ajustar colores si es necesario
- [ ] Probar todos los botones de contacto
- [ ] Verificar responsive en diferentes tamaños

## 🎯 Lo Más Importante

1. **WhatsApp**: Cambia el número en `services_data.dart`
2. **Instagram**: Cambia el handle en `services_data.dart`
3. **Servicios**: Personaliza en `services_data.dart`
4. **Colores**: Ajusta en `app_colors.dart`

## 💡 Tips

- Los emojis pueden reemplazarse con URLs de imágenes
- Cada servicio tiene su propio color único
- Los botones de contacto están siempre visibles (esquina inferior derecha)
- El diseño es completamente responsivo

---

**¿Necesitas ayuda?** Consulta [DESIGN_GUIDE.md](./DESIGN_GUIDE.md) para información detallada.
