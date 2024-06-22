import 'package:nectar_template/entities/role_entity.dart';
import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar_template/payloads/requests/user_create_request.dart';
import 'package:nectar_template/payloads/response/message_response.dart';
import 'package:nectar/nectar.dart';

class UserService {
  static Future<List<RoleEntity>> getRoles(UserEntity user) async {
    return await runInDefaultConnection(() async {
      var roles = await RoleEntity.query().select().list();
      roles.removeWhere((role) => role.key == 'machine');
      if (user.role.key == 'superAdmin') return roles;
      if (user.role.key == 'admin') {
        roles.removeWhere((role) => role.key == 'superAdmin');
        return roles;
      }
      throw RestException.notAllowed();
    });
  }

  static Future<Paginated> getProjectUsers(UserEntity user, int page) async {
    return await runInDefaultConnection(() async {
      if (user.role.key == 'superAdmin') {
        return await UserEntity.query()
            .select()
            .where()
            .isArchived(false)
            .paginated(page: page);
      }
      if (user.role.key == 'admin') {
        return await UserEntity.query()
            .select()
            .where()
            .isArchived(false)
            .projectId(user.projectId)
            .paginated(page: page);
      } else {
        throw RestException.notAllowed();
      }
    });
  }

  static Future<UserEntity> getUserById(int id, UserEntity user) async {
    if (user.role.key == 'superAdmin') {
      return getById(id);
    }
    if (user.role.key == 'admin') {
      var cashedUser = await UserEntity.query()
          .select()
          .where()
          .isArchived(false)
          .projectId(user.projectId)
          .id(id)
          .one();
      if (cashedUser != null) return cashedUser;
      throw RestException(message: 'User with this id not found');
    } else {
      throw RestException.notAllowed();
    }
  }

  static Future<UserEntity> _prepareAndSaveUser(
      UserEntity user, UserCreateRequest request) async {
    user
      ..name = request.name
      ..lastName = request.lastName
      ..email = request.email
      ..phone = request.phone
      ..password = request.password!.toHashedPassword()
      ..isBlocked = false
      ..projectId = request.projectId;

    var res = await user.save();
    if (res == null) throw RestException.badRequest();
    return res;
  }

  static Future<UserEntity> createUser(
      UserCreateRequest request, UserEntity user) async {
    return await runInDefaultConnection(() async {
      if (user.role.key == 'superAdmin') {
        final userData = UserEntity()..id = request.id;
        return _prepareAndSaveUser(userData, request);
      } else if (user.role.key == 'admin') {
        UserEntity createdUser = (request.id == null)
            ? (UserEntity()..projectId = request.projectId)
            : await getById(request.id!);
        if (createdUser.projectId != user.projectId) {
          throw RestException.notFound(
              message: "User with id:${request.id} not found ");
        }
        return _prepareAndSaveUser(createdUser, request);
      }
      throw RestException.notAllowed();
    });
  }

  static Future<MessageResponse> archiveUser(
      int userId, UserEntity user) async {
    return await runInDefaultConnection(() async {
      var cachedUser = await getUserById(userId, user);
      user.isArchived = true;
      var res = await cachedUser.save();
      if (res == null) throw RestException.badRequest();
      return MessageResponse.successfullyRemoved();
    });
  }

  static Future<UserEntity> getById(int code) async {
    var unit = await UserEntity.query().select().where().id(code).one();
    if (unit == null) {
      throw RestException.notFound(message: "User with id:$code not found ");
    }
    return unit;
  }

  static Future<UserEntity> getByEmail(String email) async {
    final user = await UserEntity.query().select().where().email(email).one();
    if (user == null) {
      throw RestException.unauthorized(
        message: "User with this email not found!",
      );
    }
    return user;
  }

  static Future<MessageResponse> deleteUserById(int id) async {
    var user = await getById(id);
    user.isArchived = true;
    user.save();
    return MessageResponse.successfullyRemoved();
  }

  static Future<UserEntity> getByPhone(String phone) async {
    final user = await UserEntity.query().select().where().phone(phone).one();
    if (user == null) {
      throw RestException.unauthorized(
        message: "User with this phone not found!",
      );
    }
    return user;
  }

  static Future<UserEntity> saveSelf(
      UserCreateRequest request, UserEntity user) async {
    user.email = request.email;
    user.name = request.name;
    user.lastName = request.lastName;
    user.phone = request.phone;
    if (request.password != null && (request.password?.length ?? 0) > 8) {
      user.password = request.password!.toHashedPassword();
    }

    final res = await user.save();
    if (res == null) {
      throw RestException.badRequest(message: "Can't update user!");
    }
    return user;
  }

  static Future<UserEntity> save(
      UserCreateRequest request, String tokenRoleKey) async {
    final existUser =
        await UserEntity.query().select().where().email(request.email).one();
    if (existUser != null) {
      throw RestException.itemAlreadyExist("User");
    }

    if (tokenRoleKey == 'admin' && request.role == 'superAdmin') {
      throw RestException.notAllowed();
    }

    if (tokenRoleKey == 'manager' &&
        (request.role == 'superAdmin' || request.role == 'admin')) {
      throw RestException.notAllowed();
    }

    if (tokenRoleKey == 'user' || tokenRoleKey == 'machine') {
      throw RestException.notAllowed();
    }

    if (request.password == null || request.password?.isEmpty == true) {
      throw RestException.badRequest();
    }

    final userData = UserEntity()
      ..name = request.name
      ..lastName = request.lastName
      ..email = request.email
      ..phone = request.phone
      ..password = request.password!.toHashedPassword()
      ..isBlocked = false;

    if (request.role != null) {
      userData.role = RoleEntity()..key = request.role!;
    }
    final user = await userData.save();
    if (user == null) {
      throw RestException(
        message: "Can't save user",
      );
    }
    return user;
  }

  static Future<MessageResponse> delete(int code) async {
    final res = await UserEntity.query().select().where().id(code).one();
    if (res == null) {
      throw RestException.notFound(message: "User with code:$code not found");
    }
    final affected = await res.delete();
    if (affected == 0) {
      throw RestException.badRequest(message: "Can't remove user");
    }
    return MessageResponse("Successfully removed");
  }
}
