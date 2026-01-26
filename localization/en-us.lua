return {
    descriptions = {
        Back = {}, --decks
        Blind = {}, --blinds
        Joker = {
            j_serena_determination = {
                name = "{C:red}DETERMINATION{}",
                text = {
                    "{C:inactive}The hardened {S:1.1,C:red,E:2}SOUL{} in your chest.{}",
                    "When you would die, replenish",
                    "all of your {S:1.1,C:red}Hands{} and {S:1.1,C:red}Discards{}.",
                    "Inactive after {S:1.1,C:red,E:2}#1#{} activation(s), and replenishes",
                    "after a boss blind is defeated."
                },
            },
            j_serena_inflation = {
                name = "Inflation Joker",
                text = {
                    "Increases {C:green}every value{} on each",
                    "held joker by {C:money}#1#{} at the end of each round.",
                },
            },
            j_serena_mimic = {
                name = "Mimic",
                text = {

                },
            },
            j_serena_dr_house = {
                name = "Dr. House",
                text = {
                    "This joker gains {X:mult,C:white}x#2#{} mult when a {C:G.C.SUITS.Hearts}debuffed{} card is played,",
                    "and removes {C:G.C.SUITS.Hearts}debuffed{} from the card.",
                    "{C:inactive}Currently x#1# mult.{}",
                    "Small chance to trigger additional random effect",
                    "When {C:G.C.SUITS.Hearts}debuffed{} is removed from a card."
                }
            },
            j_serena_sonic = {
                name = "Sonic and Tails",
                text = {
                    "This joker gains {X:mult,C:white}x#2#{} mult if blind",
                    "is cleared by the first played hand.",
                    "(Currently {X:mult,C:white}x#1#{} mult.)",
                    "Mult gain multiplies by 1.5x",
                    "after each successful trigger."
                }
            }
        },
        misc = {
            dictionary = {
                k_serena_nums_increased = "Values UP!",
                k_serena_debuff_removed = "Cured!",
                k_serena_gotta_go_fast = "Speeding up!"
            }
        }
    }
}