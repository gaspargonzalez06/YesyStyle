import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/auth_provider.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    final ok = context.read<AuthProvider>().login(_userCtrl.text.trim(), _passCtrl.text);
    setState(() => _loading = false);
    if (ok) {
      context.go('/admin');
    } else {
      setState(() => _error = 'Credenciales incorrectas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo diamond
                _GoldDiamond(size: 48),
                const SizedBox(height: 24),
                Text('YESYSTYLE',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Acceso administrativo',
                  style: TextStyle(
                    color: AppColors.whiteGhost,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 48),

                // Card con borde dorado
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    border: Border.all(color: AppColors.goldBorder, width: 1),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _GoldField(
                          controller: _userCtrl,
                          label: 'USUARIO',
                          icon: Icons.person_outline,
                          validator: (v) => v!.isEmpty ? 'Ingresa tu usuario' : null,
                        ),
                        const SizedBox(height: 20),
                        _GoldField(
                          controller: _passCtrl,
                          label: 'CONTRASEÑA',
                          icon: Icons.lock_outline,
                          obscureText: _obscure,
                          suffix: IconButton(
                            icon: Icon(
                              _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.gold, size: 18,
                            ),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                          validator: (v) => v!.isEmpty ? 'Ingresa tu contraseña' : null,
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.1),
                              border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
                            ),
                            child: Text(_error!,
                              style: const TextStyle(color: AppColors.error, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        const SizedBox(height: 28),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? const SizedBox(
                                    width: 20, height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.black,
                                    ))
                                : const Text('INGRESAR'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: Text('← Volver al sitio',
                    style: TextStyle(color: AppColors.whiteGhost, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 48),
                Text('Usuario por defecto: admin / YesyStyle2024!',
                  style: TextStyle(color: AppColors.textLight, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoldDiamond extends StatelessWidget {
  final double size;
  const _GoldDiamond({required this.size});
  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: 0.785,
    child: Container(
      width: size, height: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gold, width: 2),
      ),
    ),
  );
}

class _GoldField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const _GoldField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    style: const TextStyle(color: AppColors.white, fontSize: 14),
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 18),
      suffixIcon: suffix,
    ),
  );
}
