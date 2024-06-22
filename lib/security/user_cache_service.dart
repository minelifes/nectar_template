import 'package:dcache/dcache.dart';
import 'package:nectar_template/entities/user_entity.dart';

class UserCacheService {
  final int validMinutes;
  late Cache _users;
  UserCacheService({this.validMinutes = 180}) {
    _users = LruCache<int, UserEntity>(storage: InMemoryStorage(100))
      ..expiration = Duration(minutes: validMinutes);
  }

  // final HashMap<int, UserCacheInfo> _users = HashMap();
  // final Cache<int, UserCacheInfo> _users = HashMap();

  void saveUser(UserEntity user) {
    _users[user.id!] = user;
  }

  UserEntity? findUser(int id) {
    final user = _users[id];
    if (user == null) return null;
    return user;
  }
}
