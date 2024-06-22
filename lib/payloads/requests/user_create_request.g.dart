// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateRequest _$UserCreateRequestFromJson(Map<String, dynamic> json) =>
    UserCreateRequest(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      role: json['role'] as String?,
      password: json['password'] as String? ?? "",
      projectId: json['projectId'] as String?,
    );
