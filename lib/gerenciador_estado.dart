import 'package:distro_hopper/modelos/distro.dart';
import 'package:distro_hopper/modelos/teste.dart';
import 'package:distro_hopper/repositorio.dart';
import 'package:distro_hopper/usuario.dart';
import 'package:flutter/material.dart';

enum EmExibicao { telaDistros, telaDetalhes, telaMeusTestes }

class GerenciadorEstado extends ChangeNotifier {
  EmExibicao _exibicao = EmExibicao.telaDistros;
  EmExibicao get exibicao => _exibicao;

  int _idDistro = -1;
  int get idDistro => _idDistro;

  bool _carregando = true;
  bool get carregando => _carregando;

  List<Distro> _distros = [];
  List<Distro> get distros => _distros;

  List<Teste> _testes = [];
  List<Teste> get testes => _testes;

  Usuario? _usuario;
  Usuario? get usuario => _usuario;
  bool get logado => _usuario != null;

  Future<void> carregarDados() async {
    _distros = await Repositorio.carregarDistros();
    _testes = await Repositorio.carregarTestes();
    _carregando = false;

    notifyListeners();
  }

  void exibirDistros() {
    _exibicao = EmExibicao.telaDistros;

    notifyListeners();
  }

  void exibirDetalhes(int idDistro) {
    _exibicao = EmExibicao.telaDetalhes;
    _idDistro = idDistro;

    notifyListeners();
  }

  void exibirMeusTestes() {
    if (!logado) return; 

    _exibicao = EmExibicao.telaMeusTestes;

    notifyListeners();
  }

  void login(Usuario? usuario) {
    _usuario = usuario;

    notifyListeners();
  }

  void logout() {
    _usuario = null;

    if (_exibicao == EmExibicao.telaMeusTestes) {
      _exibicao = EmExibicao.telaDistros;
    }

    notifyListeners();
  }

  Distro? distroPorId(int id) {
    for (final distro in _distros) {
      if (distro.id == id) return distro;
    }
    return null;
  }

  Distro? get distroSelecionada => distroPorId(_idDistro);

  Teste? testeDaDistro(int idDistro) {
    for (final teste in _testes) {
      if (teste.idDistro == idDistro) return teste;
    }
    return null;
  }

  bool foiTestada(int idDistro) => testeDaDistro(idDistro) != null;

  void marcarTestada(int idDistro) {
    if (!logado || foiTestada(idDistro)) return;

    _testes.add(
      Teste(
        id: _proximoId(),
        idDistro: idDistro,
        nota: 0,
        comentario: '',
        data: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void avaliar(int idDistro, int nota, String comentario) {
    if (!logado) return;

    final existente = testeDaDistro(idDistro);
    final novo = Teste(
      id: existente?.id ?? _proximoId(),
      idDistro: idDistro,
      nota: nota,
      comentario: comentario,
      data: DateTime.now(),
    );

    if (existente == null) {
      _testes.add(novo);
    } else {
      _testes[_testes.indexOf(existente)] = novo;
    }

    notifyListeners();
  }

  void removerTeste(int idDistro) {
    if (!logado) return;

    _testes.removeWhere((teste) => teste.idDistro == idDistro);

    notifyListeners();
  }

  int _proximoId() {
    if (_testes.isEmpty) return 1;
    return _testes.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
  }
}

late GerenciadorEstado estadoApp;