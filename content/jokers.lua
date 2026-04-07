
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
        return { vars = { colours = { SBALA.COLORS.UNBEATABLE } } }
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
    config = { extra = { x_mult = 0.25 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, 1 + ((G.GAME.round_resets.temp_hand_size or G.hand.config.temp_limit or G.hand.config.card_limit) or G.GAME.starting_params.hand_size) * card.ability.extra.x_mult or 1 } }
    end,
    rarity = 2,
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 1 + ((G.GAME.round_resets.temp_hand_size or G.hand.config.temp_limit or G.hand.config.card_limit) or G.GAME.starting_params.hand_size) * card.ability.extra.x_mult
            }
        end
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

SMODS.Joker {
    key = "enterprise", --what if satellite was xmult
    atlas = "jokers_atlas",
    pos = { x = 7, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { x_mult = .25 } },
    loc_vars = function (self, info_queue, card)
        local planets_used = 0
        for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end
        return { vars = { card.ability.extra.x_mult, 1 + card.ability.extra.x_mult * planets_used } }
    end,
    rarity = 2,
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            --satellite logic yayyy
            local planets_used = 0
            for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end

            return {
                xmult = 1 + card.ability.extra.x_mult * planets_used
            } 
        end
    end
}

SMODS.Joker {
    key = "himejoker",
    atlas = "jokers_atlas",
    pos = { x = 8, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { x_mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    rarity = 3,
    cost = 7,
    calculate = function(self, card, context)
        -- if context.individual and context.cardarea == G.play then
        --     context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
        --     context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
        --     return {
        --         extra = { message = localize('serena_yuriful'), colour = G.C.CHIPS },
        --         card = card
        --     }
        -- end I DONT KNOW WHAT IM DOING
    end
}

SMODS.Joker {
    key = "woker",
    atlas = "jokers_atlas",
    pos = { x = 9, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    rarity = 2,
    cost = 6
}

SMODS.Joker {
    key = "fawesome",
    atlas = "jokers_atlas",
    pos = { x = 10, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { num = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.num } }
    end,
    rarity = "serena_streaming_service",
    cost = 6,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, card.ability.extra.num do
                            local card = create_card('Joker', G.jokers, nil, "serena_movie", nil, nil, nil, nil)
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
            }))
        end
    end

}

--letterjokd
SMODS.Joker {
    key = "letterboxd",
    atlas = "jokers_atlas",
    pos = { x = 11, y = 0 },
    unlocked = true,
    discovered = true,
    config = { extra = { slots = 1 } },
    loc_vars = function(self,info_queue,card)
        return { vars = { card.ability.extra.slots } }
    end,
    rarity = 3,
    cost = 6,
    add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end,
}







--movie jokers
fargo_calc = function(self, card, context)
    if context.joker_main and G.GAME.dollars>0 then
        return {xmult = card.ability.extra.x_mult}
    end
end

fargo = SBALA.create_leonie_joker(
    "fargo", 
    0, 0, 
    {
        ['en-us'] = {
            name = "Fargo", 
            text = {
                "This Joker gives {X:mult,C:white}X#1#{} mult when you have fewer than {C:money}$0{}.",
                "{C:inactive}Jerry, a small-town Minnesota car salesman is bursting at the seams with debt...",
                "{C:inactive}but he's got a plan. He's going to hire two thugs to kidnap his wife in a scheme to collect",
                "{C:inactive}a hefty ransom from his wealthy father-in-law. It's going to be a snap and nobody's going",
                "{C:inactive}to get hurt... until people start dying. Enter Police Chief Marge, a coffee-drinking,",
                "{C:inactive}parka-wearing - and extremely pregnant - investigator who'll stop at nothing to get her man.",
                "{C:inactive}And if you think her small-time investigative skills will give the crooks a run",
                "{C:inactive}for their ransom... you betcha!{}"
            }
        }
    }, 
    fargo_calc,
    {x_mult = 10},
    function(self, info_queue, card)
         return { vars = { card.ability.extra.x_mult } }
    end
)

the_big_lebowski_calc = function(self, card, context)
    local other_joker = nil
    for _, joker in ipairs(G.jokers.cards) do
        if joker ~= card then
            if other_joker == nil then other_joker = joker end
            if joker.sell_cost>other_joker.sell_cost then other_joker = joker end
        end
    end
    if other_joker and other_joker ~= self then
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or self
        if context.blueprint > #G.jokers.cards + 1 then return end
        local other_joker_ret = other_joker:calculate_joker(context)
        if other_joker_ret then 
            other_joker_ret.card = context.blueprint_card or self
            other_joker_ret.colour = G.C.BLUE
            return other_joker_ret
        end
    end
