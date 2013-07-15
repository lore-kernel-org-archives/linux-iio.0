Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 15 Jul 2013 14:52:13 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com
Subject: Re: [PATCH 1/5] iio: at91: use adc_clk_khz to make the calculation
 not easy to large than u32.
Message-ID: <20130715125213.GB2962@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-2-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
In-Reply-To: <1373789069-11604-2-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sun, Jul 14, 2013 at 04:04:25PM +0800, Josh Wu wrote:
> for example, if adc_clk is 20Mhz and start-up time set as larger than 215=
us.
> then the calculation "st->startup_time * adc_clk_khz" will out of u32.
>=20
> In this patch, it will use khz unit for adc_clk, that avoids above proble=
m.
>=20
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Maybe we can have a slightly better commit log here, like:

------8<-----------
iio: at91: Fix adc_clk overflow

The adc_clk variable is currently defined using a 32-bits unsigned
integer, which will overflow under some very valid range of operations.

Such overflow will occur if, for example, the parent clock is set to a
20MHz frequency and the ADC startup time is larger than 215ns.

To fix this, introduce an intermediate variable holding the clock rate
in kHz.

--------8<---------------

Or something like that.

For the patch itself, I'm happy about it. You can add my Acked-by.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR4/B9AAoJEBx+YmzsjxAg9NUP/jAWw7NnRa4NbSbg9ifSFPWD
0IZzNM/gAYoRJZe/IOPu95I+WOk1LL8l18Cb7g/akLaILuM1faGeqlyGDKEokFF6
Z4rcXRuv3sHL8l8soHZp5jdtJHlIru5jyVL2uji7JYU5DP3QZ/+DZHKubfV8pgLN
mSUhIlf0r6OxE/8tXmW81p6FS101nGaox1+vIQkWjAlifR+DTHLYKuPyk3VZZnxC
GpPJO+UY0U3uJRWuJKFSlO2N4oqMS9uvJ0qeyTcXUjDFtuYCyh72XhIHOkNLDP3w
HMXfBR1t3bYIgZY/IOVYSCH8gaGNW8PzADvC6OWn7IWQUVM5qvJoQXYacQz/mqUk
1anoF6uWl/WrlXFD2aBtXkWxMmMnCdOYL/uM30k3Ukn80v+HQWoiE3XXawayFw3G
fOW4VmWInbQUlPV74EOZbfAlmVXgwAJyDHSxcxIVUVpyEUouqXL/+EK6+t6t4bKO
Ojs5k2kSIyADVQEfEsBYJTepyQeEvaKezcvGwGyNlO8ftCeuE1+77CLgM2AB1Wwh
xFI2Hojx3v91ZuvkJbYmzESfGJOutI9UrJtfAmlyBMPJcgqF+32VyEFKo7QAacM9
uzT3DC+xeozbojEyCSb+jSCVeJqvq9WQK8NCWEFhOesvLAUeYukXy+2Q+eYVpEFz
6HJhcBg0s8w9gRwADJRI
=fmbW
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
