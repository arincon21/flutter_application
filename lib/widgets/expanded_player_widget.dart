import 'package:flutter/material.dart';
import '../themes/colors.dart';

class ExpandedPlayerWidget extends StatelessWidget {
  final Map<String, dynamic> song;
  final bool isPlaying;
  final VoidCallback onPlayPause;
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(color: AppColors.collapsedBackground),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 3,
            width: screenWidth * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                  onPressed: onClose,
                ),
                /* const Column(
                  children: [
                    Text(
                      "REPRODUCIENDO DESDE",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Tu Música",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {},
                ),*/
              ],
            ),
          ),
          const SizedBox(height: 80),

          // Album Art
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: song['backgroundColor'] ?? AppColors.secondaryDark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                song['albumArt'] ?? '🎵',
                style: const TextStyle(fontSize: 120),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Song Info
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
                ),
                const SizedBox(height: 8),
                Text(
                  song['artist'] ?? 'Unknown Artist',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor:
                        song['backgroundColor'] ?? AppColors.accentColor,
                    inactiveTrackColor: Colors.grey[800],
                    thumbColor: AppColors.textPrimary,
                    overlayColor:
                        (song['backgroundColor'] ?? AppColors.accentColor)
                            .withOpacity(0.3),
                  ),
                  child: Slider(
                    value: 0.3, // Simulado
                    onChanged: (value) {},
                  ),
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

          // Controls
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_previous,
                    color: AppColors.textPrimary,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: AppColors.primaryDark,
                      size: 32,
                    ),
                    onPressed: onPlayPause,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_next,
                    color: AppColors.textPrimary,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.repeat,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const Spacer(),

          // Bottom actions
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: AppColors.textSecondary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
