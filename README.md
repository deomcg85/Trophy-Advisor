# KoL Trophy Advisor

A [KoL Mafia](https://kolmafia.us/) ASH script that scans your trophy cabinet and tells you which trophies to work toward next, sorted by how much effort they require.

Best run **aftercore**, after releasing King Ralph from the prism.

## Installation

### Manual

1. Download `trophy_advisor.ash`
2. Place it in your KoL Mafia `scripts/` folder

### SVN

Paste into the KoL Mafia CLI:

```
svn checkout https://github.com/YOUR_USERNAME/kol-trophy-advisor/trunk/scripts
```

## Usage

Open the KoL Mafia CLI and type:

```
ash trophy_advisor.ash
ash trophy_advisor.ash verbose
ash trophy_advisor.ash all
```

| Flag | Effect |
|---|---|
| *(none)* | Show all missing trophies sorted by difficulty |
| `verbose` | Also list trophies you already own |
| `all` | Everything combined |

## Colour Tiers

| Colour | Tag | Meaning |
|---|---|---|
| Gold | READY | Conditions already met — visit the Trophy Hut now |
| Purple | EASY | Achievable today or this session |
| Blue | MODERATE | Needs some planning or setup |
| Green | GRIND | Long-term cumulative progress |
| Slate | SEASONAL | Time-limited (New Year's Day, Crimbo, July 4th, etc.) |
| Grey | SKIP | No longer obtainable |

## How It Works

Trophy detection works by fetching `trophies.php` directly and checking for each trophy's image filename — no `have_trophy()` dependency, so it runs on older Mafia builds. Live game state is also checked where relevant: fullness, drunkenness, spleen, active effects, equipped gear, closet contents, Quest Log notes, and permed skills.

Recipe discovery counts (food, booze, meatsmithing) cannot be read from ASH — those entries advise you to check your in-game Discoveries tab instead.

## Notes

- Trophy #13 does not exist (Jick's triskaidekaphobia)
- Trophy #145 exists but is currently unobtainable
- Trophy #27 (This Lousy Trophy) was only available on June 9, 2005
- State-based trophies must be purchased while the condition is still active — the script flags these clearly

## Reference

Full trophy list: https://kol.coldfront.net/thekolwiki/index.php/Trophies
