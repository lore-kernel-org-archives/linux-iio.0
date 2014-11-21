Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50269 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758431AbaKUO7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Nov 2014 09:59:13 -0500
Date: Fri, 21 Nov 2014 16:00:33 +0100
From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 2/2] iio: add driver for the TI DAC8554
Message-ID: <20141121150033.GA16636@avionic-0071.adnet.avionic-design.de>
References: <1416502461-13980-1-git-send-email-nikolaus.schulz@avionic-design.de>
 <1416502461-13980-2-git-send-email-nikolaus.schulz@avionic-design.de>
 <alpine.DEB.2.02.1411201911001.13081@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.DEB.2.02.1411201911001.13081@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 20, 2014 at 07:19:36PM +0100, Peter Meerwald wrote:
> 
> > The TI DAC8554 is a quad-channel Digital-to-Analog Converter with an SPI
> > interface.
> 
> some minor comments below, looks good
>  
> > Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> > ---
> >  drivers/iio/dac/Kconfig      |  10 ++
> >  drivers/iio/dac/Makefile     |   1 +
> >  drivers/iio/dac/ti-dac8554.c | 365 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 376 insertions(+)
> >  create mode 100644 drivers/iio/dac/ti-dac8554.c
> > 
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 2236ea2..1689260 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -181,4 +181,14 @@ config MCP4922
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called mcp4922.
> >  
> > +config TI_DAC8554
> > +	tristate "TI DAC8554 driver"
> > +	depends on SPI
> > +	depends on OF
> > +	help
> > +	  Say yes here to build the driver for the TI DAC8554.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called ti-dac8554.
> > +
> >  endmenu
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > index 52be7e1..b98d79a 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -20,3 +20,4 @@ obj-$(CONFIG_MAX517) += max517.o
> >  obj-$(CONFIG_MAX5821) += max5821.o
> >  obj-$(CONFIG_MCP4725) += mcp4725.o
> >  obj-$(CONFIG_MCP4922) += mcp4922.o
> > +obj-$(CONFIG_TI_DAC8554) += ti-dac8554.o
> > diff --git a/drivers/iio/dac/ti-dac8554.c b/drivers/iio/dac/ti-dac8554.c
> > new file mode 100644
> > index 0000000..9c135e1
> > --- /dev/null
> > +++ b/drivers/iio/dac/ti-dac8554.c
> > @@ -0,0 +1,365 @@
> > +/*
> > + * TI DAC8554 Digital to Analog Converter SPI driver
> > + *
> > + * Copyright (C) 2014 Avionic Design GmbH
> > + *
> > + * Based on ad5446r_spi.c
> > + * Copyright (C) 2010,2011 Analog Devices Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/spi/spi.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/of.h>
> > +
> > +#define DAC8554_DRIVERNAME			"ti-dac8554"
> > +#define DAC8554_DAC_CHANNELS			4
> > +
> > +/* Load commands */
> > +#define DAC8554_CMD_STORE_DAC_N			0x0
> > +#define DAC8554_CMD_UPDATE_DAC_N		0x1
> > +#define DAC8554_CMD_STORE_DAC_N_UPDATE_ALL	0x2
> > +#define DAC8554_CMD_UPDATE_BROADCAST		0x3
> > +
> > +#define DAC8554_BROADCAST_USE_SRDATA		0x2
> > +/* Powerdown modes (ORed PD1|PD2 bits) */
> > +#define DAC8554_PWRDN_HIZ			0x0
> > +#define DAC8554_PWRDN_1K			0x1
> > +#define DAC8554_PWRDN_100K			0x2
> > +
> > +#define DAC8554_PWRDN_TO_SR(mode)		(BIT(16) | (mode) << 14)
> > +
> > +/**
> > + * struct dac8554_state - driver instance specific data
> > + * @spi:		spi_device
> > + * @reg:		supply regulator
> > + * @addr:		two-bit chip address
> > + * @vref_mv:		reference voltage in millivolt
> > + * @val			DAC/channel data
> > + * @powerdown		channel powerdown flag
> > + * @powerdown_mode	channel powerdown mode
> > + */
> > +struct dac8554_state {
> > +	struct spi_device		*spi;
> > +	struct regulator		*reg;
> > +	unsigned			addr;
> > +	unsigned			vref_mv;
> > +	u16				val[DAC8554_DAC_CHANNELS];
> > +	bool				powerdown[DAC8554_DAC_CHANNELS];
> > +	u8				powerdown_mode[DAC8554_DAC_CHANNELS];
> > +};
> > +
> > +static int dac8554_spi_write(struct spi_device *spi,
> > +			     unsigned chip_addr, unsigned cmd,
> > +			     unsigned chan_addr, unsigned val)
> > +{
> > +	u32 data;
> > +	u8 msg[3];
> 
> careful with SPI; data should be ____cacheline_aligned

Ah, thanks.  Actually for DMA, it also shouldn't be on the stack.  I'll
move it into struct dac8554_state, just like the majority of ad* DAC
drivers do.

Looking at the other iio dac drivers, ad5624r_spi and ad5446 also
use unaligned memory on the stack for SPI transfers, and need be fixed
as well.

> > +
> > +	/*
> > +	 * The input shift register is 24 bits wide. The 8 MSB are
> > +	 * control bits, followed by 16 data bits.
> > +	 * The first two bits A1 and A0 address a DAC8554 chip.
> > +	 * The next two are the command bits, LD1 and LD0.
> > +	 * After a don't-care-bit, the next two bits select the channel.
> > +	 * The final control bit PD0 is a flag signalling if the data
> > +	 * bits encode a powerdown mode. We merge PD0 with the adjacent
> > +	 * data bits.
> > +	 */
> > +
> > +	if (chip_addr > 3 || cmd > 3 || chan_addr > 3 ||
> > +			(val > 0xffff && (val & ~DAC8554_PWRDN_TO_SR(3))))
> > +		return -EINVAL;
> > +
> > +	data = (chip_addr << 22) | (cmd << 20) | (chan_addr << 17) | val;
> > +	msg[0] = data >> 16;
> > +	msg[1] = data >> 8;
> > +	msg[2] = data;
> > +
> > +	return spi_write(spi, msg, sizeof(msg));
> > +}
> > +
> > +static int dac8554_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val,
> > +			    int *val2,
> > +			    long m)
> > +{
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +
> > +	switch (m) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		*val = st->val[chan->address];
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = st->vref_mv;
> > +		*val2 = 16;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int dac8554_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val,
> > +			     int val2,
> > +			     long mask)
> > +{
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +	int err = 0;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val > 0xffff || val < 0)
> > +			return -EINVAL;
> > +
> > +		err = dac8554_spi_write(st->spi, st->addr,
> > +				DAC8554_CMD_UPDATE_DAC_N,
> > +				chan->address, val);
> > +		if (err)
> > +			return err;
> > +
> > +		st->val[chan->address] = val;
> > +
> > +		/* By hw design, DAC updates automatically trigger powerup. */
> > +		st->powerdown[chan->address] = false;
> > +
> > +		return 0;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int dac8554_get_powerdown_mode(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan)
> > +{
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +
> > +	return st->powerdown_mode[chan->address];
> > +}
> > +
> > +static int dac8554_set_powerdown_mode(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      unsigned int mode)
> > +{
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +
> > +	st->powerdown_mode[chan->address] = mode;
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t dac8554_read_dac_powerdown(struct iio_dev *indio_dev,
> > +					  uintptr_t private,
> > +					  const struct iio_chan_spec *chan,
> > +					  char *buf)
> > +{
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +
> > +	return sprintf(buf, "%d\n", st->powerdown[chan->address]);
> > +}
> > +
> > +static ssize_t dac8554_write_dac_powerdown(struct iio_dev *indio_dev,
> > +					   uintptr_t private,
> > +					   const struct iio_chan_spec *chan,
> > +					   const char *buf,
> > +					   size_t len)
> > +{
> > +	bool powerdown;
> > +	int ret;
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +	u8 powerdown_mode;
> > +
> > +	ret = strtobool(buf, &powerdown);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->powerdown[chan->address] = powerdown;
> > +
> > +	if (powerdown) {
> > +		powerdown_mode = st->powerdown_mode[chan->address];
> > +		ret = dac8554_spi_write(st->spi, st->addr,
> > +				DAC8554_CMD_UPDATE_DAC_N,
> > +				chan->address,
> > +				DAC8554_PWRDN_TO_SR(powerdown_mode));
> > +	} else {
> > +		/* Load DAC with cached value. This triggers a powerup. */
> > +		ret = dac8554_spi_write(st->spi, st->addr,
> > +				DAC8554_CMD_UPDATE_DAC_N,
> > +				chan->address,
> > +				st->val[chan->address]);
> > +	}
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > +
> > +static int dac8554_powerdown_broadcast(struct dac8554_state *st,
> > +				       u8 powerdown_mode)
> > +{
> > +	int ret;
> > +
> > +	ret = dac8554_spi_write(st->spi, 0,
> > +			DAC8554_CMD_UPDATE_BROADCAST,
> > +			DAC8554_BROADCAST_USE_SRDATA,
> > +			DAC8554_PWRDN_TO_SR(powerdown_mode));
> > +	if (ret)
> > +		return ret;
> > +
> > +	memset(st->powerdown_mode, powerdown_mode, sizeof(st->powerdown_mode));
> > +	memset(st->powerdown, true, sizeof(st->powerdown));
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_info dac8554_info = {
> > +	.write_raw = dac8554_write_raw,
> > +	.read_raw = dac8554_read_raw,
> > +	.driver_module = THIS_MODULE,
> > +};
> > +
> > +static const char * const dac8554_powerdown_modes[] = {
> > +	"hi-z",
> 
> hi-z is (not yet) described in ABI/testing/sysfs-bus-iio, you should add 
> that

I'll switch that to "three_state", as suggested by Lars-Peter.

> > +	"1kohm_to_gnd",
> > +	"100kohm_to_gnd"
> > +};
> > +
> > +static const struct iio_enum dac8854_powerdown_mode_enum = {
> > +	.items = dac8554_powerdown_modes,
> > +	.num_items = ARRAY_SIZE(dac8554_powerdown_modes),
> > +	.get = dac8554_get_powerdown_mode,
> > +	.set = dac8554_set_powerdown_mode,
> > +};
> > +
> > +static const struct iio_chan_spec_ext_info dac8554_ext_info[] = {
> > +	{
> > +		.name = "powerdown",
> > +		.read = dac8554_read_dac_powerdown,
> > +		.write = dac8554_write_dac_powerdown,
> > +		.shared = IIO_SEPARATE,
> > +	},
> > +	IIO_ENUM("powerdown_mode", IIO_SEPARATE,
> > +		 &dac8854_powerdown_mode_enum),
> > +	IIO_ENUM_AVAILABLE("powerdown_mode", &dac8854_powerdown_mode_enum),
> > +	{ },
> > +};
> > +
> > +#define DAC8554_CHANNEL(chan) { \
> > +	.type = IIO_VOLTAGE, \
> > +	.indexed = 1, \
> > +	.output = 1, \
> > +	.channel = (chan), \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> > +	.address = (chan), \
> > +	.ext_info = dac8554_ext_info, \
> > +}
> > +const struct iio_chan_spec dac8554_channels[] = {
> > +	DAC8554_CHANNEL(0),
> > +	DAC8554_CHANNEL(1),
> > +	DAC8554_CHANNEL(2),
> > +	DAC8554_CHANNEL(3),
> > +};
> > +#undef DAC8554_CHANNEL
> 
> nothing wrong, but this would be the first IIO driver to #undef its 
> channel macro

Hehe. Ok, one might argue that #undef'ing it simply adds noise for
nothing substantial...

> > +
> > +static int dac8554_probe(struct spi_device *spi)
> > +{
> > +	struct dac8554_state *st;
> > +	struct iio_dev *indio_dev;
> > +	int ret, voltage_uv = 0;
> > +	u32 addr;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->name = DAC8554_DRIVERNAME;
> > +	indio_dev->info = &dac8554_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = dac8554_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(dac8554_channels);
> > +
> > +	spi_set_drvdata(spi, indio_dev);
> > +	ret = iio_device_register(indio_dev);
> 
> iio_device_register() should probably be the last thing in _probe();
> _state should be fully set up so requests can be handled

Ok.

> > +	if (ret)
> > +		return ret;
> > +
> > +	st = iio_priv(indio_dev);
> > +
> > +	if (!spi->dev.of_node) {
> > +		dev_err(&spi->dev, "missing OF node");
> > +		return -ENODEV;
> > +	}
> > +	ret = of_property_read_u32(spi->dev.of_node, "address", &addr);
> > +	if (ret || addr > 2) {
> 
> addr < 0?

Ah! Yes.

> > +		dev_err(&spi->dev, "no or invalid chip address");
> > +		return -ENODEV;
> > +	}
> > +
> > +	st->spi = spi;
> > +	st->addr = addr;
> > +
> > +	st->reg = devm_regulator_get(&spi->dev, "vref");
> > +	if (IS_ERR(st->reg))
> > +		return PTR_ERR(st->reg);
> > +
> > +	ret = regulator_enable(st->reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	voltage_uv = regulator_get_voltage(st->reg);
> > +	if (voltage_uv < 0)
> > +		goto error_disable_reg;
> > +	st->vref_mv = voltage_uv / 1000;
> > +
> > +	ret = dac8554_powerdown_broadcast(st, DAC8554_PWRDN_100K);
> > +	if (ret)
> > +		goto error_disable_reg;
> > +
> > +	return 0;
> > +
> > +error_disable_reg:
> > +	regulator_disable(st->reg);
> > +	return ret;
> > +}
> > +
> > +static int dac8554_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct dac8554_state *st = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> 
> probably a powerdown?

It's powered down anyway by disabling the regulator, isnt' it?

> > +	regulator_disable(st->reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id dac8554_of_match[] = {
> > +	{ .compatible = "ti,dac8554" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, dac8554_of_match);
> > +
> > +static struct spi_driver dac8554_driver = {
> > +	.driver = {
> > +		.name = DAC8554_DRIVERNAME,
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = dac8554_of_match,
> > +	 },
> > +	.probe = dac8554_probe,
> > +	.remove = dac8554_remove,
> > +};
> > +module_spi_driver(dac8554_driver);
> > +
> > +MODULE_AUTHOR("Nikolaus Schulz <nikolaus.schulz@avionic-design.de>");
> > +MODULE_DESCRIPTION("Texas Instruments DAC8554 SPI driver");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> -- 
> 
> Peter Meerwald
> +43-664-2444418 (mobile)

Thanks for the review!

-- 
Avionic Design GmbH
Nikolaus Schulz
Wragekamp 10
D-22397 Hamburg
Germany

Tel.:  +49 40 88187-163
Fax:   +49 40 88187-150
Email: nikolaus.schulz@avionic-design.de

Avionic Design GmbH
Amtsgericht Hamburg HRB 82598
Geschäftsführung: Cornelis Broers
Ust.-Ident-Nr.: DE813378254
