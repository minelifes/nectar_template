import 'package:nectar/nectar.dart';

part 'user_create_request.g.dart';

@JsonSerializable(createToJson: false)
class UserCreateRequest {
  final int? id;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String? password;
  final String? role;
  final String? projectId;

  const UserCreateRequest(
      {this.id,
      required this.name,
      required this.lastName,
      required this.phone,
      required this.email,
      this.role,
      this.password = "",
      this.projectId});

  factory UserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserCreateRequestFromJson(json);
}
