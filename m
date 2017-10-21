Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932159AbdJUTdN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 15:33:13 -0400
Date: Sat, 21 Oct 2017 20:33:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: dac: Add Texas Instruments 8/10/12-bit
 2/4-channel DAC driver
Message-ID: <20171021203308.15ad9c1a@archlinux>
In-Reply-To: <a3d85aed78a808d170dc4d52253532a49ae02d22.1508232186.git.lukas@wunner.de>
References: <cover.1508232186.git.lukas@wunner.de>
        <a3d85aed78a808d170dc4d52253532a49ae02d22.1508232186.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Oct 2017 12:42:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The DACrrcS085 (rr = 08/10/12, c = 2/4) family of SPI DACs was
> inherited by TI when they acquired National Semiconductor in 2011.
> This driver was developed for and tested with the DAC082S085 built into
> the Revolution Pi by KUNBUS, but should work with any of the other
> chips as they share the same programming interface.
> 
> There is also a family of I2C DACs with just a single channel called
> DACrr1C08x (rr = 08/10/12, x = 1/5).  Their programming interface is
> very similar and it should be possible to extend the driver for these
> chips with moderate effort.  Alternatively they could be integrated into
> ad5446.c.  (The AD5301/AD5311/AD5321 use different power-down modes but
> otherwise appear to be comparable.)
> 
> Furthermore there is a family of 8-channel DACs called DACrr8S085
> (rr = 08/10/12) as well as two 16-bit DACs called DAC161Sxxx
> (xxx = 055/997).  These are more complicated devices with support for
> daisy-chaining and the ability to power down each channel separately.
> They could either be handled by a separate driver or integrated into the
> present driver with a larger effort.
> 
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
One issue inline, but I'll fix it.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   1 +
>  drivers/iio/dac/Kconfig                 |  10 +
>  drivers/iio/dac/Makefile                |   1 +
>  drivers/iio/dac/ti-dac082s085.c         | 351 ++++++++++++++++++++++++++++++++
>  4 files changed, 363 insertions(+)
>  create mode 100644 drivers/iio/dac/ti-dac082s085.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3fc79185cc56..2e3f919485f4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -522,6 +522,7 @@ Description:
>  		Specifies the output powerdown mode.
>  		DAC output stage is disconnected from the amplifier and
>  		1kohm_to_gnd: connected to ground via an 1kOhm resistor,
> +		2.5kohm_to_gnd: connected to ground via a 2.5kOhm resistor,
>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
>  		90kohm_to_gnd: connected to ground via a 90kOhm resistor,
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index d187233dec3a..965d5c0d2468 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -310,6 +310,16 @@ config STM32_DAC
>  config STM32_DAC_CORE
>  	tristate
>  
> +config TI_DAC082S085
> +	tristate "Texas Instruments 8/10/12-bit 2/4-channel DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Driver for the Texas Instruments (formerly National Semiconductor)
> +	  DAC082S085, DAC102S085, DAC122S085, DAC084S085, DAC104S085 and
> +	  DAC124S085.
> +
> +	  If compiled as a module, it will be called ti-dac082s085.
> +
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
>  	depends on OF
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8fe5af231698..4785858e04cc 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -33,4 +33,5 @@ obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
>  obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
>  obj-$(CONFIG_STM32_DAC) += stm32-dac.o
> +obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
>  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
> new file mode 100644
> index 000000000000..0fefb110be69
> --- /dev/null
> +++ b/drivers/iio/dac/ti-dac082s085.c
> @@ -0,0 +1,351 @@
> +/*
> + * ti-dac082s085.c - Texas Instruments 8/10/12-bit 2/4-channel DAC driver
> + *
> + * Copyright (C) 2017 KUNBUS GmbH
> + *
> + * http://www.ti.com/lit/ds/symlink/dac082s085.pdf
> + * http://www.ti.com/lit/ds/symlink/dac102s085.pdf
> + * http://www.ti.com/lit/ds/symlink/dac122s085.pdf
> + * http://www.ti.com/lit/ds/symlink/dac084s085.pdf
> + * http://www.ti.com/lit/ds/symlink/dac104s085.pdf
> + * http://www.ti.com/lit/ds/symlink/dac124s085.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License (version 2) as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +/**
> + * struct ti_dac_chip - TI DAC chip
> + * @lock: protects write sequences
> + * @vref: regulator generating Vref
> + * @mesg: SPI message to perform a write
> + * @xfer: SPI transfer used by @mesg
> + * @buf: buffer for @xfer
> + * @val: cached value of each output
> + * @powerdown: whether the chip is powered down
> + * @powerdown_mode: selected by the user
> + * @resolution: resolution of the chip
> + */
> +struct ti_dac_chip {
> +	struct mutex lock;
> +	struct regulator *vref;
> +	struct spi_message mesg;
> +	struct spi_transfer xfer;
> +	u8 buf[2] ____cacheline_aligned;
I missed this the first time.  The whole point of the fun
of ____cacheline_aligned is to ensure nothing shares a
cacheline with the buffer used for DMA.  We take care
when allocating these private structures that this
will be true, but it relies on nothing that might be
changed during dma being after the buffer.

Simple reordering fix so I'll do it whilst applying.
> +	u16 val[4];
> +	bool powerdown;
> +	u8 powerdown_mode;
> +	u8 resolution;
> +};
> +
> +#define WRITE_NOT_UPDATE(chan)	(0x00 | (chan) << 6)
> +#define WRITE_AND_UPDATE(chan)	(0x10 | (chan) << 6)
> +#define WRITE_ALL_UPDATE	 0x20
> +#define POWERDOWN(mode) 	(0x30 | ((mode) + 1) << 6)
> +
> +static int ti_dac_cmd(struct ti_dac_chip *ti_dac, u8 cmd, u16 val)
> +{
> +	u8 shift = 12 - ti_dac->resolution;
> +
> +	ti_dac->buf[0] = cmd | (val >> (8 - shift));
> +	ti_dac->buf[1] = (val << shift) & 0xff;
> +	return spi_sync(ti_dac->mesg.spi, &ti_dac->mesg);
> +}
> +
> +static const char * const ti_dac_powerdown_modes[] = {
> +	"2.5kohm_to_gnd", "100kohm_to_gnd", "three_state",
> +};
> +
> +static int ti_dac_get_powerdown_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan)
> +{
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +
> +	return ti_dac->powerdown_mode;
> +}
> +
> +static int ti_dac_set_powerdown_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     unsigned int mode)
> +{
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (ti_dac->powerdown_mode == mode)
> +		return 0;
> +
> +	mutex_lock(&ti_dac->lock);
> +	if (ti_dac->powerdown) {
> +		ret = ti_dac_cmd(ti_dac, POWERDOWN(mode), 0);
> +		if (ret)
> +			goto out;
> +	}
> +	ti_dac->powerdown_mode = mode;
> +
> +out:
> +	mutex_unlock(&ti_dac->lock);
> +	return ret;
> +}
> +
> +static const struct iio_enum ti_dac_powerdown_mode = {
> +	.items = ti_dac_powerdown_modes,
> +	.num_items = ARRAY_SIZE(ti_dac_powerdown_modes),
> +	.get = ti_dac_get_powerdown_mode,
> +	.set = ti_dac_set_powerdown_mode,
> +};
> +
> +static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     char *buf)
> +{
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", ti_dac->powerdown);
> +}
> +
> +static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +	bool powerdown;
> +	int ret;
> +
> +	ret = strtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	if (ti_dac->powerdown == powerdown)
> +		return len;
> +
> +	mutex_lock(&ti_dac->lock);
> +	if (powerdown)
> +		ret = ti_dac_cmd(ti_dac, POWERDOWN(ti_dac->powerdown_mode), 0);
> +	else
> +		ret = ti_dac_cmd(ti_dac, WRITE_AND_UPDATE(0), ti_dac->val[0]);
> +	if (!ret)
> +		ti_dac->powerdown = powerdown;
> +	mutex_unlock(&ti_dac->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_chan_spec_ext_info ti_dac_ext_info[] = {
> +	{
> +		.name	   = "powerdown",
> +		.read	   = ti_dac_read_powerdown,
> +		.write	   = ti_dac_write_powerdown,
> +		.shared	   = IIO_SHARED_BY_TYPE,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", &ti_dac_powerdown_mode),
> +	{ },
> +};
> +
> +#define TI_DAC_CHANNEL(chan) {					\
> +	.type = IIO_VOLTAGE,					\
> +	.channel = (chan),					\
> +	.address = (chan),					\
> +	.indexed = true,					\
> +	.output = true,						\
> +	.datasheet_name = (const char[]){ 'A' + (chan), 0 },	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.ext_info = ti_dac_ext_info,				\
> +}
> +
> +static const struct iio_chan_spec ti_dac_channels[] = {
> +	TI_DAC_CHANNEL(0),
> +	TI_DAC_CHANNEL(1),
> +	TI_DAC_CHANNEL(2),
> +	TI_DAC_CHANNEL(3),
> +};
> +
> +static int ti_dac_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = ti_dac->val[chan->channel];
> +		ret = IIO_VAL_INT;
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(ti_dac->vref);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret / 1000;
> +		*val2 = ti_dac->resolution;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ti_dac_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (ti_dac->val[chan->channel] == val)
> +			return 0;
> +
> +		if (val >= (1 << ti_dac->resolution) || val < 0)
> +			return -EINVAL;
> +
> +		if (ti_dac->powerdown)
> +			return -EBUSY;
> +
> +		mutex_lock(&ti_dac->lock);
> +		ret = ti_dac_cmd(ti_dac, WRITE_AND_UPDATE(chan->channel), val);
> +		if (!ret)
> +			ti_dac->val[chan->channel] = val;
> +		mutex_unlock(&ti_dac->lock);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ti_dac_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info ti_dac_info = {
> +	.read_raw	   = ti_dac_read_raw,
> +	.write_raw	   = ti_dac_write_raw,
> +	.write_raw_get_fmt = ti_dac_write_raw_get_fmt,
> +};
> +
> +static int ti_dac_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ti_dac_chip *ti_dac;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*ti_dac));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &ti_dac_info;
> +	indio_dev->name = spi->modalias;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ti_dac_channels;
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ti_dac = iio_priv(indio_dev);
> +	ti_dac->xfer.tx_buf = &ti_dac->buf;
> +	ti_dac->xfer.len = sizeof(ti_dac->buf);
> +	spi_message_init_with_transfers(&ti_dac->mesg, &ti_dac->xfer, 1);
> +	ti_dac->mesg.spi = spi;
> +
> +	ret = sscanf(spi->modalias, "dac%2hhu%1d",
> +		     &ti_dac->resolution, &indio_dev->num_channels);
> +	WARN_ON(ret != 2);
> +
> +	ti_dac->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(ti_dac->vref))
> +		return PTR_ERR(ti_dac->vref);
> +
> +	ret = regulator_enable(ti_dac->vref);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&ti_dac->lock);
> +
> +	ret = ti_dac_cmd(ti_dac, WRITE_ALL_UPDATE, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize outputs to 0\n");
> +		goto err;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	mutex_destroy(&ti_dac->lock);
> +	regulator_disable(ti_dac->vref);
> +	return ret;
> +}
> +
> +static int ti_dac_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	mutex_destroy(&ti_dac->lock);
> +	regulator_disable(ti_dac->vref);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ti_dac_of_id[] = {
> +	{ .compatible = "ti,dac082s085" },
> +	{ .compatible = "ti,dac102s085" },
> +	{ .compatible = "ti,dac122s085" },
> +	{ .compatible = "ti,dac084s085" },
> +	{ .compatible = "ti,dac104s085" },
> +	{ .compatible = "ti,dac124s085" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ti_dac_of_id);
> +#endif
> +
> +static const struct spi_device_id ti_dac_spi_id[] = {
> +	{ "dac082s085" },
> +	{ "dac102s085" },
> +	{ "dac122s085" },
> +	{ "dac084s085" },
> +	{ "dac104s085" },
> +	{ "dac124s085" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ti_dac_spi_id);
> +
> +static struct spi_driver ti_dac_driver = {
> +	.driver = {
> +		.name		= "ti-dac082s085",
> +		.of_match_table	= of_match_ptr(ti_dac_of_id),
> +	},
> +	.probe	  = ti_dac_probe,
> +	.remove   = ti_dac_remove,
> +	.id_table = ti_dac_spi_id,
> +};
> +module_spi_driver(ti_dac_driver);
> +
> +MODULE_AUTHOR("Lukas Wunner <lukas@wunner.de>");
> +MODULE_DESCRIPTION("Texas Instruments 8/10/12-bit 2/4-channel DAC driver");
> +MODULE_LICENSE("GPL v2");

