![Logo](https://cdn.cottle.cloud/littlelink/littlelink.gif)

# LittleLink

This is my fork of [LittleLink](https://github.com/sethcottle/littlelink), but with my links - fork the original if you want to have your own ;-)


## Getting Started with LittleLink

This page has been built with every pre-designed button available in LittleLink by default. You can rearrange and delete as needed.

You can add your own brand or others brands you may need in the `css/brands.css` file. 

You can add custom icons to `images/icons/...`. It is recommended to use a 24x24 .SVG.

Edit the "Your Image Here" section to add your own personal branding, like a picture of yourself or your brand logo!

Edit the "Title" section to change the page heading. You can use something like your name, your social handle, or your brand name.

Edit the "Short Bio" section tell users about yourself or your brand.

## Breaking down `<a>` attributes:

1.) class="button button-default" | The first "button" here is telling this <a> tag that it should make this element a button and applies the default styling in `css/brands.css`.
The second portion, button-default, is declaring the specific brand style you would like to apply. Here we're applying the "default" style and color.
If you want to make this button to use the brand colors for Discord, just change "button-default" to "button-discord". Brands are found in `css/brands.css`. You can always edit & add your own there.

2.) Replace the # in href="#" with the desired target URL for the button.

3.) target="_blank" | This attribute opens links in a new tab. Remove this attribute to prevent links from opening in a new tab.

4.) rel="noopener" | This attribute instructs the browser to navigate to the target resource without granting the new browsing context access to the document that opened it.
This is especially useful when opening untrusted links. https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/noopener

5.) role="button" | The button role identifies an element as a button to assistive technology such as screen readers.

## Breaking down the `<img>` attributes:

1.) class="icon" | This class is telling the <img> tag that it should use the styling for icons found in `css/brands.css`.

2.) src="images/icons/[icon-name].svg" | This defines the icon you would like to display from the 'images/icons/' folder. For example, you can change this to src="images/icons/discord.svg" to use the Discord icon.
Add your own 24x24 icons to the "icons" folder to reference them. We recommend providing a SVG.

3.) alt="" | Since the text at the end of the snippet, "..>[Button Text]</a><br>", explains what the button is, we use "alt=""" to nullify the icon annoucement from the accessibility tree. 
This can improve the experience for assistive technology users by hiding what is essentially duplicated

    
