Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59711 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab2ALV1N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2012 16:27:13 -0500
Message-ID: <4F0F504D.80208@kernel.org>
Date: Thu, 12 Jan 2012 21:27:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Pirmin Duss <pirmin.duss@flytec.ch>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V3.2] adds support for Texas Instruments ads1110 adc
References: <1326266396-7689-1-git-send-email-pirmin.duss@flytec.ch>
In-Reply-To: <1326266396-7689-1-git-send-email-pirmin.duss@flytec.ch>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/2012 07:19 AM, Pirmin Duss wrote:
> From: Duss Pirmin <pirmin.duss@flytec.ch>
> 
Nearly there.  Couple of little bits below though.
> Version 3.2
> 	fixes coding errors found by Lars-Peter Clausen
> 	uses the new module_i2c_driver() macro
> Version 3.1
> 	patch against staging-next
> Version 3
> 	removed boiler plate comments
> 	removed table for gain/scale
> 	removed trivial wrapper function
> 	added locking around access to configuration
> 	scale is done via infomask
> 
> Signed-off-by: Duss Pirmin <pirmin.duss@flytec.ch>
> ---
>  drivers/staging/iio/adc/Kconfig   |   10 ++
>  drivers/staging/iio/adc/Makefile  |    1 +
>  drivers/staging/iio/adc/ads1110.c |  322 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 333 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ads1110.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index d9decea..ab516dd 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -145,6 +145,16 @@ config AD7192
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7192.
>  
> +config ADS1110
> +	tristate "Texas Instruments ADS1110 Analog Digital Converter driver"
> +	depends on I2C
> +	help
> +		Say yes here to build support for Texas Instruments ads1110 ADC.
> +		Provides direct access via sysfs.
> +
> +		To compile this driver as a module, choose M here: the
> +		module will be called ads1110.
> +
>  config ADT7310
>  	tristate "Analog Devices ADT7310 temperature sensor driver"
>  	depends on SPI
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index ceee7f3..5551e03 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
>  obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7816) += ad7816.o
>  obj-$(CONFIG_AD7192) += ad7192.o
> +obj-$(CONFIG_ADS1110) += ads1110.o
>  obj-$(CONFIG_ADT7310) += adt7310.o
>  obj-$(CONFIG_ADT7410) += adt7410.o
>  obj-$(CONFIG_AD7280) += ad7280a.o
> diff --git a/drivers/staging/iio/adc/ads1110.c b/drivers/staging/iio/adc/ads1110.c
> new file mode 100644
> index 0000000..69b4d52
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ads1110.c
> @@ -0,0 +1,322 @@
> +/*
> + * Driver for Texas Instruments ads1110 ADC.
> + *
> + * Datashhet con be found on: http://www.ti.com/lit/ds/symlink/ads1110.pdf
> + *
> + * Copyright 2011 Flytec AG.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +
> +#define ADS1110_DATA_BYTES		2
> +#define ADS1110_CONFIG_BYTES		3
> +
> +#define ADS1110_CYC_MASK		0x0C
> +#define ADS1110_CYC_SHIFT		2
> +#define ADS1110_CYC_15			3
> +#define ADS1110_CYC_30			2
> +#define ADS1110_CYC_60			1
> +#define ADS1110_CYC_240			0
> +
> +#define ADS1110_PGA_MASK		0x03
> +#define ADS1110_PGA_COUNT		4
> +
> +struct ads1110_chip_info {
> +	struct i2c_client	*client;
> +	u8	config;
> +};
> +
> +static const unsigned int ads1110_frequencies[] = {
> +	[ADS1110_CYC_240] = 240,
> +	[ADS1110_CYC_60] = 60,
> +	[ADS1110_CYC_30] = 30,
> +	[ADS1110_CYC_15] = 15,
> +};
> +
> +static const struct iio_chan_spec ads1110_channels[] = {
> +	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> +		(IIO_CHAN_INFO_SCALE_SEPARATE_BIT), 0, 0,
unwanted brackets.
> +		IIO_ST('s', 16, 16, 0), 0),
> +};
> +
> +static int ads1110_i2c_read_config(struct ads1110_chip_info *chip, u8 *data)
> +{
> +	int ret = 0;
> +	u8 tmp[ADS1110_CONFIG_BYTES];
> +
> +	ret = i2c_master_recv(chip->client, tmp, ADS1110_CONFIG_BYTES);
> +	if (ret != ADS1110_CONFIG_BYTES) {
> +		dev_err(&chip->client->dev, "I2C read error\n");
> +		return -EIO;
> +	}
> +
> +	*data = tmp[2];
> +
> +	return 0;
> +}
> +
> +static int ads1110_i2c_read_data(struct ads1110_chip_info *chip, int *data)
> +{
> +	int ret = 0;
> +	__be16 tmp;
> +
> +	ret = i2c_master_recv(chip->client, (char *)&tmp, ADS1110_DATA_BYTES);
> +	if (ret != ADS1110_DATA_BYTES) {
> +		dev_err(&chip->client->dev, "I2C read error\n");
> +		return -EIO;
> +	}
> +
> +	*data = be16_to_cpu(tmp);
> +
> +	return 0;
> +}
> +
> +static ssize_t ads1110_read_frequency(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	u8 cfg;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	cfg = ((st->config & ADS1110_CYC_MASK) >> ADS1110_CYC_SHIFT);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return sprintf(buf, "%d\n", ads1110_frequencies[cfg]);
> +}
> +
> +static ssize_t ads1110_write_frequency(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	unsigned long lval;
> +	int ret, i;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	ret = kstrtoul(buf, 10, &lval);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1110_frequencies); i++)
> +		if (lval == ads1110_frequencies[i])
> +			break;
> +
> +	if (i == ARRAY_SIZE(ads1110_frequencies)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	st->config &= ~ADS1110_CYC_MASK;
> +	st->config |= (i << ADS1110_CYC_SHIFT);
> +
> +	ret = i2c_master_send(st->client, &st->config, 1);
> +	if (ret < 0) {
> +		ret = -EIO;
> +		dev_err(&st->client->dev, "I2C write error\n");
> +	}
> +
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret < 0 ? ret : len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +		ads1110_read_frequency,
> +		ads1110_write_frequency);
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("240 60 30 15");
> +
> +static IIO_CONST_ATTR(in_in_scale_available, "1 2 4 8");
> +
> +static int ads1110_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	int ret, data, gain;
> +
> +	switch (mask) {
> +	case 0:
> +		mutex_lock(&indio_dev->mlock);
> +		ret = ads1110_i2c_read_data(st, &data);
> +		if (ret < 0)
returned with lock held.
> +			return -EIO;
> +
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		*val = data;
> +
> +		return IIO_VAL_INT;
> +
> +	case (IIO_CHAN_INFO_SCALE):
> +
> +		mutex_lock(&indio_dev->mlock);
> +		gain = 1 << (st->config & ADS1110_PGA_MASK);
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		*val = gain;
> +
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int ads1110_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	int ret, i;
> +	unsigned int tmp;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	switch (mask) {
> +	case (IIO_CHAN_INFO_SCALE):
> +		ret = -EINVAL;
Rather deep nesting here.  Maybe something like the below would be
easier to read.

unsigned long valcp = val;
...

i = find_first_bit_set(&valcp, ADS1110_PGA_COUNT);
if (i == ADS1110_PGA_COUNT) {
	ret = -EVINAL;
	goto out;
}
if (st->config && i) {
	ret = 0;
	goto out;
}
st->config &= ~ADS1110_PGA_MASK;
st->config |= i;
ret = i2c...


> +		for (i = 0; i < ADS1110_PGA_COUNT; i++) {
> +			if (val == (1 << i)) {
> +				tmp = st->config;
> +
> +				st->config &= ~ADS1110_PGA_MASK;
> +				st->config |= i;
> +
> +				if (tmp != st->config) {
> +					ret = i2c_master_send(st->client,
> +						&st->config, 1);
> +					if (ret < 0) {
> +						ret = -EIO;
> +						dev_err(&st->client->dev,
> +							"I2C write error\n");
> +						goto out;
> +					}
> +				}
> +				ret = 0;
> +
> +				break;
> +			}
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret;
> +}
> +
> +
> +static struct attribute *ads1110_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_in_in_scale_available.dev_attr.attr,
naming is wrong here.  Should be
in_voltage_scale_available
> +	NULL,
> +};
> +
> +static const struct attribute_group ads1110_attribute_group = {
> +	.attrs = ads1110_attributes,
> +};
> +
> +static const struct iio_info ads1110_info = {
> +	.attrs = &ads1110_attribute_group,
> +	.read_raw = &ads1110_read_raw,
> +	.write_raw = &ads1110_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int __devinit ads1110_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct ads1110_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = iio_allocate_device(sizeof(*chip));
> +	if (indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	chip = iio_priv(indio_dev);
> +
> +	/* this is only used for device removal purposes  */
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	chip->client = client;
> +
> +	/* Establish that the iio_dev is a child of the i2c device */
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &ads1110_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1110_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1110_channels);
> +
> +	/* read the config register from the chip */
> +	ret = ads1110_i2c_read_config(chip, &chip->config);
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	dev_err(&client->dev, "%s ADC registered.\n", id->name);
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_free_device(indio_dev);
> +	kfree(chip);
> +error_ret:
> +	return ret;
> +}
> +
> +static int __devexit ads1110_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_free_device(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ads1110_id[] = {
> +	{ "ads1110", 0x00 },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ads1110_id);
> +
> +static struct i2c_driver ads1110_driver = {
> +	.driver = {
> +		.name = "ads1110",
> +	},
> +	.probe = ads1110_probe,
> +	.remove = __devexit_p(ads1110_remove),
> +	.id_table = ads1110_id,
> +};
> +
> +module_i2c_driver(ads1110_driver);
> +
> +MODULE_AUTHOR("Duss Pirmin <pirmin.duss@flytec.ch>");
> +MODULE_DESCRIPTION("Texas Instruments ads1110 adc driver");
> +MODULE_LICENSE("GPL v2");

