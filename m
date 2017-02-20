Return-Path: <SRS0=o/U3=2B=goldelico.com=hns@kernel.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <201702202208.50498@pali>
Date: Mon, 20 Feb 2017 22:27:39 +0100
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
 Pavel Machek <pavel@ucw.cz>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Haibo Chen <haibo.chen@freescale.com>
Message-Id: <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali> <201702202208.50498@pali>
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> Am 20.02.2017 um 22:08 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
>=20
> On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
>> Hi Nikolaus!
>>=20
>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>>> Hi Dmitry,
>>>=20
>>>> Input driver may set resolution for given axis in units per mm
>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
>>>> ABS_RZ), and if you check the binding, you can use
>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
>>>> entire touch surface and set resolution from it so that
>>>> userspace can calculate the proper scaling factor.
>>>=20
>>> How is this information exposed by the kernel to user-space? By
>>> scanning the DT file or tree?
>>=20
>> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
>> ioctl() on input device. Look at struct input_absinfo, you should
>> have all needed information here. This is generic input interface,
>> no DT is needed.
>=20
> Looking at kernel code... via EVIOCSABS ioctl() you can even set
> resolution from userspace for specified input device.
>=20
> So this could be potentially used for calibrating input device from
> userspace? (In case DT data will not fully match current HW)
>=20
>> I hope that XServer is already using it for evdev devices...
>>=20
>> For whole implementation look at evtest program. That should be good
>> starting point for your userspace implementation.
>>=20
>> While I'm watching this discussion... in my opinion kernel should
>> just invert input axes (when needed)

It is questionable why it should do that at all then.

User-Space can also easily do it. Either the driver should provide raw
data only or if it does pre-processing (scaling by +/-1), why exclude
pre-scaling by other factors?

>> and should not do any other
>> normalization or integer/floating-point
>> re-calibration/re-calculation. If it correctly exports minimum
>> value, maximum value and resolution then userspace can correctly
>> re-scale input events to units which userspace needs (e.g. mapping
>> into LCD screen pixels or whatever is needed).
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com


--Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq19LAAoJEIl79TGLgAm644gQALBIU3doHmJLuu/w4V608d7D
Y1r6IwKjUc0QbFDu7UufKehYRgW/fN3LMbgl+w/gddudIts+Rntrf2AY/P8q4FS3
cYWJ34WBApV8ITuwxLhfAb0ErGBsxYCA4VMTUJmyj5tiGkXdPqO/Sa0+/4GhSaNe
8gelyT7WintA05hK0vuo5b9StfvJm6Zn/9I53DDFjQtnM113YIa/oJ8HFtybXsc/
tcGOPbihkF/El6pvu+M6z3Nnyf0IJZtu6DEzKuxUwVkYuEE54d8zWlxups4gpsVJ
LQ+gu8PlrGjNWYbBnl8nx7AZvEM+rVcr7Y+lrgZ2qQe/UAsM6M90DvMxlfqlvbIp
DcRJiFAAoAlr+NWShtVba7T6qohuBkdAasLRE/rYuiILALzDn5XDD5s4px3WqrMC
T2Ual/Xhd8Xp8bsEjCicBaJSvdl13YNXYTrk2oe8velvr1t4fHrvOiW0XapDZjBN
JwJDH8uS+IDqPfs8WfODTIUayHTAqrM3Tc4CdC8aQQMcMRIE9OOJJabHAKkITdc1
XSmx++KzhzZ8+TFScrrRX7lX8simDl8zOrddlnk7jmE8U4Xg9PL/0/eqEl2zkKy/
FFo9vZo1T45bnw7r01qu3eR+Zwz78JP5A/MwDkXkSHSBONmFDIo9HwlSPlS97+iV
JNK/P+YMOGulEA3gmaHB
=nfv3
-----END PGP SIGNATURE-----

--Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F--
