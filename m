Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43373 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbaH1Nf0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 Aug 2014 09:35:26 -0400
Date: Thu, 28 Aug 2014 08:34:57 -0500
From: Felipe Balbi <balbi@ti.com>
To: Vignesh R <vigneshr@ti.com>
CC: Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, <nsekhar@ti.com>,
	Felipe Balbi <balbi@ti.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Fix TSC operation after ADC
 continouous mode
Message-ID: <20140828133457.GA16689@saruman.home>
Reply-To: <balbi@ti.com>
References: <1409216820-11506-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
In-Reply-To: <1409216820-11506-1-git-send-email-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2014 at 02:37:00PM +0530, Vignesh R wrote:
> After enabling and disabling ADC continuous mode via sysfs, ts_print_raw
> fails to return any data. This is because when ADC is configured for
> continuous mode, it disables touch screen steps.These steps are not
> re-enabled when ADC continuous mode is disabled. Therefore existing values
> of REG_SE needs to be cached before enabling continuous mode and
> disabling touch screen steps and enabling ADC steps. The cached value
> are to be restored to REG_SE once ADC is disabled.
>=20
> Fixes: 7ca6740cd1cd ("The continues-read mode remains unchanged")
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>

looks like this should Cc stable

> ---
>  drivers/mfd/ti_am335x_tscadc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscad=
c.c
> index d4e860413bb5..e3076afe6b3c 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -54,7 +54,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsad=
c, u32 val)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache =3D val;
> +	tsadc->reg_se_cache |=3D val;
>  	if (tsadc->adc_waiting)
>  		wake_up(&tsadc->reg_se_wait);
>  	else if (!tsadc->adc_in_use)
> @@ -97,6 +97,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev=
 *tsadc)
>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	spin_lock_irq(&tsadc->reg_lock);
> +	tsadc->reg_se_cache |=3D val;
>  	am335x_tscadc_need_adc(tsadc);
> =20
>  	tscadc_writel(tsadc, REG_SE, val);
> --=20
> 1.7.9.5
>=20

--=20
balbi

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/zAAAAoJEIaOsuA1yqREYZIQAJyuv9kQ8ODEnKein84Yb78o
VbHUbl5fFq7YI4zdx/ofBkAzNev9VUvtsWlnmvufC6cIOoCJeiMaWcM/6BBYuWlj
y9XQ4Wv/TmCi+HkCcjDHGQV8cEYOeEJ4eQSoWB7maG92zEhMOdxg8XHuAYIFOXin
HgbHj/BXgrzKKvicxwZ7kQgwjSRwgqUhjgzvSyRsi6RXtyyLgY0zdFvUIJizY6tc
NF/ZuJWDP4CWy6Xg2OZSEU+aQnZYPohKlpm0AnQmDOQvodQHwko8u4AesIRQh6vJ
PcgfV9sIrLYES+G2W0NJqXcvbpFPOOXbFbHqey4wbqh4uYAGYhEi51xjRdg0X2VQ
f993XCgAfEouEwF/qeUqU3bbtD3Ne3aCZI5kZhaCZJvu5wGdY5OYCwQwZNgJAysl
0m+TiNijA9rW/UF4UOrY5acv0BPQx6cm7Tf+hNpq8LjTW9Zbb6mA5N1FNMyMUAdO
7l6Xv6vjRRRw3sXniByHqDJ0nOdY0vc05foA2K/lrtb3ZP5IwXVS7kEw2zRPNo6V
HESBKhPIEzWSmkFvzv9bGQpADK8eHo5Rs4+uIPdxOJzPNrgoAqrau+TPrlgbjYFN
oz/aoiY5xoaoEweGtPc70abpzV9S7CHH8oiqURrU7MXMzD/5/djZKa0iWt8FApPS
AeFb3MEfwNPgbdUzGQ5e
=pkbi
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
