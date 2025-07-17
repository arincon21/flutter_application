import 'package:flutter/material.dart';
import '../themes/colors.dart';

/// Widget expandido del reproductor de música.
/// Muestra controles completos, portada, barra de progreso y acciones.
class ExpandedPlayerWidget extends StatelessWidget {
  /// Canción actual a mostrar.
  final Map<String, dynamic> song;
  /// Indica si la canción está en reproducción.
  final bool isPlaying;
  /// Callback para alternar play/pause.
  final VoidCallback onPlayPause;
  /// Callback para cerrar el panel expandido.
  final VoidCallback onClose;

  const ExpandedPlayerWidget({
    Key? key,
    required this.song,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.collapsedBackground),
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
          // Botón para cerrar el panel
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onClose,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Portada del álbum con animación Hero
          Hero(
            tag: 'albumArt_${song['title']}',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.circular(110),
              ),
              child: Center(
                child: Text(
                  song['albumArt'] ?? '🎵',
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Información de la canción
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  song['title'] ?? 'Unknown Song',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  song['artist'] ?? 'Unknown Artist',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Barra de progreso animada (simulada)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 0.3),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.accentColor,
                        inactiveTrackColor: Colors.grey[800],
                        thumbColor: AppColors.textPrimary,
                        overlayColor: AppColors.accentColor.withOpacity(0.3),
                      ),
                      child: Slider(
                        value: value,
                        onChanged: (_) {},
                      ),
                    );
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1:23",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "4:56",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.02),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Controles de reproducción
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shuffle,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: onClose,
                          tooltip: 'Aleatorio',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_previous,
                            color: AppColors.textPrimary,
                            size: 32,
                          ),
                          onPressed: () {},
                          tooltip: 'Anterior',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppColors.textPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                              child: isPlaying
                                  ? const Icon(Icons.pause, key: ValueKey('pause'), color: AppColors.primaryDark, size: 32)
                                  : const Icon(Icons.play_arrow, key: ValueKey('play'), color: AppColors.primaryDark, size: 32),
                            ),
                            onPressed: onPlayPause,
                            tooltip: isPlaying ? 'Pausar' : 'Reproducir',
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                            color: AppColors.textPrimary,
                            size: 32,
                          ),
                          onPressed: () {},
                          tooltip: 'Siguiente',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.repeat,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {},
                          tooltip: 'Repetir',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Acciones inferiores
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {},
                          tooltip: 'Favorito',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {},
                          tooltip: 'Compartir',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
