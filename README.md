
# OSM Completionist

OSM Completionist is an iOS companion app that allows [OpenStreetMap][1]
contributors to complete missing information for objects around them.

Instead of advanced editing possibilities, OSM Completionist uses the concept
of "quests", analog to [StreetComplete for Android][4].

## Based on GoMap!!

This repository is a fork of [GoMap!!][2], a comprehensive OpenStreetMap editor
for iPhone/iPad.

If you're looking for **a full OpenStreetMap editor**,
[download GoMap on the App Store][3].

# Continuous delivery

## Signing

To automate the signing, this project uses [fastlane match][5].
Fetch the certificates for development with

    % bundle exec fastlane match development

## Source code structure

* iOS - Code specific to the iOS app
* Mac - Code specific to the Mac app (old, doesn't build anymore)
* Shared - Shared code (drawing code, OSM data structures, etc)
* Images - Images used for application elements (buttons, etc)
* png/poi/Maki/iD SVG POI - Icons used for map elements (POIs, etc)
* presets - The presets database copied from the iD editor

[1]: https://www.openstreetmap.org
[2]: https://github.com/bryceco/GoMap
[3]: https://itunes.apple.com/app/id592990211
[4]: https://wiki.openstreetmap.org/wiki/StreetComplete/Quests
[5]: https://docs.fastlane.tools/actions/match/
