Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbeJHCNj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 22:13:39 -0400
Date: Sun, 7 Oct 2018 20:05:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
        <u.kleine-koenig@pengutronix.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] iio: ssp_sensors: don't manually free devm managed
 resources
Message-ID: <20181007200519.5e731736@archlinux>
In-Reply-To: <20181005194830.9332-1-u.kleine-koenig@pengutronix.de>
References: <20181005194830.9332-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  5 Oct 2018 21:48:30 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The charme of devm_* functions is that you don't need to care about them
> in the error path. In this case it is valid to just return NULL which mak=
es
> the device fail to probe and then the two gpios and the allocated memory
> are freed automatically by the driver core.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/commo=
n/ssp_sensors/ssp_dev.c
> index af3aa38f67cd..9e13be2c0cb9 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -462,43 +462,35 @@ static struct ssp_data *ssp_parse_dt(struct device =
*dev)
> =20
>  	data->mcu_ap_gpio =3D of_get_named_gpio(node, "mcu-ap-gpios", 0);
>  	if (data->mcu_ap_gpio < 0)
> -		goto err_free_pd;
> +		return NULL;
> =20
>  	data->ap_mcu_gpio =3D of_get_named_gpio(node, "ap-mcu-gpios", 0);
>  	if (data->ap_mcu_gpio < 0)
> -		goto err_free_pd;
> +		return NULL;
> =20
>  	data->mcu_reset_gpio =3D of_get_named_gpio(node, "mcu-reset-gpios", 0);
>  	if (data->mcu_reset_gpio < 0)
> -		goto err_free_pd;
> +		return NULL;
> =20
>  	ret =3D devm_gpio_request_one(dev, data->ap_mcu_gpio, GPIOF_OUT_INIT_HI=
GH,
>  				    "ap-mcu-gpios");
>  	if (ret)
> -		goto err_free_pd;
> +		return NULL;
> =20
>  	ret =3D devm_gpio_request_one(dev, data->mcu_reset_gpio,
>  				    GPIOF_OUT_INIT_HIGH, "mcu-reset-gpios");
>  	if (ret)
> -		goto err_ap_mcu;
> +		return NULL;
> =20
>  	match =3D of_match_node(ssp_of_match, node);
>  	if (!match)
> -		goto err_mcu_reset_gpio;
> +		return NULL;
> =20
>  	data->sensorhub_info =3D match->data;
> =20
>  	dev_set_drvdata(dev, data);
> =20
>  	return data;
> -
> -err_mcu_reset_gpio:
> -	devm_gpio_free(dev, data->mcu_reset_gpio);
> -err_ap_mcu:
> -	devm_gpio_free(dev, data->ap_mcu_gpio);
> -err_free_pd:
> -	devm_kfree(dev, data);
> -	return NULL;
>  }
>  #else
>  static struct ssp_data *ssp_parse_dt(struct device *pdev)
