Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37753 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdBSNEY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 08:04:24 -0500
Subject: Re: [PATCH 1/4] iio: accel: adxl345: Use I2C regmap instead of direct
 I2C access
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-2-git-send-email-eraretuya@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f0fa3bdc-2a31-a704-7bff-e56dada6948f@kernel.org>
Date: Sun, 19 Feb 2017 13:04:01 +0000
MIME-Version: 1.0
In-Reply-To: <1487239327-21406-2-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/17 10:02, Eva Rachel Retuya wrote:
> Convert the driver to use regmap instead of I2C-specific functions. This
> is done in preparation for splitting this driver into core and
> I2C-specific code as well as introduction of SPI driver.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
One minor point inline.

Jonathan
> ---
>  drivers/iio/accel/Kconfig   |  1 +
>  drivers/iio/accel/adxl345.c | 43 +++++++++++++++++++++++++++++++------------
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 2308bac..26b8614 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -9,6 +9,7 @@ config ADXL345
>  	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
>  	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  Say Y here if you want to build support for the Analog Devices
>  	  ADXL345 3-axis digital accelerometer.
> diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345.c
> index c34991f..a1fdf60 100644
> --- a/drivers/iio/accel/adxl345.c
> +++ b/drivers/iio/accel/adxl345.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -46,9 +47,15 @@ static const int adxl345_uscale = 38300;
>  
>  struct adxl345_data {
>  	struct i2c_client *client;
> +	struct regmap *regmap;
>  	u8 data_range;
>  };
>  
> +static const struct regmap_config adxl345_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
>  #define ADXL345_CHANNEL(reg, axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
> @@ -70,6 +77,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adxl345_data *data = iio_priv(indio_dev);
>  	int ret;
> +	__le16 regval;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -78,11 +86,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
>  		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
>  		 */
> -		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> +				       sizeof(regval));
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(ret, 12);
> +		*val = sign_extend32(le16_to_cpu(regval), 12);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> @@ -104,15 +113,24 @@ static int adxl345_probe(struct i2c_client *client,
>  {
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
>  	int ret;
> +	u32 regval;
> +
> +	regmap = devm_regmap_init_i2c(client, &adxl345_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Error initializing regmap: %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
>  
> -	ret = i2c_smbus_read_byte_data(client, ADXL345_REG_DEVID);
> +	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Error reading device ID: %d\n", ret);
>  		return ret;
>  	}
>  
> -	if (ret != ADXL345_DEVID) {
> +	if (regval != ADXL345_DEVID) {
>  		dev_err(&client->dev, "Invalid device ID: %d\n", ret);
>  		return -ENODEV;
>  	}
> @@ -124,11 +142,12 @@ static int adxl345_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
Leaving client behind means that you have a driver that is still implicitly
associated with i2c in more places than it should be.  I'd normally expect
to either see all the access to the underlying dev done through a local
copy of the client's device pointer, or through the device pointer that
can be retrieved form the regmap.

> +	data->regmap = regmap;
>  	/* Enable full-resolution mode */
>  	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_DATA_FORMAT,
> -					data->data_range);
> +	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> +			   data->data_range);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to set data range: %d\n", ret);
>  		return ret;
> @@ -142,8 +161,8 @@ static int adxl345_probe(struct i2c_client *client,
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  
>  	/* Enable measurement mode */
> -	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> -					ADXL345_POWER_CTL_MEASURE);
> +	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> +			   ADXL345_POWER_CTL_MEASURE);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to enable measurement mode: %d\n",
>  			ret);
> @@ -153,8 +172,8 @@ static int adxl345_probe(struct i2c_client *client,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "iio_device_register failed: %d\n", ret);
> -		i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> -					  ADXL345_POWER_CTL_STANDBY);
> +		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> +			     ADXL345_POWER_CTL_STANDBY);
>  	}
>  
>  	return ret;
> @@ -167,8 +186,8 @@ static int adxl345_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	return i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> -					 ADXL345_POWER_CTL_STANDBY);
> +	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> +			    ADXL345_POWER_CTL_STANDBY);
>  }
>  
>  static const struct i2c_device_id adxl345_i2c_id[] = {
> 

