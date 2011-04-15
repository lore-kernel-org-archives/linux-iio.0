Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46132 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab1DOQf1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 12:35:27 -0400
Message-ID: <4DA87440.6000609@cam.ac.uk>
Date: Fri, 15 Apr 2011 17:37:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/1] IIO: DAC: New driver for AD5791/AD5781 High Resolution
 Voltage Output DACs
References: <1302783984-26300-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1302783984-26300-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/14/11 13:26, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
Yikes. That union stuff for the transfers is ugly. Having
said that I can't immediately see a better way of doing it.
Otherwise another nice clean an easy to read driver. Thanks,
I don't think I've overly broken anything in here with the recent
changes.  The only acception is adding a 0 parameter to iio_allocate_device.

That kind of depends on when Greg picks up the last set I sent him.

The other cleanup that applies here is to set indio_dev->name and
get rid of the explicit name attribute.  Can do that one later
though as it will still work as is.  Just saves a few lines of
code.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

> ---
>  drivers/staging/iio/dac/Kconfig  |   10 +
>  drivers/staging/iio/dac/Makefile |    1 +
>  drivers/staging/iio/dac/ad5791.c |  418 ++++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/dac/ad5791.h |  109 ++++++++++
>  4 files changed, 538 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/dac/ad5791.c
>  create mode 100644 drivers/staging/iio/dac/ad5791.h
> 
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index 1b0188a..f25468a 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -31,6 +31,16 @@ config AD5504
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5504.
>  
> +config AD5791
> +	tristate "Analog Devices AD5781/AD5791 DAC SPI driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD5781, AD5791,
> +	  High Resolution Voltage Output Digital to Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5791.
> +
>  config MAX517
>  	tristate "Maxim MAX517/518/519 DAC driver"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
> index 020df4a..83196de 100644
> --- a/drivers/staging/iio/dac/Makefile
> +++ b/drivers/staging/iio/dac/Makefile
> @@ -5,4 +5,5 @@
>  obj-$(CONFIG_AD5624R_SPI) += ad5624r_spi.o
>  obj-$(CONFIG_AD5504) += ad5504.o
>  obj-$(CONFIG_AD5446) += ad5446.o
> +obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
> new file mode 100644
> index 0000000..545f1a6
> --- /dev/null
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -0,0 +1,418 @@
> +/*
> + * AD5791, AD5791 Voltage Output Digital to Analog Converter
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "dac.h"
> +#include "ad5791.h"
> +
> +static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
> +{
> +	union {
> +		u32 d32;
> +		u8 d8[4];
> +	} data;
> +
> +	data.d32 = cpu_to_be32(AD5791_CMD_WRITE |
> +			      AD5791_ADDR(addr) |
> +			      (val & AD5791_DAC_MASK));
> +
> +	return spi_write(spi, &data.d8[1], 3);
> +}
> +
> +static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
> +{
> +	union {
> +		u32 d32;
> +		u8 d8[4];
> +	} data[3];
> +	int ret;
> +	struct spi_message msg;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &data[0].d8[1],
> +			.bits_per_word = 8,
> +			.len = 3,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = &data[1].d8[1],
> +			.rx_buf = &data[2].d8[1],
> +			.bits_per_word = 8,
> +			.len = 3,
> +		},
> +	};
> +
> +	data[0].d32 = cpu_to_be32(AD5791_CMD_READ |
> +			      AD5791_ADDR(addr));
> +	data[1].d32 = cpu_to_be32(AD5791_ADDR(AD5791_ADDR_NOOP));
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	ret = spi_sync(spi, &msg);
> +
> +	*val = be32_to_cpu(data[2].d32);
> +
> +	return ret;
> +}
> +
> +static ssize_t ad5791_write_dac(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	long readin;
> +	int ret;
> +
> +	ret = strict_strtol(buf, 10, &readin);
> +	if (ret)
> +		return ret;
> +
> +	readin += (1 << (st->chip_info->bits - 1));
> +	readin &= AD5791_RES_MASK(st->chip_info->bits);
> +	readin <<= st->chip_info->left_shift;
> +
> +	ret = ad5791_spi_write(st->spi, this_attr->address, readin);
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad5791_read_dac(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int ret;
> +	int val;
> +
> +	ret = ad5791_spi_read(st->spi, this_attr->address, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= AD5791_DAC_MASK;
> +	val >>= st->chip_info->left_shift;
> +	val -= (1 << (st->chip_info->bits - 1));
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t ad5791_read_powerdown_mode(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +
> +	const char mode[][14] = {"6kohm_to_gnd", "three_state"};
> +
> +	return sprintf(buf, "%s\n", mode[st->pwr_down_mode]);
> +}
> +
> +static ssize_t ad5791_write_powerdown_mode(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +	int ret;
> +
> +	if (sysfs_streq(buf, "6kohm_to_gnd"))
> +		st->pwr_down_mode = AD5791_DAC_PWRDN_6K;
> +	else if (sysfs_streq(buf, "three_state"))
> +		st->pwr_down_mode = AD5791_DAC_PWRDN_3STATE;
> +	else
> +		ret = -EINVAL;
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad5791_read_dac_powerdown(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->pwr_down);
> +}
> +
> +static ssize_t ad5791_write_dac_powerdown(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	long readin;
> +	int ret;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +
> +	ret = strict_strtol(buf, 10, &readin);
> +	if (ret)
> +		return ret;
> +
> +	if (readin == 0) {
> +		st->pwr_down = false;
> +		st->ctrl &= ~(AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
> +	} else if (readin == 1) {
> +		st->pwr_down = true;
> +		if (st->pwr_down_mode == AD5791_DAC_PWRDN_6K)
> +			st->ctrl |= AD5791_CTRL_OPGND;
> +		else if (st->pwr_down_mode == AD5791_DAC_PWRDN_3STATE)
> +			st->ctrl |= AD5791_CTRL_DACTRI;
> +	} else
> +		ret = -EINVAL;
> +
> +	ret = ad5791_spi_write(st->spi, AD5791_ADDR_CTRL, st->ctrl);
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad5791_show_scale(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +	/* Corresponds to Vref / 2^(bits) */
> +	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
> +
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
> +}
> +static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5791_show_scale, NULL, 0);
> +
> +static ssize_t ad5791_show_name(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
> +
> +	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
> +}
> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad5791_show_name, NULL, 0);
> +
> +#define IIO_DEV_ATTR_OUT_RW_RAW(_num, _show, _store, _addr)		\
> +	IIO_DEVICE_ATTR(out##_num##_raw,				\
> +			S_IRUGO | S_IWUSR, _show, _store, _addr)
> +
> +static IIO_DEV_ATTR_OUT_RW_RAW(0, ad5791_read_dac,
> +	ad5791_write_dac, AD5791_ADDR_DAC0);
> +
> +static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO |
> +			S_IWUSR, ad5791_read_powerdown_mode,
> +			ad5791_write_powerdown_mode, 0);
> +
> +static IIO_CONST_ATTR(out_powerdown_mode_available,
> +			"6kohm_to_gnd three_state");
> +
> +#define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _show, _store, _addr)		\
> +	IIO_DEVICE_ATTR(out##_num##_powerdown,				\
> +			S_IRUGO | S_IWUSR, _show, _store, _addr)
> +
> +static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5791_read_dac_powerdown,
> +				   ad5791_write_dac_powerdown, 0);
> +
> +static struct attribute *ad5791_attributes[] = {
> +	&iio_dev_attr_out0_raw.dev_attr.attr,
> +	&iio_dev_attr_out0_powerdown.dev_attr.attr,
> +	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
> +	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
> +	&iio_dev_attr_out_scale.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad5791_attribute_group = {
> +	.attrs = ad5791_attributes,
> +};
> +
> +static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
> +	[ID_AD5791] = {
> +		.bits = 20,
> +		.left_shift = 0,
> +	},
> +	[ID_AD5781] = {
> +		.bits = 18,
> +		.left_shift = 2,
> +	},
> +};
> +
> +static int ad5791_get_lin_comp(unsigned int span)
> +{
> +	if (span <= 10000)
> +		return AD5791_LINCOMP_0_10;
> +	else if (span <= 12000)
> +		return AD5791_LINCOMP_10_12;
> +	else if (span <= 16000)
> +		return AD5791_LINCOMP_12_16;
> +	else if (span <= 19000)
> +		return AD5791_LINCOMP_16_19;
> +	else
> +		return AD5791_LINCOMP_19_20;
> +}
> +
> +static int __devinit ad5791_probe(struct spi_device *spi)
> +{
> +	struct ad5791_platform_data *pdata = spi->dev.platform_data;
> +	struct ad5791_state *st;
> +	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
> +
> +	st = kzalloc(sizeof(*st), GFP_KERNEL);
> +	if (st == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	spi_set_drvdata(spi, st);
> +
> +	st->reg_vdd = regulator_get(&spi->dev, "vdd");
> +	if (!IS_ERR(st->reg_vdd)) {
> +		ret = regulator_enable(st->reg_vdd);
> +		if (ret)
> +			goto error_put_reg_pos;
> +
> +		pos_voltage_uv = regulator_get_voltage(st->reg_vdd);
> +	}
> +
> +	st->reg_vss = regulator_get(&spi->dev, "vss");
> +	if (!IS_ERR(st->reg_vss)) {
> +		ret = regulator_enable(st->reg_vss);
> +		if (ret)
> +			goto error_put_reg_neg;
> +
> +		neg_voltage_uv = regulator_get_voltage(st->reg_vss);
> +	}
> +
> +	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd))
> +		st->vref_mv = (pos_voltage_uv - neg_voltage_uv) / 1000;
> +	else if (pdata)
> +		st->vref_mv = pdata->vref_pos_mv - pdata->vref_neg_mv;
> +	else
> +		dev_warn(&spi->dev, "reference voltage unspecified\n");
> +
> +	ret = ad5791_spi_write(spi, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
> +	if (ret)
> +		goto error_disable_reg_neg;
> +
> +	st->chip_info =
> +		&ad5791_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> +
> +
> +	st->ctrl = AD5761_CTRL_LINCOMP(ad5791_get_lin_comp(st->vref_mv)) |
> +		  ((pdata && pdata->use_rbuf_gain2) ? 0 : AD5791_CTRL_RBUF) |
> +		  AD5791_CTRL_BIN2SC;
> +
> +	ret = ad5791_spi_write(spi, AD5791_ADDR_CTRL, st->ctrl |
> +		AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
> +	if (ret)
> +		goto error_disable_reg_neg;
> +
> +	st->pwr_down = true;
> +
> +	st->spi = spi;
> +	st->indio_dev = iio_allocate_device();
> +	if (st->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_disable_reg_neg;
> +	}
> +	st->indio_dev->dev.parent = &spi->dev;
> +	st->indio_dev->dev_data = (void *)(st);
> +	st->indio_dev->attrs = &ad5791_attribute_group;
> +	st->indio_dev->driver_module = THIS_MODULE;
> +	st->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(st->indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_free_device(st->indio_dev);
> +
> +error_disable_reg_neg:
> +	if (!IS_ERR(st->reg_vss))
> +		regulator_disable(st->reg_vss);
> +error_put_reg_neg:
> +	if (!IS_ERR(st->reg_vss))
> +		regulator_put(st->reg_vss);
> +
> +	if (!IS_ERR(st->reg_vdd))
> +		regulator_disable(st->reg_vdd);
> +error_put_reg_pos:
> +	if (!IS_ERR(st->reg_vdd))
> +		regulator_put(st->reg_vdd);
> +
> +	kfree(st);
> +error_ret:
> +	return ret;
> +}
> +
> +static int __devexit ad5791_remove(struct spi_device *spi)
> +{
> +	struct ad5791_state *st = spi_get_drvdata(spi);
> +
> +	iio_device_unregister(st->indio_dev);
> +
> +	if (!IS_ERR(st->reg_vdd)) {
> +		regulator_disable(st->reg_vdd);
> +		regulator_put(st->reg_vdd);
> +	}
> +
> +	if (!IS_ERR(st->reg_vss)) {
> +		regulator_disable(st->reg_vss);
> +		regulator_put(st->reg_vss);
> +	}
> +
> +	kfree(st);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id ad5791_id[] = {
> +	{"ad5791", ID_AD5791},
> +	{"ad5781", ID_AD5781},
> +	{}
> +};
> +
> +static struct spi_driver ad5791_driver = {
> +	.driver = {
> +		   .name = "ad5791",
> +		   .owner = THIS_MODULE,
> +		   },
> +	.probe = ad5791_probe,
> +	.remove = __devexit_p(ad5791_remove),
> +	.id_table = ad5791_id,
> +};
> +
> +static __init int ad5791_spi_init(void)
> +{
> +	return spi_register_driver(&ad5791_driver);
> +}
> +module_init(ad5791_spi_init);
> +
> +static __exit void ad5791_spi_exit(void)
> +{
> +	spi_unregister_driver(&ad5791_driver);
> +}
> +module_exit(ad5791_spi_exit);
> +
> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> +MODULE_DESCRIPTION("Analog Devices AD5791/AD5781 DAC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/dac/ad5791.h b/drivers/staging/iio/dac/ad5791.h
> new file mode 100644
> index 0000000..71c7d59
> --- /dev/null
> +++ b/drivers/staging/iio/dac/ad5791.h
> @@ -0,0 +1,109 @@
> +/*
> + * AD5791 SPI DAC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#ifndef SPI_AD5791_H_
> +#define SPI_AD5791_H_
> +
> +#define AD5791_RES_MASK(x)		((1 << (x)) - 1)
> +#define AD5791_DAC_MASK			AD5791_RES_MASK(20)
> +#define AD5791_DAC_MSB			(1 << 19)
> +
> +#define AD5791_CMD_READ			(1 << 23)
> +#define AD5791_CMD_WRITE		(0 << 23)
> +#define AD5791_ADDR(addr)		((addr) << 20)
> +
> +/* Registers */
> +#define AD5791_ADDR_NOOP		0
> +#define AD5791_ADDR_DAC0		1
> +#define AD5791_ADDR_CTRL		2
> +#define AD5791_ADDR_CLRCODE		3
> +#define AD5791_ADDR_SW_CTRL		4
> +
> +/* Control Register */
> +#define AD5791_CTRL_RBUF		(1 << 1)
> +#define AD5791_CTRL_OPGND		(1 << 2)
> +#define AD5791_CTRL_DACTRI		(1 << 3)
> +#define AD5791_CTRL_BIN2SC		(1 << 4)
> +#define AD5791_CTRL_SDODIS		(1 << 5)
> +#define AD5761_CTRL_LINCOMP(x)		((x) << 6)
> +
> +#define AD5791_LINCOMP_0_10		0
> +#define AD5791_LINCOMP_10_12		1
> +#define AD5791_LINCOMP_12_16		2
> +#define AD5791_LINCOMP_16_19		3
> +#define AD5791_LINCOMP_19_20		12
> +
> +/* Software Control Register */
> +#define AD5791_SWCTRL_LDAC		(1 << 0)
> +#define AD5791_SWCTRL_CLR		(1 << 1)
> +#define AD5791_SWCTRL_RESET		(1 << 2)
> +
> +#define AD5791_DAC_PWRDN_6K		0
> +#define AD5791_DAC_PWRDN_3STATE		1
> +
> +/*
> + * TODO: struct ad5791_platform_data needs to go into include/linux/iio
> + */
> +
> +/**
> + * struct ad5791_platform_data - platform specific information
> + * @vref_pos_mv:	Vdd Positive Analog Supply Volatge (mV)
> + * @vref_neg_mv:	Vdd Negative Analog Supply Volatge (mV)
> + * @use_rbuf_gain2:	ext. amplifier connected in gain of two configuration
> + */
> +
> +struct ad5791_platform_data {
> +	u16				vref_pos_mv;
> +	u16				vref_neg_mv;
> +	bool				use_rbuf_gain2;
> +};
> +
> +/**
> + * struct ad5791_chip_info - chip specific information
> + * @bits:		accuracy of the DAC in bits
> + * @left_shift:		number of bits the datum must be shifted
> + */
> +
> +struct ad5791_chip_info {
> +	u8			bits;
> +	u8			left_shift;
> +};
> +
> +/**
> + * struct ad5791_state - driver instance specific data
> + * @indio_dev:		the industrial I/O device
> + * @us:			spi_device
> + * @reg_vdd:		positive supply regulator
> + * @reg_vss:		negative supply regulator
> + * @chip_info:		chip model specific constants
> + * @vref_mv:		actual reference voltage used
> + * @pwr_down_mode	current power down mode
> + */
> +
> +struct ad5791_state {
> +	struct iio_dev			*indio_dev;
> +	struct spi_device		*spi;
> +	struct regulator		*reg_vdd;
> +	struct regulator		*reg_vss;
> +	const struct ad5791_chip_info	*chip_info;
> +	unsigned short			vref_mv;
> +	unsigned			ctrl;
> +	unsigned			pwr_down_mode;
> +	bool				pwr_down;
> +};
> +
> +/**
> + * ad5791_supported_device_ids:
> + */
> +
> +enum ad5791_supported_device_ids {
> +	ID_AD5791,
> +	ID_AD5781,
> +};
> +
> +#endif /* SPI_AD5791_H_ */

