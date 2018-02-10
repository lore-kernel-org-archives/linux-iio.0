Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeBJPtL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Feb 2018 10:49:11 -0500
Date: Sat, 10 Feb 2018 15:49:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, martinbv@mothictech.com
Subject: Re: [PATCH v5 2/2] iio: ad5272: Add support for Analog Devices
 digital potentiometers
Message-ID: <20180210154907.0b33f2a0@archlinux>
In-Reply-To: <1518137847-63381-3-git-send-email-preid@electromag.com.au>
References: <1518137847-63381-1-git-send-email-preid@electromag.com.au>
        <1518137847-63381-3-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  9 Feb 2018 08:57:27 +0800
Phil Reid <preid@electromag.com.au> wrote:

> Add implementation for Analog Devices AD5272 and AD5274 digital
> potentiometer devices.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/Kconfig  |  10 ++
>  drivers/iio/potentiometer/Makefile |   1 +
>  drivers/iio/potentiometer/ad5272.c | 231 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 242 insertions(+)
>  create mode 100644 drivers/iio/potentiometer/ad5272.c
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 8bf2825..8daf6d1 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -5,6 +5,16 @@
>  
>  menu "Digital potentiometers"
>  
> +config AD5272
> +	tristate "Analog Devices AD5272 and similar Digital Potentiometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Analog Devices AD5272 and AD5274
> +	  digital potentiometer chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5272.
> +
>  config DS1803
>  	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
>  	depends on I2C
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 1afd1e7..dbc139c 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD5272) += ad5272.o
>  obj-$(CONFIG_DS1803) += ds1803.o
>  obj-$(CONFIG_MAX5481) += max5481.o
>  obj-$(CONFIG_MAX5487) += max5487.o
> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
> new file mode 100644
> index 0000000..154f9a5
> --- /dev/null
> +++ b/drivers/iio/potentiometer/ad5272.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices AD5272 digital potentiometer driver
> + * Copyright (C) 2018 Phil Reid <preid@electromag.com.au>
> + *
> + * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5272_5274.pdf
> + *
> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
> + * ad5272	1	1024		20, 50, 100		01011xx
> + * ad5274	1	256		20, 100			01011xx
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +#define  AD5272_RDAC_WR  1
> +#define  AD5272_RDAC_RD  2
> +#define  AD5272_RESET    4
> +#define  AD5272_CTL      7
> +
> +#define  AD5272_RDAC_WR_EN  BIT(1)
> +
> +struct ad5272_cfg {
> +	int max_pos;
> +	int kohms;
> +	int shift;
> +};
> +
> +enum ad5272_type {
> +	AD5272_020,
> +	AD5272_050,
> +	AD5272_100,
> +	AD5274_020,
> +	AD5274_100,
> +};
> +
> +static const struct ad5272_cfg ad5272_cfg[] = {
> +	[AD5272_020] = { .max_pos = 1024, .kohms = 20 },
> +	[AD5272_050] = { .max_pos = 1024, .kohms = 50 },
> +	[AD5272_100] = { .max_pos = 1024, .kohms = 100 },
> +	[AD5274_020] = { .max_pos = 256,  .kohms = 20,  .shift = 2 },
> +	[AD5274_100] = { .max_pos = 256,  .kohms = 100, .shift = 2 },
> +};
> +
> +struct ad5272_data {
> +	struct i2c_client       *client;
> +	struct mutex            lock;
> +	const struct ad5272_cfg *cfg;
> +	u8                      buf[2] ____cacheline_aligned;
> +};
> +
> +static const struct iio_chan_spec ad5272_channel = {
> +	.type = IIO_RESISTANCE,
> +	.output = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +};
> +
> +static int ad5272_write(struct ad5272_data *data, int reg, int val)
> +{
> +	int ret;
> +
> +	data->buf[0] = (reg << 2) | ((val >> 8) & 0x3);
> +	data->buf[1] = (u8)val;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_master_send(data->client, data->buf, sizeof(data->buf));
> +	mutex_unlock(&data->lock);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ad5272_read(struct ad5272_data *data, int reg, int *val)
> +{
> +	int ret;
> +
> +	data->buf[0] = reg << 2;
> +	data->buf[1] = 0;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_master_send(data->client, data->buf, sizeof(data->buf));
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = i2c_master_recv(data->client, data->buf, sizeof(data->buf));
> +	if (ret < 0)
> +		goto error;
> +
> +	*val = ((data->buf[0] & 0x3) << 8) | data->buf[1];
> +	ret = 0;
> +error:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int ad5272_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad5272_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		ret = ad5272_read(data, AD5272_RDAC_RD, val);
> +		*val = *val >> data->cfg->shift;
> +		return ret ? ret : IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000 * data->cfg->kohms;
> +		*val2 = data->cfg->max_pos;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5272_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad5272_data *data = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val >= data->cfg->max_pos || val < 0 || val2)
> +		return -EINVAL;
> +
> +	return ad5272_write(data, AD5272_RDAC_WR, val << data->cfg->shift);
> +}
> +
> +static const struct iio_info ad5272_info = {
> +	.read_raw = ad5272_read_raw,
> +	.write_raw = ad5272_write_raw,
> +};
> +
> +static int ad5272_reset(struct ad5272_data *data)
> +{
> +	struct gpio_desc *reset_gpio;
> +
> +	reset_gpio = devm_gpiod_get_optional(&data->client->dev, "reset",
> +		GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	if (reset_gpio) {
> +		udelay(1);
> +		gpiod_set_value(reset_gpio, 1);
> +	} else {
> +		ad5272_write(data, AD5272_RESET, 0);
> +	}
> +	usleep_range(1000, 2000);
> +
> +	return 0;
> +}
> +
> +static int ad5272_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5272_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +	data->cfg = &ad5272_cfg[id->driver_data];
> +
> +	ret = ad5272_reset(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad5272_write(data, AD5272_CTL, AD5272_RDAC_WR_EN);
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &ad5272_info;
> +	indio_dev->channels = &ad5272_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = client->name;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id ad5272_dt_ids[] = {
> +	{ .compatible = "adi,ad5272-020", .data = (void *)AD5272_020 },
> +	{ .compatible = "adi,ad5272-050", .data = (void *)AD5272_050 },
> +	{ .compatible = "adi,ad5272-100", .data = (void *)AD5272_100 },
> +	{ .compatible = "adi,ad5274-020", .data = (void *)AD5274_020 },
> +	{ .compatible = "adi,ad5274-100", .data = (void *)AD5274_100 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
> +#endif /* CONFIG_OF */
> +
> +static const struct i2c_device_id ad5272_id[] = {
> +	{ "ad5272-020", AD5272_020 },
> +	{ "ad5272-050", AD5272_050 },
> +	{ "ad5272-100", AD5272_100 },
> +	{ "ad5274-020", AD5274_020 },
> +	{ "ad5274-100", AD5274_100 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ad5272_id);
> +
> +static struct i2c_driver ad5272_driver = {
> +	.driver = {
> +		.name	= "ad5272",
> +		.of_match_table = of_match_ptr(ad5272_dt_ids),
> +	},
> +	.probe		= ad5272_probe,
> +	.id_table	= ad5272_id,
> +};
> +
> +module_i2c_driver(ad5272_driver);
> +
> +MODULE_AUTHOR("Phil Reid <preid@eletromag.com.au>");
> +MODULE_DESCRIPTION("AD5272 digital potentiometer");
> +MODULE_LICENSE("GPL v2");

