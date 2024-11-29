<style>
  *,
  ::before,
  ::after {
    box-sizing: border-box;
  }

  :host {
    contain: content;
    display: block;
  }

  :host([hidden]) {
    display: none;
  }

  form {
    background-color: var(--${NAME}-background-color, transparent);
    color: var(--${NAME}-color, inherit);
    padding: 0;
  }

  fieldset {
    border: none;
    margin: 0;
    padding-block: 0.25rem;
    padding-inline: 0.25rem;
  }

  legend {
    font: var(--${NAME}-legend-font, inherit);
    padding: 0;
  }

  input,
  label {
    cursor: pointer;
  }

  label {
    white-space: nowrap;
  }

  input {
    opacity: 0;
    position: absolute;
    pointer-events: none;
  }

  input:focus-visible + label {
    outline: #e59700 auto 2px;
    outline: -webkit-focus-ring-color auto 5px;
  }

  label::before {
    content: "";
    display: inline-block;
    background-size: var(--${NAME}-icon-size, 1rem);
    background-repeat: no-repeat;
    height: var(--${NAME}-icon-size, 1rem);
    width: var(--${NAME}-icon-size, 1rem);
    vertical-align: middle;
  }

  label:not(:empty)::before {
    margin-inline-end: 0.5rem;
  }

  [part="lightLabel"]::before {
    background-image: var(--${NAME}-light-icon, url("${DEFAULT_URL}sun.png"));
  }

  [part="darkLabel"]::before {
    filter: var(--${NAME}-icon-filter, none);
    background-image: var(--${NAME}-dark-icon, url("${DEFAULT_URL}moon.png"));
  }

  [part="toggleLabel"]::before {
    background-image: var(--${NAME}-checkbox-icon, none);
  }

  [part="permanentLabel"]::before {
    background-image: var(--${NAME}-remember-icon-unchecked, url("${DEFAULT_URL}unchecked.svg"));
  }

  [part="lightLabel"],
  [part="darkLabel"],
  [part="toggleLabel"] {
    font: var(--${NAME}-label-font, inherit);
  }

  [part="lightLabel"]:empty,
  [part="darkLabel"]:empty,
  [part="toggleLabel"]:empty {
    font-size: 0;
    padding: 0;
  }

  [part="permanentLabel"] {
    font: var(--${NAME}-remember-font, inherit);
  }

  input:checked + [part="permanentLabel"]::before {
    background-image: var(--${NAME}-remember-icon-checked, url("${DEFAULT_URL}checked.svg"));
  }

  input:checked + [part="darkLabel"],
  input:checked + [part="lightLabel"] {
    background-color: var(--${NAME}-active-mode-background-color, transparent);
  }

  input:checked + [part="darkLabel"]::before,
  input:checked + [part="lightLabel"]::before {
    background-color: var(--${NAME}-active-mode-background-color, transparent);
  }

  input:checked + [part="toggleLabel"]::before {
    filter: var(--${NAME}-icon-filter, none);
  }

  input:checked + [part="toggleLabel"] + aside [part="permanentLabel"]::before {
    filter: var(--${NAME}-remember-filter, invert(100%));
  }

  aside {
    visibility: hidden;
    margin-block-start: 0.15rem;
  }

  [part="lightLabel"]:focus-visible ~ aside,
  [part="darkLabel"]:focus-visible ~ aside,
  [part="toggleLabel"]:focus-visible ~ aside {
    visibility: visible;
    transition: visibility 0s;
  }

  aside [part="permanentLabel"]:empty {
    display: none;
  }

  @media (hover: hover) {
    aside {
      transition: visibility 3s;
    }

    aside:hover {
      visibility: visible;
    }

    [part="lightLabel"]:hover ~ aside,
    [part="darkLabel"]:hover ~ aside,
    [part="toggleLabel"]:hover ~ aside {
      visibility: visible;
      transition: visibility 0s;
    }
  }
</style>
<form part="form">
  <fieldset part="fieldset">
    <legend part="legend"></legend>
    <input part="lightRadio" id="l" name="mode" type="radio">
    <label part="lightLabel" for="l"></label>
    <input part="darkRadio" id="d" name="mode" type="radio">
    <label  part="darkLabel" for="d"></label>
    <input part="toggleCheckbox" id="t" type="checkbox">
    <label part="toggleLabel" for="t"></label>
    <aside part="aside">
      <input part="permanentCheckbox" id="p" type="checkbox">
      <label part="permanentLabel" for="p"></label>
    </aside>
  </fieldset>
</form>
