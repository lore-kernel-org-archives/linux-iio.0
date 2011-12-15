Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1134 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab1LOQHQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Dec 2011 11:07:16 -0500
Message-ID: <4EEA1B54.5060607@metafoo.de>
Date: Thu, 15 Dec 2011 17:07:48 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Duss Pirmin <pirmin.duss@flytec.ch>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Add support for ads1110
References: <4EE9FB74.6010402@flytec.ch>
In-Reply-To: <4EE9FB74.6010402@flytec.ch>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/15/2011 02:51 PM, Duss Pirmin wrote:
> Hi
> 
> This patch adds support for the ads1110 adc from Texas Instruments.
> 
> This is my first submission to the Linux kernel.
> 
> Comments welcome
> 

Hi,

It looks like your driver is based on a rather old version of IIO. Please
try to always submit IIO patches against Gregs staging-next[1] tree.

Also it looks like your mail program messed up the patch. (Replaced tabs
with space, inserted line breaks).

Comments inline.

> 
> diff -Naur aaa/drivers/staging/iio/adc//ads1110.c
> bbb/drivers/staging/iio/adc//ads1110.c
> --- aaa/drivers/staging/iio/adc//ads1110.c    1970-01-01 01:00:00.000000000
> +0100
> +++ bbb/drivers/staging/iio/adc//ads1110.c    2011-12-15 13:53:32.000000000
> +0100
> @@ -0,0 +1,521 @@
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
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +
> +/*
> + * ADS1110 definitions
> + */
> +
> +#define ADS1110_CONFIG_ST_NDRDY        (1 << 7)
> +#define ADS1110_CONFIG_SC              (1 << 4)
> +
> +#define ADS1110_CONFIG_DR_240          (0 << 2)
> +#define ADS1110_CONFIG_DR_60           (1 << 2)
> +#define ADS1110_CONFIG_DR_30           (2 << 2)
> +#define ADS1110_CONFIG_DR_15           (3 << 2)
> +
> +#define ADS1110_CONFIG_PGA_1           0
> +#define ADS1110_CONFIG_PGA_2           1
> +#define ADS1110_CONFIG_PGA_4           2
> +#define ADS1110_CONFIG_PGA_8           3
> +
> +#define ADS1110_MAX_CONV_MODE          2
> +#define ADS1110_MAX_DATA_RATE          4
> +#define ADS1110_MAX_PGA                4
> +
> +/*
> + * struct ads1110_chip_info  - chip specifig information
> + */
> +
> +struct ads1110_chip_info {
> +    struct i2c_client        *client;
> +    struct iio_dev            *indio_dev;
> +
> +    char *conversion_mode;
> +    char *data_rate;
> +    char *gain;
> +};
> +
> +struct ads1110_conversion_mode {
> +  char *name;
> +  u8 reg_cfg;
> +};
> +
> +static struct ads1110_conversion_mode
> +ads1110_conv_mode_table[ADS1110_MAX_CONV_MODE] = {
> +  { "continuous-conversion", 0 },
> +  { "single-conversion", 1 },
> +};

This should probably not user controllable. You probably want to do a single
conversion when reading from sysfs and use continuous conversion when using
a triggered buffer.

