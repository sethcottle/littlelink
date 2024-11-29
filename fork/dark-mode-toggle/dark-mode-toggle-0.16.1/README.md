# `<dark-mode-toggle>` Element

[![Published on webcomponents.org](https://img.shields.io/badge/webcomponents.org-published-blue.svg)](https://www.webcomponents.org/element/dark-mode-toggle)

A custom element that allows you to easily put a _Dark Mode 🌒_ toggle or switch
on your site, so you can initially adhere to your users' preferences according
to
[`prefers-color-scheme`](https://drafts.csswg.org/mediaqueries-5/#prefers-color-scheme),
but also allow them to (optionally permanently) override their system setting
for just your site.

📚 Read all(!) about dark mode in the related article
[Hello Darkness, My Old Friend](https://web.dev/prefers-color-scheme/).

## Installation

Install from npm:

```bash
npm install --save dark-mode-toggle
```

Or, alternatively, use a `<script type="module">` tag (served from unpkg's CDN):

```html
<script type="module" src="https://unpkg.com/dark-mode-toggle"></script>
```

![Dark mode toggle live coding sample.](https://user-images.githubusercontent.com/145676/94532333-0466b580-023e-11eb-947e-f73044a7cd63.gif)

(See the [original HD version](https://youtu.be/qfsvoPhx-bE) so you can pause.)

## Usage

There are two ways how you can use `<dark-mode-toggle>`:

### ① Using different stylesheets per color scheme that are conditionally loaded

The custom element assumes that you have organized your CSS in different files
that you load conditionally based on the **`media`** attribute in the
stylesheet's corresponding `link` element. This is a great performance pattern,
as you don't force people to download CSS that they don't need based on their
current theme preference, yet non-matching stylesheets still get loaded, but
don't compete for bandwidth in the critical rendering path. You can also have
more than one file per theme. The example below illustrates the principle.

<!--
```
<custom-element-demo>
  <template>
    <link rel="stylesheet" href="https://googlechromelabs.github.io/dark-mode-toggle/demo/common.css">
    <link rel="stylesheet" href="https://googlechromelabs.github.io/dark-mode-toggle/demo/light.css" media="(prefers-color-scheme: light)">
    <link rel="stylesheet" href="https://googlechromelabs.github.io/dark-mode-toggle/demo/dark.css" media="(prefers-color-scheme: dark)">
    <script type="module" src="https://googlechromelabs.github.io/dark-mode-toggle/src/dark-mode-toggle.mjs"></script>
    <style>
      #dark-mode-toggle-1 {
        --dark-mode-toggle-dark-icon: url("https://googlechromelabs.github.io/dark-mode-toggle/demo/moon.png");
        --dark-mode-toggle-light-icon: url("https://googlechromelabs.github.io/dark-mode-toggle/demo/sun.png");
        --dark-mode-toggle-remember-icon-checked: url("https://googlechromelabs.github.io/dark-mode-toggle/demo/checked.svg");
        --dark-mode-toggle-remember-icon-unchecked: url("https://googlechromelabs.github.io/dark-mode-toggle/demo/unchecked.svg");
        --dark-mode-toggle-remember-font: 0.75rem 'Helvetica';
        --dark-mode-toggle-legend-font: bold 0.85rem 'Helvetica';
        --dark-mode-toggle-label-font: 0.85rem 'Helvetica';
        --dark-mode-toggle-color: var(--text-color);
        --dark-mode-toggle-background-color: none;
        --dark-mode-toggle-active-mode-background-color: var(--accent-color);
        --dark-mode-toggle-remember-filter: invert(100%);
      }
    </style>
    <next-code-block></next-code-block>
  </template>
</custom-element-demo>
```
-->

```html
<head>
  <link rel="stylesheet" href="common.css" />
  <link
    rel="stylesheet"
    href="light.css"
    media="(prefers-color-scheme: light)"
  />
  <link rel="stylesheet" href="dark.css" media="(prefers-color-scheme: dark)" />
  <script
    type="module"
    src="https://googlechromelabs.github.io/dark-mode-toggle/src/dark-mode-toggle.mjs"
  ></script>
</head>
<!-- ... -->
<main>
  <h1>Hi there</h1>
  <img
    src="https://googlechromelabs.github.io/dark-mode-toggle/demo/cat.jpg"
    alt="Sitting cat in front of a tree"
    width="320"
    height="195"
  />
  <p>Check out the dark mode toggle in the upper right corner!</p>
</main>
<aside>
  <dark-mode-toggle
    id="dark-mode-toggle-1"
    legend="Theme Switcher"
    appearance="switch"
    dark="Dark"
    light="Light"
    remember="Remember this"
  ></dark-mode-toggle>
</aside>
```

The above method might cause flashing
([#77](https://github.com/GoogleChromeLabs/dark-mode-toggle/issues/77)) when the
page loads, as the dark mode toggle module is loaded after the page is rendered.
A loader script can be used to apply the saved theme before the page is
rendered. Wrap the stylesheet tags with
`<noscript id="dark-mode-toggle-stylesheets">...</noscript>` and add the loader
script as follows:

```html
<head>
  <link rel="stylesheet" href="common.css" />
  <noscript id="dark-mode-toggle-stylesheets">
    <link
      rel="stylesheet"
      href="light.css"
      media="(prefers-color-scheme: light)"
    />
    <link
      rel="stylesheet"
      href="dark.css"
      media="(prefers-color-scheme: dark)"
    />
  </noscript>
  <script src="https://googlechromelabs.github.io/dark-mode-toggle/src/dark-mode-toggle-stylesheets-loader.js"></script>
  <script
    type="module"
    src="https://googlechromelabs.github.io/dark-mode-toggle/src/dark-mode-toggle.mjs"
  ></script>
</head>
<!-- ... -->
```

### ② Using a CSS class that you toggle

If you prefer to not split your CSS in different files based on the color
scheme, you can instead work with a class that you toggle, for example
`class="dark"`. You can see this in action in
[this demo](https://dark-mode-class-toggle.glitch.me/).

```js
import * as DarkModeToggle from 'https://googlechromelabs.github.io/dark-mode-toggle/src/dark-mode-toggle.mjs';

const toggle = document.querySelector('dark-mode-toggle');
const body = document.body;

// Set or remove the `dark` class the first time.
toggle.mode === 'dark'
  ? body.classList.add('dark')
  : body.classList.remove('dark');

// Listen for toggle changes (which includes `prefers-color-scheme` changes)
// and toggle the `dark` class accordingly.
toggle.addEventListener('colorschemechange', () => {
  body.classList.toggle('dark', toggle.mode === 'dark');
});
```

## Demo

See the custom element in action in the
[interactive demo](https://googlechromelabs.github.io/dark-mode-toggle/demo/index.html).
It shows four different kinds of synchronized `<dark-mode-toggle>`s. If you use
Chrome on an Android device, pay attention to the address bar's theme color, and
also note how the favicon changes.

<img src="https://user-images.githubusercontent.com/145676/59537453-ec5b0d80-8ef6-11e9-9efb-c44ed9db24b6.png" width="400" alt="Dark">
<img src="https://user-images.githubusercontent.com/145676/59537454-ec5b0d80-8ef6-11e9-8a89-5e3fbda9c15c.png" width="400" alt="Light">

## Properties

Properties can be set directly on the custom element at creation time, or
dynamically via JavaScript.

👉 Note that the dark and light **icons** are set via CSS variables, see
[Style Customization](#style-customization) below.

| Name         | Required | Values                          | Default                                                                                                                                                            | Description                                                                                                                                            |
| ------------ | -------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `mode`       | No       | Any of `"dark"` or `"light"`    | Defaults to whatever the user's preferred color scheme is according to `prefers-color-scheme`, or `"light"` if the user's browser doesn't support the media query. | If set overrides the user's preferred color scheme.                                                                                                    |
| `appearance` | No       | Any of `"toggle"` or `"switch"` | Defaults to `"toggle"`.                                                                                                                                            | The `"switch"` appearance conveys the idea of a theme switcher (light/dark), whereas `"toggle"` conveys the idea of a dark mode toggle (on/off).       |
| `permanent`  | No       | `true` if present               | Defaults to not remember the last choice.                                                                                                                          | If present remembers the last selected mode (`"dark"` or `"light"`), which allows the user to permanently override their usual preferred color scheme. |
| `legend`     | No       | Any string                      | Defaults to no legend.                                                                                                                                             | Any string value that represents the legend for the toggle or switch.                                                                                  |
| `light`      | No       | Any string                      | Defaults to no label.                                                                                                                                              | Any string value that represents the label for the `"light"` mode.                                                                                     |
| `dark`       | No       | Any string                      | Defaults to no label.                                                                                                                                              | Any string value that represents the label for the `"dark"` mode.                                                                                      |
| `remember`   | No       | Any string                      | Defaults to no label.                                                                                                                                              | Any string value that represents the label for the "remember the last selected mode" functionality.                                                    |

## Events

- `colorschemechange`: Fired when the color scheme gets changed.
- `permanentcolorscheme`: Fired when the color scheme should be permanently
  remembered or not.

## Complete Example

Interacting with the custom element:

```js
/* On the page */
const darkModeToggle = document.querySelector('dark-mode-toggle');

// Set the mode to dark
darkModeToggle.mode = 'dark';
// Set the mode to light
darkModeToggle.mode = 'light';

// Set the legend to "Dark Mode"
darkModeToggle.legend = 'Dark Mode';
// Set the light label to "off"
darkModeToggle.light = 'off';
// Set the dark label to "on"
darkModeToggle.dark = 'on';

// Set the appearance to resemble a switch (theme: light/dark)
darkModeToggle.appearance = 'switch';
// Set the appearance to resemble a toggle (dark mode: on/off)
darkModeToggle.appearance = 'toggle';

// Set a "remember the last selected mode" label
darkModeToggle.remember = 'Remember this';

// Remember the user's last color scheme choice
darkModeToggle.setAttribute('permanent', '');
// Forget the user's last color scheme choice
darkModeToggle.removeAttribute('permanent');
```

Reacting on color scheme changes:

```js
/* On the page */
document.addEventListener('colorschemechange', (e) => {
  console.log(`Color scheme changed to ${e.detail.colorScheme}.`);
});
```

Reacting on "remember the last selected mode" functionality changes:

```js
/* On the page */
document.addEventListener('permanentcolorscheme', (e) => {
  console.log(
    `${e.detail.permanent ? 'R' : 'Not r'}emembering the last selected mode.`,
  );
});
```

## Style Customization

You can style the custom element with
[`::part()`](https://developer.mozilla.org/en-US/docs/Web/CSS/::part). See the
demo's
[CSS source code](https://github.com/GoogleChromeLabs/dark-mode-toggle/blob/master/demo/common.css)
for some concrete examples. The exposed parts and their names can be seen below:

```html
<form part="form">
  <fieldset part="fieldset">
    <legend part="legend"></legend>
    <input part="lightRadio" id="l" name="mode" type="radio" />
    <label part="lightLabel" for="l"></label>
    <input part="darkRadio" id="d" name="mode" type="radio" />
    <label part="darkLabel" for="d"></label>
    <input part="toggleCheckbox" id="t" type="checkbox" />
    <label part="toggleLabel" for="t"></label>
    <aside part="aside">
      <input part="permanentCheckbox" id="p" type="checkbox" />
      <label part="permanentLabel" for="p"></label>
    </aside>
  </fieldset>
</form>
```

Additionally, you can use a number of exposed CSS variables, as listed in the
following:

| CSS Variable Name                                 | Default                                | Description                                                                                                                                                              |
| ------------------------------------------------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--dark-mode-toggle-light-icon`                   | No icon                                | The icon for the light state in `background-image:` notation.                                                                                                            |
| `--dark-mode-toggle-dark-icon`                    | No icon                                | The icon for the dark state in `background-image:` notation.                                                                                                             |
| `--dark-mode-toggle-icon-size`                    | 1rem                                   | The icon size in CSS length data type notation.                                                                                                                          |
| `--dark-mode-toggle-remember-icon-checked`        | No icon                                | The icon for the checked "remember the last selected mode" functionality in `background-image:` notation.                                                                |
| `--dark-mode-toggle-remember-icon-unchecked`      | No icon                                | The icon for the unchecked "remember the last selected mode" functionality in `background-image:` notation.                                                              |
| `--dark-mode-toggle-color`                        | User-Agent stylesheet text color       | The main text color in `color:` notation.                                                                                                                                |
| `--dark-mode-toggle-background-color`             | User-Agent stylesheet background color | The main background color in `background-color:` notation.                                                                                                               |
| `--dark-mode-toggle-legend-font`                  | User-Agent `<legend>` font             | The font of the legend in shorthand `font:` notation.                                                                                                                    |
| `--dark-mode-toggle-label-font`                   | User-Agent `<label>` font              | The font of the labels in shorthand `font:` notation.                                                                                                                    |
| `--dark-mode-toggle-remember-font`                | User-Agent `<label>` font              | The font of the "remember the last selected mode" functionality label in shorthand `font:` notation.                                                                     |
| `--dark-mode-toggle-icon-filter`                  | No filter                              | The filter for the dark icon (so you can use all black or all white icons and just invert one of them) in `filter:` notation.                                            |
| `--dark-mode-toggle-remember-filter`              | No filter                              | The filter for the "remember the last selected mode" functionality icon (so you can use all black or all white icons and just invert one of them) in `filter:` notation. |
| `--dark-mode-toggle-active-mode-background-color` | No background color                    | The background color for the currently active mode in `background-color:` notation.                                                                                      |

## Hacking on `<dark-mode-toggle>`

The core custom element code lives in
[`src/dark-mode-toggle.mjs`](https://github.com/GoogleChromeLabs/dark-mode-toggle/blob/master/src/dark-mode-toggle.mjs).
You can start hacking and testing your changes by running `npm run start` and
then navigating to <http://localhost:8080/demo/>. No build step required 🎉,
this happens automatically upon `npm publish`ing. If for whatever reason you
want to build locally, run `npm run build`. You can lint by running
`npm run lint`.

The HTML and the CSS used by `<dark-mode-toggle>` is hard-coded as a template
literal in the file `src/dark-mode-toggle.mjs`. For optimal performance, the
contents of this literal are hand-minified. If you need to tweak the HTML or the
CSS, find the unminified template literal contents in
`src/template-contents.tpl` and copy them over to `src/dark-mode-toggle.mjs`.
Once your changes are done, commit them to both the `*.tpl` file (in unminified
form) and the `*.mjs` file (in minified form).

(This is actually just making a strong argument for
[CSS Modules](https://github.com/w3c/webcomponents/issues/759) and
[HTML Modules](https://github.com/w3c/webcomponents/issues/645) that would allow
for proper tools integration).

## Proudly used on…

- [**v8.dev**](https://v8.dev/): V8 is Google’s open source high-performance
  JavaScript and WebAssembly engine, written in C++.

  ![v8.dev in light mode](https://user-images.githubusercontent.com/145676/66128744-c913b580-e5ee-11e9-8c44-e2ca1d24dacb.png)

  ![v8.dev in dark mode](https://user-images.githubusercontent.com/145676/66128803-ea74a180-e5ee-11e9-8792-c411a54346fc.png)

- Your site here…

## Notes

This is not an official Google product.

## Acknowledgements

Thanks to all
[contributors](https://github.com/GoogleChromeLabs/dark-mode-toggle/graphs/contributors)
for making `<dark-mode-toggle>` even better! Usage video by
[Tomek Sułkowski](https://twitter.com/sulco).

## License

Copyright 2019 Google LLC

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
