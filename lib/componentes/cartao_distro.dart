import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/modelos/distro.dart';
import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';

class LogoDistro extends StatelessWidget {
  final Distro distro;
  final double tamanho;

  const LogoDistro({super.key, required this.distro, this.tamanho = 56});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'recursos/imagens/logos/${distro.logo}',
      width: tamanho,
      height: tamanho,
      fit: BoxFit.contain,
      errorBuilder: (context, erro, pilha) =>
          Icon(Icons.computer, size: tamanho, color: CoresTux.cinza),
    );
  }
}

class CartaoDistro extends StatelessWidget {
  final Distro distro;

  const CartaoDistro({super.key, required this.distro});

  @override
  Widget build(BuildContext context) {
    final teste = estadoApp.logado ? estadoApp.testeDaDistro(distro.id) : null;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => estadoApp.exibirDetalhes(distro.id),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              LogoDistro(distro: distro),
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
                    const SizedBox(height: 2),
                    Text(
                      'Base: ${distro.base} · ${distro.ambiente}',
                      style: const TextStyle(color: CoresTux.cinza),
                    ),
                    if (teste != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: CoresTux.laranja,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            teste.nota > 0
                                ? 'Testada · nota ${teste.nota}/5'
                                : 'Testada',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CoresTux.laranjaEscuro,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: CoresTux.cinza),
            ],
          ),
        ),
      ),
    );
  }
}