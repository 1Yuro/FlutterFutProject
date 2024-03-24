import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class FullScreenPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  FullScreenPlayer({required this.videoPlayerController});

  @override
  _FullScreenPlayerState createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  bool _isOverlayVisible = false;
  double _overlayOpacity = 0.8;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: AspectRatio(
            aspectRatio: widget.videoPlayerController.value.aspectRatio,
            child: Stack(
              children: <Widget>[
                VideoPlayer(widget.videoPlayerController),
                GestureDetector(
                  onTap: _toggleOverlay,
                  child: AnimatedOpacity(
                    opacity: _isOverlayVisible ? _overlayOpacity : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      color: Colors.black87,
                    ),
                  ),
                ),
                _buildControls(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
//Overlayin görünümü
  Widget _buildControls(BuildContext context) {
    return _isOverlayVisible
        ? Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.black.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.fullscreen_exit),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
//Overlayin görülüp kaybolması futuredelay kullanmayı denedim error verdi Timer kullanılabilir.
  void _toggleOverlay() {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
      if (_isOverlayVisible) {
        _overlayOpacity = 0.8;
      } else {
        _overlayOpacity = 0.0;
      }
    });
  }
}