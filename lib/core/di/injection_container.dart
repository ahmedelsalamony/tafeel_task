import 'package:get_it/get_it.dart';
import 'package:tafeel_task/app_features/users/data/data_source/http_remote_data_source.dart';
import 'package:tafeel_task/app_features/users/data/repositories/users_repository_impl.dart';
import 'package:tafeel_task/app_features/users/domain/repositories/user_repository.dart';
import 'package:tafeel_task/app_features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:tafeel_task/app_features/users/domain/usecases/get_user_details_usecase.dart';
import 'package:tafeel_task/app_features/users/presentation/bloc/users_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - users
  sl.registerLazySingleton<http.Client>(() => http.Client());
  // Cubit
  sl.registerFactory<UsersCubit>(() => UsersCubit(
        sl<GetAllUsersUsecase>(),
        sl<GetUserDetailsUsecase>(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetAllUsersUsecase(sl()));
  sl.registerLazySingleton(() => GetUserDetailsUsecase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UsersRepositoryImpl(
      httpRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<HttpRemoteDataSource>(
    () => HttpRemoteDataSourceImpl(httpClient: sl()),
  );
}
