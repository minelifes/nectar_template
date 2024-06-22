import 'package:nectar_template/entities/role_entity.dart';
import 'package:nectar_template/entities/user_entity.dart';

extension UserDTOExt on UserEntity {
  UserDTO toDto(String token, DateTime tokenExpire) =>
      UserDTO.fromUser(this, token, tokenExpire);
}

class UserDTO {
  final int id;
  final String phone;
  final String? email;
  final String name;
  final String lastName;
  final bool isBlocked;
  final RoleEntity role;
  final String token;
  final String? projectId;
  final DateTime tokenExpire;

  const UserDTO({
    required this.id,
    required this.phone,
    required this.email,
    required this.name,
    required this.lastName,
    required this.isBlocked,
    required this.role,
    required this.token,
    required this.tokenExpire,
    this.projectId,
  });

  factory UserDTO.fromUser(
          UserEntity entity, String token, DateTime tokenExpire) =>
      UserDTO(
        id: entity.id!,
        phone: entity.phone,
        email: entity.email,
        name: entity.name,
        lastName: entity.lastName,
        isBlocked: entity.isBlocked,
        role: entity.role,
        token: token,
        tokenExpire: tokenExpire,
        projectId: entity.projectId,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "lastName": lastName,
        "isBlocked": isBlocked,
        "role": role.toJson(),
        "token": token,
        "projectId": projectId,
        "tokenExpire": tokenExpire.toIso8601String(),
      };
}
