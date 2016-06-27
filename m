Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46441 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbcF0Q4v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 12:56:51 -0400
Date: Mon, 27 Jun 2016 18:56:49 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/10 v3] iio: pressure: bmp280: support supply
 regulators
In-Reply-To: <1467045020-2665-5-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.02.1606271854230.5271@pmeerw.net>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org> <1467045020-2665-5-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Jun 2016, Linus Walleij wrote:

> The BMP058/BMP180/BMP280 is supplied with two power sources:

BMP085
and comment below

> VDDA (analog power) and VDDD (digital power). As these may come
> from regulators (as on the APQ8060 Dragonboard) we need the driver
> to attempt to fetch and enable these regulators.
> 
> We FAIL if we cannot: boards should either define:
> - Proper regulators if present
> - Define fixed regulators if power is hardwired to the component
> - Rely on dummy regulators (will be present on all DT systems and
>   any boardfile system that calls regulator_has_full_constraints().
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Encode a start-up time for each sensor type (from the datasheets)
>   this is necessary when coldstarting the sensor with a regulator
>   to be sure it is on before we try to use it.
> - Introduce a try/catch-style set of goto clauses in the probe
>   function to make sure the regulators are properly disabled.
> ChangeLog v1->v2:
> - Make the regulators non-optional: an optional supply is one you
>   can choose not to supply ELECTRICALLY as in an internal charge
>   pump taking its place or so.
> - Bail out if not present and add some notices to the commit that
>   boards need to think about their regulator usage.
> - Make sure we disable the regulators, and introduce a .remove()
>   call to do that if/when the module is removed.
> ---
>  drivers/iio/pressure/bmp280.c | 64 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index 1618968f8889..d895973a966d 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -24,6 +24,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
>  
>  /* BMP280 specific registers */
>  #define BMP280_REG_HUMIDITY_LSB		0xFE
> @@ -124,6 +125,9 @@ struct bmp280_data {
>  	struct mutex lock;
>  	struct regmap *regmap;
>  	const struct bmp280_chip_info *chip_info;
> +	struct regulator *vddd;
> +	struct regulator *vdda;
> +	unsigned int start_up_time; /* in milliseconds */
>  
>  	/* log of base 2 of oversampling rate */
>  	u8 oversampling_press;
> @@ -1047,12 +1051,14 @@ static int bmp280_probe(struct i2c_client *client,
>  		data->chip_info = &bmp180_chip_info;
>  		data->oversampling_press = ilog2(8);
>  		data->oversampling_temp = ilog2(1);
> +		data->start_up_time = 10;
>  		break;
>  	case BMP280_CHIP_ID:
>  		indio_dev->num_channels = 2;
>  		data->chip_info = &bmp280_chip_info;
>  		data->oversampling_press = ilog2(16);
>  		data->oversampling_temp = ilog2(2);
> +		data->start_up_time = 2;
>  		break;
>  	case BME280_CHIP_ID:
>  		indio_dev->num_channels = 3;
> @@ -1060,11 +1066,37 @@ static int bmp280_probe(struct i2c_client *client,
>  		data->oversampling_press = ilog2(16);
>  		data->oversampling_humid = ilog2(16);
>  		data->oversampling_temp = ilog2(2);
> +		data->start_up_time = 2;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> +	/* Bring up regulators */
> +	data->vddd = devm_regulator_get(&client->dev, "vddd");
> +	if (IS_ERR(data->vddd)) {
> +		dev_err(&client->dev, "failed to get VDDD regulator\n");
> +		return PTR_ERR(data->vddd);
> +	}
> +	ret = regulator_enable(data->vddd);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable VDDD regulator\n");
> +		return ret;
> +	}
> +	data->vdda = devm_regulator_get(&client->dev, "vdda");
> +	if (IS_ERR(data->vdda)) {
> +		dev_err(&client->dev, "failed to get VDDA regulator\n");
> +		ret = PTR_ERR(data->vddd);
> +		goto out_disable_vddd;
> +	}
> +	ret = regulator_enable(data->vdda);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable VDDA\n");

maybe add 'regulator'

> +		goto out_disable_vddd;
> +	}
> +	/* Wait to make sure we started up properly */
> +	mdelay(data->start_up_time);
> +
>  	/* Bring chip out of reset if there is an assigned GPIO line */
>  	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
>  	/* Deassert the signal */
> @@ -1077,7 +1109,8 @@ static int bmp280_probe(struct i2c_client *client,
>  					data->chip_info->regmap_config);
>  	if (IS_ERR(data->regmap)) {
>  		dev_err(&client->dev, "failed to allocate register map\n");
> -		return PTR_ERR(data->regmap);
> +		ret = PTR_ERR(data->regmap);
> +		goto out_disable_vdda;
>  	}
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
> @@ -1086,14 +1119,36 @@ static int bmp280_probe(struct i2c_client *client,
>  	if (chip_id != id->driver_data) {
>  		dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
>  			BMP280_CHIP_ID, chip_id);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_disable_vdda;
>  	}
>  
>  	ret = data->chip_info->chip_config(data);
>  	if (ret < 0)
> -		return ret;
> +		goto out_disable_vdda;
> +
> +	i2c_set_clientdata(client, data);
>  
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret)
> +		goto out_disable_vdda;
> +
> +	return 0;
> +
> +out_disable_vdda:
> +	regulator_disable(data->vdda);
> +out_disable_vddd:
> +	regulator_disable(data->vddd);
> +	return ret;
> +}
> +
> +static int bmp280_remove(struct i2c_client *client)
> +{
> +	struct bmp280_data *data = i2c_get_clientdata(client);
> +
> +	regulator_disable(data->vdda);
> +	regulator_disable(data->vddd);
> +	return 0;
>  }
>  
>  static const struct acpi_device_id bmp280_acpi_match[] = {
> @@ -1134,6 +1189,7 @@ static struct i2c_driver bmp280_driver = {
>  		.of_match_table = of_match_ptr(bmp280_of_match),
>  	},
>  	.probe		= bmp280_probe,
> +	.remove		= bmp280_remove,
>  	.id_table	= bmp280_id,
>  };
>  module_i2c_driver(bmp280_driver);
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
