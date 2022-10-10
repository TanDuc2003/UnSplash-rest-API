import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BottomSheetCustom extends StatelessWidget {
  const BottomSheetCustom({
    Key? key,
    required this.description,
    required this.imageProfile,
    required this.like,
    required this.location,
    required this.name,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int like;
  final int width;
  final int height;
  final String description;
  final String imageProfile;
  final String name;
  final String location;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var ui;
    return Container(
      width: size.width,
      height: size.height / 1.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 3,
            child: Container(
              width: size.width,
              height: size.height / 2.1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.4),
                    blurRadius: 60,
                  )
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF964fc9),
                    Color(0xFF7e5a98),
                    Color(0xFF544c5b),
                    Color(0xFF7f6557),
                    Color(0xFFa3521b),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height / 2.1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF010101),
                    Color(0xFF0a0a0c),
                    Color(0xFF18151c),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            top: 14,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.orange),
                borderRadius: BorderRadius.circular(56),
              ),
              child: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(imageProfile),
              ),
            ),
          ),
          Positioned(
            top: size.height / 5.8,
            child: Text(
              "THÔNG TIN",
              style: GoogleFonts.permanentMarker(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            top: size.height / 4.7,
            child: Text.rich(
              TextSpan(
                text: "Name: ",
                style: GoogleFonts.patrickHand(
                  color: Colors.white,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: name,
                    style: GoogleFonts.patrickHand(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height / 4,
            child: Container(
              width: size.width / 1.2,
              height: size.height / 15,
              child: Text(
                description,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.patrickHand(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Positioned(
            bottom: size.height / 7.2,
            child: Container(
              width: size.width / 1.1,
              height: size.height / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomSheet(
                    size: size,
                    subtitle: "Like",
                    title: like.toString(),
                  ),
                  BottomSheet(
                    size: size,
                    subtitle: "Địa điểm",
                    title: location,
                  ),
                  Container(
                    width: size.width / 5,
                    height: size.height / 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Kích thước",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        FittedBox(
                          child: Text(
                            height.toString() + "*" + width.toString(),
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              minWidth: size.width / 1.4,
              height: size.height / 16,
              color: Colors.grey,
              splashColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Text(
                      "BACK",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.blue[700]!,
                      ),
                    ),
                    Text(
                      "BACK",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key? key,
    required this.size,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 5,
      height: size.height / 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
