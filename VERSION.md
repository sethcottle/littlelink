# LittleLink Version History

## Current Version: v3.12.0

### v3.12.0 - 10/06/2026
- Added a one-click deploy button for ZopDay.

### v3.11.0 - 07/28/2026
- Google icon refresh (2025/2026 redesigns): new buttons for Google, Google Calendar, Google Chat, Google Docs, Google Forms, Gmail, Google Meet, Google Photos, Google Sheets, and Google Slides; updated the Google Drive icon. Added a dedicated `.button-yt-music` class for YouTube Music.
- Accessibility & markup: removed `role="button"` from link buttons, converted the button stack to `<nav aria-label="Links">`, wrapped page content in `<main>`, fixed the canonical tag (was an invalid `<meta>`), removed the obsolete keywords meta, made the favicon path relative, and added `theme-color` metas plus a fill-in Open Graph/Twitter block.
- Performance: preload hints for the three above-the-fold font weights, explicit dimensions and `fetchpriority` on the avatar, and placeholder avatars re-exported at true 128px/256px.
- CSS cleanup: removed the duplicated legacy typography block in `style.css`, implemented the documented `theme-light` class, and simplified `@font-face` to woff2-only (deleting ~1.2 MB of legacy .eot/.svg/.ttf/.woff files).
- Icons: fixed missing `viewBox` on both Bluesky icons (they rendered clipped) and optimized several oversized icons; removed stale unused icons and `google-podcasts.svg` (service discontinued).
- Deployment: moved `.dockerignore` to the repo root so Docker actually applies it, and added `.assetsignore` so Cloudflare deploys stop serving repo metadata like `.git/`.
- CI: the contrast check now catches edits to existing buttons and handles hyphenated class names.
- Removed Kit (Kit.co shut down in May 2026).

### v3.10.0 - 01/27/2026
- Added quick deploy files for Cloudflare & DigitalOcean.

### v3.9.0 - 07/25/2025
- Fixed Unsplash Icon [PR #161](https://github.com/sethcottle/littlelink/pull/161), thanks to [@majal](https://github.com/majal)

### v3.8.0 - 06/29/2025
- Added pre-commit for auto-lint the files before commit them [PR #158](https://github.com/sethcottle/littlelink/pull/158), thanks to [@luclis](https://github.com/luclis).

### v3.7.0 - 4/18/2025
- Added [Meetup](https://www.meetup.com/).

### v3.6.0 - 3/25/2025
- Finally adds Docker support to LittleLink. See [PR #151](https://github.com/sethcottle/littlelink/pull/151), thank you [@lllahaye](https://github.com/lllahaye).
  - Docker support has been a long-standing community request. While I previously closed similar PRs in an effort to keep the LittleLink repo as minimal as possible, several community forks emerged that added Docker support independently. Over the last few weeks I had been reconsidering this stance—this PR arrived at just the right time.
- Updated the brand color for Signal.

### v3.5.0 - 3/10/2025
- Added LittleLink Extended information in `index.html`
- Added `PULL_REQUEST_TEMPLATE.md` to `.github` which is a reflection of [submitting a new brand](https://github.com/sethcottle/littlelink/wiki/Submitting-a-new-brand-to-LittleLink) wiki.

### v3.4.0 - 3/04/2025
- Added Matrix

### v3.3.0 - 03/01/2025
- Updated Facebook Logo
- Updated Messenger Logo
- Updated Messenger Button Color

### v3.2.0 - 2/14/2025
- Added Apple Invites
- Removed Read.cv (service is winding down)

### v3.1.1 - 1/28/2025
- Fixed the alt text for Obsidian (`PR #138` / `@timtjtim`)

### v3.1.0 - 1/20/2025
- Added alternate YouTube button (`PR #138` / `@Omikorin`)
- Fixed `index.html` accessibilty issues (`PR #137` / `@rosahaj`)

### v3.0.2 - 12/20/2024
- Added Obsidian as a brand

### v3.0.1 - 11/13/2024
- Removed Trakt logo from `images/icons` since this now lives in LittleLink Extended
- Favicon update for `privacy.html`

### v3.0.0 - 11/13/2024
A complete modernization of LittleLink focusing on accessibility, maintainability, and more modern web standards.

#### Major Changes
- Complete rebuild of CSS architecture
  - Moved away from Skeleton CSS dependency to custom, purpose-built CSS
  - Improved maintainability with modular CSS structure
  - Enhanced dark mode and auto theming implementation
  - Enhanced `brands.css`

- Accessibility Improvements
  - Improved keyboard navigation throughout
  - Enhanced screen reader compatibility
  - Better focus management and visible focus states
  - Proper ARIA labels and semantic HTML structure

- HTML Modernization
  - Rebuilt `index.html`
  - Rebuilt `privacy.html`
  - Optimized meta tags and SEO structure

#### Developer Experience
- Better documented codebase
- Simplified customization process
- Improved maintainability
- More consistent standards
- Added VERSION.md so you know what version of LittleLink you downloaded

#### Brand Changes
- Updated PayPal button color
- Updated Discord button color
- Updated YouTube button color
- Updated Pinterest button color
- Updated Ko-fi button color and updated their logo
- Updated Medium logo
- Updated WordPress button color
- Moved NGL to LittleLink Extended
- Moved Redbubble to LittleLink Extended
- Moved Revolut to LittleLink Extended
- Moved Trakt to LittleLink Extended
- Moved Untapped to LittleLink Extended
- Moved Upwork to LittleLink Extended

---
For the complete history of changes, please visit:
https://github.com/sethcottle/littlelink/releases
