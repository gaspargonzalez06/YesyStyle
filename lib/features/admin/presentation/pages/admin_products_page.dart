import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/content_providers.dart';
import '../widgets/admin_layout.dart';
import '../widgets/admin_widgets.dart';
import '../widgets/image_picker_widget.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();
    return AdminLayout(
      currentRoute: '/admin/products',
      child: Column(
        children: [
          AdminTopBar(title: 'PRODUCTOS', onAdd: () => _showForm(context, null)),
          Expanded(
            child: provider.products.isEmpty
                ? const Center(
                    child: Text('No hay productos.', style: TextStyle(color: AppColors.whiteGhost)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: provider.products.length,
                    itemBuilder: (ctx, i) {
                      final p = provider.products[i];
                      return _ProductTile(
                        product: p,
                        onEdit: () => _showForm(context, p),
                        onDelete: () => _confirmDelete(context, p.id, provider),
                        onToggle: () => provider.toggleVisibility(p.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showForm(BuildContext context, ProductModel? existing) {
    showDialog(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.85),
      builder: (dlgCtx) => ChangeNotifierProvider.value(
        value: context.read<ProductsProvider>(),
        child: _ProductFormDialog(existing: existing),
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, String id, ProductsProvider provider) {
    showDialog(
      context: ctx,
      builder: (dlgCtx) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: const Text('¿Eliminar este producto?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dlgCtx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              provider.delete(id);
              Navigator.pop(dlgCtx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const _ProductTile({
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        border: Border.all(color: AppColors.blackBorder),
      ),
      child: Row(
        children: [
          if (product.imageBase64 != null && product.imageBase64!.isNotEmpty)
            SizedBox(
              width: 100,
              height: 80,
              child: Image.memory(base64Decode(product.imageBase64!), fit: BoxFit.cover),
            )
          else
            const EmptyImagePlaceholder(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                if (product.price != null)
                  Text('\$${product.price!.toStringAsFixed(2)}',
                      style: const TextStyle(color: AppColors.gold, fontSize: 13)),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.whiteGhost, fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              VisibilityChip(isVisible: product.isVisible, onTap: onToggle),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                color: AppColors.whiteGhost,
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                color: AppColors.error,
                onPressed: onDelete,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductFormDialog extends StatefulWidget {
  final ProductModel? existing;
  const _ProductFormDialog({this.existing});

  @override
  State<_ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<_ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _desc;
  late final TextEditingController _price;
  late final TextEditingController _category;
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    final p = widget.existing;
    _name = TextEditingController(text: p?.name ?? '');
    _desc = TextEditingController(text: p?.description ?? '');
    _price = TextEditingController(text: p?.price?.toStringAsFixed(2) ?? '');
    _category = TextEditingController(text: p?.category ?? '');
    _imageBase64 = p?.imageBase64;
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _price.dispose();
    _category.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<ProductsProvider>();
    final p = widget.existing;

    final model = p != null
        ? p.copyWith(
            name: _name.text.trim(),
            description: _desc.text.trim(),
            imageBase64: _imageBase64,
            price: double.tryParse(_price.text),
            category: _category.text.trim(),
          )
        : provider.createNew(
            name: _name.text.trim(),
            description: _desc.text.trim(),
            imageBase64: _imageBase64,
            price: double.tryParse(_price.text),
            category: _category.text.trim(),
          );

    if (p != null) {
      provider.update(model);
    } else {
      provider.add(model);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existing == null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
        child: Column(
          children: [
            AdminDialogHeader(isNew ? 'NUEVO PRODUCTO' : 'EDITAR PRODUCTO'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImagePickerWidget(
                        currentBase64: _imageBase64,
                        onImageSelected: (v) => setState(() => _imageBase64 = v),
                        height: 160,
                      ),
                      const SizedBox(height: 20),
                      AdminField(
                        controller: _name,
                        label: 'Nombre *',
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),
                      AdminField(
                        controller: _desc,
                        label: 'Descripción *',
                        maxLines: 3,
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AdminField(
                              controller: _price,
                              label: 'Precio',
                              keyboardType: TextInputType.number,
                              prefixText: '\$  ',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AdminField(
                              controller: _category,
                              label: 'Categoría',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AdminDialogFooter(onSave: _save, saveLabel: isNew ? 'CREAR' : 'GUARDAR'),
          ],
        ),
      ),
    );
  }
}
