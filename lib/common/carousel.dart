import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  final List<String> carouselImages;
  const CarouselImages({super.key, required this.carouselImages});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.carouselImages.map(
            (e) {
              return Builder(
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      e,
                      fit: BoxFit.cover,
                      height: 800,
                      width: 1000,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            viewportFraction: 1,
            height: 220,
          ),
        ),
        DotsIndicator(
          decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.blue,
              activeSize: const Size(20, 9),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          dotsCount: widget.carouselImages.length,
          position: currentIndex,
        ),
      ],
    );
  }
}
