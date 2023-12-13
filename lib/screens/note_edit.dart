import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_dicoding/screens/home_screen.dart';
import 'package:notes_dicoding/style/appstyle.dart';

class NoteEditScreen extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  NoteEditScreen(this.doc);

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.doc['note_title'];
    _mainController.text = widget.doc['note_content'];
  }

  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        title: const Text('Edit Catatan'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                final documentReference = FirebaseFirestore.instance
                    .collection("notes")
                    .doc(widget.doc.id);

                await documentReference.update({
                  'note_title': _titleController.text,
                  'note_content': _mainController.text,
                });

                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())));
              },
              icon: const Icon(
                Icons.save_rounded,
                size: 36,
                color: Colors.white,
              ),
            ),
          )
        ],
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
    );
  }

  @override
  dispose() {
    _titleController.dispose();
    _mainController.dispose();
    super.dispose();
  }
}
