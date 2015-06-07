Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47685 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFGQLi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:11:38 -0400
Message-ID: <55746D35.1030409@kernel.org>
Date: Sun, 07 Jun 2015 17:11:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete
 ADC
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com> <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/15 13:20, Vladimir Barinov wrote:
> Add Holt descrete ADC driver for HI-8435/8436/8437 chips
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Hmm. The main issue here is one man's discrete ADC is another man's
configurable general purpose input device.

Anyhow, from an IIO point of view what we care about is consistent
userspace interface. A discrete ADC to userspace is definitely a generic
input, be it one with a configurable threshold level and other bells
and whistles.

Right now IIO does not have explicit support for digital I/O channels,
but it's been discussed many times before.  We do want some buy in from
the GPIO infrastructure guys though to avoid stepping on peoples toes!
Also I suspect we'd need an IIO to gpio bridge pretty soon as well
as the likelihood of someone using the gpios in an IIO device to save
themselves some pins on their soc is very high.

There are generic gpios on some of the IMUs and similar, but they have
always been ignored in drivers, or just handled by registering them as
a GPIO rather than through the buffered interfaces etc.  I suspect if
the core support was in place, there would be interesting in this
functionality.

Lars, you've looked at the demux stuff a lot more recently than I have.
One issue this driver raises is single bit channels. For those I think
we need to support 1 bit packing throughout.  How hard do you think it
would be?
(1 bit, 8 bit, 16 bit, 32 bit, 64 bit etc) rather than any more complex
packing.



