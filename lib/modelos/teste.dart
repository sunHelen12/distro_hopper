class Teste {
  final int id;
  final int idDistro;
  final int nota; // de 1 a 5
  final String comentario;
  final DateTime data;

  const Teste({
    required this.id,
    required this.idDistro,
    required this.nota,
    required this.comentario,
    required this.data,
  });

  factory Teste.fromJson(Map<String, dynamic> json) {
    return Teste(
      id: json['id'],
      idDistro: json['idDistro'],
      nota: json['nota'],
      comentario: json['comentario'],
      data: DateTime.parse(json['data']),
    );
  }
}