end

the_big_lebowski = SBALA.create_leonie_joker(
    "lebowski", 
    1, 0, 
    {
        ['en-us'] = {
            name = "The Big Lebowski",
            text = {
                "Retrigger the Joker with the highest sell value #1# time.",
                "{C:inactive}Jeffrey 'The Dude' Lebowski, a Los Angeles slacker who only wants to bowl and drink",
                "{C:inactive}White Russians, is mistaken for another Jeffrey Lebowski, a wheelchair-bound ",
                "{C:inactive}millionaire, and finds himself dragged into a strange series of events involving",
                "{C:inactive}nihilists, adult film producers, ferrets, errant toes, and large sums of money."
            }
        }
    },
    the_big_lebowski_calc,
    { retriggers = 1 },
    function(self, info_queue, card)
         return { vars = { card.ability.extra.retriggers } }
    end
)

marty_supreme_calc = function(self, card, context)
    if context.joker_main then
        if math.random(0,1)>0.5 then
            ease_dollars(math.floor(math.random(card.ability.extra.min_dollars,card.ability.extra.max_dollars)))
        else
            return {
                xmult = card.ability.extra.x_mult,
                xchips = card.ability.extra.x_chips
            }
        end
    end
end

marty_supreme = SBALA.create_leonie_joker(
    "marty_supreme",
    2, 0,
    {
        ['en-us'] = {
            name = "Marty Supreme",
            text = {
                "When scored, this Joker randomly either subtracts {C:money}$#3#-#4#{} or",
                "gives {X:chips,C:white}X#1#{} chips and {X:mult,C:white}X#2#{} mult.",
                "{C:inactive}Marty Mauser, a young man with a dream no one respects,",
                "{C:inactive}goes to hell and back in pursuit of greatness."
            }
        }
    },
    marty_supreme_calc,
    { x_mult = 10, x_chips = 10, min_dollars = -10, max_dollars = -20 },
    function(self, info_queue, card)
         return { vars = { card.ability.extra.x_mult, card.ability.extra.x_chips, math.abs(card.ability.extra.min_dollars), math.abs(card.ability.extra.max_dollars) } }
    end
)

every_living_breathing_moment_calc = function(self, card, context)
    if context.before and #context.scoring_hand>=5 then
        face_counter = 0
        for _, card in ipairs(context.scoring_hand) do
            if card:is_face() then face_counter = face_counter + 1 end
        end
        if face_counter>=5 then
            SMODS.create_card({set="Joker", area = G.jokers, key="j_photograph", edition="e_negative"})
        end
    end
end

every_living_breathing_moment = SBALA.create_leonie_joker(
    "every_living_breathing_moment",
    3, 0,
    {
        ['en-us'] = {
            name = "Every Living Breathing Moment",
            text = {
                "If played hand contains five face cards, create a {C:dark_edition}Negative{} {C:attention}Photograph{}.",
                "{C:inactive}During his daily commute, a man finds himself stuck in a rut, hiding from the world",
                "{C:inactive}behind the safety of his polaroid camera and his street-photography obsession. It isn't",
                "{C:inactive}until he misses the chance to meet someone special when he learns he must leave his shell",
                "{C:inactive}and is forced to understand cherishing even the smallest moments in life."
            }
        }
    },
    every_living_breathing_moment_calc,
    { },
    function(self, info_queue, card)
         return { vars = { nil } }
    end
)

vampire_hunter_abraham_lincoln_calc = function(self, card, context)
    --individual: played steel cards give x3 mult
    if context.individual and context.cardarea == G.play then
        if context.other_card.config.center == G.P_CENTERS.m_steel then
            return {
                xmult = card.ability.extra.x_mult,
                card = card
            }
        end
    end

    --after: queue events for each steel card to play the sounds and then delay for duration for next
    if context.after then
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("serena_where_is_the_steel")
                return true
            end
        }))

        for _, other_card in ipairs(context.scoring_hand) do
            if other_card.config.center == G.P_CENTERS.m_steel then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 7,
                    func = function()
                        other_card:juice_up(0.3, 0.4)
                        play_sound("serena_right_here")
                        return true
                    end
                }))
            end
        end
    end
end

