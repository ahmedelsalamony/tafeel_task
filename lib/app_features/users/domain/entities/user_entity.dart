import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final List<UserDataEntity> users;
  final int page;
  final int perPage;
  final int total;

  const UserEntity({
    required this.users,
    required this.page,
    required this.perPage,
    required this.total,
  });

  @override
  List<Object?> get props => [
        users,
        page,
        perPage,
        total,
      ];
}

class UserDataEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        avatar,
      ];

  const UserDataEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.avatar});
}
