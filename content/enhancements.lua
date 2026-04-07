SMODS.Enhancement {
    key = "quaver",
    atlas = "quaver_atlas",
    pos = { x = 1, y = 0 },
    colour = G.C.CHIPS,
    config = { extra = { bonus = 12, x_chips = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.bonus, card.ability.extra.x_chips } }
    end,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.name = "Quaver Card"
        card.rank = "Quaver"
        card.ability.extra.bonus = 12 --because she is twelve
        card.ability.extra.x_chips = 1.5

        --is unbeatable installed? (wont work on linux sorry :(  )
        local steamPath = "C:\\Program Files (x86)\\Steam\\steamapps\\libraryfolders.vdf"
        local file = io.open(steamPath, "r")
        if file then
            local content = file:read("*all")
            file:close()

            local paths = {}
            --get paths from vdf file
            for path in content:gmatch('"path"%s+"(.-)"') do
                -- windows path separator stuffs
                table.insert(paths, path) --:gsub("\\\\", "\\")
            end
            local UNBEATABLE = false
            for _, path in ipairs(paths) do
                if SBALA.exists(path.."/steamapps/common/UNBEATABLE/") then
                    UNBEATABLE = true
                end
            end

            if UNBEATABLE then
                card.ability.extra.x_chips = 3 --everyone play unbeatable
            end
        end

    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                message = "Quaver!", 
                colour = G.C.CHIPS,
                sound = "serena_quaver",
                pitch = 1,
                volume = 2,
                chips = card.ability.extra.bonus,
                x_chips = card.ability.extra.x_chips
            }
        end
    end
}