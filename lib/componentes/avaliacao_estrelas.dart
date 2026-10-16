import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';

class AvaliacaoEstrelas extends StatelessWidget {
  final int nota;
  final ValueChanged<int>? aoMudar;
  final double tamanho;

  const AvaliacaoEstrelas({
    super.key,
    required this.nota,
    this.aoMudar,
    this.tamanho = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (indice) {
        final valor = indice + 1;

        final estrela = Icon(
          valor <= nota ? Icons.star : Icons.star_border,
          size: tamanho,
          color: CoresTux.laranja,
        );

        if (aoMudar == null) return estrela;

        return GestureDetector(
          onTap: () => aoMudar!(valor),
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: estrela,
          ),
        );
      }),
    );
  }
}