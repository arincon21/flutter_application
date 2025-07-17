import '../themes/colors.dart';

/// Modelo de datos para la lista de canciones del reproductor.
/// Solo incluye la información esencial para mantener el minimalismo.
class MusicData {
  /// Devuelve una lista de canciones con datos básicos.
  static List<Map<String, dynamic>> getMusicList() {
    return [
      {
        'title': 'Bohemian Rhapsody',
        'artist': 'Queen',
        'duration': '5:55',
        'albumArt': '🎵',
      },
      {
        'title': 'Stairway to Heaven',
        'artist': 'Led Zeppelin',
        'duration': '8:02',
        'albumArt': '🎸',
      },
      {
        'title': 'Hotel California',
        'artist': 'Eagles',
        'duration': '6:30',
        'albumArt': '🏨',
      },
      {
        'title': 'Imagine',
        'artist': 'John Lennon',
        'duration': '3:07',
        'albumArt': '🕊️',
      },
      {
        'title': 'Sweet Child O Mine',
        'artist': 'Guns N Roses',
        'duration': '5:03',
        'albumArt': '🌹',
      },
      {
        'title': 'Billie Jean',
        'artist': 'Michael Jackson',
        'duration': '4:54',
        'albumArt': '🕺',
      },
      {
        'title': 'Like a Rolling Stone',
        'artist': 'Bob Dylan',
        'duration': '6:13',
        'albumArt': '🎤',
      },
      {
        'title': 'Smells Like Teen Spirit',
        'artist': 'Nirvana',
        'duration': '5:01',
        'albumArt': '🎯',
      },
      {
        'title': 'Purple Haze',
        'artist': 'Jimi Hendrix',
        'duration': '2:50',
        'albumArt': '💜',
      },
      {
        'title': 'Yesterday',
        'artist': 'The Beatles',
        'duration': '2:05',
        'albumArt': '🎭',
      },
    ];
  }
}
