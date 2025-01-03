import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/core.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_admins/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/auth_response_model.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/get_pembimbing/get_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/pages/pembimbing_pages.dart';
import 'package:komdigi_logbooks_admins/presentation/project/pages/project_page.dart';
import 'package:komdigi_logbooks_admins/presentation/widgets/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  bool isLoading = false;

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
        isLoading = false;
      });
    } else {
      setState(() {
        user = User(name: 'Guest', email: 'guest@example.com');
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _loadUserData();
    context
        .read<GetPembimbingBloc>()
        .add(const GetPembimbingEvent.getPembimbing());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.bgHome.provider(),
              fit: MediaQuery.of(context).size.width > 600
                  ? BoxFit.cover
                  : BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo,",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Admin",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SpaceHeight(16.0),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.06),
                      blurRadius: 10.0,
                      blurStyle: BlurStyle.outer,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile Anda',
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    const Text(
                      'Nama Admin',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      user?.name ?? 'Loading...',
                      style: const TextStyle(
                        color: AppColors.gray3,
                        fontSize: 16.0,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    const Text(
                      'Email Admin',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      user?.email ?? 'Loading...',
                      style: const TextStyle(
                        color: AppColors.gray3,
                        fontSize: 16.0,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    const Text(
                      'Jumlah Pembimbing',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 16.0,
                      ),
                    ),
                    BlocBuilder<GetPembimbingBloc, GetPembimbingState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const Text(
                              'Loading...',
                              style: TextStyle(
                                color: AppColors.gray3,
                                fontSize: 16.0,
                              ),
                            );
                          },
                          loading: () {
                            return const Text(
                              'Loading...',
                              style: TextStyle(
                                color: AppColors.gray3,
                                fontSize: 16.0,
                              ),
                            );
                          },
                          error: (error) {
                            return const Text(
                              'Error',
                              style: TextStyle(
                                color: AppColors.gray3,
                                fontSize: 16.0,
                              ),
                            );
                          },
                          success: (pembimbing) {
                            return Text(
                              pembimbing.length.toString(),
                              style: const TextStyle(
                                color: AppColors.gray3,
                                fontSize: 16.0,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    MenuButton(
                      color: AppColors.homeGreen,
                      label: 'Daftar Pembimbing',
                      iconPath: Assets.icons.menu.transaksiHariIni.path,
                      onPressed: () {
                        context.push(const PembimbingPages());
                      },
                    ),
                    MenuButton(
                      color: AppColors.homeYellow,
                      label: 'Daftar Project',
                      iconPath: Assets.icons.menu.jumlahPesanan.path,
                      onPressed: () {
                        context.push(const ProjectPage());
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
