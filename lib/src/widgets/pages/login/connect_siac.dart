import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/exceptions.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/widgets/pages/login/login_siac_page.dart';

class ConnectSiac extends ConsumerStatefulWidget {
  const ConnectSiac({Key? key}) : super(key: key);

  @override
  ConsumerState<ConnectSiac> createState() => _ConnectSiacState();
}

class _ConnectSiacState extends ConsumerState<ConnectSiac> {
  logout() async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    try {
      await ref.read(authServiceProvider.notifier).logout();
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
      appBar: AppBar(title: const Text('Importar Dados')),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                        height: 250,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Continue para importar os seus dados do SIAC para o !FILA',
                              style: ref
                                  .read(baseTextStyleProvider)
                                  .copyWith(fontSize: 18),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity,
                                    50), // largura máxima e altura de 50
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginSiacPage()),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud_sync),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Importar Dados"),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                logout();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.logout),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Sair"),
                                  ),
                                ],
                              ),
                            )
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
    );
  }
}
