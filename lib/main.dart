import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:no_fila/src/app/cache_service.dart';
import 'package:no_fila/src/common/no_fila.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/data/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // garantia de inicialização do Firebase antes do app

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CachePreferences.init();

  runApp(
    const ProviderScope(
      child: NoFila(),
    ),
  );
}
