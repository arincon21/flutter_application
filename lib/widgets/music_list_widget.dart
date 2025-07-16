import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';

class MusicListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> musicData;
  final int duration;
  final double reBounceDepth;
  final double tileHeight;
  final EdgeInsets tileMargin;
  final double borderRadius;
  final Function(Map<String, dynamic>)? onTap;
  final Map<String, dynamic>?
  selectedSong; // Nueva propiedad para la canción seleccionada

  const MusicListWidget({
    Key? key,
    required this.musicData,
    this.duration = 1500,
    this.reBounceDepth = 30,
    this.tileHeight = 80,
    this.tileMargin = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.borderRadius = 12,
    this.onTap,
    this.selectedSong, // Agregar el parámetro selectedSong
  }) : super(key: key);

  Widget _buildMusicTile(Map<String, dynamic> music) {
    // Verificar si esta canción está seleccionada
    final bool isSelected =
        selectedSong != null &&
        selectedSong!['title'] == music['title'] &&
        selectedSong!['artist'] == music['artist'];

    return GestureDetector(
      onTap: () => onTap?.call(music),
      child: Container(
        height: tileHeight,
        margin: tileMargin,
        decoration: BoxDecoration(
          // Aplicar color de fondo oscuro si está seleccionada
          color: isSelected
              ? Color.fromRGBO(255, 255, 255, 0.04)
              : Colors.transparent,
          //borderRadius: BorderRadius.circular(borderRadius),
          /*boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],*/
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Row(
            children: [
              // Album Art (Emoji)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(54, 54, 54, 1),
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

              // Song Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      music['title'] ?? 'Unknown Song',
                      style: TextStyle(
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
                      style: TextStyle(
                        color: Color.fromRGBO(96, 96, 96, 1),
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Duration y icono de reproducción
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mostrar icono de reproducción si está seleccionada
                  /*if (isSelected)
                    Icon(
                      Icons.volume_up,
                      color: music['backgroundColor'] ?? AppColors.accentColor,
                      size: 16,
                    )
                  else
                    Text(
                      music['duration'] ?? '0:00',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 4),*/
                  Icon(Icons.more_vert, color: AppColors.textPrimary, size: 16),
                ],
              ),
            ],
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
      children: musicData.map((music) => _buildMusicTile(music)).toList(),
    );
  }
}
