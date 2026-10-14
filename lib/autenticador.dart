import 'package:distro_hopper/usuario.dart';

class Autenticador {
  static const Usuario _usuarioMock = Usuario(
    "Linus Pinguim",
    "linus.pinguim@distrohopper.com",
  );

  static Future<Usuario?> login() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _usuarioMock;
  }

  static Future<Usuario?> recuperarUsuario() async {
    return _usuarioMock;
  }

  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}