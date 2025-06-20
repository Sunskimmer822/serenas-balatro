
-- DETERMINATION
SMODS.Joker {
    key = "determination",
    name = "Determination",
    atlas = "jokers_atlas",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    rarity = 3,
    cost = 9,
    config = { extra = { remaining = 1 } },
    loc_vars = function(self, info_queue, card) 
        return { vars = { card.ability.extra.remaining } }
    end,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            card.ability.extra.remaining = G.GAME.round_resets.ante
        end

        if context.end_of_round and context.game_over and context.main_eval and ( card.ability.extra.remaining > 0 ) then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.current_round.hands_left = G.GAME.round_resets.hands;
                        G.GAME.current_round.discards_left = G.GAME.round_resets.discards;
                        play_sound('serenasbalatro_soul')
                        card.ability.extra.remaining = card.ability.extra.remaining - 1
                        context.main_eval = false
                        return true
                    end
                }))
                return {
                    message = localize('k_saved_ex'),
                    saved = 'ph_mr_bones',
                    colour = G.C.RED
                }
        end
    end
    
}

-- Inflation
SMODS.Joker {
    key = "inflation",
    name = "Inflation",
    atlas = "jokers_atlas",
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { increment = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment } }
    end,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)

        -- TODO: Handle Fortune Teller (maybe need to use a lovely injection to force the updated values to be added)

        if context.end_of_round and not context.game_over and context.main_eval then
            for _, joker in ipairs(G.jokers.cards) do

                for i, v in pairs(joker.ability) do

                    print("type of value attached to field "..i.." on joker "..joker.ability.name.. " is "..type(v))

                    if type(v) == "number" and ((v>0) or (((i=="x_mult")or(i=="xmult")) and v~=0) or ((i=="h_x_mult") and v~=0)) and (i ~= "order") and (i ~= "cost") then
                        G.jokers.cards[_].ability[i] = v + card.ability.extra.increment
                        print("incremented field "..i.." to "..v)
                    elseif type(v) == "table" then
                        for i2, v2 in pairs(joker.ability[i]) do
                            if type(v2) == "number" and (v2>0) then
                                G.jokers.cards[_].ability[i][i2] = v2 + card.ability.extra.increment
                                print("incremented field "..i2.." to "..v2)
                            end
                        end
                    end
                end
                                
            end

            return {
                message = localize("k_nums_increased"),
                colour = G.C.MONEY
            }
        end
    end
}

-- SMODS.Joker {
--     key = "mimic",
--     name = "Mimic",
--     atlas = "jokers_atlas",
--     pos = { x = 2, y = 0 },
--     unlocked = true,
--     discovered = true,
    
-- }

SMODS.Joker {
    key = "dr_house",
    name = "Dr. House",
    atlas = "jokers_atlas",
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { x_mult = 1, increase = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.increase } }
    end,
    rarity = 2,
    cost = 8,
    calculate = function(self, card, context)

    end,
}