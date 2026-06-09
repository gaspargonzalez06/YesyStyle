import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ContactButtons extends StatelessWidget {
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onInstagramPressed;
  final bool showLabels;
  final double size;

  const ContactButtons({
    Key? key,
    required this.onWhatsAppPressed,
    required this.onInstagramPressed,
    this.showLabels = true,
    this.size = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ContactButton(
          icon: Icons.sd,
          label: 'WhatsApp',
          color: const Color(0xFF25D366),
          onPressed: onWhatsAppPressed,
          showLabel: showLabels,
          size: size,
        ),
        const SizedBox(width: 16),
        _ContactButton(
          icon: Icons.camera_alt,
          label: 'Instagram',
          gradient: const LinearGradient(
            colors: [Color(0xFFF58529), Color(0xFFDD2A7B), Color(0xFF8134AF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onPressed: onInstagramPressed,
          showLabel: showLabels,
          size: size,
        ),
      ],
    );
  }
}

class _ContactButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final LinearGradient? gradient;
  final VoidCallback onPressed;
  final bool showLabel;
  final double size;

  const _ContactButton({
    required this.icon,
    required this.label,
    this.color,
    this.gradient,
    required this.onPressed,
    required this.showLabel,
    required this.size,
  });

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onPressed,
        child: widget.showLabel
            ? _buildWithLabel()
            : _buildIconOnly(),
      ),
    );
  }

  Widget _buildIconOnly() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        gradient: widget.gradient,
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.size / 2),
        boxShadow: [
          BoxShadow(
            color: (widget.color ?? AppColors.primary).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        widget.icon,
        color: Colors.white,
        size: widget.size * 0.5,
      ),
    );
  }

  Widget _buildWithLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: widget.gradient,
        color: widget.color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: (widget.color ?? AppColors.primary).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
