// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shri_ram_mandir/features/home/screens/home_screen.dart';
import 'package:shri_ram_mandir/features/maps/screens/map_screen.dart';
import 'package:shri_ram_mandir/features/music/screens/music_player.dart';
// import 'package:hair_salon/features/schedule/screens/schedule_screen.dart';

class BottomBar extends StatefulWidget {
  final pageIndex;
  BottomBar({
    Key? key,
   this.pageIndex = 0,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _page = 0;
  double bottomBarWidth = 35;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const MusicPlayer(),
    const MapScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    updatePage(widget.pageIndex);
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) {
          return pages[_page];
        }
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return BottomNavigationBar(
            currentIndex: _page,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            iconSize: 23,
            onTap: updatePage,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: _page == 0
                            ? Color.fromARGB(255, 255, 103, 31)
                            : Colors.black,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(Icons.home_outlined),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: _page == 1
                            ? Color.fromARGB(255, 255, 103, 31)
                            : Colors.black,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(Icons.play_arrow_outlined),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: _page == 2
                            ? Color.fromARGB(255, 255, 103, 31)
                            : Colors.black,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(Icons.location_on_outlined),
                ),
                label: '',
              ),
            ],
          );
        }
      ),
    );
  }
}