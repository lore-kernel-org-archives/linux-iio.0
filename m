Return-Path: <SRS0=HQNo=Z7=goldelico.com=hns@kernel.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_BC19EF0D-16D4-415E-A21E-28DCB585420D"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20170218032233.3qh5xdjbx5kkq5hm@earth>
Date: Sat, 18 Feb 2017 12:33:34 +0100
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
 Pavel Machek <pavel@ucw.cz>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Haibo Chen <haibo.chen@freescale.com>
Message-Id: <95E59EB0-6F96-40BB-B74C-9CD56DDD7783@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218032233.3qh5xdjbx5kkq5hm@earth>
To: Sebastian Reichel <sre@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_BC19EF0D-16D4-415E-A21E-28DCB585420D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 18.02.2017 um 04:22 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> Hi,
>=20
> On Fri, Feb 17, 2017 at 12:40:41PM -0800, Dmitry Torokhov wrote:
>>> AFAIK there is no mainline board using the DT except ours (and the =
upcoming
>>> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can =
remove this
>>> compatibility property. We don't need it for our devices.
>=20
> $ cd linux.git/arch
> $ git grep -l tsc2004
> arm/boot/dts/imx6qdl-nit6xlite.dtsi
> arm/boot/dts/imx7d-nitrogen7.dts
> arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> arm/boot/dts/omap4-var-som-om44.dtsi
> $ git grep -l tsc2005
> arm/boot/dts/omap3-n900.dts

Those are not relevant since tsc2004/5 and tsc2007 are independent =
drivers and don't
share code. Hence the N900 is not influenced by this patch series.

If it has a similar issue, it should be fixed of course.

> $ git grep -l tsc2007
> arm/boot/dts/imx28-tx28.dts
> arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
> arm/boot/dts/imx53-tx53-x03x.dts
> arm/boot/dts/imx6qdl-tx6.dtsi
> arm/boot/dts/imx6ul-tx6ul.dtsi
> arm/boot/dts/omap3-gta04.dtsi
> sh/boards/mach-ecovec24/setup.c

Sorry, I was a little imprecise here, because I looked for the min/max =
properties.
Of course, the imx devices use the tsc2007 as well.

Maybe we should edit all these DTS and set the "ti,report-resistance" =
property
by default. Then, no user should notice a difference.

Is any user/maintainer of these devices following this discussion and =
can comment?

>=20
>> You seem to be treating DT data as something very fluid, which is =
wrong.
>> You need to treat it as a firmware, unlikely to change once device is
>> shipped. Unlike legacy platform data, the fact that DTS files are not
>> present in mainline does not mean that we can ignore such users and
>> change behavior at will.
>>=20
>> That said, if driver behavior is out of line from the subsystem
>> expectations, we need to fix it.
>>=20
>>=20
>>> That the function name is wrong is a second issue and this double =
negation might
>>> confuse a litte.
>>>=20
>>> Please test on a real device if the patched driver reports pressure =
now (unless
>>> ti,report-resistance is specified).
>>=20
>> I unfortunately can not test this driver as I do not have the =
hardware.
>> So all my observations are from code and data sheets.
>>=20
>> That said, what is the values emitted as ABS_PRESSURE when finger is =
not
>> touching the device, barely touching the device, or pressing firmly?
>> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
>> confusion as to what is being reported.
>=20
> As far as I can see all calculate Rtouch and ADS7846 reports
> (Rmax - Rtouch), which looks sensible.

I don't see where this subtraction from Rmax takes place for the =
tsc2007:

=
http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc2007.c#L=
131

>=20
>> I am adding a few more folks to the CC so we can try and soft this =
out.
>> Sebastian, Pali, Pavel, any input here?
>=20
> I think tsc200x works, since usually userspace is Xorg and I think
> it only cares for x/y coordinates + boolean pressure. Since
> no-pressure is correctly reported as 0, everything works as
> expected.

No pressure is usually treated as a special case in these drivers,
so reduction to "boolean" in user-space works well by accident and
might still hide a bug.

> I currently don't have X running on my N900 due some
> omapdrm bug, so I can't test this, sorry.

I usually look with evtest if ABS_PRESSURE is monotonic.

>=20
> I suggest to put the resistance vs pressure thing in its own patch,
> that also fixes tsc200x-core and merge it to linux-next after the
> merge window.
>=20
> -- Sebastian

BR and thanks,
Nikolaus



--Apple-Mail=_BC19EF0D-16D4-415E-A21E-28DCB585420D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqDEPAAoJEIl79TGLgAm6IL8P+wc56KLeLJL+O8Ep2m1TEx9O
x6SN1rWB76lOvGcF1bSxG7z/pR97JPvDFwjRkMScXUCkDUfraU/c5RafVupDIDWN
JWTYYv6jLLHX5GTLlNvg7ponMUgY1fXqjQsZXzuBF2IdwX/ETsG2mM/sveFe446L
58FYlsCMjiF1/bLc1HoTMDp3rTo3HfPTnb4/BS0jCWaTSH+JyZrhO2SiRr3mcXyu
m8IOaInGPMMRA2fOe9krcXpawlM8JlxLiVbHysx2lVaiA/KEGBEvVQhYdldV5jWa
9w0u4av3eYnoEgLs6TMtHl6OF0dVFJXGsCGLbuLAUUvDj6hWDSKC97wQMcnYkOhN
qeJpy5/bz3J/lkjwwaddiYwctMGtwhP9pUUtuUqSFMOxsYFlgIOgGyMuE+3IQm9B
JFqGAEec2blcS87gCpYY4/GaL5J9Uoowtol9ZMdsWP66L2p7ZJlnFH0D+Bbpy1j8
YfH7Tp0J67GPkLzRAX7ycrEgVE0mA9ho5eKH7tZmWcIXWii8qROAQ4hKgUF6Do0N
1TG8DotUYpps6etsCe3fh5sxkdigQy79XDKnLf8GHTAe1luaTLUUTgKlwnHBFhzd
3ptTql2xX25EM7zBtQBsv1MCovEVH++I+5kHU6WxRpoPIOOEt3Te1M1sQ7wkJdxJ
Ozj4sN3bxfLwYHQYL2uH
=mpmc
-----END PGP SIGNATURE-----

--Apple-Mail=_BC19EF0D-16D4-415E-A21E-28DCB585420D--
