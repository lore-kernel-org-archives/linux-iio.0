Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:44550 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0K2XFb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2010 18:05:31 -0500
Message-ID: <4CF43350.4000703@cam.ac.uk>
Date: Mon, 29 Nov 2010 23:12:16 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: dds: ad9834: Enable driver support for
 AD9833 and AD9834 DDS devices
References: <1291045919-11141-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1291045919-11141-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/29/10 15:51, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> staging: iio: dds: ad9834: add missing include file
> 
> staging: iio: dds: ad9834: fix typo

Hi Michael,

Thanks for this driver and in particular the first thoughts on a
suitable abi design for these parts.  There are a few nitpicks
in the driver body that will be trivial to cleanup.

The abi needs more open discussion. I have inserted a few
suggestions here, but I would also like to see it formally
proposed as an RFC separate from the driver to linux-iio and
lkml. It's a fairly substantial new abi that we want to try
and get right. Given similar postings of IIO abi's in the
past the lkml posting may fall on deaf ears, but then at least
you can use it to bash latecomers over the head with when
they disagree with your interface 6 months down the line...
It won't help but it always makes me feel better and we might
get a few more people who did read it at the time coming
in on our side if we are lucky :)

Just wait... Someone will want to use a nice general DDS
as a clock input for some other part and hence ask about
in kernel interfaces...

Thanks,

