import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar/nectar.dart';

class UserDetailsService extends UserDetails {
  final UserEntity user;

  UserDetailsService(this.user);

  @override
  bool allowedWithPrivilege(List<String> privileges) => true;

  @override
  bool allowedWithRole(List<String> roles) =>
      roles.contains(user.role.key) || roles.contains("user");

  @override
  String? get email => user.email;

  @override
  getUserModel() => user;

  @override
  bool get isBlocked => user.isBlocked;

  @override
  String? get login => user.email;

  @override
  String get name => "${user.lastName} ${user.name}";

  @override
  String get password => user.password;
}
