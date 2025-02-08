import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/components/components.dart';
import 'package:komdigi_logbooks_admins/core/core.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_admins/presentation/admin/bloc/register_admin/register_admin_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/main_page.dart';

class AddAdminPage extends StatefulWidget {
  const AddAdminPage({super.key});

  @override
  State<AddAdminPage> createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Admin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(controller: nameController, label: 'Nama Admin'),
              const SpaceHeight(16),
              CustomTextField(controller: emailController, label: 'Email'),
              const SpaceHeight(16),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: !isShowPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  icon: Icon(
                    isShowPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: passwordConfirmController,
                label: 'Konfirmasi Password',
                obscureText: !isShowConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowConfirmPassword = !isShowConfirmPassword;
                    });
                  },
                  icon: Icon(
                    isShowConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              const SpaceHeight(32),
              BlocConsumer<RegisterAdminBloc, RegisterAdminState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (admin) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Admin ${admin.data!.name} berhasil ditambahkan'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      context.pushReplacement(const MainPage());
                    },
                    error: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              passwordConfirmController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Semua field harus diisi'),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          } else if (passwordController.text !=
                              passwordConfirmController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password tidak sama'),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          } else {
                            context.read<RegisterAdminBloc>().add(
                                  RegisterAdminEvent.registerAdmin(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                        label: 'Tambah Admin',
                      );
                    },
                    loading: () {
                      return const CircularProgressIndicator();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
