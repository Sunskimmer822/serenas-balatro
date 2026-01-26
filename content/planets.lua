SMODS.Consumable {
    key = "quaver_guitar",
    set = "Planet",
    atlas = "quaver_atlas",
    pos = { x = 4, y = 0 },
    config = { hand_type = "serena_quaver_five" },
    -- all this is stolen from cryptid
    set_card_type_badge = function(self, card, badges) 
		badges[1] = create_badge(localize("k_planet_disc"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				"Quaver five",
				G.GAME.hands["serena_quaver_five"].level,
				G.GAME.hands["serena_quaver_five"].l_mult,
				G.GAME.hands["serena_quaver_five"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["serena_quaver_five"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["serena_quaver_five"].level))]
					),
				},
			},
            message = "This jit cracks planets",
            colour = G.C.CHIPS
		}
	end,
    generate_ui = 0,
    force_use = function(self, card, area)
		card:use_consumeable(area)
	end
}