import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void loading(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext loading) {
        return Container(
          decoration: BoxDecoration(color: Color(0xFFF0F5F9)),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  'Loading...',
                  style: GoogleFonts.kodchasan(fontSize: 25),
                ),
              ),
            ),
            Image.asset(
              'assets/Icons/Imagehourglass.png',
              height: 300,
              width: 300,
            ),
            Center(
                child: Text(
              'Contact Customer Service - 1-800-433-7330',
              style: GoogleFonts.kodchasan(fontSize: 10),
            ))
          ]),
        );
      });
}
