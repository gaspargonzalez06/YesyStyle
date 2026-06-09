import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/content_providers.dart';
import '../../../../shared/widgets/contact_buttons.dart';
import '../../../../shared/widgets/service_card.dart';
import '../../data/services_data.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _heroController;
  late final Animation<double> _heroFade;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _heroController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    _heroFade = CurvedAnimation(parent: _heroController, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _heroController.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp() async {
    final url = Uri.parse(ServicesData.getWhatsAppLink('Hola, quiero cotizar mi evento.'));
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchInstagram() async {
    final url = Uri.parse(ServicesData.getInstagramLink());
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _goTo(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 650), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final services = ServicesData.getAllServices();
    final events = context.watch<EventsProvider>().visibleEvents;
    final products = context.watch<ProductsProvider>().visibleProducts;
    final posts = context.watch<BlogProvider>().visiblePosts;
    final isMobile = MediaQuery.of(context).size.width < 920;

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          const _PremiumBackground(),
          SafeArea(
            child: Column(
              children: [
                _TopBar(
                  isMobile: isMobile,
                  currentPage: _currentPage,
                  onJump: _goTo,
                  onAdminTap: () => context.go('/admin-login'),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    children: [
                      _HeroSlide(
                        fade: _heroFade,
                        onCta: () => _goTo(1),
                        onWhatsApp: _launchWhatsApp,
                      ),
                      _ServicesSlide(services: services, onServiceTap: _goTo),
                      _ShowcaseSlide(events: events, products: products, posts: posts),
                      _AboutSlide(onWhatsApp: _launchWhatsApp, onInstagram: _launchInstagram),
                    ],
                  ),
                ),
                _BottomRail(
                  currentPage: _currentPage,
                  onJump: _goTo,
                ),
              ],
            ),
          ),
          Positioned(
            right: 18,
            bottom: 18,
            child: ContactButtons(
              onWhatsAppPressed: _launchWhatsApp,
              onInstagramPressed: _launchInstagram,
              showLabels: false,
              size: 56,
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumBackground extends StatelessWidget {
  const _PremiumBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.35,
            colors: [Color(0xFF151515), Color(0xFF050505)],
          ),
        ),
        child: CustomPaint(
          painter: _GridPainter(),
          child: Container(),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0x12E2C56D)
      ..strokeWidth = 0.7;
    const spacing = 42.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TopBar extends StatelessWidget {
  final bool isMobile;
  final int currentPage;
  final void Function(int) onJump;
  final VoidCallback onAdminTap;
  const _TopBar({required this.isMobile, required this.currentPage, required this.onJump, required this.onAdminTap});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Home', 'Servicios', 'Portfolio', 'Nosotros'];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A).withValues(alpha: 0.78),
        border: Border.all(color: const Color(0xFF3A2F1A)),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 22, offset: Offset(0, 10))],
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gold, width: 1.4),
            ),
            transform: Matrix4.rotationZ(0.785),
          ),
          const SizedBox(width: 10),
          const Text('YESYSTYLE', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w800, letterSpacing: 2.4)),
          const Spacer(),
          if (!isMobile)
            ...List.generate(tabs.length, (index) {
              final active = currentPage == index;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () => onJump(index),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: active ? AppColors.goldLight : const Color(0xFFD0C4A1),
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          OutlinedButton(
            onPressed: onAdminTap,
            child: const Text('ADMIN'),
          ),
        ],
      ),
    );
  }
}

