
-- DETERMINATION
SMODS.Joker {
    key = "determination",
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

-- Compound Interest
SMODS.Joker {
    key = "inflation",
    atlas = "jokers_atlas",
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { inc = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.inc } }
    end,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            for _, other in ipairs(G.jokers.cards) do


                print(type(other.ability.extra))


                if type(other.ability.extra) ~= "nil" then
                    if type(other.ability.extra) == "number" then
                        other.ability.extra = other.ability.extra + card.ability.extra.inc
                    elseif type(other.ability.extra) == "table" then
                        for _, val in pairs(other.ability.extra) do
                            print(type(val))
                            if type(val) == "number" then
                                val = val + card.ability.extra.inc
                            elseif type(val) == "table" then
                                for _2, val2 in pairs(val) do
                                    if type(val2) == "number" then
                                        val2 = val2 + card.ability.extra.inc
                                    end
                                end
                            end
                        end
                    end
                end

                if not (other.ability.mult == nil) then
                    other.ability.mult = other.ability.mult + card.ability.extra.inc
                end
                if not (other.ability.h_mult == nil) then
                    other.ability.h_mult = other.ability.h_mult + card.ability.extra.inc
                end
                if not (other.ability.h_x_mult == nil) then
                    other.ability.h_x_mult = other.ability.h_x_mult + card.ability.extra.inc
                end
                if not (other.ability.h_dollars == nil) then
                    other.ability.h_dollars = other.ability.h_dollars + card.ability.extra.inc
                end
                if not (other.ability.p_dollars == nil) then
                    other.ability.p_dollars = other.ability.p_dollars + card.ability.extra.inc
                end
                if not (other.ability.t_mult == nil) then
                    other.ability.t_mult = other.ability.t_mult + card.ability.extra.inc
                end
                if not (other.ability.t_chips == nil) then
                    other.ability.t_chips = other.ability.t_chips + card.ability.extra.inc
                end
                if (not (other.ability.x_mult == nil)) and (not (other.ability.x_mult == 1))  then
                    other.ability.x_mult = other.ability.x_mult + card.ability.extra.inc
                end
                if not (other.ability.h_size == nil) then
                    other.ability.h_size = other.ability.h_size + card.ability.extra.inc
                end
                if not (other.ability.d_size == nil) then
                    other.ability.d_size = other.ability.d_size + card.ability.extra.inc
                end
            end

            return {
                message = localize("k_nums_increased"),
                colour = G.C.MONEY
            }
        end
    end
}