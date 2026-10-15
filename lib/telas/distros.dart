import 'package:distro_hopper/componentes/barra_app.dart';
import 'package:distro_hopper/componentes/cartao_distro.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:flutter/material.dart';

class Distros extends StatelessWidget {
  const Distros({super.key});

  @override
  Widget build(BuildContext context) {
    final distros = estadoApp.distros;

    return Scaffold(
      appBar: const BarraApp(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: distros.length,
        itemBuilder: (context, indice) {
          return CartaoDistro(distro: distros[indice]);
        },
      ),
    );
  }
}