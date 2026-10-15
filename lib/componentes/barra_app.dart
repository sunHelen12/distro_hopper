import 'package:flutter/material.dart';

class LogoTux extends StatelessWidget {
  final double tamanho;

  const LogoTux({super.key, this.tamanho = 40});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'recursos/imagens/tux.png',
      width: tamanho,
      height: tamanho,
    );
  }
}

class BarraApp extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> acoes;
  final VoidCallback? aoVoltar; 

  const BarraApp({super.key, this.acoes = const [], this.aoVoltar});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64,
      leading: aoVoltar == null
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: aoVoltar,
            ),
      title: Row(
        children: [
          const LogoTux(tamanho: 40),
          const SizedBox(width: 10),
          const Text('Distro '),
          Text(
            'Hopper',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
      actions: acoes,
    );
  }
}