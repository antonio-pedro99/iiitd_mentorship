import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';

void main() {
  group('UserAuthLogin', () {
    test('should create a valid UserAuthLogin object', () {
      final userAuthLogin =
          UserAuthLogin(email: 'test@example.com', password: 'password');

      expect(userAuthLogin, isA<UserAuthLogin>());
      expect(userAuthLogin.email, equals('test@example.com'));
      expect(userAuthLogin.password, equals('password'));
    });
  });

  group('UserAuthSignUp', () {
    test('fromJson() should return a valid UserAuthSignUp object', () {
      final json = {
        'email': 'test@example.com',
        'password': 'password',
        'isMentor': true,
        'name': 'John Doe'
      };
      final userAuthSignUp = UserAuthSignUp.fromJson(json);

      expect(userAuthSignUp, isA<UserAuthSignUp>());
      expect(userAuthSignUp.email, equals('test@example.com'));
      expect(userAuthSignUp.password, equals('password'));
      expect(userAuthSignUp.isMentor, equals(true));
      expect(userAuthSignUp.name, equals('John Doe'));
    });

    test('toJson() should return a valid JSON object', () {
      final userAuthSignUp = UserAuthSignUp(
          email: 'test@example.com',
          password: 'password',
          isMentor: true,
          name: 'John Doe');
      final json = userAuthSignUp.toJson();

      expect(json['email'], equals('test@example.com'));
      expect(json['password'], equals('password'));
      expect(json['isMentor'], equals(true));
      expect(json['name'], equals('John Doe'));
    });
  });
}