> ---
>  drivers/iio/adc/Kconfig   |  12 +
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/hi-843x.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 790 insertions(+)
>  create mode 100644 drivers/iio/adc/hi-843x.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e36a73e..71b0efc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -164,6 +164,18 @@ config EXYNOS_ADC
>  	  of SoCs for drivers such as the touchscreen and hwmon to use to share
>  	  this resource.
>  
> +config HI_843X
> +	tristate "Holt Integrated Circuits HI-8435/8436/8437"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for Holt Integrated Circuits
> +	  HI-8435/8436/8437 chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called hi-843x.
> +
>  config LP8788_ADC
>  	tristate "LP8788 ADC driver"
>  	depends on MFD_LP8788
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 3930e63..65f54c2 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> +obj-$(CONFIG_HI_843X) += hi-843x.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1027) += max1027.o
>  obj-$(CONFIG_MAX1363) += max1363.o
> diff --git a/drivers/iio/adc/hi-843x.c b/drivers/iio/adc/hi-843x.c
> new file mode 100644
> index 0000000..ccc46e7
> --- /dev/null
> +++ b/drivers/iio/adc/hi-843x.c
> @@ -0,0 +1,777 @@
> +/*
> + * Holt Integrated Circuits HI-8435/8436/8437 discrete ADC driver
> + *
> + * Copyright (C) 2015 Zodiac Inflight Innovations
> + * Copyright (C) 2015 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/interrupt.h>
> +
> +#define DRV_NAME "hi-843x"
> +
> +/* Register offsets for HI-843X */
> +#define HI843X_CTRL_REG			0x02
> +#define HI843X_PSEN_REG			0x04
> +#define HI843X_TMDATA_REG		0x1E
> +#define HI843X_GOCENHYS_REG		0x3A
> +#define HI843X_SOCENHYS_REG		0x3C
> +#define HI843X_SO7_0_REG		0x10
> +#define HI843X_SO15_8_REG		0x12
> +#define HI843X_SO23_16_REG		0x14
> +#define HI843X_SO31_24_REG		0x16
> +#define HI843X_SO31_0_REG		0x78
> +
> +#define HI843X_WRITE_OPCODE		0x00
> +#define HI843X_READ_OPCODE		0x80
> +
> +/* THRESHOLD mask */
> +#define HI843X_THRESHOLD_MAX		0x3f
> +#define HI843X_THRESHOLD_MASK		0xff
> +
> +/* CTRL register bits */
> +#define HI843X_CTRL_TEST		0x01
> +#define HI843X_CTRL_SRST		0x02
> +
> +#define HI843X_DEBOUNCE_SOFT_DELAY_MAX	1000	/* ms */
> +#define HI843X_DEBOUNCE_SOFT_DELAY_DEF	100	/* ms */
> +
> +struct hi843x_priv {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	struct delayed_work work;
> +
> +	int mr_gpio;
> +	bool debounce_soft;
> +	int debounce_soft_delay;
> +	int debounce_soft_val;
> +
> +	void *iio_buffer;
> +	u8 reg_buffer[4] ____cacheline_aligned;
> +};
> +
> +static int hi843x_readb(struct hi843x_priv *priv, u8 reg, u8 *val)
> +{
> +	reg |= HI843X_READ_OPCODE;
> +	return spi_write_then_read(priv->spi, &reg, 1, val, 1);
> +}
> +
> +static int hi843x_readw(struct hi843x_priv *priv, u8 reg, u16 *val)
> +{
> +	int ret;
> +
> +	reg |= HI843X_READ_OPCODE;
> +	ret = spi_write_then_read(priv->spi, &reg, 1, val, 2);
> +	*val = swab16p(val);
> +
> +	return ret;
> +}
> +
> +static int hi843x_readl(struct hi843x_priv *priv, u8 reg, u32 *val)
> +{
> +	int ret;
> +
> +	reg |= HI843X_READ_OPCODE;
> +	ret = spi_write_then_read(priv->spi, &reg, 1, val, 4);
> +	*val = swab32p(val);
These all need checking as unlikely to be true for both be and le
platforms.
> +
> +	return ret;
> +}
> +
> +static int hi843x_writeb(struct hi843x_priv *priv, u8 reg, u8 val)
> +{
> +	priv->reg_buffer[0] = reg | HI843X_WRITE_OPCODE;
> +	priv->reg_buffer[1] = val;
> +
> +	return spi_write(priv->spi, priv->reg_buffer, 2);
> +}
> +
> +static int hi843x_writew(struct hi843x_priv *priv, u8 reg, u16 val)
> +{
> +	priv->reg_buffer[0] = reg | HI843X_WRITE_OPCODE;
> +	priv->reg_buffer[1] = (val >> 8) & 0xff;
> +	priv->reg_buffer[2] = val & 0xff;
> +
> +	return spi_write(priv->spi, priv->reg_buffer, 3);
> +}
> +
> +ssize_t hi843x_debounce_soft_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", priv->debounce_soft);
> +}
> +
> +ssize_t hi843x_debounce_soft_delay_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", priv->debounce_soft_delay);
> +}
> +
> +ssize_t hi843x_sensing_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u8 reg;
> +
> +	ret = hi843x_readb(priv, HI843X_PSEN_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", reg);
> +}
> +
> +ssize_t hi843x_test_enable_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u8 reg;
> +
> +	ret = hi843x_readb(priv, HI843X_CTRL_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", reg & HI843X_CTRL_TEST);
> +}
> +
> +ssize_t hi843x_test_mode_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u8 reg;
> +
> +	ret = hi843x_readb(priv, HI843X_TMDATA_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", reg);
> +}
> +
> +ssize_t hi843x_debounce_soft_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	priv->debounce_soft = !!val;
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_debounce_soft_delay_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > HI843X_DEBOUNCE_SOFT_DELAY_MAX)
> +		val = HI843X_DEBOUNCE_SOFT_DELAY_MAX;
> +
> +	priv->debounce_soft_delay = val;
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_sensing_mode_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
This definitely looks like magic number territory.
ABI must be easy to understand without the datasheet to hand etc.

