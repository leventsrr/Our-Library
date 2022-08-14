import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../views/book_detail_page.dart';

class BookCardToMainPage extends StatelessWidget {
  String bookName;
  String aboutBook;
  String rate;
  String authorName;
  String publisherName;
  int width;
  List comments;
  String bookId;
  var userUid;
  BookCardToMainPage(
      {Key? key,
      required this.bookName,
      required this.aboutBook,
      required this.rate,
      required this.authorName,
      required this.publisherName,
      required this.width,
      required this.comments,
      required this.userUid,
      required this.bookId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => BookDetail(
              bookName: bookName,
              aboutBook: aboutBook,
              rate: rate,
              authorName: authorName,
              publisher: publisherName,
              comments: comments,
              bookId: bookId,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Color.fromARGB(255, 139, 139, 139), blurRadius: 20.0)
        ]),
        width: MediaQuery.of(context).size.width / width,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    bookName,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.courgette(
                        textStyle: TextStyle(fontSize: 25)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        authorName,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.courgette(),
                      ),
                      Text(
                        publisherName,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.courgette(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_border,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(rate, style: GoogleFonts.lobster(fontSize: 19)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
