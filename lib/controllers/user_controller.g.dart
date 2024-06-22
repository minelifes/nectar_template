// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// NectarRestGenerator
// **************************************************************************

class UserController extends _UserController {
  UserController();

  static void register() {
    Routes.registerRoute((router) {
      final controller = UserController();
      final corsMiddleware = getIt.get<Nectar>().corsMiddleware;
      router.get(
        "/api/v1/user/roles",
        controller._getRolesHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(hasRoleMiddleware(['admin', 'superAdmin']))
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );

      router.get(
        "/api/v1/user/",
        controller._listHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );

      router.get(
        "/api/v1/user/<id>",
        controller._byIdHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );

      router.post(
        "/api/v1/user/",
        controller._saveHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );

      router.delete(
        "/api/v1/user/<id>",
        controller._deleteHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );
    });
  }

  Future<dynamic> _getRolesHandler(Request request) async {
    return await _returnResponseOrError(() async {
      final request0 = request;

      return await getRoles(request0);
    });
  }

  Future<dynamic> _listHandler(Request request) async {
    return await _returnResponseOrError(() async {
      var queryValue0 =
          int.tryParse(request.url.queryParameters["page"] ?? "") ??
              int.tryParse("'null'");

      final request1 = request;

      return await list(queryValue0, request1);
    });
  }

  Future<dynamic> _byIdHandler(Request request) async {
    return await _returnResponseOrError(() async {
      final defaultValue0 = null;
      int pathValue0 = _convertPathVariableToType(
          'int', request.params["id"], defaultValue0);

      final request1 = request;

      return await byId(pathValue0, request1);
    });
  }

  Future<dynamic> _saveHandler(Request request) async {
    return await _returnResponseOrError(() async {
      final str0 = await request.readAsString();
      final json0 = jsonDecode(str0);
      final body0 = UserCreateRequest.fromJson(json0);

      final request1 = request;

      return await save(body0, request1);
    });
  }

  Future<dynamic> _deleteHandler(Request request) async {
    return await _returnResponseOrError(() async {
      final defaultValue0 = null;
      int pathValue0 = _convertPathVariableToType(
          'int', request.params["id"], defaultValue0);

      final request1 = request;

      return await delete(pathValue0, request1);
    });
  }

  dynamic _convertPathVariableToType(
      String type, String? path, String? defaultValue) {
    if (path == null && defaultValue == null) return null;
    switch (type) {
      case 'String':
        return path ?? defaultValue ?? "";
      case 'int':
        return int.tryParse(path ?? defaultValue ?? "");
      case 'double':
        return double.tryParse(path ?? defaultValue ?? "");
      case 'bool':
        return bool.tryParse(path ?? defaultValue ?? "");
    }
  }

  Future<dynamic> _returnResponseOrError(
    Future<dynamic> Function() call,
  ) async {
    try {
      return await call();
    } on RestException catch (e) {
      return Response(e.statusCode, body: jsonEncode({"error": e.toString()}));
    } catch (e) {
      return Response(500, body: jsonEncode({"error": e.toString()}));
    }
  }
}
