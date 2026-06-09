import 'package:equatable/equatable.dart';

enum EventCategory {
  conference,
  workshop,
  meetup,
  party,
  sports,
  concert,
  exhibition,
  other
}

enum EventStatus {
  upcoming,
  ongoing,
  finished,
  cancelled
}

class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final DateTime? endDateTime;
  final String location;
  final String imageUrl;
  final EventCategory category;
  final EventStatus status;
  final int maxAttendees;
  final int currentAttendees;
  final String organizerId;
  final String organizerName;
  final List<String> tags;
  final double? latitude;
  final double? longitude;
  final bool isOnline;
  final String? onlineLink;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.endDateTime,
    required this.location,
    required this.imageUrl,
    required this.category,
    required this.status,
    required this.maxAttendees,
    this.currentAttendees = 0,
    required this.organizerId,
    required this.organizerName,
    this.tags = const [],
    this.latitude,
    this.longitude,
    this.isOnline = false,
    this.onlineLink,
  });

  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    DateTime? endDateTime,
    String? location,
    String? imageUrl,
    EventCategory? category,
    EventStatus? status,
    int? maxAttendees,
    int? currentAttendees,
    String? organizerId,
    String? organizerName,
    List<String>? tags,
    double? latitude,
    double? longitude,
    bool? isOnline,
    String? onlineLink,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      status: status ?? this.status,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      currentAttendees: currentAttendees ?? this.currentAttendees,
      organizerId: organizerId ?? this.organizerId,
      organizerName: organizerName ?? this.organizerName,
      tags: tags ?? this.tags,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isOnline: isOnline ?? this.isOnline,
      onlineLink: onlineLink ?? this.onlineLink,
    );
  }

  bool get isFull => currentAttendees >= maxAttendees;
  double get fillPercentage => (currentAttendees / maxAttendees) * 100;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dateTime,
        endDateTime,
        location,
        imageUrl,
        category,
        status,
        maxAttendees,
        currentAttendees,
        organizerId,
        organizerName,
        tags,
        latitude,
        longitude,
        isOnline,
        onlineLink,
      ];
}