> +
> +struct ads1110_data_rate {
> +    char *name;
> +    u8 reg_cfg;
> +};
> +
> +static struct ads1110_data_rate
> +ads1110_dr_table[ADS1110_MAX_DATA_RATE] = {
> +  { "dr-15_SPS",  ADS1110_CONFIG_DR_15 },
> +  { "dr-30_SPS",  ADS1110_CONFIG_DR_30 },
> +  { "dr-60_SPS",  ADS1110_CONFIG_DR_60 },
> +  { "dr-240_SPS", ADS1110_CONFIG_DR_240 },
> +};
> +
> +struct ads1110_pga {
> +    char *name;
> +    u8 reg_cfg;
> +};
> +
> +static struct ads1110_pga
> +ads1110_pga_table[ADS1110_MAX_PGA] = {
> +    { "gain-1",  ADS1110_CONFIG_PGA_1 },
> +    { "gain-2",  ADS1110_CONFIG_PGA_2 },
> +    { "gain-4",  ADS1110_CONFIG_PGA_4 },
> +    { "gain-8",  ADS1110_CONFIG_PGA_8 },
> +};
> +
> +/*
> + * cummunication functions for i2c
> + */
> +
> +static int ads1110_i2c_read_config(struct ads1110_chip_info *chip, u8 *data)
> +{
> +    struct i2c_client *client = chip->client;
> +    int ret = 0;
> +    u8 tmp[3];        // read three bytes ; first two are data third is the
> config

Please use C style comments.

> +
> +    ret = i2c_master_recv(client, tmp, 3);
> +    if (ret < 3) {
> +        dev_err(&client->dev, "I2C read error\n");
> +        return ret;
> +    }
> +
> +    *data = tmp[2];
> +
> +    return ret;
> +}
> +
> +static int ads1110_i2c_read_data(struct ads1110_chip_info *chip, int *data)
> +{
> +    struct i2c_client *client = chip->client;
> +    int ret = 0;
> +    u8 tmp[3];        // read three bytes ; first two are data third is the
> config
> +

Please use C style comments.

> +    ret = i2c_master_recv(client, tmp, 3);
> +    if (ret < 3) {
> +        dev_err(&client->dev, "I2C read error\n");
> +        return ret;
> +    }
> +
> +    *data = (int)(tmp[0] << 8) + tmp[1];
> +
> +    return ret;
> +}
> +
> +
> +static int ads1110_i2c_write_config(struct ads1110_chip_info *chip, u8 data)
> +{
> +  struct i2c_client *client = chip->client;
> +  int ret = 0;

indention.

> +
> +    ret = i2c_master_send(client, &data, 1);        // there is only one
> register to write to.

Please use C style comments.

> +    if (ret < 0)
> +        dev_err(&client->dev, "I2C write error\n");
> +
> +    return ret;
> +}
> +
> +/*
> + * sysfs nodes
> + */
>[...]
> +
> +static ssize_t ads1110_store_start_conversion(struct device *dev,
> +        struct device_attribute *attr,
> +        const char *buf,
> +        size_t len)
> +{
> +    struct iio_dev *dev_info = dev_get_drvdata(dev);
> +    struct ads1110_chip_info *chip = dev_info->dev_data;
> +    u8 cfg;
> +  int ret;
> +  long val;
> +
> +    ret = kstrtoul(buf, 10, &val);
> +    if (ret)
> +        goto error_ret;
> +
> +    if ((val > 1) || (val < 0) ) {
> +        ret = -EINVAL;
> +        goto error_ret;
> +    }
> +
> +    ads1110_i2c_read_config(chip, &cfg);
> +
> +    if(val)
> +      cfg |= ADS1110_CONFIG_SC;
> +    else
> +      cfg &= ~ADS1110_CONFIG_SC;
> +
> +
> +    ads1110_i2c_write_config(chip, cfg);
> +
> +error_ret:
> +    return ret ? ret : len;
> +}
> +
> +static IIO_DEV_ATTR_START_CONVERSION(S_IWUSR,
> +        NULL,
> +        ads1110_store_start_conversion);

This should probably not be a sysfs attribute, but be set on demand.
> +
> +/*
> + * attributes for ysfs
> + */
> +
> +static struct attribute *ads1110_attributes[] = {
> + &iio_dev_attr_available_conversion_modes.dev_attr.attr,
> + &iio_dev_attr_available_data_rates.dev_attr.attr,
> + &iio_dev_attr_available_gains.dev_attr.attr,
> + &iio_dev_attr_value.dev_attr.attr,
> + &iio_dev_attr_conversion_mode.dev_attr.attr,
> + &iio_dev_attr_data_rate.dev_attr.attr,
> + &iio_dev_attr_gain.dev_attr.attr,
> + &iio_dev_attr_start_conversion.dev_attr.attr,
> +  NULL,
> +};

Please use channel_spec. Most of the attributes can probably be expresses
through it. For those which can not please take a look at
Documentation/sysfs-bus-iio and see which already existing attribute names
match your use case. E.g. your "data_rate" should probably be
"sampling_frequency".

> +
> +static const struct attribute_group ads1110_attribute_group = {
> +  .attrs = ads1110_attributes,
> +};
> +
> +static struct attribute_group ads1110_event_attribute_group = {
> +  .attrs = NULL,
> +};

Since there are no attributes in the attribute group you can just drop it.

