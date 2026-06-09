class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageBase64;
  final DateTime date;
  final int attendees;
  final String? location;
  final String? category;
  final bool isVisible;
  final DateTime createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageBase64,
    required this.date,
    this.attendees = 0,
    this.location,
    this.category,
    this.isVisible = true,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'imageBase64': imageBase64 ?? '',
    'date': date.toIso8601String(),
    'attendees': attendees,
    'location': location ?? '',
    'category': category ?? '',
    'isVisible': isVisible,
    'createdAt': createdAt.toIso8601String(),
  };

  factory EventModel.fromMap(Map<dynamic, dynamic> map) => EventModel(
    id: map['id'] as String,
    title: map['title'] as String,
    description: map['description'] as String,
    imageBase64: (map['imageBase64'] as String?) == '' ? null : map['imageBase64'] as String?,
    date: DateTime.parse(map['date'] as String),
    attendees: (map['attendees'] as int?) ?? 0,
    location: (map['location'] as String?) == '' ? null : map['location'] as String?,
    category: (map['category'] as String?) == '' ? null : map['category'] as String?,
    isVisible: (map['isVisible'] as bool?) ?? true,
    createdAt: DateTime.parse(map['createdAt'] as String),
  );

  EventModel copyWith({
    String? id, String? title, String? description,
    String? imageBase64, DateTime? date, int? attendees,
    String? location, String? category, bool? isVisible, DateTime? createdAt,
  }) => EventModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    imageBase64: imageBase64 ?? this.imageBase64,
    date: date ?? this.date,
    attendees: attendees ?? this.attendees,
    location: location ?? this.location,
    category: category ?? this.category,
    isVisible: isVisible ?? this.isVisible,
    createdAt: createdAt ?? this.createdAt,
  );
}
