
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
        if context.end_of_round and G.GAME.blind.boss then
            card.ability.extra.remaining = G.GAME.round_resets.ante + 1
        end

        if context.after then
            print(G.GAME.current_round.hands_left)
            if G.GAME.current_round.hands_left == 0 then
                if card.ability.extra.remaining > 0 then
                    G.GAME.current_round.hands_left = G.GAME.round_resets.hands
                    G.GAME.current_round.discards_left = G.GAME.round_resets.discards
                    play_sound('serena_soul')
                    card.ability.extra.remaining = card.ability.extra.remaining - 1
                end
            end
        end
    end,
    sb_credits = {
        idea = {
            "Annalert"
        },
        art = {
            "Serena"
        },
        code = {
            "Serena"
        }
    }
    
}

-- Inflation
SMODS.Joker {
    key = "inflation",
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

                    if type(v) == "number" and ((v>0) or ((i=="Xmult" and v>1) or (i=="xmult" and v>1) or (i=="h_x_chips" and v>1) or (i=="x_chips" and v>1))) and (i ~= "order") and (i ~= "cost") then
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
                message = localize("serena_nums_increased"),
                colour = G.C.MONEY
            }
        end
    end,
    sb_credits = {
        idea = {
            "Serena"
        },
        art = {
            "Serena"
        },
        code = {
            "Serena"
        }
    }
}

-- SMODS.Joker {
--     key = "mimic",
--     name = "Mimic",
--     atlas = "jokers_atlas",
--     pos = { x = 2, y = 0 },
--     unlocked = true,
--     discovered = true,
--     ,
    -- sb_credits = {
    --     idea = {
    --         "Serena"
    --     },
    --     art = {
    --         "Penta"
    --     },
    --     code = {
    --         "Serena"
    --     }
    -- }  
-- }

SMODS.Joker {
    key = "dr_house",
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
        --stage 1: remove debuff on played hand
        local check = false
        if context.before then
            for i, played_card in ipairs(G.play.cards) do
                if played_card.debuff then
                    G.play.cards[i].debuff = false
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.increase
                    check = true

                    -- medical malpractice










                end
            end
        end
        if check then 
            return {
                message = localize('serena_debuff_removed')
            }
        end


        --stage 2: do the xmult thing 🤤🤤🤤🤤🤤
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult
            }
        end

    end,
    sb_credits = {
        idea = {
            "Serena"
        },
        art = {
            "scopophobiaz"
        },
        code = {
            "Serena"
        }
    }
}

--sonic (duh)
SMODS.Joker {
    key = "sonic",
    atlas = "jokers_atlas",
    pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { x_mult = 1, increase = 1 } },
    loc_vars = function (self, info_queue, card) 
        return { vars = { card.ability.extra.x_mult, card.ability.extra.increase } }
    end,
    rarity = 2,
    cost = 7,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and (G.GAME.current_round.hands_played == 1) and context.cardarea == G.jokers then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.increase
            card.ability.extra.increase = card.ability.extra.increase * 1.5
            print(localize('serena_gotta_go_fast'))
            return {
                message = localize('serena_gotta_go_fast')
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
}

--Inside Joker
SMODS.Joker {
    key = 'arkveld_all_quavers',
    atlas = "quaver_atlas",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { x_mult = 6000000000 } },
    loc_vars = function (self, info_queue, card) 
        return { vars = { colours = { HEX('ee597b') } } }
    end,
    rarity = 4,
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            print(G.STEAM.user.getSteamID()) --have to have these as strings cause of how luasteam stores user ids
            if tostring(G.STEAM.user.getSteamID())=="76561198868217568" or tostring(G.STEAM.user.getSteamID())=="76561198988159766" then
                return {
                    message = "all quavers speculative oops you in arkveld",
                    colour = G.C.Mult,
                    xmult = card.ability.extra.x_mult,
                    func = function()
                        play_sound("serena_quaver", 1, 2)
                    end
                }
            end
        end
    end
}

--serena
SMODS.Joker {
    key = "serena",
    atlas = "jokers_atlas",
    pos = { x = 5, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { inc = 0.1, x_mult = 1 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.inc, card.ability.extra.x_mult } }
    end,
    rarity = 3,
    cost = 7,
    calculate = function(self, card, context)
        if context.before then
            if next(context.poker_hands['Straight']) then
                card.ability.extra.x_mult = 1
                return { message = localize("k_reset") }
            end
            local yuri_counter = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card.base.value == "Queen" then
                    yuri_counter = yuri_counter+1
                end
            end
            if yuri_counter>=2 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.inc
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
}

--inkling
SMODS.Joker {
    key = "inkling",
    atlas = "jokers_atlas",
    pos = { x = 6, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { inc = 0.25, x_mult = 1 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.inc, card.ability.extra.x_mult } }
    end,
    rarity = 3,
    cost = 7,
    calculate = function(self, card, context)
        card.ability.extra.x_mult = 1 + #G.hand.card_limit * 0.25
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.x_mult = 1 + #G.hand.card_limit * 0.25
    end
}

SMODS.Joker {
    key = "quaverzord",
    atlas = "quaver_atlas",
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function (self, info_queue, card)
        return { vars = { colours = { G.C.CHIPS }} }
    end,
    rarity = 3,
    cost = 10,
    calculate = function(self, card, context)
        if context.before then
            if #context.scoring_hand==4 and next(context.poker_hands['Four of a Kind']) then
                for _, scoring_card in ipairs(context.scoring_hand) do
                    scoring_card:set_ability("m_serena_quaver")
                end
                return {
                    message = "Oops! All quavers!",
                    colour = G.C.CHIPS
                }
            end
        end
    end
}