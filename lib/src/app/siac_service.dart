import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/app/cache_service.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/data/siac_repository.dart';
import 'package:no_fila/src/common/exceptions.dart';

class SiacState {
  final String? data;
  final String email;

  SiacState({this.data, required this.email});
}

class SiacNotifier extends AsyncNotifier<SiacState> {
  final SiacRepository _siacRepository = SiacRepository();

  @override
  FutureOr<SiacState> build() {
    String email = ref.read(authServiceProvider.notifier).getEmail();
    final data = CachePreferences.getUserCache(email);
    return SiacState(email: email, data: data);
  }

  Future<void> loginSiac(String cpf, String senha) async {
    try {
      final data = await _siacRepository.loginSiac(cpf, senha);
      String email = ref.read(authServiceProvider.notifier).getEmail();
      await CachePreferences.setUserCache(email, data);
      _getCache();
    } on AuthException catch (err) {
      throw AuthException(err.message);
    }
  }

  Future<void> logoutSiac(String email) async {
    await CachePreferences.removeUserCache(email);
    _getCache();
  }

  void _getCache() {
    String email = ref.read(authServiceProvider.notifier).getEmail();
    final data = CachePreferences.getUserCache(email);
    state = AsyncValue.data(SiacState(data: data, email: email));
  }
}
