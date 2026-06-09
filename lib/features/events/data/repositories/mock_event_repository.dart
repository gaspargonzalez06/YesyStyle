import '../../domain/models/event.dart';

class MockEventRepository {
  static List<Event> getMockEvents() {
    final now = DateTime.now();
    
    return [
      Event(
        id: '1',
        title: 'Flutter Web Conference 2026',
        description: 'Únete a los mejores desarrolladores de Flutter para discutir las últimas tendencias y mejores prácticas en desarrollo web con Flutter.',
        dateTime: now.add(const Duration(days: 7)),
        endDateTime: now.add(const Duration(days: 7, hours: 8)),
        location: 'Centro de Convenciones TechHub',
        imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
        category: EventCategory.conference,
        status: EventStatus.upcoming,
        maxAttendees: 500,
        currentAttendees: 287,
        organizerId: 'org1',
        organizerName: 'Flutter Community',
        tags: ['flutter', 'web', 'development', 'tech'],
        latitude: 40.7128,
        longitude: -74.0060,
      ),
      
      Event(
        id: '2',
        title: 'Workshop: Animaciones en Flutter',
        description: 'Aprende a crear animaciones espectaculares en Flutter desde cero. Incluye ejercicios prácticos y proyectos reales.',
        dateTime: now.add(const Duration(days: 3)),
        endDateTime: now.add(const Duration(days: 3, hours: 4)),
        location: 'Online via Zoom',
        imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
        category: EventCategory.workshop,
        status: EventStatus.upcoming,
        maxAttendees: 50,
        currentAttendees: 45,
        organizerId: 'org2',
        organizerName: 'Animation Masters',
        tags: ['flutter', 'animations', 'workshop', 'online'],
        isOnline: true,
        onlineLink: 'https://zoom.us/meeting/example',
      ),
      
      Event(
        id: '3',
        title: 'Meetup: Desarrolladores Flutter México',
        description: 'Networking casual con desarrolladores Flutter. Comparte experiencias, proyectos y conoce a la comunidad local.',
        dateTime: now.add(const Duration(days: 2)),
        endDateTime: now.add(const Duration(days: 2, hours: 3)),
        location: 'Café Code & Coffee',
        imageUrl: 'https://images.unsplash.com/photo-1515187029135-18ee286d815b?w=800',
        category: EventCategory.meetup,
        status: EventStatus.upcoming,
        maxAttendees: 30,
        currentAttendees: 22,
        organizerId: 'org3',
        organizerName: 'Flutter MX',
        tags: ['networking', 'flutter', 'community'],
        latitude: 19.4326,
        longitude: -99.1332,
      ),
      
      Event(
        id: '4',
        title: 'Hackathon: Build the Future',
        description: '24 horas de programación intensa. Forma equipos y crea la próxima gran aplicación Flutter.',
        dateTime: now.add(const Duration(days: 14)),
        endDateTime: now.add(const Duration(days: 15)),
        location: 'Innovation Hub',
        imageUrl: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800',
        category: EventCategory.conference,
        status: EventStatus.upcoming,
        maxAttendees: 200,
        currentAttendees: 156,
        organizerId: 'org4',
        organizerName: 'Tech Innovators',
        tags: ['hackathon', 'coding', 'competition'],
      ),
      
      Event(
        id: '5',
        title: 'Fiesta de Lanzamiento: App YesyStyle',
        description: '¡Celebra con nosotros el lanzamiento de nuestra nueva aplicación! Música, comida y networking.',
        dateTime: now.add(const Duration(days: 1)),
        endDateTime: now.add(const Duration(days: 1, hours: 5)),
        location: 'Rooftop Sky Lounge',
        imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800',
        category: EventCategory.party,
        status: EventStatus.upcoming,
        maxAttendees: 100,
        currentAttendees: 67,
        organizerId: 'org5',
        organizerName: 'YesyStyle Team',
        tags: ['party', 'launch', 'celebration'],
      ),
      
      Event(
        id: '6',
        title: 'Torneo de eSports: Flutter Edition',
        description: 'Compite en juegos desarrollados con Flutter. Premios para los ganadores.',
        dateTime: now.add(const Duration(days: 10)),
        location: 'Gaming Arena',
        imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
        category: EventCategory.sports,
        status: EventStatus.upcoming,
        maxAttendees: 64,
        currentAttendees: 38,
        organizerId: 'org6',
        organizerName: 'Flutter Gaming',
        tags: ['gaming', 'esports', 'competition'],
      ),
      
      Event(
        id: '7',
        title: 'Concierto: Developers Symphony',
        description: 'Una noche de música en vivo con artistas de la comunidad tech.',
        dateTime: now.subtract(const Duration(days: 5)),
        location: 'Auditorio Nacional',
        imageUrl: 'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=800',
        category: EventCategory.concert,
        status: EventStatus.finished,
        maxAttendees: 1000,
        currentAttendees: 950,
        organizerId: 'org7',
        organizerName: 'Tech Arts',
        tags: ['music', 'concert', 'entertainment'],
      ),
      
      Event(
        id: '8',
        title: 'Exposición: UI/UX Design Trends 2026',
        description: 'Descubre las últimas tendencias en diseño de interfaces y experiencia de usuario.',
        dateTime: now.add(const Duration(days: 5)),
        endDateTime: now.add(const Duration(days: 8)),
        location: 'Museo de Arte Moderno',
        imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
        category: EventCategory.exhibition,
        status: EventStatus.upcoming,
        maxAttendees: 300,
        currentAttendees: 112,
        organizerId: 'org8',
        organizerName: 'Design Masters',
        tags: ['design', 'ui', 'ux', 'trends'],
      ),
      
      Event(
        id: '9',
        title: 'Webinar: State Management en Flutter',
        description: 'Comparativa profunda de BLoC, Provider, Riverpod y GetX. Con ejemplos prácticos.',
        dateTime: now.add(const Duration(hours: 6)),
        endDateTime: now.add(const Duration(hours: 8)),
        location: 'Online',
        imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
        category: EventCategory.workshop,
        status: EventStatus.ongoing,
        maxAttendees: 500,
        currentAttendees: 423,
        organizerId: 'org9',
        organizerName: 'Flutter Experts',
        tags: ['webinar', 'state-management', 'online'],
        isOnline: true,
        onlineLink: 'https://youtube.com/live/example',
      ),
      
      Event(
        id: '10',
        title: 'Networking Breakfast: Founders & Developers',
        description: 'Desayuno networking para conectar fundadores de startups con desarrolladores talentosos.',
        dateTime: now.add(const Duration(days: 4)),
        location: 'Hotel Presidente',
        imageUrl: 'https://images.unsplash.com/photo-1511578314322-379afb476865?w=800',
        category: EventCategory.meetup,
        status: EventStatus.upcoming,
        maxAttendees: 40,
        currentAttendees: 40,
        organizerId: 'org10',
        organizerName: 'Startup Hub',
        tags: ['networking', 'startups', 'business'],
      ),
    ];
  }

  static Event? getEventById(String id) {
    try {
      return getMockEvents().firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Event> getEventsByCategory(EventCategory category) {
    return getMockEvents()
        .where((event) => event.category == category)
        .toList();
  }

  static List<Event> getEventsByStatus(EventStatus status) {
    return getMockEvents()
        .where((event) => event.status == status)
        .toList();
  }

  static List<Event> searchEvents(String query) {
    final lowerQuery = query.toLowerCase();
    return getMockEvents().where((event) {
      return event.title.toLowerCase().contains(lowerQuery) ||
          event.description.toLowerCase().contains(lowerQuery) ||
          event.location.toLowerCase().contains(lowerQuery) ||
          event.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
