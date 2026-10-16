import 'package:distro_hopper/componentes/avaliacao_estrelas.dart';
import 'package:distro_hopper/componentes/controles_usuario.dart';
import 'package:distro_hopper/gerenciador_estado.dart';
import 'package:distro_hopper/modelos/distro.dart';
import 'package:distro_hopper/modelos/teste.dart';
import 'package:distro_hopper/tema.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class FormularioTeste extends StatefulWidget {
  final Distro distro;

  const FormularioTeste({super.key, required this.distro});

  @override
  State<FormularioTeste> createState() => _FormularioTesteState();
}

class _FormularioTesteState extends State<FormularioTeste> {
  int _nota = 0;
  final TextEditingController _comentario = TextEditingController();
  final TextEditingController _ambiente = TextEditingController();
  final TextEditingController _versao = TextEditingController();

  @override
  void dispose() {
    _comentario.dispose();
    _ambiente.dispose();
    _versao.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  void _salvar() {
    if (_nota == 0) {
      _mostrarMensagem('Escolha uma nota de 1 a 5 estrelas.');
      return;
    }

    estadoApp.avaliar(
      widget.distro.id,
      _nota,
      _comentario.text.trim(),
      ambiente: _ambiente.text.trim(),
      versao: _versao.text.trim(),
    );

    setState(() {
      _nota = 0;
      _comentario.clear();
      _ambiente.clear();
      _versao.clear();
    });
    _mostrarMensagem('Teste salvo!');
  }

  @override
  Widget build(BuildContext context) {
    if (!estadoApp.logado) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meu teste',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Faça login para registrar o seu teste desta distro, '
                'com nota e comentário.',
                style: TextStyle(color: CoresTux.cinza),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  final conta = await escolherConta(context);
                  if (conta != null) await entrarCom(conta);
                },
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
              ),
            ],
          ),
        ),
      );
    }

    final anteriores = estadoApp.testesDaDistro(widget.distro.id);

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Novo teste',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                AvaliacaoEstrelas(
                  nota: _nota,
                  tamanho: 36,
                  aoMudar: (valor) => setState(() => _nota = valor),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ambiente,
                        decoration: const InputDecoration(
                          labelText: 'Ambiente gráfico',
                          hintText: 'GNOME, KDE...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _versao,
                        decoration: const InputDecoration(
                          labelText: 'Versão',
                          hintText: 'Ex.: 24.04',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _comentario,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Comentário',
                    hintText: 'O que achou? Instalação, desempenho, visual...',
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _salvar,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                    if (anteriores.isEmpty)
                      TextButton(
                        onPressed: () {
                          estadoApp.marcarTestada(widget.distro.id);
                          _mostrarMensagem('Marcada como testada.');
                        },
                        child: const Text('Só marcar como testada'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (anteriores.isNotEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meus testes desta distro (${anteriores.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (final teste in anteriores) _itemHistorico(teste),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _itemHistorico(Teste teste) {
    final detalhes = [
      if (teste.ambiente.isNotEmpty) teste.ambiente,
      if (teste.versao.isNotEmpty) 'versão ${teste.versao}',
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (teste.nota > 0)
                  AvaliacaoEstrelas(nota: teste.nota, tamanho: 18)
                else
                  const Text(
                    'Sem nota',
                    style: TextStyle(color: CoresTux.cinza),
                  ),
                Text(
                  DateFormat('dd/MM/yyyy').format(teste.data),
                  style: const TextStyle(fontSize: 12, color: CoresTux.cinza),
                ),
                if (detalhes.isNotEmpty)
                  Text(
                    detalhes,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CoresTux.laranjaEscuro,
                    ),
                  ),
                if (teste.comentario.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(teste.comentario),
                  ),
                const Divider(),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Remover este teste',
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              estadoApp.removerTeste(teste.id);
              _mostrarMensagem('Teste removido.');
            },
          ),
        ],
      ),
    );
  }
}