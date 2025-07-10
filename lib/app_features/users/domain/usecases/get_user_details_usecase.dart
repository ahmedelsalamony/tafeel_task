import 'package:dartz/dartz.dart';
import 'package:tafeel_task/app_features/users/data/models/user_model.dart';
import 'package:tafeel_task/app_features/users/domain/repositories/user_repository.dart';
import 'package:tafeel_task/app_features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:tafeel_task/core/error/failure.dart';
import 'package:tafeel_task/core/usecases/usecase.dart';

class GetUserDetailsUsecase extends UseCase<UserDetailsModel, Params> {
  final UserRepository repository;

  GetUserDetailsUsecase(this.repository);
  @override
  Future<Either<Failure, UserDetailsModel>> call(Params params) async {
    return await repository.getUserDetails(params.number);
  }
}
