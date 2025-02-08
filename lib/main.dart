import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/constants/constants.dart';
import 'package:komdigi_logbooks_admins/data/datasources/auth_remote_datasource.dart';
import 'package:komdigi_logbooks_admins/data/datasources/pembimbing_remote_datasources.dart';
import 'package:komdigi_logbooks_admins/data/datasources/project_remote_datasources.dart';
import 'package:komdigi_logbooks_admins/presentation/admin/bloc/register_admin/register_admin_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/auth/bloc/login_bloc/login_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/auth/bloc/logout_bloc/logout_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/auth/pages/login_page.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/add_pembimbing/add_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/delete_pembimbing/delete_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/get_pembimbing/get_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/profile/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/project/bloc/create_project/create_project_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/project/bloc/delete_project/delete_project_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/project/bloc/get_project/get_project_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AddPembimbingBloc(
            PembimbingRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => GetPembimbingBloc(
            PembimbingRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => DeletePembimbingBloc(
            PembimbingRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => GetProjectBloc(
            ProjectRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateProjectBloc(
            ProjectRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteProjectBloc(
            ProjectRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterAdminBloc(
            AuthRemoteDatasource(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme:
              DividerThemeData(color: AppColors.primary.withOpacity(0.5)),
          dialogTheme: const DialogTheme(elevation: 0),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.white),
            centerTitle: true,
            color: AppColors.primary,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
