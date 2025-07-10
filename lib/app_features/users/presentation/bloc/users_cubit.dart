import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeel_task/app_features/users/domain/entities/user_entity.dart';
import 'package:tafeel_task/app_features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:tafeel_task/app_features/users/domain/usecases/get_user_details_usecase.dart';
import 'package:tafeel_task/app_features/users/presentation/bloc/users_states.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetAllUsersUsecase getAllUsersUsecase;
  final GetUserDetailsUsecase getUserDetailsUsecase;

  UsersCubit(this.getAllUsersUsecase, this.getUserDetailsUsecase)
      : super(UsersState());

  int currentPage = 1;
  bool isLoadingMore = false;

  Future<void> getAllUsers({int page = 1, bool isLoadMore = false}) async {
    if (isLoadingMore && isLoadMore) return;

    if (isLoadMore) {
      isLoadingMore = true;
      emit(state.copyWith(status: UserStatus.loadingMore));
    } else {
      emit(state.copyWith(status: UserStatus.loading));
    }

    final result = await getAllUsersUsecase.call(Params(number: page));

    result.fold(
      (failure) {
        emit(state.copyWith(status: UserStatus.failure));
        isLoadingMore = false;
      },
      (fetchedEntity) {
        final List<UserDataEntity> newUsers = fetchedEntity.users;

        final List<UserDataEntity> combinedUsers = isLoadMore
            ? [...(state.users?.users ?? []), ...newUsers]
            : newUsers;

        final updatedEntity = UserEntity(
          users: combinedUsers,
          page: fetchedEntity.page,
          perPage: fetchedEntity.perPage,
          total: fetchedEntity.total,
        );

        emit(state.copyWith(
          status: UserStatus.success,
          users: updatedEntity,
        ));

        currentPage = fetchedEntity.page;
        isLoadingMore = false;
      },
    );
  }

  void loadNextPage() {
    debugPrint('🚀 Triggering loadNextPage()');
    final int total = state.users?.total ?? 2;
    final int perPage = state.users?.perPage ?? 6;
    final int loadedCount = state.users?.users.length ?? 0;

    if (loadedCount < total) {
      getAllUsers(page: currentPage + 1, isLoadMore: true);
    }
  }

  Future<void> getUserDetails(int userId) async {
    emit(state.copyWith(status: UserStatus.loading));
    final result = await getUserDetailsUsecase.call(Params(number: userId));
    result.fold(
      (failure) => emit(state.copyWith(status: UserStatus.failure)),
      (details) => emit(state.copyWith(
        status: UserStatus.success,
        userDetails: details.data,
      )),
    );
  }
}
