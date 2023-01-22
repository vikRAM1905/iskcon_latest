import 'package:flutter/material.dart';

import 'custColors.dart';

Widget loadingOverlay() {
  return Container(
    child: Stack(
      children: [
        const Opacity(
          opacity: 0.1,
          child: ModalBarrier(dismissible: false, color: Colors.white),
        ),
        Center(
            child: Container(
          height: 56,
          width: 56,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        )),
        const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ],
    ),
  );
}
