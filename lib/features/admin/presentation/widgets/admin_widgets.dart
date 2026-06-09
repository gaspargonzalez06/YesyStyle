import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Barra superior de secciones admin con título y botón "Nuevo"
class AdminTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onAdd;
  final String addLabel;
  const AdminTopBar({
    super.key,
    required this.title,
    required this.onAdd,
    this.addLabel = 'NUEVO',
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.blackBorder)),
    ),
    child: Row(
      children: [
        Container(width: 3, height: 18, color: AppColors.gold),
        const SizedBox(width: 10),
        Text(title,
          style: const TextStyle(
            color: AppColors.gold, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 2.5,
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 16),
          label: Text(addLabel),
        ),
      ],
    ),
  );
}

/// Chip que muestra visibilidad y permite togglearla
class VisibilityChip extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onTap;
  const VisibilityChip({super.key, required this.isVisible, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
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
          fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

/// Título de sección en admin
class AdminSectionTitle extends StatelessWidget {
  final String text;
  const AdminSectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(width: 3, height: 18, color: AppColors.gold),
      const SizedBox(width: 10),
      Text(text,
        style: const TextStyle(
          color: AppColors.gold, fontSize: 11,
          fontWeight: FontWeight.w700, letterSpacing: 2.5,
        ),
      ),
    ],
  );
}

/// Campo de texto con estilo admin
class AdminField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? prefixText;

  const AdminField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: keyboardType,
    validator: validator,
    style: const TextStyle(color: AppColors.white, fontSize: 14),
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefixText,
      prefixStyle: const TextStyle(color: AppColors.gold),
    ),
  );
}

/// Dialog header reutilizable
class AdminDialogHeader extends StatelessWidget {
  final String title;
  const AdminDialogHeader(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.blackBorder)),
    ),
    child: Row(
      children: [
        Text(title,
          style: const TextStyle(
            color: AppColors.gold, fontSize: 12,
            fontWeight: FontWeight.w700, letterSpacing: 2,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

/// Footer de dialogs con botones
class AdminDialogFooter extends StatelessWidget {
  final VoidCallback onSave;
  final String saveLabel;
  const AdminDialogFooter({super.key, required this.onSave, this.saveLabel = 'GUARDAR'});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: AppColors.blackBorder)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(onPressed: onSave, child: Text(saveLabel)),
      ],
    ),
  );
}

/// Placeholder de imagen vacía en listas
class EmptyImagePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  const EmptyImagePlaceholder({super.key, this.width = 100, this.height = 80});
  @override
  Widget build(BuildContext context) => Container(
    width: width, height: height,
    color: AppColors.blackBorder,
    child: const Icon(Icons.image_not_supported_outlined,
      color: AppColors.whiteGhost, size: 24),
  );
}
