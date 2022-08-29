import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technos_app/src/home_page/home_page_model.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key, required Servico servico}) : _servico = servico, super(key: key);

  static const routeName = '/PlayVideo';
  final Servico _servico;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;
  late File _fileExists;
  bool _videoExists = false;


  @override
  void initState() {
    super.initState();
    initializePlayer(widget._servico.titulo, widget._servico.categoria);
  }

  @override
  void dispose() {
    if(_videoExists){
      _videoPlayerController1.dispose();
      _chewieController?.dispose();
    }
    super.dispose();
  }

  Future<void> initializePlayer(String titulo, String categoria) async {
    Permission.manageExternalStorage.request();

    final prefs = await SharedPreferences.getInstance();
    final String? videoDirectory = prefs.getString('technos_directory');
    _fileExists  = File('$videoDirectory/$categoria/$titulo.mp4');

    if(await _fileExists.exists()){
      _videoPlayerController1 = VideoPlayerController.file(_fileExists);

      await Future.wait([
        _videoPlayerController1.initialize()
      ]);

      _createChewieController();
      _videoExists = true;
      setState(() {});

      return;
    }

    else{
      _videoExists = false;
      setState(() {});
    }


  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      hideControlsTimer: const Duration(seconds: 2),

      // showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: const Color.fromARGB(255, 202, 200, 200),
        bufferedColor: Colors.grey,
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  <Widget> [
          Container(
            height: 120,
            color: Colors.black,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )
                  ),
                  Expanded(
                    child: Center(child: 
                      Text(
                        widget._servico.titulo, 
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)))
                  ),
                  const SizedBox(
                    width: 48,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: _videoExists == false 
              ? const Center(child: Text('Arquivo não encontrado', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)))
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: _chewieController != null &&
                                _chewieController!
                                    .videoPlayerController.value.isInitialized
                            ? Chewie(
                                controller: _chewieController!,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text('Carregando...'),
                                ],
                              ),
                      ),
                    ),
                    // const SizedBox(height: 50),

                    TextButton(
                      onPressed: () {
                        _chewieController?.enterFullScreen();
                      },
                      child: const Text('Fullscreen'),
                    ),
                  ],
                ),
          ),
        ]
      )
    );
  }
}

