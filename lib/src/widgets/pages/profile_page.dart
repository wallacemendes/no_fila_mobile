import 'package:flutter/material.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeuPerfil extends ConsumerStatefulWidget {
  const MeuPerfil({super.key});

  @override
  ConsumerState<MeuPerfil> createState() => _MeuPerfilState();
}

class _MeuPerfilState extends ConsumerState<MeuPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Logoff:',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: OutlinedButton(
                onPressed: () async {
                  await ref.read(authServiceProvider.notifier).logout();
                  ref.read(selectedIndexProvider.notifier).state = 0;
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Sair',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
