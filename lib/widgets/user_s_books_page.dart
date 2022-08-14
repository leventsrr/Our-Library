import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:our_library/Firebase/storage.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';
import 'book_card_profile_page.dart';

class UsersBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userUid = Provider.of<Auth>(context, listen: false).reachToUserUid();
    final _onlyUserBooks =
        Provider.of<Storage>(context, listen: false).getOnlyUserBooks(userUid);

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _onlyUserBooks,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Center(
                child: Text("hata"),
              );
            } else {
              if (!asyncSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<DocumentSnapshot> onlyUserBooks = asyncSnapshot.data!.docs;
                return onlyUserBooks.length == 0
                    ? Center(child: Text("Henüz Bir Kitabın Yok"))
                    : GridView.count(
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.4),
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        children: List.generate(onlyUserBooks.length, (index) {
                          return BookCardToProfilePage(
                            bookName: onlyUserBooks[index]["bookName"],
                            aboutBook: onlyUserBooks[index]["aboutBook"],
                            rate: onlyUserBooks[index]["rate"],
                            authorName: onlyUserBooks[index]["authorName"],
                            publisherName: onlyUserBooks[index]
                                ["publisherName"],
                            width: 3,
                            comments: onlyUserBooks[index]["comments"],
                            userUid: onlyUserBooks[index]['userUid'],
                            bookId: onlyUserBooks[index].id,
                          );
                        }),
                      );
              }
            }
          }),
    );
  }
}
