import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/content_providers.dart';
import '../widgets/admin_layout.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events   = context.watch<EventsProvider>();
    final products = context.watch<ProductsProvider>();
    final blog     = context.watch<BlogProvider>();

    final recentEvents = events.events.take(3).toList();
    final recentPosts  = blog.posts.take(3).toList();

    return AdminLayout(
      currentRoute: '/admin',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('RESUMEN'),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16, runSpacing: 16,
              children: [
                _StatCard(
                  label: 'Eventos',
                  total: events.events.length,
                  visible: events.visibleEvents.length,
                  icon: Icons.event,
                ),
                _StatCard(
                  label: 'Productos',
                  total: products.products.length,
                  visible: products.visibleProducts.length,
                  icon: Icons.shopping_bag_outlined,
                ),
                _StatCard(
                  label: 'Blog Posts',
                  total: blog.posts.length,
                  visible: blog.visiblePosts.length,
                  icon: Icons.article_outlined,
                ),
              ],
            ),
            const SizedBox(height: 48),
            const _SectionTitle('ÚLTIMOS EVENTOS'),
            const SizedBox(height: 16),
            if (recentEvents.isEmpty)
              const _EmptyHint('No hay eventos aún. Ve a Eventos para crear el primero.')
            else
              ...recentEvents.map((e) => _RecentTile(
                title: e.title,
                subtitle: '${e.date.day}/${e.date.month}/${e.date.year} · ${e.attendees} asistentes',
                isVisible: e.isVisible,
              )),
            const SizedBox(height: 48),
            const _SectionTitle('ÚLTIMAS ENTRADAS BLOG'),
            const SizedBox(height: 16),
            if (recentPosts.isEmpty)
              const _EmptyHint('No hay posts aún.')
            else
              ...recentPosts.map((p) => _RecentTile(
                title: p.title,
                subtitle: '${p.createdAt.day}/${p.createdAt.month}/${p.createdAt.year}',
                isVisible: p.isVisible,
              )),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(width: 3, height: 18, color: AppColors.gold),
      const SizedBox(width: 10),
      Text(text,
        style: const TextStyle(
          color: AppColors.gold,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.5,
        ),
      ),
    ],
  );
}

class _StatCard extends StatelessWidget {
  final String label;
  final int total;
  final int visible;
  final IconData icon;
  const _StatCard({
    required this.label, required this.total, required this.visible,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) => Container(
      width: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        border: Border.all(color: AppColors.blackBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.gold, size: 24),
          const SizedBox(height: 16),
          Text('$total',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
            style: const TextStyle(color: AppColors.whiteGhost, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text('$visible visibles',
            style: const TextStyle(color: AppColors.gold, fontSize: 11, letterSpacing: 1),
          ),
        ],
      ),
  );
}

class _RecentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isVisible;
  const _RecentTile({required this.title, required this.subtitle, required this.isVisible});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.blackCard,
      border: Border(left: BorderSide(color: AppColors.goldBorder, width: 1)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(subtitle,
                style: const TextStyle(color: AppColors.whiteGhost, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: isVisible ? AppColors.gold : AppColors.blackBorder,
            ),
          ),
          child: Text(
            isVisible ? 'VISIBLE' : 'OCULTO',
            style: TextStyle(
              color: isVisible ? AppColors.gold : AppColors.whiteGhost,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    ),
  );
}

class _EmptyHint extends StatelessWidget {
  final String text;
  const _EmptyHint(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.blackBorder),
    ),
    child: Text(text,
      style: const TextStyle(color: AppColors.whiteGhost, fontSize: 13),
    ),
  );
}
