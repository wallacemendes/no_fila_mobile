import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:no_fila/src/common/exceptions.dart';

class SiacRepository {
  final Dio dio = Dio();
  final _baseUrl = 'http://localhost:8000';
  final _path = '/siac_proof_of_registration';

  Future<String> loginSiac(String cpf, String senha) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await dio.post(
        _baseUrl + _path,
        options: Options(headers: headers),
        data: {
          'cpf': cpf,
          'senha': senha,
        },
      );

      if (response.statusCode == 200) {
        return jsonEncode(response.data);
      } else {
        throw AuthException(response.data['detail'] ?? 'Erro desconhecido');
      }
    } on Exception {
      throw AuthException("Erro ao tentar conectar ao SIAC.");
    }
  }
}
