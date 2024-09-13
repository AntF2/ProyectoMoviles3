import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReproduccionScreen extends StatefulWidget {
  final String videoUrl;

  const ReproduccionScreen({super.key, required this.videoUrl});

  @override
  _ReproduccionScreenState createState() => _ReproduccionScreenState();
}

class _ReproduccionScreenState extends State<ReproduccionScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setLooping(true); // Opcional: Repetir el video

    _initializeVideoPlayerFuture = _controller.initialize();
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
        title: const Text('Reproducción de Video'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error al cargar el video: ${snapshot.error}'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                const SizedBox(height: 20),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.deepPurple,
                    backgroundColor: Colors.grey[300]!,
                    bufferedColor: Colors.deepPurple.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying ? _controller.pause() : _controller.play();
                        });
                      },
                      color: Colors.deepPurple,
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10, size: 36),
                      onPressed: () {
                        setState(() {
                          final position = _controller.value.position;
                          final duration = _controller.value.duration;
                          final newPosition = position + const Duration(seconds: 10);
                          _controller.seekTo(newPosition < duration ? newPosition : duration);
                        });
                      },
                      color: Colors.deepPurple,
                    ),
                    IconButton(
                      icon: const Icon(Icons.replay_10, size: 36),
                      onPressed: () {
                        setState(() {
                          final position = _controller.value.position;
                          final newPosition = position - const Duration(seconds: 10);
                          _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
                        });
                      },
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el video: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
