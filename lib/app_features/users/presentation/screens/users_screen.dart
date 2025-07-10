import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tafeel_task/app_features/users/presentation/bloc/users_cubit.dart';
import 'package:tafeel_task/app_features/users/presentation/bloc/users_states.dart';
import 'package:tafeel_task/core/app_router/routes.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollController = ScrollController()
        ..addListener(() {
          print('🔍 SCROLL POSITION: ${_scrollController.position.pixels}');
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
            print('🚀 Triggering loadNextPage()');
            context.read<UsersCubit>().loadNextPage();
          }
        });
      await context.read<UsersCubit>().getAllUsers();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Screen !"),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state.status == UserStatus.loadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == UserStatus.loading &&
              (state.users?.users.isEmpty ?? true)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == UserStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == UserStatus.failure) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (state.status == UserStatus.success) {
            return ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final users = state.users!.users;

                if (index < users.length) {
                  final user = users[index];
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0), // increases height
                        onTap: () {
                          Navigator.pushNamed(context, Routes.userDetails,
                              arguments: user.id);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: user.avatar,
                                fit: BoxFit
                                    .scaleDown, // ensures the image fills the circle nicely
                              ),
                            ),
                          ),
                        ),
                        title: Text("${user.firstName} ${user.lastName}"),
                        subtitle: Text(user.email),
                      ),
                      const Divider(),
                    ],
                  );
                } else {
                  // Show loader at the bottom
                  return state.status == UserStatus.loadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }
              },
              itemCount: state.users!.users.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
