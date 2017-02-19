Return-Path: <SRS0=Ewx+=2A=goldelico.com=hns@kernel.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20170218225435.GA4693@amd>
Date: Sun, 19 Feb 2017 13:05:25 +0100
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Sebastian Reichel <sre@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Alexander Stein <alexander.stein@systec-electronic.com>,
 Eric Engestrom <eric@engestrom.ch>,
 Hans de Goede <hdegoede@redhat.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Petr Cvek <petr.cvek@tul.cz>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Nick Dyer <nick@shmanahar.org>,
 Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
 Michel Verlaan <michel.verl@gmail.com>,
 linux-input@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 letux-kernel@openphoenux.org,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com,
 Aaro Koskinen <aaro.koskinen@nokia.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Haibo Chen <haibo.chen@freescale.com>
Message-Id: <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd>
To: Pavel Machek <pavel@ucw.cz>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 18.02.2017 um 23:54 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> On Sat 2017-02-18 20:17:09, H. Nikolaus Schaller wrote:
>>=20
>>> Am 18.02.2017 um 19:08 schrieb Pavel Machek <pavel@ucw.cz>:
>>>=20
>>>>> And I agree that kernel should _not_ attempt rescaling itself, as =
it
>>>>> would lose precision.
>>>>=20
>>>> With an almost 1:1 mapping you won't loose precision.
>>>=20
>>> How do you propose to do that?
>>=20
>> something like
>>=20
>> xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate =
Transformation Matrix"  1.00 0.00 0.00  0.00 1.00 0.00  0.00 0.00 1.00
>>=20
>> but I think it is the default of X11 if you use no coordinate =
transformation at all.
>> And having the kernel to properly scale from ADC values to screen =
coordinates.
>>=20
>=20
> No. How do you propose doing rescaling in the kernel without loosing
> precision?

I wonder how it works with your setting

xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate =
Transformation Matrix"  1.10 0.00 -0.05  0.00 1.18 -0.10  0.00 0.00 1.00

This obviously also assumes that the input events report pixel =
coordinates or you would have factors not close to 0.00 and 1.00.
It just aligns the touch with the screen, i.e. calibrates. Or your =
example was incomplete.

About loosing precision: there is already noise (jitter) in real-world =
devices so that you can't achieve subpixel precision anyways (unless =
your panel has a very low resolution). Please see my answer to Dmitry =
some mails ago.

BR and thanks,
Nikolaus


--Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqYoGAAoJEIl79TGLgAm6O+MP/2xCAvKRKen8ZX6ZylTNCgnz
BJEp+awnsICgeb6Cny2vm29ujBMSyBKR7dgPjgGFLJV8C2jLlaPjPgKuOxKMYXdl
iAi0yQoqwRR7rONWGd74aiWQHhpXmt8LSRD5trXrpA1aAC2qmpDyLeCKwkA5UskE
EzcXMh125ZsrKUtk2qHJ3a/RMWbGIlvBdlw/A7qfkwF6FedyKL7GQMoE0iV/GVcK
ynHhIzTH+3m3ajU2uZK0ZOIv/4AdNYLu+5mVmbaQt0bgSzEMBsmUW1pyx6fdqJKL
tcYBiHCRx2pLwh6tju3GzCzmv0DJrWv+UDan2DqjMMRsVsA0qhY9k6QG4F2CG5+Y
HkWxb4Je7AUAAz2kO3MMxGDErDEaqVJDajiBQLMSQDZTvJ1DOeOgHPKJUQ6pdpNF
qkXrD+8Mw658dmTx2t8brYoVY51wvadCKkidhdWMCV71P0pP2hDraMYaJm4pUasY
YMhkE8MG7dhaPY++sO0K0iJj7nEC/UNMbqvwpF3/aycXGuqt3d5GzkviMggffZ2s
70bsvIFMByiE4obsTSr2bsnk5BFO+qnva9Ry+yb2ToAkbJMdXOzIOn6rgbENpoQ9
y/sem5fjOZZgAQTfmGvbp/lL3J4mr2Wg80t3/xMepUAktPSnWnF//519EFZF5VUa
sbJJsO/EGFY6IKalSIGJ
=UPAP
-----END PGP SIGNATURE-----

--Apple-Mail=_396942DE-7251-42FE-AE9C-DA4B2AF1E5EF--
