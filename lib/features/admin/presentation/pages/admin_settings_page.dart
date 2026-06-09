import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/content_providers.dart';
import '../widgets/admin_layout.dart';
import '../widgets/admin_widgets.dart';
import '../widgets/image_picker_widget.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _siteName = TextEditingController();
  final _subtitle = TextEditingController();
  final _whatsapp = TextEditingController();
  final _instagram = TextEditingController();
  String? _heroBase64;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<SettingsProvider>();
      _siteName.text = p.siteName;
      _subtitle.text = p.siteSubtitle;
      _whatsapp.text = p.whatsapp;
      _instagram.text = p.instagram;
      setState(() => _heroBase64 = p.heroImageBase64.isEmpty ? null : p.heroImageBase64);
    });
  }

  @override
  void dispose() {
    _siteName.dispose();
    _subtitle.dispose();
    _whatsapp.dispose();
    _instagram.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<SettingsProvider>().save(
          siteName: _siteName.text.trim(),
          siteSubtitle: _subtitle.text.trim(),
          whatsapp: _whatsapp.text.trim(),
          instagram: _instagram.text.trim(),
          heroImageBase64: _heroBase64,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración guardada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      currentRoute: '/admin/settings',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AdminTopBar(title: 'CONFIGURACIÓN', onAdd: _noop, addLabel: 'GUARDAR'),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AdminSectionTitle('IDENTIDAD DEL SITIO'),
                    const SizedBox(height: 16),
                    AdminField(
                      controller: _siteName,
                      label: 'Nombre del sitio *',
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 12),
                    AdminField(
                      controller: _subtitle,
                      label: 'Subtítulo *',
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 24),
                    const AdminSectionTitle('HERO / PORTADA'),
                    const SizedBox(height: 16),
                    ImagePickerWidget(
                      currentBase64: _heroBase64,
                      onImageSelected: (v) => setState(() => _heroBase64 = v),
                      height: 220,
                    ),
                    const SizedBox(height: 24),
                    const AdminSectionTitle('REDES / CONTACTO'),
                    const SizedBox(height: 16),
                    AdminField(controller: _whatsapp, label: 'WhatsApp (solo número o URL)'),
                    const SizedBox(height: 12),
                    AdminField(controller: _instagram, label: 'Instagram (usuario o URL)'),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.save_outlined, size: 16),
                        label: const Text('GUARDAR CAMBIOS'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _noop() {}
