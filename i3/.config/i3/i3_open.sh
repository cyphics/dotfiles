#!/bin/bash

## Focus sur un programme. Si celui-ci n'est pas ouvert, l'ouvre.

case "$1" in
    "firefox")
	if pgrep "firefox" > /dev/null ; then
	    i3-msg "[class=Firefox] focus"
	else
	    firefox
	fi
	exit 0;;

    "chromium")
	if pgrep "chrome" > /dev/null ; then
	    i3-msg "[class=Chromium-browser-chromium] focus"
	else
	    chromium
	fi
	exit 0;;

    "chrome")
	if pgrep "chrome" > /dev/null ; then
	    i3-msg "[class=Google-chrome] focus"
	else
	    google-chrome-stable
	fi
	exit 0;;

    "thunderbird")
	if pgrep "thunderbird" > /dev/null ; then
	    i3-msg "[class=Thunderbird] focus"
	else
	    thunderbird
	fi
	exit 0;;

    "emacs")
	if pgrep "emacs" > /dev/null ; then
	    i3-msg "[class=Emacs] focus"
	else
	    emacs
	fi
	exit 0;;

    "thunar")
	if pgrep "thunar" > /dev/null ; then
	    i3-msg "[class=Thunar] focus"
	else
	    thunar
	fi
	exit 0;;

    "pcmanfm")
	if pgrep "pcmanfm" > /dev/null ; then
	    i3-msg "[class=Pcmanfm] focus"
	else
	    pcmanfm
	fi
    exit 0;;
    "thunar")
	          if pgrep "thunar" > /dev/null ; then
	              i3-msg "[class=Thunar] focus"
	          else
	              thunar
	          fi

	exit 0;;

    "dolphin")
	    if pgrep "dolphin" > /dev/null ; then
	        i3-msg "[class=Dolphin] focus"
	    else
	        QT_QPA_PLATFORMTHEME=qt5ct dolphin
	    fi

	    exit 0;;
    "nautilus")
	    if pgrep "nautilus" > /dev/null ; then
	        i3-msg "[class=Nautilus] focus"
	    else
	        nautilus
	    fi

	    exit 0;;

    "vlc")
	if pgrep "vlc" > /dev/null ; then
	    i3-msg "[class=Vlc] focus"
	else
	    vlc
	fi

	exit 0;;

    "irc")
	if pgrep -f 'ssh -t -i /home/cyphics/.ssh/id_ed25519_f magneto irc' > /dev/null ; then
	    i3-msg "[title=irc] focus"
	else
	    termite -e /home/cyphics/scripts/cyphics/irc
	fi

	exit 0;;

    "cmus")
	if pgrep "cmus" > /dev/null ; then
	    i3-msg "[id=18237] focus"
	else
	    terminology -e cmus
	fi

	exit 0;;

    "pavucontrol")
	if pgrep "pavucontrol" > /dev/null ; then
	    i3-msg "[Class=Pavucontrol] focus"
	else
	    pavucontrol
	fi

	exit 0;;

esac
echo fail
