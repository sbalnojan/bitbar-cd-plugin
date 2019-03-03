# BitBar Death Clock Plugin

This BitBar plugin, called "Death Clock" shows two things in your Mac OS X menu bar:

- the days you have left to live,
- (optionally) the % progress of this quarter.

and on click it additionally shows:

- (optionally) the amount of books you will still be able to read in your life,
- the 4 year projects you can still complete within the days left.

# Take a Look

This is what it looks like

![death clock plugin](pic/demo_pic.jpg "Death Clock")

# Installation

Install https://github.com/matryer/bitbar if you haven't.

Put [DClock.sh](DClock/DClock.sh) into your plugin directory.

Put up your configuration file at ~/.dc_config.cfg in the following format:

```bash
DEATH_DATE_STR="2025-11-07"
BOOKS_A_YEAR=20
```

The BOOKS_A_YEAR is optional.

## Enable Quarter Progress

If you want to additionally show the progress of the current quarter (for instance
because you set yourself OKRs quarter-wise), you can do that by adding this line
to your .dc_config.cfg:

```bash
DEATH_DATE_STR="2025-11-07"
BOOKS_A_YEAR=20
QUARTER_PROGRESS=true
```

where DEATH_DATE_STR denotes your personal death date in %Y-%M-%d format,
and BOOKS_A_YEAR the amount of books you read in a given year.
