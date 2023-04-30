import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildOnboard extends StatelessWidget {
  final String imgPath;
  final String title;
  final String subTitle;

  const BuildOnboard({
    super.key,
    required this.imgPath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imgPath,
            width: w,
            height: h * 0.45,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: h * 0.04,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: GoogleFonts.alata(
            fontSize: w * 0.1,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            subTitle,
            style: GoogleFonts.acme(
              color: Colors.grey[400],
              fontSize: w * 0.037,
            ),
          ),
        ),
      ],
    );
  }
}
