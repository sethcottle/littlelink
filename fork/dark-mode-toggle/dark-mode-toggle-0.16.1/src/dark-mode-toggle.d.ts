/**
 * Reflects the user’s desire that the page use a light or dark color theme.
 */
export type ColorScheme = 'light' | 'dark';

export class DarkModeToggle extends HTMLElement {
  /**
   * The user's preferred color scheme.
   */
  mode: ColorScheme;

  /**
   * The "switch" appearance conveys the idea of a theme switcher (light/dark),
   * whereas "toggle" conveys the idea of a dark mode toggle (on/off).
   * The "three-way" option will feature a central state that aligns with the user's system preferred color mode, while both the left and right states will consistently apply a fixed color scheme, irrespective of the system settings.
   */
  appearance: 'toggle' | 'switch' | 'three-way';

  /**
   * If true, remember the last selected mode ("dark" or "light"),
   * which allows the user to permanently override their usual preferred color scheme.
   */
  permanent: boolean;

  /**
   * Any string value that represents the legend for the toggle or switch.
   */
  legend: string;

  /**
   * Any string value that represents the label for the "light" mode.
   */
  light: string;

  /**
   * Any string value that represents the label for the "dark" mode.
   */
  dark: string;

  /**
   * Any string value that represents the label for the
   * "remember the last selected mode" functionality.
   */
  remember: string;
}

/**
 * Fired when the color scheme gets changed.
 */
export type ColorSchemeChangeEvent = CustomEvent<{ colorScheme: ColorScheme }>;

/**
 * Fired when the color scheme should be permanently remembered or not.
 */
export type PermanentColorSchemeEvent = CustomEvent<{ permanent: boolean }>;

declare global {
  interface HTMLElementTagNameMap {
    'dark-mode-toggle': DarkModeToggle;
  }

  interface GlobalEventHandlersEventMap {
    colorschemechange: ColorSchemeChangeEvent;
    permanentcolorscheme: PermanentColorSchemeEvent;
  }
}
