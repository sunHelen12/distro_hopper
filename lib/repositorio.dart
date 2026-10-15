import 'dart:convert';

import 'package:distro_hopper/modelos/distro.dart';
import 'package:distro_hopper/modelos/teste.dart';
import 'package:flutter/services.dart' show rootBundle;

class Repositorio {
  static const String _caminhoDistros = 'recursos/jsons/distros.json';
  static const String _caminhoTestes = 'recursos/jsons/testes.json';

  static Future<List<Distro>> carregarDistros() async {
    final texto = await rootBundle.loadString(_caminhoDistros);
    final dados = jsonDecode(texto);

    return (dados['distros'] as List)
        .map((item) => Distro.fromJson(item))
        .toList();
  }

  static Future<List<Teste>> carregarTestes() async {
    final texto = await rootBundle.loadString(_caminhoTestes);
    final dados = jsonDecode(texto);

    return (dados['testes'] as List)
        .map((item) => Teste.fromJson(item))
        .toList();
  }
}