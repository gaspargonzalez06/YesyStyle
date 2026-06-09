class ProductModel {
  final String id;
  final String name;
  final String description;
  final String? imageBase64;
  final double? price;
  final String? category;
  final bool isVisible;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageBase64,
    this.price,
    this.category,
    this.isVisible = true,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'imageBase64': imageBase64 ?? '',
    'price': price ?? 0.0,
    'category': category ?? '',
    'isVisible': isVisible,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) => ProductModel(
    id: map['id'] as String,
    name: map['name'] as String,
    description: map['description'] as String,
    imageBase64: (map['imageBase64'] as String?) == '' ? null : map['imageBase64'] as String?,
    price: (map['price'] as num?)?.toDouble(),
    category: (map['category'] as String?) == '' ? null : map['category'] as String?,
    isVisible: (map['isVisible'] as bool?) ?? true,
    createdAt: DateTime.parse(map['createdAt'] as String),
  );

  ProductModel copyWith({
    String? id, String? name, String? description, String? imageBase64,
    double? price, String? category, bool? isVisible, DateTime? createdAt,
  }) => ProductModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageBase64: imageBase64 ?? this.imageBase64,
    price: price ?? this.price,
    category: category ?? this.category,
    isVisible: isVisible ?? this.isVisible,
    createdAt: createdAt ?? this.createdAt,
  );
}
