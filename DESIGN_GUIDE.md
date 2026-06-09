# YesyStyle - Eventos Elegantes 💐

## Transformación Completa de la Aplicación

Esta aplicación ha sido completamente rediseñada para reflejar elegancia, sofisticación y un enfoque femenino emprendedor, especializada en servicios de eventos de alta calidad.

---

## 🎨 Diseño y Paleta de Colores

### Paleta Elegante Rose Gold & Champagne

La aplicación utiliza una paleta de colores cuidadosamente seleccionada que transmite elegancia y feminidad:

- **Rose Gold** (`#B76E79`) - Color principal, representa sofisticación
- **Champagne** (`#F7E7CE`) - Calidez y elegancia
- **Blush Pink** (`#E8B4B8`) - Suavidad y feminidad
- **Dusty Rose** (`#D4A5A5`) - Tonos románticos
- **Warm Beige** (`#F5E6D3`) - Neutralidad cálida
- **Soft Lavender** (`#E6D4E8`) - Toque de creatividad
- **Pearl White** (`#FFFBF5`) - Pureza y brillo
- **Deep Plum** (`#8B6E7E`) - Profundidad y contraste
- **Golden Accent** (`#D4AF37`) - Lujo y distinción

### Colores por Categoría de Servicio

Cada servicio tiene su propio color identificativo:

- 🫖 **Tardes de Té**: Blush Pink
- 💍 **Bodas**: Warm Beige
- 🎻 **Servicios Musicales**: Soft Lavender
- ✨ **Decoraciones**: Golden Accent
- 📋 **Organización de Eventos**: Rose Gold
- 🎪 **Equipos & Servicios**: Rose Gold gradiente

---

## 📱 Servicios Ofrecidos

### 1. Tardes de Té ☕
*Momentos de elegancia y distinción*

**Características:**
- Selección de tés premium importados
- Repostería artesanal y bocadillos gourmet
- Vajilla fina y cristalería elegante
- Decoración temática personalizada
- Ambientación musical suave
- Servicio de mesa profesional
- Arreglos florales frescos
- Menús personalizados para cada ocasión

### 2. Bodas de Ensueño 💍
*Tu día perfecto, realidad*

**Características:**
- Planificación completa de la boda
- Coordinación de ceremonia y recepción
- Diseño de decoración personalizada
- Selección de proveedores premium
- Asesoría de imagen y protocolo
- Coordinación el día del evento
- Diseño de invitaciones y papelería
- Ambientación y flores naturales

### 3. Servicios Musicales 🎻
*La melodía perfecta para cada momento*

**Características:**
- Violinista profesional en vivo
- Pianista para ceremonias
- Cuarteto de cuerdas
- Música clásica y contemporánea
- Repertorio personalizado
- Arpa para ceremonias especiales
- Cantantes líricos
- Asesoría musical para tu evento

### 4. Decoraciones Exclusivas ✨
*Ambientes que inspiran*

**Características:**
- Diseño de concepto decorativo
- Arreglos florales a medida
- Mobiliario elegante y exclusivo
- Iluminación ambiental profesional
- Backdrops y fondos temáticos
- Centros de mesa personalizados
- Telas y textiles de alta calidad
- Coordinación de paleta de colores

### 5. Organización de Eventos 📋
*Perfección en cada detalle*

**Características:**
- Planificación integral del evento
- Coordinación de proveedores
- Timeline y cronograma detallado
- Logística y montaje
- Gestión de invitados
- Coordinación el día del evento
- Solución de imprevistos
- Seguimiento post-evento

### 6. Equipos & Servicios 🎪
*Todo lo que necesitas*

**Características:**
- Mobiliario elegante (mesas, sillas, lounge)
- Vajilla fina y cristalería
- Equipo audiovisual profesional
- Carpas y toldos elegantes
- Pista de baile iluminada
- Fotomatón y accesorios
- Servicio de meseros profesionales
- Renta de menaje completo

---

## 🏗️ Estructura del Proyecto

### Archivos Principales Creados/Modificados

#### 1. Colores y Tema
- `lib/core/constants/app_colors.dart` - Nueva paleta elegante
- `lib/core/theme/app_theme.dart` - Tema actualizado

#### 2. Modelos de Datos
- `lib/features/events/domain/models/service_category.dart` - Modelo de servicios
- `lib/features/events/data/services_data.dart` - Datos completos de servicios

#### 3. Widgets Reutilizables
- `lib/shared/widgets/contact_buttons.dart` - Botones de WhatsApp e Instagram
- `lib/shared/widgets/service_card.dart` - Cards para mostrar servicios

#### 4. Página Principal
- `lib/features/events/presentation/pages/landing_page_elegant.dart` - Nueva landing page elegante

---

## 🎯 Funcionalidades Implementadas

### Contacto Directo
- **WhatsApp**: Botón directo que abre chat con mensaje predefinido
- **Instagram**: Enlace directo al perfil de Instagram

### Interfaz Interactiva
- Animaciones suaves al cargar
- Cards interactivos con hover effects
- Modales detallados para cada servicio
- Scroll suave entre secciones
- Botones flotantes de contacto

### Diseño Responsivo
- Layout adaptable a diferentes tamaños de pantalla
- Grid de servicios que se ajusta automáticamente
- Optimizado para web, tablet y móvil

