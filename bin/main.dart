import 'dart:io';

import 'package:nectar_template/controllers/auth_controller.dart';
import 'package:nectar_template/controllers/media_controller.dart';
import 'package:nectar_template/controllers/user_controller.dart';
import 'package:nectar_template/db.dart';
import 'package:nectar_template/entities/user_entity.dart';
import 'package:nectar_template/security/user_cache_service.dart';
import 'package:nectar_template/security/user_details.dart';
import 'package:nectar/nectar.dart';

void _registerControllers() {
  AuthController.register();
  MediaController.register();
  UserController.register();
}

Handler configCors(RouterPlus app) {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*', //http://localhost:5173
    'Access-Control-Allow-Methods': 'GET, POST, DELETE, PUT, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, authorization, content-type',
    'Content-Security-Policy':
        "default-src 'self';base-uri 'self';font-src 'self' https: data:;form-action 'self';frame-ancestors 'self';img-src 'self' data:;object-src 'none';script-src 'self';script-src-attr 'none';style-src 'self' https: 'unsafe-inline';upgrade-insecure-requests",
    'Cross-Origin-Opener-Policy': 'same-origin',
    'Cross-Origin-Resource-Policy': 'same-origin', 'Origin-Agent-Cluster': "?1",
    'Referrer-Policy': 'no-referrer',
  };
  final handler = Pipeline().addMiddleware((innerHandler) {
    return (request) async {
      final response = await innerHandler(request);

      // Set CORS when responding to OPTIONS request
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }

      // Move onto handler
      return response.change(headers: {
        ...response.headers,
        ...corsHeaders,
        HttpHeaders.authorizationHeader: ""
      });
    };
  }).addHandler(app.shelfRouter);
  return handler;
}

void main() {
  final cache = UserCacheService();
  _registerControllers();
  Nectar.configure()
      .setPort(9191)
      .enableJwtSecurity(
        JwtSecurity(
          secretKey: "lksdnfgsi5gsi5gijs58gshg58hsr5ys5hg",
          userDetailsFromPayload: (JwtPayload payload) async {
            var user = cache.findUser(payload.id);
            if (user == null) {
              user = await UserEntity.query()
                  .select()
                  .where()
                  .id(payload.id)
                  .one();
              if (user == null) return null;
              cache.saveUser(user);
            }
            return UserDetailsService(user);
          },
        ),
      )
      .withDefaultConnection(dbConfig)
      .start(configurer: configCors);
}
