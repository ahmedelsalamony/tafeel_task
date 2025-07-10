import 'package:tafeel_task/app_features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.users,
    required super.page,
    required super.perPage,
    required super.total,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      users:
          (json['data'] as List).map((e) => UserDataModel.fromJson(e)).toList(),
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.avatar,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      avatar: json['avatar'] ?? "",
    );
  }
}

class UserDetailsModel {
  final UserDataModel data;
  final String supportText;
  final String supportUrl;

  UserDetailsModel({
    required this.data,
    required this.supportText,
    required this.supportUrl,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      data: UserDataModel.fromJson(json['data']),
      supportText: json['support']?['text'] ?? '',
      supportUrl: json['support']?['url'] ?? '',
    );
  }
}
