import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/content_providers.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final events = context.watch<EventsProvider>().visibleEvents;
    final products = context.watch<ProductsProvider>().visibleProducts;
    final posts = context.watch<BlogProvider>().visiblePosts;

    final maxWidth = MediaQuery.of(context).size.width > 1200 ? 1200.0 : 1000.0;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF8),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopHeader(siteName: settings.siteName),
                  const SizedBox(height: 24),
                  _HeroCard(
                    title: settings.siteName,
                    subtitle: settings.siteSubtitle,
                    heroBase64: settings.heroImageBase64,
                  ),
                  const SizedBox(height: 36),
                  const _Section('Eventos destacados'),
                  const SizedBox(height: 12),
                  if (events.isEmpty)
                    const _EmptyCard('Pronto publicaremos nuevos eventos')
                  else
                    ...events.map((e) => _EventRow(event: e)),
                  const SizedBox(height: 24),
                  const _Section('Productos'),
                  const SizedBox(height: 12),
                  if (products.isEmpty)
                    const _EmptyCard('No hay productos disponibles')
                  else
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: products.map((p) => _ProductCard(product: p)).toList(),
                    ),
                  const SizedBox(height: 24),
                  const _Section('Blog'),
                  const SizedBox(height: 12),
                  if (posts.isEmpty)
                    const _EmptyCard('Sin publicaciones aún')
                  else
                    ...posts.map((p) => _BlogRow(post: p)),
                  const SizedBox(height: 26),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.go('/admin-login'),
                      child: Text('·', style: TextStyle(color: AppColors.gold.withValues(alpha: 0.35))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  final String siteName;
  const _TopHeader({required this.siteName});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gold, width: 1.4),
            ),
            transform: Matrix4.rotationZ(0.785),
            transformAlignment: Alignment.center,
          ),
          const SizedBox(width: 10),
          Text(
            siteName.toUpperCase(),
            style: const TextStyle(
              color: AppColors.goldDark,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.6,
            ),
          ),
        ],
      );
}

class _HeroCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String heroBase64;
  const _HeroCard({required this.title, required this.subtitle, required this.heroBase64});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8D9B2)),
        boxShadow: const [
          BoxShadow(color: Color(0x14C9A84C), blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (heroBase64.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(base64Decode(heroBase64), fit: BoxFit.cover),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.white.withValues(alpha: 0.78), Colors.white.withValues(alpha: 0.9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF33280F),
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(subtitle, style: const TextStyle(color: Color(0xFF6C5B35), fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String text;
  const _Section(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(text.toUpperCase(),
            style: const TextStyle(color: AppColors.goldDark, letterSpacing: 1.8, fontWeight: FontWeight.w700)),
      );
}

class _EventRow extends StatelessWidget {
  final dynamic event;
  const _EventRow({required this.event});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEEDFB8)),
        ),
        child: ListTile(
          leading: event.imageBase64 != null && event.imageBase64!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(base64Decode(event.imageBase64!), width: 56, fit: BoxFit.cover),
                )
              : const Icon(Icons.event_outlined, color: AppColors.gold),
          title: Text(event.title, style: const TextStyle(color: Color(0xFF33280F), fontWeight: FontWeight.w600)),
          subtitle: Text(
            '${DateFormat('dd/MM/yyyy').format(event.date)} · ${event.attendees} asistentes',
            style: const TextStyle(color: Color(0xFF6B5A34)),
          ),
        ),
      );
}

class _ProductCard extends StatelessWidget {
  final dynamic product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) => Container(
        width: 250,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEEDFB8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageBase64 != null && product.imageBase64!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(base64Decode(product.imageBase64!), height: 120, width: double.infinity, fit: BoxFit.cover),
              )
            else
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFFF8E7),
                ),
                child: const Center(child: Icon(Icons.image_outlined, color: AppColors.gold)),
              ),
            const SizedBox(height: 10),
            Text(product.name, style: const TextStyle(color: Color(0xFF33280F), fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              product.price == null ? product.description : '\$${product.price!.toStringAsFixed(2)}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF6B5A34), fontSize: 12),
            ),
          ],
        ),
      );
}

class _BlogRow extends StatelessWidget {
  final dynamic post;
  const _BlogRow({required this.post});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEEDFB8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: const TextStyle(color: Color(0xFF33280F), fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(
              post.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF6B5A34)),
            ),
          ],
        ),
      );
}

class _EmptyCard extends StatelessWidget {
  final String text;
  const _EmptyCard(this.text);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEDFB8)),
        ),
        child: Text(text, style: const TextStyle(color: Color(0xFF6B5A34))),
      );
}
