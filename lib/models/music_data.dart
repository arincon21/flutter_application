import '../themes/colors.dart';

class MusicData {
  static List<Map<String, dynamic>> getMusicList() {
    return [
      {
        'title': 'Bohemian Rhapsody',
        'artist': 'Queen',
        'backgroundColor': AppColors.musicTileColors[0],
        'duration': '5:55',
        'albumArt': '🎵',
      },
      {
        'title': 'Stairway to Heaven',
        'artist': 'Led Zeppelin',
        'backgroundColor': AppColors.musicTileColors[1],
        'duration': '8:02',
        'albumArt': '🎸',
      },
      {
        'title': 'Hotel California',
        'artist': 'Eagles',
        'backgroundColor': AppColors.musicTileColors[2],
        'duration': '6:30',
        'albumArt': '🏨',
      },
      {
        'title': 'Imagine',
        'artist': 'John Lennon',
        'backgroundColor': AppColors.musicTileColors[3],
        'duration': '3:07',
        'albumArt': '🕊️',
      },
      {
        'title': 'Sweet Child O Mine',
        'artist': 'Guns N Roses',
        'backgroundColor': AppColors.musicTileColors[4],
        'duration': '5:03',
        'albumArt': '🌹',
      },
      {
        'title': 'Billie Jean',
        'artist': 'Michael Jackson',
        'backgroundColor': AppColors.musicTileColors[5],
        'duration': '4:54',
        'albumArt': '🕺',
      },
      {
        'title': 'Like a Rolling Stone',
        'artist': 'Bob Dylan',
        'backgroundColor': AppColors.musicTileColors[6],
        'duration': '6:13',
        'albumArt': '🎤',
      },
      {
        'title': 'Smells Like Teen Spirit',
        'artist': 'Nirvana',
        'backgroundColor': AppColors.musicTileColors[7],
        'duration': '5:01',
        'albumArt': '🎯',
      },
      {
        'title': 'Purple Haze',
        'artist': 'Jimi Hendrix',
        'backgroundColor': AppColors.musicTileColors[8],
        'duration': '2:50',
        'albumArt': '💜',
      },
      {
        'title': 'Yesterday',
        'artist': 'The Beatles',
        'backgroundColor': AppColors.musicTileColors[9],
        'duration': '2:05',
        'albumArt': '🎭',
      },
    ];
  }
}
