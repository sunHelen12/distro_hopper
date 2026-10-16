import 'package:distro_hopper/componentes/avaliacao_estrelas.dart';
import 'package:distro_hopper/componentes/cartao_distro.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/modelos/distro.dart';
import 'package:distro_hopper/modelos/teste.dart';
import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartaoTeste extends StatelessWidget {
  final Teste teste;
  final Distro distro;

  const CartaoTeste({super.key, required this.teste, required this.distro});

  @override
  Widget build(BuildContext context) {
    final detalhes = [
      if (teste.ambiente.isNotEmpty) teste.ambiente,
      if (teste.versao.isNotEmpty) 'versão ${teste.versao}',
    ].join(' · ');

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => estadoApp.exibirDetalhes(distro.id),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoDistro(distro: distro, tamanho: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      distro.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (teste.nota > 0)
                      AvaliacaoEstrelas(nota: teste.nota, tamanho: 20)
                    else
                      const Text(
                        'Sem nota',
                        style: TextStyle(color: CoresTux.cinza),
                      ),
                    if (detalhes.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        detalhes,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: CoresTux.laranjaEscuro,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      teste.comentario.isEmpty
                          ? 'Sem comentário.'
                          : teste.comentario,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormat('dd/MM/yyyy').format(teste.data),
                      style: const TextStyle(
                        fontSize: 12,
                        color: CoresTux.cinza,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}