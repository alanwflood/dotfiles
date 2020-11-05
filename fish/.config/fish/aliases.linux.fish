alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection c -o"

function brightness --argument screenBrightness
	qdbus-qt5 local.org_kde_powerdevil /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $screenBrightness
end

alias mute="qdbus org.kde.kglobalaccel /component/kmix invokeShortcut 'mute'"
alias nightnight="brightness 10; mute"
