# esteid-overlay
Gentoo overlay for Estonian ID-card software

To use this overlay, get the `app-eselect/eselect-repository` package and then:

    # eselect repository add esteid git https://github.com/open-eid/gentoo.git

Alternatively, get the package `app-portage/layman` and add an overlay definition to your layman.conf so it looks something like

    overlays :
        https://api.gentoo.org/overlays/repositories.xml
        https://raw.githubusercontent.com/open-eid/gentoo/master/profiles/overlay.xml

and then

    # layman -a esteid

## Support
There is no official support for this distribution, the scripts provided here are on best-effort basis AS IS terms.
