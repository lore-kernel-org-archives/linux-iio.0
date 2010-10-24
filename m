Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54844 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933293Ab0JXVDJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 17:03:09 -0400
Message-ID: <4CC4A06E.8090900@cam.ac.uk>
Date: Sun, 24 Oct 2010 22:09:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 01/14] staging: iio: adc: new driver for AD7152/3 devices
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/10 21:29, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>
> 
For new device classes like this I'd prefer to see the
abi posted on the mailing list at an early stage as we'd
have changed a few things.  As you said in your other
email we can fix these at a later date as long as everyone
is aware the abi isn't fixed as of yet!

Lots of new abi that we will want to standardize, document
and pin down fully including some dreaded magic register
writing :) Also some current abi breakage that needs fixing
soonish.

Few nitpicks inline.

Looks like it would benefit from a quick checkpatch run.

There is stuff I'm not happy with but as you have said that
can get fixed afterwards, so subject to the changes needed
to make it build, send it on to Greg.
> Signed-off-by: Barry Song <barry.song@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/Kconfig  |    7 +
>  drivers/staging/iio/adc/Makefile |    1 +
>  drivers/staging/iio/adc/ad7152.c |  610 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 618 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ad7152.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 98dd0a8..4bfe372 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -33,3 +33,10 @@ config AD7150
>  	help
>  	  Say yes here to build support for Analog Devices capacitive sensors.
>  	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
> +
> +config AD7152
> +	tristate "Analog Devices ad7152/3 capacitive sensor driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Analog Devices capacitive sensors.
> +	  (ad7152, ad7153) Provides direct access via sysfs.
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 3148a2c..fca1eff 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -7,3 +7,4 @@ max1363-y += max1363_ring.o
>  
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_AD7150) += ad7150.o
> +obj-$(CONFIG_AD7152) += ad7152.o
> diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
> new file mode 100644
> index 0000000..3612350
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7152.c
> @@ -0,0 +1,610 @@
> +/*
> + * AD7152 capacitive sensor driver supporting AD7152/3
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/i2c.h>
> +#include <linux/rtc.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +
> +/*
> + * AD7152 registers definition
> + */
> +
> +#define AD7152_STATUS              0
> +#define AD7152_STATUS_RDY1         (1 << 0)
> +#define AD7152_STATUS_RDY2         (1 << 1)
> +#define AD7152_CH1_DATA_HIGH       1
> +#define AD7152_CH1_DATA_LOW        2
> +#define AD7152_CH2_DATA_HIGH       3
> +#define AD7152_CH2_DATA_LOW        4
> +#define AD7152_CH1_OFFS_HIGH       5
> +#define AD7152_CH1_OFFS_LOW        6
> +#define AD7152_CH2_OFFS_HIGH       7
> +#define AD7152_CH2_OFFS_LOW        8
> +#define AD7152_CH1_GAIN_HIGH       9
> +#define AD7152_CH1_GAIN_LOW        10
> +#define AD7152_CH1_SETUP           11
> +#define AD7152_CH2_GAIN_HIGH       12
> +#define AD7152_CH2_GAIN_LOW        13
> +#define AD7152_CH2_SETUP           14
> +#define AD7152_CFG                 15
> +#define AD7152_RESEVERD            16
> +#define AD7152_CAPDAC_POS          17
> +#define AD7152_CAPDAC_NEG          18
> +#define AD7152_CFG2                26
> +
> +#define AD7152_MAX_CONV_MODE       6
> +
> +/*
> + * struct ad7152_chip_info - chip specifc information
> + */
> +
> +struct ad7152_chip_info {
> +	const char *name;
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	u16 ch1_offset;     /* Channel 1 offset calibration coefficient */
> +	u16 ch1_gain;       /* Channel 1 gain coefficient */
> +	u8  ch1_setup;
> +	u16 ch2_offset;     /* Channel 2 offset calibration coefficient */
> +	u16 ch2_gain;       /* Channel 1 gain coefficient */
> +	u8  ch2_setup;
Checkpatch overlong line.
> +	u8  filter_rate_setup; /* Capacitive channel digital filter setup; conversion time/update rate setup per channel */
> +	char *conversion_mode;
> +};
> +
> +struct ad7152_conversion_mode {
> +	char *name;
> +	u8 reg_cfg;
> +};
> +
My usual comment on this sort of mode by string option is that it doesn't
generalize.  If we can possibly blugeon things into a form that does
I will be much happier. This matters a lot to userspace code writers.
> +struct ad7152_conversion_mode ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
> +	{ "idle", 0 },
Guessing this means off?  Should probably be handled internally.  If the read
doesn't care, then it shouldn't be enabled.
> +	{ "continuous-conversion", 1 },
Possibly only enable it event that needs it is turned on?
> +	{ "single-conversion", 2 },
Typical one shot mode.  Should be written on demmand (by all means cache
whether it is already in the right mode)
> +	{ "power-down", 3 },
Separate attr for power down.

