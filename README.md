# esteid-overlay
Gentoo overlay for estonian ID-card software

add overlay definition to your layman.conf so it looks something like that

    overlays :
        https://api.gentoo.org/overlays/repositories.xml
        https://raw.githubusercontent.com/urmet/esteid-overlay/master/profiles/overlay.xml

and then just 

    # layman -a esteid
