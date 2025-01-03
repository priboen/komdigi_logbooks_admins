import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/components/components.dart';
import 'package:komdigi_logbooks_admins/core/constants/colors.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_admins/presentation/main_page.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/add_pembimbing/add_pembimbing_bloc.dart';

class CreatePembimbingPages extends StatefulWidget {
  const CreatePembimbingPages({super.key});

  @override
  State<CreatePembimbingPages> createState() => _CreatePembimbingPagesState();
}

class _CreatePembimbingPagesState extends State<CreatePembimbingPages> {
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pembimbing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            const SpaceHeight(16.0),
            CustomTextField(
              controller: emailController,
              label: 'Email Pembimbing',
            ),
            const SpaceHeight(16.0),
            CustomTextField(
              controller: phoneController,
              label: 'Nomor Telepon',
            ),
            const SpaceHeight(16.0),
            CustomTextField(
              controller: nameController,
              label: 'Nama Pembimbing',
            ),
            const SpaceHeight(16.0),
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
            const SpaceHeight(32.0),
            BlocConsumer<AddPembimbingBloc, AddPembimbingState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                      ),
                    );
                  },
                  success: () {
                    emailController.clear();
                    phoneController.clear();
                    nameController.clear();
                    passwordController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pembimbing berhasil ditambahkan'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                    context.pushReplacement(const MainPage());
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                        onPressed: () {
                          context.read<AddPembimbingBloc>().add(
                                AddPembimbingEvent.addPembimbing(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                ),
                              );
                        },
                        label: 'Tambah Pembimbing');
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