> +
> +static const struct iio_info ads1110_info = {
> +  .attrs = &ads1110_attribute_group,
> +  .num_interrupt_lines = 1,
> +  .event_attrs = &ads1110_event_attribute_group,
> +  .driver_module = THIS_MODULE,
> +};
> +
> +/*
> + * device probe and remove
> + */
> +
> +static int __devinit ads1110_probe(struct i2c_client *client,
> +        const struct i2c_device_id *id)
> +{
> +    int ret = 0, regdone = 0;
> +    struct ads1110_chip_info *chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +    if (chip == NULL) {
> +        ret = -ENOMEM;
> +        goto error_ret;
> +    }
> +
> +    // this is only used for device removal purposes
> +    i2c_set_clientdata(client, chip);
> +
> +    chip->client = client;
> +
> +    chip->indio_dev = iio_allocate_device(0);
> +    if (chip->indio_dev == NULL) {
> +        ret = -ENOMEM;
> +        goto error_free_chip;
> +    }
> +

Make your ads1110_chip_info the private part of the iio_device.
indio_dev = iio_allocate_device(sizeof(*chip));
chip = iio_priv(indio_dev);


> +    // Establish that the iio_dev is a child of the i2c device
> +    chip->indio_dev->name = id->name;
> +    chip->indio_dev->dev.parent = &client->dev;
> +
> +    chip->indio_dev->info = &ads1110_info;
> +    chip->indio_dev->dev_data = (void *)(chip);
> +
> +    chip->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +    ret = iio_device_register(chip->indio_dev);
> +    if (ret)
> +        goto error_free_dev;
> +    regdone = 1;
> +
> +    dev_err(&client->dev, "%s ADC registered.\n", id->name);
> +
> +    return 0;
> +
> +error_free_dev:
> +    if (regdone)
> +        iio_device_unregister(chip->indio_dev);
> +    else
> +        iio_free_device(chip->indio_dev);

You have to call both device_unregister and free_device with the current
version of IIO.

> +error_free_chip:
> +    kfree(chip);
> +error_ret:
> +    return ret;
> +}
> +
> +static int __devexit ads1110_remove(struct i2c_client *client)
> +{
> +    struct ads1110_chip_info *chip = i2c_get_clientdata(client);
> +    struct iio_dev *indio_dev = chip->indio_dev;
> +
> +    iio_device_unregister(indio_dev);
> +    kfree(chip);
> +

	iio_free_device(indio_dev);

> +    return 0;
> +}
> +
> +static const struct i2c_device_id ads1110_id[] = {
> +    { "ads1110-ed0", 0x48 },
> +    { "ads1110-ed1", 0x49 },
> +    { "ads1110-ed2", 0x50 },
> +    { "ads1110-ed3", 0x51 },
> +    { "ads1110-ed4", 0x52 },
> +    { "ads1110-ed5", 0x53 },
> +    { "ads1110-ed6", 0x54 },
> +    { "ads1110-ed7", 0x55 },

Are these really different parts, or is it just the same part with a
different I2C address controlled by some external pins?

> +    {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ads1110_id);
> +
> +static struct i2c_driver ads1110_driver = {
> +    .driver = {
> +        .name = "ads1110",
> +    },
> +    .probe = ads1110_probe,
> +    .remove = __devexit_p(ads1110_remove),
> +    .id_table = ads1110_id,
> +};
> +
> +static __init int ads1110_init(void)
> +{
> +    return i2c_add_driver(&ads1110_driver);
> +}
> +
> +static __exit void ads1110_exit(void)
> +{
> +    i2c_del_driver(&ads1110_driver);
> +}
> +
> +MODULE_AUTHOR("Duss Pirmin <pirmin.duss@flytec.ch>");
> +MODULE_DESCRIPTION("Texas Instruments ads1110 adc driver");
> +MODULE_LICENSE("GPL v2");
> +
> +module_init(ads1110_init);
> +module_exit(ads1110_exit);
> diff -Naur aaa/drivers/staging/iio/adc//Kconfig
> bbb/drivers/staging/iio/adc//Kconfig
> --- aaa/drivers/staging/iio/adc//Kconfig    2011-12-14 14:46:58.000000000 +0100
> +++ bbb/drivers/staging/iio/adc//Kconfig    2011-12-14 14:33:01.000000000 +0100
> @@ -191,3 +191,14 @@
>      help
>        Say yes here to include ring buffer support in the MAX1363
>        ADC driver.
> +
> +config ADS1110
> +    tristate "Texas Instruments ADS1110 ADC driver"
> +    depends on I2C
> +    help
> +      Say yes here to build support for Texas Instruments ads1110 ADC.
> +      Provides direct access via sysfs.
> +
> +      To compile this driver as a module, choose M here: the
> +      module will be called ads1110.
> +

Please try to keep the Kconfig items ordered.

> diff -Naur aaa/drivers/staging/iio/adc//Makefile
> bbb/drivers/staging/iio/adc//Makefile
> --- aaa/drivers/staging/iio/adc//Makefile    2011-12-14 14:46:58.000000000
> +0100
> +++ bbb/drivers/staging/iio/adc//Makefile    2011-12-14 14:32:47.000000000
> +0100
> @@ -39,3 +39,4 @@
>  obj-$(CONFIG_ADT75) += adt75.o
>  obj-$(CONFIG_ADT7310) += adt7310.o
>  obj-$(CONFIG_ADT7410) += adt7410.o
> +obj-$(CONFIG_ADS1110) += ads1110.o

Same here.
