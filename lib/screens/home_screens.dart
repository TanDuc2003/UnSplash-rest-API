import 'package:flutter/material.dart';
import 'package:image/model/image_model.dart';
import 'package:image/provider/get_image.dart';
import 'package:image/utils/search_bar.dart';
import 'package:image/widgets/photo_gridview.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool checkScroll = false;
  TextEditingController query = TextEditingController();
  List<ImageModel> myImage = [];
  //cho hàm lấy ảnh ngẫu nhiên chạy đầu tiên khi khởi tạo app

  @override
  void initState() {
    super.initState();
    getAwesomeStart();
    getMyImage();
    scrolls.addListener(
      () {
        if (scrolls.position.pixels == scrolls.position.maxScrollExtent) {
          getMyImage();
        }
        setState(() {
          if (scrolls.position.pixels <= 0) {
            checkScroll = false;
          } else {
            checkScroll = true;
          }
        });
      },
    );
  }

  void getAwesomeStart() async {
    List<ImageModel> images =
        await image.getCollectionsImages('2423569', 1, 20);
    setState(() {
      for (var image in images) {
        myImage.add(image);
      }
    });
  }

  // lấy ảnh
  void getMyImage() async {
    List<ImageModel> images = await image.getRandomImage();
    setState(() {
      for (var image in images) {
        myImage.add(image);
      }
    });
  }

  void scrollUp() {
    checkScroll = false;
    final double start = 0;
    scrolls.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  void scrollDow() {
    final double end = scrolls.position.maxScrollExtent;
    scrolls.animateTo(end,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    super.dispose();
    scrolls.dispose();
  }

  //khai báo
  final GetImages image = GetImages();
  ScrollController scrolls = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        title: Row(
          children: [
            Shimmer.fromColors(
              child: Text(
                "UnSplash",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              baseColor: Colors.orange,
              highlightColor: Colors.black,
            ),
            Shimmer.fromColors(
                child: Text(
                  " Wallpaper",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                direction: ShimmerDirection.rtl,
                baseColor: Colors.orange,
                highlightColor: Colors.teal)
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchBar());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.blueGrey,
                size: 35,
              ),
              color: Colors.black,
            ),
          )
        ],
      ),
      body: PhotosView(
        images: myImage,
        scrollController: scrolls,
        isNormalGrid: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Shimmer.fromColors(
            child: Icon(
              checkScroll ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.yellow,
              size: 40,
            ),
            baseColor: Colors.white,
            highlightColor: Colors.pink),
        splashColor: Colors.purple,
        elevation: 0,
        backgroundColor: checkScroll
            ? Colors.black.withOpacity(0.8)
            : Colors.black.withOpacity(0.2),
        onPressed: checkScroll ? scrollUp : scrollDow,
      ),
    );
  }
}
