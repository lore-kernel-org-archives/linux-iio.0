Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44207 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756994Ab3HOT1O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Aug 2013 15:27:14 -0400
Date: Thu, 15 Aug 2013 21:27:11 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v2 3/4] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
Message-ID: <20130815192711.GE12162@lukather>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-4-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
In-Reply-To: <1376219071-29946-4-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sun, Aug 11, 2013 at 07:04:30PM +0800, Josh Wu wrote:
> Since in at91sam9x5, sama5d3x chip. the start up time calucation is
> changed.  This patch can choose different start up time calculation
> formula for different chips.
>=20
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> v1 --> v2:
>   add a new variable for different start_time calculation.
>=20
>  drivers/iio/adc/at91_adc.c |   42 +++++++++++++++++++++++++++++++++++---=
----
>  1 file changed, 35 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index b41eb60..9b0ffff 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -40,6 +40,7 @@
>  	(writel_relaxed(val, st->reg_base + reg))
> =20
>  struct at91_adc_caps {
> +	bool	start_time_use_lookup_tab;
>  	u32	mr_prescal_mask;
>  	u32	mr_startup_mask;
>  };
> @@ -700,13 +701,39 @@ static int at91_adc_probe(struct platform_device *p=
dev)
>  		goto error_disable_adc_clk;
>  	}
> =20
> -	/*
> -	 * Number of ticks needed to cover the startup time of the ADC as
> -	 * defined in the electrical characteristics of the board, divided by 8.
> -	 * The formula thus is : Startup Time =3D (ticks + 1) * 8 / ADC Clock
> -	 */
> -	ticks =3D round_up((st->startup_time * adc_clk_khz /
> -			  1000) - 1, 8) / 8;
> +	if (!st->caps->start_time_use_lookup_tab) {
> +		/*
> +		 * Number of ticks needed to cover the startup time of the ADC
> +		 * as defined in the electrical characteristics of the board,
> +		 * divided by 8. The formula thus is :
> +		 *   Startup Time =3D (ticks + 1) * 8 / ADC Clock
> +		 */
> +		ticks =3D round_up((st->startup_time * adc_clk_khz /
> +				  1000) - 1, 8) / 8;
> +	} else {
> +		/*
> +		 * For sama5d3x and at91sam9x5, the formula changes to:
> +		 * Startup Time =3D <lookup_table_value> / ADC Clock
> +		 */
> +		const int startup_lookup[] =3D {
> +			0  , 8  , 16 , 24 ,
> +			64 , 80 , 96 , 112,
> +			512, 576, 640, 704,
> +			768, 832, 896, 960
> +			};
> +
> +		int i, size =3D ARRAY_SIZE(startup_lookup);
> +		ticks =3D st->startup_time * adc_clk_khz / 1000;
> +		for (i =3D 0; i < size; i++)
> +			if (ticks < startup_lookup[i])
> +				break;
> +
> +		ticks =3D i;
> +		if (ticks =3D=3D size)
> +			/* Reach the end of lookup table */
> +			ticks =3D size - 1;
> +	}
> +

Maybe just declaring two different functions here to calculate the
number of ticks, and just holding the function pointer in your structure
would make things more readable and future-proof?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDSuPAAoJEBx+YmzsjxAgaywP+wQDEfCJOHksJ+ry+vVt0D3P
ypjC5eYfFylvlBBArMgKcj9ZBKyKV+jr8zZsEXN780hVo5zee4uSn6aOMlbLyvkQ
o3h57vRjFWLtB6e+S5n+iJLseOi+fzr8baemJ19qeqgZgdn5cQgZUtdVe4uyUis/
tE3k92cIbzROOSdcDz9U95e5lk84h1AtsSzJK/Nm/297kGTNW3aEuwovQMECCMTl
dHRK2dT5HQyXf/KzAIgJ/xEMsbMhsL17PWk6fggh3Frq1pLiWVR47+5cZzFZZxeF
JW4+pioadQVKe1VvGtujBvd4mE8LpblZ5dbbmyQx1uLkzYCGgQjWaaE7YqRIxHdl
tncK/ftl5eI45wDtgZPcKApT8xsaiN71gNXmKFW8Dpi5eNlhWjk6+ixSpmCEhD7r
iJcBOhVCyChAPPWzpE4g5CK+TZdLlFbghRo1zW9KDs2wgQvLTR3sTjr14vGQdq+X
qYETGV5m9LUsSEKblMEaTWoMym3RiZVZF9OYsHJNverAnyKk5xUuU2ecCWIVyhvE
kqpPcjKZYm1WHZXs1xCWN8uLJZ+VIidI8kCvQveB3h5dy+8LWp+6xOUR3eaoWM6S
udKG6jcxvntD1ph1NvWxUeZtWmUQYh9AzdK4LXzW7fUGxQKSZjcxGjLrrhx9efvQ
Y2zOad2EibJUnapqmXii
=58BL
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
