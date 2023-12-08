List<String> nomeDeUsuario({String? fullName}) {
  return fullName
          ?.split(' ')
          .map(
              (word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
          .toList() ??
      [];
}
