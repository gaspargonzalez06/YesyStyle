class BlogPostModel {
  final String id;
  final String title;
  final String content;
  final String? imageBase64;
  final String? tags;
  final bool isVisible;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogPostModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageBase64,
    this.tags,
    this.isVisible = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'imageBase64': imageBase64 ?? '',
    'tags': tags ?? '',
    'isVisible': isVisible,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory BlogPostModel.fromMap(Map<dynamic, dynamic> map) => BlogPostModel(
    id: map['id'] as String,
    title: map['title'] as String,
    content: map['content'] as String,
    imageBase64: (map['imageBase64'] as String?) == '' ? null : map['imageBase64'] as String?,
    tags: (map['tags'] as String?) == '' ? null : map['tags'] as String?,
    isVisible: (map['isVisible'] as bool?) ?? true,
    createdAt: DateTime.parse(map['createdAt'] as String),
    updatedAt: DateTime.parse(map['updatedAt'] as String),
  );

  BlogPostModel copyWith({
    String? id, String? title, String? content, String? imageBase64,
    String? tags, bool? isVisible, DateTime? createdAt, DateTime? updatedAt,
  }) => BlogPostModel(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    imageBase64: imageBase64 ?? this.imageBase64,
    tags: tags ?? this.tags,
    isVisible: isVisible ?? this.isVisible,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  List<String> get tagList =>
    tags == null || tags!.isEmpty ? [] : tags!.split(',').map((t) => t.trim()).toList();
}
