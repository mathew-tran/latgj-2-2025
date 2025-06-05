extends Node2D

class_name SoundMixerManager

enum SONG_NAME{
	FIGHTYOUWANT,
	BATTLEWITHBEASTS,
	ORIGINS
}
func PlaySong(songName : SONG_NAME):
	match songName:
		SONG_NAME.FIGHTYOUWANT:
			$Music.stream = load("res://Audio/If It's a Fight You Want.ogg")
		SONG_NAME.BATTLEWITHBEASTS:
			$Music.stream = load("res://Audio/Battle with Beasts.ogg")
		SONG_NAME.ORIGINS:
			$Music.stream = load("res://Audio/Origins.ogg")
	$Music.play()
	
