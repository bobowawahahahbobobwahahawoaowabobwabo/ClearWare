local games = {
    fsim = 2866967438,
    rmavatar = 6708206173,
    fyweather = 12507488315,
    kat = 621129760
}

if game.PlaceId == games.fsim then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bobowawahahahbobobwahahawoaowabobwabo/Clearware/main/Clearware%20Games/Fishing%20Simulator.txt"))()
elseif game.PlaceId == games.rmavatar then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bobowawahahahbobobwahahawoaowabobwabo/Clearware/main/Clearware%20Games/Rate%20my%20avatar.txt"))()
elseif game.PlaceId == games.fyweather then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bobowawahahahbobobwahahawoaowabobwabo/Clearware/main/Clearware%20Games/Flex%20Your%20Weather.txt"))()
elseif game.PlaceId == games.kat then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bobowawahahahbobobwahahawoaowabobwabo/Clearware/main/Clearware%20Games/knifeabilitytest"))()
end
