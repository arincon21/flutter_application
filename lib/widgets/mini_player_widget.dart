import 'package:flutter/material.dart';
import '../themes/colors.dart';

class MiniPlayerWidget extends StatelessWidget {
  final Map<String, dynamic> song;
  final bool isPlaying;
  final VoidCallback onTap;
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
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: EdgeInsets.all(15),
        color: AppColors.collapsedBackground,
        child: Column(
          children: [
            // Barra de progreso
            /*Container(
              height: 2,
              child: LinearProgressIndicator(
                value: 0.3, // Simulado
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(
                  song['backgroundColor'] ?? AppColors.accentColor,
                ),
              ),
            ),
            */
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 3,
              width: screenWidth * 0.85,
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
                    // Play/Pause button
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.fromARGB(255, 79, 79, 79),
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.textSecondary,
                          size: 25,
                        ),
                        onPressed: onPlayPause,
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Song info
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

                    // info song
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Mostrar icono de reproducción si está seleccionada
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
    );
  }
}
