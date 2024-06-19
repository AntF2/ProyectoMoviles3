import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReproduccionScreen extends StatefulWidget {
  final String videoUrl;

  ReproduccionScreen({required this.videoUrl});

  @override
  _ReproduccionScreenState createState() => _ReproduccionScreenState();
}

class _ReproduccionScreenState extends State<ReproduccionScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true); // Opcional: Repetir el video

    _controller.play(); // Iniciar automáticamente la reproducción (opcional)
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reproducción de Video'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
