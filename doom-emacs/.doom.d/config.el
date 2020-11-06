;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; [[file:config.org::*Personal Information][Personal Information:1]]
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alan Flood"
      user-mail-address "alanwflood.tech@gmail.com")
;; Personal Information:1 ends here

;; [[file:config.org::*Simple settings][Simple settings:1]]
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

;; (display-time-mode 1)                             ; Enable time in the mode-line
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                       ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words
;; Simple settings:1 ends here

;; [[file:config.org::*Windows][Windows:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below t)
;; Windows:1 ends here

;; [[file:config.org::*Theme and modeline][Theme and modeline:3]]
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)
;; Theme and modeline:3 ends here

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Iosevka" :size 18 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(lsp-treemacs-sync-mode 1)

(after! lsp-mode
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-headerline-breadcrumb-segments '(symbols)))

(after! lsp-ui
  (setq lsp-ui-sideline-show-hover t
        lsp-ui-sideline-delay 1))

;; Easier window navigation
(map! :map general-override-mode-map
      :nvim "C-h"  #'evil-window-left
      :nvim "C-j"  #'evil-window-down
      :nvim "C-k"  #'evil-window-up
      :nvim "C-l"  #'evil-window-right)

(map! :leader (:prefix ("r" . "eradio") :desc "Play a radio channel" "p" 'eradio-play))
(map! :leader (:prefix ("r" . "eradio") :desc "Stop the radio player" "s" 'eradio-stop))

(setq eradio-channels '(
        ("Lofi hip hop radio - Beats to relax/study to" . "https://www.youtube.com/watch?v=5qap5aO4i9A")
        ("Lofi hip hop radio - Beats to sleep/chill to" . "https://www.youtube.com/watch?v=DWcJFNfaw9c")
        ("Lofi hip hop radio - Sad & sleepy beats" . "https://www.youtube.com/watch?v=l7TxwBhtTUY")
        ("/g/punk Radio" . "http://cyberadio.pw:8000/stream")
        ("Plaza One" . "http://radio.plaza.one/ogg")
        ("Chiru.no" . "https://chiru.no:8081/stream.ogg")
        ("Bluemars - Echos of Bluemars" . "http://streams.echoesofbluemars.org:8000/bluemars.m3u")
        ("Cryosleep - Echos of Bluemars" . "http://streams.echoesofbluemars.org:8000/cryosleep.m3u")
        ("Cafe - Lainon"     . "https://lainon.life/radio/cafe.ogg.m3u")
        ("Cyberia - Lainon"  . "https://lainon.life/radio/cyberia.ogg.m3u")
        ("Everything - Lainon"     . "https://lainon.life/radio/everything.ogg.m3u")
        ("Swing - Lainon"  . "https://lainon.life/radio/swing.ogg.m3u")
        ("Doomed (Special) - SomaFm" . "https://somafm.com/specials.pls")
        ("Vaporwaves - SomaFm" . "https://somafm.com/vaporwaves.pls")
        ("Groove Salad - SomaFm" . "https://somafm.com/groovesalad.pls")
        ("Groove Salad Classic - SomaFm" . "https://somafm.com/gsclassic.pls")
        ("Deep Space One - SomaFm" . "https://somafm.com/deepspaceone.pls")
        ("Space Station Soma - SomaFm" . "https://somafm.com/spacestation.pls")
        ("Drone Zone - SomaFm" . "https://somafm.com/dronezone.pls")
        ("The Trip - SomaFm" . "https://somafm.com/thetrip.pls")
        ("DEF CON Radio - SomaFm" . "https://somafm.com/defcon.pls")
        ("Sonic Universe - SomaFm" . "https://somafm.com/sonicuniverse.pls")
        ("Heavyweight Reggae - SomaFm" . "https://somafm.com/reggae.pls")
        ("Seven Inch Soul - SomaFm" . "https://somafm.com/7soul.pls")
        ("Left Coast 70s - SomaFm" . "https://somafm.com/seventies.pls")
        ("Underground 80s - SomaFm" . "https://somafm.com/u80s.pls")
        ("Secret Agent - SomaFm" . "https://somafm.com/secretagent.pls")
        ("Lush - SomaFm" . "https://somafm.com/lush.pls")
        ("ThistleRadio - SomaFm" . "https://somafm.com/thistle.pls")
        ("Fluid - SomaFm" . "https://somafm.com/fluid.pls")
        ("PopTron - SomaFm" . "https://somafm.com/poptron.pls")
        ("Beat Blender - SomaFm" . "https://somafm.com/beatblender.pls")
        ("Boot Liquor - SomaFm" . "https://somafm.com/bootliquor.pls")
        ("Illinois Street Lounge - SomaFm" . "https://somafm.com/illstreet.pls")
        ("BAGeL Radio - SomaFm" . "https://somafm.com/bagel.pls")
        ("Indie Pop Rocks! - SomaFm" . "https://somafm.com/indiepop.pls")
        ("Digitalis - SomaFm" . "https://somafm.com/digitalis.pls")
        ("Folk Forward - SomaFm" . "https://somafm.com/folkfwd.pls")
        ("cliqhop idm - SomaFm" . "https://somafm.com/cliqhop.pls")
        ("Dub Step Beyond - SomaFm" . "https://somafm.com/dubstep.pls")
        ("Suburbs of Goa - SomaFm" . "https://somafm.com/suburbsofgoa.pls")
        ("SF 10-33 - SomaFm" . "https://somafm.com/sf1033.pls")
        ("Mission Control - SomaFm" . "https://somafm.com/missioncontrol.pls")
        ("SF Police Scanner - SomaFm" . "https://somafm.com/scanner.pls")
        ("Metal Detector - SomaFm" . "https://somafm.com/metal.pls")
        ("Covers - SomaFm" . "https://somafm.com/covers.pls")
        ("Black Rock FM - SomaFm" . "https://somafm.com/brfm.pls")
        ("SF in SF Podcast - SomaFm" . "https://somafm.com/sfinsf.pls")
        ("SomaFM Live - SomaFm" . "https://somafm.com/live.pls")
        ("Xmas in Frisko - SomaFm" . "https://somafm.com/xmasinfrisko.pls")
        ("Christmas Lounge - SomaFm" . "https://somafm.com/christmas.pls")
        ("Christmas Rocks! - SomaFm" . "https://somafm.com/xmasrocks.pls")
        ("Jolly Ol' Soul - SomaFm" . "https://somafm.com/jollysoul.pls")
        ("Doomed - SomaFm" . "https://somafm.com/doomed.pls")
        ("I.D.M. Tranceponder - HRB1" . "http://www.hbr1.com/playlist/trance.ogg.m3u")
        ("Tronic Lounge - HRB1" . "http://www.hbr1.com/playlist/tronic.ogg.m3u")
        ("Dream Lounge - HRB1" . "http://www.hbr1.com/playlist/ambient.ogg.m3u")
))

(setq eradio-player '("mpv" "--no-video" "--no-terminal"))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