Jonathan

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/dds/Kconfig  |   11 +-
>  drivers/staging/iio/dds/Makefile |    1 +
>  drivers/staging/iio/dds/ad9834.c |  348 ++++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/dds/ad9834.h |  108 ++++++++++++
>  drivers/staging/iio/dds/dds.h    |   99 +++++++++++
>  5 files changed, 565 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/staging/iio/dds/ad9834.c
>  create mode 100644 drivers/staging/iio/dds/ad9834.h
>  create mode 100644 drivers/staging/iio/dds/dds.h
> 
> diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
> index d045ed6..4c9cce3 100644
> --- a/drivers/staging/iio/dds/Kconfig
> +++ b/drivers/staging/iio/dds/Kconfig
> @@ -11,11 +11,18 @@ config AD5930
>  	  ad5930/ad5932, provides direct access via sysfs.
>  
>  config AD9832
> -	tristate "Analog Devices ad9832/3/4/5 driver"
> +	tristate "Analog Devices ad9832/5 driver"
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Analog Devices DDS chip
> -	  ad9832/3/4/5, provides direct access via sysfs.
This is somewhat 'interesting'.  Please add to commit comment to say
whether this change was due to only partial support existing in the
'old' driver or if it never worked in the first place for these
parts.
> +	  ad9832 and ad9835, provides direct access via sysfs.
> +
> +config AD9834
> +	tristate "Analog Devices ad9833/4/ driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices DDS chip
> +	  AD9833 and AD9834, provides direct access via sysfs.
>  
>  config AD9850
>  	tristate "Analog Devices ad9850/1 driver"
> diff --git a/drivers/staging/iio/dds/Makefile b/drivers/staging/iio/dds/Makefile
> index 6f274ac..1477461 100644
> --- a/drivers/staging/iio/dds/Makefile
> +++ b/drivers/staging/iio/dds/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-$(CONFIG_AD5930) += ad5930.o
>  obj-$(CONFIG_AD9832) += ad9832.o
> +obj-$(CONFIG_AD9834) += ad9834.o
>  obj-$(CONFIG_AD9850) += ad9850.o
>  obj-$(CONFIG_AD9852) += ad9852.o
>  obj-$(CONFIG_AD9910) += ad9910.o
> diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
> new file mode 100644
> index 0000000..d17f139
> --- /dev/null
> +++ b/drivers/staging/iio/dds/ad9834.c
> @@ -0,0 +1,348 @@
> +/*
> + * AD9834 SPI DAC driver
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <asm/div64.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "dds.h"
> +
> +#include "ad9834.h"
> +
> +static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
> +{
> +	unsigned long long freqreg = (u64) fout * (u64) (1 << AD9834_FREQ_BITS);
> +	do_div(freqreg, mclk);
> +	return freqreg;
> +}
> +
> +static int ad9834_write_frequency(struct ad9834_state *st,
> +				  unsigned long addr, unsigned long fout)
> +{
> +	unsigned long regval;
> +
> +	if (fout > (st->mclk / 2))
> +		return -EINVAL;
> +
> +	regval = ad9834_calc_freqreg(st->mclk, fout);
> +
> +	st->freq_data[0] = cpu_to_be16(addr | (regval &
> +				       RES_MASK(AD9834_FREQ_BITS / 2)));
> +	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
> +				       (AD9834_FREQ_BITS / 2)) &
> +				       RES_MASK(AD9834_FREQ_BITS / 2)));
> +
> +	return spi_sync(st->spi, &st->freq_msg);;
> +}
> +
> +static int ad9834_write_phase(struct ad9834_state *st,
> +				  unsigned long addr, unsigned long phase)
> +{
> +	if (phase > (1 << AD9834_PHASE_BITS))
> +		return -EINVAL;
> +	st->data = cpu_to_be16(addr | phase);
> +
> +	return spi_sync(st->spi, &st->msg);
> +}
> +
> +static ssize_t ad9834_write(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad9834_state *st = dev_info->dev_data;
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int ret;
> +	long val;
> +
> +	ret = strict_strtol(buf, 10, &val);
> +	if (ret)
> +		goto error_ret;
> +
> +	mutex_lock(&dev_info->mlock);
> +	switch (this_attr->address) {
> +	case AD9834_REG_FREQ0:
> +	case AD9834_REG_FREQ1:
> +		ret = ad9834_write_frequency(st, this_attr->address, val);
> +		break;
> +	case AD9834_REG_PHASE0:
> +	case AD9834_REG_PHASE1:
> +		ret = ad9834_write_phase(st, this_attr->address, val);
> +		break;
> +	case AD9834_PIN_SW:
> +	case AD9834_OPBITEN:
> +		if (val)
> +			st->control |= this_attr->address;
> +		else
> +			st->control &= ~this_attr->address;
Odd tabbing
> +			st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> +		ret = spi_sync(st->spi, &st->msg);
> +		break;
> +	case AD9834_FSEL:
> +	case AD9834_PSEL:
> +		if (val == 0)
> +			st->control &= ~(this_attr->address | AD9834_PIN_SW);
> +		else if (val == 1) {
> +			st->control |= this_attr->address;
> +			st->control &= ~AD9834_PIN_SW;
> +		}
Do we want an error if val is anything else rather than carrying on
with the last valid setting?

> +		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> +		ret = spi_sync(st->spi, &st->msg);
> +		break;
> +	case AD9834_RESET:
> +		if (val)
> +			st->control |= AD9834_RESET;
> +		else
> +			st->control &= ~AD9834_RESET;
Appears to be a tab issue on the next line.
> +			st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> +		ret = spi_sync(st->spi, &st->msg);
> +		break;
> +	default:
> +		ret = -ENODEV;
> +	}
> +	mutex_unlock(&dev_info->mlock);
> +
> +error_ret:
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad9834_store_mode(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad9834_state *st = dev_info->dev_data;
> +	int ret;
> +
> +	mutex_lock(&dev_info->mlock);
Use the sysfs_streq instead for these? (avoids possible white
space issues etc).
> +	if (strncmp(buf, "sine", 4) == 0)
> +		st->control &= ~AD9834_MODE;
> +	else if (strncmp(buf, "triangle", 8) == 0)
> +		st->control |= AD9834_MODE;
> +	else
> +		ret = -EINVAL;
> +	mutex_unlock(&dev_info->mlock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad9834_show_name(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
> +
> +	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
> +}
> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad9834_show_name, NULL, 0);
> +

Comments on these alongside the header where the macros are
defined.
> +static IIO_DEV_ATTR_FREQ(0, ad9834_write, AD9834_REG_FREQ0);
> +static IIO_DEV_ATTR_FREQ(1, ad9834_write, AD9834_REG_FREQ1);
> +static IIO_DEV_ATTR_FREQ_EN(ad9834_write, AD9834_FSEL);
> +static IIO_CONST_ATTR_FREQ_SCALE("1"); /* 1Hz */
> +
> +static IIO_DEV_ATTR_PHASE(0, ad9834_write, AD9834_REG_PHASE0);
> +static IIO_DEV_ATTR_PHASE(1, ad9834_write, AD9834_REG_PHASE1);
> +static IIO_DEV_ATTR_PHASE_EN(ad9834_write, AD9834_PSEL);
> +static IIO_CONST_ATTR_PHASE_SCALE("0.0015339808"); /* 2PI/2^12 rad*/
> +
> +static IIO_DEV_ATTR_PINCONTROL_EN(ad9834_write, AD9834_PIN_SW);
> +static IIO_DEV_ATTR_DISABLE(ad9834_write, AD9834_RESET);
> +static IIO_DEV_ATTR_SIGNBIT_OUTPUT_EN(ad9834_write, AD9834_OPBITEN);
> +static IIO_DEV_ATTR_OUTPUT_MODE(ad9834_store_mode, 0);
> +static IIO_CONST_ATTR_AVAILABLE_OUTPUT_MODES("sine triangle");
> +
> +static struct attribute *ad9834_attributes[] = {
> +	&iio_dev_attr_freq0.dev_attr.attr,
> +	&iio_dev_attr_freq1.dev_attr.attr,
> +	&iio_const_attr_freq_scale.dev_attr.attr,
> +	&iio_dev_attr_phase0.dev_attr.attr,
> +	&iio_dev_attr_phase1.dev_attr.attr,
> +	&iio_const_attr_phase_scale.dev_attr.attr,
> +	&iio_dev_attr_pincontrol_en.dev_attr.attr,
> +	&iio_dev_attr_freq_en.dev_attr.attr,
> +	&iio_dev_attr_phase_en.dev_attr.attr,
> +	&iio_dev_attr_disable.dev_attr.attr,
> +	&iio_dev_attr_signbit_output_en.dev_attr.attr,
> +	&iio_dev_attr_output_mode.dev_attr.attr,
> +	&iio_const_attr_available_output_modes.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad9834_attribute_group = {
> +	.attrs = ad9834_attributes,
> +};
> +
> +static int __devinit ad9834_probe(struct spi_device *spi)
> +{
> +	struct ad9834_platform_data *pdata = spi->dev.platform_data;
> +	struct ad9834_state *st;
> +	int ret, voltage_uv = 0;
> +
> +	if (!pdata) {
> +		dev_dbg(&spi->dev, "no platform data?\n");
> +		return -ENODEV;
> +	}
> +
> +	st = kzalloc(sizeof(*st), GFP_KERNEL);
> +	if (st == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	st->reg = regulator_get(&spi->dev, "vcc");
> +	if (!IS_ERR(st->reg)) {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			goto error_put_reg;
> +
> +		voltage_uv = regulator_get_voltage(st->reg);
Guessing you wanted to do something with this but haven't
implemented it yet?
> +	}
> +
> +	st->mclk = pdata->mclk;
> +
> +	spi_set_drvdata(spi, st);
> +
> +	st->spi = spi;
> +
> +	st->indio_dev = iio_allocate_device();
> +	if (st->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_disable_reg;
> +	}
> +
> +	st->indio_dev->dev.parent = &spi->dev;
> +	st->indio_dev->attrs = &ad9834_attribute_group;
> +	st->indio_dev->dev_data = (void *)(st);
> +	st->indio_dev->driver_module = THIS_MODULE;
> +	st->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Setup default messages */
> +
> +	st->xfer.tx_buf = &st->data;
> +	st->xfer.len = 2;
> +
> +	spi_message_init(&st->msg);
> +	spi_message_add_tail(&st->xfer, &st->msg);
> +
> +	st->freq_xfer[0].tx_buf = &st->freq_data[0];
> +	st->freq_xfer[0].len = 2;
> +	st->freq_xfer[0].cs_change = 1;
> +	st->freq_xfer[1].tx_buf = &st->freq_data[1];
> +	st->freq_xfer[1].len = 2;
> +
> +	spi_message_init(&st->freq_msg);
> +	spi_message_add_tail(&st->freq_xfer[0], &st->freq_msg);
> +	spi_message_add_tail(&st->freq_xfer[1], &st->freq_msg);
> +
> +	st->control = AD9834_B28 | AD9834_RESET;
> +
> +	if (!pdata->en_div2)
> +		st->control |= AD9834_DIV2;
> +
> +	if (!pdata->en_signbit_msb_out)
> +		st->control |= AD9834_SIGN_PIB;
> +
> +	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> +	ret = spi_sync(st->spi, &st->msg);
> +
> +	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, pdata->freq0);
Annoying though it might be, I'd prefer to see the errors handled
independently. Weird things might happen if two different errors
are output. This is far from implausible as an initial error in transmission
might give say -EAGAIN then continuing problems cause EIO (or similar).
> +	ret |= ad9834_write_frequency(st, AD9834_REG_FREQ1, pdata->freq1);
> +	ret |= ad9834_write_phase(st, AD9834_REG_PHASE0, pdata->phase0);
> +	ret |= ad9834_write_phase(st, AD9834_REG_PHASE1, pdata->phase1);
> +
> +	st->control &= ~AD9834_RESET;
> +
> +	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> +	ret |= spi_sync(st->spi, &st->msg);
> +
> +	if (ret) {
> +		dev_err(&spi->dev, "device init failed\n");
> +		goto error_free_device;
> +	}
> +
> +	ret = iio_device_register(st->indio_dev);
> +	if (ret)
> +		goto error_free_device;
> +
> +	return 0;
> +
> +error_free_device:
> +	iio_free_device(st->indio_dev);
> +error_disable_reg:
> +	if (!IS_ERR(st->reg))
> +		regulator_disable(st->reg);
> +error_put_reg:
> +	if (!IS_ERR(st->reg))
> +		regulator_put(st->reg);
> +	kfree(st);
> +error_ret:
> +	return ret;
> +}
> +
> +static int ad9834_remove(struct spi_device *spi)
> +{
> +	struct ad9834_state *st = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = st->indio_dev;
> +
> +	iio_device_unregister(indio_dev);
> +	if (!IS_ERR(st->reg)) {
> +		regulator_disable(st->reg);
> +		regulator_put(st->reg);
> +	}
> +	kfree(st);
> +	return 0;
> +}
> +
> +static const struct spi_device_id ad9834_id[] = {
> +	{"ad9833", ID_AD9833},
> +	{"ad9834", ID_AD9834},
I don't think you ever use the enum values. If you don't
and there is not likely to be a need anytime soon, it
would be a little cleaner not to specify them. That
would make it clear the parts are identical as far as the
driver is concerned.
> +	{}
> +};
> +
> +static struct spi_driver ad9834_driver = {
> +	.driver = {
> +		.name	= "ad9834",
> +		.bus	= &spi_bus_type,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ad9834_probe,
> +	.remove		= __devexit_p(ad9834_remove),
> +	.id_table	= ad9834_id,
> +};
> +
> +static int __init ad9834_init(void)
> +{
> +	return spi_register_driver(&ad9834_driver);
> +}
> +module_init(ad9834_init);
> +
> +static void __exit ad9834_exit(void)
> +{
> +	spi_unregister_driver(&ad9834_driver);
> +}
> +module_exit(ad9834_exit);
> +
> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> +MODULE_DESCRIPTION("Analog Devices AD9833/AD9834 DAC");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:ad9834");
> diff --git a/drivers/staging/iio/dds/ad9834.h b/drivers/staging/iio/dds/ad9834.h
> new file mode 100644
> index 0000000..9b59061
> --- /dev/null
> +++ b/drivers/staging/iio/dds/ad9834.h
> @@ -0,0 +1,108 @@
> +/*
> + * AD9834 SPI DDS driver
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +#ifndef IIO_DDS_AD9834_H_
> +#define IIO_DDS_AD9834_H_
> +
> +/* Registers */
> +
> +#define AD9834_REG_CMD		(0 << 14)
> +#define AD9834_REG_FREQ0	(1 << 14)
> +#define AD9834_REG_FREQ1	(2 << 14)
> +#define AD9834_REG_PHASE0	(6 << 13)
> +#define AD9834_REG_PHASE1	(7 << 13)
> +
> +/* Command Control Bits */
> +
> +#define AD9834_B28		(1 << 13)
> +#define AD9834_HLB		(1 << 12)
> +#define AD9834_FSEL		(1 << 11)
> +#define AD9834_PSEL		(1 << 10)
> +#define AD9834_PIN_SW		(1 << 9)
> +#define AD9834_RESET		(1 << 8)
> +#define AD9834_SLEEP1		(1 << 7)
> +#define AD9834_SLEEP12		(1 << 6)
> +#define AD9834_OPBITEN		(1 << 5)
> +#define AD9834_SIGN_PIB		(1 << 4)
> +#define AD9834_DIV2		(1 << 3)
> +#define AD9834_MODE		(1 << 1)
> +
> +#define AD9834_FREQ_BITS	28
> +#define AD9834_PHASE_BITS	12
> +
> +#define RES_MASK(bits)	((1 << (bits)) - 1)
> +
Proper docs make me happy :)  Makes it nice and easy
to spot odd items...
> +/**
> + * struct ad9834_state - driver instance specific data
> + * @indio_dev:		the industrial I/O device
> + * @spi:		spi_device
> + * @reg:		supply regulator
> + * @poll_work:		bottom half of polling interrupt handler
No sign of any poll work in this driver at the mo...

> + * @mclk:		external master clock
> + * @control:		cached control word
> + * @xfer:		default spi transfer
> + * @msg:		default spi message
> + * @data:		spi transmit buffer
> + * @freq_xfer:		tuning word spi transfer
> + * @freq_msg:		tuning word spi message
> + * @freq_data:		tuning word spi transmit buffer
> + */
> +
> +struct ad9834_state {
> +	struct iio_dev			*indio_dev;
> +	struct spi_device		*spi;
> +	struct regulator		*reg;
> +	struct work_struct		poll_work;
> +	unsigned int			mclk;
> +	unsigned short			control;
> +	struct spi_transfer		xfer;
> +	struct spi_message		msg;
> +	unsigned short			data;
> +	struct spi_transfer		freq_xfer[2];
> +	struct spi_message		freq_msg;
Going to need your usual alignment trick to avoid cache line
problems. Same for data above I think.
> +	unsigned short			freq_data[2];
> +};
> +
> +
> +/*
> + * TODO: struct ad7887_platform_data needs to go into include/linux/iio
> + */
> +
> +/**
> + * struct ad9834_platform_data - platform specific information
> + * @mclk:		master clock in Hz
> + * @freq0:		power up freq0 tuning word in Hz
> + * @freq1:		power up freq1 tuning word in Hz
> + * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
> + * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
> + * @en_div2:		digital output/2 is passed to the SIGN BIT OUT pin
> + * @en_signbit_msb_out:	the MSB (or MSB/2) of the DAC data is connected to the
> + 			SIGN BIT OUT pin. en_div2 controls whether it is the MSB
> + 			or MSB/2 that is output. if en_signbit_msb_out=false,
> + 			the on-board comparator is connected to SIGN BIT OUT
> + */
> +
> +struct ad9834_platform_data {
> +	unsigned int		mclk;
> +	unsigned int		freq0;
> +	unsigned int		freq1;
> +	unsigned short		phase0;
> +	unsigned short		phase1;
> +	bool			en_div2;
> +	bool			en_signbit_msb_out;
> +};
> +
> +/**
> + * ad9834_supported_device_ids:
> + */
> +
> +enum ad9834_supported_device_ids {
> +	ID_AD9833,
> +	ID_AD9834,
> +};
> +
> +#endif /* IIO_DDS_AD9834_H_ */
> diff --git a/drivers/staging/iio/dds/dds.h b/drivers/staging/iio/dds/dds.h
> new file mode 100644
> index 0000000..6cbede6
> --- /dev/null
> +++ b/drivers/staging/iio/dds/dds.h
> @@ -0,0 +1,99 @@
> +/*
> + * dds.h - sysfs attributes associated with DDS devices
> + */

Good to see so much documentation. I would ask that this also exists
in the Documentation directory. Given there is so little overlap in
attributes between this and our existing elements, it probably makes
sense to add a new file called something like sysfs-bus-iio-dds.
I also think this interface is worth posting (in that form) as an RFC to
lkml. Note Greg just merged a big cleanup of the existing docs so that
should be in linux-next etc tomorrow.

I am going to read this pretty much without referring to the datasheet
so as to see how it might read to someone coming in with a different
dds device.
> +
> +/**
> + * /sys/bus/iio/devices/deviceX/freqX
> + * Description:
> + * Stores frequency into tuning word register X.
> + * There can be more than one freqX file, which allows for pin controlled FSK
> + * Frequency Shift Keying (en_pincontrol is active) or the user can control
> + * the desired active tuning word by writing X to the en_freq file.
> + */
> +
> +#define IIO_DEV_ATTR_FREQ(_num, _store, _addr)				\
> +	IIO_DEVICE_ATTR(freq##_num, S_IWUSR, NULL, _store, _addr)
> +
Do we need a base name for these? If we have a device that combines a dds
element with other IIO elements things could get rather confusing. This is
also true if we have a single device with multiple dds channels (perhaps
a more common situation).

Perhaps somthing like...

ddsX_freqY
ddsX_freq_en
ddsX_phaseY
ddsX_phase_en
ddsX_phase_scale
ddsX_phaseY_scale
ddsX_phase_en

> +/**
> + * /sys/bus/iio/devices/deviceX/freq_en
> + * Description:
> + * Specifies the active output frequency tuning word.
> + * To exit this mode the user can write pincontrol_en or disable file.
> + */
Based on the description I didn't really follow this one.
Looking at what the code does, it's a simple input for of the current FSK symbol?
_en is not a good name for it.  I'd go with ddsX_freqsymbol or something like
that. The value then corresponds to the Y in ddsX_freqY.

> +
> +#define IIO_DEV_ATTR_FREQ_EN(_store, _addr)				\
> +	IIO_DEVICE_ATTR(freq_en, S_IWUSR, NULL, _store, _addr);
> +
> +#define IIO_CONST_ATTR_FREQ_SCALE(_string)		\
> +	IIO_CONST_ATTR(freq_scale, _string)
This should probably be under the freqX element as that is what it applies
to. I'd like to see some explanation.
> +
> +/**
> + * /sys/bus/iio/devices/deviceX/phaseX
> + * Description:
> + * Stores phase into phase register X.
> + * There can be more than one phaseX file, which allows for pin controlled PSK
> + * Phase Shift Keying (en_pincontrol is active) or the user can control
> + * the desired phase X which is added to the phase accumulator output
> + * by writing X to the en_phase file.
> + */
> +
> +#define IIO_DEV_ATTR_PHASE(_num, _store, _addr)				\
> +	IIO_DEVICE_ATTR(phase##_num, S_IWUSR, NULL, _store, _addr)
> +
> +/**
> + * /sys/bus/iio/devices/deviceX/phase_en
> + * Description:
> + * Specifies the active phase which is added to the phase accumulator output.
> + * To exit this mode the user can write pincontrol_en or disable file.
> + */
> +
These have the same questions as above for frequency.
> +#define IIO_DEV_ATTR_PHASE_EN(_store, _addr)				\
> +	IIO_DEVICE_ATTR(phase_en, S_IWUSR, NULL, _store, _addr);
> +
> +#define IIO_CONST_ATTR_PHASE_SCALE(_string)		\
> +	IIO_CONST_ATTR(phase_scale, _string)
> +
> +
> +/**
> + * /sys/bus/iio/devices/deviceX/pincontrol_en
> + * Description:
> + * The active frequency and phase is controlled by the respective
> + * phase and frequency control inputs.
> + */
> +
> +#define IIO_DEV_ATTR_PINCONTROL_EN(_store, _addr)			\
> +	IIO_DEVICE_ATTR(pincontrol_en, S_IWUSR, NULL, _store, _addr);
Is it just about plausible we will get a device with separate pin control
for phase and frequency? (I really don't know much about these devices ;)
If so that naming should allow for it.  Perhaps you are allowing for
it here and the specific ones would be
ddsX_pincontrol_phase_en
ddsX_pincontrol_freq_en
or
dds_pincontrol_en for one that covers all channels and both phase and
frequency?


> +
> +/**
> + * /sys/bus/iio/devices/deviceX/disable
> + * Description:
> + * Disables any signal generation, the output is set to midscale
Is the midscale a feature of this part of absolutely general? i.e. do
we want to enforce this by documentation or allow for some flexibility
(and a means to specify if it is something else?).
> + */
> +
> +#define IIO_DEV_ATTR_DISABLE(_store, _addr)				\
> +	IIO_DEVICE_ATTR(disable, S_IWUSR, NULL, _store, _addr);
> +
> +/**
> + * /sys/bus/iio/devices/deviceX/signbit_output_en
> + * Description:
> + * Enables an auxiliary square wave output
> + */
> +#define IIO_DEV_ATTR_SIGNBIT_OUTPUT_EN(_store, _addr)				\
> +	IIO_DEVICE_ATTR(signbit_output_en, S_IWUSR, NULL, _store, _addr);
How standard is this?  Can we make it look more general. See next comment.
> +
> +/**
> + * /sys/bus/iio/devices/deviceX/output_mode
> + * Description:
> + * Specifies the output waveform.
> + * For a list of available output waveform modes read available_output_modes.
> + */
> +#define IIO_DEV_ATTR_OUTPUT_MODE(_store, _addr)				\
> +	IIO_DEVICE_ATTR(output_mode, S_IWUSR, NULL, _store, _addr);
ddsX_waveform (or perhaps wavetype)  seems more descriptive to me. Output mode
could cover a whole host of things!

dds0_wavetype (sine, triangle, square)

>>From a generalization point of view we don't care that the square wave is a
random bonus option the part happens to be able to kick out.  Ideally we
want a naming scheme that makes it's relationship to the other waveforms
apparent though and it's not entirely obvious how to handle that (e.g.
how to handle the double frequency square wave this part can produce).
Things will get more fun if parts have multiple outputs tied to one dds
channel.

I'd also like to see the docs including the current options and a description
of each. It's fairly obvious for those we have here, but there are going
to be less simple cases in future!

> +
> +/**
> + * /sys/bus/iio/devices/deviceX/available_output_modes
> + * Description:
> + * Lists all available output waveform modes
> + */
> +#define IIO_CONST_ATTR_AVAILABLE_OUTPUT_MODES(_modes)			\
> +	IIO_CONST_ATTR(available_output_modes, _modes);

