import 'package:flutter/material.dart';
import 'package:meeting_app/features/laboratory/videos/widgets/video_item.dart';

class VideoScreen extends StatefulWidget {
  static String routeName = "/lab/video";
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  int _itemCount = 5;
  final PageController _pageController = PageController();
  final Duration _duration = const Duration(milliseconds: 150);
  final Curve _curve = Curves.bounceInOut;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _duration,
      curve: _curve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 5;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _duration,
      curve: _curve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => VideoItem(
        onVideoFinished: _onVideoFinished,
      ),
    );
  }
}
