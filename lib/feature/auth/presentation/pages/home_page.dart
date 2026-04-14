import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();
    final user = vm.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthViewModel>().logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Bem-vindo, ${user?.name ?? user?.email ?? 'usuário'}',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
