import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/// all [Global] size texts with fonts
/// linkifyText Widget

Text capText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
                color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: fontSize,
                height: lineHeight,
                decoration: decoration),
      ),
    );
Text bodyMedText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
                color: color,
                fontSize: fontSize,
                height: lineHeight,
                decoration: decoration),
      ),
    );
Text bodyLargeText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: fontWeight ?? FontWeight.bold,
                letterSpacing: letterSpacing,
                color: color,
                fontSize: fontSize,
                height: lineHeight,
                decoration: decoration),
      ),
    );
Text titleLargeText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize = 18,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: fontWeight ?? FontWeight.bold,
                letterSpacing: letterSpacing,
                color: color,
                fontSize: fontSize,
                height: lineHeight,
                // fontFamily: 'Sansita',
                decoration: decoration),
      ),
    );

class ShadowText extends StatelessWidget {
  const ShadowText({super.key, required this.data, this.shadowData, this.style});

  final Widget data;
  final Widget? shadowData;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // new Positioned(
          //   top: 1.0,
          //   left: 1.0,
          //   bottom: 1,
          //   child: data,
          // ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: data,
          ),
          // new BackdropFilter(
          //   filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          //   child: data,
          // ),
        ],
      ),
    );
  }
}

linkifyText(String text,
        [double fs = 11.0,
        TextStyle style = const TextStyle(color: Colors.grey),
        TextStyle linkStyle = const TextStyle(color: Colors.blue)]) =>
    Linkify(
      onOpen: (link) async {
        if (!await launchUrl(Uri.parse(link.url),
            mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch ${link.url}');
        }
      },
      text: text,
      style: style.copyWith(fontSize: fs),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      linkStyle: linkStyle.copyWith(fontSize: fs),
    );
