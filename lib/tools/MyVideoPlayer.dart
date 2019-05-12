import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideoPlayer extends StatefulWidget {
  final String url;
  MyVideoPlayer({this.url});
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState(url: url);
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  final String url;
  _MyVideoPlayerState({
    this.url
});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController= VideoPlayerController.network(
      url);
        //'https://github.com/nekomiyaxneko/MyResouse/raw/master/butterfly.mp4');
        //"images/butterfly.mp4");
    print("url${url}");
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
