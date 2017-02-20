Return-Path: <SRS0=o/U3=2B=goldelico.com=hns@kernel.org>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <776DC6E2-5D58-40F4-8866-39D9002EF772@goldelico.com>
Date: Mon, 20 Feb 2017 21:50:01 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Michel Verlaan <michel.verl@gmail.com>,
 Nick Dyer <nick@shmanahar.org>,
 Tony Lindgren <tony@atomide.com>,
 kernel@pyra-handheld.com,
 Sebastian Reichel <sre@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Aaro Koskinen <aaro.koskinen@nokia.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 linux-input@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Eric Engestrom <eric@engestrom.ch>,
 Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Igor Grinberg <grinberg@compulab.co.il>,
 linux-omap <linux-omap@vger.kernel.org>,
 Petr Cvek <petr.cvek@tul.cz>,
 Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
 Haibo Chen <haibo.chen@freescale.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-iio@vger.kernel.org,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
 Michael Welling <mwelling@ieee.org>,
 Alexander Stein <alexander.stein@systec-electronic.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Message-Id: <24001F85-AB58-4ADB-A7A3-1E9AD6F3E1AB@goldelico.com>
References: <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <20170219232918.53801560@aktux> <20170219223949.GA2470@amd> <EE81034E-C10E-4E8B-B026-B3E92C0DAA19@goldelico.com> <20170220193228.GB23745@amd> <776DC6E2-5D58-40F4-8866-39D9002EF772@goldelico.com>
To: Pavel Machek <pavel@ucw.cz>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 20.02.2017 um 21:22 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi,
>=20
>> Am 20.02.2017 um 20:32 schrieb Pavel Machek <pavel@ucw.cz>:
>>=20
>> Hi!
>>=20
>>>> But if you have userspace that depends on touchscreen to be
>>>> calibrated... that _is_ wrong.
>>>=20
>>> User-space people and real users have the opposite opinion. They
>>> prefer if a touch is plug&play. I.e. without need for calibration.
>>=20
>> Some people prefer to calibrate their touchscreens; because of
>> per-device variations, that gives better precision.
>>=20
>> You can pass default calibration data from device tree to kernel to
>> userland. But you can not force people to use that calibration.
>=20
> Yes, you can do that if you want. I hope it became clear by the =
formula
> in my last mail.

Sorry this can be completely misleading, if read in conjunction with =
your
sentences. Brevity in answers may disturb the message.

It does not mean that you can and should force people to use that =
calibration...

It means that users still can do per-device calibration and do not have
to use the pre-calibration capability of the driver. Hence we called it
pre-calibration.

>=20
> I just want to be able to do it the other way for those users who =
don't
> care about this per-device variation.
>=20
> BR,
> Nikolaus
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel


--Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq1Z6AAoJEIl79TGLgAm6DDMP/2KjPv4aWmaKFpArgEinX0oU
D/Fuu1ZG3lLCYkTnC0DbSRdmh2G52xitI6Au/F82CLNx1qhHrNWBdECmoJDNNmq6
Ej8XIM1wl8VWC8d4AnL871YwLdrRuHYgr27UbcsJTZhaZYT/L2pxDznx/NJjUojO
51aJL2JNz0XnrRf9DJenFN7O1dkJFx/yC5bXJlTnC7d/c0od4hHVRuT/Ya/VbGtF
7XwhBLnfTui8Zd4JaQZPu0LBRYI+RzX4jQW890pVPTVWWDgF/qEuahq7MuYjzGIB
rkfPhGkEWHPClCdBSHv30ESaKNNtQJKK03YtvDUMuXWAGF0JiPdqg5oqP3rCA3rA
HZ8T0be+mEspEd5KDKCf/fTvrrIjAqV7N+xMPXvXjRkrqfd9TUo6ZLy9BeFVQvaK
va/tO2fYTtH/Jfm3ucMa1Hy3FtTY8bKPdR3Q845VOV0cJ87tTaIPaZmuNaVNn9KX
euunfW0tKNolen/tdK9WQv3RHnTpPTU+K15c6FZMb25lBkLKIxmlJveq9WvCfyLQ
XBqpgn6f3CA4jvc2iP2ycpIrkhumd0Sp+H+fH9A+btv+n+wRNxynO+IzrL1g3i4D
NcAOxcxFsIp/sH+ZJ4W0zOqrrjIeIraqQrAMC/NPmHKSrEidtzkFfxPniQCHleNV
Q0Ou9KzfZGpSOkDqDb58
=l2hy
-----END PGP SIGNATURE-----

--Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F--
