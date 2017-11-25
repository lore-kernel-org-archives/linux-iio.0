Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:12381 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750819AbdKYUtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Nov 2017 15:49:22 -0500
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Guenter Roeck <linux@roeck-us.net>
CC: Maciej Purski <m.purski@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Jean Delvare" <jdelvare@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] hwmon: (ina2xx) Make calibration register value fixed
Date: Sat, 25 Nov 2017 21:49:14 +0100
Message-ID: <1765425.OcFVFKOaMc@pebbles>
In-Reply-To: <90ceee91-de0e-456f-b0c9-9274973ac02b@roeck-us.net>
References: <1511364735-16818-1-git-send-email-m.purski@samsung.com> <1511364735-16818-3-git-send-email-m.purski@samsung.com> <90ceee91-de0e-456f-b0c9-9274973ac02b@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2485776.OalhKULJmM";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart2485776.OalhKULJmM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, November 25, 2017 7:50:16 PM CET Guenter Roeck wrote:
> On 11/22/2017 07:32 AM, Maciej Purski wrote:
> > Calibration register is used for calculating current register in
> > hardware according to datasheet:
> > current =3D shunt_volt * calib_register / 2048 (ina 226)
> > current =3D shunt_volt * calib_register / 4096 (ina 219)
> >=20
> > Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
> > order to avoid truncation error and provide best precision allowed
> > by shunt_voltage measurement. Make current scale value follow changes
> > of shunt_resistor from sysfs as calib_register value is now fixed.
> >=20
> > Power_lsb value should also follow shunt_resistor changes as stated in
> > datasheet:
> > power_lsb =3D 25 * current_lsb (ina 226)
> > power_lsb =3D 20 * current_lsb (ina 219)
> >=20
> > Signed-off-by: Maciej Purski <m.purski@samsung.com>
>=20
> Setting the calibration register to a specific value may optimize precisi=
on,
> but limits the supported value range, which is the whole point of providi=
ng
> a calibration register. What am I missing here ?

=46or the current register, any different calibration register value is=20
completely useless - smaller values just truncate the register value, large=
r=20
values adds noise in the lsbs. Both registers (current/shunt voltage) are=20
16bit, and nothing is going to change that.

There is a *very* small allowed power operating area where scaling down wou=
ld=20
be of any use:
1. Bus voltage exceeds 25 (20) Volts
2. Shunt voltage is about 82 (320) mV

In this case the power register overflows. More specifically, if:
(shunt_voltage [mv] / 81.92) * (bus_voltage [V] / 25) > 1

Maximum allowed bus voltage is 36 V resp 26 V. (ina226/219).

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2485776.OalhKULJmM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWhnXSgAKCRBvf0o9jP6q
U3niAJ456l1DjlwQN8qLbPTSZl0MxB526gCgrxpT9ghjxcdywvODHcUg/B4+kYA=
=9aEm
-----END PGP SIGNATURE-----

--nextPart2485776.OalhKULJmM--
