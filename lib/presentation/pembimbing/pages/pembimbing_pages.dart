import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/core.dart';

class PembimbingPages extends StatefulWidget {
  const PembimbingPages({super.key});

  @override
  State<PembimbingPages> createState() => _PembimbingPagesState();
}

class _PembimbingPagesState extends State<PembimbingPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pembimbing'),
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
