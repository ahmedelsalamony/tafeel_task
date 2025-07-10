import 'package:tafeel_task/app_features/users/domain/entities/user_entity.dart';

enum UserStatus {
  initial,
  loading,
  success,
  failure,
  loadingMore,
}

class UsersState {
  final UserStatus status;
  final UserEntity? users;
  final UserDataEntity? userDetails;

  UsersState({
    this.status = UserStatus.initial,
    this.users,
    this.userDetails,
  });

  UsersState copyWith({
    UserStatus? status,
    UserEntity? users,
    UserDataEntity? userDetails,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      userDetails: userDetails ?? this.userDetails,
    );
  }
}
