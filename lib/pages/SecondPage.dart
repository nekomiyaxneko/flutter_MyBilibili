import 'package:flutter/material.dart';
import 'package:mytest/MyAppBar/HomeAppBar.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController= VideoPlayerController.network(
        'https://github.com/nekomiyaxneko/MyResouse/raw/master/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:
      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
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
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: _sliverBuilder,
          body: Center(
            child: Text('hahaha'),
          )),
    );
  }
}
 
List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
  return <Widget>[
    SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      backgroundColor: Colors.pink[300],
      floating: false, //不随着滑动隐藏标题
      pinned: true, //不固定在顶部
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Image.asset(
          "images/head_icon.jpg", 
          fit: BoxFit.cover,
        ),
      ),
      title: Text("这个是标题"),
    ),
  ];
}
