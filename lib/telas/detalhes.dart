import 'package:distro_hopper/componentes/barra_app.dart';
import 'package:distro_hopper/componentes/cartao_detalhes_distro.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:flutter/material.dart';

class Detalhes extends StatelessWidget {
  const Detalhes({super.key});

  @override
  Widget build(BuildContext context) {
    final distro = estadoApp.distroSelecionada;
    if (distro == null) return const SizedBox.shrink();

    // o botão voltar do Android também volta para a lista
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, resultado) {
        if (!didPop) estadoApp.exibirDistros();
      },
      child: Scaffold(
        appBar: BarraApp(aoVoltar: estadoApp.exibirDistros),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(children: [CartaoDetalhesDistro(distro: distro)]),
        ),
      ),
    );
  }
}