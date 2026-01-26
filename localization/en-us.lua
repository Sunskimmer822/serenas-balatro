return {
    descriptions = {
        Back = { --decks
            b_serena_quaver = {
                name = "Quaver Deck",
                text = {
                    "Oops! All {B:1,C:white}Quaver Cards{}!",
                }
            }
        },
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
            },
            j_serena_arkveld_all_quavers = {
                name = "Inside Joker",
                text = {
                    "{B:1,C:white}and the idea changes you in return...{}"
                }
            },
            j_serena_serena = {
                name = "Serena",
                text = {
                    "This Joker gains {X:mult,C:white}x#1#{} mult per hand played containing",
                    "at least two queens. Resets if played hand contains a straight.",
                    "{C:inactive}(Currently{} {X:mult,C:white}x#2#{} {C:inactive}mult){}",
                    "{X:money,E:2}yuri!{}"
                }
            },
            j_serena_inkling = {
                name = "Inkling",
                text = {
                    "This joker gives {X:mult,C:white}x#1#{} mult per hand size.",
                    "{C:inactive}(Currently{} {X:mult,C:white}x#2#{} {C:inactive} mult){}"
                }
            },
            j_serena_quaverzord = {
                name = "Quaverzord",
                text = {
                    "When a Four of a Kind is played,",
                    "scored cards become {B:1,C:white}Quaver cards{}."
                }
            }
        },
        Enhanced = {
            m_serena_quaver = {
                name = "Quaver Card",
                text = {
                    "{C:chips}+#1#{} chips, because she's 12.",
                    "{X:chips,C:white}x#2#{} chips, because she's blue.",
                    "Everyone play UNBEATABLE right NOW!!"
                }
            }
        },
        Planet = {
            c_serena_quaver_guitar = {
                name = "Electric Guitar",
                text = {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
                }
            }
        },
        misc = {
            dictionary = {
                serena_nums_increased = "Values UP!",
                serena_debuff_removed = "Cured!",
                serena_gotta_go_fast = "Speeding up!",
                serena_UNBEATABLE = "UNBEATABLE!",
            },
        }
    }
}