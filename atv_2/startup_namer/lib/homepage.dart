import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BandNames extends StatelessWidget {
  const BandNames({Key? key, required this.title}) : super(key: key);

  final String title;
  final docs = DocumentSnapshot;

  Widget _buildListItem(BuildContext context, DocumentSnapshot doc) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child:
                Text(doc['name'], style: Theme.of(context).textTheme.headline5),
          ),
          Container(
            decoration: const BoxDecoration(color: Color(0xffddddff)),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              doc['votos'].toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
          )
        ],
      ),
      onTap: () {
        FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap = await transaction.get(doc.reference);
          await transaction.update(freshSnap.reference, {
            'votes': freshSnap['votes'] + 1,
          });
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('bandnames').snapshots(),
            builder: (context, snapshots) {
              if (!snapshots.hasData) return const Text('Loading...');
              {
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshots.data!.docs[index]),
                );
              }
            }));
  }
}
