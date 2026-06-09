# YesyStyle Events - Event Organizer Platform

Un organizador de eventos moderno y elegante desarrollado con Flutter Web.

## 🎨 Características Principales

### Diseño y Tema
- **Paleta de colores moderna**: Azul oscuro (#1a237e), púrpura vibrante (#7c4dff), blanco roto
- **Diseño minimalista** con gradientes sutiles y bordes redondeados
- **Tipografía**: Poppins para títulos, Inter para cuerpo de texto
- **Tema personalizado** completamente configurado en `lib/core/theme/`

### Pantallas Implementadas

#### 1. Landing Page (`/`)
- Hero section con animación de partículas de fondo interactivas
- Gradientes animados
- Secciones de features con glassmorphism
- Estadísticas animadas
- CTA buttons con transiciones fluidas

#### 2. Dashboard (`/dashboard`)
- Grid responsive de eventos con animaciones staggered
- Barra de búsqueda en tiempo real
- Filtros por categoría y estado
- Vista de calendario integrada
- Transiciones suaves entre vistas

#### 3. Event Detail (`/event/:id`)
- Hero image con parallax effect
- Información detallada del evento
- Sistema de RSVP interactivo
- Tags y categorías
- Información del organizador
- Mapa de ubicación

## 🏗️ Arquitectura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada
├── core/                          # Funcionalidades core
│   ├── constants/
│   │   ├── app_colors.dart       # Paleta de colores
│   │   ├── app_text_styles.dart  # Estilos de texto
│   │   └── breakpoints.dart      # Breakpoints responsive
│   ├── router/
│   │   └── app_router.dart       # Configuración de rutas (go_router)
│   └── theme/
│       └── app_theme.dart        # Tema de la aplicación
├── features/                      # Módulos por característica
│   └── events/
│       ├── data/
│       │   └── repositories/
│       │       └── mock_event_repository.dart  # Datos mock
│       ├── domain/
│       │   └── models/
│       │       ├── event.dart    # Modelo de evento
│       │       ├── user.dart     # Modelo de usuario
│       │       └── rsvp.dart     # Modelo de RSVP
│       └── presentation/
│           ├── pages/
│           │   ├── landing_page.dart
│           │   ├── dashboard_page.dart
│           │   └── event_detail_page.dart
│           └── widgets/
│               └── rsvp_button.dart
└── shared/                        # Componentes compartidos
    ├── animations/
    │   └── particle_background.dart
    └── widgets/
        ├── event_card.dart
        └── animated_calendar.dart
```

## 🚀 Cómo Ejecutar

### Requisitos
- Flutter 3.10.7 o superior
- Dart SDK compatible
- Chrome (para Flutter Web)

### Instalación

1. **Instalar dependencias**
```bash
flutter pub get
```

2. **Ejecutar en modo desarrollo**
```bash
flutter run -d chrome
```

3. **Build para producción**
```bash
flutter build web
```

## 📦 Dependencias Principales

```yaml
dependencies:
  # Routing
  go_router: ^14.0.0
  
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  
  # Animations
  lottie: ^3.0.0
  animations: ^2.0.11
  shimmer: ^3.0.0
  
  # UI Components
  glassmorphism: ^3.0.0
  table_calendar: ^3.0.9
  google_fonts: ^6.1.0
```

## 🎯 Componentes Principales

### EventCard
Card de evento con imagen, animación hover, badge de estado y progreso de asistentes.

### RSVPButton
Botón interactivo con animaciones de confirmación y efecto ripple.

### AnimatedCalendar
Calendario con eventos marcados y transiciones suaves.

### ParticleBackground
Sistema de partículas interactivo para el hero section.

---

**¡Disfruta organizando eventos! 🎉**
