import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';

import '../../../../core/widgets/_index.dart';

class AdvertisementCarousel extends StatefulWidget {
  final List<AdItem>items;
  const AdvertisementCarousel({super.key, required this.items});

  @override
  State<AdvertisementCarousel> createState() => _AdvertisementCarouselState();
}

class _AdvertisementCarouselState extends State<AdvertisementCarousel> {
  late final PageController _controller;
  final int _itemCount = 4;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            itemBuilder: (_, index) =>  AdvertisementWidget(ad: widget.items[index],),
          ),
        ),
        0.01.vSpace(),
        CustomPageIndicator(controller: _controller),
      ],
    );
  }
}