> +	{ "offset-calibration", 5 },
> +	{ "gain-calibration", 6 },
These look fun. No idea how these should be described ;)
> +};
> +
> +/*
> + * ad7152 register access by I2C
> + */
> +
> +static int ad7152_i2c_read(struct ad7152_chip_info *chip, u8 reg, u8 *data, int len)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret = 0;
> +
> +	ret = i2c_master_send(client, &reg, 1);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "I2C write error\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_master_recv(client, data, len);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "I2C read error\n");
pointless return ret
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad7152_i2c_write(struct ad7152_chip_info *chip, u8 reg, u8 data)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret = 0;
no need to initialize ret
> +
> +	u8 tx[2] = {
> +		reg,
> +		data,
> +	};
> +
> +	ret = i2c_master_send(client, tx, 2);
> +	if (ret < 0)
> +		dev_err(&client->dev, "I2C write error\n");
> +
> +	return ret;
> +}
> +
> +/*
> + * sysfs nodes
> + */
> +
Those of the following that generalize should move out into a generic header.

> +#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)				\
> +	IIO_DEVICE_ATTR(available_conversion_modes, S_IRUGO, _show, NULL, 0)
standard form is conversion_mode_available (makes processing in userspace easy ;)
> +#define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store)              \
> +	IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0)
I'm not keen on this for reasons stated above.

> +#define IIO_DEV_ATTR_CH1_OFFSET(_mode, _show, _store)		\
> +	IIO_DEVICE_ATTR(ch1_offset, _mode, _show, _store, 0)
Lets define a 'type' for capcitance measurement. 'capacitance' seems
like a sensible option for me.  Base unit, Farads.
Hence this becomes capacitance0_offset (we index from 0, though don't
really care on that as long as you are consistent - userspace should
be able to cope as it's common for particular channels to be missing
on some devices)

