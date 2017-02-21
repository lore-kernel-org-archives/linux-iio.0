Return-Path: <SRS0=Xqrh=2C=goldelico.com=hns@kernel.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <e3dd020e-8590-6e65-9151-b5f1492debcb@tul.cz>
Date: Tue, 21 Feb 2017 09:29:53 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila@nextfour.com>,
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
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Nick Dyer <nick@shmanahar.org>,
 Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
 Michel Verlaan <michel.verl@gmail.com>,
 linux-input@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com,
 Aaro Koskinen <aaro.koskinen@nokia.com>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Haibo Chen <haibo.chen@freescale.com>
Message-Id: <EABA13E3-05E4-4A7B-A84D-033BB8FBDE28@goldelico.com>
References: <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com> <20170219221930.GA1568@amd> <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com> <e3dd020e-8590-6e65-9151-b5f1492debcb@tul.cz>
To: Petr Cvek <petr.cvek@tul.cz>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Pavel Machek <pavel@ucw.cz>,
 Sebastian Reichel <sre@kernel.org>,
 =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Petr and all,

> Am 20.02.2017 um 23:26 schrieb Petr Cvek <petr.cvek@tul.cz>:
>=20
> Hi
>=20
> Dne 20.2.2017 v 17:50 H. Nikolaus Schaller napsal(a):
>> Hi Pavel,
>>=20
>>> Am 19.02.2017 um 23:19 schrieb Pavel Machek <pavel@ucw.cz>:
>>>=20
>>> hi!
>>>=20
>>>>>> But as said I don't think we need float or fixed point for =
practical systems
>>>>>> at all.
>>>>>=20
>>>>> So you are going to loose precision. And if userspace decides to
>>>>> calibrate it slightly differently from kernel, lost precision will
>>>>> matter.
>>>>=20
>>>> Really?
>>>=20
>>> Really.
>>>=20
>>>> Example:
>>>>=20
>>>> ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in =
pre-calibration)
>>>>=20
>>>> This is scaled to let's say 0..640.
>>>=20
>>> Ok. Now userspace realizes that kernel alignemnt is off, and it =
would
>>> want to scale it to 1..642.
>>=20
>> Screen coordinates are still 0..639.
>>=20
>>> That will mean that single pixel will be
>>> inaccessible, right?
>>=20
>> Yes, that can happen if the additional user-space scale is > 1.0.
>>=20
>> As long as it is small (I expect <1.01 =3D 1% error in scale) it is
>> barely noticeable.
>>=20
>> Therefore, I asked before: how big in pixels is your finger or =
stylus?
>> Does this effect matter?
>>=20
>> A resistive touch is a man-machine-interface where people press =
buttons of at
>> least 12x12 pixels size (or they are no longer visually =
recognizable).
>=20
> Smallest kernel font is 4x6 (i think) and I'm regularly using 8x8. I =
would like
> to be able to select a single letter in the console.

So you probably have exceptionally good eyes and reading a terminal on a =
touch
screen is not a typical use case (except for us hard-core programmers).

Anyways, if there is only a single pixel is not accessible due do =
rescaling and integer
truncation effects (which is what Pavel complained) you can still select =
single letters
in a 4x6 font.

---

So, let's close commenting this patch here since in my opinion =
everything is said
and the maintainers have decided not to accept it.

I hope that I have not forgotten anyone to answer.

Thank you very much to all participants for this discussion, because it =
was
really enlightening to me and contains a lot of new perspectives.

BR and thanks,
Nikolaus=
