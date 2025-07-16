import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/music_list_widget.dart';
import '../widgets/mini_player_widget.dart';
import '../widgets/expanded_player_widget.dart';
import '../models/music_data.dart';
import '../themes/colors.dart';

class MusicPlayerHome extends StatefulWidget {
  const MusicPlayerHome({Key? key}) : super(key: key);

  @override
  State<MusicPlayerHome> createState() => _MusicPlayerHomeState();
}

class _MusicPlayerHomeState extends State<MusicPlayerHome> {
  Map<String, dynamic>? currentSong;
  bool isPlaying = false;
  final PanelController _panelController = PanelController();

  void _onSongTap(Map<String, dynamic> song) {
    setState(() {
      currentSong = song;
      isPlaying = true;
    });
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _onMiniPlayerTap() {
    _panelController.open();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final musicList = MusicData.getMusicList();
    final miniPlayerHeight = 150.0;

    return Scaffold(
      backgroundColor: AppColors.collapsedBackground,
      appBar: AppBar(
        backgroundColor: AppColors.collapsedBackground,
        surfaceTintColor: AppColors.collapsedBackground,
        toolbarHeight: 100,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            "Music Player",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),

      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: currentSong != null ? miniPlayerHeight : 0,
        maxHeight: screenHeight,
        parallaxEnabled: true,
        parallaxOffset: 0.9,
        boxShadow: const [],

        // Contenido principal (Lista de música)
        body: Container(
          color: AppColors.collapsedBackground,
          child: SafeArea(
            bottom: false,
            child: Container(
              margin: EdgeInsets.only(
                bottom: currentSong != null ? miniPlayerHeight : 130,
              ),
              child: MusicListWidget(
                musicData: musicList,
                onTap: _onSongTap,
                selectedSong: currentSong,
                duration: 2500,
                reBounceDepth: 20,
              ),
            ),
          ),
        ),

        // Mini reproductor (collapsed)
        collapsed: currentSong != null
            ? MiniPlayerWidget(
                song: currentSong!,
                isPlaying: isPlaying,
                onTap: _onMiniPlayerTap,
                onPlayPause: _togglePlayPause,
              )
            : const SizedBox.shrink(),

        // Reproductor expandido (panel)
        panel: currentSong != null
            ? ExpandedPlayerWidget(
                song: currentSong!,
                isPlaying: isPlaying,
                onPlayPause: _togglePlayPause,
                onClose: () => _panelController.close(),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
