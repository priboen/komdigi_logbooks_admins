import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_admins/core/core.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_admins/presentation/main_page.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/delete_pembimbing/delete_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/bloc/get_pembimbing/get_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/dialog/detail_pembimbing_dialog.dart';
import 'package:komdigi_logbooks_admins/presentation/pembimbing/pages/create_pembimbing_pages.dart';

class PembimbingPages extends StatefulWidget {
  const PembimbingPages({super.key});

  @override
  State<PembimbingPages> createState() => _PembimbingPagesState();
}

class _PembimbingPagesState extends State<PembimbingPages> {
  @override
  void initState() {
    context
        .read<GetPembimbingBloc>()
        .add(const GetPembimbingEvent.getPembimbing());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pembimbing'),
      ),
      body: BlocBuilder<GetPembimbingBloc, GetPembimbingState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (pembimbing) {
              if (pembimbing.isEmpty) {
                return const Center(
                  child: Text('Data Pembimbing Kosong'),
                );
              }
              return ListView.builder(
                itemCount: pembimbing.length,
                itemBuilder: (context, index) {
                  final pembimbingData = pembimbing[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => DetailPembimbingDialog(
                              namaPembimbing: pembimbingData.name!,
                              emailPembimbing: pembimbingData.email!,
                              nomorHpPembimbing: pembimbingData.phone!,
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(pembimbingData.name!),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: const Text(
                                          'Apakah anda yakin ingin menghapus data ini?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<DeletePembimbingBloc>()
                                                .add(DeletePembimbingEvent
                                                    .deletePembimbing(
                                                        pembimbingData.id!));
                                            context.pushReplacement(
                                                const MainPage());
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Data berhasil dihapus',
                                                ),
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
                                  },
                                );
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_pembimbing',
        shape: const CircleBorder(),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        onPressed: () {
          context.push(const CreatePembimbingPages());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
