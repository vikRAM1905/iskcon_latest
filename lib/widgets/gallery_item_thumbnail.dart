import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galleryimage/gallery_item_model.dart';

import '../Utils/custColors.dart';

// to show image in Row
class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key? key, required this.galleryItem, this.onTap})
      : super(key: key);

  final GalleryItemModel galleryItem;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: galleryItem.id,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: galleryItem.imageUrl,
          height: 100.0,
          placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
