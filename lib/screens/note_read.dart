import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_dicoding/screens/home_screen.dart';
import 'package:notes_dicoding/screens/note_edit.dart';
import 'package:notes_dicoding/style/appstyle.dart';

class NoteReadScreen extends StatelessWidget {
  QueryDocumentSnapshot doc;

  NoteReadScreen(this.doc, {super.key});

  @override
  Widget build(BuildContext context) {
    int colorId = doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => NoteEditScreen(doc))));
              },
              icon: const Icon(
                Icons.edit_note_rounded,
                color: Colors.white,
                size: 48.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 6),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Peringatan !!', 
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 205, 21),
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        )
                      ),
                      content: const Text("Apakah kamu yakin akan menghapus? Catatan yang sudah terhapus tak dapat dipulihkan."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Batal',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20
                              )
                            )
                          ), 
                          TextButton(
                            onPressed: () async {
                              final documentReference =
                              FirebaseFirestore.instance.collection("notes").doc(doc.id);
          
                              await documentReference.delete();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                            },
                            child: const Text('Hapus',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20
                              ),
                            ),
                          ),
                        ],
                    );
                  }
                ); // showDialog
              }, // onPressed
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                  size: 36.0,
                ),
              ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doc["note_title"],
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'inter')),
                    const SizedBox(height: 6),
                    Text(doc["creation_date"], style: AppStyle.dateTitle),
                    const SizedBox(height: 24),
                    Text(
                      doc["note_content"],
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontFamily: 'inter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}