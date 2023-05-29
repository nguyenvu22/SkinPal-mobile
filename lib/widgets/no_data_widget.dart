import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  String text = '';
  late String img;

  NoDataWidget({this.text = '', required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 250,
            width: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: GoogleFonts.robotoSlab(
              // color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
