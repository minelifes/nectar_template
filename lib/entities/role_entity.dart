import 'package:nectar/nectar.dart';

part 'role_entity.g.dart';

@Entity(tableName: "roles")
abstract class _RoleEntity {
  @Id()
  late String key;

  @Column()
  late String name;
}
