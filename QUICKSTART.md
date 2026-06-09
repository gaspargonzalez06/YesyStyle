# 🚀 Guía Rápida de Inicio

## Pasos para ejecutar el proyecto

### 1. Verificar instalación de Flutter
```bash
flutter doctor
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Ejecutar la aplicación en Chrome
```bash
flutter run -d chrome
```

### 4. Opciones adicionales

#### Ejecutar en modo release (más rápido)
```bash
flutter run -d chrome --release
```

#### Ejecutar con hot reload habilitado
```bash
flutter run -d chrome --hot
```

#### Especificar puerto para el servidor web
```bash
flutter run -d chrome --web-port=8080
```

### 5. Build para producción
```bash
flutter build web
```
Los archivos compilados estarán en `build/web/`

### 6. Servir los archivos en producción

#### Con servidor HTTP simple de Python
```bash
cd build/web
python -m http.server 8000
```

#### Con servidor HTTP de Node.js
```bash
cd build/web
npx http-server -p 8000
```

## 🎯 Navegación en la App

- **Página principal**: `http://localhost:<port>/`
- **Dashboard**: `http://localhost:<port>/dashboard`
- **Detalle de evento**: `http://localhost:<port>/event/:id`

## 🔧 Solución de Problemas

### Error: "No se encuentra Chrome"
```bash
# En Windows, asegúrate de tener Chrome instalado
# O especifica el ejecutable:
flutter run -d chrome --chrome-binary="C:\Program Files\Google\Chrome\Application\chrome.exe"
```

### Error en dependencias
```bash
# Limpiar caché y reinstalar
flutter clean
flutter pub get
```

### Hot reload no funciona
```bash
# Reiniciar con hot reload explícito
flutter run -d chrome --hot
```

## 📱 Probar en diferentes dispositivos

### Desktop (Windows)
```bash
flutter run -d windows
```

### Edge browser
```bash
flutter run -d edge
```

### Listar todos los dispositivos disponibles
```bash
flutter devices
```

## 🎨 Características implementadas

✅ Landing page con animación de partículas
✅ Dashboard con grid de eventos
✅ Filtros y búsqueda en tiempo real
✅ Vista de calendario integrada
✅ Página de detalle de evento
✅ Sistema de RSVP interactivo
✅ Animaciones fluidas en todas las pantallas
✅ Diseño responsive (mobile, tablet, desktop)
✅ Tema personalizado con paleta moderna
✅ Routing con go_router

## 📚 Próximos pasos

1. Explorar el código en `lib/`
2. Revisar los modelos en `lib/features/events/domain/models/`
3. Personalizar colores en `lib/core/constants/app_colors.dart`
4. Agregar más eventos mock en `lib/features/events/data/repositories/mock_event_repository.dart`
5. Implementar nuevas features según tu necesidad

## 💡 Tips de Desarrollo

- Usa **hot reload** (presiona `r` en la terminal) para ver cambios instantáneos
- Usa **hot restart** (presiona `R` en la terminal) para reiniciar la app
- Presiona `p` para mostrar el grid de depuración
- Presiona `q` para salir

¡Disfruta programando! 🎉
