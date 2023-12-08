import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/common/utils.dart';
import 'package:no_fila/src/widgets/pages/login/login_siac_page.dart';
import 'ajustes_page.dart';
import 'grade_page.dart';
import 'profile_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: const <Widget>[
        HomeBar(),
        MinhaGrade(),
        MeusAjustes(),
        MeuPerfil(),
      ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: ref.read(selectedIndexProvider.notifier).state,
        onDestinationSelected: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_max), label: 'Início'),
          NavigationDestination(
              icon: Icon(Icons.calendar_view_month_rounded),
              label: 'Grade Curricular'),
          NavigationDestination(
              icon: Icon(Icons.archive_outlined), label: 'Ajustes'),
          NavigationDestination(
              icon: Icon(Icons.person_2_outlined), label: 'Perfil'),
        ],
      ),
    );
  }
}

class HomeBar extends ConsumerWidget {
  const HomeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.read(userDataProvider).usuarioSiac;
    List<String> nome = nomeDeUsuario(fullName: userData?.nome);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const Header(),
            Row(
              children: [
                Text("Bem Vindo,",
                    style: ref
                        .read(baseTextStyleProvider)
                        .copyWith(fontSize: 32, fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              children: [
                Text(
                  "${nome.first} ${nome.last}",
                  style: ref.read(baseTextStyleProvider).copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.waving_hand, color: Colors.yellow[800])),
              ],
            ),
            const ContentSection()
          ],
        ),
      ),
    );
  }
}

class ContentSection extends ConsumerStatefulWidget {
  const ContentSection({
    super.key,
  });

  @override
  ConsumerState<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends ConsumerState<ContentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_today_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                title: const Text("Componentes Curriculares"),
                contentPadding: const EdgeInsets.all(20.0),
                titleTextStyle: ref.read(baseTextStyleProvider).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                subtitle: const Text(
                  "Visualize os componentes curriculares inscritos",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                onTap: () {
                  ref.read(selectedIndexProvider.notifier).state = 1;
                  // Chamar componente grade
                },
              ),
            ),
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                leading: const Icon(
                  Icons.archive_outlined,
                  size: 50,
                  color: Colors.white,
                ),
                title: const Text("Solicitações de Ajustes de Matrícula"),
                contentPadding: const EdgeInsets.all(20.0),
                titleTextStyle: ref.read(baseTextStyleProvider).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                subtitle: Text(
                    "Crie e acompanhe suas solicitações de ajuste assíncrono",
                    style: ref
                        .read(baseTextStyleProvider)
                        .copyWith(fontSize: 14, color: Colors.white)),
                onTap: () {
                  ref.read(selectedIndexProvider.notifier).state = 2;
                },
              ),
            ),
          ],
        ));
  }
}

class Header extends ConsumerStatefulWidget {
  const Header({
    super.key,
  });

  @override
  ConsumerState<Header> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
            ),
          ),
          const Image(image: AssetImage('images/Logo.png'), height: 40),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(ref
                        .read(baseTextStyleProvider)
                        .copyWith(fontSize: 14))),
                child: const Text('Atualizar SIAC'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginSiacPage(
                        isLogin: false,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
