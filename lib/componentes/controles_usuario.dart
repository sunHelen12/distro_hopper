import 'package:distro_hopper/autenticador.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/usuario.dart';
import 'package:flutter/material.dart';

Future<Usuario?> escolherConta(BuildContext context) {
  return showDialog<Usuario>(
    context: context,
    builder: (contexto) => SimpleDialog(
      title: const Text('Escolha uma conta'),
      children: [
        for (final conta in Autenticador.contas)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(contexto, conta),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(child: Text(conta.nome[0])),
              title: Text(conta.nome),
              subtitle: Text(conta.email),
            ),
          ),
      ],
    ),
  );
}

Future<void> entrarCom(Usuario conta) async {
  final usuario = await Autenticador.login(conta);
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
    if (mounted) setState(() => _ocupado = false);
  }

  Future<void> _entrar() async {
    final conta = await escolherConta(context);
    if (conta == null || !mounted) return;
    await _executar(() => entrarCom(conta));
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
        onPressed: _entrar,
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
          tooltip: 'Sair (${estadoApp.usuario?.nome ?? ''})',
          icon: const Icon(Icons.logout),
          onPressed: () => _executar(sair),
        ),
      ],
    );
  }
}