SMODS.Sound {
    key = "soul",
    path = "soul.ogg",
}

assert(SMODS.load_file("content/atlas.lua"))()
assert(SMODS.load_file("content/jokers.lua"))()



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