import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Claves para los boxes de Hive (tablas)
class HiveBoxes {
  static const String settings  = 'settings';
  static const String auth      = 'auth';
  static const String events    = 'events';
  static const String products  = 'products';
  static const String blogPosts = 'blog_posts';
}

/// Claves de settings globales
class SettingsKeys {
  static const String siteName        = 'site_name';
  static const String siteSubtitle    = 'site_subtitle';
  static const String heroImageBase64 = 'hero_image_base64';
  static const String whatsapp        = 'whatsapp';
  static const String instagram       = 'instagram';
}

/// Inicializa Hive y abre todos los boxes.
/// Si la BD no existe, Hive la crea automáticamente.
/// Si no existe admin, se crea uno por defecto.
class AppDatabase {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(HiveBoxes.settings),
      Hive.openBox(HiveBoxes.auth),
      Hive.openBox(HiveBoxes.events),
      Hive.openBox(HiveBoxes.products),
      Hive.openBox(HiveBoxes.blogPosts),
    ]);
    await _seedDefaultAdmin();
    await _seedDefaultSettings();
    await _seedDemoContent();
    _initialized = true;
  }

  /// Crea admin por defecto si no existe ninguno
  static Future<void> _seedDefaultAdmin() async {
    final box = Hive.box(HiveBoxes.auth);
    if (box.isEmpty) {
      // SHA-256 de 'YesyStyle2024!' generado en runtime
      box.put('admin', {
        'username': 'admin',
        'passwordHash': _sha256('YesyStyle2024!'),
        'createdAt': DateTime.now().toIso8601String(),
      });
    }
  }

  /// Crea configuraciones por defecto si no existen
  static Future<void> _seedDefaultSettings() async {
    final box = Hive.box(HiveBoxes.settings);
    if (!box.containsKey(SettingsKeys.siteName)) {
      box.put(SettingsKeys.siteName, 'YesyStyle');
      box.put(SettingsKeys.siteSubtitle, 'Eventos que cuentan historias');
      box.put(SettingsKeys.whatsapp, '');
      box.put(SettingsKeys.instagram, '');
      box.put(SettingsKeys.heroImageBase64, '');
    }
  }

  /// Carga contenido demo para ver el diseño mientras no haya data real.
  static Future<void> _seedDemoContent() async {
    final events = Hive.box(HiveBoxes.events);
    final products = Hive.box(HiveBoxes.products);
    final blog = Hive.box(HiveBoxes.blogPosts);

    if (events.isEmpty) {
      await events.putAll({
        'demo-event-1': {
          'id': 'demo-event-1',
          'title': 'Boda Vintage Dorada',
          'description': 'Montaje integral de boda con estilo clásico elegante y detalles en dorado.',
          'imageBase64': '',
          'date': DateTime.now().add(const Duration(days: 12)).toIso8601String(),
          'attendees': 140,
          'location': 'Salón Imperial',
          'category': 'Bodas',
          'isVisible': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
        'demo-event-2': {
          'id': 'demo-event-2',
          'title': 'Cumpleaños Luxury 30',
          'description': 'Celebración premium con mesa principal, ambientación moderna y show en vivo.',
          'imageBase64': '',
          'date': DateTime.now().add(const Duration(days: 20)).toIso8601String(),
          'attendees': 85,
          'location': 'Casa de Eventos Aurora',
          'category': 'Cumpleaños',
          'isVisible': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
        'demo-event-3': {
          'id': 'demo-event-3',
          'title': 'Tea Party Elegante',
          'description': 'Evento íntimo con decoración floral y servicio personalizado.',
          'imageBase64': '',
          'date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
          'attendees': 45,
          'location': 'Jardín Magnolia',
          'category': 'Social',
          'isVisible': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
      });
    }

    if (products.isEmpty) {
      await products.putAll({
        'demo-product-1': {
          'id': 'demo-product-1',
          'name': 'Paquete Decoración Premium',
          'description': 'Incluye mesa principal, centros de mesa y ambientación completa.',
          'imageBase64': '',
          'price': 899.00,
          'category': 'Decoración',
          'isVisible': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
        'demo-product-2': {
          'id': 'demo-product-2',
          'name': 'Candy Bar Personalizado',
          'description': 'Diseño temático con dulces premium y montaje profesional.',
          'imageBase64': '',
          'price': 420.00,
          'category': 'Mesa dulce',
          'isVisible': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
        'demo-product-3': {
          'id': 'demo-product-3',
          'name': 'Coordinación de Evento',
          'description': 'Planificación, logística y coordinación en día de evento.',
          'imageBase64': '',
          'price': 650.00,
          'category': 'Organización',
          'isVisible': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
      });
    }

    if (blog.isEmpty) {
      final now = DateTime.now().toIso8601String();
      await blog.putAll({
        'demo-blog-1': {
          'id': 'demo-blog-1',
          'title': '5 claves para un evento inolvidable',
          'content': 'Define un concepto, cuida la iluminación, elige una paleta coherente y crea una experiencia emocional.',
          'imageBase64': '',
          'tags': 'eventos, diseño, consejos',
          'isVisible': true,
          'createdAt': now,
          'updatedAt': now,
        },
        'demo-blog-2': {
          'id': 'demo-blog-2',
          'title': 'Tendencias 2026 en decoración',
          'content': 'Texturas naturales, acentos metálicos dorados y composiciones minimalistas marcan la tendencia.',
          'imageBase64': '',
          'tags': 'tendencias, decoracion',
          'isVisible': true,
          'createdAt': now,
          'updatedAt': now,
        },
      });
    }
  }

  static String _sha256(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  static Box get settingsBox => Hive.box(HiveBoxes.settings);
  static Box get authBox     => Hive.box(HiveBoxes.auth);
  static Box get eventsBox   => Hive.box(HiveBoxes.events);
  static Box get productsBox => Hive.box(HiveBoxes.products);
  static Box get blogBox     => Hive.box(HiveBoxes.blogPosts);
}
