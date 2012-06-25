Return-Path: <maxime.ripard@free-electrons.com>
Message-ID: <4FE87D04.4080008@free-electrons.com>
Date: Mon, 25 Jun 2012 17:00:20 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:adc:at91: Relase mutex on error path in at91_adc_read_raw
References: <1340631780-14685-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1340631780-14685-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Lars,

You can add my
Acked-By: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

Le 25/06/2012 15:43, Lars-Peter Clausen a =E9crit :
> This issue was reported by the mini_lock.cocci coccinelle semantic patc=
h.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/at91_adc.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 6a08469..f61780a 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -349,9 +349,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  						       st->done,
>  						       msecs_to_jiffies(1000));
>  		if (ret =3D=3D 0)
> -			return -ETIMEDOUT;
> -		else if (ret < 0)
> +			ret =3D -ETIMEDOUT;
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
>  			return ret;
> +		}
> =20
>  		*val =3D st->last_value;
> =20


--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
