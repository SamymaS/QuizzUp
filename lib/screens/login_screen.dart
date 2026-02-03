import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      if (username.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        
        await Future.delayed(UXConstants.shortAnimation);
        
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushReplacementNamed(
            '/home',
            arguments: {'username': username},
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - 
      MediaQuery.of(context).padding.top - 
      MediaQuery.of(context).padding.bottom - 
      keyboardHeight;
    
    return Scaffold(
      backgroundColor: UXConstants.primaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: availableHeight,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: keyboardHeight > 0 ? UXConstants.standardSpacing : 0,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: UXConstants.screenPadding,
                  child: Column(
                    mainAxisAlignment: keyboardHeight > 0 
                        ? MainAxisAlignment.start 
                        : MainAxisAlignment.center,
                    children: [
                      if (keyboardHeight > 0) 
                        SizedBox(height: UXConstants.extraLargeSpacing),
                      // Icône trophée
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(UXConstants.standardSpacing),
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
                      // Titre QuizzUp
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
                      // Tagline
                      const Text(
                        'Défiez vos amis en duel !',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: UXConstants.bodyTextSize,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: keyboardHeight > 0 
                        ? UXConstants.largeSpacing 
                        : UXConstants.extraLargeSpacing),
                      // Carte de connexion blanche
                      Container(
                        padding: UXConstants.cardPadding,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(UXConstants.extraLargeRadius),
                          boxShadow: [
                            BoxShadow(
                              color: UXConstants.primaryColor.withValues(alpha: 0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Nom d\'utilisateur',
                                style: TextStyle(
                                  color: UXConstants.textPrimary,
                                  fontSize: UXConstants.captionTextSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: UXConstants.minSpacing),
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Entrez votre pseudo',
                                  hintStyle: TextStyle(color: UXConstants.textSecondary.withValues(alpha: 0.6)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                                    borderSide: BorderSide(
                                      color: UXConstants.accentColor.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                                    borderSide: BorderSide(
                                      color: UXConstants.accentColor.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                                    borderSide: const BorderSide(
                                      color: UXConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: UXConstants.cardBackground,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: UXConstants.standardSpacing,
                                    vertical: UXConstants.standardSpacing,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: UXConstants.bodyTextSize,
                                  color: UXConstants.textPrimary,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Veuillez entrer un nom d\'utilisateur';
                                  }
                                  if (value.trim().length < 3) {
                                    return 'Le pseudo doit contenir au moins 3 caractères';
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _handleLogin(),
                              ),
                              SizedBox(height: UXConstants.largeSpacing),
                              _isLoading
                                ? const SizedBox(
                                    height: UXConstants.buttonHeight,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          UXConstants.primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: UXConstants.primaryColor,
                                      padding: UXConstants.buttonPadding,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                                      ),
                                    ),
                                    child: const Text(
                                      'Se connecter',
                                      style: TextStyle(
                                        fontSize: UXConstants.bodyTextSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: keyboardHeight > 0 
                        ? UXConstants.standardSpacing 
                        : UXConstants.extraLargeSpacing),
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
    );
  }
}
