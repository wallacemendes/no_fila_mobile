import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/exceptions.dart';
import 'package:no_fila/src/common/providers.dart';

class LoginSiacPage extends ConsumerStatefulWidget {
  const LoginSiacPage({super.key, this.isLogin = true});
  final bool isLogin;

  @override
  ConsumerState<LoginSiacPage> createState() => _LoginSiacPageState();
}

class _LoginSiacPageState extends ConsumerState<LoginSiacPage> {
  final formKey = GlobalKey<FormState>();
  final cpf = TextEditingController();
  final senha = TextEditingController();
  late bool isLogin;
  late String titulo;
  late String actionButton;

  @override
  void initState() {
    super.initState();
    setFormAction(widget.isLogin);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Conectar ao SIAC';
        actionButton = 'Importar dados';
      } else {
        titulo = 'Atualizar dados do SIAC';
        actionButton = 'Atualizar dados';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '/images/logo.png',
                      height: 75,
                    ),
                    const Icon(Icons.sync_alt_outlined, size: 65),
                    Text("SIAC",
                        style: ref.read(baseTextStyleProvider).copyWith(
                            fontSize: 52, fontWeight: FontWeight.w500)),
                  ],
                ),
                Container(
                  height: 220,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: cpf,
                        decoration: const InputDecoration(
                          labelText: 'Digite seu CPF',
                          icon: Icon(Icons.perm_identity),
                          iconColor: Colors.indigo,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o e-mail corretamente';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: senha,
                        obscureText: true,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          labelText: 'Digite sua senha',
                          icon: Icon(Icons.lock_outline_rounded),
                          iconColor: Colors.indigo,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informa a sua senha';
                          } else if (value.length < 6) {
                            return 'Sua senha deve ter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _login(cpf.text, senha.text);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cloud_sync),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(actionButton),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login(String cpf, String senha) async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    try {
      await ref.read(siacServiceProvider.notifier).loginSiac(cpf, senha);
    } on AuthException catch (e) {
      scaffoldContext.showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }
}
