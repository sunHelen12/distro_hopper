import 'package:distro_hopper/autenticador.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:flutter/material.dart';

Future<void> entrar() async {
  final usuario = await Autenticador.login();
  estadoApp.login(usuario);
}

Future<void> sair() async {
  await Autenticador.logout();
  estadoApp.logout();
}

class ControlesUsuario extends StatefulWidget {
  final bool mostrarMeusTestes;

  const ControlesUsuario({super.key, this.mostrarMeusTestes = true});

  @override
  State<ControlesUsuario> createState() => _ControlesUsuarioState();
}

class _ControlesUsuarioState extends State<ControlesUsuario> {
  bool _ocupado = false;

  Future<void> _executar(Future<void> Function() acao) async {
    setState(() => _ocupado = true);
    await acao();
    // a tela pode ter mudado durante o logout
    if (mounted) setState(() => _ocupado = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_ocupado) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    }

    if (!estadoApp.logado) {
      return TextButton.icon(
        onPressed: () => _executar(entrar),
        icon: const Icon(Icons.login),
        label: const Text('Entrar'),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.mostrarMeusTestes)
          IconButton(
            tooltip: 'Meus testes',
            icon: const Icon(Icons.menu_book),
            onPressed: estadoApp.exibirMeusTestes,
          ),
        IconButton(
          tooltip: 'Sair',
          icon: const Icon(Icons.logout),
          onPressed: () => _executar(sair),
        ),
      ],
    );
  }
}