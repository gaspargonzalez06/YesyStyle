import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/constants/app_colors.dart';

/// Widget reutilizable para seleccionar y previsualizar imágenes (base64).
class ImagePickerWidget extends StatelessWidget {
  final String? currentBase64;
  final ValueChanged<String?> onImageSelected;
  final double height;

  const ImagePickerWidget({
    super.key,
    this.currentBase64,
    required this.onImageSelected,
    this.height = 180,
  });

  Future<void> _pick() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;
    final base64Str = base64Encode(bytes);
    onImageSelected(base64Str);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pick,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.blackCard,
          border: Border.all(
            color: currentBase64 != null ? AppColors.gold : AppColors.blackBorder,
            width: 1,
          ),
        ),
        child: currentBase64 != null && currentBase64!.isNotEmpty
            ? Stack(
                children: [
                  Positioned.fill(
                    child: Image.memory(
                      base64Decode(currentBase64!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8, right: 8,
                    child: Row(
                      children: [
                        _iconBtn(Icons.edit, _pick),
                        const SizedBox(width: 8),
                        _iconBtn(Icons.close, () => onImageSelected(null)),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_photo_alternate_outlined,
                    color: AppColors.gold, size: 32),
                  const SizedBox(height: 8),
                  Text('Toca para subir imagen',
                    style: TextStyle(
                      color: AppColors.whiteGhost,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(6),
      color: AppColors.black.withValues(alpha: 0.7),
      child: Icon(icon, color: AppColors.gold, size: 16),
    ),
  );
}
