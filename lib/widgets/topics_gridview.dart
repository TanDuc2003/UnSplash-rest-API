import 'package:flutter/material.dart';
import 'package:image/model/image_model.dart';
import 'package:image/model/topic_model.dart';
import 'package:image/provider/get_image.dart';
import 'package:image/widgets/photo_gridview.dart';

class TopicsView extends StatelessWidget {
  const TopicsView({
    Key? key,
    required this.topics,
  }) : super(key: key);

  final List<TopicsModel> topics;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.96,
      minChildSize: 0.65,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black45, blurRadius: 2)
              ],
              color: Theme.of(context).canvasColor),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                controller: scrollController,
                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                children: topics
                    .map((topic) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OnTopicsClick(
                                    slug: topic.slug!,
                                    topicTitle: topic.title!,
                                  ),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      topic.coverPhoto!.urls!.thumb!),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black38),
                                ),
                                Center(
                                  child: Text(
                                    topic.title!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        );
      },
    );
  }
}

class OnTopicsClick extends StatefulWidget {
  const OnTopicsClick({
    Key? key,
    required this.slug,
    required this.topicTitle,
  }) : super(key: key);
  final String slug;
  final String topicTitle;

  @override
  State<OnTopicsClick> createState() => _OnTopicsClickState();
}

class _OnTopicsClickState extends State<OnTopicsClick> {
  final scrolls = ScrollController();
  final List<ImageModel> topicImages = [];
  final GetImages image = GetImages();

  @override
  void initState() {
    super.initState();
    int pageNo = 1;
    getTopicsImages(widget.slug, pageNo);
    scrolls.addListener(() {
      if (scrolls.position.pixels == scrolls.position.maxScrollExtent) {
        pageNo++;
        getTopicsImages(widget.slug, pageNo);
      }
    });
  }

  void getTopicsImages(topic, pageNo) async {
    List<ImageModel> images =
        await image.getTopic(topic: topic, pageNo: pageNo);
    setState(() {
      for (var image in images) {
        topicImages.add(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Text(widget.topicTitle),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.pink],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
      ),
      body: PhotosView(
        images: topicImages,
        scrollController: scrolls,
        isNormalGrid: false,
      ),
    );
  }
}
