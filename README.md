# nimoji
Emoji support for Nim
Gets emoji data from [here](https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json), and saves the json to your home directory.
Concept and design based on [node-emoji](https://github.com/omnidan/node-emoji) with a few of my own ideas thrown in too.

(Not in Nimble package manager yet, as theres another package with the same name, and also I havent worked out how to do nimble things yet, still fairly new at Nim. To use, just download the .nim file and drop it in to the project directory.)

```nim
import nimoji

echo getEmoji "santa"
# 🎅

echo getEmojiCode "🎅"
# santa

echo findEmoji "sant"
# 🎅

echo findEmojis "sa"
# @["♐", "🇸🇦", "🈂️", "🍶", "🎅", "🎒", "🎷", "🎽", "👡", "💆‍♀️", "💆‍♀️", "💆‍♂️", "📡", "😆", "😞", "😥", "🛰️", "🛸", "🥐", "🥗", "🥪", "🦕", "⏳", "⛵"]

echo findEmojiCodes "sa"
# @["sagittarius", "flag-sa", "sa", "sake", "santa", "school_satchel", "saxophone", "running_shirt_with_sash", "sandal", "woman-getting-massage", "massage", "man-getting-massage", "satellite_antenna", "satisfied", "disappointed", "disappointed_relieved", "satellite", "flying_saucer", "croissant", "green_salad", "sandwich", "sauropod", "hourglass_flowing_sand", "sailboat"]

echo emojify "I love :santa:!"
# I love 🎅!

echo demojify "I love 🎅"
# I love :santa:

echo stripEmojis "I love 🎅"
# I love

echo randomEmoji()
# ⏭️
```
