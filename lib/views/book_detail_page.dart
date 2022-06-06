import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_library/Firebase/storage.dart';
import 'package:my_library/widgets/comment_card.dart';
import 'package:my_library/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';

class BookDetail extends StatefulWidget {
  String bookName;
  String aboutBook;
  String rate;
  String publisher;
  String authorName;
  List comments;
  String bookId;
  BookDetail(
      {Key? key,
      required this.bookName,
      required this.aboutBook,
      required this.rate,
      required this.authorName,
      required this.publisher,
      required this.comments,
      required this.bookId})
      : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final List<Widget> _bookComments = [];

  void getBookComments() {
    _bookComments.clear();
    for (int i = 0; i < widget.comments.length; i++) {
      _bookComments.add(CommentCard(
        comments: widget.comments,
        index: i,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    getBookComments();
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < int.parse(widget.rate)) {
        stars.add(Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(
            Icons.star,
            color: Colors.orange,
          ),
        ));
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Book Name: ${widget.bookName}',
                              style: GoogleFonts.courgette(
                                  textStyle: TextStyle(fontSize: 25)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Author: ${widget.authorName}',
                                style: GoogleFonts.courgette(
                                    textStyle: TextStyle(fontSize: 25)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Publisher: ${widget.publisher}',
                                softWrap: true,
                                style: GoogleFonts.courgette(
                                    textStyle: TextStyle(fontSize: 25)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: stars,
                  )
                ],
              ),
            ),
            const Divider(
              height: 5,
              thickness: 3,
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                flex: 2,
                child: Text(
                  widget.aboutBook,
                  style:
                      GoogleFonts.courgette(textStyle: TextStyle(fontSize: 20)),
                )),
            TextButton(
                onPressed: () {
                  TextEditingController _commentController =
                      TextEditingController();
                  showModalBottomSheet<void>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 5,
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              hintText: 'Your Comment',
                              icon: Icon(Icons.send),
                              keyboardType: TextInputType.text,
                              obsecureText: false,
                              controller: _commentController,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  var userUid =
                                      Provider.of<Auth>(context, listen: false)
                                          .reachToUserUid();
                                  Provider.of<Storage>(context, listen: false)
                                      .addCommentToBook(widget.bookId,
                                          _commentController.text, userUid);
                                  setState(() {
                                    _commentController.text = "";
                                  });
                                },
                                child: Text(
                                  'Send',
                                  style: TextStyle(color: Colors.white),
                                )),
                            Expanded(
                              child: ListView(
                                children: _bookComments,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Comments'))
          ],
        ),
      ),
    );
  }
}
