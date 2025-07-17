import 'package:flutter/material.dart';
import '../themes/colors.dart';

/// Widget minimalista para mostrar el mini reproductor en la parte inferior.
/// Incluye controles básicos y la información de la canción actual.
class MiniPlayerWidget extends StatelessWidget {
  /// Canción actual a mostrar.
  final Map<String, dynamic> song;
  /// Indica si la canción está en reproducción.
  final bool isPlaying;
  /// Callback al tocar el mini reproductor (expande el panel).
  final VoidCallback onTap;
  /// Callback para alternar play/pause.
  final VoidCallback onPlayPause;

  const MiniPlayerWidget({
    Key? key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onPlayPause,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.collapsedBackground,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 60,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: [
              // Barra superior para indicar que se puede deslizar
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              // Contenido del mini player
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      // Botón Play/Pause con animación visual
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 79, 79, 79),
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                            child: isPlaying
                                ? const Icon(Icons.pause, key: ValueKey('pause'), color: AppColors.textSecondary, size: 25)
                                : const Icon(Icons.play_arrow, key: ValueKey('play'), color: AppColors.textSecondary, size: 25),
                          ),
                          onPressed: onPlayPause,
                          tooltip: isPlaying ? 'Pausar' : 'Reproducir',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Información de la canción
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              song['title'] ?? 'Unknown Song',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              song['artist'] ?? 'Unknown Artist',
                              style: const TextStyle(
                                color: Color.fromRGBO(96, 96, 96, 1),
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Duración de la canción
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            song['duration'] ?? '0:00',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
