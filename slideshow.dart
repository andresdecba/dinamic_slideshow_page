import 'package:flutter/material.dart';

/*

JUST ADD A LIST OF WIDGETS. EX.:

MySlideshow(
  secondaryColor: Colors.grey,
  primaryColor: Colors.blueAccent,
  images: [
    SvgPicture.asset('assets/images/image_1.svg'),
    SvgPicture.asset('assets/images/image_2.svg'),
    SvgPicture.asset('assets/images/image_3.svg'),
  ],
),

*/

class MySlideshow extends StatefulWidget {
  const MySlideshow({
    required this.images,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.black,
    Key? key,
  }) : super(key: key);

  // Properties
  final List<Widget> images;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  _MySlideshowState createState() => _MySlideshowState();
}

class _MySlideshowState extends State<MySlideshow> {
  //
  //controller
  PageController pageViewController = PageController();
  double pagePosition = 0.0;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      setState(() {
        pagePosition = pageViewController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ////// slides
        Expanded(
          child: PageView(
            controller: pageViewController,
            children: widget.images.map((e) => _Slide(image: e)).toList(),
          ),
        ),

        ////// dots
        SizedBox(
          height: 75,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => _Dot(
                pagePosition: pagePosition,
                index: index,
                primary: widget.primaryColor,
                secondary: widget.secondaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

////// dot //////
class _Dot extends StatelessWidget {
  const _Dot({
    Key? key,
    required this.pagePosition,
    required this.index,
    required this.primary,
    required this.secondary,
  }) : super(key: key);

  final double pagePosition;
  final int index;
  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(5),
      height: (pagePosition >= index - 0.5 && pagePosition < index + 0.5) ? 15 : 10,
      width: (pagePosition >= index - 0.5 && pagePosition < index + 0.5) ? 15 : 10,
      decoration: BoxDecoration(
        color: (pagePosition >= index - 0.5 && pagePosition < index + 0.5) ? primary : secondary,
        shape: BoxShape.circle,
      ),
    );
  }
}

////// images //////
class _Slide extends StatelessWidget {
  const _Slide({
    required this.image,
    Key? key,
  }) : super(key: key);

  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: double.infinity,
      width: double.infinity,
      child: image,
    );
  }
}
