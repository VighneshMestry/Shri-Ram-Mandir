import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shri_ram_mandir/common/timeline_card.dart';
import 'package:shri_ram_mandir/models/event_model.dart';
import 'package:shri_ram_mandir/routes/hero_dialog_route.dart';
import 'package:timeline_tile/timeline_tile.dart';

// ignore: must_be_immutable
class MyTimelineTile extends ConsumerWidget {
  final bool isFirst;
  final bool isLast;
  final Event event;
  double height = 100;
  MyTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.height,
    required this.event
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: const LineStyle(color: Colors.orange),
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: Colors.orange,
          iconStyle: IconStyle(iconData: Icons.circle, color: Colors.white, fontSize: 16),
        ),
        endChild: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(10)),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  HeroDialogRoute(
                    builder: (context) => Center(
                      child: TimelineCard(event: event),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: event.id,
                child: Text(
                  event.title,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
