import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_dicoding/style/appstyle.dart';
import 'package:intl/intl.dart';

class NoteAddScreen extends StatefulWidget {
  const NoteAddScreen({super.key});

  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  // String date = DateTime.now().toString();
  String date = DateFormat('dd MMM yyyy HH:mm').format(DateTime.now());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        title: const Text('Tambahkan Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Apa judulnya?',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'inter'),
            ),
            const SizedBox(height: 8),
            Text(date, style: AppStyle.dateTitle),
            const SizedBox(height: 32),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null, // untuk mengizinkan mulitilines input
              decoration: InputDecoration(
                hintText: 'Mau nyatet apa?',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'inter',
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_titleController.text.isNotEmpty &&
              _mainController.text.isNotEmpty) {
            // Validasi berhasil, inputan tidak kosong
            final documentReference =
                await FirebaseFirestore.instance.collection("notes").add({
              "note_title": _titleController.text,
              "creation_date": date,
              "note_content": _mainController.text,
              "color_id": color_id
            });
            print(documentReference.id);
            Navigator.pop(context);
          } else {
            // Validasi gagal, salah satu atau kedua inputan kosong
            // Tampilkan pesan kesalahan atau tindakan lain sesuai kebutuhan.
            // Misalnya, tampilkan snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Catatan tidak boleh kosong"),
              ),
            );
          }
        },
        elevation: 8,
        tooltip: 'Simpan Catatan',
        backgroundColor: Colors.blueAccent,
        hoverColor: Colors.blueAccent.shade100,
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  dispose() {
    _titleController.dispose();
    _mainController.dispose();
    super.dispose();
  }
}
