Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44386 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbcDLFXn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Apr 2016 01:23:43 -0400
Date: Tue, 12 Apr 2016 07:23:41 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Ranostay <matt.ranostay@intel.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/3] iio: pressure: bmp280: add initial support for
 multiple chips
In-Reply-To: <1460438494-16135-2-git-send-email-matt.ranostay@intel.com>
Message-ID: <alpine.DEB.2.20.12.1604120722430.31934@pmeerw.net>
References: <1460438494-16135-1-git-send-email-matt.ranostay@intel.com> <1460438494-16135-2-git-send-email-matt.ranostay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Bosch has several chipsets that use BMP280 as core features, this enables
> chip information for each variant.

these patches clash with work to add BMP180 to the same driver, Akinobu 
Mita was first :)
 
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---
>  drivers/iio/pressure/bmp280.c | 59 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index a2602d8dd6d5..2e7cff38f5ff 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -66,12 +66,15 @@
>  #define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
>  
>  #define BMP280_CHIP_ID			0x58
> +#define BME280_CHIP_ID			0x60
> +
>  #define BMP280_SOFT_RESET_VAL		0xB6
>  
>  struct bmp280_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	struct regmap *regmap;
> +	struct bmp280_chip_info *chip;
>  
>  	/*
>  	 * Carryover value from temperature conversion, used in pressure
> @@ -80,6 +83,24 @@ struct bmp280_data {
>  	s32 t_fine;
>  };
>  
> +enum { bmp280, bme280 };
> +
> +struct bmp280_chip_info {
> +	int id;
> +	int num_channels;
> +};
> +
> +static struct bmp280_chip_info bmp280_chip_info_table[] = {
> +	[bmp280] = {
> +		.id = BMP280_CHIP_ID,
> +		.num_channels = 2,
> +	},
> +	[bme280] = {
> +		.id = BME280_CHIP_ID,
> +		.num_channels = 2,
> +	},
> +};
> +
>  /*
>   * These enums are used for indexing into the array of compensation
>   * parameters.
> @@ -344,6 +365,20 @@ static int bmp280_chip_init(struct bmp280_data *data)
>  	return ret;
>  }
>  
> +static int bmp280_match_acpi_device(struct device *dev,
> +				    struct bmp280_chip_info **chipset)
> +{
> +	const struct acpi_device_id *id;
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	*chipset = &bmp280_chip_info_table[id->driver_data];
> +
> +	return 0;
> +}
> +
>  static int bmp280_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -357,13 +392,25 @@ static int bmp280_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +
> +	if (id) {
> +		data->chip = &bmp280_chip_info_table[id->driver_data];
> +	} else if (ACPI_HANDLE(&client->dev)) {
> +		ret = bmp280_match_acpi_device(&client->dev, &data->chip);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		/* Don't break sysfs registration of BMP280 devices */
> +		data->chip = &bmp280_chip_info_table[bmp280];
> +	}
> +
>  	mutex_init(&data->lock);
>  	data->client = client;
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->name = id->name;
>  	indio_dev->channels = bmp280_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(bmp280_channels);
> +	indio_dev->num_channels = data->chip->num_channels;
>  	indio_dev->info = &bmp280_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> @@ -376,9 +423,9 @@ static int bmp280_probe(struct i2c_client *client,
>  	ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
>  	if (ret < 0)
>  		return ret;
> -	if (chip_id != BMP280_CHIP_ID) {
> +	if (chip_id != data->chip->id) {
>  		dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
> -			BMP280_CHIP_ID, chip_id);
> +			data->chip->id, chip_id);
>  		return -EINVAL;
>  	}
>  
> @@ -390,13 +437,15 @@ static int bmp280_probe(struct i2c_client *client,
>  }
>  
>  static const struct acpi_device_id bmp280_acpi_match[] = {
> -	{"BMP0280", 0},
> +	{"BMP0280", bmp280},
> +	{"BME0280", bme280},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>  
>  static const struct i2c_device_id bmp280_id[] = {
> -	{"bmp280", 0},
> +	{"bmp280", bmp280},
> +	{"bme280", bme280},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bmp280_id);
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
