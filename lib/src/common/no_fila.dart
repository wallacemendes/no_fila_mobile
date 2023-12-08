import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/controllers/auth_check.dart';

class NoFila extends ConsumerWidget {
  const NoFila({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '!Fila',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF3F51B5),
          secondary: Color(0xFF448AFF),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const AuthCheck(),
    );
  }
}