vampire_hunter_abraham_lincoln = SBALA.create_leonie_joker(
    "vampire_hunter_abraham_lincoln",
    4, 0,
    {
        ['en-us'] = {
            name = "Abraham Lincoln: Vampire Hunter",
            text = {
                "Scored {C:attention}Steel Cards{} give {X:mult,C:white}X#1#{} mult.",
                "{C:inactive}President Lincoln's mother is killed by a supernatural creature, which",
                "{C:inactive}fuels his passion to crush vampires and their slave-owning helpers."
            }
        }
    },
    vampire_hunter_abraham_lincoln_calc,
    { x_mult = 3 },
    function(self, info_queue, card)
         return { vars = { card.ability.extra.x_mult } }
    end
)


wake_up_dead_man_calc = function(self, card, context)
    if not G.GAME.SBALA_JESUS_MANAGER then G.GAME.SBALA_JESUS_MANAGER = {} end
    local eval = function() 
        return G.GAME.current_round.discards_used <= 0
    end
    juice_card_until(self, eval, true)

    for i, v in pairs(G.hand) do
        local eval = function()
            for o, entry in pairs(G.GAME.SBALA_JESUS_MANAGER) do
                return v==entry.card and entry.count==3
            end
        end
        juice_card_until(v, eval, true)
    end
    

    if context.discard and #context.full_hand==1 then
        --discarding single card
        for i, entry in ipairs(G.GAME.SBALA_JESUS_MANAGER) do
            if entry.card==context.full_hand[1] then
                entry.count = 0
            else
                while #G.GAME.SBALA_JESUS_MANAGER>=3 do
                    table.remove(G.GAME.SBALA_JESUS_MANAGER,1)
                end
                G.GAME.SBALA_JESUS_MANAGER.insert({card=context.full_hand[1],count=0})
            end
        end
    end

    if context.individual and context.cardarea == G.play then
        for i, entry in ipairs(G.GAME.SBALA_JESUS_MANAGER) do
            if context.other_card == entry.card then
                return {
                    repetitions = card.ability.extra.retriggers,
                    xmult = card.ability.extra.x_mult,
                    card = other_card
                    
                }
            end
        end
    end


    if context.end_of_round then
        for i, entry in ipairs(G.GAME.SBALA_JESUS_MANAGER) do
            entry.count = entry.count+1
            if entry.count>3 then table.remove(G.GAME.SBALA_JESUS_MANAGER,i) end
        end
    end


end


wake_up_dead_man = SBALA.create_leonie_joker(
    "balatro_christ",
    5, 0,
    {
        ['en-us'] = {
            name = "Wake Up Dead Man",
            text = {
                "Save the first discarded card of the round. If you play that card in exactly 3 rounds,",
                "that card gives {X:mult,C:white}X#1#{} mult and is retriggered {C:attention}#2#{} times",
                "{C:inactive}When young priest Jud Duplenticy is sent to assist charismatic firebrand Monsignor Jefferson Wicks, it's clear",
                "{C:inactive}that all is not well in the pews. After a sudden and seemingly impossible murder rocks the town, the lack of an",
                "{C:inactive}obvious suspect prompts local police chief Geraldine Scott to join forces with renowned detective Benoit Blanc",
                "{C:inactive}to unravel a mystery that defies all logic."
            }
        }
    },
    wake_up_dead_man_calc,
    { x_mult = 5, retriggers = 3 },
    function(self, info_queue, card)
         return { vars = { card.ability.extra.x_mult, card.ability.extra.retriggers } }
    end
)


lady_bird_calc = function(self, card, context)
end

lady_bird = SBALA.create_leonie_joker(
    "lady_bird",
    6, 0,
    {
        ['en-us'] = {
            name = "Lady Bird",
            text = {
                "",
                "{C:inactive}Lady Bird McPherson, a strong willed, deeply opinionated,",
                "{C:inactive}artistic 17 year old comes of age in Sacramento. Her relationship",
                "{C:inactive}with her mother and her upbringing are questioned",
                "{C:inactive}and tested as she plans to head off to college."
            }
        }
    },
    lady_bird_calc,
    { },
    function(self, info_queue, card)
         return { vars = { nil } }
    end
)


see_how_they_run_calc = function(self, card, context)
end

see_how_they_run = SBALA.create_leonie_joker(
    "see_how_they_run",
    7, 0,
    {
        ['en-us'] = {
            name = "See How They Run",
            text = {
                "",
                "{C:inactive}In the West End of 1950s London, plans for a movie version of a smash-hit play come",
                "{C:inactive}to an abrupt halt after a pivotal member of the crew is murdered. When world-weary",
                "{C:inactive}Inspector Stoppard and eager rookie Constable Stalker take on the case, the two find",
                "{C:inactive}themselves thrown into a puzzling whodunit within the glamorously sordid theater underground,",
                "{C:inactive}investigating the mysterious homicide at their own peril."
            }
        }
    },
    see_how_they_run_calc,
    { },
    function(self, info_queue, card)
         return { vars = { nil } }
    end
)


