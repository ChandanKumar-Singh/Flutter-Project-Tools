import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:rive/rive.dart';

import 'color.dart';

Widget assetSvg(String path,
        {BoxFit? fit,
        bool fullPath = false,
        Color? color,
        double? width,
        double? height}) =>
    SvgPicture.asset(
      fullPath ? path : 'assets/svg/$path',
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );
Widget assetRive(String path, {BoxFit? fit, bool fullPath = false}) =>
    RiveAnimation.asset(
      fullPath ? path : 'assets/rive/$path',
      fit: fit ?? BoxFit.contain,
    );
Widget assetLottie(String path,
        {BoxFit? fit,
        bool fullPath = false,
        double? width,
        double? height,
        LottieDelegates? delegates}) =>
    Lottie.asset(
      fullPath ? path : 'assets/lottie/$path',
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      delegates: delegates,
    );

Widget assetImages(String path,
        {BoxFit? fit,
        bool fullPath = false,
        Color? color,
        double? width,
        double? height}) =>
    Image.asset(
      fullPath ? path : 'assets/images/$path',
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );

ImageProvider assetImageProvider(String path,
        {BoxFit? fit, bool fullPath = false}) =>
    AssetImage(fullPath ? path : 'assets/images/$path');

ImageProvider netImageProvider(String path,
        {BoxFit? fit, Color? color, double? width, double? height}) =>
    NetworkImage(path);

CachedNetworkImage buildCachedNetworkImage(String image,
    {double? ph,
    double? pw,
    BoxFit? fit,
    bool fullPath = false,
    String? placeholder}) {
  return CachedNetworkImage(
    imageUrl: image,
    fit: fit ?? BoxFit.cover,
    placeholder: (context, url) => Center(
        child: SizedBox(
            height: ph ?? 50,
            width: pw ?? 100,
            child: Center(
                child: CircularProgressIndicator(
                    color: appLogoColor.withOpacity(0.5))))),
    errorWidget: (context, url, error) => Center(
        child: SizedBox(
            height: ph ?? 50,
            width: pw ?? 100,
            child: assetImages(placeholder ?? AssetPNG.appLogo))),
    cacheManager: CacheManager(Config("${AppConst.appName}_$image",
        stalePeriod: const Duration(days: 30))),
  );
}
