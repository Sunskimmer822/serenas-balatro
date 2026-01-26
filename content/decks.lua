SMODS.Back {
    --quaver deck
    key = "quaver",
    atlas = "quaver_atlas",
    pos = { x = 3, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = { colours = { G.C.CHIPS }} }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    card:set_ability("m_serena_quaver")
                end
            return true
            end
        }))
    end
}