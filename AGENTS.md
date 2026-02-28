# AGENTS.md

## Cursor Cloud specific instructions

### Overview

`find_dupe_images` is a Ruby CLI gem that finds duplicate images in directory structures by comparing MD5 digests of image pixel data. It uses ImageMagick (`rmagick`) for image processing and `libmagic` (`ruby-filemagic`) for MIME type detection.

### System dependencies

The following system packages must be installed (already present in the VM snapshot):
- `libmagickwand-dev` (for `rmagick` native extension)
- `libmagic-dev` (for `ruby-filemagic` native extension)
- `build-essential` (C compiler for native extensions)
- `ruby`, `ruby-dev` (Ruby 3.2.x runtime)

### Development commands

- **Install deps:** `bundle install` (gems install to `vendor/bundle` via local bundle config)
- **Run tests:** `bundle exec rake spec` (14 RSpec examples)
- **Run CLI:** `bundle exec ruby bin/find_dupe_images <path-to-images>`
- **Interactive console:** `bundle exec rake console`

### Non-obvious caveats

- The gemspec `bundler` and `rake` development dependency version constraints were relaxed from `~> 1.10` / `~> 10.0` to `>= 1.10` / `>= 10.0` to support modern Ruby 3.2 + Bundler 4.x. If these get reverted, `bundle install` will fail.
- The gemspec evaluates `man libmagic` at load time and raises an error if `libmagic` is not installed. This means `bundle install` itself will fail without `libmagic-dev`.
- A `FileMagic` allocator warning (`undefining the allocator of T_DATA class FileMagic`) appears at runtime — this is harmless and comes from the `ruby-filemagic` gem on Ruby 3.2.
- Gems are installed to `vendor/bundle` (configured via `.bundle/config`). This path is gitignored.
- There is no linter configured for this project (no RuboCop or similar).
- Test fixtures (JPEG images) are in `spec/support/images/`.
