import 'package:nectar_template/entities/media_entity.dart';
import 'package:nectar_template/payloads/response/message_response.dart';
import 'package:nectar_template/services/media_service.dart';
import 'package:nectar/nectar.dart';

part 'media_controller.g.dart';

@RestController(path: "/api/v1/media")
class _MediaController {
  @AuthWithJwt()
  @PostMapping("/")
  @AcceptMultipartFormData()
  Future<MediaEntity> upload(
    @QueryVariable() int? type,
    @Files() Map<String, MultipartFile> files,
  ) async {
    if (files.isEmpty) throw RestException.badRequest();
    final key = files.keys.first;
    final file = files[key]!;
    final res = await MediaService.saveMedia(file, type ?? 0);
    if (res == null) throw RestException(message: "File not saved");
    return res;
  }

  @AuthWithJwt()
  @DeleteMapping("/<id>")
  Future<MessageResponse> remove(
    @PathVariable() String? id,
  ) async {
    if (id == null) throw RestException.badRequest();
    await MediaService.removeMedia(id);
    return MessageResponse.successfullyRemoved();
  }
}