class _HeroSlide extends StatelessWidget {
  final Animation<double> fade;
  final VoidCallback onCta;
  final Future<void> Function() onWhatsApp;
  const _HeroSlide({required this.fade, required this.onCta, required this.onWhatsApp});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fade,
      builder: (context, _) {
        final tilt = (1 - fade.value) * 0.12;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateX(tilt)
                ..rotateY(-tilt * 0.7),
              child: Opacity(
                opacity: fade.value,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1300),
                  height: 640,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFF433519)),
                    boxShadow: const [
                      BoxShadow(color: Color(0xAA000000), blurRadius: 30, offset: Offset(0, 18)),
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF121212), Color(0xFF050505), Color(0xFF16110A)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -40,
                        top: -40,
                        child: _GlowCircle(color: AppColors.gold.withValues(alpha: 0.18), size: 220),
                      ),
                      Positioned(
                        left: -20,
                        bottom: -20,
                        child: _GlowCircle(color: Colors.white.withValues(alpha: 0.05), size: 180),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'EVENTOS DE LUJO',
                              style: TextStyle(color: AppColors.gold, letterSpacing: 3, fontWeight: FontWeight.w800, fontSize: 12),
                            ),
                            const Spacer(),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 760),
                              child: const Text(
                                'Experiencias premium\ncon estética negra y dorada',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                  height: 0.98,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -1.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 720),
                              child: const Text(
                                'Una landing con presencia editorial, secciones interactivas y contenido administrable para que tu hermana pueda cargar eventos, posts y productos sin tocar código.',
                                style: TextStyle(color: Color(0xFFD9CCB0), fontSize: 16, height: 1.7),
                              ),
                            ),
                            const SizedBox(height: 26),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: onCta,
                                  child: const Text('EXPLORAR EXPERIENCIA'),
                                ),
                                OutlinedButton(
                                  onPressed: onWhatsApp,
                                  child: const Text('WHATSAPP'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 26,
                        bottom: 26,
                        child: _HeroCardStack(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeroCardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.04,
      child: Container(
        width: 300,
        height: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF4A3A18)),
          color: const Color(0xFF0E0E0E),
          boxShadow: const [BoxShadow(color: Color(0x99000000), blurRadius: 24, offset: Offset(0, 14))],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [AppColors.gold.withValues(alpha: 0.18), Colors.transparent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 20,
              child: Text('Brand Card', style: TextStyle(color: AppColors.gold, letterSpacing: 2, fontSize: 11)),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Bodas', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('Eventos sociales\nBranding\nBlog editable', style: TextStyle(color: Color(0xFFD9CCB0), height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _ServicesSlide extends StatelessWidget {
  final List<dynamic> services;
  final void Function(int) onServiceTap;
  const _ServicesSlide({required this.services, required this.onServiceTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0B0B),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF352A14)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(title: 'SERVICIOS', subtitle: 'Cada servicio es una pieza de colección.'),
              const SizedBox(height: 22),
              Expanded(
                child: GridView.builder(
                  itemCount: services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.55,
                  ),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _TiltServiceCard(service: service, index: index, onTap: () => onServiceTap(0));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TiltServiceCard extends StatefulWidget {
  final dynamic service;
  final int index;
  final VoidCallback onTap;
  const _TiltServiceCard({required this.service, required this.index, required this.onTap});

  @override
  State<_TiltServiceCard> createState() => _TiltServiceCardState();
}

class _TiltServiceCardState extends State<_TiltServiceCard> {
  double _dx = 0;
  double _dy = 0;

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    final tilt = Matrix4.identity()
      ..setEntry(3, 2, 0.0012)
      ..rotateX(_dy)
      ..rotateY(-_dx);

    return MouseRegion(
      onHover: (e) {
        setState(() {
          _dx = (e.localPosition.dx / 300 - 0.5) * 0.12;
          _dy = (e.localPosition.dy / 220 - 0.5) * 0.12;
        });
      },
      onExit: (_) => setState(() {
        _dx = 0;
        _dy = 0;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform(
          alignment: Alignment.center,
          transform: tilt,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F5EE),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE8D9B2)),
              boxShadow: const [BoxShadow(color: Color(0x18C9A84C), blurRadius: 18, offset: Offset(0, 10))],
            ),
            child: ServiceCard(service: s, onTap: widget.onTap),
          ),
        ),
      ),
    );
  }
}

