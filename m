Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57120 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab1HOJoi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2011 05:44:38 -0400
Message-ID: <4E48EC6D.5090102@cam.ac.uk>
Date: Mon, 15 Aug 2011 10:52:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Paul Thomas <pthomas8589@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: [v2] add support for Analog Devices ad7194 a/d converter
References: <1313353117-25140-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1313353117-25140-1-git-send-email-pthomas8589@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/14/11 21:18, Paul Thomas wrote:
> This uses the iio sysfs interface, and inculdes gain
includes

Couple of left over bits from chan_spec conversion that need
cleaning up and a that gain attribute wants to be done via the
scale_shared chan_info element instead.

Some other nitpicks inline.  Mostly looks good though so
shouldn't take much time to clean up. 

Thanks,

Jonathan
> 
> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
> ---
>  drivers/staging/iio/adc/Kconfig  |    7 +
>  drivers/staging/iio/adc/Makefile |    1 +
>  drivers/staging/iio/adc/ad7194.c |  393 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 401 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ad7194.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 8c751c4..871605b 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -17,6 +17,13 @@ config AD7152
>  	  Say yes here to build support for Analog Devices capacitive sensors.
>  	  (ad7152, ad7153) Provides direct access via sysfs.
>  
> +config AD7194
> +	tristate "Analog Devices AD7194 ADC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices ad7194.
> +	  Provides direct access via sysfs.
> +
>  config AD7291
>  	tristate "Analog Devices AD7291 temperature sensor driver"
>  	depends on I2C
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 1d9b3f5..4da3c40 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_AD7298) += ad7298.o
>  
>  obj-$(CONFIG_AD7150) += ad7150.o
>  obj-$(CONFIG_AD7152) += ad7152.o
> +obj-$(CONFIG_AD7194) += ad7194.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7314) += ad7314.o
>  obj-$(CONFIG_AD7745) += ad7745.o
> diff --git a/drivers/staging/iio/adc/ad7194.c b/drivers/staging/iio/adc/ad7194.c
> new file mode 100644
> index 0000000..30d8378
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7194.c
> @@ -0,0 +1,393 @@
> +/*
> + *  ad7194 - driver for Analog Devices AD7194 A/D converter
> + *
> + *  Copyright (c) 2011 Paul Thomas <pthomas8589@gmail.com>
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + *  GNU General Public License for more details.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  later as publishhed by the Free Software Foundation.
> + *
> + *	You need to have something like this in struct spi_board_info
> + *	{
> + *		.modalias	= "ad7194",
> + *		.max_speed_hz	= 2*1000*1000,
> + *		.chip_select	= 0,
> + *		.bus_num	= 1,
> + *	},
> + *
> + * There is 1 universial gain that is used for each read.
> + */
> +
> +/*From Table 15 in the datasheet*/
> +/*Register addresses*/
> +#define REG_STATUS  0
> +#define REG_MODE    1
> +#define REG_CONF    2
> +#define REG_DATA    3
> +#define REG_ID      4
> +#define REG_GPOCON  5
> +#define REG_OFFSET  6
> +#define REG_FS      7
> +
> +/*From Table 15 in the datasheet*/

What are these bp, bm and gc suffixes for?
> +#define COMM_ADDR_bp 3
> +#define COMM_READ_bm (1 << 6)
> +
> +#define CONF_CHOP_bm (1 << 23)
> +#define CONF_PSEUDO_bm (1 << 18)
> +#define CONF_BUF_bm (1 << 4)
> +#define CONF_CHAN_NEG_bp 8
> +#define CONF_CHAN_POS_bp 12
> +
> +
> +#define MODE_MD_SINGLE_gc (0x01 << 21)
> +#define MODE_MD_ZS_CAL_gc (0x04 << 21)
> +#define MODE_MD_FS_CAL_gc (0x05 << 21)
> +#define MODE_CLK_INTTRI_gc (0x02 << 18)
> +/*Table 8 in the datasheet provides options for the Filter Word*/
> +#define MODE_FILTER_WORD 1
> +#define SETTLE_MS 2
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/spi/spi.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +
> +#define DEVICE_NAME	"ad7194"
> +#define NUM_CHANNELS 16
Not used so drop.

