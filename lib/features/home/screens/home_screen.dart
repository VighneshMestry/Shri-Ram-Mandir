import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shri_ram_mandir/common/my_timeline_tile.dart';
import 'package:shri_ram_mandir/constants/constants.dart';
import 'package:shri_ram_mandir/features/admin/repository/admin_repository.dart';
import 'package:shri_ram_mandir/features/home/drawers/admin_drawer.dart';
import 'package:shri_ram_mandir/models/event_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  List<Event> events = [];
  void fetchEvents() async {
    events =
        await ref.watch(adminRepositoryProvider.notifier).fetchEvents().first;
        print(events);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10),
          child: Image.asset(
            "assets/images/ram_mandir.png",
            width: 150,
            fit: BoxFit.fitHeight,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 60,
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () => displayDrawer(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                "assets/images/shri_ram.jpg",
                width: 60,
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/images/shri_ram_right.jpg",
              width: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
                padding: const EdgeInsets.only(left: 0),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: 'Witness the great history of \n',
                      style: TextStyle(color: Colors.black, fontSize: 22)),
                  TextSpan(
                      text: 'Ayodhya\'s Ram Mandir 🙏🏻',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 103, 31),
                          fontSize: 26,
                          fontWeight: FontWeight.w500))
                ]))),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Lists.eventDetails.length,
                  itemBuilder: (context, index) {
                    return MyTimelineTile(event: Lists.eventDetails[index], height: 100, isFirst: index == 0, isLast: index == Lists.eventDetails.length-1,);
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}
