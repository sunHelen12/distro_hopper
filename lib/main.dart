import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/tema.dart';
import 'package:distro_hopper/telas/detalhes.dart';
import 'package:distro_hopper/telas/distros.dart';
import 'package:distro_hopper/telas/meus_testes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DistroHopper());
}

class DistroHopper extends StatelessWidget {
  const DistroHopper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GerenciadorEstado()..carregarDados(),
      child: MaterialApp(
        title: 'Distro Hopper',
        debugShowCheckedModeBanner: false,
        theme: tema,
        home: const TelaPrincipal(),
      ),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    estadoApp = context.watch<GerenciadorEstado>();

    if (estadoApp.carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    Widget tela = const SizedBox.shrink();
    if (estadoApp.exibicao == EmExibicao.telaDistros) {
      tela = Distros();
    } else if (estadoApp.exibicao == EmExibicao.telaDetalhes) {
      tela = Detalhes();
    } else if (estadoApp.exibicao == EmExibicao.telaMeusTestes) {
      tela = MeusTestes();
    }

    return tela;
  }
}