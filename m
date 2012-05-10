Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44371 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759404Ab2EJM3M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 08:29:12 -0400
Message-ID: <4FABB495.10001@kernel.org>
Date: Thu, 10 May 2012 13:29:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 8/8] iio: add support for hmc5883/hmc5883l to hmc5843
 magnetometer driver
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net> <1336515606-12364-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1336515606-12364-9-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/8/2012 11:20 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
Hi Peter,

Mostly fine.  Few trivial bits inline and one bigger one.

I'd prefer to see the difference between the parts implemented
via a table of static 'chip_variant' structures. It's generally
cleaner, less error prone and moves some stuff into static data
rather than code which is always nice.  It's also how this is
handled in most of the other drivers and as a lazy maintainer I
like everything to look similar!

Jonathan
> v2 addresses review comments:
> * fixes and cleanups have been split out (Jonathan Cameron)
> * constants are generally prefixed HMC5843_, except when related
>    specifically to hmc5883 (Jonathan Cameron)
> * simplify code and avoid temp buffer in
>    hmc5843_show_sampling_frequencies_available() (Lars-Peter Clausen)
> * use sysfs_streq() instead of strncmp()/strlen() in
>    hmc5843_check_sampling_frequency() (Lars-Peter Clausen)
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
> ---
>   drivers/staging/iio/magnetometer/Kconfig   |    8 +-
>   drivers/staging/iio/magnetometer/hmc5843.c |  181 +++++++++++++++++++++++----
>   2 files changed, 158 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
> index 722c4e1..b9d9325 100644
> --- a/drivers/staging/iio/magnetometer/Kconfig
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -15,13 +15,13 @@ config SENSORS_AK8975
>   	  will be called ak8975.
>
>   config SENSORS_HMC5843
> -	tristate "Honeywell HMC5843 3-Axis Magnetometer"
> +	tristate "Honeywell HMC5843/5883/5883L 3-Axis Magnetometer"
>   	depends on I2C
>   	help
> -	  Say Y here to add support for the Honeywell HMC 5843 3-Axis
> -	  Magnetometer (digital compass).
> +	  Say Y here to add support for the Honeywell HMC5843, HMC5883 and
> +	  HMC5883L 3-Axis Magnetometer (digital compass).
>
>   	  To compile this driver as a module, choose M here: the module
> -	  will be called hmc5843
> +	  will be called hmc5843.
Technically an independent change so should be in separate patch, but 
frankly I don't care for something this trivial!
>
>   endmenu
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 2e1bc6c..8321a77 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -2,6 +2,8 @@
>       Author: Shubhrajyoti Datta<shubhrajyoti@ti.com>
>       Acknowledgement: Jonathan Cameron<jic23@cam.ac.uk>  for valuable inputs.
>
> +    Support for HMC5883 and HMC5883L by Peter Meerwald<pmeerw@pmeerw.net>.
> +
>       This program is free software; you can redistribute it and/or modify
>       it under the terms of the GNU General Public License as published by
>       the Free Software Foundation; either version 2 of the License, or
> @@ -44,6 +46,11 @@
>   #define HMC5843_ID_REG_B			0x0B
>   #define HMC5843_ID_REG_C			0x0C
>
> +enum hmc5843_ids {
> +	HMC5843_ID,
> +	HMC5883_ID,
> +	HMC5883L_ID,
> +};
>
>   /*
>    * Beware: identification of the HMC5883 is still "H43";
> @@ -103,8 +110,16 @@ static const int hmc5843_regval_to_nanoscale[] = {
>   	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
>   };
>
> +static const int hmc5883_regval_to_nanoscale[] = {
> +	7812, 9766, 13021, 16287, 24096, 27701, 32573, 45662
> +};
> +
> +static const int hmc5883l_regval_to_nanoscale[] = {
> +	7299, 9174, 12195, 15152, 22727, 25641, 30303, 43478
> +};
> +
>   /*
> - * From the datasheet:
> + * From the HMC5843 datasheet:
>    * Value	| Sensor input field range (Ga)	| Gain (counts/milli-Gauss)
>    * 0		| (+-)0.7			| 1620
>    * 1		| (+-)1.0			| 1300
> @@ -114,6 +129,28 @@ static const int hmc5843_regval_to_nanoscale[] = {
>    * 5		| (+-)3.8			| 460
>    * 6		| (+-)4.5			| 390
>    * 7		| (+-)6.5			| 280
> + *
> + * From the HMC5883 datasheet:
> + * Value	| Recommended sensor field range (Ga)	| Gain (counts/Gauss)
> + * 0		| (+-)0.9				| 1280
> + * 1		| (+-)1.2				| 1024
> + * 2		| (+-)1.9				| 768
> + * 3		| (+-)2.5				| 614
> + * 4		| (+-)4.0				| 415
> + * 5		| (+-)4.6				| 361
> + * 6		| (+-)5.5				| 307
> + * 7		| (+-)7.9				| 219
> + *
> + * From the HMC5883L datasheet:
> + * Value	| Recommended sensor field range (Ga)	| Gain (LSB/Gauss)
> + * 0		| (+-)0.88				| 1370
> + * 1		| (+-)1.3				| 1090
> + * 2		| (+-)1.9				| 820
> + * 3		| (+-)2.5				| 660
> + * 4		| (+-)4.0				| 440
> + * 5		| (+-)4.7				| 390
> + * 6		| (+-)5.6				| 330
> + * 7		| (+-)8.1				| 230
>    */
>   static const int hmc5843_regval_to_input_field_mga[] = {
>   	700,
> @@ -126,17 +163,41 @@ static const int hmc5843_regval_to_input_field_mga[] = {
>   	6500
>   };
>
Maybe rotate these tables?  (e.g. same as done with the scale ones above)
> +static const int hmc5883_regval_to_input_field_mga[] = {
> +	900,
> +	1200,
> +	1900,
> +	2500,
> +	4000,
> +	4600,
> +	5500,
> +	7900
> +};
> +
> +static const int hmc5883l_regval_to_input_field_mga[] = {
> +	880,
> +	1300,
> +	1900,
> +	2500,
> +	4000,
> +	4700,
> +	5600,
> +	8100
> +};
> +
> +
>   /*
>    * From the datasheet:
> - * Value	| Data output rate (Hz)
> - * 0		| 0.5
> - * 1		| 1
> - * 2		| 2
> - * 3		| 5
> - * 4		| 10 (default)
> - * 5		| 20
> - * 6		| 50
> - * 7		| Not used
> + * Value	| HMC5843		| HMC5883/HMC5883L
> + *		| Data output rate (Hz)	| Data output rate (Hz)
> + * 0		| 0.5			| 0.75
> + * 1		| 1			| 1.5
> + * 2		| 2			| 3
> + * 3		| 5			| 7.5
> + * 4		| 10 (default)		| 15
> + * 5		| 20			| 30
> + * 6		| 50			| 75
> + * 7		| Not used		| Not used
>    */
>   static const char * const hmc5843_regval_to_sample_freq[] = {
>   	"0.5",
> @@ -148,6 +209,16 @@ static const char * const hmc5843_regval_to_sample_freq[] = {
>   	"50",
>   };
>
> +static const char * const hmc5883_regval_to_sample_freq[] = {
> +	"0.75",
> +	"1.5",
> +	"3",
> +	"7.5",
> +	"15",
> +	"30",
> +	"75",
> +};
> +
>   /* Addresses to scan: 0x1E */
>   static const unsigned short normal_i2c[] = { HMC5843_I2C_ADDRESS,
>   					     I2C_CLIENT_END };
> @@ -159,6 +230,9 @@ struct hmc5843_data {
>   	u8 meas_conf;
>   	u8 operating_mode;
>   	u8 range;
> +	const char * const *regval_to_sample_freq;
> +	const int *regval_to_input_field_mga;
> +	const int *regval_to_nanoscale;
>   };
>
>   /* The lower two bits contain the current conversion mode */
> @@ -334,7 +408,25 @@ static IIO_DEVICE_ATTR(meas_conf,
>   			hmc5843_set_measurement_configuration,
>   			0);
>
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
> +static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +	ssize_t total_n = 0;
> +	int i;
> +
> +	for (i = 0; i<  HMC5843_RATE_NOT_USED; i++) {
> +		ssize_t n = sprintf(buf, "%s ", data->regval_to_sample_freq[i]);
> +		buf += n;
> +		total_n += n;
> +	}
newline on the end? + ideally clear out the extra space...
> +
> +	return total_n;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_frequencies_available);
>
>   static s32 hmc5843_set_rate(struct i2c_client *client,
>   				u8 rate)
> @@ -343,24 +435,23 @@ static s32 hmc5843_set_rate(struct i2c_client *client,
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>   	u8 reg_val;
>
> -	reg_val = (data->meas_conf) |  (rate<<  HMC5843_RATE_OFFSET);
>   	if (rate>= HMC5843_RATE_NOT_USED) {
>   		dev_err(&client->dev,
>   			"data output rate is not supported\n");
>   		return -EINVAL;
>   	}
> +	reg_val = data->meas_conf | (rate<<  HMC5843_RATE_OFFSET);
Technically this is an unrelated change, sensible but shouldn't really
be in this patch!
>   	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
>   }
>
>   static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
>   						const char *buf)
>   {
> -	const char * const *samp_freq = hmc5843_regval_to_sample_freq;
> +	const char * const *samp_freq = data->regval_to_sample_freq;
>   	int i;
>
>   	for (i = 0; i<  HMC5843_RATE_NOT_USED; i++) {
> -		if (strncmp(buf, samp_freq[i],
> -			strlen(samp_freq[i])) == 0)
> +		if (sysfs_streq(buf, samp_freq[i]))
>   			return i;
>   	}
>
> @@ -403,13 +494,14 @@ static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	s32 rate;
>
>   	rate = i2c_smbus_read_byte_data(client, this_attr->address);
>   	if (rate<  0)
>   		return rate;
>   	rate = (rate&  HMC5843_RATE_BITMASK)>>  HMC5843_RATE_OFFSET;
> -	return sprintf(buf, "%s\n", hmc5843_regval_to_sample_freq[rate]);
> +	return sprintf(buf, "%s\n", data->regval_to_sample_freq[rate]);
>   }
>
>   static IIO_DEVICE_ATTR(sampling_frequency,
> @@ -427,7 +519,7 @@ static ssize_t hmc5843_show_range_gain(struct device *dev,
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>
>   	range = data->range;
> -	return sprintf(buf, "%d\n", hmc5843_regval_to_input_field_mga[range]);
> +	return sprintf(buf, "%d\n", data->regval_to_input_field_mga[range]);
>   }
>
>   static ssize_t hmc5843_set_range_gain(struct device *dev,
> @@ -485,7 +577,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>   						val);
>   	case IIO_CHAN_INFO_SCALE:
>   		*val = 0;
> -		*val2 = hmc5843_regval_to_nanoscale[data->range];
> +		*val2 = data->regval_to_nanoscale[data->range];
>   		return IIO_VAL_INT_PLUS_NANO;
>   	};
>   	return -EINVAL;
> @@ -507,12 +599,19 @@ static const struct iio_chan_spec hmc5843_channels[] = {
>   	HMC5843_CHANNEL(Z, HMC5843_DATA_OUT_Z_MSB_REG),
>   };
>
> +static const struct iio_chan_spec hmc5883_channels[] = {
> +	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
> +	HMC5843_CHANNEL(Y, HMC5883_DATA_OUT_Y_MSB_REG),
> +	HMC5843_CHANNEL(Z, HMC5883_DATA_OUT_Z_MSB_REG),
> +};
> +
> +
>   static struct attribute *hmc5843_attributes[] = {
>   	&iio_dev_attr_meas_conf.dev_attr.attr,
>   	&iio_dev_attr_operating_mode.dev_attr.attr,
>   	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>   	&iio_dev_attr_in_magn_range.dev_attr.attr,
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>   	NULL
>   };
>
> @@ -539,19 +638,47 @@ static int hmc5843_detect(struct i2c_client *client,
>   	return 0;
>   }
>
> -/* Called when we have found a new HMC5843 */
> -static void hmc5843_init_client(struct i2c_client *client)
> +/* Called when we have found a new HMC58X3 */
> +static void hmc5843_init_client(struct i2c_client *client,
> +				const struct i2c_device_id *id)
>   {
>   	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>
> +	switch (id->driver_data) {
> +	case HMC5843_ID:
This smacks of stuff that would be better done with a 'chip_variant' 
structure.  That way you get it into a simple selection of an element
in a table and it's all static data.  See how it is done in adc/max1363 
for example.

> +		data->regval_to_sample_freq = hmc5843_regval_to_sample_freq;
> +		data->regval_to_input_field_mga =
> +			hmc5843_regval_to_input_field_mga;
> +		data->regval_to_nanoscale = hmc5843_regval_to_nanoscale;
> +		indio_dev->channels = hmc5843_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(hmc5843_channels);
> +		break;
> +	case HMC5883_ID:
> +		data->regval_to_sample_freq = hmc5883_regval_to_sample_freq;
> +		data->regval_to_input_field_mga =
> +			hmc5883_regval_to_input_field_mga;
> +		data->regval_to_nanoscale = hmc5883_regval_to_nanoscale;
> +		indio_dev->channels = hmc5883_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(hmc5883_channels);
> +		break;
> +	case HMC5883L_ID:
> +		data->regval_to_sample_freq = hmc5883_regval_to_sample_freq;
> +		data->regval_to_input_field_mga =
> +			hmc5883l_regval_to_input_field_mga;
> +		data->regval_to_nanoscale = hmc5883l_regval_to_nanoscale;
> +		indio_dev->channels = hmc5883_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(hmc5883_channels);
> +		break;
> +	}
> +
>   	hmc5843_set_meas_conf(client, data->meas_conf);
>   	hmc5843_set_rate(client, data->rate);
>   	hmc5843_configure(client, data->operating_mode);
>   	i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_B, data->range);
>   	mutex_init(&data->lock);
>
> -	pr_info("HMC5843 initialized\n");
> +	pr_info("%s initialized\n", id->name);
>   }
>
>   static const struct iio_info hmc5843_info = {
> @@ -580,12 +707,10 @@ static int hmc5843_probe(struct i2c_client *client,
>   	data->operating_mode = HMC5843_MODE_CONVERSION_CONTINUOUS;
>
>   	i2c_set_clientdata(client, indio_dev);
> -	hmc5843_init_client(client);
> +	hmc5843_init_client(client, id);
>
>   	indio_dev->info =&hmc5843_info;
>   	indio_dev->name = id->name;
> -	indio_dev->channels = hmc5843_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(hmc5843_channels);
>   	indio_dev->dev.parent =&client->dev;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>
> @@ -636,7 +761,9 @@ static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_suspend, hmc5843_resume);
>   #endif
>
>   static const struct i2c_device_id hmc5843_id[] = {
> -	{ "hmc5843", 0 },
> +	{ "hmc5843", HMC5843_ID },
> +	{ "hmc5883", HMC5883_ID },
> +	{ "hmc5883l", HMC5883L_ID },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, hmc5843_id);
> @@ -655,5 +782,5 @@ static struct i2c_driver hmc5843_driver = {
>   module_i2c_driver(hmc5843_driver);
>
>   MODULE_AUTHOR("Shubhrajyoti Datta<shubhrajyoti@ti.com");
> -MODULE_DESCRIPTION("HMC5843 driver");
> +MODULE_DESCRIPTION("HMC5843/5883/5883L driver");
>   MODULE_LICENSE("GPL");

