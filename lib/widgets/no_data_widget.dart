import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  String text = '';

  NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_item.png',
            height: 250,
            width: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: GoogleFonts.robotoSlab(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
