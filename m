Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60656 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbaCOQSC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 12:18:02 -0400
Message-ID: <53247D74.8050800@kernel.org>
Date: Sat, 15 Mar 2014 16:19:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] Add support for Microchip Technology's MCP3426/7/8
 ADC
References: <1394320963-20757-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1394320963-20757-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/14 23:22, Angelo Compagnucci wrote:
> This patch extends previous mcp3422 driver to support
> missing members of the family, mcp3426/7/8.
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
You did introduce a white space at the end of a line in the Kconfig.
Also, for the scales function the plural is used to indicate that it
is showing all scales.  I added an s to the freq equivalent for the
sake of consistency.

Fixed up and applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>   drivers/iio/adc/Kconfig   |  7 ++++---
>   drivers/iio/adc/mcp3422.c | 33 ++++++++++++++++++++++++++++-----
>   2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5553206..246d9d2 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -146,11 +146,12 @@ config MCP320X
>   	  called mcp320x.
>
>   config MCP3422
> -	tristate "Microchip Technology MCP3422/3/4 driver"
> +	tristate "Microchip Technology MCP3422/3/4/6/7/8 driver"
>   	depends on I2C
>   	help
> -	  Say yes here to build support for Microchip Technology's MCP3422,
> -	  MCP3423 or MCP3424 analog to digital converters.
> +	  Say yes here to build support for Microchip Technology's
> +	  MCP3422, MCP3423, MCP3424, MCP3426, MCP3427 or MCP3428
> +	  analog to digital converters.
>
>   	  This driver can also be built as a module. If so, the module will be
>   	  called mcp3422.
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 47dcb34..8dcd1ca 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -1,10 +1,11 @@
>   /*
> - * mcp3422.c - driver for the Microchip mcp3422/3/4 chip family
> + * mcp3422.c - driver for the Microchip mcp3422/3/4/6/7/8 chip family
>    *
>    * Copyright (C) 2013, Angelo Compagnucci
>    * Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>    *
>    * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf
> + *            http://ww1.microchip.com/downloads/en/DeviceDoc/22226a.pdf
>    *
>    * This driver exports the value of analog input voltage to sysfs, the
>    * voltage unit is nV.
> @@ -96,6 +97,7 @@ static const int mcp3422_sign_extend[4] = {
>   /* Client data (each client gets its own) */
>   struct mcp3422 {
>   	struct i2c_client *i2c;
> +	u8 id;
>   	u8 config;
>   	u8 pga[4];
>   	struct mutex lock;
> @@ -238,6 +240,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>   			temp = MCP3422_SRATE_15;
>   			break;
>   		case 3:
> +			if (adc->id > 4)
> +				return -EINVAL;
>   			temp = MCP3422_SRATE_3;
>   			break;
>   		default:
> @@ -271,6 +275,17 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
>   	}
>   }
>
> +static ssize_t mcp3422_show_samp_freq(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
> +
> +	if (adc->id > 4)
> +		return sprintf(buf, "240 60 15\n");
> +
> +	return sprintf(buf, "240 60 15 3\n");
> +}
> +
>   static ssize_t mcp3422_show_scales(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> @@ -284,12 +299,13 @@ static ssize_t mcp3422_show_scales(struct device *dev,
>   		mcp3422_scales[sample_rate][3]);
>   }
>
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("240 60 15 3");
> +static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> +		mcp3422_show_samp_freq, NULL, 0);
>   static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
>   		mcp3422_show_scales, NULL, 0);
>
>   static struct attribute *mcp3422_attributes[] = {
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>   	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
>   	NULL,
>   };
> @@ -335,6 +351,7 @@ static int mcp3422_probe(struct i2c_client *client,
>
>   	adc = iio_priv(indio_dev);
>   	adc->i2c = client;
> +	adc->id = (u8)(id->driver_data);
>
>   	mutex_init(&adc->lock);
>
> @@ -343,13 +360,16 @@ static int mcp3422_probe(struct i2c_client *client,
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->info = &mcp3422_info;
>
> -	switch ((unsigned int)(id->driver_data)) {
> +	switch (adc->id) {
>   	case 2:
>   	case 3:
> +	case 6:
> +	case 7:
>   		indio_dev->channels = mcp3422_channels;
>   		indio_dev->num_channels = ARRAY_SIZE(mcp3422_channels);
>   		break;
>   	case 4:
> +	case 8:
>   		indio_dev->channels = mcp3424_channels;
>   		indio_dev->num_channels = ARRAY_SIZE(mcp3424_channels);
>   		break;
> @@ -375,6 +395,9 @@ static const struct i2c_device_id mcp3422_id[] = {
>   	{ "mcp3422", 2 },
>   	{ "mcp3423", 3 },
>   	{ "mcp3424", 4 },
> +	{ "mcp3426", 6 },
> +	{ "mcp3427", 7 },
> +	{ "mcp3428", 8 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, mcp3422_id);
> @@ -399,5 +422,5 @@ static struct i2c_driver mcp3422_driver = {
>   module_i2c_driver(mcp3422_driver);
>
>   MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
> -MODULE_DESCRIPTION("Microchip mcp3422/3/4 driver");
> +MODULE_DESCRIPTION("Microchip mcp3422/3/4/6/7/8 driver");
>   MODULE_LICENSE("GPL v2");
>

