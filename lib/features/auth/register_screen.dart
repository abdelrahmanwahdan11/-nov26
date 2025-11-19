import 'package:audiobook_ebooks/core/controllers/auth_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.authController, required this.onSuccess});
  final AuthController authController;
  final VoidCallback onSuccess;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  double get _strength {
    final value = _passwordController.text;
    if (value.length >= 12 && _hasMixed(value)) return 1;
    if (value.length >= 8 && _hasMixed(value)) return .7;
    if (value.length >= 6) return .4;
    return .1;
  }

  bool _hasMixed(String value) {
    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));
    return hasUpper && hasNumber;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('register'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _BubbleHeader(title: loc.translate('createAccount'), subtitle: loc.translate('registerSubtitle')),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: loc.translate('email')),
                validator: (value) => value != null && value.contains('@') ? null : 'Invalid email',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscure,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: loc.translate('password'),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (value) => value != null && value.length >= 6 ? null : 'Password too short',
              ),
              const SizedBox(height: 8),
              _StrengthBar(strength: _strength),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await widget.authController.register(
                      _emailController.text,
                      _passwordController.text,
                    );
                    widget.onSuccess();
                  }
                },
                child: Text(loc.translate('createAccount')),
              ).animate().scale(begin: const Offset(.97, .97)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StrengthBar extends StatelessWidget {
  const _StrengthBar({required this.strength});
  final double strength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String label;
    Color color;
    if (strength >= 1) {
      label = 'Strong';
      color = Colors.green;
    } else if (strength >= .7) {
      label = 'Good';
      color = theme.colorScheme.primary;
    } else if (strength >= .4) {
      label = 'Fair';
      color = Colors.orange;
    } else {
      label = 'Weak';
      color = Colors.redAccent;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(value: strength, backgroundColor: theme.dividerColor, color: color),
        const SizedBox(height: 6),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: color)),
      ],
    );
  }
}

class _BubbleHeader extends StatelessWidget {
  const _BubbleHeader({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(.1),
            theme.colorScheme.secondary.withOpacity(.08),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: theme.textTheme.bodyMedium),
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).slide(begin: const Offset(0, 0.04));
  }
}
