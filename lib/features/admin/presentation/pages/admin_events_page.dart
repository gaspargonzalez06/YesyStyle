import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/content_templates.dart';
import '../../../../models/event_model.dart';
import '../../../../providers/content_providers.dart';
import '../widgets/admin_layout.dart';
import '../widgets/admin_widgets.dart';
import '../widgets/image_picker_widget.dart';

class AdminEventsPage extends StatelessWidget {
  const AdminEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventsProvider>();
    return AdminLayout(
      currentRoute: '/admin/events',
      child: Column(
        children: [
          AdminTopBar(title: 'EVENTOS', onAdd: () => _showEventForm(context, null)),
          Expanded(
            child: provider.events.isEmpty
                ? const Center(child: Text('No hay eventos. Crea el primero.',
                    style: TextStyle(color: AppColors.whiteGhost)))
                : ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: provider.events.length,
                    itemBuilder: (ctx, i) {
                      final e = provider.events[i];
                      return EventAdminTile(
                        event: e,
                        onEdit: () => _showEventForm(context, e),
                        onDelete: () => _confirmDelete(context, e.id, provider),
                        onToggle: () => provider.toggleVisibility(e.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEventForm(BuildContext context, EventModel? existing) {
    showDialog(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.85),
      builder: (dlgCtx) => ChangeNotifierProvider.value(
        value: context.read<EventsProvider>(),
        child: EventFormDialog(existing: existing),
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, String id, EventsProvider provider) {
    showDialog(
      context: ctx,
      builder: (dlgCtx) => AlertDialog(
        title: const Text('Eliminar evento'),
        content: const Text('Esta accion no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dlgCtx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () { provider.delete(id); Navigator.pop(dlgCtx); },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class EventAdminTile extends StatelessWidget {
  final EventModel event;
  final VoidCallback onEdit, onDelete, onToggle;
  const EventAdminTile({super.key, required this.event, required this.onEdit,
    required this.onDelete, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy', 'es').format(event.date);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.blackCard,
        border: Border.all(color: AppColors.blackBorder)),
      child: Row(
        children: [
          if (event.imageBase64 != null && event.imageBase64!.isNotEmpty)
            SizedBox(width: 100, height: 80,
              child: Image.memory(base64Decode(event.imageBase64!), fit: BoxFit.cover))
          else
            const EmptyImagePlaceholder(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(event.title, style: const TextStyle(color: AppColors.white,
                fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('$dateStr · ${event.attendees} asistentes',
                style: const TextStyle(color: AppColors.whiteGhost, fontSize: 12)),
              if (event.location != null && event.location!.isNotEmpty)
                Text(event.location!, style: const TextStyle(color: AppColors.textLight, fontSize: 11)),
            ]),
          ),
          Row(children: [
            VisibilityChip(isVisible: event.isVisible, onTap: onToggle),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.edit_outlined, size: 18),
              color: AppColors.whiteGhost, onPressed: onEdit, tooltip: 'Editar'),
            IconButton(icon: const Icon(Icons.delete_outline, size: 18),
              color: AppColors.error, onPressed: onDelete, tooltip: 'Eliminar'),
            const SizedBox(width: 8),
          ]),
        ],
      ),
    );
  }
}

class EventFormDialog extends StatefulWidget {
  final EventModel? existing;
  const EventFormDialog({super.key, this.existing});
  @override
  State<EventFormDialog> createState() => _EventFormDialogState();
}

class _EventFormDialogState extends State<EventFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title, _desc, _location, _category, _attendees;
  String? _selectedTemplateId;
  DateTime _date = DateTime.now();
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _title     = TextEditingController(text: e?.title ?? '');
    _desc      = TextEditingController(text: e?.description ?? '');
    _location  = TextEditingController(text: e?.location ?? '');
    _category  = TextEditingController(text: e?.category ?? '');
    _attendees = TextEditingController(text: e?.attendees.toString() ?? '0');
    _date      = e?.date ?? DateTime.now();
    _imageBase64 = e?.imageBase64;
  }

  void _applyTemplate(String templateId) {
    final tpl = ContentTemplates.events.firstWhere((t) => t.id == templateId);
    setState(() {
      _selectedTemplateId = templateId;
      _title.text = tpl.title;
      _desc.text = tpl.description;
      _category.text = tpl.category;
    });
  }

  @override
  void dispose() {
    _title.dispose(); _desc.dispose(); _location.dispose();
    _category.dispose(); _attendees.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context, initialDate: _date,
      firstDate: DateTime(2020), lastDate: DateTime(2035),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.gold)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<EventsProvider>();
    final e = widget.existing;
    final model = e != null
        ? e.copyWith(title: _title.text.trim(), description: _desc.text.trim(),
            imageBase64: _imageBase64, date: _date,
            attendees: int.tryParse(_attendees.text) ?? 0,
            location: _location.text.trim(), category: _category.text.trim())
        : provider.createNew(title: _title.text.trim(), description: _desc.text.trim(),
            imageBase64: _imageBase64, date: _date,
            attendees: int.tryParse(_attendees.text) ?? 0,
            location: _location.text.trim(), category: _category.text.trim());
    if (e != null) { provider.update(model); } else { provider.add(model); }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existing == null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 700),
        child: Column(children: [
          AdminDialogHeader(isNew ? 'NUEVO EVENTO' : 'EDITAR EVENTO'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  ImagePickerWidget(currentBase64: _imageBase64,
                    onImageSelected: (v) => setState(() => _imageBase64 = v)),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedTemplateId,
                    decoration: const InputDecoration(labelText: 'Plantilla de evento'),
                    items: ContentTemplates.events
                        .map((t) => DropdownMenuItem(value: t.id, child: Text(t.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) _applyTemplate(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  AdminField(controller: _title, label: 'Titulo *',
                    validator: (v) => v!.isEmpty ? 'Requerido' : null),
                  const SizedBox(height: 16),
                  AdminField(controller: _desc, label: 'Descripcion *', maxLines: 4,
                    validator: (v) => v!.isEmpty ? 'Requerido' : null),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(child: AdminField(controller: _location, label: 'Ubicacion')),
                    const SizedBox(width: 12),
                    Expanded(child: AdminField(controller: _category, label: 'Categoria')),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: InkWell(onTap: _pickDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(labelText: 'Fecha del evento',
                            prefixIcon: Icon(Icons.calendar_today_outlined, size: 16)),
                          child: Text(DateFormat('dd/MM/yyyy').format(_date),
                            style: const TextStyle(color: AppColors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: AdminField(controller: _attendees, label: 'N asistentes',
                      keyboardType: TextInputType.number)),
                  ]),
                ]),
              ),
            ),
          ),
          AdminDialogFooter(onSave: _save, saveLabel: isNew ? 'CREAR' : 'GUARDAR'),
        ]),
      ),
    );
  }
}
