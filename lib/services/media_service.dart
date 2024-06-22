import 'dart:io';

import 'package:nectar_template/entities/media_entity.dart';
import 'package:nectar/nectar.dart';

class MediaService {
  static const fileFolder = "media/";

  static Future<MediaEntity?> saveMedia(
      MultipartFile fileInfo, int type) async {
    final uuid = generateUUID();
    final filePath =
        "$fileFolder${type == 1 ? "videos" : "images"}/$uuid.${fileInfo.name.split(".").last}";
    final file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsBytesSync(fileInfo.bytes);
    final media = MediaEntity()
      ..id = uuid
      ..type = type
      ..url = "/$filePath";
    return await media.save();
  }

  static Future<bool> removeMedia(String id) async {
    final media = await MediaEntity.query().select().where().id(id).one();
    if (media == null) throw RestException(message: "Media not found");
    final file = File(media.url.replaceFirst("/", ""));
    try {
      file.deleteSync();
    } catch (_) {}
    media.url = "";
    //@TODO here we need to check if we have relation ti this media, and if have remove them.
    await media.save();
    return true;
  }
}
