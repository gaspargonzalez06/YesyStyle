import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/content_templates.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../models/blog_post_model.dart';
import '../../../../providers/content_providers.dart';
import '../widgets/admin_layout.dart';
import '../widgets/admin_widgets.dart';
import '../widgets/image_picker_widget.dart';

class AdminBlogPage extends StatelessWidget {
  const AdminBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BlogProvider>();
    return AdminLayout(
      currentRoute: '/admin/blog',
      child: Column(
        children: [
          AdminTopBar(title: 'BLOG', onAdd: () => _showForm(context, null)),
          Expanded(
            child: provider.posts.isEmpty
                ? const Center(
                    child: Text('No hay entradas de blog.',
                        style: TextStyle(color: AppColors.whiteGhost)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: provider.posts.length,
                    itemBuilder: (ctx, i) {
                      final p = provider.posts[i];
                      return _BlogTile(
                        post: p,
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

  void _showForm(BuildContext context, BlogPostModel? existing) {
    showDialog(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.85),
      builder: (dlgCtx) => ChangeNotifierProvider.value(
        value: context.read<BlogProvider>(),
        child: _BlogFormDialog(existing: existing),
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, String id, BlogProvider provider) {
    showDialog(
      context: ctx,
      builder: (dlgCtx) => AlertDialog(
        title: const Text('Eliminar entrada'),
        content: const Text('¿Eliminar esta entrada del blog?'),
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

class _BlogTile extends StatelessWidget {
  final BlogPostModel post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const _BlogTile({
    required this.post,
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
          if (post.imageBase64 != null && post.imageBase64!.isNotEmpty)
            SizedBox(
              width: 100,
              height: 80,
              child: Image.memory(base64Decode(post.imageBase64!), fit: BoxFit.cover),
            )
          else
            const EmptyImagePlaceholder(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title,
                    style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(post.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.whiteGhost, fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: [
              VisibilityChip(isVisible: post.isVisible, onTap: onToggle),
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

class _BlogFormDialog extends StatefulWidget {
  final BlogPostModel? existing;
  const _BlogFormDialog({this.existing});

  @override
  State<_BlogFormDialog> createState() => _BlogFormDialogState();
}

class _BlogFormDialogState extends State<_BlogFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _content;
  late final TextEditingController _tags;
  String? _selectedTemplateId;
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    final p = widget.existing;
    _title = TextEditingController(text: p?.title ?? '');
    _content = TextEditingController(text: p?.content ?? '');
    _tags = TextEditingController(text: p?.tags ?? '');
    _imageBase64 = p?.imageBase64;
  }

  void _applyTemplate(String templateId) {
    final tpl = ContentTemplates.blog.firstWhere((t) => t.id == templateId);
    setState(() {
      _selectedTemplateId = templateId;
      _title.text = tpl.title;
      _content.text = tpl.content;
      _tags.text = tpl.tags;
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    _tags.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<BlogProvider>();
    final p = widget.existing;

    final model = p != null
        ? p.copyWith(
            title: _title.text.trim(),
            content: _content.text.trim(),
            tags: _tags.text.trim(),
            imageBase64: _imageBase64,
            updatedAt: DateTime.now(),
          )
        : provider.createNew(
            title: _title.text.trim(),
            content: _content.text.trim(),
            tags: _tags.text.trim(),
            imageBase64: _imageBase64,
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
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 700),
        child: Column(
          children: [
            AdminDialogHeader(isNew ? 'NUEVA ENTRADA BLOG' : 'EDITAR ENTRADA BLOG'),
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
                      DropdownButtonFormField<String>(
                        value: _selectedTemplateId,
                        decoration: const InputDecoration(
                          labelText: 'Plantilla predeterminada',
                        ),
                        items: ContentTemplates.blog
                            .map((t) => DropdownMenuItem(
                                  value: t.id,
                                  child: Text(t.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) _applyTemplate(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      AdminField(
                        controller: _title,
                        label: 'Título *',
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),
                      AdminField(
                        controller: _content,
                        label: 'Contenido *',
                        maxLines: 6,
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),
                      AdminField(
                        controller: _tags,
                        label: 'Tags (separados por coma)',
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
