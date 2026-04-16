SBALA = {}


SBALA.config = SMODS.current_mod.config or {}

SBALA.config_tab = function()
               SBALA.nodes = {
                  {
                     n=G.UIT.C, config={ align = "tm" },
                     nodes={
                        { 
                        n = G.UIT.C, config = { align = "tm", padding = 0.5 }, nodes = {
                           create_toggle({label = "Copyrighted Music", ref_table = SBALA.config.serenasbalatro, ref_value = "copyrightedmusic"}),
                           create_toggle({label = "Movie Content", ref_table = SBALA.config.serenasbalatro, ref_value = "cinema"}) 
                     } 
                     },
                     
                  },
                  }
               }
               return {
               n = G.UIT.ROOT,
               config = {
                  emboss = 0.05,
                  minh = 6,
                  r = 0.1,
                  minw = 10,
                  align = "cm",
                  padding = 0.2,
                  colour = G.C.BLACK
               },
               nodes = SBALA.nodes
            }

              end


--utils and stuff
SBALA.exists = function(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

SBALA.COLORS = {
   UNBEATABLE = HEX("ee597b"),
   streaming_service = HEX("89f336"),
   movie = HEX("0c1559"),
}


SBALA.vanilla_food = {
  ['j_gros_michel'] = true,
  ['j_egg'] = true,
  ['j_ice_cream'] = true,
  ['j_cavendish'] = true,
  ['j_turtle_bean'] = true,
  ['j_diet_cola'] = true,
  ['j_popcorn'] = true,
  ['j_ramen'] = true,
  ['j_selzer'] = true,
}

SBALA.modded_food = {
    ['j_serena_vanilla'] = true,
    ['j_serena_500_cigarettes'] = true,
}

SBALA.add_to_letterboxd = function()
   for _, jonger in ipairs(G.jokers.cards) do
      if jonger.ability.name == "serena_letterboxd" then
         jonger.remove_from_deck(null, jonger, null)
         jonger.ability.extra.slots = jonger.ability.extra.slots+1
         jonger.add_to_deck(null, jonger, null)
      end
   end
end

SBALA.remove_from_letterboxd = function()
   for _, jonger in ipairs(G.jokers.cards) do
      if jonger.ability.name == "serena_letterboxd" then
         jonger.remove_from_deck(null, jonger, null)
         jonger.ability.extra.slots = jonger.ability.extra.slots-1
         jonger.add_to_deck(null, jonger, null)
      end
   end
end



SBALA.create_leonie_joker = function(movie_key, image_pos_x, image_pos_y, serene_loc_txt, calc, j_extra, loc)
   return SMODS.Joker {
      key = movie_key,
      atlas = "movies_atlas",
      pos = { x = image_pos_x, y = image_pos_y },
      unlocked = true,
      discovered = true,
      config = { extra = j_extra },
      loc_txt = serene_loc_txt,
      loc_vars = loc or {function(self, info_queue, card)
         return { vars = { nil } }
      end},
      rarity = "serena_movie",
      cost = 4,
      calculate = calc,
      add_to_deck = function(self, card, from_debuff)
		   SBALA.add_to_letterboxd()
	   end,
	   remove_from_deck = function(self, card, from_debuff)
		   SBALA.remove_from_letterboxd()
	   end,
   }
end
         


--utils and stuff done! yay!

assert(SMODS.load_file("assets/sounds/sound.lua"))()
assert(SMODS.load_file("content/atlas.lua"))()
assert(SMODS.load_file("content/rarities.lua"))()
assert(SMODS.load_file("content/jokers.lua"))()
assert(SMODS.load_file("content/enhancements.lua"))()
assert(SMODS.load_file("content/decks.lua"))()
assert(SMODS.load_file("content/pokerhands.lua"))()
assert(SMODS.load_file("content/planets.lua"))()



SMODS.current_mod.config_tab = SBALA.config_tab



