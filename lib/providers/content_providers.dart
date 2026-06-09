import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/database/app_database.dart';
import '../models/event_model.dart';
import '../models/product_model.dart';
import '../models/blog_post_model.dart';

const _uuid = Uuid();

// ─────────────────────────────────────────────────────────────────────────────
// EVENTS PROVIDER
// ─────────────────────────────────────────────────────────────────────────────
class EventsProvider extends ChangeNotifier {
  List<EventModel> _events = [];
  List<EventModel> get events => _events;
  List<EventModel> get visibleEvents => _events.where((e) => e.isVisible).toList();

  void load() {
    final box = AppDatabase.eventsBox;
    _events = box.values
        .map((v) => EventModel.fromMap(v as Map))
        .toList();
    _events.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> add(EventModel event) async {
    final box = AppDatabase.eventsBox;
    await box.put(event.id, event.toMap());
    load();
  }

  Future<void> update(EventModel event) async {
    final box = AppDatabase.eventsBox;
    await box.put(event.id, event.toMap());
    load();
  }

  Future<void> delete(String id) async {
    await AppDatabase.eventsBox.delete(id);
    load();
  }

  Future<void> toggleVisibility(String id) async {
    final box = AppDatabase.eventsBox;
    final raw = box.get(id) as Map?;
    if (raw == null) return;
    final event = EventModel.fromMap(raw);
    await box.put(id, event.copyWith(isVisible: !event.isVisible).toMap());
    load();
  }

  EventModel createNew({
    required String title,
    required String description,
    String? imageBase64,
    required DateTime date,
    int attendees = 0,
    String? location,
    String? category,
  }) => EventModel(
    id: _uuid.v4(),
    title: title,
    description: description,
    imageBase64: imageBase64,
    date: date,
    attendees: attendees,
    location: location,
    category: category,
    createdAt: DateTime.now(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// PRODUCTS PROVIDER
// ─────────────────────────────────────────────────────────────────────────────
class ProductsProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  List<ProductModel> get visibleProducts => _products.where((p) => p.isVisible).toList();

  void load() {
    final box = AppDatabase.productsBox;
    _products = box.values
        .map((v) => ProductModel.fromMap(v as Map))
        .toList();
    _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  Future<void> add(ProductModel product) async {
    await AppDatabase.productsBox.put(product.id, product.toMap());
    load();
  }

  Future<void> update(ProductModel product) async {
    await AppDatabase.productsBox.put(product.id, product.toMap());
    load();
  }

  Future<void> delete(String id) async {
    await AppDatabase.productsBox.delete(id);
    load();
  }

  Future<void> toggleVisibility(String id) async {
    final box = AppDatabase.productsBox;
    final raw = box.get(id) as Map?;
    if (raw == null) return;
    final product = ProductModel.fromMap(raw);
    await box.put(id, product.copyWith(isVisible: !product.isVisible).toMap());
    load();
  }

  ProductModel createNew({
    required String name,
    required String description,
    String? imageBase64,
    double? price,
    String? category,
  }) => ProductModel(
    id: _uuid.v4(),
    name: name,
    description: description,
    imageBase64: imageBase64,
    price: price,
    category: category,
    createdAt: DateTime.now(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOG PROVIDER
// ─────────────────────────────────────────────────────────────────────────────
class BlogProvider extends ChangeNotifier {
  List<BlogPostModel> _posts = [];
  List<BlogPostModel> get posts => _posts;
  List<BlogPostModel> get visiblePosts => _posts.where((p) => p.isVisible).toList();

  void load() {
    final box = AppDatabase.blogBox;
    _posts = box.values
        .map((v) => BlogPostModel.fromMap(v as Map))
        .toList();
    _posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  Future<void> add(BlogPostModel post) async {
    await AppDatabase.blogBox.put(post.id, post.toMap());
    load();
  }

  Future<void> update(BlogPostModel post) async {
    await AppDatabase.blogBox.put(post.id, post.toMap());
    load();
  }

  Future<void> delete(String id) async {
    await AppDatabase.blogBox.delete(id);
    load();
  }

  Future<void> toggleVisibility(String id) async {
    final box = AppDatabase.blogBox;
    final raw = box.get(id) as Map?;
    if (raw == null) return;
    final post = BlogPostModel.fromMap(raw);
    await box.put(id, post.copyWith(isVisible: !post.isVisible).toMap());
    load();
  }

  BlogPostModel createNew({
    required String title,
    required String content,
    String? imageBase64,
    String? tags,
  }) {
    final now = DateTime.now();
    return BlogPostModel(
      id: _uuid.v4(),
      title: title,
      content: content,
      imageBase64: imageBase64,
      tags: tags,
      createdAt: now,
      updatedAt: now,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SETTINGS PROVIDER
// ─────────────────────────────────────────────────────────────────────────────
class SettingsProvider extends ChangeNotifier {
  String _siteName = 'YesyStyle';
  String _siteSubtitle = 'Eventos que cuentan historias';
  String _whatsapp = '';
  String _instagram = '';
  String _heroImageBase64 = '';

  String get siteName => _siteName;
  String get siteSubtitle => _siteSubtitle;
  String get whatsapp => _whatsapp;
  String get instagram => _instagram;
  String get heroImageBase64 => _heroImageBase64;

  void load() {
    final box = AppDatabase.settingsBox;
    _siteName      = (box.get(SettingsKeys.siteName)      ?? 'YesyStyle') as String;
    _siteSubtitle  = (box.get(SettingsKeys.siteSubtitle)  ?? 'Eventos que cuentan historias') as String;
    _whatsapp      = (box.get(SettingsKeys.whatsapp)      ?? '') as String;
    _instagram     = (box.get(SettingsKeys.instagram)     ?? '') as String;
    _heroImageBase64 = (box.get(SettingsKeys.heroImageBase64) ?? '') as String;
    notifyListeners();
  }

  Future<void> save({
    required String siteName,
    required String siteSubtitle,
    String? whatsapp,
    String? instagram,
    String? heroImageBase64,
  }) async {
    final box = AppDatabase.settingsBox;
    await box.put(SettingsKeys.siteName,     siteName);
    await box.put(SettingsKeys.siteSubtitle, siteSubtitle);
    if (whatsapp != null)       await box.put(SettingsKeys.whatsapp, whatsapp);
    if (instagram != null)      await box.put(SettingsKeys.instagram, instagram);
    if (heroImageBase64 != null) await box.put(SettingsKeys.heroImageBase64, heroImageBase64);
    load();
  }
}
