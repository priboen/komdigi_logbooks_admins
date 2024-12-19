import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/core.dart';
import 'package:komdigi_logbooks_admins/presentation/widgets/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Anda',
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SpaceHeight(16.0),
                    Text(
                      'Nama Admin',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Ahmad Yanto',
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: 16.0,
                      ),
                    ),
                    SpaceHeight(16.0),
                    Text(
                      'Lokasi Admin',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Yogyakarta',
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: 16.0,
                      ),
                    ),
                    SpaceHeight(16.0),
                    const Text(
                      'Jumlah Pembimbing',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: 16.0,
                      ),
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
                      onPressed: () {},
                    ),
                    MenuButton(
                      color: AppColors.homeYellow,
                      label: 'Daftar Project',
                      iconPath: Assets.icons.menu.jumlahPesanan.path,
                      onPressed: () {},
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
