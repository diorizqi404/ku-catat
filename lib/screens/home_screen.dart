import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_dicoding/screens/card.dart';
import 'package:notes_dicoding/screens/note_read.dart';
import 'package:notes_dicoding/screens/note_add.dart';
import 'package:notes_dicoding/style/appstyle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrainst) {
          if (constrainst.maxWidth >= 1000) {
            return NoteList(
              gridCount: 4,
              gridRatio: 1.0,
            );
          } else if (constrainst.maxWidth > 600) {
            return NoteList(gridCount: 2, gridRatio: 1.0);
          } else {
            return NoteListMobile();
          }
        },
      ),
    );
  }
}

class NoteListMobile extends StatelessWidget {
  const NoteListMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "KuCatat 📑",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'inter',
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("notes")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2.0,
                        ),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NoteReadScreen(note)));
                                }, note))
                            .toList(),
                      );
                    }
                    return const Text(
                      "theres no notes",
                      style: TextStyle(color: Colors.black),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteAddScreen()));
        },
        elevation: 8,
        backgroundColor: Colors.greenAccent.shade400,
        hoverColor: Colors.green.shade200,
        tooltip: 'Tambahkan Catatan Baru',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteList extends StatelessWidget {
  final int gridCount;
  final double gridRatio;
  const NoteList({super.key, required this.gridCount, required this.gridRatio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "KuCatat 📑",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'inter',
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("notes")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCount,
                          childAspectRatio: gridRatio,
                        ),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NoteReadScreen(note)));
                                }, note))
                            .toList(),
                      );
                    }
                    return const Text(
                      "Catatan Kosong",
                      style: TextStyle(color: Colors.black),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteAddScreen()));
        },
        elevation: 8,
        backgroundColor: Colors.greenAccent.shade400,
        hoverColor: Colors.green.shade200,
        tooltip: 'Tambahkan Catatan Baru',
        child: const Icon(Icons.add),
      ),
    );
  }
}