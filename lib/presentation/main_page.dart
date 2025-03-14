import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/core.dart';
import 'package:komdigi_logbooks_admins/presentation/home/pages/home_page.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/pages/pembimbing_pages.dart';
import 'package:komdigi_logbooks_admins/presentation/profile/pages/profile_page.dart';
import 'package:komdigi_logbooks_admins/presentation/project/pages/project_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _widgets = [
    const HomePage(),
    const ProjectPage(),
    const PembimbingPages(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgets,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(
                0.06,
              ),
              blurRadius: 16.0,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            )
          ],
        ),
        child: Theme(
          data: ThemeData(),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            currentIndex: _selectedIndex,
            onTap: (value) => setState(() => _selectedIndex = value),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(color: AppColors.primary),
            selectedIconTheme: const IconThemeData(color: AppColors.primary),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Assets.icons.nav.home.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? AppColors.primary : AppColors.gray1,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.order.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1 ? AppColors.primary : AppColors.gray1,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Project',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.history.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2 ? AppColors.primary : AppColors.gray1,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Pembimbing',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.profile.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 3 ? AppColors.primary : AppColors.gray1,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
