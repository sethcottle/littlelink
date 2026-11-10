/*
 * Shared profile for / and /fr/.
 * Edit a link or an icon here and both locales update.
 * Button labels can differ by language. href and icon cannot.
 */
(function () {
  var lang = document.documentElement.lang === "fr" ? "fr" : "en";

  var links = [
    {
      href: "https://github.com/tanguy-fgl",
      icon: "/images/icons/github.svg",
      buttonClass: "button-github",
      label: { en: "GitHub", fr: "GitHub" },
      iconAlt: { en: "GitHub Logo", fr: "Logo GitHub" },
    },
    {
      href: "https://www.linkedin.com/in/tanguy-fgl/",
      icon: "/images/icons/linkedin.svg",
      buttonClass: "button-linked",
      label: { en: "LinkedIn", fr: "LinkedIn" },
      iconAlt: { en: "LinkedIn Logo", fr: "Logo LinkedIn" },
    },
    {
      href: "mailto:tanguyfrageul@gmail.com",
      icon: "/images/icons/generic-email.svg",
      buttonClass: "button-default",
      label: { en: "Email me", fr: "E-mail" },
      iconAlt: { en: "Email Icon", fr: "Icône e-mail" },
    },
    {
      href: "https://tanguy-fgl.me",
      icon: "/images/icons/generic-website.svg",
      buttonClass: "button-default",
      label: { en: "Visit Website", fr: "Visiter mon site" },
      iconAlt: { en: "Website Icon", fr: "Icône du site" },
    },
  ];

  var nav = document.querySelector("[data-links]");
  if (nav) {
    var fragment = document.createDocumentFragment();
    links.forEach(function (link) {
      var anchor = document.createElement("a");
      anchor.className = "button " + link.buttonClass;
      anchor.href = link.href;
      anchor.target = "_blank";
      anchor.rel = "noopener";

      var icon = document.createElement("img");
      icon.className = "icon";
      icon.setAttribute("aria-hidden", "true");
      icon.alt = link.iconAlt[lang];
      icon.src = link.icon;

      anchor.appendChild(icon);
      anchor.appendChild(document.createTextNode(link.label[lang]));
      fragment.appendChild(anchor);
    });
    nav.replaceChildren(fragment);
  }

  document.querySelectorAll("[data-keep-query]").forEach(function (anchor) {
    if (!window.location.search) return;
    var url = new URL(anchor.getAttribute("href"), window.location.href);
    url.search = window.location.search;
    anchor.href = url.pathname + url.search + url.hash;
  });
})();
