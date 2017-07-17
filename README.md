# dvorak-gamer

The source code and database for <a href="https://dvorakgamer.com" target="_blank">DvorakGamer.com</a>.

## The database

All data is found in YAML files within the [data](data) directory.  Games are in `games.yml`, and each tested version is given a rating from `rating.yml` and an OS from `os.yml`.

New OSes and ratings can be added as needed.  In particular, if a game has specific quirks that Dvorak gamers ought to know, I am perfectly okay with creating a brand new rating just for that one game.

## Local development

If you want to run the website locally:

1. Install Ruby — ideally 2.3 or higher, but any 2.x will probably work.
2. Install bundler: `gem install bundler`.
3. Change to the project directory and run `bundle install`.
4. Run `bundle exec middleman server`.

You'll now have the site running on localhost, port 4567.

## Contributing

If you want to contribute, you have one of two options:

1. Create a GitHub issue (or contribute details to an existing one);
2. Fork the repository, edit the YAML files directly, and submit a pull request.

The latter is for programmers like myself who are already familiar with how git, GitHub, and YAML work.  It's more work for you, but less work for me, and that may help get your changes in the index faster.

In either case, remember that I'm going to want details about what you tried and what the results were.  I'm pretty thorough with how I rate these games, and it's not just enough to say "you can remap everything so it gets B" or "it automatically worked with Dvorak so it gets A".  Unless you've been equally meticulous, there's probably going to be some back and forth discussion, and I may end up giving it a different rating than you expect.

Here's a list of some of the things I'm going to want to know:

* Before remapping anything, did you start the game in Dvorak?
  * Did it correctly remap all keys to make sense on Dvorak?
* What happens if you change your layout while the game is running?  Do the same keys continue to work (binds to physical), or are they scattered all over the keyboard now (binds to logical)?
  * If physical: What happens if you start the game in layout A (so it binds to the correct keys), then change keyboard layout to B, then continue playing the game?  Do any actions ever stop working?
* If you start the game with the "wrong" layout, get into the game and discover your keys are unplayable, and then change to the "right" layout, is the game now playable?
* Have you played the game in Dvorak (or another layout highly different from Qwerty)?  Are there any actions that are hardcoded / non-remappable?
* Have you tried remapping to punctuation keys like period, comma, etc.?
* Have you finished the game?  This isn't 100% necessary, but it does help indicate there aren't any layout-related quirks further down the line.

Also, remember that the rating is purely about how Dvorak-friendly a game is, and has absolutely nothing to do with how good or bad it is.  Some of my favourite games have (or would be given) some pretty mediocre or even awful ratings, and vice versa.  This isn't a review site or a popularity contest.

## Acknowledgements

Icons for operating systems and for Wikipedia are taken from the Wikimedia Commons:

* [Wikipedia logo](https://commons.wikimedia.org/wiki/File:Wikipedia-logo-v2.svg) (license: CC-SA)
* [Apple logo](https://commons.wikimedia.org/wiki/File:Apple_logo_black.svg) (public domain)
* [Windows logo](https://commons.wikimedia.org/wiki/File:Windows_logo_-_2012.svg) (public domain)

The keyboard header image was made in Blender, based on a [model by davyzhang](https://www.blendswap.com/blends/view/42899) but with the keys remapped to Dvorak.  The license is CC-BY, and as fan art, it cannot be used for commercial purposes.
