import 'package:distro_hopper/componentes/cartao_distro.dart';
import 'package:distro_hopper/modelos/distro.dart';
import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

/// Bloco com as informações da distro: capturas de tela, dados e descrição.
class CartaoDetalhesDistro extends StatefulWidget {
  final Distro distro;

  const CartaoDetalhesDistro({super.key, required this.distro});

  @override
  State<CartaoDetalhesDistro> createState() => _CartaoDetalhesDistroState();
}

class _CartaoDetalhesDistroState extends State<CartaoDetalhesDistro> {
  int _pagina = 0;

  @override
  Widget build(BuildContext context) {
    final distro = widget.distro;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            child: PageView.builder(
              itemCount: distro.imagens.length,
              onPageChanged: (pagina) => setState(() => _pagina = pagina),
              itemBuilder: (context, indice) {
                return Image.asset(
                  'recursos/imagens/capturas/${distro.imagens[indice]}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, erro, pilha) => Container(
                    color: CoresTux.preto,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: CoresTux.laranja,
                    ),
                  ),
                );
              },
            ),
          ),
          if (distro.imagens.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: PageViewDotIndicator(
                  currentItem: _pagina,
                  count: distro.imagens.length,
                  unselectedColor: Colors.black26,
                  selectedColor: CoresTux.laranja,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LogoDistro(distro: distro, tamanho: 48),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        distro.nome,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Chip(label: Text('Base: ${distro.base}')),
                    Chip(label: Text(distro.ambiente)),
                    Chip(label: Text('Desde ${distro.ano}')),
                  ],
                ),
                const SizedBox(height: 12),
                Text(distro.descricao, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.link, size: 18, color: CoresTux.laranja),
                    const SizedBox(width: 6),
                    Expanded(
                      child: SelectableText(
                        distro.site,
                        style: const TextStyle(color: CoresTux.laranjaEscuro),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}