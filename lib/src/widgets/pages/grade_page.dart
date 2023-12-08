import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/models/siac.dart';

class MinhaGrade extends ConsumerWidget {
  const MinhaGrade({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const Header(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Meus componentes matriculados",
                  style: ref
                      .read(baseTextStyleProvider)
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const ListViewComponent()
          ],
        ),
      ),
    );
  }
}

class ListViewComponent extends ConsumerStatefulWidget {
  const ListViewComponent({
    super.key,
  });

  @override
  ConsumerState<ListViewComponent> createState() => _ListViewComponentState();
}

class _ListViewComponentState extends ConsumerState<ListViewComponent> {
  List<MateriaSiac> itens = [];

  @override
  void initState() {
    super.initState();
    itens = [...ref.read(userDataProvider).usuarioSiac!.materias];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: itens.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.indigoAccent,
              child: Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    title: Text(itens.elementAt(index).nomeMateria),
                    contentPadding: const EdgeInsets.all(20.0),
                    titleTextStyle: ref.read(baseTextStyleProvider).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itens
                              .elementAt(index)
                              .aulas
                              .firstWhere((element) => element.professor != "")
                              .professor,
                          style: ref
                              .read(baseTextStyleProvider)
                              .copyWith(fontSize: 14, color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              NonInteractiveOutlineText(
                                  text: itens.elementAt(index).codMateria),
                              NonInteractiveOutlineText(
                                  text:
                                      "CH: ${itens.elementAt(index).cargaHoraria}"),
                            ],
                          ),
                        )
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {
                      // Chamar componente ajustes
                    },
                  ),
                ],
              ),
            );
          }),
    );
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Componentes Curriculares",
              style: ref
                  .read(baseTextStyleProvider)
                  .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Image(image: AssetImage('images/Logo.png'), height: 40),
        ),
      ],
    );
  }
}

class NonInteractiveOutlineText extends StatelessWidget {
  final String text;

  const NonInteractiveOutlineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 10, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
