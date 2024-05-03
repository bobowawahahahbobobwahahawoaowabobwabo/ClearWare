local games = {
    fsim = 2866967438,
    rmavatar = 6708206173,
    fyweather = 12507488315,
    kat = 621129760,
    mort = 4169490976
}

if game.PlaceId == games.fsim then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/Clearware/main/Clearware%20Games/Fishing%20Simulator.lua"))()
elseif game.PlaceId == games.rmavatar then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/Clearware/main/Clearware%20Games/Rate%20my%20avatar.lua"))()
elseif game.PlaceId == games.fyweather then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/Clearware/main/Clearware%20Games/Flex%20Your%20Weather.lua"))()
elseif game.PlaceId == games.kat then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/Clearware/main/Clearware%20Games/knifeabilitytest.lua"))()
elseif game.PlaceId == games.mort then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/Clearware/main/Clearware%20Games/mortem.lua"))()
end
