import 'package:nectar/nectar.dart';

part 'auth_request.g.dart';

@JsonSerializable(createToJson: false)
class AuthRequest {
  final String email;
  final String password;

  const AuthRequest({
    required this.email,
    required this.password,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
}
