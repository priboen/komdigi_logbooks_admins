import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/extensions/build_context_ext.dart';

class DetailProjectDialog extends StatefulWidget {
  final String namaProject;
  final String fiturProject;
  const DetailProjectDialog(
      {super.key, required this.namaProject, required this.fiturProject});

  @override
  State<DetailProjectDialog> createState() => _DetailProjectDialogState();
}

class _DetailProjectDialogState extends State<DetailProjectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Detail Project',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.cancel,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Nama Pembimbing'),
            subtitle: Text(widget.namaProject),
          ),
          ListTile(
            title: const Text('Fitur yang dibutuhkan'),
            subtitle: Text(widget.fiturProject),
          ),
        ],
      ),
    );
  }
}
