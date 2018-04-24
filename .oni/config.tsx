
import * as React from "/Applications/Oni.app/Contents/Resources/app/node_modules/react"
import * as Oni from "/Applications/Oni.app/Contents/Resources/app/node_modules/oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as
    "oni.loadInitVim": "~/.config/oni/init.vim", // Load user's init.vim
    "oni.useDefaultConfig": false, // Do not load Oni's init.vim

    "ui.colorscheme": "onedark",

    //"oni.useDefaultConfig": true,
    //"oni.bookmarks": ["~/Documents"],
    //"oni.loadInitVim": false,
    "editor.fontSize": "15px",
    "editor.fontFamily": "Iosevka Nerd Font Mono",

    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",

    // Language Servers
    'language.vue.languageServer.command':'vls'
}
