import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tafeel_task/app_features/users/data/models/user_model.dart';
import 'package:tafeel_task/app_features/users/domain/repositories/user_repository.dart';
import 'package:tafeel_task/core/error/failure.dart';
import 'package:tafeel_task/core/usecases/usecase.dart';

class GetAllUsersUsecase extends UseCase<UserModel, Params> {
  final UserRepository repository;

  GetAllUsersUsecase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(Params params) async {
    return await repository.getUsers(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
