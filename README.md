## DEPRECATED

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

This repository is no longer supported.

Please consider implementing the quest functionality directly
in the [GoMap!!][2] repository, e. g. as part of [bryceco/GoMap#221](https://github.com/bryceco/GoMap/issues/221).

Pay [OSM-Surveyor](https://github.com/wtimme/OSM-Surveyor) a visit and consider contributing there as well.

Most of the added functionality is available from the Git history as atomic commits, ready to be picked and built upon.

---

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

To automate the signing, this project uses [fastlane match][13].
Fetch the certificates for development with

    % bundle exec fastlane match development

## Screenshots

Screenshots are taken automatically with [fastlane snapshot][14].
To create new screenshots, run

    % bundle exec fastlane snapshot

## App Icon

The app icon is based on the 1024x1024 PNG file in `fastlane/metadata/app_icon.png`.
After changing this "master" app icon,
re-generate the app icons using the
[fastlane plugin "appicon"][15] like so:

    % bundle exec fastlane regenerate_app_icon

## Source code structure

* iOS - Code specific to the iOS app
* Mac - Code specific to the Mac app (old, doesn't build anymore)
* Shared - Shared code (drawing code, OSM data structures, etc)
* Images - Images used for application elements (buttons, etc)
* POI-Icons - Icons used for map elements (POIs, etc)
* presets - The presets database copied from the iD editor
* xliff - Translation files

## External assets

A number of assets used in the app come from other repositories, and should be periodically updated. Because updating these items can be a lengthy process it is performed manually rather than at build time:
- iD presets database (https://github.com/openstreetmap/id-tagging-schema)
- iD presets icons (https://github.com/ideditor/temaki.git, https://github.com/mapbox/maki.git)
- Name suggestion index (https://github.com/osmlab/name-suggestion-index)
- NSI brand imagery (pulled from facebook/twitter/wikipedia)
- WebLate translations (https://hosted.weblate.org/projects/go-map/app)

### How to update external assets

Starting from the `src` directory:
- `(cd presets && update.sh)`				# fetches latest presets.json, etc. files and NSI
- `(cd POI-Icons && update.sh)`			# fetches maki/temaki icons
- `(cd presets && getBrandIcons.py)`		# downloads images from various websites and converts them to png as necessary
- `(cd presets && uploadBrandIcons.sh)`	# uploads imagery to gomaposm.com where they can be downloaded on demand at runtime (password required)
- `(cd xliff && update.sh)`					# downloads latest translations from weblate (password required)

## Continuous integration

### Prerequisite

- Make sure you have _fastlane_ installed. (From a terminal, change to the `src/iOS` directory and run `bundle install`.)
- Since _fastlane_ stores your provisioning profiles and certificates in a Git repository (`MATCH_REPO`), you need to create a new, empty repository if you haven't already. The profiles and certificates are protected by a password (`MATCH_PASSWORD`).
- When creating the Beta locally, _fastlane_ will make sure that your certificates and provisioning profiles are up-to-date.

### How to release a Beta locally

You'll need to obtain the values for the following parameter:

- `MATCH_REPO`: The URL to the Git repository that contains the provisioning profiles/certificates
- `MATCH_PASSWORD`: The password for encrypting/decrypting the provisioning profiles/certificates
- `FASTLANE_TEAM_ID`: The ID of the developer team at developer.apple.com
- `FASTLANE_USER`: The email address that is used to sign in to App Store Connect
- `FASTLANE_ITC_TEAM_ID`: The ID of the team at appstoreconnect.apple.com

In order to release a new Beta to the TestFlight testers, run

    % MATCH_REPO=<GIT_REPOSITORY_URL> \
      MATCH_PASSWORD=<MATCH_PASSWORD> \
      FASTLANE_TEAM_ID=<APPLE_DEVELOPER_TEAM_ID> \
      FASTLANE_USER=<APP_STORE_CONNECT_EMAIL> \
      FASTLANE_ITC_TEAM_ID=<APP_STORE_CONNECT_TEAM_ID> \
      bundle exec fastlane beta

## Formatting

In order to have a consistent code style, please make sure to install
[SwiftFormat][6] and run it on a regular basis. Consider setting up a `pre-commit`
Git hook, as described [here][7].

## Assets

The Go Map!! app icon was created by [@Binnette][5].

## Assets

The icons for the quests were retrieved from
[rugk/streetcomplete-quest-svgs][10] and then converted to PDF using
[CairoSVG][11]:

    % cairosvg $path -o $pdf_path

For details on the license of the icons, please refer to [authors.txt][12]
in the StreetComplete repository.

## Presets and translation

Go Map!! is using iD presets, so you can improve translations [by improving translations of iD presets](https://github.com/openstreetmap/id-tagging-schema).
[1]: https://www.openstreetmap.org
[2]: https://github.com/bryceco/GoMap
[3]: https://itunes.apple.com/app/id592990211
[4]: https://wiki.openstreetmap.org/wiki/StreetComplete/Quests
[5]: https://github.com/Binnette
[6]: https://github.com/nicklockwood/SwiftFormat
[7]: https://github.com/nicklockwood/SwiftFormat#git-pre-commit-hook
[8]: src/iOS/fastlane/README.md
[9]: https://testflight.apple.com/join/v1tyM5yU
[10]: https://github.com/rugk/streetcomplete-quest-svgs
[11]: https://cairosvg.org/
[12]: https://github.com/westnordost/StreetComplete/blob/master/res/authors.txt
[13]: https://docs.fastlane.tools/actions/match/
[14]: https://docs.fastlane.tools/actions/snapshot/
[15]: https://github.com/fastlane-community/fastlane-plugin-appicon
