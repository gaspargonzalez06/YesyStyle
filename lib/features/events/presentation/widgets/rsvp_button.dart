import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/rsvp.dart';

class RSVPButton extends StatefulWidget {
  final RSVPStatus? currentStatus;
  final int attendeeCount;
  final bool isFull;
  final Function(RSVPStatus) onStatusChanged;

  const RSVPButton({
    Key? key,
    this.currentStatus,
    required this.attendeeCount,
    this.isFull = false,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  State<RSVPButton> createState() => _RSVPButtonState();
}

class _RSVPButtonState extends State<RSVPButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;
  late Animation<double> _scaleAnimation;
  bool _showRipple = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(RSVPStatus status) {
    setState(() => _showRipple = true);
    _controller.forward(from: 0.0).then((_) {
      setState(() => _showRipple = false);
    });
    widget.onStatusChanged(status);
  }

  Color _getButtonColor(RSVPStatus? status) {
    if (status == null) return AppColors.roseGold;
    switch (status) {
      case RSVPStatus.going:
        return AppColors.success;
      case RSVPStatus.maybe:
        return AppColors.warning;
      case RSVPStatus.notGoing:
        return AppColors.error;
      case RSVPStatus.waitlist:
        return AppColors.info;
    }
  }

  IconData _getButtonIcon(RSVPStatus? status) {
    if (status == null) return Icons.add;
    switch (status) {
      case RSVPStatus.going:
        return Icons.check_circle;
      case RSVPStatus.maybe:
        return Icons.help_outline;
      case RSVPStatus.notGoing:
        return Icons.cancel;
      case RSVPStatus.waitlist:
        return Icons.schedule;
    }
  }

  String _getButtonText(RSVPStatus? status) {
    if (status == null) {
      return widget.isFull ? 'Lista de Espera' : 'Asistir';
    }
    switch (status) {
      case RSVPStatus.going:
        return 'Confirmado';
      case RSVPStatus.maybe:
        return 'Quizás';
      case RSVPStatus.notGoing:
        return 'No Asistiré';
      case RSVPStatus.waitlist:
        return 'En Espera';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main RSVP Button
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple effect
                  if (_showRipple)
                    Container(
                      width: 200 * _rippleAnimation.value,
                      height: 200 * _rippleAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getButtonColor(widget.currentStatus)
                            .withOpacity(0.3 * (1 - _rippleAnimation.value)),
                      ),
                    ),
                  
                  // Button
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getButtonColor(widget.currentStatus),
                          _getButtonColor(widget.currentStatus).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              _getButtonColor(widget.currentStatus).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.currentStatus == null
                            ? () => _handleTap(widget.isFull
                                ? RSVPStatus.waitlist
                                : RSVPStatus.going)
                            : null,
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getButtonIcon(widget.currentStatus),
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _getButtonText(widget.currentStatus),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        
        // Attendee count
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.people,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '${widget.attendeeCount} personas asistirán',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        
        // Change RSVP options
        if (widget.currentStatus != null) ...[
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Cambiar respuesta:',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickOption(RSVPStatus.going, 'Voy', Icons.check),
              _buildQuickOption(RSVPStatus.maybe, 'Quizás', Icons.help_outline),
              _buildQuickOption(RSVPStatus.notGoing, 'No voy', Icons.close),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuickOption(RSVPStatus status, String label, IconData icon) {
    final bool isSelected = widget.currentStatus == status;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: isSelected
            ? _getButtonColor(status).withOpacity(0.1)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => _handleTap(status),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? _getButtonColor(status)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected
                      ? _getButtonColor(status)
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? _getButtonColor(status)
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