> +
> +const uint8_t gains[8] = {1, 0, 0, 8, 16, 32, 64, 128};
> +
> +struct ad7194_state {
> +	struct spi_device *spi_dev;
> +	struct iio_dev *indio_dev;
> +	uint8_t gain;
> +	struct mutex lock;
> +};
> +
> +static ssize_t show_gain(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
Inconsistent naming. Pick either dev_info of indio_dev (yes,
I'm the fool who put both of these in the same driver first, but
no need to copy me ;)

> +	struct ad7194_state *st = dev_info->dev_data;
dev_data just got dropped entirely (when Greg merges patches I sent
him on Friday.) It's been deprecated for a while and I got the final
tested by last week on a tricky conversion so it's gone now.  As you
are using a size in iio_allocate_device just use

struct ad7194_state *st = iio_priv(dev_info);

everywhere you have a dev_info->dev_data.

Also gain is handled by the iio_chan_spec and read_raw. There is a shared
version that covers what you are doing here.  Also attribute is in_scale
for this. Note this will involve some conversions as the scale value
should be what you multiply the raw reading by to get an output in millivolts.
> +
> +	return sprintf(buf, "%d\n", gains[st->gain]);
> +}
> +
> +static ssize_t set_gain(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	uint8_t gain_real, i;
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7194_state *st = dev_info->dev_data;
> +
> +	gain_real = simple_strtol(buf, NULL, 10);
simple_strtol was always dubious, now it's deprecated as well.
kstrtou8 is a better choice.  

> +	if (gain_real == 0)
> +		return -EPERM;
> +	for (i = 0; i < 8; i++) {
Check patch should I think have moaned about extra brackets for the for
loop.
> +		if (gains[i] == gain_real) {
> +			st->gain =  i;
> +			return count;
> +		}
> +	}
> +	return -EPERM;
> +}
> +
> +static inline int ad7194_read_reg8(struct spi_device *spi,
> +		int reg, uint8_t *val)
> +{
> +	int ret;
> +	uint8_t tx[1], rx[1];
> +
> +	tx[0] = (COMM_READ_bm | (reg << COMM_ADDR_bp));
> +
> +	ret = spi_write_then_read(spi, tx, 1, rx, 1);
> +	*val = rx[0];
> +	return ret;
> +}
> +
> +static inline int ad7194_read_reg24(struct spi_device *spi,
> +		int reg, uint32_t *val)
> +{
> +	int ret;
> +	uint8_t tx[1], rx[3];
> +
> +	tx[0] = (COMM_READ_bm | (reg << COMM_ADDR_bp));
> +
> +	ret = spi_write_then_read(spi, tx, 1, rx, 3);
> +	*val = (rx[0] << 16) + (rx[1] << 8) + rx[2];
> +	return ret;
> +}
> +
> +static inline int ad7194_write_reg24(struct spi_device *spi,
> +		int reg, uint32_t *val)
> +{
> +	uint8_t *tx;
> +	tx = kmalloc(4, GFP_KERNEL);
> +
> +	tx[0] = (reg << COMM_ADDR_bp);
> +	tx[1] = (*val >> 16) & 0xff;
> +	tx[2] = (*val >> 8) & 0xff;
> +	tx[3] = (*val >> 0) & 0xff;
> +
> +	return spi_write(spi, tx, 4);
> +}
> +
> +static ssize_t show_voltage(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long m)
> +{
In kernel stuff, so u32, u8, s32 as types please.  Actually that's
true everywhere, I just happened to notice it here ;)
> +	uint32_t conf, mode, myval, sign;
> +	uint8_t status;
> +	int32_t whole, fract;
> +	int ret;
> +
> +	struct ad7194_state *st = iio_priv(indio_dev);
> +	struct spi_device *spi = st->spi_dev;
> +
> +	if (chan->type == IIO_IN_DIFF)
> +		conf = CONF_CHOP_bm | CONF_BUF_bm |
> +			((chan->channel - 1) << CONF_CHAN_POS_bp) |
> +			((chan->channel2 - 1) << CONF_CHAN_NEG_bp) | st->gain;
> +	else
> +		conf = CONF_CHOP_bm | CONF_BUF_bm | CONF_PSEUDO_bm |
> +			((chan->channel - 1) << CONF_CHAN_POS_bp) | st->gain;
> +
> +	ret = mutex_lock_interruptible(&st->lock);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = ad7194_write_reg24(spi, REG_CONF, &conf);
> +	if (ret != 0)
> +		goto out;
> +
> +	mode = MODE_MD_SINGLE_gc | MODE_CLK_INTTRI_gc | MODE_FILTER_WORD;
> +	ret = ad7194_write_reg24(spi, REG_MODE, &mode);
> +	if (ret != 0)
> +		goto out;
> +
> +	msleep_interruptible(SETTLE_MS);
> +
> +	ret = ad7194_read_reg8(spi, REG_STATUS, &status);
> +	if (ret != 0)
> +		goto out;
> +	status = (status >> 6) & 0x01;
> +
> +	ret = ad7194_read_reg24(spi, REG_DATA, &myval);
> +	if (ret != 0)
> +		goto out;
> +
> +	sign = (myval & 0x800000) >> 23;
(no need for the right shift though irrelevant given next suggestion - 0x800000000 = true).
> +	if (sign)
> +		fract = (myval & 0x7fffff);
> +	else
> +		fract = 0x7fffff - (myval & 0x7fffff);
There are cleaner options for sign extension.
Classic trick would be something like:
fract = (s32)((myval & 0xffffff << 8) >> 8;

> +	fract = ((int64_t)fract*4095000) >> 23;
> +	fract = fract / gains[st->gain];
> +	whole = fract / 1000000;
> +	fract = fract % 1000000;
> +
> +	if (status == 0) {
better for program flow to do the status check much earlier.
> +		mutex_unlock(&st->lock);
> +		if (sign) {
> +			*val = whole;
> +			*val2 = fract;
> +		} else {
> +			*val = whole;
> +			*val2 = -fract;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	} else {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
Couple of things here some of which you had no way 
of knowing about!

a) I'm trying to clear out that IIO_CHAN macro. Arnd
warned me when I introduced it and he was right. It's
a maintenance nightmare.  Hence please use explicit
asignment of the elements.  A local macro will help
with this. Note scan type is currently irrelevant as
you don't support buffering so we'll add it if anyone
ever needs it. Same is true of scan_index and you don't
use address anywhere either. So we don't need to set that
many elements.

#define AD7194_CHAN_S(index)\
{\
	.type = IIO_IN,\
	.indexed = 1,\
	.channel = index,\
	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),\ \\note this is your 'gain' equivalent.
}

#define AD7194_CHAN_D(index1, index2) \
{\
	.type = IIO_DIFF,\
	.indexed = 1,\
	.channel = index1,\
	.channel2 = index2,\
	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),\ \\note we don't support sharing gain
across channel types so will have two attributes that are linked. This is fine.
}

