import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(double size, Color color, FontWeight weight){

  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: weight);
}

TextStyle appStyleHeight(double size, Color color, FontWeight weight, double ht){

  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: weight, height: ht);
}