memento_calc = function(self, card, context)

    if context.before then
        local common_card = false
        for i, v in ipairs(context.scoring_hand) do
            if not common_card then
                for o, k in ipairs(SMODS.last_hand.scoring_hand) do
                    if v==k then common_card = true break end
                end
            end
        end
        if common_card then card.ability.extra.consec = card.ability.extra.consec+1 end
    end

    if context.joker_main then
        return {
            xmult = 1+ card.ability.extra.consec*card.ability.extra.per
        }
    end
end

memento = SBALA.create_leonie_joker(
    "memento",
    8, 0,
    {
        ['en-us'] = {
            name = "Memento",
            text = {
                "This Joker gains {X:mult,C:white}X#1#{} mult per consecutive hand",
                "played containing at least one card in the last played hand.",
                "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}mult.){}",
                "{C:inactive}Leonard Shelby is tracking down the man who raped and murdered his wife. The difficulty of",
                "{C:inactive}locating his wife's killer, however, is compounded by the fact that he suffers from a rare,",
                "{C:inactive}untreatable form of short-term memory loss. Although he can recall details of life before",
                "{C:inactive}his accident, Leonard cannot remember what happened fifteen minutes ago, where he's going, or why."
            }
        }
    },
    memento_calc,
    { consec = 0, per = .25 },
    function(self, info_queue, card)
         return { vars = { card.ability.extra.per, 1+card.ability.extra.consec*card.ability.extra.per } }
    end
)


the_grand_budapest_hotel_calc = function(self, card, context)
end

the_grand_budapest_hotel = SBALA.create_leonie_joker(
    "the_grand_budapest_hotel",
    9, 0,
    {
        ['en-us'] = {
            name = "The Grand Budapest Hotel",
            text = {
                "",
                "{C:inactive}The Grand Budapest Hotel tells of a legendary concierge at a famous European hotel between the wars",
                "{C:inactive}and his friendship with a young employee who becomes his trusted protégé. The story involves the",
                "{C:inactive}theft and recovery of a priceless Renaissance painting, the battle for an enormous family fortune",
                "{C:inactive}and the slow and then sudden upheavals that transformed Europe during the first half of the 20th century."
            }
        }
    },
    the_grand_budapest_hotel_calc,
    { },
    function(self, info_queue, card)
         return { vars = { nil } }
    end
)


the_outrun_calc = function(self, card, context)
end

the_outrun = SBALA.create_leonie_joker(
    "the_outrun",
    10, 0,
    {
        ['en-us'] = {
            name = "The Outrun",
            text = {
                "",
                "{C:inactive}Fresh out of rehab, Rona returns to the Orkney Islands—a place both wild and beautiful,",
                "{C:inactive}right off the Scottish coast. Now 29 and after more than a decade of living life on the",
                "{C:inactive}edge in London, where she both found and lost love, Rona attempts to come to terms with",
                "{C:inactive}her troubled past. As she reconnects with the dramatic landscape where she grew up,",
                "{C:inactive}memories of her traumatic childhood merge with more recent challenging events that have",
                "{C:inactive}set her on the path to recovery."
            }
        }
    },
    the_outrun_calc,
    { },
    function(self, info_queue, card)
         return { vars = { nil } }
    end
)


the_french_dispatch_of_the_liberty_kansas_evening_sun_calc = function(self, card, context)
end

the_french_dispatch_of_the_liberty_kansas_evening_sun = SBALA.create_leonie_joker(
    "the_french_dispatch_of_the_liberty_kansas_evening_sun",
    11, 0,
    {
        ['en-us'] = {
            name = "The French Dispatch of the Liberty, Kansas Evening Sun",
            text = {
                "",
                "{C:inactive}The staff of an American magazine based in France puts out its last issue, with",
                "{C:inactive}stories featuring an artist sentenced to life imprisonment, student",
                "{C:inactive}riots, and a kidnapping resolved by a chef."
            }
        }
    },
    the_french_dispatch_of_the_liberty_kansas_evening_sun_calc,
    { },
    function(self, info_queue, card)
         return { vars = { nil } }
    end
)


little_women_calc = function(self, card, context)
end

little_women = SBALA.create_leonie_joker(
    "little_women",
    12, 0,
    {
        ['en-us'] = {
            name = "Little Women",
            text = {
                "",
                "{C:inactive}Four sisters come of age in America in the aftermath of the Civil War."
            }
        }
    }
)