b) Index is from zero is IIO.

> +static struct iio_chan_spec ad7194_channels[] = {
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0, 0,
> +		0, 0, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0, 0,
> +		1, 1, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0, 0,
> +		2, 2, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0, 0,
> +		3, 3, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0, 0,
> +		4, 4, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0, 0,
> +		5, 5, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0, 0,
> +		6, 6, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 8, 0, 0,
> +		7, 7, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 9, 0, 0,
> +		8, 8, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 10, 0, 0,
> +		9, 9, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 11, 0, 0,
> +		10, 10, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 12, 0, 0,
> +		11, 11, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 13, 0, 0,
> +		12, 12, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 14, 0, 0,
> +		13, 13, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 15, 0, 0,
> +		14, 14, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 16, 0, 0,
> +		15, 15, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 2, 0,
> +		16, 16, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 1, 0,
> +		17, 17, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 3, 4, 0,
> +		18, 18, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 4, 3, 0,
> +		19, 19, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 5, 6, 0,
> +		20, 20, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 6, 5, 0,
> +		21, 21, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 7, 8, 0,
> +		22, 22, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 8, 7, 0,
> +		23, 23, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 9, 10, 0,
> +		24, 24, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 10, 9, 0,
> +		25, 25, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 11, 12, 0,
> +		26, 26, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 12, 11, 0,
> +		27, 27, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 13, 14, 0,
> +		28, 28, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 14, 13, 0,
> +		29, 29, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 15, 16, 0,
> +		30, 30, IIO_ST('s', 24, 32, 0), 0),
> +	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 16, 15, 0,
> +		31, 31, IIO_ST('s', 24, 32, 0), 0),
> +};
> +
> +static IIO_DEVICE_ATTR(gain, S_IWUSR | S_IRUGO, show_gain, set_gain, -1);
> +
> +static struct attribute *ad7194_attributes[] = {
> +	&iio_dev_attr_gain.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7194_attribute_group = {
> +	.attrs = ad7194_attributes,
> +};
> +
> +static const struct iio_info ad7194_info = {
> +	.attrs = &ad7194_attribute_group,
> +	.read_raw = &show_voltage,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int __devinit ad7194_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct ad7194_state *st;
> +	struct iio_dev *indio_dev;
> +
> +	/* Configure the SPI bus */
> +	spi->mode = (SPI_MODE_0);
Again, please run checkpatch over this, those brackets will cause
a warning.
> +	spi->bits_per_word = 8;
Should be the default, but feel free to make sure!

> +	spi_setup(spi);
> +
> +	indio_dev = iio_allocate_device(sizeof(struct ad7194_state));
> +	if (indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	st = iio_priv(indio_dev);
> +

> +	dev_set_drvdata(&spi->dev, st);
Don't think this line does anything (fairly sure the spi_set_drvdata will
overwrite it in a mo).
> +
> +	st->spi_dev = spi;
> +
Why do we have two iio_allocate_devices?  One is plenty.
(I'm guessing this is dead code).
> +	st->indio_dev = iio_allocate_device(0);
> +	if (st->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi_dev = spi;
> +
> +	mutex_init(&st->lock);
> +	indio_dev->name = "ad7194";
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &ad7194_info;
> +	indio_dev->dev_data = (void *)st;
Gone.

> +	indio_dev->channels = ad7194_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7194_channels);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_free_device(st->indio_dev);
> +error_free:
Check this error path. st is never explicitly allocated.
> +	kfree(st);
> +exit:
> +	return ret;
> +}
> +
> +static int __devexit ad7194_remove(struct spi_device *spi)
> +{
roll into one line.
iio_device_unregister(spi_get_drvdata(spi));
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	iio_device_unregister(indio_dev);
> +	return 0;
> +}
> +
> +static struct spi_driver ad7194_driver = {
> +	.driver = {
> +		.name = DEVICE_NAME,
DEVICE_NAME is only used here, so I'd just put "ad7194" here
directly and get rid of the define.
> +		.bus = &spi_bus_type,
I'm fairly sure spi_register_driver will set the bus type
anyway so don't need this here.

> +		.owner = THIS_MODULE,
> +	},
> +
> +	.probe = ad7194_probe,
> +	.remove = __devexit_p(ad7194_remove),
> +};
> +
> +static int __init ad7194_init(void)
> +{
> +	return spi_register_driver(&ad7194_driver);
> +}
> +
> +static void __exit ad7194_exit(void)
> +{
> +	spi_unregister_driver(&ad7194_driver);
> +}
> +
> +module_init(ad7194_init);
Convention puts these directly under the functions rather than
in a block on their own down here.
> +module_exit(ad7194_exit);
> +
> +MODULE_AUTHOR("Paul Thomas <pthomas8589@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7194 A/D driver");
> +MODULE_LICENSE("GPL");

