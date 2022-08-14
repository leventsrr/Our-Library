import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:our_library/Firebase/storage.dart';
import 'package:our_library/views/profile_page.dart';
import 'package:our_library/views/sign_in_page.dart';
import 'package:our_library/widgets/book_card_main_page.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _allBooks =
        Provider.of<Storage>(context, listen: false).getAllBooks();
    return Scaffold(

        appBar: AppBar(
          title: Text("Neler Okundu", style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<Auth>(context, listen: false).signOut();
                  Provider.of<Auth>(context, listen: false)
                      .changeUserInformation(null);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SignInPage()));
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _allBooks,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return const Center(
                  child: Text("Hata"),
                );
              } else {
                if (!asyncSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<DocumentSnapshot> allBooks = asyncSnapshot.data!.docs;
                  return ListView.builder(
                      itemCount: allBooks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          child: BookCardToMainPage(
                            bookName: allBooks[index]["bookName"],
                            aboutBook: allBooks[index]["aboutBook"],
                            rate: allBooks[index]["rate"],
                            authorName: allBooks[index]["authorName"],
                            publisherName: allBooks[index]["publisherName"],
                            width: 1,
                            comments: allBooks[index]["comments"],
                            userUid: allBooks[index]['userUid'],
                            bookId: allBooks[index].id,
                          ),
                        );
                      });
                }
              }
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.account_box,
            color: Colors.white,
          ),
          onPressed: (() {
            Navigator.push(context,
                (MaterialPageRoute(builder: (builder) => const ProfilePage())));
          }),
        ));
  }
}
