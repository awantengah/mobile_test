import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class NetworkImageComponent extends StatelessWidget {
  final String image;
  final double width;
  final double height;

  const NetworkImageComponent({
    Key? key,
    required this.image,
    this.width = 300,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyShimmerImage(
      imageUrl: image,
      width: width,
      height: height,
      boxFit: BoxFit.cover,
      errorWidget: Image.network('https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
    );
  }
}