### Experiencia de Usuario
- Navegación intuitiva
- Información clara y organizada
- Call-to-actions visibles
- Diseño limpio y elegante

---

## 🚀 Cómo Usar la Nueva Landing Page

### Opción 1: Usar la Nueva Página Directamente

Actualiza el router para usar la nueva landing page:

```dart
// En lib/core/router/app_router.dart
import '../../../features/events/presentation/pages/landing_page_elegant.dart';

// Cambia la ruta:
GoRoute(
  path: '/',
  builder: (context, state) => const LandingPageElegant(),
),
```

### Opción 2: Actualizar Datos de Contacto

En `lib/features/events/data/services_data.dart`:

```dart
static const String whatsappNumber = '+525512345678'; // CAMBIAR
static const String instagramHandle = '@yesystyle_eventos'; // CAMBIAR
```

---

## 📝 Personalización

### Cambiar Colores

Edita `lib/core/constants/app_colors.dart` para ajustar la paleta de colores.

### Agregar/Modificar Servicios

Edita `lib/features/events/data/services_data.dart` en el método `getAllServices()`.

### Modificar Contenido

Edita directamente los textos en `landing_page_elegant.dart`:
- Título principal
- Subtítulos
- Descripciones
- Valores de la empresa

---

## 🎨 Elementos de Diseño Únicos

### Por Sección

1. **Header**: 
   - Logo con gradiente Rose Gold
   - Botones de contacto integrados
   - Fondo semi-transparente

2. **Hero Section**:
   - Título con shader mask (gradiente en texto)
   - Separador dorado decorativo
   - Botón principal con sombra y efecto hover

3. **Servicios**:
   - Cards con gradientes únicos por categoría
   - Emojis como hero images
   - Patrón decorativo de fondo
   - Efecto hover con scale animation

4. **Modales de Detalle**:
   - Header con gradiente del servicio
   - Lista de características con íconos
   - Galería de emojis relacionados
   - Botón CTA directo a WhatsApp

5. **Sobre Nosotros**:
   - Cards de valores con sombras suaves
   - Íconos con gradiente
   - Fondo con opacidad

6. **CTA Final**:
   - Gradiente elegante de fondo
   - Botones de contacto principales
   - Sombra pronunciada

7. **Footer**:
   - Diseño minimalista
   - Ícono de corazón en brand color

### Patrón Decorativo

El fondo incluye un patrón custom de círculos concéntricos que añade textura sutil sin ser invasivo.

---

## 💡 Filosofía de Diseño

### Principios Aplicados

1. **Elegancia**: Uso de colores suaves y transiciones fluidas
2. **Feminidad**: Paleta Rose Gold y formas redondeadas
3. **Profesionalismo**: Información clara y bien organizada
4. **Accesibilidad**: Contraste adecuado y tamaños de fuente legibles
5. **Interactividad**: Animaciones sutiles que mejoran la experiencia

### Experiencia del Usuario

- **Primera Impresión**: Hero section impactante
- **Exploración**: Servicios fáciles de navegar
- **Acción**: CTAs claros y accesibles
- **Contacto**: Botones siempre visibles (flotantes)

---

## 📞 Configuración de Contacto

### WhatsApp

Actualizar número en `services_data.dart`:
```dart
static const String whatsappNumber = '+5255XXXXXXXXXX';
```

El mensaje predefinido es:
> "¡Hola! Me interesa conocer más sobre sus servicios de eventos 💐"

### Instagram

Actualizar handle en `services_data.dart`:
```dart
static const String instagramHandle = '@tu_usuario';
```

---

## ✅ Estado del Proyecto

### ✓ Completado

- [x] Paleta de colores elegante
- [x] Modelos de datos para servicios
- [x] Widgets reutilizables
- [x] Landing page completa
- [x] Integración con WhatsApp
- [x] Integración con Instagram
- [x] Diseño responsivo
- [x] Animaciones y transiciones
- [x] Contenido de ejemplo para 6 servicios
- [x] Modales de detalle por servicio

### 🎯 Próximos Pasos Sugeridos

1. Agregar imágenes reales en lugar de emojis
2. Implementar galería de fotos de eventos anteriores
3. Agregar testimonios de clientes
4. Crear formulario de contacto integrado
5. Agregar sistema de calendario para disponibilidad
6. Implementar blog con tips de organización de eventos

---

## 🎨 Diferencias Clave vs Diseño Anterior

| Aspecto | Antes | Ahora |
|---------|-------|-------|
| **Paleta** | Púrpura/Azul tech | Rose Gold/Champagne elegante |
| **Enfoque** | Plataforma de eventos | Servicios de eventos premium |
| **Audiencia** | General | Mujeres emprendedoras |
| **Contenido** | Gestión de eventos | Showcase de servicios |
| **CTAs** | Registro/Login | WhatsApp/Instagram directo |
| **Estilo** | Moderno tech | Elegante y sofisticado |
| **Colores** | Vibrantes | Suaves y refinados |

---

## 📱 Contacto y Soporte

Para personalización adicional o dudas, los archivos principales a modificar son:

1. **Colores**: `app_colors.dart`
2. **Servicios**: `services_data.dart`
3. **Diseño**: `landing_page_elegant.dart`
4. **Tema Global**: `app_theme.dart`

---

**Diseñado con ❤️ para emprendedoras que crean momentos inolvidables**

✨ YesyStyle - Eventos Elegantes ✨
