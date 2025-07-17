import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/music_list_widget.dart';
import '../widgets/mini_player_widget.dart';
import '../widgets/expanded_player_widget.dart';
import '../models/music_data.dart';
import '../themes/colors.dart';

/// Pantalla principal del reproductor de música.
/// Muestra la lista de canciones y gestiona el mini reproductor y el panel expandido.
class MusicPlayerHome extends StatefulWidget {
  const MusicPlayerHome({Key? key}) : super(key: key);

  @override
  State<MusicPlayerHome> createState() => _MusicPlayerHomeState();
}

class _MusicPlayerHomeState extends State<MusicPlayerHome> {
  /// Canción actualmente seleccionada.
  Map<String, dynamic>? currentSong;
  /// Estado de reproducción.
  bool isPlaying = false;
  /// Indica si el panel se está cerrando (para evitar animaciones conflictivas).
  bool isPanelClosing = false;
  /// Indica si el panel está expandido.
  bool isPanelExpanded = false;

  /// Controlador del panel deslizante.
  final PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
    _setInitialNavigationBarColor();
  }

  /// Establece el color inicial de la barra de navegación inferior.
  void _setInitialNavigationBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.collapsedBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Maneja la selección de una canción en la lista.
  void _onSongTap(Map<String, dynamic> song) async {
    setState(() {
      currentSong = song;
      isPlaying = true;
    });
    if (_panelController.isAttached) {
      await _panelController.open();
    }
  }

  /// Alterna entre reproducir y pausar la canción actual.
  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  /// Abre el panel expandido al tocar el mini reproductor.
  Future<void> _onMiniPlayerTap() async {
    if (_panelController.isAttached) {
      await _panelController.open();
    }
  }

  /// Cierra el panel expandido con animación.
  Future<void> _onClosePanel() async {
    if (_panelController.isAttached &&
        !isPanelClosing &&
        !_panelController.isPanelAnimating) {
      setState(() {
        isPanelClosing = true;
      });
      await _panelController.animatePanelToPosition(
        0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          isPanelClosing = false;
        });
      }
    }
  }

  /// Maneja el cambio de estado del panel deslizante (expandido/colapsado).
  void _handlePanelSlide(double position) {
    final shouldBeExpanded = position > 0.7;
    if (shouldBeExpanded != isPanelExpanded) {
      setState(() {
        isPanelExpanded = shouldBeExpanded;
      });
      // Mantener el color minimalista, sin colores por canción.
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.collapsedBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final musicList = MusicData.getMusicList();
    const miniPlayerHeight = 130.0;
    final maxPanelHeight = screenHeight - statusBarHeight - bottomPadding;

    return Scaffold(
      backgroundColor: AppColors.collapsedBackground,
      body: SafeArea(
        child: SlidingUpPanel(
          controller: _panelController,
          minHeight: (currentSong != null && !isPanelExpanded)
              ? miniPlayerHeight
              : 0,
          maxHeight: maxPanelHeight,
          parallaxEnabled: true,
          parallaxOffset: 0.9,
          boxShadow: const [],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          panelSnapping: true,
          isDraggable: currentSong != null,
          onPanelSlide: _handlePanelSlide,
          body: Scaffold(
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
            body: Container(
              margin: EdgeInsets.only(
                bottom: (currentSong != null && !isPanelExpanded)
                    ? miniPlayerHeight
                    : 0,
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
          // Mini reproductor con animación de aparición
          collapsed: (currentSong != null && !isPanelExpanded)
              ? AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: MiniPlayerWidget(
                    key: const ValueKey('mini_player'),
                    song: currentSong!,
                    isPlaying: isPlaying,
                    onTap: _onMiniPlayerTap,
                    onPlayPause: _togglePlayPause,
                  ),
                )
              : const SizedBox.shrink(),
          // Panel expandido con animación de aparición
          panel: (currentSong != null || isPanelClosing)
              ? SafeArea(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: ExpandedPlayerWidget(
                        key: const ValueKey('expanded_player'),
                        song: currentSong!,
                        isPlaying: isPlaying,
                        onPlayPause: _togglePlayPause,
                        onClose: _onClosePanel,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
