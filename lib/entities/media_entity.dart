import 'package:nectar/nectar.dart';

part 'media_entity.g.dart';

@Entity(tableName: "media")
abstract class _MediaEntity {
  @Id()
  @UuidGenerate()
  String? id;

  @Column()
  late String url;

  @Column()
  late int type;
}
