# Branding of the Beta Nu chapter of Theta Chi

This repo contains all the source code required for generating all the branding releated with the Beta Nu chapter of Theta Chi.

`SVG` `path` `d` attributes are stored in environment variables that will be built into the template SVG file.

Documentation on `d` attributes may be found [here](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/d)

Extraction of the `d` attribute may also be done by extracting an svg then copying the `d` attribute from the file.

## Usage

This repo will be automatically built upon any push with a tag starting with `release-`. Artifacts will be produced as a GitHub release.

A nix flake is also provided with the `#branding` attribute, this is useful for cross-repo-referencing. This is used in the bylaw build process.

## Branding elements

The `src/colors` folder contains color variants for different color schemes for models. All files referenced from the `src/build.py` builder will be built as a variant of the branding.

## Build process

The build process is managed by the `src/build.py` script

1. It iterates over specified color schemes
2. It iterates over logo variants, including the logomark, logo, OX logo, and stacked logomark variants
3. Builds each variant of the specified logo by sourcing the variables and running `envsubst` on the template file
4. Then, uses the `mogrify` command from `imagemagick` to build `.png` versions of all the variants
5. Releases:
    - For the GitHub release, a zip file will be made containing all the variants
    - For the nix flake, all raw files are provided in the `result` folder
    - An additional attribute `.#branding-nopng` is provided for quicker builds
