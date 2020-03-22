---
name: Quest
about: Suggest a new quest for the app
title: ''
labels: 'quest suggestion'
assignees: ''
---

# Basic data

> Replace the example data in the column "Data" with your suggestion.

| Field | Data | Description |
| - | :-: | - |
| Question | Lorem ipsum? | The question that the mapper is prompted to answer |
| Tag key | `capacity` | The key of the tag that will be modified with this quest |
| [Overpass Wizard][1] query | ```type:node and amenity:bicycle_parking``` | A query that the objects on the map are matched against |
| [Overpass Turbo][2] link | https://overpass-turbo.eu/s/RO8 | A link to the Overpass Turbo that allows others to easily see the query in action |
| Quest ID | my_new_quest | A `String` is used to reference the quest when storing its "selected" state in `UserDefaults` |

## Icon

> Ideally, provide a vector icon, or a link to one.

# Answers

> Decide for one type of answers and remove the other ones.

## Boolean

The quest can be solved with a simple "Yes/No" answer.

| **Answer** | Tag value |
| - | - |
| Yes | `yes` |
| No | `no` |

## Multiple choice

The quest can be solved by choosing one of these answers.

| **Answer** | Tag value |
| - | - |
| Wall | `wall` |
| Pole | `pole` |
| Ceiling | `ceiling` |

## Numeric

The quest can be solved by entering a number that will be used as the tag's value.

[1]: https://wiki.openstreetmap.org/wiki/Overpass_turbo/Wizard
[2]: https://overpass-turbo.eu/
