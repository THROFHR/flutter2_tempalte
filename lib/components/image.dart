import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/values/values.dart';

/// 缓存图片
Widget netImageCached(
  String url, {
  double? width = 48,
  double? height = 48,
  EdgeInsetsGeometry? margin,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height != null ? height.h : null,
      width: width != null ? width.h : null,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: Radii.k6pxRadius,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        ),
      ),
    ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    },
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}


/// 缓存图片
Widget netImageCachedFill(
    String url, {
      double? width,
      double? height,
      BorderRadiusGeometry? border,
    }) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height != null ? height.h : null,
      width: width != null ? width.h : null,
      decoration: BoxDecoration(
        borderRadius: border,
        // image: DecorationImage(
        //   image: imageProvider,
        //   fit: BoxFit.fitWidth,
        //   // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        // ),
      ),
      child: Image(
        image: imageProvider,
        fit: BoxFit.contain,
      ),
    ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    },
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
