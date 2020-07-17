import json, os, httpclient, tables, strutils, re, random

## Saves the json at `https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json` to configDir/nimoji/emoji.json

proc downloadEmojiData*() =
    echo "Downloading emoji data..."
    let client = newHttpClient()
    let js = client.getContent("https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json")
    writeFile(getHomeDir()&"emoji.json", js)

proc getEmojiJson():JsonNode =
    if not fileExists(getHomeDir()&"emoji.json"):
        downloadEmojiData()
        
    return parseFile(getHomeDir()&"emoji.json")

proc replacex(s, repFrom, repTo:string):string =
    result = s
    while repFrom in result:
        result = result.replace(repFrom, repTo)
        
## Searches the emoji dict for emoji names matching search, returns all hits
proc findEmoji*(part:string):string =
    for k, v in getEmojiJson().getFields().pairs:
        if part.replacex(":", "") in k:
            return v.getStr
            
proc findEmojis*(part:string):seq[string] =
    for k, v in getEmojiJson().getFields().pairs:
        if part.replacex(":", "") in k:
            result.add v.getStr
        
## Searches the emoji dict for emojis matching the search
proc getEmoji*(emoji:string, default:string = "unknown_emoji"):string =
    return getEmojiJson(){emoji.replacex(":", "")}.getStr(default)
    
## Searches the emoji dict for emojis matching the search
proc getEmojiCode*(emoji:string):string =
    for k, v in getEmojiJson().getFields().pairs:
        if emoji == v.getStr:
            return k
            
## Searches string for emoji tokens, such as `:santa:` and swaps in the emoji character
proc emojify*(msg:string):string =
    result = msg
    var emojis = msg.findAll(re":(.+?):")
    for emoji in emojis:
        let e = getEmoji(emoji)
        if e != "":
            result = msg.replace(emoji, e)
    
## Searches string for emoji characters, and swaps in the emoji token, such as `:santa:`   
proc demojify*(msg:string):string =
    result = msg
    for k, v in getEmojiJson().getFields().pairs:
        if v.getStr in result:
            result = msg.replace(v.getStr, ":"&getEmojiCode(v.getStr)&":")
    
## Returns random emoji
proc randomEmoji*():string =
    let j = getEmojiJson().getFields()
    var e:seq[string] = @[]
    for k, v in j.pairs:
        e.add v.getStr()
        
    let l = (e.len-1)
    randomize()
    let num = rand(l)
    return e[num]

## Strips emoji characters out of msg
proc stripEmojis*(msg:string):string =
    result = msg
    for k, v in getEmojiJson().getFields().pairs:
        if v.getStr in result:
            result = msg.replace(v.getStr, "")
    
