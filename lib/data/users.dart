import 'package:intl/intl.dart';

class User {
  String nombre;
  String apellido;
  String contrasena; // Se pide
  String cedula;
  String correo; // Se pide
  String numeroTel;
  double balance; // inicia en 0
  bool activo; // NO se pide, siempre true a menos que se bloquee
  bool admin; // NO se pide, siempre false
  int tipoArea; // IGNORAR
  bool verificado; // Se pregunta
  String username;
  DateTime? ingreso; // No se registra

  User({
    required this.nombre,
    required this.apellido,
    required this.contrasena,
    required this.cedula,
    required this.correo,
    required this.numeroTel,
    required this.balance,
    required this.activo,
    required this.admin,
    required this.tipoArea,
    required this.verificado,
    required this.username,
    this.ingreso,
  });

  // Convertir a JSON
  Map<String, dynamic> toJson() => {
        'profileName': nombre,
        'profileLastName': apellido,
        'profilePassword': contrasena,
        'personalID': cedula,
        'electronicMail': correo,
        'phoneNumber': numeroTel,
        'initialDigitalWalletBalance': balance,
        'isAccountAdmin': admin,
        'workArea': tipoArea,
        'profileNickName': username,
        "isAccountVerified": verificado,
        'entryDate': DateFormat('yyyy-MM-dd').format(ingreso!),
        'isAccountActive': activo,
      };

  // Convertir de JSON a instancia de User
  factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json['profileName'] ?? '',
        apellido: json['profileLastName'] ?? '',
        contrasena: json['profilePassword'] ?? '',
        cedula: json['personalID'] ?? '',
        correo: json['electronicMail'] ?? '',
        numeroTel: json['phoneNumber'] ?? '',
        balance:
            (json['initialDigitalWalletBalance'] as num?)?.toDouble() ?? 0.0,
        activo: json['isAccountActive'] ?? true,
        admin: json['isAccountAdmin'] ?? false,
        tipoArea: json['workArea'] ?? 0,
        verificado: json['isAccountVerified'] ?? false,
        username: json['profileNickName'] ?? '',
        ingreso: json['entryDate'] != null
            ? DateFormat('yyyy-MM-dd').parse(json['entryDate'])
            : null,
      );

  Map<String, dynamic> toJsonUp() {
    return {
      'currentProfileNickName': username,
      'profileNickName': username,
      'profileName': nombre,
      'profileLastName': apellido,
      'electronicMail': correo,
      // Otros campos no son necesarios para este endpoint
    };
  }

  void updateFromJson(Map<String, dynamic> json) {
    username = json['currentProfileNickName'];
    username = json['profileNickName'];
    nombre = json['profileName'];
    apellido = json['profileLastName'];
    correo = json['electronicMail'];
  }
}
