SBALA = {}

assert(SMODS.load_file("assets/sounds/sound.lua"))()
assert(SMODS.load_file("content/atlas.lua"))()
assert(SMODS.load_file("content/jokers.lua"))()
assert(SMODS.load_file("content/enhancements.lua"))()
assert(SMODS.load_file("content/decks.lua"))()
assert(SMODS.load_file("content/pokerhands.lua"))()
assert(SMODS.load_file("content/planets.lua"))()



vanilla_food = {
  j_gros_michel = true,
  j_egg = true,
  j_ice_cream = true,
  j_cavendish = true,
  j_turtle_bean = true,
  j_diet_cola = true,
  j_popcorn = true,
  j_ramen = true,
  j_selzer = true,
}

modded_food = {
    j_serena_vanilla = true,
    j_serena_500_cigarettes = true,
}

--util
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