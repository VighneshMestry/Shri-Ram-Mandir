import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shri_ram_mandir/common/carousel.dart';
import 'package:shri_ram_mandir/models/event_model.dart';

class TimelineCard extends ConsumerWidget {
  final Event event;
  const TimelineCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: event.id,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          child: SizedBox(
            // height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 103, 31),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CarouselImages(carouselImages: event.imageUrls),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Text(
                        event.description,
                        style: const TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold,),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
