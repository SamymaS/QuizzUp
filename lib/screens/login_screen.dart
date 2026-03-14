import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      '/home',
      arguments: {
        'username': AuthService.instance.username,
        'isGuest': AuthService.instance.isGuest,
      },
    );
  }

  Future<void> _handleGuest() async {
    final error = await AuthService.instance.signInAsGuest();
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
        ),
      );
    } else {
      _navigateHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UXConstants.primaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: UXConstants.screenPadding,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: UXConstants.largeSpacing),
                        // Icône trophée
                        Container(
                          width: 80,
                          height: 80,
                          padding:
                              const EdgeInsets.all(UXConstants.standardSpacing),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                        SizedBox(height: UXConstants.largeSpacing),
                        const Text(
                          'QuizzUp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: UXConstants.standardSpacing),
                        const Text(
                          'Défiez vos amis en duel !',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: UXConstants.bodyTextSize,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: UXConstants.extraLargeSpacing),
                        // Carte blanche avec onglets
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                UXConstants.extraLargeRadius),
                            boxShadow: [
                              BoxShadow(
                                color: UXConstants.primaryColor
                                    .withValues(alpha: 0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // TabBar
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      UXConstants.extraLargeRadius),
                                  topRight: Radius.circular(
                                      UXConstants.extraLargeRadius),
                                ),
                                child: TabBar(
                                  controller: _tabController,
                                  labelColor: UXConstants.primaryColor,
                                  unselectedLabelColor:
                                      UXConstants.textSecondary,
                                  indicatorColor: UXConstants.primaryColor,
                                  indicatorWeight: 3,
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: UXConstants.bodyTextSize,
                                  ),
                                  tabs: const [
                                    Tab(text: 'Se connecter'),
                                    Tab(text: "S'inscrire"),
                                  ],
                                ),
                              ),
                              // Tab views — hauteur augmentée pour le formulaire d'inscription
                              SizedBox(
                                height: 320,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    _SignInForm(onSuccess: _navigateHome),
                                    _SignUpForm(onSuccess: _navigateHome),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: UXConstants.largeSpacing),
                        // Bouton Invité
                        OutlinedButton.icon(
                          onPressed: _handleGuest,
                          icon: const Icon(Icons.person_outline,
                              color: Colors.white70),
                          label: const Text(
                            'Continuer en invité',
                            style: TextStyle(color: Colors.white70),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Colors.white54, width: 1.5),
                            padding: UXConstants.buttonPadding,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(UXConstants.mediumRadius),
                            ),
                            minimumSize: const Size(
                                double.infinity, UXConstants.buttonHeight),
                          ),
                        ),
                        SizedBox(height: UXConstants.largeSpacing),
                        const Text(
                          'Prêt à tester vos connaissances ?',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: UXConstants.captionTextSize,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Sign-in form ──────────────────────────────────────────────────────────────

class _SignInForm extends StatefulWidget {
  final VoidCallback onSuccess;
  const _SignInForm({required this.onSuccess});

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final error = await AuthService.instance.signIn(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(error),
            backgroundColor: UXConstants.errorColor),
      );
    } else {
      widget.onSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: UXConstants.cardPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailCtrl,
              style: const TextStyle(color: UXConstants.textPrimary),
              decoration: _inputDeco('Email', Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: _emailValidator,
            ),
            SizedBox(height: UXConstants.standardSpacing),
            TextFormField(
              controller: _passwordCtrl,
              style: const TextStyle(color: UXConstants.textPrimary),
              obscureText: _obscure,
              decoration: _inputDeco('Mot de passe', Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                    color: UXConstants.textSecondary,
                  )),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Mot de passe requis' : null,
            ),
            SizedBox(height: UXConstants.largeSpacing),
            _isLoading
                ? const SizedBox(
                    height: UXConstants.buttonHeight,
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          UXConstants.primaryColor),
                    )))
                : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UXConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: UXConstants.buttonPadding,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(UXConstants.mediumRadius),
                      ),
                      minimumSize: const Size(
                          double.infinity, UXConstants.buttonHeight),
                    ),
                    child: const Text(
                      'Se connecter',
                      style: TextStyle(
                          fontSize: UXConstants.bodyTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// ── Sign-up form ──────────────────────────────────────────────────────────────

class _SignUpForm extends StatefulWidget {
  final VoidCallback onSuccess;
  const _SignUpForm({required this.onSuccess});

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final error = await AuthService.instance.signUp(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
      _usernameCtrl.text.trim(),
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(error),
            backgroundColor: UXConstants.errorColor),
      );
    } else {
      widget.onSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: UXConstants.cardPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameCtrl,
              style: const TextStyle(color: UXConstants.textPrimary),
              decoration: _inputDeco('Pseudo', Icons.person_outline),
              textInputAction: TextInputAction.next,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Pseudo requis';
                if (v.trim().length < 3) return 'Min. 3 caractères';
                return null;
              },
            ),
            SizedBox(height: UXConstants.standardSpacing),
            TextFormField(
              controller: _emailCtrl,
              style: const TextStyle(color: UXConstants.textPrimary),
              decoration: _inputDeco('Email', Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: _emailValidator,
            ),
            SizedBox(height: UXConstants.standardSpacing),
            TextFormField(
              controller: _passwordCtrl,
              style: const TextStyle(color: UXConstants.textPrimary),
              obscureText: _obscure,
              decoration: _inputDeco('Mot de passe', Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                    color: UXConstants.textSecondary,
                  )),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Mot de passe requis';
                if (v.length < 6) return 'Min. 6 caractères';
                return null;
              },
            ),
            SizedBox(height: UXConstants.largeSpacing),
            _isLoading
                ? const SizedBox(
                    height: UXConstants.buttonHeight,
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          UXConstants.primaryColor),
                    )))
                : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UXConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: UXConstants.buttonPadding,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(UXConstants.mediumRadius),
                      ),
                      minimumSize: const Size(
                          double.infinity, UXConstants.buttonHeight),
                    ),
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontSize: UXConstants.bodyTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────

InputDecoration _inputDeco(String label, IconData icon, {Widget? suffix}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: UXConstants.textSecondary, size: 20),
    suffixIcon: suffix,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
      borderSide: BorderSide(
          color: UXConstants.accentColor.withValues(alpha: 0.3), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
      borderSide: BorderSide(
          color: UXConstants.accentColor.withValues(alpha: 0.3), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
      borderSide:
          const BorderSide(color: UXConstants.primaryColor, width: 2),
    ),
    filled: true,
    fillColor: UXConstants.cardBackground,
    contentPadding: const EdgeInsets.symmetric(
        horizontal: UXConstants.standardSpacing,
        vertical: UXConstants.standardSpacing),
    labelStyle: const TextStyle(
        color: UXConstants.textSecondary,
        fontSize: UXConstants.captionTextSize),
  );
}

String? _emailValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Email requis';
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
    return 'Email invalide';
  }
  return null;
}
