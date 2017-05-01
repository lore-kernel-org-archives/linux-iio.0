Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57463 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376629AbdEAJ16 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 05:27:58 -0400
Date: Mon, 1 May 2017 11:27:54 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/7] hwmon: twl4030-madc: drop driver
Message-ID: <20170501092754.wgwhbrjjigpc7xjf@earth>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-2-sebastian.reichel@collabora.co.uk>
 <20170427165159.GB30189@roeck-us.net>
 <567f0680-abe9-790e-aea7-65c98ae0698a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4mcfwyvdrigzennk"
In-Reply-To: <567f0680-abe9-790e-aea7-65c98ae0698a@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--4mcfwyvdrigzennk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 30, 2017 at 05:41:05PM +0100, Jonathan Cameron wrote:
> On 27/04/17 17:51, Guenter Roeck wrote:
> > On Thu, Apr 27, 2017 at 05:30:06PM +0200, Sebastian Reichel wrote:
> >> This driver is no longer needed:
> >>
> >>  * It has no mainline users
> >>  * It has no DT support and OMAP is DT only
> >>  * iio-hwmon can be used for madc, which also works with DT
> >>
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >=20
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> >=20
> > ... assuming this will be pushed through the same tree as the rest
> > of the series. Let me know if I should queue it up in hwmon for v4.12.
> We are too late for the series to go through IIO for the 4.12 cycle, so I=
 guess it
> makes sense to take this one through hwmon if you still have time.
>=20
> I can then pick up the rest once I have acks from Wolfram
> (who should have been cc'd as we are hoovering up things from the
> i2c directories in this series)

$ ./scripts/get_maintainer.pl -f include/linux/i2c/twl4030-madc.h
linux-kernel@vger.kernel.org (open list)

This directory contains headers for random i2c chips
and Wolfram maintains the bus drivers (and is already
overloaded with work afaik), so I did not Cc him.

> + power supply side of things.

I just send my pull-request for 4.12. I will queue this up for my
early -rc/late merge window pull-request.

-- Sebastian

--4mcfwyvdrigzennk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkG/5cACgkQ2O7X88g7
+ppyCQ/+OSbCHhn1A/HWU0qbgFUd0iNJt/M4pN0YxOMrdlgw1+KRnD0wK8G2R0KZ
BQg9VmAEe1LdasNLvv3LgLTPKAyWD8wtr1dE5rNjVbZv8RRQdmLzjZhYr2v/8O0R
EozadcpQDA1D4Srb1ixZcp3IX/RlTTcUGcF/pMZOD2ZjpVN7GvX36vZ1kFfu5ean
+YA6x3nbG0hbZPcrMutey8t70WTnlHgPx+24HzBV08taWjfekFs0dHpKZ1hjBMuj
ZnjUNtqj2eNShQpeQpHM1pVokUDBFf3gVbWD66F4MzgYNBbNgMX3w93FztBkruEh
eIpjYS51KFN20Mf1ubPdv0HG1cEoBMKCqD4Gv7N0JHb1s742456zp+8jY1ed3uMC
rQU9BNQlQ5zzBFEGff5pDb/jD1mh/N90G1vMI8U21WFoeIGVv1L/tYmqAETZGFO8
0ocgiMSGMh0R2ivkbbwmkDfwIQsD1xyY/rJ879Ox2j66usbvLUqddvds+5axtnxl
1HOcXrUpTHXfAKt5FntJuUJSLkuArAoCSjIhfG95nMr0Gj1FITDxCiSjmoGLrB/U
FYxcRyGgD3IymG2zoTzmSHfcX/n/Rn0GEfjHCp0UYR2J8dBix6pnOPyGSWPmtqt8
gMUWh7N4SrH8457h0n+iQctVNooQsaOfuzk0FNZqR+H7q0AcKFA=
=VcoC
-----END PGP SIGNATURE-----

--4mcfwyvdrigzennk--
