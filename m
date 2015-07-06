Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 5/5] iio:light:stk3310: adjust indentation
Date: Mon, 6 Jul 2015 09:34:09 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402216D8D6@IRSMSX109.ger.corp.intel.com>
References: <cover.1436024257.git.knaack.h@gmx.de>
 <4d3814bde208bce5f8257da0df7badc3787187ff.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <4d3814bde208bce5f8257da0df7badc3787187ff.1436024257.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Saturday, July 4, 2015 6:57 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 5/5] iio:light:stk3310: adjust indentation
>=20
> Adjust some indentation issues as spotted by checkpatch.pl --strict
>=20
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/light/stk3310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c in=
dex
> be715c7..2760f67 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -385,7 +385,7 @@ static int stk3310_write_raw(struct iio_dev
> *indio_dev,
>  			ret =3D regmap_field_write(data->reg_ps_it, index);
>  		if (ret < 0)
>  			dev_err(&data->client->dev,
> -					"sensor configuration failed\n");
> +				"sensor configuration failed\n");
>  		mutex_unlock(&data->lock);
>  		return ret;
>=20
> @@ -402,7 +402,7 @@ static int stk3310_write_raw(struct iio_dev
> *indio_dev,
>  			ret =3D regmap_field_write(data->reg_ps_gain, index);
>  		if (ret < 0)
>  			dev_err(&data->client->dev,
> -					"sensor configuration failed\n");
> +				"sensor configuration failed\n");
>  		mutex_unlock(&data->lock);
>  		return ret;
>  	}
> @@ -649,7 +649,7 @@ static int stk3310_probe(struct i2c_client *client,
>  						STK3310_EVENT, indio_dev);
>  		if (ret < 0) {
>  			dev_err(&client->dev, "request irq %d failed\n",
> -					client->irq);
> +				client->irq);
>  			goto err_unregister;
>  		}
>  	}
> --
> 2.3.6
