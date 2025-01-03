import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/extensions/extensions.dart';

class DetailPembimbingDialog extends StatefulWidget {
  final String namaPembimbing;
  final String emailPembimbing;
  final String nomorHpPembimbing;
  const DetailPembimbingDialog({
    super.key,
    required this.namaPembimbing,
    required this.emailPembimbing,
    required this.nomorHpPembimbing,
  });

  @override
  State<DetailPembimbingDialog> createState() => _DetailPembimbingDialogState();
}

class _DetailPembimbingDialogState extends State<DetailPembimbingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Detail Pembimbing',
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
            subtitle: Text(widget.namaPembimbing),
          ),
          ListTile(
            title: const Text('Email Pembimbing'),
            subtitle: Text(widget.emailPembimbing),
          ),
          ListTile(
            title: const Text('No. Telepon Pembimbing'),
            subtitle: Text(widget.nomorHpPembimbing),
          ),
        ],
      ),
    );
  }
}
