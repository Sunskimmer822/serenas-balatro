SMODS.PokerHand {
    key = "quaver_five",
    loc_txt = {
        name = "Quaver five",
        description = {
            "5 Quavers."
        }
    },
    visible = false,
    chips = 120,
    mult = 12,
    l_chips = 12,
	l_mult = 12,
    example = {
		{ "S_A", true, enhancement = "m_serena_quaver" },
		{ "S_A", true, enhancement = "m_serena_quaver" },
		{ "S_A", true, enhancement = "m_serena_quaver" },
		{ "S_A", true, enhancement = "m_serena_quaver" },
		{ "S_A", true, enhancement = "m_serena_quaver" },
	},
    loc_vars = function (self, info_queue, card)
        return { vars = { colours = { G.C.CHIPS }} }
    end,
    atlas = "poker_hands",
    pos = { x = 0, y = 0 },
    evaluate = function(parts, hand) --stolen from cryptid
		local quavers = {}
		for i, card in ipairs(hand) do
			if
				card.config.center_key == "m_serena_quaver"
				or (card.config.center.rank=="Quaver" and card.config.center.no_suit)
			then
				quavers[#quavers + 1] = card
			end
		end
		return #quavers >= 5 and { quavers } or {}
	end,
}