> +
> +	hi843x_writeb(priv, HI843X_PSEN_REG, val & 0xf);
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_test_enable_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	hi843x_writeb(priv, HI843X_CTRL_REG, val ? HI843X_CTRL_TEST : 0);
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_test_mode_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	hi843x_writeb(priv, HI843X_TMDATA_REG, val & 0xf);
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_threshold_gohys_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u16 reg;
> +
> +	ret = hi843x_readw(priv, HI843X_GOCENHYS_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", (reg >> 8) & HI843X_THRESHOLD_MASK);
> +}
> +
> +ssize_t hi843x_threshold_gocval_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u16 reg;
> +
> +	ret = hi843x_readw(priv, HI843X_GOCENHYS_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", reg & HI843X_THRESHOLD_MASK);
> +}
> +
> +ssize_t hi843x_threshold_sohys_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u16 reg;
> +
> +	ret = hi843x_readw(priv, HI843X_SOCENHYS_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", (reg >> 8) & HI843X_THRESHOLD_MASK);
> +}
> +
> +ssize_t hi843x_threshold_socval_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +	u16 reg;
> +
> +	ret = hi843x_readw(priv, HI843X_SOCENHYS_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", reg & HI843X_THRESHOLD_MASK);
> +}
> +
> +ssize_t hi843x_threshold_gohys_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val, ret;
> +	u16 reg;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > HI843X_THRESHOLD_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = hi843x_readw(priv, HI843X_GOCENHYS_REG, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +	reg &= ~(HI843X_THRESHOLD_MASK << 8);
> +	reg |= (val << 8);
> +	hi843x_writew(priv, HI843X_GOCENHYS_REG, reg);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_threshold_gocval_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val, ret;
> +	u16 reg;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > HI843X_THRESHOLD_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = hi843x_readw(priv, HI843X_GOCENHYS_REG, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +	reg &= ~HI843X_THRESHOLD_MASK;
> +	reg |= val;
> +	hi843x_writew(priv, HI843X_GOCENHYS_REG, reg);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_threshold_sohys_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val, ret;
> +	u16 reg;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > HI843X_THRESHOLD_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = hi843x_readw(priv, HI843X_SOCENHYS_REG, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +	reg &= ~(HI843X_THRESHOLD_MASK << 8);
> +	reg |= (val << 8);
> +	hi843x_writew(priv, HI843X_SOCENHYS_REG, reg);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return len;
> +}
> +
> +ssize_t hi843x_threshold_socval_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct hi843x_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val, ret;
> +	u16 reg;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > HI843X_THRESHOLD_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = hi843x_readw(priv, HI843X_SOCENHYS_REG, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +	reg &= ~HI843X_THRESHOLD_MASK;
> +	reg |= val;
> +	hi843x_writew(priv, HI843X_SOCENHYS_REG, reg);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(debounce_soft, S_IRUGO | S_IWUSR,
> +	hi843x_debounce_soft_show, hi843x_debounce_soft_store, 0);
> +static IIO_DEVICE_ATTR(debounce_soft_delay, S_IRUGO | S_IWUSR,
> +	hi843x_debounce_soft_delay_show, hi843x_debounce_soft_delay_store, 0);
> +static IIO_DEVICE_ATTR(sensing_mode, S_IRUGO | S_IWUSR,
> +	hi843x_sensing_mode_show, hi843x_sensing_mode_store, 0);
> +static IIO_DEVICE_ATTR(test_enable, S_IRUGO | S_IWUSR,
> +	hi843x_test_enable_show, hi843x_test_enable_store, 0);
> +static IIO_DEVICE_ATTR(test_mode, S_IRUGO | S_IWUSR,
> +	hi843x_test_mode_show, hi843x_test_mode_store, 0);
> +static IIO_DEVICE_ATTR(threshold_gohys, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_gohys_show, hi843x_threshold_gohys_store, 0);
> +static IIO_DEVICE_ATTR(threshold_gocval, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_gocval_show, hi843x_threshold_gocval_store, 0);
> +static IIO_DEVICE_ATTR(threshold_sohys, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_sohys_show, hi843x_threshold_sohys_store, 0);
> +static IIO_DEVICE_ATTR(threshold_socval, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_socval_show, hi843x_threshold_socval_store, 0);
> +
> +static struct attribute *hi843x_attributes[] = {
> +	&iio_dev_attr_debounce_soft.dev_attr.attr,
> +	&iio_dev_attr_debounce_soft_delay.dev_attr.attr,
Userspace doesn't care that the debounce is software or hardware so
we want to come up with a generic interface that covers the common
ways debouncing is done.

> +	&iio_dev_attr_sensing_mode.dev_attr.attr,
> +	&iio_dev_attr_test_enable.dev_attr.attr,
> +	&iio_dev_attr_test_mode.dev_attr.attr,
> +	&iio_dev_attr_threshold_gohys.dev_attr.attr,
> +	&iio_dev_attr_threshold_gocval.dev_attr.attr,
> +	&iio_dev_attr_threshold_sohys.dev_attr.attr,
> +	&iio_dev_attr_threshold_socval.dev_attr.attr,
Thse all need documentation in Documenation/ABI/testing/sysfs-bus-iio-*
> +	NULL,
> +};
> +
> +static struct attribute_group hi843x_attribute_group = {
> +	.attrs = hi843x_attributes,
> +};
> +
> +static int hi843x_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
> +{
> +	struct hi843x_priv *priv = iio_priv(idev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +	case IIO_CHAN_INFO_RAW:
> +		ret = hi843x_readl(priv, HI843X_SO31_0_REG, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (mask == IIO_CHAN_INFO_RAW)
> +			*val = !!(*val & BIT(channel->channel));
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define HI843X_VOLTAGE_CHANNEL(num)				\
> +	{							\
> +		.type = IIO_VOLTAGE,				\
> +		.indexed = 1,					\
> +		.channel = num,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.scan_index = num,				\
> +		.scan_type = {					\
> +			.sign = 'u',				\
> +			.realbits = 1,				\
> +			.storagebits = 8,			\
> +		},						\
> +	}
As commented at the start of this review. These are not voltage channels
as userspace understands them (I understand from a hardware point of
view where you are coming from but we have to care about what the software
using them cares about!)

These are digital signals and need to be treated as such.

I wonder if we want to take this oportunity to add 1 bit packing to the
demux etc in the IIO core so we can have tighter packing on these
values.  Shouldn't be too hard to do and we probably do want it if we are
going to support these sorts of devices.

Will take a bit of shuffling to pack the relevant channels together if only
a subset are enabled and to notice when no repacking at all is needed.
This will probably first one implementing in the core and pushing out into
the dummy driver to allow for testing of corner cases.
> +
> +static const struct iio_chan_spec hi843x_channels[] = {
> +	HI843X_VOLTAGE_CHANNEL(0),
> +	HI843X_VOLTAGE_CHANNEL(1),
> +	HI843X_VOLTAGE_CHANNEL(2),
> +	HI843X_VOLTAGE_CHANNEL(3),
> +	HI843X_VOLTAGE_CHANNEL(4),
> +	HI843X_VOLTAGE_CHANNEL(5),
> +	HI843X_VOLTAGE_CHANNEL(6),
> +	HI843X_VOLTAGE_CHANNEL(7),
> +	HI843X_VOLTAGE_CHANNEL(8),
> +	HI843X_VOLTAGE_CHANNEL(9),
> +	HI843X_VOLTAGE_CHANNEL(10),
> +	HI843X_VOLTAGE_CHANNEL(11),
> +	HI843X_VOLTAGE_CHANNEL(12),
> +	HI843X_VOLTAGE_CHANNEL(13),
> +	HI843X_VOLTAGE_CHANNEL(14),
> +	HI843X_VOLTAGE_CHANNEL(15),
> +	HI843X_VOLTAGE_CHANNEL(16),
> +	HI843X_VOLTAGE_CHANNEL(17),
> +	HI843X_VOLTAGE_CHANNEL(18),
> +	HI843X_VOLTAGE_CHANNEL(19),
> +	HI843X_VOLTAGE_CHANNEL(20),
> +	HI843X_VOLTAGE_CHANNEL(21),
> +	HI843X_VOLTAGE_CHANNEL(22),
> +	HI843X_VOLTAGE_CHANNEL(23),
> +	HI843X_VOLTAGE_CHANNEL(24),
> +	HI843X_VOLTAGE_CHANNEL(25),
> +	HI843X_VOLTAGE_CHANNEL(26),
> +	HI843X_VOLTAGE_CHANNEL(27),
> +	HI843X_VOLTAGE_CHANNEL(28),
> +	HI843X_VOLTAGE_CHANNEL(29),
> +	HI843X_VOLTAGE_CHANNEL(30),
> +	HI843X_VOLTAGE_CHANNEL(31),
> +	{
> +		.type = IIO_ALTVOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.scan_index = 32,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(33),
> +};
> +
> +static const struct iio_info hi843x_info = {
> +	.driver_module = THIS_MODULE,
> +	.attrs = &hi843x_attribute_group,
> +	.read_raw = hi843x_read_raw,
> +};
> +
> +static void h843x_iio_push_to_buffers(struct iio_dev *idev, int val)
> +{
> +	struct hi843x_priv *priv = iio_priv(idev);
> +	u8 *pbuffer = priv->iio_buffer;
> +	int i;
> +
> +	for_each_set_bit(i, idev->active_scan_mask, idev->masklength) {
> +		if (idev->channels[i].type == IIO_ALTVOLTAGE) {
In what way is the is an AC voltage?
> +			*(u32 *)pbuffer = val;
> +			pbuffer += 4;
> +		 } else {
> +			*pbuffer = !!(val & BIT(i));
> +			pbuffer++;
> +		}
> +	}
> +	iio_push_to_buffers_with_timestamp(idev, priv->iio_buffer,
> +					   iio_get_time_ns());
> +}
> +
This soft debounce is interesting.  I wonder if we want to work
this into a more generic form for use on other devices?  Maybe something
to look at once we have more drivers where it is useful.

If it was an even sampling thing then we could do it as a generic
in kernel buffer client, but this requires a sport of spurt of readings
(well 2 in this case) which is not something we currently handle.

> +static void hi843x_debounce_soft_work(struct work_struct *work)
> +{
> +	struct hi843x_priv *priv = container_of(work, struct hi843x_priv,
> +						work.work);
> +	struct iio_dev *idev = spi_get_drvdata(priv->spi);
> +	int val, ret;
> +
> +	ret = hi843x_readl(priv, HI843X_SO31_0_REG, &val);
> +	if (ret < 0)
> +		return;
> +
> +	if (val == priv->debounce_soft_val)
> +		h843x_iio_push_to_buffers(idev, val);
> +	else
> +		dev_warn(&priv->spi->dev, "filtered by soft debounce");
> +}
> +
> +static irqreturn_t hi843x_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct hi843x_priv *priv = iio_priv(idev);
> +	int val, ret;
> +
your readl explicitly takes a u32* why do you use an int here?
> +	ret = hi843x_readl(priv, HI843X_SO31_0_REG, &val);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	if (priv->debounce_soft) {
> +		priv->debounce_soft_val = val;
> +		schedule_delayed_work(&priv->work,
> +				msecs_to_jiffies(priv->debounce_soft_delay));
> +	} else
> +		h843x_iio_push_to_buffers(idev, val);
> +
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hi843x_buffer_postenable(struct iio_dev *idev)
> +{
> +	struct hi843x_priv *priv = iio_priv(idev);
> +
> +	priv->iio_buffer = kmalloc(idev->scan_bytes, GFP_KERNEL);
> +	if (!priv->iio_buffer)
> +		return -ENOMEM;
> +
> +	return iio_triggered_buffer_postenable(idev);
> +}
> +
> +static int hi843x_buffer_predisable(struct iio_dev *idev)
> +{
> +	struct hi843x_priv *priv = iio_priv(idev);
> +	int ret;
> +
> +	ret = iio_triggered_buffer_predisable(idev);
> +	if (!ret)
> +		kfree(priv->iio_buffer);
Two options here, either use the update_scan_mask hook that is
meant for exactly this sort of thing, or take the view that
it is probably less wasteful to allocate the largest size you will
even need as part of the private structure and
remove the need for these custom ops functions entirely.
I'd go with the second option.
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops hi843x_buffer_setup_ops = {
> +	.postenable = &hi843x_buffer_postenable,
> +	.predisable = &hi843x_buffer_predisable,
> +};
> +
> +static const struct iio_trigger_ops hi843x_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
> +static void hi843x_parse_dt(struct hi843x_priv *priv)
> +{
> +	struct device_node *np = priv->spi->dev.of_node;
> +	int ret;
> +
> +	ret = of_get_named_gpio(np, "holt,mr-gpio", 0);
> +	priv->mr_gpio = ret < 0 ? 0 : ret;
> +
> +	if (of_find_property(np, "holt,debounce-soft", NULL))
> +		priv->debounce_soft = 1;
> +
> +	ret = of_property_read_u32(np, "holt,debounce-soft-delay",
> +				   &priv->debounce_soft_delay);
> +	if (ret)
> +		priv->debounce_soft_delay = HI843X_DEBOUNCE_SOFT_DELAY_DEF;
> +}
> +
> +static int hi843x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *idev;
> +	struct hi843x_priv *priv;
> +	int ret;
> +
> +	idev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(idev);
> +	priv->spi = spi;
> +
> +	if (spi->dev.of_node)
> +		hi843x_parse_dt(priv);
> +
> +	spi_set_drvdata(spi, idev);
> +	mutex_init(&priv->lock);
> +	INIT_DELAYED_WORK(&priv->work, hi843x_debounce_soft_work);
> +
> +	idev->dev.parent	= &spi->dev;
> +	idev->name		= spi_get_device_id(spi)->name;
> +	idev->modes		= INDIO_DIRECT_MODE;
> +	idev->info		= &hi843x_info;mmc35240
> +	idev->channels		= hi843x_channels;
> +	idev->num_channels	= ARRAY_SIZE(hi843x_channels);
> +
> +	if (priv->mr_gpio) {
> +		ret = devm_gpio_request(&spi->dev, priv->mr_gpio, idev->name);
> +		if (!ret) {
> +			/* chip hardware reset */
> +			gpio_direction_output(priv->mr_gpio, 0);
> +			udelay(5);
> +			gpio_direction_output(priv->mr_gpio, 1);
> +		}
> +	} else {
> +		/* chip software reset */
> +		hi843x_writeb(priv, HI843X_CTRL_REG, HI843X_CTRL_SRST);
> +		/* get out from reset state */
> +		hi843x_writeb(priv, HI843X_CTRL_REG, 0);
> +	}
> +
> +	ret = iio_triggered_buffer_setup(idev, NULL, hi843x_trigger_handler,
> +					 &hi843x_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(idev);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "unable to register device\n");
> +		goto unregister_buffer;
> +	}
> +
> +	return 0;
> +
> +unregister_buffer:
> +	iio_triggered_buffer_cleanup(idev);
> +	return ret;
> +}
> +
> +static int hi843x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *idev = spi_get_drvdata(spi);
> +	struct hi843x_priv *priv = iio_priv(idev);
> +
> +	cancel_delayed_work_sync(&priv->work);
> +	iio_device_unregister(idev);
> +	iio_triggered_buffer_cleanup(idev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id hi843x_dt_ids[] = {
> +	{ .compatible = "holt,hi-8435" },
> +	{ .compatible = "holt,hi-8436" },
> +	{ .compatible = "holt,hi-8437" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, hi843x_dt_ids);
> +
> +static const struct spi_device_id hi843x_id[] = {
> +	{ "hi-8435", 0},
> +	{ "hi-8436", 0},
> +	{ "hi-8437", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, hi843x_id);
> +
> +static struct spi_driver hi843x_driver = {
> +	.driver	= {
> +		.name		= DRV_NAME,
> +		.of_match_table	= of_match_ptr(hi843x_dt_ids),
> +	},
> +	.probe		= hi843x_probe,
> +	.remove		= hi843x_remove,
> +	.id_table	= hi843x_id,
> +};
> +module_spi_driver(hi843x_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Vladimir Barinov");
> +MODULE_DESCRIPTION("HI-8435/8436/8437 discrete ADC");
> 

