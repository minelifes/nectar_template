import 'package:nectar_template/dtos/user_dto.dart';
import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar_template/payloads/requests/auth_request.dart';
import 'package:nectar_template/payloads/requests/user_create_request.dart';
import 'package:nectar_template/services/user_service.dart';
import 'package:nectar_template/utils/email_validator.dart';
import 'package:nectar/nectar.dart';

part 'auth_controller.g.dart';

@RestController(path: "/api/v1/auth")
class _AuthController {
  @PostMapping('/register')
  @AuthWithJwt()
  Future<UserDTO> registerUser(
      @RequestBody() UserCreateRequest request, UserDetails details) async {
    final userToken = details.getUserModel() as UserEntity;

    if (request.email.isEmpty || !(request.password?.isNotEmpty == true)) {
      throw RestException.badRequest();
    }
    if (!request.email.isValidEmail()) {
      throw RestException.badRequest();
    }

    final user = await UserService.save(request, userToken.role.key);
    try {
      final token = getIt.get<JwtSecurity>().generateToken(
            JwtPayload(
                id: user.id!,
                userLogin: user.email,
                userName: "${user.lastName} ${user.name}",
                createdAt: DateTime.now()),
          );
      return user.toDto(token, DateTime.now().add(Duration(days: 4)));
    } catch (_) {
      throw RestException(message: "Can't save user");
    }
  }

  @PostMapping('/login')
  Future<UserDTO> login(@RequestBody() AuthRequest request) async {
    if (request.email.isEmpty || request.password.isEmpty) {
      throw RestException.badRequest();
    }
    if (!request.email.isValidEmail()) {
      throw RestException.badRequest();
    }
    final user = await runInDefaultConnection(
        () async => await UserService.getByEmail(request.email));
    if (!request.password.isPasswordEq(user.password)) {
      throw RestException.unauthorized(
        message: "User with this data not found!",
      );
    }
    final token = getIt.get<JwtSecurity>().generateToken(
          JwtPayload(
              id: user.id!,
              userLogin: user.email,
              userName: "${user.lastName} ${user.name}",
              createdAt: DateTime.now()),
        );
    return user.toDto(token, DateTime.now().add(Duration(days: 4)));
  }
}
