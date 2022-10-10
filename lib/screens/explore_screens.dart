import 'package:flutter/material.dart';
import 'package:image/model/topic_model.dart';
import 'package:image/provider/get_image.dart';
import 'package:image/widgets/topics_gridview.dart';
import 'package:shimmer/shimmer.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final List<TopicsModel> topics = [];
  final GetImages image = GetImages();

  @override
  void initState() {
    super.initState();
    getTopics();
  }

  void getTopics() async {
    List<TopicsModel> topic = await image.getTopicsList();
    setState(() {
      for (var element in topic) {
        topics.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
              constraints: const BoxConstraints.expand(height: 130),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage("assets/images/explore.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.pink,
                  child: const Text(
                    "Chủ Đề",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            TopicsView(topics: topics)
          ],
        ),
      ),
    );
  }
}
