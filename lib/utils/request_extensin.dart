import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar/nectar.dart';

extension RequestExtension on Request {
  UserEntity? getUser() {
    final obj = context[MiddlewareKeys.userDetails];
    if (obj == null) return null;
    return (obj as UserDetails).getUserModel() as UserEntity;
  }
}
