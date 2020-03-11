# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.7.0 (24)]
### Fixed
- Fix an issue where the "edit control" at the bottom of the map was not
reacting to taps when the MapRoulette layer was visible

## [1.7.0 (23)]
This build still includes the MapRoulette MVP, but has been updated with the
latest changes from `bryceco/master`:
### Fixed
- Fix blurry icons in "POI Type" screen (#283)
- Fix Dark Mode for "Notes" comments (#279)

## [1.7.0 (22)]
### Added
- First version of the MapRoulette integration

  You can enable MapRoulette in the "Display" settings under "Overlays".
  Please note that the server's response might take some time, so
  MapRoulette tasks are not displayed immediately.

## [1.7.0 (20)]
This build includes the latest changes from bryceco/GoMap's `master` branch.
### Added
- Updated icons
- New help page (use OSM wiki instead of Storyboard-based text)

## [1.6.2 (19)]
### Added
- Adds haptic feedback to
  - failed login
  - successful login
  - open location search

### Fixed
- Reverts the update of the presets, which caused issues with the icons
(thanks for reporting, Tobias!)

## [1.6.2 (18)]
### Added
- Updated preset JSON files from the `master` of bryceco/GoMap

## [1.6.2 (17)]
### Added
- Icons for the quests so that the list is a bit easier to navigate
and nicer to look at

## [1.6.2 (16)]
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

## [1.6.2 (14)]
### Changed
- Removes the functionality where the app asked the user to leave a review on the App Store (#48)

### Fixed
- Fixes an issue where the comments for notes were not visible (bryceco/GoMap#254)

## [1.6.2 (13)]
### Fixed
- Fixes an issue with the Dark Mode and the "Measure Direction" view (#46) that was reported by @tordans. Thanks!

## [1.6.2 (12)]
### Added
- Adds a new "advanced" setting for displaying a "FPS" label

## [1.6.2 (11)]
### Added
- Adds support for quests with numbers (#39), allowing for an easier fixing of bicycle/motorcycle parking objects that are lacking the "capacity" tag

## [1.6.2 (10)]
### Added
- Adds action to quests (#29).

  When tapping on an object on the map that has an active quest, the app will ask the quest's question and allows for the user to select an answer, which will then be applied to the object.

## [1.6.2 (9)]
### Added
- Add building:part to preset fields (#32, by @LucasLarson)
- Adds list of quests (#30)

### Fixed
- Fix email address for feedback (#35)