> +#define IIO_DEV_ATTR_CH2_OFFSET(_mode, _show, _store)		\
> +	IIO_DEVICE_ATTR(ch2_offset, _mode, _show, _store, 0)
> +#define IIO_DEV_ATTR_CH1_GAIN(_mode, _show, _store)		\
> +	IIO_DEVICE_ATTR(ch1_gain, _mode, _show, _store, 0)
capacitance0_scale if to be applied by userspace to end up in farads or
capacitance0_calibscale if it is an internal gain setting applied on the
device and that doesn't need to be applied by userspace to get to Farads.
> +#define IIO_DEV_ATTR_CH2_GAIN(_mode, _show, _store)		\
> +	IIO_DEVICE_ATTR(ch2_gain, _mode, _show, _store, 0)
> +#define IIO_DEV_ATTR_CH1_VALUE(_show)		\
> +	IIO_DEVICE_ATTR(ch1_value, S_IRUGO, _show, NULL, 0)
convention is <type>[m]_raw if it's not in si units (or _input if it is).
capacitance0_raw
> +#define IIO_DEV_ATTR_CH2_VALUE(_show)		\
> +	IIO_DEVICE_ATTR(ch2_value, S_IRUGO, _show, NULL, 0)
capacitance1_raw
> +#define IIO_DEV_ATTR_CH1_SETUP(_mode, _show, _store)		\
> +	IIO_DEVICE_ATTR(ch1_setup, _mode, _show, _store, 0)
This smacks of magic value. Really needs to be on the todo list
to clean this up to some 'standard' interface.  Without the datasheet
I have no idea what these magic values do.
> +#define IIO_DEV_ATTR_CH2_SETUP(_mode, _show, _store)              \
> +	IIO_DEVICE_ATTR(ch2_setup, _mode, _show, _store, 0)
> +#define IIO_DEV_ATTR_FILTER_RATE_SETUP(_mode, _show, _store)              \
> +	IIO_DEVICE_ATTR(filter_rate_setup, _mode, _show, _store, 0)
Filters are one area we realy don't have a clean abi for.  This might actually
be our first driver to support them (though quite a few devices we have drivers
for do).  Abi needs discussion at somepoint soon.  May be rather fiddly to get
right, so beware abi may not be stable for a while.
> +
> +static ssize_t ad7152_show_conversion_modes(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int i;
> +	int len = 0;
> +
> +	for (i = 0; i < AD7152_MAX_CONV_MODE; i++)
> +		len += sprintf(buf + len, "%s\n", ad7152_conv_mode_table[i].name);
space rather than newline please.

> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(ad7152_show_conversion_modes);
> +
> +static ssize_t ad7152_show_ch1_value(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	u8 data[2];
> +
> +	ad7152_i2c_read(chip, AD7152_CH1_DATA_HIGH, data, 2);
> +	return sprintf(buf, "%d\n", ((int)data[0] << 8) | data[1]);
> +}
> +
> +static IIO_DEV_ATTR_CH1_VALUE(ad7152_show_ch1_value);
> +
> +static ssize_t ad7152_show_ch2_value(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	u8 data[2];
> +
> +	ad7152_i2c_read(chip, AD7152_CH2_DATA_HIGH, data, 2);
> +	return sprintf(buf, "%d\n", ((int)data[0] << 8) | data[1]);
> +}
> +
> +static IIO_DEV_ATTR_CH2_VALUE(ad7152_show_ch2_value);
> +
> +static ssize_t ad7152_show_conversion_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%s\n", chip->conversion_mode);
> +}
> +
> +static ssize_t ad7152_store_conversion_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	u8 cfg;
> +	int i;
> +
> +	ad7152_i2c_read(chip, AD7152_CFG, &cfg, 1);
> +
> +	for (i = 0; i < AD7152_MAX_CONV_MODE; i++) {
superfluous brackets.
> +		if (strncmp(buf, ad7152_conv_mode_table[i].name,
> +				strlen(ad7152_conv_mode_table[i].name) - 1) == 0) {
> +			chip->conversion_mode = ad7152_conv_mode_table[i].name;
> +			cfg |= 0x18 | ad7152_conv_mode_table[i].reg_cfg;
> +			ad7152_i2c_write(chip, AD7152_CFG, cfg);
> +			return len;
> +		}
> +	}
> +
> +	dev_err(dev, "not supported conversion mode\n");
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CONVERSION_MODE(S_IRUGO | S_IWUSR,
> +		ad7152_show_conversion_mode,
> +		ad7152_store_conversion_mode);
> +
> +static ssize_t ad7152_show_ch1_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", chip->ch1_offset);
> +}
> +
> +static ssize_t ad7152_store_ch1_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x10000)) {
> +		ad7152_i2c_write(chip, AD7152_CH1_OFFS_HIGH, data >> 8);
> +		ad7152_i2c_write(chip, AD7152_CH1_OFFS_LOW, data);
> +		chip->ch1_offset = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CH1_OFFSET(S_IRUGO | S_IWUSR,
> +		ad7152_show_ch1_offset,
> +		ad7152_store_ch1_offset);
> +
> +static ssize_t ad7152_show_ch2_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", chip->ch2_offset);
> +}
Can probably save a few functions round here easily enough.
> +
> +static ssize_t ad7152_store_ch2_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x10000)) {
> +		ad7152_i2c_write(chip, AD7152_CH2_OFFS_HIGH, data >> 8);
> +		ad7152_i2c_write(chip, AD7152_CH2_OFFS_LOW, data);
> +		chip->ch2_offset = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CH2_OFFSET(S_IRUGO | S_IWUSR,
> +		ad7152_show_ch2_offset,
> +		ad7152_store_ch2_offset);
> +
> +static ssize_t ad7152_show_ch1_gain(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", chip->ch1_gain);
> +}
> +
> +static ssize_t ad7152_store_ch1_gain(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x10000)) {
> +		ad7152_i2c_write(chip, AD7152_CH1_GAIN_HIGH, data >> 8);
> +		ad7152_i2c_write(chip, AD7152_CH1_GAIN_LOW, data);
> +		chip->ch1_gain = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CH1_GAIN(S_IRUGO | S_IWUSR,
> +		ad7152_show_ch1_gain,
> +		ad7152_store_ch1_gain);
> +
> +static ssize_t ad7152_show_ch2_gain(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", chip->ch2_gain);
> +}
> +
> +static ssize_t ad7152_store_ch2_gain(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x10000)) {
> +		ad7152_i2c_write(chip, AD7152_CH2_GAIN_HIGH, data >> 8);
> +		ad7152_i2c_write(chip, AD7152_CH2_GAIN_LOW, data);
> +		chip->ch2_gain = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CH2_GAIN(S_IRUGO | S_IWUSR,
> +		ad7152_show_ch2_gain,
> +		ad7152_store_ch2_gain);
> +

Err, no to this as an interface.  Fine for initial bashing, but
we aren't going to keep something this 'magic' in here long term.
> +static ssize_t ad7152_show_ch1_setup(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "0x%02x\n", chip->ch1_setup);
> +}
> +
> +static ssize_t ad7152_store_ch1_setup(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x100)) {
> +		ad7152_i2c_write(chip, AD7152_CH1_SETUP, data);
> +		chip->ch1_setup = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CH1_SETUP(S_IRUGO | S_IWUSR,
> +		ad7152_show_ch1_setup,
> +		ad7152_store_ch1_setup);
> +
> +static ssize_t ad7152_show_ch2_setup(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "0x%02x\n", chip->ch2_setup);
> +}
> +
> +static ssize_t ad7152_store_ch2_setup(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x100)) {
> +		ad7152_i2c_write(chip, AD7152_CH2_SETUP, data);
> +		chip->ch2_setup = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_CH2_SETUP(S_IRUGO | S_IWUSR,
> +		ad7152_show_ch2_setup,
> +		ad7152_store_ch2_setup);
> +
Again, fine for initial bashing, but this ain't going to generalize
unless all device use the same magic ;)
> +static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "0x%02x\n", chip->filter_rate_setup);
> +}
> +
> +static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +
> +	if ((!ret) && (data < 0x100)) {
> +		ad7152_i2c_write(chip, AD7152_CFG2, data);
> +		chip->filter_rate_setup = data;
> +		return len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
> +		ad7152_show_filter_rate_setup,
> +		ad7152_store_filter_rate_setup);
> +
> +static ssize_t ad7152_show_name(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7152_chip_info *chip = dev_info->dev_data;
> +	return sprintf(buf, "%s\n", chip->name);
> +}
> +
> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7152_show_name, NULL, 0);
> +
comments on these are alongside the macros above.
> +static struct attribute *ad7152_attributes[] = {
> +	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
> +	&iio_dev_attr_conversion_mode.dev_attr.attr,
> +	&iio_dev_attr_ch1_gain.dev_attr.attr,
> +	&iio_dev_attr_ch2_gain.dev_attr.attr,
> +	&iio_dev_attr_ch1_offset.dev_attr.attr,
> +	&iio_dev_attr_ch2_offset.dev_attr.attr,
> +	&iio_dev_attr_ch1_value.dev_attr.attr,
> +	&iio_dev_attr_ch2_value.dev_attr.attr,
> +	&iio_dev_attr_ch1_setup.dev_attr.attr,
> +	&iio_dev_attr_ch2_setup.dev_attr.attr,
> +	&iio_dev_attr_filter_rate_setup.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7152_attribute_group = {
> +	.attrs = ad7152_attributes,
> +};
> +
> +/*
> + * device probe and remove
> + */
> +
> +static int __devinit ad7152_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret = 0;
> +	struct ad7152_chip_info *chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (chip == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	/* this is only used for device removal purposes */
> +	i2c_set_clientdata(client, chip);
> +
> +	chip->client = client;
> +	chip->name = id->name;
> +
> +	chip->indio_dev = iio_allocate_device();
> +	if (chip->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_chip;
> +	}
> +
> +	/* Echipabilish that the iio_dev is a child of the i2c device */
> +	chip->indio_dev->dev.parent = &client->dev;
> +	chip->indio_dev->attrs = &ad7152_attribute_group;
> +	chip->indio_dev->dev_data = (void *)(chip);
> +	chip->indio_dev->driver_module = THIS_MODULE;
> +	chip->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(chip->indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	dev_err(&client->dev, "%s capacitive sensor registered\n", id->name);
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_free_device(chip->indio_dev);
> +error_free_chip:
> +	kfree(chip);
> +error_ret:
> +	return ret;
> +}
> +
> +static int __devexit ad7152_remove(struct i2c_client *client)
> +{
> +	struct ad7152_chip_info *chip = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = chip->indio_dev;
> +
> +	if (client->irq && gpio_is_valid(irq_to_gpio(client->irq)) > 0)
> +		iio_unregister_interrupt_line(indio_dev, 0);
> +	iio_device_unregister(indio_dev);
> +	kfree(chip);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ad7152_id[] = {
> +	{ "ad7152", 0 },
> +	{ "ad7153", 0 },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ad7152_id);
> +
> +static struct i2c_driver ad7152_driver = {
> +	.driver = {
> +		.name = "ad7152",
> +	},
> +	.probe = ad7152_probe,
> +	.remove = __devexit_p(ad7152_remove),
> +	.id_table = ad7152_id,
> +};
> +
> +static __init int ad7152_init(void)
> +{
> +	return i2c_add_driver(&ad7152_driver);
> +}
> +
> +static __exit void ad7152_exit(void)
> +{
> +	i2c_del_driver(&ad7152_driver);
> +}
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ad7152/3 capacitive sensor driver");
> +MODULE_LICENSE("GPL v2");
> +
> +module_init(ad7152_init);
> +module_exit(ad7152_exit);

