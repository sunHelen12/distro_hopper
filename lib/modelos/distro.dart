class Distro {
  final int id;
  final String nome;
  final String descricao;
  final String base;
  final int ano;
  final String site;
  final String logo;
  final List<String> imagens;

  const Distro({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.base,
    required this.ano,
    required this.site,
    required this.logo,
    required this.imagens,
  });

  factory Distro.fromJson(Map<String, dynamic> json) {
    return Distro(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      base: json['base'],
      ano: json['ano'],
      site: json['site'],
      logo: json['logo'],
      imagens: List<String>.from(json['imagens']),
    );
  }
}