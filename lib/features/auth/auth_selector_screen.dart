import 'package:audiobook_ebooks/core/controllers/auth_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/features/auth/login_screen.dart';
import 'package:audiobook_ebooks/features/auth/forgot_password_screen.dart';
import 'package:audiobook_ebooks/features/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthSelectorScreen extends StatelessWidget {
  const AuthSelectorScreen({
    super.key,
    required this.authController,
    required this.onAuthenticated,
  });

  final AuthController authController;
  final VoidCallback onAuthenticated;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: onAuthenticated,
            child: Text(loc.translate('continueGuest')),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.08),
                    theme.colorScheme.secondary.withOpacity(0.08),
                    theme.scaffoldBackgroundColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            right: -80,
            child: CircleAvatar(
              radius: 160,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
            ),
          ),
          Positioned(
            bottom: -160,
            left: -120,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: theme.colorScheme.secondary.withOpacity(0.12),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('welcomeBack'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 350.ms).slide(begin: const Offset(0, 0.05)),
                  const SizedBox(height: 8),
                  Text(
                    loc.translate('authSubtitle'),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: MediaQuery.of(context).size.width > 700 ? 3 : 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        _AuthCard(
                          title: loc.translate('login'),
                          subtitle: loc.translate('loginSubtitle'),
                          icon: Icons.lock_open_rounded,
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary.withOpacity(.12),
                              theme.colorScheme.primary.withOpacity(.04),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LoginScreen(
                                authController: authController,
                                onSuccess: onAuthenticated,
                                onForgot: () => _openForgot(context),
                                onRegister: () => _openRegister(context),
                              ),
                            ),
                          ),
                        ),
                        _AuthCard(
                          title: loc.translate('register'),
                          subtitle: loc.translate('registerSubtitle'),
                          icon: Icons.person_add_rounded,
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.secondary.withOpacity(.14),
                              theme.colorScheme.secondary.withOpacity(.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () => _openRegister(context),
                        ),
                        _AuthCard(
                          title: loc.translate('continueGuest'),
                          subtitle: loc.translate('guestSubtitle'),
                          icon: Icons.explore,
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.tertiary.withOpacity(.12),
                              theme.colorScheme.tertiary.withOpacity(.04),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: onAuthenticated,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RegisterScreen(
          authController: authController,
          onSuccess: onAuthenticated,
        ),
      ),
    );
  }

  void _openForgot(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ForgotPasswordScreen(),
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.gradient,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 320.ms,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.dividerColor.withOpacity(.08)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(.04),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withOpacity(.1),
              child: Icon(icon, color: theme.colorScheme.primary),
            ).animate().scale(begin: const Offset(.9, .9), duration: 280.ms),
            const Spacer(),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.7),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 260.ms).slide(begin: const Offset(0, 0.05)),
    );
  }
}
