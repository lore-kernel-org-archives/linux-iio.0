Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.178]:15336 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdBSRFM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 12:05:12 -0500
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20170219141715.GA7159@amd>
Date: Sun, 19 Feb 2017 18:04:14 +0100
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
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
Message-Id: <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
References: <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd>
To: Pavel Machek <pavel@ucw.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

HI Pavel,

> Am 19.02.2017 um 15:17 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> Hi!
> 
>> About loosing precision: there is already noise (jitter) in
>> real-world devices so that you can't achieve subpixel precision
>> anyways (unless your panel has a very low resolution). Please see my
>> answer to Dmitry some mails ago.
> 
> Maybe you can achieve better precision with averaging.

Can you? What do you want to average here? Multiple sequential measurements?
This makes the touch slower and hence imprecise and unuseable in another way.
Anyways, the tsc2007 chip can already do such averaging.

> 
> Anyway "input is already noisy" does not mean "so it is okay to
> degrade it more".

You have not yet said how you think it is degraded *more* than in your
example.

> Solve it properly. That means passing calibration
> data from kernel to userland.

As written before, the really proper solution would be to provide floating
or fixed point subpixel input events. Not arbitrarily scaling up in kernel
and leaving downscaling to user space (where everybody can make it worse).

But I don't think it is worth implementing subpixel touch events for real
world devices due to the jitter I mentioned.

BR,
Nikolaus


--Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqdAPAAoJEIl79TGLgAm65rEQAJ0mZZRtaztphNV8QN8Pmc3o
ouY5N7/rxvIyoC1nE94ieV3Ck4coCw3mDICbiVCB6yg0iIiji4HipuQLrUZAPKmn
WFXI+8GK5l68xMpgYug6+QuJw1dnD605H4FqEyIl+4Tt4TilhGgIYfvqEbIioidq
+qcjZCyS5zHpNp2hBDPIuL0KjO6QWa67QNU1QwK+5UAS1P93IbzJbfLsB1i+lORu
F/heq0u93HhNiOSPrhQ2SW/0erkXih+VFjOwkf8VGfHjdRNdLCrEuJ00vx6UY+uf
O4jqAyYVf3z8RFnzBBNh1lWUoUp3i+QNXZBrNORTaJ2NDxnFv2LYjRAzMLwM62gH
UTZ/jM7DLjw8MhhEVWYVpNUj2B//pyx2uCLCV6lrfHH68HTzFQBzE/nczN91A9nz
jWiAivF4HTT8cUTtplKzKjgxgTvFajNBQwdZZuueP5mmiIbMg7EPi7oSzDa0rKh5
AhAlvyphN69LxbQewnuww8nzqMdgymIkQ2oWDqoAYJNk6YWWQzdVuBdDVzoHnrsV
enl2Z4mJ+aIVkTbp3SrtI7vTb3HyJXhYs9TcRVzC3x9zy4gCdcjbRlyCAScx8fgz
9YhRwpwDEmWh+IB1IaUjohczo4ccMnii686NnL+WTjmKtm0F+fEufgRqLWQjA686
WQutmVEUZtsWD7UBj3Bv
=07bO
-----END PGP SIGNATURE-----

--Apple-Mail=_AFF05A29-D6EB-4CDC-AFB0-0756510B7880--
