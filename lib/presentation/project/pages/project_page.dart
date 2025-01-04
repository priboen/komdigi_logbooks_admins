import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/constants/colors.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_admins/presentation/main_page.dart';
import 'package:komdigi_logbooks_admins/presentation/project/bloc/delete_project/delete_project_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/project/bloc/get_project/get_project_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/project/dialog/detail_project_dialog.dart';
import 'package:komdigi_logbooks_admins/presentation/project/pages/create_project_page.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  void initState() {
    context.read<GetProjectBloc>().add(const GetProjectEvent.getProject());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Project'),
      ),
      body: BlocBuilder<GetProjectBloc, GetProjectState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (project) {
              if (project.isEmpty) {
                return const Center(
                  child: Text('Data Project Kosong'),
                );
              }
              return ListView.builder(
                itemCount: project.length,
                itemBuilder: (context, index) {
                  final projectData = project[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => DetailProjectDialog(
                              namaProject: projectData.name!,
                              fiturProject: projectData.features!,
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(projectData.name!),
                            subtitle: Text(projectData.features!),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Hapus Project'),
                                        content: const Text(
                                            'Apakah anda yakin ingin menghapus project ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<DeleteProjectBloc>()
                                                  .add(DeleteProjectEvent
                                                      .deleteProject(
                                                          projectData.id!));
                                              context.pushReplacement(
                                                  const MainPage());
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Project berhasil dihapus'),
                                                  backgroundColor:
                                                      AppColors.primary,
                                                ),
                                              );
                                            },
                                            child: const Text('Ya'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: const Text('Tidak'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (message) => Center(
              child: Text(message),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_project',
        shape: const CircleBorder(),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        onPressed: () {
          context.push(const CreateProjectPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
