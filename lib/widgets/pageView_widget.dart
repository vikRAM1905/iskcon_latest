import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MultiPageText extends StatefulWidget {
  final List<String> fullText;
  final Size size;
  final EdgeInsets paddingTextBox;
  final bool usePageNavigation;
  final BoxDecoration? decoration;
  const MultiPageText({
    Key? key,
    required this.fullText,
    required this.size,
    required this.font,
    this.paddingTextBox = const EdgeInsets.all(
      10,
    ),
    this.usePageNavigation = true,
    this.decoration,
  }) : super(key: key);
  final double font;

  @override
  State<MultiPageText> createState() => _MultiPageTextState();
}

class _MultiPageTextState extends State<MultiPageText> {
  int _currentPageIndex = 0;
  final double _pageNavigatorHeight = 40;
  final int _upperLayoutRunsLimit = 20;
  late List<String> _pages;
  late Size _availableSize;

  @override
  void initState() {
    _pages = _getPageTexts();
    super.initState();
  }

  List<String> _getPageTexts() {
    List<String> pages = widget.fullText;
    // String remainingText = widget.fullText;
    _availableSize = _calculateAvailableSize(
      size: widget.size,
      padding: widget.paddingTextBox,
      usePageNavigation: widget.usePageNavigation,
    );
    return pages;
  }

  Size _calculateAvailableSize({
    required Size size,
    required EdgeInsets padding,
    required bool usePageNavigation,
  }) {
    double availableHeight = size.height -
        (widget.paddingTextBox.top + widget.paddingTextBox.bottom);
    if (usePageNavigation) {
      availableHeight = availableHeight - _pageNavigatorHeight;
    }
    final double availableWidth =
        size.width - (widget.paddingTextBox.right + widget.paddingTextBox.left);
    return Size(availableWidth, availableHeight);
  }

  double _updateWidthFactor({
    required double widthFactor,
    required int layoutRuns,
    required int upperLayoutRunsLimit,
  }) {
    final double newWidthFactor = layoutRuns >= upperLayoutRunsLimit
        ? widthFactor + 0.05
        : widthFactor - 0.05;
    return newWidthFactor;
  }

  int _estimatePageCharacterLimit({
    required Size size,
    required TextStyle textStyle,
    required double widthFactor,
  }) {
    final characterHeight = textStyle.fontSize!;
    final characterWidth = characterHeight * widthFactor;
    return ((size.height * size.width) / (characterHeight * characterWidth))
        .ceil();
  }

  String _getPageTextEstimate({
    required String text,
    required int pageCharacterLimit,
  }) {
    final initialPageTextEstimate =
        text.substring(0, math.min(pageCharacterLimit + 1, text.length));
    final substringIndex =
        initialPageTextEstimate.lastIndexOf(RegExp(r"\s+\b|\b\s+|[\.?!]"));
    final pageTextEstimate =
        text.substring(0, math.min(substringIndex + 1, text.length));
    return pageTextEstimate;
  }

  PageProperties _getPageText({
    required String text,
    required TextStyle textStyle,
    required Size size,
  }) {
    double paragraphHeight = 10000;
    String currentText = text;
    int layoutRuns = 0;
    final RegExp regExp = RegExp(r"\S+[\W]*$");
    while (paragraphHeight > size.height) {
      final paragraph = ParagraphPainter.layoutParagraph(
          text: currentText, textStyle: textStyle, size: size);
      paragraphHeight = paragraph.height;
      if (paragraphHeight > size.height) {
        currentText = currentText.replaceFirst(regExp, '');
      }
      layoutRuns = layoutRuns + 1;
    }

    return PageProperties(currentText, layoutRuns);
  }

  bool _performRetry(int layoutRuns, int retries) {
    return layoutRuns == 1 && retries <= 0;
  }

  bool _shouldOptimizeEstimates(int layoutRuns) {
    return layoutRuns > _upperLayoutRunsLimit || layoutRuns == 1;
  }

