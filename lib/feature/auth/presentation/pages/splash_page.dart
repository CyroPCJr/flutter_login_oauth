import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      final vm = context.read<AuthViewModel>();
      await vm.checkAuth();

      final page = vm.status == AuthStatus.authenticated
          ? const HomePage()
          : const LoginPage();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, _, _) => page,
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
