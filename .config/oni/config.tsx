import * as React from "/Applications/Oni.app/Contents/Resources/app/node_modules/react";
import * as Oni from "/Applications/Oni.app/Contents/Resources/app/node_modules/oni-api";

export const activate = (oni: Oni.Plugin.Api) => {
  console.log("config activated");

  // Input
  //
  // Add input bindings here:
  //
  oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"));

  //
  // Or remove the default bindings here by uncommenting the below line:
  //
  // oni.input.unbind("<c-p>")
};

export const deactivate = (oni: Oni.Plugin.Api) => {
  console.log("config deactivated");
};

export const configuration = {
  //add custom config here, such as

  "ui.colorscheme": "nord",

  "oni.useDefaultConfig": false,
  //"oni.bookmarks": ["~/Documents"],
  "oni.loadInitVim": "~/.config/oni/init.vim",
  "editor.fontSize": "15px",
  "editor.fontFamily": "Iosevka Nerd Font Mono",

  // UI customizations
  "ui.animations.enabled": true,
  "ui.fontSmoothing": "auto",

  "oni.plugins.prettier": {
    settings: {
      semi: true,
      tabWidth: 2,
      useTabs: false,
      singleQuote: false,
      trailingComma: "es5",
      bracketSpacing: true,
      jsxBracketSameLine: false,
      arrowParens: "avoid",
      printWidth: 80,
    },
    formatOnSave: true,
    enabled: true,
  },
  "language.vue.languageServer.command": "vls",
};
