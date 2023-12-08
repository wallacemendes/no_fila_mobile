import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/app/cache_service.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/models/siac.dart';
import 'package:no_fila/src/common/exceptions.dart';
import 'dart:convert';

class UserData {
  UsuarioSiac? usuarioSiac;

  UserData({this.usuarioSiac});
}

class UserDataNotifier extends Notifier<UserData> {
  @override
  UserData build() {
    final email = ref.read(authServiceProvider.notifier).getEmail();
    try {
      final data = CachePreferences.getUserCache(email);
      if (data != null) {
        final json = jsonDecode(data);
        return UserData(
          usuarioSiac: UsuarioSiac.fromJson(json),
        );
      }
      return UserData();
    } on AuthException catch (err) {
      throw AuthException(err.toString());
    }
  }

  void refresh() {
    final email = ref.read(authServiceProvider.notifier).getEmail();
    try {
      final data = CachePreferences.getUserCache(email);
      if (data != null) {
        final json = jsonDecode(data);
        state = UserData(
          usuarioSiac: UsuarioSiac.fromJson(json),
        );
      }
    } on AuthException catch (err) {
      throw AuthException(err.toString());
    }
  }
}
