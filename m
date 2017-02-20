Return-Path: <SRS0=o/U3=2B=goldelico.com=hns@kernel.org>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_A793DE90-0BBB-42DE-88B5-172FF3ADE34D"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20170219223949.GA2470@amd>
Date: Mon, 20 Feb 2017 17:50:28 +0100
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Michel Verlaan <michel.verl@gmail.com>,
 Nick Dyer <nick@shmanahar.org>,
 Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-omap@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Aaro Koskinen <aaro.koskinen@nokia.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 linux-input@vger.kernel.org,
 devicetree@vger.kernel.org,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Eric Engestrom <eric@engestrom.ch>,
 Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Petr Cvek <petr.cvek@tul.cz>,
 Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
 Haibo Chen <haibo.chen@freescale.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Sebastian Reichel <sre@kernel.org>,
 linux-iio@vger.kernel.org,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 kernel@pyra-handheld.com,
 Michael Welling <mwelling@ieee.org>,
 letux-kernel@openphoenux.org,
 Jonathan Cameron <jic23@kernel.org>,
 Alexander Stein <alexander.stein@systec-electronic.com>
Message-Id: <EE81034E-C10E-4E8B-B026-B3E92C0DAA19@goldelico.com>
References: <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <20170219232918.53801560@aktux> <20170219223949.GA2470@amd>
To: Pavel Machek <pavel@ucw.cz>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_A793DE90-0BBB-42DE-88B5-172FF3ADE34D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 19.02.2017 um 23:39 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> Hi!
> 
>>>> And note that I am not making things different from others in tree,
>>>> I am making the tsc2007 right (incl. following the touchscreen
>>>> bindings which define the touchscreen size in "Pixels").
>>> 
>>> Your touch screen is not in any way special, so it has to behave in
>>> the same way others do.
>>> 
>> 
>> I agree, the tsc2007 (=what the interface provides to userspace) should
>> not behave special, for example it should behave like the virtual
>> touchscreen (=what the interface provides to userspace) virtualbox
>> gives. No need to be calibrated. Well, the internals are different. But
>> that is what the kernel is good for, abstract such things.
>> Conclusion: It cannot be totally wrong behavior to have pixel values
>> there.
> 
> It is not "totally wrong". But it is useless code that should not be
> in kernel. Calibration certainly does not belong to single
> _driver_.

It belongs to driver + attached panel. I.e. hardware. Which the kernel
or driver should IMHO abstract from as good as possible.

> Feel free to submit driver

For what? The tsc2007 driver already exists.

> but keep the calibration code out
> of tree...

It is the really important patch to add this.

> 
> But if you have userspace that depends on touchscreen to be
> calibrated... that _is_ wrong.

User-space people and real users have the opposite opinion. They
prefer if a touch is plug&play. I.e. without need for calibration.

When did you last time re-calibrate the heads of your hard disk in
user-space?

BR and thanks,
Nikolaus


--Apple-Mail=_A793DE90-0BBB-42DE-88B5-172FF3ADE34D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqx5UAAoJEIl79TGLgAm6jM8P/3BTp49TOHhZYZDYPDxhRuLJ
xh+fByiCCEh8u0X6U5cuWjD4BjpCc5TtyMyPMlty2rmlx94z0Paof4PtTxt2Lm7j
hq+lLWDFIEbc2zUDkLzu98AtsyhWjXZp4ygk7iuYHeVYXqxpB6bpGQJMLWqA6kjT
/UgovYyaFoy0PZN0IHpgF9eAXCpAY8p47gKQpJ7TCIS3DGkhnsfrg34IuuDY/V7R
xs/xKlrEuFV5Jkj0U1kibLiV5YsYbrmpSSteylstwzE6HkqsD/lYyrD6zgLlcrGt
eWSAVSg1jGQyYhDIHshZTlKWA4hMXPG1pMjXqlw0pX996ThQx6fqsifrQ7p1cJWC
s7KN7XjGBspqK9S+hvx+ho3Nh6lSHC4MYlKBRaEEpEnCoWHk52Wawcvmj2GJRtIM
BhRJ5iMJzJjw3GPAPh/V+G8EKXrZJyU7fzHfllbzRLbvA1jJ2G1wOM85pe+4225P
U7+6rmJt4eSktV+T3EWt1Y4v/Ih9e05uuVKHfSgmbyoYfr703sMNzTCkM3aCn6kJ
F9MmJOU4KqNIBjOnOpLA5z0YeNWXPwhE7AwmGBzBKBXNJhpBIEaMHixzEFhQqn83
qU/p2A5rqshLEtPdsKTpBp+bdhUzqO2tBG4MXf5HmmZMCZYPMb0K+58tt/8wwgL0
FfIb+4kZpPn6gWe1ETxO
=NGg3
-----END PGP SIGNATURE-----

--Apple-Mail=_A793DE90-0BBB-42DE-88B5-172FF3ADE34D--
