// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_controller.dart';

// **************************************************************************
// NectarRestGenerator
// **************************************************************************

class MediaController extends _MediaController {
  MediaController();

  static void register() {
    Routes.registerRoute((router) {
      final controller = MediaController();
      final corsMiddleware = getIt.get<Nectar>().corsMiddleware;
      router.post(
        "/api/v1/media/",
        controller._uploadHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );

      router.delete(
        "/api/v1/media/<id>",
        controller._removeHandler,
        use: setContentType('application/json')
            .addMiddleware(setHeadersMiddleware({}))
            .addMiddleware(checkJwtMiddleware())
            .addMiddleware(contextProviderMiddleware())
            .addMiddleware(corsMiddleware),
      );
    });
  }

  Future<dynamic> _uploadHandler(Request request) async {
    if (!request.isMultipart || !request.isMultipartForm) {
      throw RestException.badRequest(message: "request is not form");
    }
    final requestFormData = <String, dynamic>{
      await for (final formData in request.multipartFormData)
        if (formData.filename != null)
          formData.name: MultipartFile(
            name: formData.filename!,
            bytes: await formData.part.readBytes(),
          )
        else
          formData.name: await formData.part.readString(),
    };

    return await _returnResponseOrError(() async {
      var queryValue0 =
          int.tryParse(request.url.queryParameters["type"] ?? "") ??
              int.tryParse("'null'");

      final body1 = <String, MultipartFile>{}; //Uint8List
      requestFormData.forEach((key, value) {
        if (value is MultipartFile) {
          body1[key] = value;
        }
      });

      return await upload(queryValue0, body1);
    });
  }

  Future<dynamic> _removeHandler(Request request) async {
    return await _returnResponseOrError(() async {
      final defaultValue0 = null;
      String pathValue0 = _convertPathVariableToType(
          'String', request.params["id"], defaultValue0);

      return await remove(pathValue0);
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
