import 'package:flutter/material.dart';
import 'package:no_fila/src/common/exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Entrar';
        actionButton = 'Entrar';
      } else {
        titulo = 'Criar conta';
        actionButton = 'Cadastrar';
      }
    });
  }

  login() async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(authServiceProvider.notifier)
          .login(email.text, senha.text);
    } on AuthException catch (err) {
      scaffoldContext.showSnackBar(SnackBar(
        content: Text(err.message),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  registrar() async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(authServiceProvider.notifier)
          .registrar(email.text, senha.text);
    } on AuthException catch (err) {
      scaffoldContext.showSnackBar(SnackBar(
        content: Text(err.message),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          '/images/logo.png',
                          height: 100,
                        ),
                        Container(
                          height: isLogin ? 300 : 350,
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                  labelText: 'Digite seu email',
                                  icon: Icon(Icons.alternate_email_outlined),
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
                              if (!isLogin)
                                TextFormField(
                                  obscureText: true,
                                  enableSuggestions: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Repita a senha',
                                    icon: Icon(Icons.lock_outline_rounded),
                                    iconColor: Colors.indigo,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informa a sua senha';
                                    } else if (value != senha.text) {
                                      return 'As senhas não conferem';
                                    }
                                    return null;
                                  },
                                ),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (isLogin) {
                                      login();
                                    } else {
                                      registrar();
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLogin
                                        ? const Icon(Icons.login)
                                        : const Icon(Icons.person_add_alt),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(actionButton),
                                    ),
                                  ],
                                ),
                              ),
                              if (isLogin)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      child: const Text('Esqueceu sua senha?'),
                                      onPressed: () {
                                        // Navigate to Forgot Password Screen
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TelaEsqueceuSenha(),
                                          ),
                                        );
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Criar nova conta'),
                                      onPressed: () => setFormAction(!isLogin),
                                    ),
                                  ],
                                ),
                              if (!isLogin)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Já possui uma conta?'),
                                    TextButton(
                                      child: const Text('Faça login'),
                                      onPressed: () => setFormAction(!isLogin),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TelaEsqueceuSenha extends ConsumerWidget {
  TelaEsqueceuSenha({super.key});

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Digite o email associado a sua conta para receber um email de recuperação de senha.',
                        style: ref
                            .read(baseTextStyleProvider)
                            .copyWith(fontSize: 16),
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Digite seu email',
                          icon: Icon(Icons.alternate_email_outlined),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        child: const Text('Enviar email de recuperação'),
                        onPressed: () async {
                          final scaffoldContext = ScaffoldMessenger.of(context);
                          final navigatorContext = Navigator.of(context);
                          if (formKey.currentState!.validate()) {
                            try {
                              final status = await ref
                                  .read(authServiceProvider.notifier)
                                  .resetPassword(email.text);
                              scaffoldContext.showSnackBar(SnackBar(
                                content: Text(status),
                                duration: const Duration(seconds: 3),
                              ));
                              status.isEmpty ? null : navigatorContext.pop();
                            } on AuthException catch (err) {
                              scaffoldContext.showSnackBar(SnackBar(
                                content: Text(err.message),
                                duration: const Duration(seconds: 3),
                              ));
                            }
                          }
                        },
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
}
