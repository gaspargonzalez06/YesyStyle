import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/auth_provider.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  const AdminLayout({super.key, required this.child, required this.currentRoute});

  static const _navItems = [
    (icon: Icons.dashboard_outlined, label: 'Dashboard', route: '/admin'),
    (icon: Icons.event_outlined,     label: 'Eventos',   route: '/admin/events'),
    (icon: Icons.shopping_bag_outlined, label: 'Productos', route: '/admin/products'),
    (icon: Icons.article_outlined,   label: 'Blog',      route: '/admin/blog'),
    (icon: Icons.settings_outlined,  label: 'Config',    route: '/admin/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.blackSoft,
        elevation: 0,
        title: Row(
          children: [
            _goldDiamond(),
            const SizedBox(width: 10),
            Text('YESYSTYLE',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(width: 8),
            Text('ADMIN',
              style: TextStyle(
                color: AppColors.whiteGhost,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go('/');
            },
            icon: const Icon(Icons.logout, size: 16),
            label: const Text('Salir', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
        ],
        bottom: isWide
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: _buildTabBar(context),
              ),
      ),
      body: isWide
          ? Row(
              children: [
                _buildSideRail(context),
                const VerticalDivider(
                  color: AppColors.blackBorder, width: 1, thickness: 1),
                Expanded(child: child),
              ],
            )
          : child,
    );
  }

  Widget _buildSideRail(BuildContext context) {
    return Container(
      width: 200,
      color: AppColors.blackSoft,
      child: Column(
        children: [
          const SizedBox(height: 16),
          ..._navItems.map((item) => _NavTile(
            icon: item.icon,
            label: item.label,
            route: item.route,
            isSelected: currentRoute == item.route,
          )),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _navItems.map((item) => InkWell(
          onTap: () => context.go(item.route),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: currentRoute == item.route
                      ? AppColors.gold : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(item.label,
              style: TextStyle(
                color: currentRoute == item.route
                    ? AppColors.gold : AppColors.whiteGhost,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _goldDiamond() => Container(
    width: 16, height: 16,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.gold, width: 1.5),
      shape: BoxShape.rectangle,
    ),
    transform: Matrix4.rotationZ(0.785),
    transformAlignment: Alignment.center,
  );
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool isSelected;
  const _NavTile({
    required this.icon, required this.label,
    required this.route, required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blackBorder : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.gold : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
              color: isSelected ? AppColors.gold : AppColors.whiteGhost,
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(label,
              style: TextStyle(
                color: isSelected ? AppColors.gold : AppColors.whiteGhost,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
