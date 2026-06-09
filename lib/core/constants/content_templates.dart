class BlogTemplate {
  final String id;
  final String name;
  final String title;
  final String content;
  final String tags;

  const BlogTemplate({
    required this.id,
    required this.name,
    required this.title,
    required this.content,
    required this.tags,
  });
}

class EventTemplate {
  final String id;
  final String name;
  final String title;
  final String description;
  final String category;

  const EventTemplate({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.category,
  });
}

class ContentTemplates {
  static const List<BlogTemplate> blog = [
    BlogTemplate(
      id: 'tips',
      name: 'Tips del evento',
      title: '5 tips para que tu evento sea inolvidable',
      content:
          'Planifica con tiempo, define una paleta visual, cuida la iluminación, crea momentos fotografiables y ofrece una experiencia personalizada para tus invitados.',
      tags: 'tips,eventos,organizacion',
    ),
    BlogTemplate(
      id: 'trend',
      name: 'Tendencias',
      title: 'Tendencias elegantes para eventos 2026',
      content:
          'Los tonos neutros con acentos dorados, las texturas naturales y la decoración minimalista de alto impacto están marcando las celebraciones más modernas.',
      tags: 'tendencias,decoracion,inspiracion',
    ),
    BlogTemplate(
      id: 'case',
      name: 'Caso de éxito',
      title: 'Así transformamos una celebración en experiencia premium',
      content:
          'Desde el concepto inicial hasta la ejecución final, diseñamos cada detalle para transmitir estilo, emoción y coherencia visual en todo el evento.',
      tags: 'caso,portfolio,eventos',
    ),
  ];

  static const List<EventTemplate> events = [
    EventTemplate(
      id: 'wedding',
      name: 'Boda elegante',
      title: 'Boda de ensueño con estilo clásico',
      description:
          'Producción integral para boda con ambientación premium, diseño floral y coordinación completa del evento.',
      category: 'Bodas',
    ),
    EventTemplate(
      id: 'birthday',
      name: 'Cumpleaños luxury',
      title: 'Cumpleaños de alto impacto visual',
      description:
          'Montaje moderno con detalles dorados, mesa principal personalizada y experiencia visual premium.',
      category: 'Cumpleaños',
    ),
    EventTemplate(
      id: 'corporate',
      name: 'Evento corporativo',
      title: 'Evento corporativo con identidad de marca',
      description:
          'Producción elegante para marcas: escenografía, branding visual y logística profesional.',
      category: 'Corporativo',
    ),
  ];
}
