// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/model/image_model.dart';
import 'package:image/provider/notification_api.dart';
import 'package:image/utils/bottom_sheet.dart';
import 'package:image/utils/pref_manager.dart';
import 'package:image/widgets/like_animations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageDetails extends StatefulWidget {
  const ImageDetails({
    Key? key,
    required this.images,
    required this.description,
    required this.likes,
    required this.imageProfile,
    required this.location,
    required this.height,
    required this.width,
    required this.name,
  }) : super(key: key);
  final ImageModel images;
  final String description;
  final int likes;
  final int width;
  final int height;
  final String imageProfile;
  final String name;
  final String location;
  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  bool isLiked = false;
  bool isLikeAnimating = false;
  double angle = 0.0;

  PrefManager prefs = PrefManager();

  check() async {
    bool checkLike = await prefs.isFavorite(widget.images.urls.regular);
    setState(() {
      isLiked = checkLike;
      isLikeAnimating = true;
    });
  }

  void dowloadImage() async {
    String url = widget.images.urls.full!;
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/myfile.jpg';
    await Dio().download(url, path);

    await GallerySaver.saveImage(path);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Tải ảnh thành công",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        shape: const StadiumBorder(),
        backgroundColor: Colors.blue[200],
      ),
    );
    NotificationApi.showNotification(
      title: "Thông báo",
      body: "Tải ảnh thành công",
    );
  }

  @override
// tải ảnh
  void initState() {
    // FlutterDownloader.registerCallback(DowloadCallback.callback);
    NotificationApi.init();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: widget.images.id,
        child: GestureDetector(
          onDoubleTap: () {
            prefs.toggleFavorite(widget.images.urls.regular!);
            check();
          },
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                child: InteractiveViewer(
                    onInteractionUpdate: (ScaleUpdateDetails details) {
                      setState(() {
                        angle = details.rotation;
                      });
                    },
                    onInteractionEnd: (ScaleEndDetails details) {
                      setState(() {
                        angle = 0.0;
                      });
                    },
                    child: Transform.rotate(
                      angle: angle,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.images.urls.regular!,
                        fit: BoxFit.contain,
                      ),
                    )),
              ),
              AnimatedOpacity(
                opacity: isLikeAnimating ? 1 : 0,
                duration: const Duration(microseconds: 200),
                child: Align(
                  alignment: Alignment.center,
                  child: LikeAnimation(
                    child: isLiked
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 200,
                          )
                        : Container(),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 600),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ),
              SafeArea(
                child: SizedBox(
                  height: 56,
                  width: 56,
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      tooltip: "Trở về",
                      iconSize: 30,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 220,
                    child: Material(
                      color: Colors.transparent,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () async {
                              dowloadImage();
                            },
                            icon: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            tooltip: "Tải ảnh xuống",
                          ),
                          IconButton(
                            onPressed: () {
                              setWallpaperDiaLog();
                            },
                            icon: const Icon(
                              Icons.wallpaper,
                              color: Colors.white,
                            ),
                            tooltip: "Cài làm ảnh nền",
                          ),
                          IconButton(
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return BottomSheetCustom(
                                  description: widget.description,
                                  imageProfile: widget.imageProfile,
                                  like: widget.likes,
                                  location: widget.location,
                                  name: widget.name,
                                  height: widget.height,
                                  width: widget.width,
                                );
                              },
                            ),
                            icon: const Icon(
                              Icons.person_outline_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            tooltip: "Chi Tiết",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setWallpaperDiaLog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Đặt ảnh nền ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Màn hình chính",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    // String url = widget.images.urls.full!;
                    // int location = WallpaperManager
                    //     .HOME_SCREEN;

                    // var file = await DefaultCacheManager().getSingleFile(url);
                    // final String result =
                    //     await WallpaperManager.setWallpaperFromFile(
                    //         file.path, location);
                    // print("Đặt hình nền");

                    // đặt ảnh nềng
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Đặt ảnh nền thành công"),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    "Màn hình khóa",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  leading: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  onTap: () {
                    // đặt ảnh nềng
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Đặt ảnh nền thành công")));
                  },
                ),
                ListTile(
                  title: const Text(
                    "Cả 2 màn hình",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  leading: const Icon(
                    Icons.phone_android,
                    color: Colors.black,
                  ),
                  onTap: () {
                    // đặt ảnh nềng

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Đặt ảnh nền thành công")));
                  },
                ),
              ],
            ),
          );
        });
  }
}
