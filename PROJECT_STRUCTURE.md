# 📁 Estructura del Proyecto YesyStyle

## Vista General de Archivos Nuevos y Modificados

```
yesystyle/
│
├── 📘 DESIGN_GUIDE.md              ⭐ NUEVO - Guía completa de diseño
├── 📘 QUICKSTART_ELEGANT.md        ⭐ NUEVO - Inicio rápido
├── 📘 TRANSFORMATION_SUMMARY.md    ⭐ NUEVO - Resumen de cambios
├── 📘 PROJECT_STRUCTURE.md         ⭐ NUEVO - Este archivo
│
├── lib/
│   ├── main.dart                   ✏️ MODIFICADO - Título actualizado
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_colors.dart     ✏️ MODIFICADO - Nueva paleta Rose Gold
│   │   │
│   │   └── theme/
│   │       └── app_theme.dart      ✏️ MODIFICADO - Tema elegante
│   │
│   ├── features/
│   │   └── events/
│   │       ├── data/
│   │       │   └── services_data.dart     ⭐ NUEVO - 6 servicios completos
│   │       │
│   │       ├── domain/
│   │       │   └── models/
│   │       │       └── service_category.dart  ⭐ NUEVO - Modelo de datos
│   │       │
│   │       └── presentation/
│   │           └── pages/
│   │               ├── landing_page.dart      ⚠️ ORIGINAL (mantener)
│   │               └── landing_page_elegant.dart  ⭐ NUEVO - Landing elegante
│   │
│   └── shared/
│       └── widgets/
│           ├── contact_buttons.dart    ⭐ NUEVO - WhatsApp/Instagram
│           └── service_card.dart       ⭐ NUEVO - Cards de servicios
│
└── pubspec.yaml                     ✅ OK - Dependencias ya están
```

---

## 🎨 Código Clave por Archivo

### 📄 app_colors.dart
**Rol**: Define toda la paleta de colores
```dart
- Rose Gold (#B76E79)
- Champagne (#F7E7CE)
- Blush Pink (#E8B4B8)
+ 6 colores más + gradientes
```

### 📄 app_theme.dart
**Rol**: Tema global de la aplicación
```dart
- Usa los nuevos colores
- Configura estilos de botones
- Define inputs y cards
```

### 📄 service_category.dart
**Rol**: Modelo de datos para servicios
```dart
class ServiceCategory {
  String title
  String description
  Color color
  List<String> features
  // ... más propiedades
}
```

### 📄 services_data.dart  ⭐ IMPORTANTE
**Rol**: Contenido de todos los servicios
```dart
- 6 servicios completos
- Configuración de WhatsApp
- Configuración de Instagram
- Métodos helper
```

**AQUÍ CAMBIAS**:
- Número de WhatsApp
- Handle de Instagram
- Contenido de servicios

### 📄 contact_buttons.dart
**Rol**: Botones de contacto reutilizables
```dart
- Botón WhatsApp animado
- Botón Instagram animado
- Versiones con/sin labels
- Efectos hover
```

### 📄 service_card.dart
**Rol**: Tarjetas de servicios
```dart
- Card con gradiente único
- Hover effect
- Patrón decorativo
- Responsive
```

### 📄 landing_page_elegant.dart  ⭐ PRINCIPAL
**Rol**: La nueva landing page
```dart
Secciones:
- Header con logo y contacto
- Hero section (título grande)
- Grid de servicios
- Sobre nosotros
- CTA final
- Footer
```

---

## 🔗 Relaciones Entre Archivos

```
landing_page_elegant.dart
    ↓ usa
    ├── contact_buttons.dart
    ├── service_card.dart  
    ├── services_data.dart
    └── app_colors.dart

services_data.dart
    ↓ usa
    └── service_category.dart

contact_buttons.dart
    ↓ usa
    ├── app_colors.dart
    └── services_data.dart (para links)

service_card.dart
    ↓ usa
    ├── app_colors.dart
    └── service_category.dart

app_theme.dart
    ↓ usa
    └── app_colors.dart

main.dart
    ↓ usa
    └── app_theme.dart
```

