Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.223]:29201 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbdBTQuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 11:50:18 -0500
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20170219201516.qw22o66t6zbolbgt@earth>
Date: Mon, 20 Feb 2017 17:49:53 +0100
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
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
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
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
Message-Id: <AE27E6D2-732F-47BB-8318-C5A7DF8A88B9@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218032233.3qh5xdjbx5kkq5hm@earth> <95E59EB0-6F96-40BB-B74C-9CD56DDD7783@goldelico.com> <20170218234422.vza3toc3bphixsdn@earth> <FA96689F-AFD0-4FC9-95D9-639299341C8B@goldelico.com> <20170219201516.qw22o66t6zbolbgt@earth>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 19.02.2017 um 21:15 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> Hi,
>=20
> On Sun, Feb 19, 2017 at 01:07:26PM +0100, H. Nikolaus Schaller wrote:
>> I don't really remember when we noticed it first. Maybe it was
>> back in tslib times some years ago where setting the sensitivity
>> threshold made problems. We then carried along our patch for a
>> long time in our local repo (and modified it several times) and
>> only started upstreaming some months ago. [...]
>>=20
>> AFAIK, GIMP and for example https://sourceforge.net/projects/xournal/ =
appear
>> to be able to handle X pressure, but I haven't running and tested =
either one
>> on our devices. Pressure is used in such drawing tools to simulate =
that some
>> physical pens make wider strokes on higher pressure.
>>=20
>> This seems to indicate that X can handle pressure in a non-boolean =
way, but rarely does.
>> Especially I think the usual menu, click, drag, scroll gestures are =
only based
>> on BTN_TOUCH status and not on ABS_PRESSURE. So it is rarely noticed =
to make
>> a difference.
>=20
> ok.
>=20
>>>>> I suggest to put the resistance vs pressure thing in its own =
patch,
>>>>> that also fixes tsc200x-core and merge it to linux-next after the
>>>>> merge window.
>>=20
>> Ok. I will propose a patch.
>=20
> Thanks. I suggest to add this in the patch description:
>=20
> While this patch changes the values reported to userspace,
> ABS_PRESSURE is used rarely by userspace. Most software only
> relies on BTN_TOUCH (boolean), which is not affected by this
> patch. Some graphics software makes use of the interface and
> does not work correctly with the currently used inverted
> behaviour.

Added. Patch set will come in some minutes (have to run checkpatch
first).

BR and thanks,
Nikolaus


--Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqx4yAAoJEIl79TGLgAm67aAQAKpae9JClZrXx/CDUgDnFi+R
JUWteEZDBKN6/minjuGdk/RKv04X4g0WWhYdr6p2HkGldo6VTz+5bULeJVBTGZGl
XdpFMvBh9JwbVkxIL4CcyjPn+orCXPChh7OGbVkEkfD/8e2TLpw2gkEVKp8Y4T3L
3HEaJver3rfb7LbajAt2z/GyQC31RMIDIm90HFFoLo9zfzz7Hpp0TESAXf0bxiOg
zQxFqW/sI1grlAApmLqs7vYKyP1Upqr2VxCL8goFypribNju+pxbDNyPq7cjtUf2
geiaNjZuLeznCotltufm0ZjjJeVlvDCDHQiMTfF0vummhDYr7aAHbPvu0Rw5oUTi
H4wmo211oXUtSbL8pf53KkwixpxwIAkvvvCQ43TJruiZ+V0zWu4zOie8k+HBdv/s
fiKGv1h3BI7BoS9ItY3oP/zd520TIk7+4+ttAg0IAYwqYIkTy3RtsD4gt2O0DDd0
V0Qp4L0aUAe+G3ruoECnkDoV8v54th8WSuUT3M3et9u0+rXRiVakcWBUbPBWLRKN
0SDNiiYxy4VVXk/E02gLXFJjg6g4fc0oDcNF28vkdwORFQey2Rf1KgAhfXm3vFnm
rIgrsFydFG5ECZiZuKx00Ce09g8pU+xPm1jlZfuLfVXoCfnVWuxg1xhAMh9e5XHK
/qO76Ikq1cEV7yl6Gnzl
=eVZS
-----END PGP SIGNATURE-----

--Apple-Mail=_42182033-5E06-43DC-9E0A-84CE55B3F722--
