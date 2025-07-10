import 'package:dartz/dartz.dart';
import 'package:tafeel_task/app_features/users/data/data_source/http_remote_data_source.dart';
import 'package:tafeel_task/app_features/users/data/models/user_model.dart';
import 'package:tafeel_task/app_features/users/domain/repositories/user_repository.dart';
import 'package:tafeel_task/core/error/exception.dart';
import 'package:tafeel_task/core/error/failure.dart';

class UsersRepositoryImpl implements UserRepository {
  final HttpRemoteDataSource httpRemoteDataSource;

  UsersRepositoryImpl({required this.httpRemoteDataSource});

  @override
  Future<Either<Failure, UserDetailsModel>> getUserDetails(int userId) async {
    try {
      final userDetails = await httpRemoteDataSource.getUserDetails(userId);
      return Right(userDetails);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUsers(int page) async {
    try {
      final users = await httpRemoteDataSource.getUsers(page);
      return Right(users);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
