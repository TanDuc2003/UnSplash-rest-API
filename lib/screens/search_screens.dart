import 'package:flutter/material.dart';
import 'package:image/model/image_model.dart';
import 'package:image/provider/get_image.dart';
import 'package:image/widgets/photo_gridview.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.query}) : super(key: key);

  final String query;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  GetImages image = GetImages();
  ScrollController scrolls = ScrollController();

  @override
  void initState() {
    getImages(widget.query);
    scrolls.addListener(() {
      if (scrolls.position.pixels == scrolls.position.maxScrollExtent) {
        getImages(widget.query);
      }
    });
    super.initState();
  }

  List<ImageModel> myImage = [];
  getImages(query) async {
    List<ImageModel> images = await image.searchImage(query: query);
    setState(() {
      for (var element in images) {
        myImage.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PhotosView(
      images: myImage,
      scrollController: scrolls,
    );
  }
}
