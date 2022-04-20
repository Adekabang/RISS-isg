#!/usr/bin/env bash
#change motd
cat << EOF > /etc/motd
______ _____ _____ _____   _   _                 _ _          _ _
| ___ \_   _/  ___/  ___| | | | |               | | |        | | |
| |_/ / | | \ `--.\ `--.  | |_| | __ _ _ __   __| | | ___  __| | |
|    /  | |  `--. \`--. \ |  _  |/ _` | '_ \ / _` | |/ _ \/ _` | |
| |\ \ _| |_/\__/ /\__/ / | | | | (_| | | | | (_| | |  __/ (_| |_|
\_| \_|\___/\____/\____/  \_| |_/\__,_|_| |_|\__,_|_|\___|\__,_(_)
EOF

cat << EOF > /usr/local/opnsense/service/templates/OPNsense/Auth/motd
______ _____ _____ _____   _   _                 _ _          _ _
| ___ \_   _/  ___/  ___| | | | |               | | |        | | |
| |_/ / | | \ `--.\ `--.  | |_| | __ _ _ __   __| | | ___  __| | |
|    /  | |  `--. \`--. \ |  _  |/ _` | '_ \ / _` | |/ _ \/ _` | |
| |\ \ _| |_/\__/ /\__/ / | | | | (_| | | | | (_| | |  __/ (_| |_|
\_| \_|\___/\____/\____/  \_| |_/\__,_|_| |_|\__,_|_|\___|\__,_(_)
EOF

#remove other version except RISS
sed -i '' -e "s|.join('<br/>')|[0]|" /usr/local/www/widgets/widgets/system_information.widget.php
# change ownership
sed -i '' -e 's|"product_copyright_owner":.*|"product_copyright_owner": "Tech\&Solution",|' -e 's|"product_copyright_url":.*|"product_copyright_url": "https://r17.co.id/",|' -e 's|"product_copyright_years":.*|"product_copyright_years": "2022",|' -e 's|"product_email":.*|"product_email": "support@r17.co.id",|' -e 's|"product_name":.*|"product_name": "RISS",|' -e 's|"product_website":.*|"product_website": "https://r17.co.id/"|' /usr/local/opnsense/version/core

#install package and themes
sed -i '' -e 's|enabled: no|enabled: yes|' /usr/local/etc/pkg/repos/FreeBSD.conf ; pkg update ; pkg install -y ccze dialog4ports iperf lynx trafshow htop tcpproxy vim nano wget json-c bind-tools screen nmap os-net-snmp os-iperf os-theme-cicada os-theme-vicuna; sed -i '' -e 's|enabled: yes|enabled: no|' /usr/local/etc/pkg/repos/FreeBSD.conf ; pkg update;pkg autoremove -y

cp -R betax /usr/local/opnsense/www/themes/

#change layout menu
cp Menu/Menu.xml -O /usr/local/opnsense/mvc/app/models/OPNsense/Core/Menu/Menu.xml

#change logo
cp images/default-logo.svg -O /usr/local/opnsense/www/themes/vicuna/build/images/default-logo.svg ; 
cp images/icon-logo.svg -O /usr/local/opnsense/www/themes/vicuna/build/images/icon-logo.svg ; 
cp images/favicon.png -O /usr/local/opnsense/www/themes/vicuna/build/images/favicon.png ; 
sed -i '' -e 's/D77610/FF9900/g' /usr/local/opnsense/www/themes/vicuna/build/css/main.css

cp images/default-logo.svg -O /usr/local/opnsense/www/themes/cicada/build/images/default-logo.svg ; 
cp images/icon-logo.svg -O /usr/local/opnsense/www/themes/cicada/build/images/icon-logo.svg ; 
cp images/favicon.png -O /usr/local/opnsense/www/themes/cicada/build/images/favicon.png ; 
sed -i '' -e 's/dd630d/FF9900/g' /usr/local/opnsense/www/themes/cicada/build/css/main.css

cp images/default-logo.svg -O /usr/local/opnsense/www/themes/opnsense/build/images/default-logo.svg ; 
cp images/icon-logo.svg -O /usr/local/opnsense/www/themes/opnsense/build/images/icon-logo.svg ; 
cp images/favicon.png -O /usr/local/opnsense/www/themes/opnsense/build/images/favicon.png ; 
sed -i '' -e 's/EA7105/AB2B28/g' -e 's/D94F00/AB2B28/g' /usr/local/opnsense/www/themes/opnsense/build/css/main.css

#change boot logo
cat << EOF > /boot/brand-opnsense.4th
6x49
\ Copyright (c) 2006-2015 Devin Teske <dteske@FreeBSD.org>
\ Copyright (c) 2016 Tobias Boertitz <tbor87@gmail.com>
\ All rights reserved.
\
\ Redistribution and use in source and binary forms, with or without
\ modification, are permitted provided that the following conditions
\ are met:
\ 1. Redistributions of source code must retain the above copyright
\    notice, this list of conditions and the following disclaimer.
\ 2. Redistributions in binary form must reproduce the above copyright
\    notice, this list of conditions and the following disclaimer in the
\    documentation and/or other materials provided with the distribution.
\
\ THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
\ ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
\ IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
\ ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
\ FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
\ DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
\ OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
\ HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
\ LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
\ OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
\ SUCH DAMAGE.
\
\ $FreeBSD$

18 brandX ! 2 brandY ! \ Initialize brand placement defaults

: brand+ ( x y c-addr/u -- x y' )
        2swap 2dup at-xy 2swap \ position the cursor
        type \ print to the screen
        1+ \ increase y for next time we're called
;

: brand ( x y -- ) \ "RISS ISG" [wide] logo in B/W (6 rows x 49 columns)

        s" #[34;1m _____  _____  _____ _____ #[m  _____  _____  _____ " brand+
        s" #[34;1m|  __ \|_   _|/ ____/ ____|#[m |_   _|/ ____|/ ____|" brand+
        s" #[34;1m| |__) | | | | (___| (___  #[m   | | | (___ | |  __ " brand+
        s" #[34;1m|  _  /  | |  \___ \\___ \ #[m   | |  \___ \| | |_ |" brand+
        s" #[34;1m| | \ \ _| |_ ____) |___) |#[m  _| |_ ____) | |__| |" brand+
        s" #[34;1m|_|  \_\_____|_____/_____/ #[m |_____|_____/ \_____|" brand+

        2drop
;
EOF

cat << EOF > /boot/logo-hourglass.4th
\ Copyright (c) 2006-2015 Devin Teske <dteske@FreeBSD.org>
\ Copyright (c) 2016-2017 Deciso B.V.
\ All rights reserved.
\
\ Redistribution and use in source and binary forms, with or without
\ modification, are permitted provided that the following conditions
\ are met:
\ 1. Redistributions of source code must retain the above copyright
\    notice, this list of conditions and the following disclaimer.
\ 2. Redistributions in binary form must reproduce the above copyright
\    notice, this list of conditions and the following disclaimer in the
\    documentation and/or other materials provided with the distribution.
\
\ THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
\ ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
\ IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
\ ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
\ FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
\ DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
\ OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
\ HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
\ LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
\ OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
\ SUCH DAMAGE.
\
\ $FreeBSD$

48 logoX ! 9 logoY ! \ Initialize logo placement defaults

: logo+ ( x y c-addr/u -- x y' )
        2swap 2dup at-xy 2swap \ position the cursor
        [char] # escc! \ replace # with Esc
        type \ print to the screen
        1+ \ increase y for next time we're called
;

: logo ( x y -- ) \ color hourglass logo (16 rows x 29 columns)

        s" #[34;1m.:-==++**##########**++=-:  " logo+
        s" +#########################: " logo+
        s" .*+==--:::........:::+####  " logo+
        s"                     .####-  " logo+
        s"                   :+####-   " logo+
        s"  .:::.....:::-=+*#####+.    " logo+
        s"  :#################+- .     " logo+
        s"   *####**#####*-:..-=###*=-:" logo+
        s"   .####+  =####*=. :=*#####=" logo+
        s"    .*####- .=######+-. :-=+ " logo+
        s"      -#####=. :=#######.    " logo+
        s"        -######=:..-=*#-     " logo+
        s"          :=######+          " logo+
        s"             .-+##           #[m" logo+
        s"  #[m                                " logo+
        s"  21.1  ``Marvelous Meerkat''     #[m" logo+

        2drop
;
EOF

rm -rf RISS-isg
