import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shri_ram_mandir/features/admin/repository/admin_repository.dart';
import 'package:shri_ram_mandir/models/event_model.dart';
import 'package:shri_ram_mandir/utils/utils.dart';

class EventUploadScreen extends ConsumerStatefulWidget {
  const EventUploadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventUploadScreenState();
}

class _EventUploadScreenState extends ConsumerState<EventUploadScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  List<File> images = [];
  List<String> imageUrls = [];

  void selectBannerImage() async {
    var res = await pickImages();

    setState(() {
      images = res;
    });
  }
  void uploadImagesToStorage() async {
    imageUrls =
        await ref.read(adminRepositoryProvider.notifier).storeImagetoStorage(
              yearController.text.trim(),
              images,
            );

    print(imageUrls);
    print("!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  }

  void uploadEvent(Event event) async {
    await ref.read(adminRepositoryProvider.notifier).uploadEvent(event, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Event to Timeline"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter the Hero id: "),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Hero id',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(height: 20),
            const Text("Enter the title: "),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter title',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(height: 20),
            const Text("Enter the description: "),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter description',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(height: 20),
            const Text("Enter the year: "),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter year',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: selectBannerImage,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (e) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectBannerImage,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open_outlined,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Select Event Images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  print("BUTTON PRESSED");
                  uploadImagesToStorage();
                  print("FUNCTION EXECUTED");
                  Event event = Event(
                    id: idController.text.trim(),
                    title: titleController.text.trim(),
                    imageUrls: imageUrls,
                    description: descriptionController.text.trim(),
                    year: int.parse(yearController.text.trim()),
                  );
                  print(imageUrls);
                  print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{object}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                  uploadEvent(event);
                },
                child: Text("Upload"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
