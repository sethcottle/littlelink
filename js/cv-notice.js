/*
 * Shown only when the page is opened with ?utm_source=cv.
 * The CV QR code lands here. The notice asks the visitor to inspect
 * that link before trusting the next QR code they scan.
 */
(function () {
  var DELAY_MS = 3000;

  var params = new URLSearchParams(window.location.search);
  if (params.get("utm_source") !== "cv") return;

  var lang = document.documentElement.lang === "fr" ? "fr" : "en";
  var copy = {
    en: {
      title: "Check this QR code",
      body: "Did you think to check the QR code link before scanning it? I could have set up a phishing campaign. Stay alert to the QR codes you scan.",
      close: "Got it",
    },
    fr: {
      title: "Vérifiez ce QR code",
      body: "Avez-vous pensé à vérifier le lien du QR code avant de le scanner ? J'aurais pu organiser une campagne de phishing. Restez attentifs aux QR codes que vous scannez.",
      close: "J'ai compris",
    },
  }[lang];

  var dialog = document.createElement("dialog");
  dialog.className = "cv-notice";
  dialog.tabIndex = -1;
  dialog.setAttribute("aria-labelledby", "cv-notice-title");
  dialog.setAttribute("aria-describedby", "cv-notice-body");

  var title = document.createElement("h2");
  title.id = "cv-notice-title";
  title.className = "cv-notice__title";
  title.textContent = copy.title;

  var body = document.createElement("p");
  body.id = "cv-notice-body";
  body.textContent = copy.body;

  var close = document.createElement("button");
  close.type = "button";
  close.className = "button button-default cv-notice__close";
  close.textContent = copy.close;
  close.addEventListener("click", function () {
    dialog.close();
  });

  dialog.append(title, body, close);
  document.body.appendChild(dialog);

  window.setTimeout(function () {
    if (!dialog.isConnected || dialog.open) return;
    dialog.showModal();
    dialog.focus();
  }, DELAY_MS);
})();