---

## 📊 Flujo de Datos

### 1. Inicio de la App
```
main.dart
  ↓
app_theme.dart (aplica colores)
  ↓
router → landing_page_elegant.dart
  ↓
Carga services_data.dart
  ↓
Muestra ServiceCards
```

### 2. Usuario hace clic en servicio
```
ServiceCard (onTap)
  ↓
landing_page_elegant → _showServiceDetails()
  ↓
Modal con toda la info del servicio
  ↓
Botón WhatsApp → services_data.getWhatsAppLink()
  ↓
Abre WhatsApp externo
```

### 3. Usuario hace clic en botón contacto
```
ContactButtons (onPressed)
  ↓
landing_page_elegant → _launchWhatsApp()
  ↓
url_launcher → WhatsApp
```

---

## 🎯 Archivos a Personalizar

### Prioridad Alta (Debes cambiar)
1. ✅ `services_data.dart` - WhatsApp e Instagram
2. ✅ `services_data.dart` - Contenido de servicios

### Prioridad Media (Opcional)
3. `landing_page_elegant.dart` - Textos generales
4. `app_colors.dart` - Si quieres otros colores

### Prioridad Baja (Raro cambiar)
5. `service_category.dart` - Modelo de datos
6. `contact_buttons.dart` - Widget de botones
7. `service_card.dart` - Widget de cards

---

## 🚀 Orden de Ejecución

Cuando ejecutas `flutter run`:

```
1. main.dart inicializa la app
2. app_theme.dart aplica los estilos
3. Router carga landing_page_elegant
4. landing_page_elegant obtiene servicios de services_data
5. Renderiza header con contact_buttons
6. Renderiza hero section
7. Renderiza grid de service_cards
8. Usuario interactúa...
```

---

## 📝 Tamaño de Archivos

```
landing_page_elegant.dart    ~700 líneas  🏠 Página principal
services_data.dart           ~200 líneas  📊 Datos de servicios
service_card.dart            ~150 líneas  🎴 Widget card
contact_buttons.dart         ~170 líneas  📱 Widget botones
service_category.dart        ~50 líneas   📦 Modelo
app_colors.dart              ~80 líneas   🎨 Paleta
```

---

## 🔧 Dependencias Externas Usadas

```yaml
url_launcher: ^6.2.5      # Para WhatsApp/Instagram
google_fonts: ^6.1.0      # Tipografías
```

Ambas ya están en `pubspec.yaml` ✅

---

## 🎨 Sistema de Colores

### Archivo: app_colors.dart

```
Colores Base (8)
  ↓
Gradientes (4)
  ↓
Colores por Servicio (6)
  ↓
Usado en app_theme.dart
  ↓
Aplicado a toda la app
```

---

## 📱 Widgets Hierarchy

```
Scaffold
└── Stack
    ├── Container (Background gradient)
    ├── CustomPaint (Pattern)
    └── SafeArea
        └── SingleChildScrollView
            ├── Header
            │   └── Row
            │       ├── Logo
            │       └── ContactButtons ⭐
            ├── Hero Section
            │   └── Column
            │       ├── ShaderMask (Title)
            │       ├── Subtitle
            │       └── Button
            ├── Services Grid
            │   └── GridView
            │       └── ServiceCard ⭐ (x6)
            ├── About Section
            │   └── ValueCards (x3)
            ├── CTA Section
            │   └── ContactButtons ⭐
            └── Footer
    └── Positioned (Floating ContactButtons ⭐)
```

---

## 🎯 Entry Points

