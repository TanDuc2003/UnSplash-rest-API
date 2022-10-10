import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  ButtonCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        height: 60,
        width: 200,
        child: Material(
          color: Colors.transparent,
          elevation: 1.0,
          borderRadius: BorderRadius.circular(35),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.wallpaper),
                tooltip: "Tải ảnh",
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.wallpaper),
                tooltip: "Cài làm ảnh nền",
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                tooltip: "Yêu thích",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
