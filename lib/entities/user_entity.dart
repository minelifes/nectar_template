import 'package:nectar/nectar.dart';

import 'role_entity.dart';

part 'user_entity.g.dart';

@Entity(tableName: "users")
abstract class _UserEntity {
  @Id()
  @AutoIncrement()
  int? id;

  @Column(name: 'project_id', nullable: true)
  String? projectId;

  @Column(columnType: ColumnType.varchar, length: 32)
  late String phone;

  @Column(
      nullable: true, columnType: ColumnType.varchar, length: 128, unique: true)
  String? email;

  @Column(
    columnType: ColumnType.varchar,
    length: 128,
  )
  late String password;

  @Column()
  late String name;

  @Column(name: "last_name")
  late String lastName;

  @Column(name: "is_archived", defaultValue: false)
  bool isArchived = false;

  @Column(name: "is_blocked", defaultValue: false)
  bool isBlocked = false;

  @ManyToOne(
    referenceClass: '_RoleEntity',
    mappedBy: 'role_id',
    foreignKey: 'key',
  )
  RoleEntity role = RoleEntity()
    ..name = "Користувач"
    ..key = "user";

  @Column(name: 'created_at')
  late DateTime createdAt = DateTime.now();

  @ToJson()
  Map<String, dynamic> customToJson() => {
        "id": id,
        "projectId": projectId,
        "phone": phone,
        "email": email,
        "name": name,
        "lastName": lastName,
        "isArchived": isArchived,
        "isBlocked": isBlocked,
        "role": role.toJson(),
        "createdAt": createdAt.toIso8601String()
      };
}
