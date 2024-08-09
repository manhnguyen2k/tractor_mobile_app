import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:developer';
class YouTubePlayerScreen extends StatefulWidget {
  YouTubePlayerScreen({required this.videoId});
  final String videoId;
  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
     _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
     flags: YoutubePlayerFlags(
      isLive: true
     )
    );
  
    super.initState();
  }


 

  @override
  void dispose() {
  _controller.dispose();
    super.dispose();
  }

 

  @override
   Widget build(BuildContext context) {
    return ClipRRect(
   
        child: YoutubePlayer(
          controller: _controller,
          liveUIColor: Colors.red,
          showVideoProgressIndicator: true,
        ),
      );
    
  }
}
