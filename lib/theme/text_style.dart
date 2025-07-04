import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStlye(
    {fontsize, fontweight, color, lineheight, TextDecoration? textDecoration}) {
  return GoogleFonts.poppins(
      fontSize: fontsize,
      fontWeight: fontweight,
      height: lineheight,
      color: color,
      decoration: textDecoration ?? TextDecoration.none);
}

TextStyle titleLarge() {
  return getTextStlye(
      fontsize: 18.0, fontweight: FontWeight.w700, color: Color(0xFF0F172A));
}

TextStyle titleMedium() {
  return getTextStlye(
      fontsize: 16.0, fontweight: FontWeight.w600, color: Color(0xFF64748B));
}

TextStyle titleSmall() {
  return getTextStlye(
      fontsize: 14.0, fontweight: FontWeight.w700, color: Color(0xFF0F172A));
}

TextStyle bodyLarge() {
  return getTextStlye(
      fontsize: 16.0, fontweight: FontWeight.w400, color: Color(0xFF64748B));
}

TextStyle bodyMedium({color}) {
  return getTextStlye(
      fontsize: 14.0,
      fontweight: FontWeight.w400,
      color: color ?? const Color(0xFF475569));
}

TextStyle bodySmall() {
  return getTextStlye(
      fontsize: 11.0, fontweight: FontWeight.w400, color: Color(0xFF64748B));
}
