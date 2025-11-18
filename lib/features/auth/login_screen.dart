import 'package:audiobook_ebooks/core/controllers/auth_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.authController, required this.onSuccess});
  final AuthController authController;
  final VoidCallback onSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('login'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: loc.translate('email')),
                validator: (value) =>
                    value != null && value.contains('@') ? null : 'Invalid email',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: loc.translate('password'),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (value) =>
                    value != null && value.length >= 6 ? null : 'Password too short',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await widget.authController.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                    widget.onSuccess();
                  }
                },
                child: Text(loc.translate('login')),
              ),
              TextButton(
                onPressed: widget.onSuccess,
                child: Text(loc.translate('continueGuest')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
