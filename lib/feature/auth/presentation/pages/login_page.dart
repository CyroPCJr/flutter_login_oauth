import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../widgets/animated_logo.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Consumer<AuthViewModel>(
              builder: (context, vm, _) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (vm.status == AuthStatus.authenticated &&
                      context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  }
                });

                return Column(
                  children: [
                    const SizedBox(height: 16),
                    const AnimatedLogo(),
                    const SizedBox(height: 20),
                    const Text(
                      'Bem-vindo',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Entre com sua conta para continuar'),
                    const SizedBox(height: 32),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 18,
                            spreadRadius: 2,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe o e-mail';
                                }
                                if (!value.contains('@')) {
                                  return 'E-mail inválido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe a senha';
                                }
                                if (value.length < 6) {
                                  return 'Senha deve ter ao menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: vm.status == AuthStatus.loading
                                    ? null
                                    : () async {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        await vm.loginWithEmail(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        );
                                      },
                                child: vm.status == AuthStatus.loading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Entrar'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: vm.status == AuthStatus.loading
                                    ? null
                                    : () => vm.loginWithGoogle(),
                                icon: const Icon(Icons.login),
                                label: const Text('Entrar com Google'),
                              ),
                            ),
                            if (vm.errorMessage != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                vm.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
