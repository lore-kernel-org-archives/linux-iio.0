Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752302AbdGDTv0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jul 2017 15:51:26 -0400
Date: Tue, 4 Jul 2017 20:51:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, linux@roeck-us.net
Subject: Re: [PATCH v2] iio: Add LTC2471/LTC2473 driver
Message-ID: <20170704205122.5f7a10b1@kernel.org>
In-Reply-To: <1499063157-9977-1-git-send-email-mike.looijmans@topic.nl>
References: <1499063157-9977-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  3 Jul 2017 08:25:57 +0200
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The LTC2741 and LTC2473 are single voltage ADC chips. The LTC2473
> is similar to the LTC2471 but outputs a signed differential value.
> 
> Datasheet:
>   http://cds.linear.com/docs/en/datasheet/24713fb.pdf
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Would have been helpful if you'd included Lars'
Reviewed-by tag here (no major changes that would require
him to take another look!)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> v2: (LC) Add empty line, remove i2c_set_clientdata
>     (PS) enum ltc2471_chips
>          sizeof(buf)
>          no if in IIO_CHAN_INFO_OFFSET
>          remove .differental=0
>          Sensor Driver -> ADC driver
> 
>  drivers/iio/adc/Kconfig   |  10 +++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/ltc2471.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/iio/adc/ltc2471.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 401f47b..01fd090 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -362,6 +362,16 @@ config LPC32XX_ADC
>  	  activate only one via device tree selection.  Provides direct access
>  	  via sysfs.
>  
> +config LTC2471
> +	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Linear Technology LTC2471 and
> +	  LTC2473 16-bit I2C ADC.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called ltc2471.
> +
>  config LTC2485
>  	tristate "Linear Technology LTC2485 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9339bec..afafe85 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> +obj-$(CONFIG_LTC2471) += ltc2471.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_LTC2497) += ltc2497.o
>  obj-$(CONFIG_MAX1027) += max1027.o
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> new file mode 100644
> index 0000000..29b7ed6
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -0,0 +1,160 @@
> +/*
> + * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
> + * The LTC2473 is identical to the 2471, but reports a differential signal.
> + *
> + * Copyright (C) 2017 Topic Embedded Products
> + * Author: Mike Looijmans <mike.looijmans@topic.nl>
> + *
> + * License: GPLv2
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +enum ltc2471_chips {
> +	ltc2471,
> +	ltc2473,
> +};
> +
> +struct ltc2471_data {
> +	struct i2c_client *client;
> +};
> +
> +/* Reference voltage is 1.25V */
> +#define LTC2471_VREF 1250
> +
> +/* Read two bytes from the I2C bus to obtain the ADC result */
> +static int ltc2471_get_value(struct i2c_client *client)
> +{
> +	int ret;
> +	__be16 buf;
> +
> +	ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	/* MSB first */
> +	return be16_to_cpu(buf);
> +}
> +
> +static int ltc2471_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ltc2471_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ltc2471_get_value(data->client);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->differential)
> +			/* Output ranges from -VREF to +VREF */
> +			*val = 2 * LTC2471_VREF;
> +		else
> +			/* Output ranges from 0 to VREF */
> +			*val = LTC2471_VREF;
> +		*val2 = 16;	/* 16 data bits */
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only differential chip has this property */
> +		*val = -LTC2471_VREF;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec ltc2471_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static const struct iio_chan_spec ltc2473_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					    BIT(IIO_CHAN_INFO_OFFSET),
> +		.differential = 1,
> +	},
> +};
> +
> +static const struct iio_info ltc2471_info = {
> +	.read_raw = ltc2471_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int ltc2471_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ltc2471_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->info = &ltc2471_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	if (id->driver_data == ltc2473)
> +		indio_dev->channels = ltc2473_channel;
> +	else
> +		indio_dev->channels = ltc2471_channel;
> +	indio_dev->num_channels = 1;
> +
> +	/* Trigger once to start conversion and check if chip is there */
> +	ret = ltc2471_get_value(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Cannot read from device.\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id ltc2471_i2c_id[] = {
> +	{ "ltc2471", ltc2471 },
> +	{ "ltc2473", ltc2473 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
> +
> +static struct i2c_driver ltc2471_i2c_driver = {
> +	.driver = {
> +		.name = "ltc2471",
> +	},
> +	.probe    = ltc2471_i2c_probe,
> +	.id_table = ltc2471_i2c_id,
> +};
> +
> +module_i2c_driver(ltc2471_i2c_driver);
> +
> +MODULE_DESCRIPTION("LTC2471/LTC2473 ADC driver");
> +MODULE_AUTHOR("Topic Embedded Products");
> +MODULE_LICENSE("GPL v2");

