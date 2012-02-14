Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47243 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab2BNRJe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2012 12:09:34 -0500
Date: Tue, 14 Feb 2012 18:09:31 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Roland Stigge <stigge@antcom.de>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kevin.wells@nxp.com, jic23@cam.ac.uk
Subject: Re: [PATCH v2] ARM: LPC32xx: ADC support
Message-ID: <20120214170931.GA2523@pengutronix.de>
References: <1329077345-15305-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <1329077345-15305-1-git-send-email-stigge@antcom.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2012 at 09:09:05PM +0100, Roland Stigge wrote:
> This patch adds a 3-channel ADC driver for the LPC32xx ARM SoC
>=20
> Signed-off-by: Roland Stigge <stigge@antcom.de>

You need to split the mach-specific stuff and the driver, then submit
them seperately via the respective maintainers.

> Index: linux-arm-soc/arch/arm/mach-lpc32xx/phy3250.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-arm-soc.orig/arch/arm/mach-lpc32xx/phy3250.c	2012-02-12 20:04:4=
9.000000000 +0100
> +++ linux-arm-soc/arch/arm/mach-lpc32xx/phy3250.c	2012-02-12 20:17:13.000=
000000 +0100
> @@ -252,6 +252,9 @@
>  	&lpc32xx_i2c2_device,
>  	&lpc32xx_watchdog_device,
>  	&lpc32xx_gpio_led_device,
> +#if defined(CONFIG_LPC32XX_ADC)
> +	&lpc32xx_adc_device,
> +#endif

Probably personal taste, yet I'd skip the #ifdef.

The rest of the mach stuff looks fine to me.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk86lUsACgkQD27XaX1/VRsVHgCfcUPsNNsPsGQEcw8B8jk/IZw8
ehcAnjnRqyV+7gTFZVF3yB78iwURQu8M
=vRDu
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
