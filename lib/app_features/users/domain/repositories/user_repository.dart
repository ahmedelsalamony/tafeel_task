import 'package:dartz/dartz.dart';
import 'package:tafeel_task/app_features/users/data/models/user_model.dart';
import 'package:tafeel_task/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUsers(int page);
  Future<Either<Failure, UserDetailsModel>> getUserDetails(int userId);
}
