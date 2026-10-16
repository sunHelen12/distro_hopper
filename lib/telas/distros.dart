import 'package:distro_hopper/componentes/barra_app.dart';
import 'package:distro_hopper/componentes/cartao_distro.dart';
import 'package:distro_hopper/componentes/controles_usuario.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';

class Distros extends StatefulWidget {
  const Distros({super.key});

  @override
  State<Distros> createState() => _DistrosState();
}

class _DistrosState extends State<Distros> {
  final TextEditingController _campoBusca = TextEditingController();
  String _busca = '';

  @override
  void dispose() {
    _campoBusca.dispose();
    super.dispose();
  }

  void _limpar() {
    _campoBusca.clear();
    setState(() => _busca = '');
  }

  @override
  Widget build(BuildContext context) {
    final termo = _busca.trim().toLowerCase();
    final distros = estadoApp.distros
        .where((distro) => distro.nome.toLowerCase().contains(termo))
        .toList();

    return Scaffold(
      appBar: const BarraApp(acoes: [ControlesUsuario()]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _campoBusca,
              onChanged: (texto) => setState(() => _busca = texto),
              decoration: InputDecoration(
                hintText: 'Pesquisar distro pelo nome',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _busca.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpar',
                        icon: const Icon(Icons.close),
                        onPressed: _limpar,
                      ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: distros.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Nenhuma distro encontrada para "${_busca.trim()}".',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CoresTux.cinza,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: distros.length,
                    itemBuilder: (context, indice) {
                      return CartaoDistro(distro: distros[indice]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}