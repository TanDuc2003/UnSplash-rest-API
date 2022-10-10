import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image/model/image_model.dart';
import 'package:image/widgets/image_details.dart';

import 'package:transparent_image/transparent_image.dart';

class PhotosView extends StatelessWidget {
  PhotosView({
    Key? key,
    required this.images,
    required this.scrollController,
    this.isNormalGrid = false,
    this.onpress = false,
  }) : super(key: key);

  bool onpress;
  final List<ImageModel> images;
  final ScrollController scrollController;

  final bool isNormalGrid;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
        controller: scrollController,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: images.length,
        itemBuilder: (BuildContext context, index) {
          final desciption = images[index].description;
          final des = desciption.toString();
          final likes = images[index].likes;
          final name = images[index].user.username;
          final location = images[index].user.location.toString();
          final width = images[index].width;
          final height = images[index].height;
          final imageProfile = images[index].user.profileImage!.large;
          return GestureDetector(
            onTap: onpress
                ? () {}
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetails(
                            images: images[index],
                            description: des,
                            likes: likes!,
                            imageProfile: imageProfile!,
                            location: location,
                            // Ảnh lỗi 4
                            name: name!,
                            height: height!,
                            width: width!,
                          ),
                        ));
                  },
            child: Hero(
              tag: images[index].id,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: isNormalGrid
                        ? images[index].urls.regular!
                        : images[index].urls.thumb!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          if (isNormalGrid) {
            return const StaggeredTile.count(1, 1.8);
          } else {
            return StaggeredTile.count(1, index.isEven ? 1.0 : 1.8);
          }
        });
  }
}
