import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/components/buttons.dart';
import 'package:komdigi_logbooks_admins/core/components/custom_text_field.dart';
import 'package:komdigi_logbooks_admins/core/components/spaces.dart';
import 'package:komdigi_logbooks_admins/core/constants/colors.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_admins/presentation/main_page.dart';
import 'package:komdigi_logbooks_admins/presentation/project/bloc/create_project/create_project_bloc.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  late final TextEditingController namaProjectController;
  late final TextEditingController fiturProjectController;

  @override
  void initState() {
    namaProjectController = TextEditingController();
    fiturProjectController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Project'),
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
              controller: namaProjectController,
              label: 'Nama Project',
            ),
            const SpaceHeight(16.0),
            CustomTextField(
              controller: fiturProjectController,
              label: 'Fitur Project',
            ),
            const SpaceHeight(32.0),
            BlocConsumer<CreateProjectBloc, CreateProjectState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  success: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Project berhasil ditambahkan'),
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
                          context.read<CreateProjectBloc>().add(
                                CreateProjectEvent.createProject(
                                  name: namaProjectController.text,
                                  features: fiturProjectController.text,
                                ),
                              );
                        },
                        label: 'Simpan');
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
