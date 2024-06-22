import 'package:nectar_template/entities/role_entity.dart';
import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar_template/payloads/requests/user_create_request.dart';
import 'package:nectar_template/payloads/response/message_response.dart';
import 'package:nectar_template/services/user_service.dart';
import 'package:nectar/nectar.dart';

part 'user_controller.g.dart';

@RestController(path: '/api/v1/user')
class _UserController {
  @AuthWithJwt()
  @HasRole(["admin", "superAdmin"])
  @GetMapping('/roles')
  Future<List<RoleEntity>> getRoles(Request request) {
    final user = request.context[MiddlewareKeys.userDetails]! as UserDetails;
    return UserService.getRoles(user.getUserModel() as UserEntity);
  }

  @AuthWithJwt()
  @GetMapping('/')
  Future<Paginated> list(
      @QueryVariable(name: 'page') int? page, Request request) {
    final user = request.context[MiddlewareKeys.userDetails]! as UserDetails;
    return UserService.getProjectUsers(user.getUserModel(), page ?? 1);
  }

  @AuthWithJwt()
  @GetMapping('/<id>')
  Future<UserEntity> byId(@PathVariable() int id, Request request) {
    final user = request.context[MiddlewareKeys.userDetails]! as UserDetails;
    return UserService.getUserById(id, user.getUserModel());
  }

  @AuthWithJwt()
  @PostMapping('/')
  Future<UserEntity> save(
      @RequestBody() UserCreateRequest userRequest, Request request) {
    final user = request.context[MiddlewareKeys.userDetails]! as UserDetails;
    return UserService.createUser(userRequest, user.getUserModel());
  }

  @AuthWithJwt()
  @DeleteMapping('/<id>')
  Future<MessageResponse> delete(@PathVariable() int id, Request request) {
    final user = request.context[MiddlewareKeys.userDetails]! as UserDetails;
    return UserService.archiveUser(id, user.getUserModel());
  }
}
