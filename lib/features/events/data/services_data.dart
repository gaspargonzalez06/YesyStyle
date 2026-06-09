import 'package:flutter/material.dart';
import '../domain/models/service_category.dart';
import '../../../core/constants/app_colors.dart';

class ServicesData {
  static const String whatsappNumber = '+525512345678'; // Cambiar por el número real
  static const String instagramHandle = '@yesystyle_eventos'; // Cambiar por el handle real
  
  static List<ServiceCategory> getAllServices() {
    return [
      // Tardes de Té
      ServiceCategory(
        id: 'tea-party',
        type: ServiceType.teaParty,
        title: 'Tardes de Té',
        subtitle: 'Momentos de elegancia y distinción',
        description: 
            'Creamos experiencias únicas de tarde de té con la más alta elegancia. '
            'Cada detalle está cuidadosamente pensado para ofrecer un momento inolvidable '
            'lleno de sofisticación, desde la selección de tés finos hasta la vajilla más exquisita.',
        icon: Icons.emoji_food_beverage,
        color: AppColors.teaPartyColor,
        gradientStart: AppColors.blushPink,
        gradientEnd: AppColors.dustyRose,
        heroImage: '☕',
        features: [
          'Selección de tés premium importados',
          'Repostería artesanal y bocadillos gourmet',
          'Vajilla fina y cristalería elegante',
          'Decoración temática personalizada',
          'Ambientación musical suave',
          'Servicio de mesa profesional',
          'Arreglos florales frescos',
          'Menús personalizados para cada ocasión',
        ],
        galleryImages: ['🫖', '🍰', '🌸', '☕', '🎀', '💐'],
      ),

      // Bodas
      ServiceCategory(
        id: 'weddings',
        type: ServiceType.weddings,
        title: 'Bodas de Ensueño',
        subtitle: 'Tu día perfecto, realidad',
        description: 
            'Transformamos tus sueños en realidad con bodas diseñadas a la perfección. '
            'Cada boda es única y reflejamos tu esencia en cada detalle, desde la ceremonia '
            'hasta la recepción, creando momentos mágicos que durarán para siempre.',
        icon: Icons.favorite,
        color: AppColors.weddingColor,
        gradientStart: AppColors.warmBeige,
        gradientEnd: AppColors.champagne,
        heroImage: '💍',
        features: [
          'Planificación completa de la boda',
          'Coordinación de ceremonia y recepción',
          'Diseño de decoración personalizada',
          'Selección de proveedores premium',
          'Asesoría de imagen y protocolo',
          'Coordinación el día del evento',
          'Diseño de invitaciones y papelería',
          'Ambientación y flores naturales',
        ],
        galleryImages: ['💒', '👰', '💐', '🎊', '🥂', '💕'],
      ),

      // Servicios Musicales
      ServiceCategory(
        id: 'music',
        type: ServiceType.musicServices,
        title: 'Servicios Musicales',
        subtitle: 'La melodía perfecta para cada momento',
        description: 
            'Ofrecemos músicos profesionales para dar vida a tus eventos. Desde el dulce sonido '
            'del violín hasta la elegancia del piano, cada nota está diseñada para crear '
            'la atmósfera perfecta y hacer de tu evento una experiencia sensorial única.',
        icon: Icons.music_note,
        color: AppColors.musicColor,
        gradientStart: AppColors.softLavender,
        gradientEnd: AppColors.blushPink,
        heroImage: '🎻',
        features: [
          'Violinista profesional en vivo',
          'Pianista para ceremonias',
          'Cuarteto de cuerdas',
          'Música clásica y contemporánea',
          'Repertorio personalizado',
          'Arpa para ceremonias especiales',
          'Cantantes líricos',
          'Asesoría musical para tu evento',
        ],
        galleryImages: ['🎹', '🎼', '🎵', '🎶', '🎺', '🎸'],
      ),

      // Decoraciones
      ServiceCategory(
        id: 'decorations',
        type: ServiceType.decorations,
        title: 'Decoraciones Exclusivas',
        subtitle: 'Ambientes que inspiran',
        description: 
            'Diseñamos y creamos decoraciones únicas que transforman espacios en escenarios '
            'de ensueño. Cada elemento decorativo es seleccionado y dispuesto con maestría '
            'para crear ambientes que reflejan elegancia, sofisticación y buen gusto.',
        icon: Icons.auto_awesome,
        color: AppColors.decorationColor,
        gradientStart: AppColors.goldenAccent,
        gradientEnd: AppColors.warmBeige,
        heroImage: '✨',
        features: [
          'Diseño de concepto decorativo',
          'Arreglos florales a medida',
          'Mobiliario elegante y exclusivo',
          'Iluminación ambiental profesional',
          'Backdrops y fondos temáticos',
          'Centros de mesa personalizados',
          'Telas y textiles de alta calidad',
          'Coordinación de paleta de colores',
        ],
        galleryImages: ['🌺', '🕯️', '🎀', '🌹', '💫', '🎨'],
      ),

      // Organización de Eventos
      ServiceCategory(
        id: 'organization',
        type: ServiceType.eventOrganization,
        title: 'Organización de Eventos',
        subtitle: 'Perfección en cada detalle',
        description: 
            'Nos encargamos de cada aspecto de tu evento para que tú solo disfrutes. '
            'Con experiencia en organización de eventos de todo tipo, garantizamos que '
            'cada momento sea perfecto, desde la planificación hasta la ejecución.',
        icon: Icons.event_note,
        color: AppColors.organizationColor,
        gradientStart: AppColors.roseGold,
        gradientEnd: AppColors.dustyRose,
        heroImage: '📋',
        features: [
          'Planificación integral del evento',
          'Coordinación de proveedores',
          'Timeline y cronograma detallado',
          'Logística y montaje',
          'Gestión de invitados',
          'Coordinación el día del evento',
          'Solución de imprevistos',
          'Seguimiento post-evento',
        ],
        galleryImages: ['🎉', '🎊', '🎈', '🎁', '📅', '✅'],
      ),

      // Equipos y Más
      ServiceCategory(
        id: 'equipment',
        type: ServiceType.equipment,
        title: 'Equipos & Servicios',
        subtitle: 'Todo lo que necesitas',
        description: 
            'Proveemos todo el equipo necesario para hacer de tu evento un éxito. '
            'Contamos con mobiliario, equipo audiovisual, vajilla, cristalería y todo '
            'lo necesario para complementar tu celebración con la más alta calidad.',
        icon: Icons.category,
        color: AppColors.primary,
        gradientStart: AppColors.primaryLight,
        gradientEnd: AppColors.primary,
        heroImage: '🎪',
        features: [
          'Mobiliario elegante (mesas, sillas, lounge)',
          'Vajilla fina y cristalería',
          'Equipo audiovisual profesional',
          'Carpas y toldos elegantes',
          'Pista de baile iluminada',
          'Fotomatón y accesorios',
          'Servicio de meseros profesionales',
          'Renta de menaje completo',
        ],
        galleryImages: ['🪑', '🍽️', '🎙️', '💡', '🎥', '⛺'],
      ),
    ];
  }

  static ServiceCategory? getServiceById(String id) {
    try {
      return getAllServices().firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<ServiceCategory> getServicesByType(ServiceType type) {
    return getAllServices().where((service) => service.type == type).toList();
  }

  static String getWhatsAppLink(String message) {
    final encodedMessage = Uri.encodeComponent(message);
    return 'https://wa.me/$whatsappNumber?text=$encodedMessage';
  }

  static String getInstagramLink() {
    return 'https://instagram.com/${instagramHandle.replaceAll('@', '')}';
  }
}
