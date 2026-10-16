import 'package:distro_hopper/componentes/barra_app.dart';
import 'package:distro_hopper/componentes/cartao_teste.dart';
import 'package:distro_hopper/componentes/controles_usuario.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';

class MeusTestes extends StatelessWidget {
  const MeusTestes({super.key});

  @override
  Widget build(BuildContext context) {
    final testes = [...estadoApp.testes]
      ..sort((a, b) => b.data.compareTo(a.data));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, resultado) {
        if (!didPop) estadoApp.exibirDistros();
      },
      child: Scaffold(
        appBar: BarraApp(
          aoVoltar: estadoApp.exibirDistros,
          acoes: const [ControlesUsuario(mostrarMeusTestes: false)],
        ),
        body: testes.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Você ainda não testou nenhuma distro.\n'
                    'Abra uma distro da lista e registre o seu teste!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: CoresTux.cinza),
                  ),
                ),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meus testes (${testes.length})',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Conta: ${estadoApp.usuario?.nome ?? ''}',
                          style: const TextStyle(color: CoresTux.cinza),
                        ),
                      ],
                    ),
                  ),
                  for (final teste in testes)
                    if (estadoApp.distroPorId(teste.idDistro) != null)
                      CartaoTeste(
                        teste: teste,
                        distro: estadoApp.distroPorId(teste.idDistro)!,
                      ),
                ],
              ),
      ),
    );
  }
}