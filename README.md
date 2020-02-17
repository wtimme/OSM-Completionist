
# OSM Completionist

OSM Completionist is an iOS companion app that allows [OpenStreetMap][1]
contributors to complete missing information for objects around them.

Instead of advanced editing possibilities, OSM Completionist uses the concept
of "quests", analog to [StreetComplete for Android][4].

## Based on GoMap

This repository is a fork of [GoMap!!][2], a comprehensive OpenStreetMap editor
for iPhone/iPad.

If you're looking for **a full OpenStreetMap editor**,
[download GoMap on the App Store][3].

# Join our TestFlight beta!

Do you want to help testing pre-releases of OSM Completionist?
[Become a TestFlight tester][9] today! 🚀

# Continuous delivery

OSM Completionist makes use of fastlane.
For a list of available actions, please refer to [the auto-generated README][8].

## Signing

To automate the signing, this project uses [fastlane match][5].
Fetch the certificates for development with

    % bundle exec fastlane match development

## Screenshots

Screenshots are taken automatically with [fastlane snapshot][6].
To create new screenshots, run

    % bundle exec fastlane snapshot

## App Icon

The app icon is based on the 1024x1024 PNG file in `fastlane/metadata/app_icon.png`.
After changing this "master" app icon,
re-generate the app icons using the
[fastlane plugin "appicon"][7] like so:

    % bundle exec fastlane regenerate_app_icon

## Source code structure

* iOS - Code specific to the iOS app
* Mac - Code specific to the Mac app (old, doesn't build anymore)
* Shared - Shared code (drawing code, OSM data structures, etc)
* Images - Images used for application elements (buttons, etc)
* png/poi/Maki/iD SVG POI - Icons used for map elements (POIs, etc)
* presets - The presets database copied from the iD editor

## Assets

The icons for the quests were retrieved from
[rugk/streetcomplete-quest-svgs][10] and then converted to PDF using
[CairoSVG][11]:

    % cairosvg $path -o $pdf_path

For details on the license of the icons, please refer to [authors.txt][12]
in the StreetComplete repository.

[1]: https://www.openstreetmap.org
[2]: https://github.com/bryceco/GoMap
[3]: https://itunes.apple.com/app/id592990211
[4]: https://wiki.openstreetmap.org/wiki/StreetComplete/Quests
[5]: https://docs.fastlane.tools/actions/match/
[6]: https://docs.fastlane.tools/actions/snapshot/
[7]: https://github.com/fastlane-community/fastlane-plugin-appicon
[8]: src/iOS/fastlane/README.md
[9]: https://testflight.apple.com/join/v1tyM5yU
[10]: https://github.com/rugk/streetcomplete-quest-svgs
[11]: https://cairosvg.org/
[12]: https://github.com/westnordost/StreetComplete/blob/master/res/authors.txt
