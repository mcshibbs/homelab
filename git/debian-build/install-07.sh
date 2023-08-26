#!/bin/bash

# Section - 13 | Purpose - Add Bitwarden, Joplin, and KDE Plasma Extension to Brave | # Linked Resources
## Creates path to place extensions
EXTENSIONS_PATH=/opt/brave.com/brave/extensions
mkdir -p $EXTENSIONS_PATH
#
BITWARDEN_ID=nngceckbapebfimnlniiiahkandclblb
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${BITWARDEN_ID}.json"
#
KDE_ID=cimiefiiaegbelhefglklhhakcgmhkai
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${KDE_ID}.json"
#
KEEPASSXC_ID=oboonakemofpalcgghocfoadofidjkkk
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${KEEPASSXC_ID}.json"
#
JOPLIN_ID=alofnhikmmkdbbbgpnglcpdollgjjfek
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${JOPLIN_ID}.json"
