import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galleryimage/gallery_item_model.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// to view image in full screen
class GalleryImageViewWrapper extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final int? initialIndex;
  final PageController pageController;
  final List<GalleryItemModel> galleryItems;
  final Axis scrollDirection;
  final String? titleGallery;

  GalleryImageViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.titleGallery,
    this.backgroundDecoration,
    this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex ?? 0),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryImageViewWrapperState();
  }
}

class _GalleryImageViewWrapperState extends State<GalleryImageViewWrapper> {
  final minScale = PhotoViewComputedScale.contained * 0.8;
  final maxScale = PhotoViewComputedScale.covered * 8;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.titleGallery ?? "Gallery"),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: widget.backgroundDecoration,
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildImage,
                itemCount: widget.galleryItems.length,
                loadingBuilder: widget.loadingBuilder,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                scrollDirection: widget.scrollDirection,
              ),
            ),
            Positioned(
              left: 5,
              top: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInExpo);
                              });
                            },
                            child: Icon(Icons.arrow_back_ios)),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              });
                            },
                            child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// build image with zooming
  PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
    final GalleryItemModel item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions.customChild(
      child: CachedNetworkImage(
        imageUrl: item.imageUrl,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      initialScale: PhotoViewComputedScale.contained,
      minScale: minScale,
      maxScale: maxScale,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
