import 'package:flutter/material.dart';
import 'package:our_library/views/account_settings_page.dart';
import 'package:our_library/widgets/user_s_books_page.dart';
import '../widgets/add_book_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    UsersBookPage(),
    AddBookPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.apps_outlined),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ProfileSettings()));
                },
                icon: Icon((Icons.account_box)))
          ],
          title: _selectedIndex == 0
              ? Text(
                  'Kitaplarım',
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  'Yeni Kitap Ekle',
                  style: TextStyle(color: Colors.white),
                ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmarks),
              label: 'Kitaplarım',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add),
              label: 'Yeni Kitap Ekle',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
