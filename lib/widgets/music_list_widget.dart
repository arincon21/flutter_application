import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';

/// Widget que muestra la lista de canciones con animaciones minimalistas.
/// Permite seleccionar una canción y resalta la seleccionada.
class MusicListWidget extends StatelessWidget {
  /// Lista de canciones a mostrar.
  final List<Map<String, dynamic>> musicData;
  /// Duración de la animación de entrada.
  final int duration;
  /// Profundidad del rebote de la animación.
  final double reBounceDepth;
  /// Altura de cada tile de canción.
  final double tileHeight;
  /// Margen de cada tile.
  final EdgeInsets tileMargin;
  /// Radio de borde de cada tile.
  final double borderRadius;
  /// Callback al seleccionar una canción.
  final Function(Map<String, dynamic>)? onTap;
  /// Canción actualmente seleccionada.
  final Map<String, dynamic>? selectedSong;

  const MusicListWidget({
    Key? key,
    required this.musicData,
    this.duration = 1500,
    this.reBounceDepth = 30,
    this.tileHeight = 80,
    this.tileMargin = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.borderRadius = 12,
    this.onTap,
    this.selectedSong,
  }) : super(key: key);

  Widget _buildMusicTile(BuildContext context, Map<String, dynamic> music) {
    final bool isSelected =
        selectedSong != null &&
        selectedSong!['title'] == music['title'] &&
        selectedSong!['artist'] == music['artist'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: tileHeight,
      margin: tileMargin,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromRGBO(255, 255, 255, 0.04)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () => onTap?.call(music),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Row(
              children: [
                // Portada (emoji)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(54, 54, 54, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      music['albumArt'] ?? '🎵',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Información de la canción
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        music['title'] ?? 'Unknown Song',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        music['artist'] ?? 'Unknown Artist',
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
                // Duración o icono de más opciones
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                      child: isSelected
                          ? const Icon(Icons.volume_up, key: ValueKey('playing'), color: AppColors.accentColor, size: 18)
                          : Text(
                              music['duration'] ?? '0:00',
                              key: const ValueKey('duration'),
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.more_vert, color: AppColors.textPrimary, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimationList(
      duration: duration,
      reBounceDepth: reBounceDepth,
      children: [
        ...musicData.map((music) => _buildMusicTile(context, music)),
        const SizedBox(height: 50),
      ],
    );
  }
}