class _ShowcaseSlide extends StatelessWidget {
  final List<dynamic> events;
  final List<dynamic> products;
  final List<dynamic> posts;
  const _ShowcaseSlide({required this.events, required this.products, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFEADDBB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(title: 'PUBLICADO', subtitle: 'Lo que admin actualiza aparece aquí automáticamente.'),
              const SizedBox(height: 22),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final stacked = constraints.maxWidth < 1050;
                    final cards = [
                      _ShowcasePanel(title: 'Eventos', icon: Icons.event_outlined, children: events.take(3).map((e) => _BulletRow(title: e.title, subtitle: '${e.attendees} asistentes · ${e.location ?? 'Sin ubicación'}')).toList()),
                      _ShowcasePanel(title: 'Blog', icon: Icons.article_outlined, children: posts.take(3).map((p) => _BulletRow(title: p.title, subtitle: p.content)).toList()),
                      _ShowcasePanel(title: 'Productos', icon: Icons.shopping_bag_outlined, children: products.take(3).map((p) => _BulletRow(title: p.name, subtitle: p.price == null ? p.description : '\$${p.price!.toStringAsFixed(2)}')).toList()),
                    ];
                    if (stacked) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cards.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 14),
                        itemBuilder: (context, index) => cards[index],
                      );
                    }
                    return Row(
                      children: cards
                          .map((card) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 7), child: card)))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShowcasePanel extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const _ShowcasePanel({required this.title, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF0C0C0C),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF372B15)),
          boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 8))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Icon(icon, color: AppColors.gold, size: 18), const SizedBox(width: 8), Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))]),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      );
}

class _BulletRow extends StatelessWidget {
  final String title;
  final String subtitle;
  const _BulletRow({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0x223A2F1A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFD7C9A9), fontSize: 12)),
          ],
        ),
      );
}

class _AboutSlide extends StatelessWidget {
  final Future<void> Function() onWhatsApp;
  final Future<void> Function() onInstagram;
  const _AboutSlide({required this.onWhatsApp, required this.onInstagram});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0B0B),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF352A14)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(title: 'EXPERIENCIA', subtitle: 'Diseño editorial, lujo real y manejo simple para el cliente.'),
              const SizedBox(height: 22),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final stacked = constraints.maxWidth < 1050;
                    final left = _InfoCard(
                      title: 'Autogestionable',
                      subtitle: 'La web está lista para que el panel admin cargue posts, eventos y productos sin tocar código.',
                      bullets: const ['Plantillas predeterminadas', 'Imágenes opcionales', 'Bordes dorados', 'Visibilidad por sección'],
                    );
                    final right = _InfoCard(
                      title: 'Contacto',
                      subtitle: 'Canales rápidos para cotizar y cerrar más clientes.',
                      bullets: const ['WhatsApp directo', 'Instagram visible', 'Acceso admin oculto', 'Experiencia premium'],
                      actions: [
                        ElevatedButton(onPressed: onWhatsApp, child: const Text('WHATSAPP')),
                        OutlinedButton(onPressed: onInstagram, child: const Text('INSTAGRAM')),
                      ],
                    );

                    if (stacked) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 2,
                        separatorBuilder: (context, index) => const SizedBox(height: 14),
                        itemBuilder: (context, index) => index == 0 ? left : right,
                      );
                    }

                    return Row(children: [Expanded(child: left), const SizedBox(width: 14), Expanded(child: right)]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> bullets;
  final List<Widget> actions;
  const _InfoCard({required this.title, required this.subtitle, required this.bullets, this.actions = const []});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF372B15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: Color(0xFFD7C9A9), height: 1.6)),
            const SizedBox(height: 14),
            ...bullets.map((b) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text('• $b', style: const TextStyle(color: Colors.white70)))),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(spacing: 10, runSpacing: 10, children: actions),
            ],
          ],
        ),
      );
}

class _BottomRail extends StatelessWidget {
  final int currentPage;
  final void Function(int) onJump;
  const _BottomRail({required this.currentPage, required this.onJump});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A).withValues(alpha: 0.72),
          border: Border.all(color: const Color(0xFF3A2F1A)),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            _Dot(label: '01', active: currentPage == 0, onTap: () => onJump(0)),
            _Dot(label: '02', active: currentPage == 1, onTap: () => onJump(1)),
            _Dot(label: '03', active: currentPage == 2, onTap: () => onJump(2)),
            _Dot(label: '04', active: currentPage == 3, onTap: () => onJump(3)),
            const Spacer(),
            Text('YesyStyle · Eventos premium', style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Dot({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 12),
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: active ? AppColors.gold : Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: active ? AppColors.goldLight : const Color(0xFF382D17)),
            ),
            child: Text(label, style: TextStyle(color: active ? Colors.black : Colors.white70, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
        ),
      );
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: 0.2)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Color(0xFFD7C9A9), fontSize: 14, height: 1.5)),
        ],
      );
}
