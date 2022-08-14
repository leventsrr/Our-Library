import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  List comments;
  int index;
  CommentCard({
    Key? key,
    required this.comments,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 3.0, color: Colors.brown)),
      ),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(comments[index]['newComment']),
      )),
    ));
  }
}