### Para Desarrolladores:
```
Quiero cambiar...         → Edita este archivo
─────────────────────────────────────────────────
Colores                   → app_colors.dart
Servicios                 → services_data.dart  
Contacto (WhatsApp/IG)    → services_data.dart
Textos de la página       → landing_page_elegant.dart
Agregar nuevo servicio    → services_data.dart
Modificar un servicio     → services_data.dart
Cambiar diseño de cards   → service_card.dart
Cambiar botones contacto  → contact_buttons.dart
Tema general              → app_theme.dart
```

---

## 📦 Exports/Imports Importantes

### landing_page_elegant.dart
```dart
import 'url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'contact_buttons.dart';
import 'service_card.dart';
import 'services_data.dart';
```

### services_data.dart
```dart
import 'service_category.dart';
import 'app_colors.dart';
```

---

## 🔍 Búsqueda Rápida

¿Dónde está...?

```
WhatsApp number          → services_data.dart:3
Instagram handle         → services_data.dart:4
Service descriptions     → services_data.dart:11-180
Color palette            → app_colors.dart:4-70
Main gradient            → app_colors.dart:30-35
Contact button widget    → contact_buttons.dart
Service card widget      → service_card.dart
Landing page             → landing_page_elegant.dart
Theme config             → app_theme.dart
```

---

## ⚡ Hot Reload Compatible

Todos los archivos soportan hot reload:
- ✅ Cambios en colores → Hot reload
- ✅ Cambios en textos → Hot reload
- ✅ Cambios en servicios → Hot reload
- ✅ Cambios en diseño → Hot reload

Solo necesitas **hot restart** si cambias:
- 🔄 Dependencias en pubspec.yaml
- 🔄 Archivos de assets

---

## 🎬 Testing de Componentes

Para probar componentes individuales:

```dart
// ContactButtons
ContactButtons(
  onWhatsAppPressed: () => print('WhatsApp'),
  onInstagramPressed: () => print('Instagram'),
);

// ServiceCard
ServiceCard(
  service: services[0],
  onTap: () => print('Tapped'),
);
```

---

## 🌳 Árbol de Decisiones

```
┌─ ¿Quieres cambiar colores?
│  └─ YES → app_colors.dart
│
├─ ¿Quieres modificar servicios?
│  └─ YES → services_data.dart
│
├─ ¿Quieres cambiar contacto?
│  └─ YES → services_data.dart (líneas 3-4)
│
├─ ¿Quieres editar textos de la página?
│  └─ YES → landing_page_elegant.dart
│
└─ ¿Quieres cambiar el diseño?
   └─ YES → landing_page_elegant.dart
            service_card.dart
            contact_buttons.dart
```

---

## 💾 Backup Recomendado

Antes de modificar, haz backup de:
1. `landing_page.dart` (original)
2. `app_colors.dart` (por si quieres volver)
3. `services_data.dart` (después de personalizarlo)

---

## 🎓 Conceptos Clave

### ServiceCategory
Modelo de datos que representa un servicio. Contiene título, descripción, color, características, etc.

### ServicesData
Clase estática que provee todos los servicios y métodos helper para WhatsApp/Instagram.

### ContactButtons
Widget reutilizable para botones de contacto con animaciones.

### ServiceCard
Widget reutilizable para mostrar cada servicio en formato card elegante.

---

## 🔄 Flujo de Actualización

```
1. Editas services_data.dart
   ↓
2. Guardas cambios
   ↓
3. Hot Reload automático
   ↓
4. Ves cambios en la app
   ↓
5. Si no funciona → Hot Restart
```

---

## ✨ Features Implementadas

- [x] Paleta de colores elegante
- [x] 6 servicios completos con contenido
- [x] Integración WhatsApp
- [x] Integración Instagram
- [x] Responsive design
- [x] Animaciones suaves
- [x] Modales de detalle
- [x] Botones flotantes
- [x] Patrón decorativo
- [x] Sombras elegantes
- [x] Hover effects
- [x] Gradientes en texto

---

**Todo está listo para personalizar y usar! 🚀**

Empieza por `services_data.dart` para configurar tu información de contacto.
