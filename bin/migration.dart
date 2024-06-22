import 'package:nectar_template/db.dart';
import 'package:nectar_template/entities/media_entity.dart';
import 'package:nectar_template/entities/role_entity.dart';
import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar/nectar.dart';

void main() async {
  Nectar.configure();
  final db = Db.configure();
  db.defaultConnection = db.newConnection(dbConfig);
  await _createTables();
  await _createRoles();
  await db.close();
}

Future<void> _createTables() async {
  await UserEntity.migration().createTable();
  await RoleEntity.migration().createTable();
  await MediaEntity.migration().createTable();
}

Future<void> _createRoles() async {
  final superAdminRole = RoleEntity()
    ..key = "superAdmin"
    ..name = "superAdmin";
  final adminRole = RoleEntity()
    ..key = "admin"
    ..name = "admin";
  final userRole = RoleEntity()
    ..key = "user"
    ..name = "user";
  final managerRole = RoleEntity()
    ..key = "manager"
    ..name = "manager";

  await superAdminRole.save();
  await adminRole.save();
  await userRole.save();
  await managerRole.save();

  final superAdmin = UserEntity()
    ..id = 1
    ..name = "admin"
    ..phone = "+380111111111"
    ..password = "admin".toHashedPassword()
    ..lastName = "admin"
    ..email = "admin@steld.com"
    ..role = superAdminRole;

  await superAdmin.save();
}
