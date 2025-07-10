import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeel_task/app_features/users/presentation/screens/user_details_screen.dart';
import 'package:tafeel_task/app_features/users/presentation/screens/users_screen.dart';
import 'package:tafeel_task/core/app_router/routes.dart';
import 'package:tafeel_task/core/di/injection_container.dart';
import '../../app_features/users/presentation/bloc/users_cubit.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.users:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => sl<UsersCubit>(),
                  child: const UsersScreen(),
                ));

      case Routes.userDetails:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => sl<UsersCubit>(),
                  child: UserDetailsScreen(
                    userId: userId,
                  ),
                ));
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}
