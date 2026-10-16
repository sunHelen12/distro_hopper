class Teste {
  final int id;
  final int idDistro;
  final int nota; 
  final String comentario;
  final String ambiente; 
  final String versao; 
  final DateTime data;

  const Teste({
    required this.id,
    required this.idDistro,
    required this.nota,
    required this.comentario,
    required this.ambiente,
    required this.versao,
    required this.data,
  });

  factory Teste.fromJson(Map<String, dynamic> json) {
    return Teste(
      id: json['id'],
      idDistro: json['idDistro'],
      nota: json['nota'],
      comentario: json['comentario'],
      ambiente: json['ambiente'] ?? '',
      versao: json['versao'] ?? '',
      data: DateTime.parse(json['data']),
    );
  }
}