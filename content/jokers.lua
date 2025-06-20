
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
                message = localize("k_serena_nums_increased"),
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
                end
            end
        end
        if check then 
            return {
                message = localize('k_serena_debuff_removed')
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