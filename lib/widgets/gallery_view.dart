library galleryimage;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/widgets/photo_view_in_gallery.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/gallery_item_model.dart';
import 'package:galleryimage/util.dart';

import 'gallery_item_thumbnail.dart';

class GalleryImage extends StatefulWidget {
  final List<String> imageUrls;
  final String? titleGallery;
  final int numOfShowImages;

  const GalleryImage(
      {Key? key,
      required this.imageUrls,
      this.titleGallery,
      this.numOfShowImages = 3})
      : assert(numOfShowImages <= imageUrls.length),
        super(key: key);
  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  List<GalleryItemModel> galleryItems = <GalleryItemModel>[];
  @override
  void initState() {
    buildItemsList(widget.imageUrls);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: galleryItems.isEmpty
          ? getEmptyWidget()
          : GridView.builder(
              primary: false,
              itemCount: galleryItems.length,
              padding: const EdgeInsets.all(0),
              semanticChildCount: 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 10),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // if have less than 4 image w build GalleryItemThumbnail
                  // if have mor than 4 build image number 3 with number for other images
                  child: GalleryItemThumbnail(
                    galleryItem: galleryItems[index],
                    onTap: () {
                      openImageFullScreen(index);
                    },
                  ),
                );
              },
            ),
    );
  }

// to open gallery image in full screen
  void openImageFullScreen(final int indexOfImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryImageViewWrapper(
          titleGallery: widget.titleGallery,
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          initialIndex: indexOfImage,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

// clear and build list
  buildItemsList(List<String> items) {
    galleryItems.clear();
    for (var item in items) {
      galleryItems.add(
        GalleryItemModel(id: item, imageUrl: item),
      );
    }
  }
}
