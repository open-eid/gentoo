# esteid-overlay
Gentoo overlay for Estonian ID-card software

add overlay definition to your layman.conf so it looks something like that

    overlays :
        https://api.gentoo.org/overlays/repositories.xml
        https://raw.githubusercontent.com/open-eid/gentoo/master/profiles/overlay.xml

and then just 

    # layman -a esteid
    

## Support
There is no official support for this distribution, the scripts provided here are on best-effort basis AS IS terms.
