import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/constants/colors.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Project'),
      ),
      body: const SingleChildScrollView(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
