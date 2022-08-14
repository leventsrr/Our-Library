import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Storage with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> addBook(
      String bookName,
      String authorName,
      String publisherName,
      String aboutBook,
      String rate,
      String userUid,
      List comments,
      var timeStamp) async {
    final CollectionReference books = _database.collection('books');
    await books.add({
      'bookName': bookName,
      'authorName': authorName,
      'publisherName': publisherName,
      'aboutBook': aboutBook,
      'rate': rate,
      'userUid': userUid,
      'comments': comments,
      'timeStamp': timeStamp,
    });
  }

  getAllBooks() {
    Stream<QuerySnapshot<Map<String, dynamic>>> _allBooks = _database
        .collection('books')
        .orderBy('timeStamp', descending: true)
        .snapshots();
    return _allBooks;
  }

  getOnlyUserBooks(String userUid) {
    Stream<QuerySnapshot<Map<String, dynamic>>> _allUserBooks = _database
        .collection('books')
        .where("userUid", isEqualTo: userUid)
        .orderBy('timeStamp', descending: true)
        .snapshots();
    return _allUserBooks;
  }

  addCommentToBook(String bookid, String newComment, String userUid) {
    var bookRef = _database.collection('books').doc(bookid);
    bookRef.update({
      "comments": FieldValue.arrayUnion([
        {"newComment": newComment, "userUid": userUid}
      ])
    });
  }

  deleteUserBook(String bookId) {
    _database.collection('books').doc(bookId).delete();
  }
}
