sealed class UserAuth {
  final String email;
  final String password;

  UserAuth(this.email, this.password);

  UserAuth.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

final class UserAuthLogin extends UserAuth {
  UserAuthLogin({required String email, required String password})
      : super(email, password);
}

final class UserAuthSignUp extends UserAuth {
  final bool isMentor;
  final String name;

  UserAuthSignUp({String? email, String? password, required this.isMentor, required this.name})
      : super(email!, password!);

  UserAuthSignUp.fromJson(Map<String, dynamic> json)
      : isMentor = json['isMentor'],
        name = json['name'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'isMentor': isMentor,
        'name': name,
        ...super.toJson(),
      };
}
