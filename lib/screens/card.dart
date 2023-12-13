import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_dicoding/style/appstyle.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(doc["note_title"], style: AppStyle.mainTitle),
          doc["note_content"].length > 50
              ? Text(
                  doc["note_content"].substring(0, 40),
                  style: AppStyle.mainContent,
                )
              : Text(doc["note_content"], style: AppStyle.mainContent),
          const SizedBox(height: 8),
          Text(doc["creation_date"], style: AppStyle.dateTitle),
        ],
      ),
    ),
  );
}
