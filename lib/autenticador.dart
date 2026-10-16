import 'package:distro_hopper/usuario.dart';

class Autenticador {
  static const List<Usuario> contas = [
    Usuario("Linus Pinguim", "linus.pinguim@distrohopper.com"),
    Usuario("Tuxa Silva", "tuxa.silva@distrohopper.com"),
  ];

  static Future<Usuario?> login(Usuario conta) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return conta;
  }

  static Future<Usuario?> recuperarUsuario() async {
    return contas.first;
  }

  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}