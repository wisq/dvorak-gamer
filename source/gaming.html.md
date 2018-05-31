---
title: Dvorak and Gaming
description: What sort of impact does using Dvorak have on video games?
---

# How does Dvorak affect gaming?

Since [Dvorak changes almost every key](dvorak.html#how-different-is-dvorak), this significantly impacts the keyboard layout of many games.  For example, the W-A-S-D keys are by far the most commonly used keys for movement in video games — yet in Dvorak, these keys would be Comma-A-O-E.

Playing video games as a Dvorak user presents many challenges.  Many games allow their controls to be remapped, but not all of them will allow remapping of all controls, and some will not accept certain non-letter keys like comma.  Many smaller games do not allow remapping at all.

These problems are not exclusive to Dvorak — anyone using a non-standard keyboard layout may have similar troubles.

## Can't you just play in Qwerty?

Playing in Qwerty is indeed an option for many games, and the **only** option for games without remapping.

However, unless a Dvorak user has retained significant Qwerty ability (I have not), they may have difficulty with certain aspects of the game that do involve actual typing of words.  This may include naming or searching for things in-game, chatting with other users, etc.

Even if a game does not involve any typing whatsoever, playing the game in Qwerty means that the user may be unable to e.g. respond to external messages from friends, such as via the Steam in-game overlay.

Furthermore, switching layouts presents its own challenges.  I frequently forget to switch to the correct layout before launching a game, and then find myself unable to play once it starts — often only after waiting through splash screens and long loading times.  Depending on how (and when) the game binds its keys, I may be able to just alt-tab out and change the layout, or I may have to restart the game entirely.

## Can't you switch layouts as needed via a hotkey?

In my experience, changing layouts on the fly tends to create more problems than it solves.

Most games are best played in fullscreen mode, meaning there is no on-screen indicator as to what layout you are in.  Accidentally changing or forgetting to change layouts will result in confusion and may cause unwanted effects in-game, such as character death, or accidentally wasting limited items or resources.

It's also more difficult than it sounds to find a hotkey combination that is easy to press frequently as needed, yet difficult to press accidentally.  Games involve pressing a lot of keys at once, often in combinations that are not immediately obvious.  Each game is different, so a hotkey that works in one may be trouble in another.  Any hotkey is likely to quickly become a habit, making it difficult to change if needed.

Finally, it's just a lot of extra work.  It's generally better to either fully remap a game to Dvorak, or to play it entirely in Qwerty.

## Are any games completely unplayable?

Yes, absolutely.

To be completely unplayable by a Dvorak user (who cannot function effectively in Qwerty), a game must require extensive amounts of typing, interspersed with significant amounts of other activities like movement.  It must also have non-remappable keys, or significant problems with remapping.

Thankfully, the number of such games is very low.  I have personally only encountered a small handful of these games — only one springs to mind — and I have played many hundreds of games since I switched to Dvorak.

Any unplayable games will receive an "F" rating on the index.

## Can developers make games more playable for Dvorak users?

Yes!  There are two key aspects to this:

### In-game typing

If your game involves typing — a social chat system, a "retro" command-line interface, naming your characters or items, etc. — then it's important that those parts of the game respect the keyboard layout the user has selected at the OS level.

If your game only receives logical keys from the OS (i.e. they've already been mapped to the current keyboard layout), then you're done here.  Skip to "[Keybindings](#keybindings)" below.

If your game normally receives raw (unmapped) physical key codes from the keyboard, you'll need to do one of three things:

* Identify the user's keyboard layout and map those raw key codes to logical keys instead.  (This is going to be OS-specific, so you may need to do some research here.)
* Switch to reading logical (mapped) keys when text input is required.
* Offer a "keyboard layout" selector in your in-game options screen, and offer as many layouts as possible.  (Less ideal, but better than nothing.)

It's a pain, sure.  But nobody ever said i18n was easy, and the result will be a smoother experience for all your non-Qwerty users.

### Keybindings

So what about the non-typing parts of your game?  Well, there's two ways to make this easier for non-Qwerty users:

1. Allow all in-game actions to be remapped, and all keyboard keys — at least in the main area, i.e. letters, numbers, **and punctuation** — to be used for remapping.
2. Bind in-game actions to physical keys (not mapped keys), store your keybindings as physical key references, and only convert them to mapped keys when displaying them to the user.

Doing both of these is the Holy Grail of non-Qwerty support.  Your game will support any keyboard layout automatically.  Changing layouts mid-game will not impact gameplay, and will only change what keys are displayed on screen.

Doing either of these alone will still allow Dvorak users to use your game comfortably.  However, if you choose only one of these, do the first one.  Allowing users to customise their interface is more important — and as long as you don't have any awkward restrictions on what keys can be bound, you'll still support all keyboard layouts.  (Trust me, Dvorak users are already very familiar with completely remapping all keys in the games they play!)

It's important to note that item #2 should be treated as a single parcel.  If you bind to physical keys but store them as logical (mapped) keys in your config files, or vice versa, you are actually creating more hassle than if you just ignored physical keys and worked purely with logical keys.

Of course, the reality is, many developers don't get to choose whether they use physical or mapped keys — it's up to what their game engine supports.  But all of the above advice can apply to game engine developers as well.