  void _updatePageIndex(PageUpdateOperation pageUpdateOperation) {
    switch (pageUpdateOperation) {
      case PageUpdateOperation.first:
        setState(() {
          _currentPageIndex = 0;
        });
        break;
      case PageUpdateOperation.previous:
        setState(() {
          _currentPageIndex--;
        });
        break;
      case PageUpdateOperation.next:
        setState(() {
          _currentPageIndex++;
        });
        break;
      case PageUpdateOperation.last:
        setState(() {
          _currentPageIndex = _pages.length - 1;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final pageTextContainer = PageTextContainer(
      text: _pages[_currentPageIndex],
      textStyle: TextStyle(fontSize: widget.font, color: Colors.black),
      padding: widget.paddingTextBox,
      size: _availableSize,
      decoration: widget.decoration,
    );
    return widget.usePageNavigation
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pageTextContainer,
              PageNavigatorMenu(
                size: Size(widget.size.width, _pageNavigatorHeight),
                currentPageIndex: _currentPageIndex,
                pageCount: _pages.length,
                updatePageIndex: _updatePageIndex,
              ),
            ],
          )
        : pageTextContainer;
  }
}

class PageTextContainer extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final Size size;
  final BoxDecoration? decoration;

  const PageTextContainer({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.padding,
    required this.size,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: padding,
      decoration: decoration,
      child: CustomPaint(
        painter: ParagraphPainter(
          pageText: text,
          textStyle: textStyle,
        ),
        child: SizedBox(
          height: size.height,
          width: size.width,
        ),
      ),
    );
  }
}

class PageNavigatorMenu extends StatelessWidget {
  final Size size;
  final int currentPageIndex;
  final int pageCount;
  final void Function(PageUpdateOperation) updatePageIndex;

  const PageNavigatorMenu({
    Key? key,
    required this.size,
    required this.currentPageIndex,
    required this.pageCount,
    required this.updatePageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.first_page,
            ),
            onPressed: currentPageIndex > 0
                ? () => updatePageIndex(
                      PageUpdateOperation.first,
                    )
                : null,
          ),
          IconButton(
            icon: const Icon(
              Icons.navigate_before,
            ),
            onPressed: currentPageIndex > 0
                ? () => updatePageIndex(
                      PageUpdateOperation.previous,
                    )
                : null,
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Page ${currentPageIndex + 1}',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.navigate_next,
            ),
            onPressed: currentPageIndex < pageCount - 1
                ? () => updatePageIndex(
                      PageUpdateOperation.next,
                    )
                : null,
          ),
          IconButton(
            icon: const Icon(
              Icons.last_page,
            ),
            onPressed: currentPageIndex < pageCount - 1
                ? () => updatePageIndex(
                      PageUpdateOperation.last,
                    )
                : null,
          ),
        ],
      ),
    );
  }
}

class ParagraphPainter extends CustomPainter {
  final String pageText;
  final TextStyle textStyle;

  ParagraphPainter({
    required this.pageText,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paragraph = layoutParagraph(
      text: pageText,
      textStyle: textStyle,
      size: size,
    );
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  static ui.Paragraph layoutParagraph({
    required String text,
    required TextStyle textStyle,
    required Size size,
  }) {
    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: textStyle.fontSize,
        fontFamily: textStyle.fontFamily,
        fontStyle: textStyle.fontStyle,
        fontWeight: textStyle.fontWeight,
        textAlign: TextAlign.left,
      ),
    )
      ..pushStyle(textStyle.getTextStyle())
      ..addText(text);
    final ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(
        ui.ParagraphConstraints(width: size.width),
      );
    return paragraph;
  }

  @override
  bool shouldRepaint(ParagraphPainter oldDelegate) =>
      oldDelegate.pageText != pageText || oldDelegate.textStyle != textStyle;
}

class PageProperties {
  final String text;
  final int layoutRuns;

  PageProperties(this.text, this.layoutRuns);

  @override
  String toString() {
    return '''PageProperties(
$text,
$layoutRuns
)''';
  }
}

enum PageUpdateOperation {
  first,
  previous,
  next,
  last,
}

// Call the widget
class ExampleMultiPageText extends StatelessWidget {
  const ExampleMultiPageText(
      {Key? key,
      required this.list,
      required this.fontsize,
      required this.size})
      : super(key: key);
  final double fontsize;
  final List<String> list;
  final Size size;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Center(
      child: MultiPageText(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.0,
            color: Get.isDarkMode ? Colors.white54 : Colors.grey,
          ),
        ),
        usePageNavigation: true,
        fullText: list,
        size: Size(
          size.width,
          size.height,
        ),
        font: fontsize,
      ),
    );
  }
}
