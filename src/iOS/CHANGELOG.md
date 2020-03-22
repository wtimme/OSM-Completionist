# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
This build contains a preview for the refactoring of the `UploadViewController`.
Please test uploading changes to the OSM server and report in the pull request
if you find any issues.

### Changed
- Preview: Move `UploadViewController` to a dedicated storyboard (bryceco/GoMap#313)

## [1.7.0 (31)] - 2020-03-21
This build has been updated with the latest changes from `bryceco/master`.
### Added
- Add CHANGELOG.md
- Setup fastlane to handle the CHANGELOG.md automatically

## [1.7.0 (30)] - 2020-03-15
This build has been updated with the latest changes from `bryceco/master`.
### Added
- Setup fastlane and Travis CI (bryceco/GoMap#238)

### Fixed
- End of line does not snap to building which is part of a relation (bryceco/GoMap#281)
- Remove empty row from language selection (bryceco/GoMap#294)

## [1.7.0 (29)] - 2020-03-13
This build has been updated with the latest changes from `bryceco/master`.
### Added
- Use green tint color for nodes that represent trees (bryceco/GoMap#277)

### Fixed
- Fix Dark Mode for icons in "POI Type" screen (bryceco/GoMap#289)

## [1.7.0 (28)] - 2020-03-12
### Added
- Add "Join our TestFlight Beta" entry to Settings (bryceco/GoMap#288)
- Preview: "Peek and Pop" for nodes (bryceco/GoMap#223)

## [1.7.0 (27)] - 2020-03-12
### Added
- Use `SFSafariViewController` for websites so that they can be shared (bryceco/GoMap#275)

## [1.7.0 (26)] - 2020-03-11
### Added
- Use circular background for nodes, similar to OpenStreetMap.org (bryceco/GoMap#277)

## [1.7.0 (25)] - 2020-03-11
### Fixed
- Tint the updated icons using the existing `defaultColorForObject:` (bryceco/GoMap#277)

## [1.7.0 (24)] - 2020-03-11
### Fixed
- Fix an issue where the "edit control" at the bottom of the map was not
reacting to taps when the MapRoulette layer was visible

## [1.7.0 (23)] - 2020-03-09
This build still includes the MapRoulette MVP, but has been updated with the
latest changes from `bryceco/master`:
### Fixed
- Fix blurry icons in "POI Type" screen (bryceco/GoMap#283)
- Fix Dark Mode for "Notes" comments (bryceco/GoMap#279)

## [1.7.0 (22)] - 2020-03-07
### Added
- First version of the MapRoulette integration

  You can enable MapRoulette in the "Display" settings under "Overlays".
  Please note that the server's response might take some time, so
  MapRoulette tasks are not displayed immediately.

## [1.7.0 (20)] - 2020-03-05
This build includes the latest changes from bryceco/GoMap's `master` branch.
### Added
- Updated icons
- New help page (use OSM wiki instead of Storyboard-based text)

## [1.6.2 (19)] - 2020-02-26
### Added
- Adds haptic feedback to
  - failed login
  - successful login
  - open location search

### Fixed
- Reverts the update of the presets, which caused issues with the icons
(thanks for reporting, Tobias!)

## [1.6.2 (18)] - 2020-02-26
### Added
- Updated preset JSON files from the `master` of bryceco/GoMap

## [1.6.2 (17)] - 2020-02-17
### Added
- Icons for the quests so that the list is a bit easier to navigate
and nicer to look at

## [1.6.2 (16)] - 2020-02-16
### Added
- Five new quests:
  - Do these toilets require a fee?
  - Is this bicycle parking covered (protected from rain)?
  - What is the type of this bicycle parking?
  - Does this bus stop have a shelter?
  - Do these steps have a handrail?

### Fixed
- Fix negated key-value-quests (e. g. "access != private"), which now also plays
well with objects that _do not have_ the tag at all, as well as a fix for the
"capacity" tag, which used to crash the app when running on the iPhone

## [1.6.2 (14)] - 2020-02-02
### Changed
- Removes the functionality where the app asked the user to leave a review on the App Store (#48)

### Fixed
- Fixes an issue where the comments for notes were not visible (bryceco/GoMap#254)

## [1.6.2 (13)] - 2020-01-21
### Fixed
- Fixes an issue with the Dark Mode and the "Measure Direction" view (#46) that was reported by @tordans. Thanks!

## [1.6.2 (12)] - 2020-01-18
### Added
- Adds a new "advanced" setting for displaying a "FPS" label

## [1.6.2 (11)] - 2020-01-12
### Added
- Adds support for quests with numbers (#39), allowing for an easier fixing of bicycle/motorcycle parking objects that are lacking the "capacity" tag

## [1.6.2 (10)] - 2020-01-12
### Added
- Adds action to quests (#29).

  When tapping on an object on the map that has an active quest, the app will ask the quest's question and allows for the user to select an answer, which will then be applied to the object.

## [1.6.2 (9)] - 2020-01-09
### Added
- Add building:part to preset fields (#32, by @LucasLarson)
- Adds list of quests (#30)

### Fixed
- Fix email address for feedback (#35)

[1.6.2 (9)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-8...builds/beta/1.6.2-9
[1.6.2 (10)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-9...builds/beta/1.6.2-10
[1.6.2 (11)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-10...builds/beta/1.6.2-11
[1.6.2 (12)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-11...builds/beta/1.6.2-12
[1.6.2 (13)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-12...builds/beta/1.6.2-13
[1.6.2 (14)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-13...builds/beta/1.6.2-14
[1.6.2 (16)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-14...builds/beta/1.6.2-16
[1.6.2 (17)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-16...builds/beta/1.6.2-17
[1.6.2 (18)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-17...builds/beta/1.6.2-18
[1.6.2 (19)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-18...builds/beta/1.6.2-19
[1.7.0 (20)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.6.2-19...builds/beta/1.7.0-20
[1.7.0 (22)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-20...builds/beta/1.7.0-22
[1.7.0 (23)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-22...builds/beta/1.7.0-23
[1.7.0 (24)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-23...builds/beta/1.7.0-24
[1.7.0 (25)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-24...builds/beta/1.7.0-25
[1.7.0 (26)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-25...builds/beta/1.7.0-26
[1.7.0 (27)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-26...builds/beta/1.7.0-27
[1.7.0 (28)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-27...builds/beta/1.7.0-28
[1.7.0 (29)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-28...builds/beta/1.7.0-29
[1.7.0 (30)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-29...builds/beta/1.7.0-30
[1.7.0 (31)]: https://github.com/wtimme/OSM-Completionist/compare/builds/beta/1.7.0-30...builds/beta/1.7.0-31
