Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.andi.de1.cc ([85.214.239.24]:49170 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdBRIPT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 03:15:19 -0500
Date: Sat, 18 Feb 2017 08:45:33 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Michel Verlaan <michel.verl@gmail.com>,
        Nick Dyer <nick@shmanahar.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mika =?UTF-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Petr Cvek <petr.cvek@tul.cz>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Haibo Chen <haibo.chen@freescale.com>,
        Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?QmVub8Ou?= =?UTF-8?B?dA==?= Cousson
        <bcousson@baylibre.com>, kernel@pyra-handheld.com,
        Michael Welling <mwelling@ieee.org>,
        letux-kernel@openphoenux.org, Jonathan Cameron <jic23@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Message-ID: <20170218084533.27ad3e3b@aktux>
In-Reply-To: <20170217204041.GE13050@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
        <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
        <20170128193342.GB38136@dtor-ws>
        <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
        <20170217204041.GE13050@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3rG=c/8M1G6uC7ZLT1cLQw8"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--Sig_/3rG=c/8M1G6uC7ZLT1cLQw8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, 17 Feb 2017 12:40:41 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

[...]=20
> > Let me cite myself:
> >=20
> > >> This makes it possible to pre-calibrate the touch so that is
> > >> (almost)
>=20
> Yes, it allows you to pre-calibrate, I get it. But you still do
> properly calibrate later, right? So you are doing double work here,
> once in kernel, and second time in userspace.
>=20
I as a daily user of that tsc2007 patch series say that I had never the
wish to calibrate it later in a better way. I am doing console work
with a virtual keyboard on it. So it is rarely double work here.

Regards,
Andreas

--Sig_/3rG=c/8M1G6uC7ZLT1cLQw8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYp/vNAAoJEInxNTv1CwY0lvcP/iQIdUpev8N0q7YbW5iaYmzn
Yq4v07bkJplCEMjl8yliy7+OOm+syPCf9zoP/hph80/CJw3z5u9iOyPOwnBtrmMa
wCz+hS30lXnC0qDk3gar5SXrNGavWlkOFRuQEW3y+yLWt4C+n6r3X2SoZhUnRuQn
75m0lym+bTxo80As6HwaeTXNlA3uIfT2KYqvxY7zVJlD9mDjv1YC1kLhYNfyQ4FO
X7pN3QG89KJDuOw/d5JmiOpUCrqA9Qt9Tn6hIdne5nDKe6dybnHJZr31MBmfmrn5
iZUoQAXtfQRJMve6g0RrEnwdP8D5rVDttx+FCtOQWCDA5wjcW/1GlUEGvxCY4TIt
/0eJ5r02JkVyBjHolOkHdIXI2ryGoQPBnkC2KKys4qj9vwDTF+GR4gYy2GWxx3oR
55iUbmorAg5GbRznqcrAvxCxb49y5wey0eOzNVoPO7i1SSJRBnks2cOdsJUdtUY6
r6u5zzW58BZyXiIUmvJVC5C9YdD+fyNOpAPZNzkNg+6tN8RCy6vKDZivYfAYxgbP
rAJzQWzz3GTxQ7uuIKw+RxaA1kDY6aIlwecN7PvwSSfOD6ueuPvUiH2DT0Ek2n4B
a3N6ZxNw0DQDmwTyfx79M853C/AKEV5e5MBKNeOdV6ZbHltlJtVPBDsX4LHe/PE9
fVw9Eh3Yu9zRPvT9r+0A
=iQv0
-----END PGP SIGNATURE-----

--Sig_/3rG=c/8M1G6uC7ZLT1cLQw8--
