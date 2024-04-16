import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sp_social/presentation/home/home_view/desktop_view.dart';

import '../event_store.dart';

class CarouselView extends StatefulWidget {
  final EventStore store;

  const CarouselView({
    required this.store,
    super.key,
  });

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  final _carouselController = CarouselController();
  late final int _speed;

  @override
  void initState() {
    final params = Uri.base.queryParameters;
    _speed = int.tryParse(params['speed'] ?? '') ?? 5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.store.value!.socialQrCodes;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = math.min(screenWidth * 0.4, 500);
    final double maxHeight = math.min(screenHeight * 0.7, maxWidth * 1.2);

    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      child: SizedBox(
        height: maxHeight,
        child: CarouselSlider(
          items: items.map((e) => QRCode(socialQrCode: e, width: maxWidth)).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            clipBehavior: Clip.none,
            autoPlay: true,
            viewportFraction: 1,
            aspectRatio: screenWidth / screenHeight,
            initialPage: 0,
            autoPlayInterval: Duration(seconds: _speed),
          ),
        ),
      ),
    );
  }
}
