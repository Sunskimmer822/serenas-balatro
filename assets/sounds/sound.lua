SMODS.Sound {
    key = "soul",
    path = "soul.ogg",
}

SMODS.Sound {
    key = "quaver",
    path = "quaver.ogg",
}

SMODS.Sound {
    key = "where_is_the_steel",
    path = "where_is_the_steel.ogg",
}

SMODS.Sound {
    key = "right_here",
    path = "right_here.ogg"
}


   SMODS.Sound({
	key = "music_lego_movie",
	path = "everything_is_awesome.ogg",
	sync = false,
	pitch = 1,
	select_music_track = function()
		return next(find_joker("j_serena_lego_movie")) and SBALA.config.serenasbalatro.copyrightedmusic
			and 300
	end,
}) 

