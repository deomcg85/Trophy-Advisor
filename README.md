# KoL Trophy Advisor

A [KoL Mafia](https://kolmafia.us/) ASH script that scans your trophy cabinet and tells you which trophies to work toward next, sorted by how much effort they require.

## Features

- Detects which trophies you already own by reading `trophies.php` directly — no external dependency, works on older Mafia builds
- Checks live game state: current fullness/drunkenness/spleen, active effects, equipped items, closet contents, Quest Log notes, and permed skills
- Colour-coded tiers so you can see at a glance what's achievable today vs. long-term
- Optional verbose mode to list owned trophies
- Optional run mode to show ascension planning hints

## Installation

### Via KoL Mafia's built-in SVN manager

If your Mafia install supports SVN scripts, paste this into the Mafia CLI:

```
svn checkout https://github.com/YOUR_USERNAME/YOUR_REPO_NAME/trunk/scripts
```

### Manual install

1. Download `trophy_advisor.ash`
2. Place it in your KoL Mafia `scripts/` folder

## Usage

Open the KoL Mafia CLI (the text box at the bottom of the relay browser or desktop client) and type:

```
ash trophy_advisor.ash
```

### Flags

| Command | Effect |
|---|---|
| `ash trophy_advisor.ash` | Show all missing trophies, sorted by difficulty |
| `ash trophy_advisor.ash verbose` | Also list trophies you already own |
| `ash trophy_advisor.ash run` | Add the ascension planning section |
| `ash trophy_advisor.ash all` | Everything combined |

## Colour Tiers

| Colour | Tag | Meaning |
|---|---|---|
| Gold | READY | Conditions already met — visit the Trophy Hut now |
| Purple | EASY | Achievable today or this session |
| Blue | MODERATE | Needs some planning or setup |
| Green | GRIND | Long-term cumulative progress |
| Dark green | RUN | Requires a specific ascension — shown with `run` flag |
| Slate | SEASONAL | Time-limited (New Year's Day, Crimbo, July 4th) |
| Grey | SKIP | No longer obtainable |

## When to Run It

Best used **aftercore**, after releasing King Ralph from the prism. You can also run it mid-ascension with the `run` flag to plan what to work toward in your current run.

## Notes

- Requires KoL Mafia with `visit_url()` support (any reasonably modern build)
- Recipe discovery counts (food, booze, meatsmithing) cannot be read from ASH — those entries give advice to check your in-game Discoveries tab instead
- Some trophies are state-based and must be purchased while the condition is active — the script flags these clearly
- Trophy #13 does not exist (Jick's triskaidekaphobia)
- Trophy #145 exists but is currently unobtainable
- Trophy #27 (This Lousy Trophy) was only available on June 9, 2005

## Contributing

Pull requests welcome. If a trophy tip is wrong, out of date, or missing, open an issue or PR with the fix.

## Reference

Full trophy list: https://kol.coldfront.net/thekolwiki/index.php/Trophies
