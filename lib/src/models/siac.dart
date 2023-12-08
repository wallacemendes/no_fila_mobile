class UsuarioSiac {
  final String matricula;
  final String nome;
  final String curso;
  final double notaCr;
  final String semestre;
  final List<MateriaSiac> materias;

  UsuarioSiac(
      {required this.matricula,
      required this.nome,
      required this.curso,
      required this.notaCr,
      required this.semestre,
      required this.materias});

  factory UsuarioSiac.fromJson(Map<String, dynamic> json) {
    return UsuarioSiac(
      matricula: json['registration'],
      nome: json['student'],
      curso: json['course'],
      notaCr: json['score'],
      semestre: json['current_semester'],
      materias: json['subjects']
          .map<MateriaSiac>((materia) => MateriaSiac(
                codMateria: materia['code'],
                nomeMateria: materia['name'],
                cargaHoraria: materia['workload'],
                codTurma: materia['group']['code'],
                turma: materia['group']['number'],
                aulas: materia['lessons']
                    .map<SiacAula>((aula) => SiacAula(
                          diaDaSemana: aula['day_of_week'],
                          inicio: aula['start'],
                          fim: aula['end'],
                          local: aula['location'],
                          professor: aula['teacher'],
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}

class MateriaSiac {
  final String codMateria;
  final String nomeMateria;
  final double cargaHoraria;
  final String codTurma;
  final String turma;
  final List<SiacAula> aulas;

  MateriaSiac(
      {required this.codMateria,
      required this.nomeMateria,
      required this.cargaHoraria,
      required this.codTurma,
      required this.turma,
      required this.aulas});
}

class SiacAula {
  final String diaDaSemana;
  final String inicio;
  final String fim;
  final String local;
  final String professor;

  SiacAula(
      {required this.diaDaSemana,
      required this.inicio,
      required this.fim,
      required this.local,
      required this.professor});
}
