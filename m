Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:60230 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbdCYQNl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Mar 2017 12:13:41 -0400
Date: Sat, 25 Mar 2017 17:13:38 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>
cc: geert@linux-m68k.org, wsa+renesas@sang-engineering.com,
        lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: Add Maxim max9611 ADC driver
In-Reply-To: <a911f5d1-e019-772f-0889-849cf42e6827@kernel.org>
Message-ID: <alpine.DEB.2.20.1703251706420.25208@vps.pmeerw.net>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org> <1490369323-13866-4-git-send-email-jacopo+renesas@jmondi.org> <a911f5d1-e019-772f-0889-849cf42e6827@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Sat, 25 Mar 2017, Jonathan Cameron wrote:

some more comments

> On 24/03/17 15:28, Jacopo Mondi wrote:
> > Add iio driver for Maxim max9611 and max9612 current-sense amplifiers
> > with 12-bits ADC interface.
> > 
> > Datasheet publicly available at:
> > https://datasheets.maximintegrated.com/en/ds/MAX9611-MAX9612.pdf
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> A few more little things inline.  Coming together nicely.
> 
> The channel set here is just odd enough that it might aid review to have
> a quick listing of the resulting sysfs entries. One or two authors do
> this an it is always useful for a quick sanity check.
> 
> Perhaps even a set of typical values.  Put this below the --- as we don't
> need it in the git history, only to assist lazy reviewers like me ;)
> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/adc/Kconfig   |  10 +
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/max9611.c | 590 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 601 insertions(+)
> >  create mode 100644 drivers/iio/adc/max9611.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index dedae7a..82f2e7b8 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -354,6 +354,16 @@ config MAX1363
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called max1363.
> >  
> > +config	MAX9611
> > +	tristate "Maxim max9611/max9612 ADC driver"
> > +	depends on I2C
> > +	help
> > +	  Say yes here to build support for Maxim max9611/max9612 current sense
> > +	  amplifier with 12-bits ADC interface.
> > +
> > +	  To compile this driver as a module, choose M here: the module will be
> > +	  called max9611.
> > +
> >  config MCP320X
> >  	tristate "Microchip Technology MCP3x01/02/04/08"
> >  	depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index d001262..149f979 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_LTC2485) += ltc2485.o
> >  obj-$(CONFIG_MAX1027) += max1027.o
> >  obj-$(CONFIG_MAX11100) += max11100.o
> >  obj-$(CONFIG_MAX1363) += max1363.o
> > +obj-$(CONFIG_MAX9611) += max9611.o
> >  obj-$(CONFIG_MCP320X) += mcp320x.o
> >  obj-$(CONFIG_MCP3422) += mcp3422.o
> >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > new file mode 100644
> > index 0000000..61566ec
> > --- /dev/null
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -0,0 +1,590 @@
> > +/*
> > + * iio/adc/max9611.c
> > + *
> > + * Maxim max9611/max9612 high side current sense amplifier with
> > + * 12-bit ADC interface.
> > + *
> > + * Copyright (C) 2017 Jacopo Mondi
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +/*
> > + * This driver supports input common-mode voltage, current-sense
> > + * amplifier with programmable gains and die temperature reading from
> > + * Maxim max9611/max9612.
> > + *
> > + * Op-amp, analog comparator, and watchdog functionalities are not
> > + * supported by this driver.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/module.h>
> > +
> > +#define DRIVER_NAME "max9611"
> > +
> > +/* max9611 register addresses */
> > +#define MAX9611_REG_CSA_DATA		0x00
> > +#define MAX9611_REG_RS_DATA		0x02
> > +#define MAX9611_REG_TEMP_DATA		0x08
> > +#define MAX9611_REG_CTRL1		0x0a
> > +#define MAX9611_REG_CTRL2		0x0b
> > +
> > +/* max9611 REG1 mux configuration options */
> > +#define MAX9611_MUX_MASK		0x07

could use GENMASK()

> > +#define MAX9611_MUX_SENSE_1x		0x00
> > +#define MAX9611_MUX_SENSE_4x		0x01
> > +#define MAX9611_MUX_SENSE_8x		0x02
> > +#define MAX9611_INPUT_VOLT		0x03
> > +#define MAX9611_MUX_TEMP		0x06

maybe avoid mixed-case #defines

> > +/* max9611 voltage (both csa and input) helper macros */
> > +#define MAX9611_VOLTAGE_SHIFT		0x04
> > +#define MAX9611_VOLTAGE_RAW(_r)		((_r) >> MAX9611_VOLTAGE_SHIFT)
> > +
> > +/*
> > + * max9611 current sense amplifier voltage output:
> > + * LSB and offset values depends on selected gain (1x, 4x, 8x)
> > + *
> > + * GAIN		LSB (nV)	OFFSET (LSB steps)
> > + * 1x		107500		1
> > + * 4x		26880		1
> > + * 8x		13440		3
> > + *
> > + * The complete formula to calculate current sense voltage is:
> > + *     (((adc_read >> 4) - offset) / ((1 / LSB) * 10^-3)
> > + */
> > +#define CSA_VOLT_1x_LSB_nV		107500
> > +#define CSA_VOLT_4x_LSB_nV		26880
> > +#define CSA_VOLT_8x_LSB_nV		13440
> > +
> > +#define CSA_VOLT_1x_OFFS_RAW		1
> > +#define CSA_VOLT_4x_OFFS_RAW		1
> > +#define CSA_VOLT_8x_OFFS_RAW		3
> > +
> > +/*
> > + * max9611 common input mode (CIM): LSB is 14mV, with 14mV offset at 25 C
> > + *
> > + * The complete formula to calculate input common voltage is:
> > + *     (((adc_read >> 4) * 1000) - offset) / (1 / 14 * 1000)
> > + */
> > +#define CIM_VOLTAGE_LSB_mV		14
> > +#define CIM_VOLTAGE_OFFSET_RAW		1
> > +
> > +/*
> > + * max9611 temperature reading: LSB is 0.48 degrees Celsius
> > + *
> > + * The complete formula to calculate temperature is:
> > + *     ((adc_read >> 7) * 1000) / (1 / 0.48 * 1000)
> > + */
> I'd prefer these defines to be prefixed with MAX9611_
> Easiest to just do the lot.  Some of these are 'standard' enough
> the might well clash with something that turns up in an included header
> at somepoint in the future.
> 
> > +#define TEMP_SHIFT			0x07
> > +#define TEMP_MAX_RAW_POS		0x7f80
> > +#define TEMP_MAX_RAW_NEG		0xff80
> > +#define TEMP_MIN_RAW_NEG		0xd980
> > +#define TEMP_MASK			((1 << TEMP_SHIFT) - 1)

could use GENMASK()

> > +#define TEMP_RAW(_r)			((_r) >> TEMP_SHIFT)
> > +#define TEMP_LSB_mC			480
> > +#define TEMP_SCALE_NUM			1000
> > +#define TEMP_SCALE_DIV			2083
> > +
> > +struct max9611_dev {
> > +	struct device *dev;
> > +	struct i2c_client *i2c_client;
> > +	struct mutex lock;
> > +	unsigned int shunt_resistor_uohm;
> > +};
> > +
> > +enum max9611_conf_ids {
> > +	CONF_SENSE_1x,
> > +	CONF_SENSE_4x,
> > +	CONF_SENSE_8x,
> > +	CONF_IN_VOLT,
> > +	CONF_TEMP,
> > +};
> > +
> > +/**
> > + * max9611_mux_conf - associate ADC mux configuration with register address
> > + *		       where data shall be read from
> > + */
> > +static unsigned int max9611_mux_conf[][2] = {

const

> > +	/* CONF_SENSE_1x */
> > +	{ MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> > +	/* CONF_SENSE_4x */
> > +	{ MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> > +	/* CONF_SENSE_8x */
> > +	{ MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> > +	/* CONF_IN_VOLT */
> > +	{ MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > +	/* CONF_TEMP */
> > +	{ MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> > +};
> > +
> > +enum max9611_csa_gain {
> > +	CSA_GAIN_1x,
> > +	CSA_GAIN_4x,
> > +	CSA_GAIN_8x,
> > +};
> > +
> > +enum max9611_csa_gain_params {
> > +	CSA_GAIN_LSB_nV,
> > +	CSA_GAIN_OFFS_RAW,
> > +};
> > +
> > +/**
> > + * max9611_csa_gain_conf - associate gain multiplier with LSB and
> > + *			    offset values.
> > + *
> > + * Group together parameters associated with configurable gain
> > + * on current sense amplifier path to ADC interface.
> > + * Current sense read routine adjusts gain until it gets a meaningful
> > + * value; use this structure to retrieve the correct LSB and offset values.
> > + */
> > +static unsigned int max9611_gain_conf[][2] = {

const

> > +	{ /* [0] CSA_GAIN_1x */
> > +		CSA_VOLT_1x_LSB_nV,
> > +		CSA_VOLT_1x_OFFS_RAW,
> > +	},
> > +	{ /* [1] CSA_GAIN_4x */
> > +		CSA_VOLT_4x_LSB_nV,
> > +		CSA_VOLT_4x_OFFS_RAW,
> > +	},
> > +	{ /* [2] CSA_GAIN_8x */
> > +		CSA_VOLT_8x_LSB_nV,
> > +		CSA_VOLT_8x_OFFS_RAW,
> > +	},
> > +};
> > +
> > +enum max9611_chan_addrs {
> > +	MAX9611_CHAN_VOLTAGE_INPUT,
> > +	MAX9611_CHAN_VOLTAGE_SENSE,
> > +	MAX9611_CHAN_TEMPERATURE,
> > +	MAX9611_CHAN_CURRENT_LOAD,
> > +	MAX9611_CHAN_POWER_LOAD,
> > +};
> > +
> > +static struct iio_chan_spec max9611_channels[] = {

const

> > +	{
> > +	  .type			= IIO_TEMP,
> > +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> > +				  BIT(IIO_CHAN_INFO_SCALE),
> > +	  .address		= MAX9611_CHAN_TEMPERATURE,
> > +	},
> > +	{
> > +	  .type			= IIO_VOLTAGE,
> > +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW)   |
> > +				  BIT(IIO_CHAN_INFO_SCALE) |
> > +				  BIT(IIO_CHAN_INFO_OFFSET),
> > +	  .address		= MAX9611_CHAN_VOLTAGE_INPUT,
> > +	  .indexed		= 1,
> > +	  .channel		= 1,

why is this indexed?
should be the only raw voltage channel


> > +	},
> > +	{
> > +	  .type			= IIO_VOLTAGE,
> > +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_PROCESSED),
> > +	  .address		= MAX9611_CHAN_VOLTAGE_SENSE,
> > +	  .indexed		= 1,
> > +	  .channel		= 0,
> Unusual to have the channels in here other than in channel order...

why is this indexed?
should be the only processed voltage channel


> > +	},
> > +	{
> > +	  .type			= IIO_CURRENT,
> > +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_PROCESSED),
> > +	  .address		= MAX9611_CHAN_CURRENT_LOAD,
> > +	},
> > +	{
> > +	  .type			= IIO_POWER,
> > +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_PROCESSED),
> > +	  .address		= MAX9611_CHAN_POWER_LOAD
> > +	},
> > +};
> > +
> > +/**
> > + * max9611_read_single() - read a single vale from ADC interface
> value
> > + *
> > + * Data registers are 16 bit long, spread between two 8 bit registers
> > + * with consecutive addresses.
> > + * Configure ADC mux first, then read register at address "reg_addr".
> > + * The smbus_read_word routine asks for 16 bits and the ADC is kind enough
> > + * to return values from "reg_addr" and "reg_addr + 1" consecutively.

maybe worth noting that data is MSB first or big-endian

> > + *
> > + * @max9611: max9611 device
> > + * @selector: index for mux and register configuration
> > + * @raw_val: the value returned from ADC
> > + */
> > +static int max9611_read_single(struct max9611_dev *max9611,
> > +			       enum max9611_conf_ids selector,
> > +			       u16 *raw_val)
> > +{
> > +	int ret;
> > +
> > +	u8 mux_conf = max9611_mux_conf[selector][0] & MAX9611_MUX_MASK;
> > +	u8 reg_addr = max9611_mux_conf[selector][1];
> > +
> > +	ret = i2c_smbus_write_byte_data(max9611->i2c_client,
> > +					MAX9611_REG_CTRL1, mux_conf);
> > +	if (ret) {
> > +		dev_err(max9611->dev, "i2c write byte failed: 0x%2x - 0x%2x\n",
> > +			MAX9611_REG_CTRL1, mux_conf);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * need a delay here to make register configuration
> > +	 * stabilize. 1 msec at least, from empirical testing.
> > +	 */
> > +	usleep_range(1000, 2000);
> > +
> > +	ret = i2c_smbus_read_word_swapped(max9611->i2c_client, reg_addr);
> > +	if (ret < 0) {
> > +		dev_err(max9611->dev, "i2c read word from 0x%2x failed\n",
> > +			reg_addr);
> > +		return ret;
> > +	}
> > +	*raw_val = ret;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * max9611_read_csa_voltage() - read current sense amplifier output voltage
> > + *
> > + * Current sense amplifier output voltage is read through a configurable
> > + * 1x, 4x or 8x gain.
> > + * Start with plain 1x gain, and adjust gain control properly until a
> > + * meaningful value is read from ADC output.
> > + *
> > + * @max9611: max9611 device
> > + * @adc_raw: raw value read from ADC output
> > + * @csa_gain: gain configuration option selector
> > + */
> > +static int max9611_read_csa_voltage(struct max9611_dev *max9611,
> > +				    u16 *adc_raw,
> > +				    enum max9611_csa_gain *csa_gain)
> > +{
> > +	enum max9611_conf_ids gain_selectors[] = {
> > +		CONF_SENSE_1x,
> > +		CONF_SENSE_4x,
> > +		CONF_SENSE_8x
> > +	};
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(gain_selectors); ++i) {
> > +		ret = max9611_read_single(max9611, gain_selectors[i], adc_raw);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (*adc_raw > 0) {
> > +			*csa_gain = gain_selectors[i];
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -EIO;
> > +}
> > +
> > +static int max9611_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct max9611_dev *dev = iio_priv(indio_dev);
> > +	enum max9611_csa_gain gain_selector;
> > +	unsigned int *csa_gain;
> > +	u16 adc_data;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&dev->lock);
> > +
> > +		switch (chan->address) {
> > +		case MAX9611_CHAN_TEMPERATURE:
> > +			ret = max9611_read_single(dev, CONF_TEMP,
> > +						  &adc_data);
> > +			if (ret)
> I'm not personally keen on jumping out of deep indentations like this
> just save on repeating one line.  I'd pull the unlock back here and return
> directly as I feel it'll improve readability.
> Actually come to think of it, why does the lock need to be held for
> the next line anyway?  adc_data is on the stack so doesn't matter if we
> have concurrent readers, once the i2c transaction is finished.
> Just unlock before checking ret.
> > +				goto unlock_fail;
> > +
> > +			*val = TEMP_RAW(adc_data);
> > +
> > +			mutex_unlock(&dev->lock);
> > +			return IIO_VAL_INT;
> > +
> > +		case MAX9611_CHAN_VOLTAGE_INPUT:
> > +			ret = max9611_read_single(dev, CONF_IN_VOLT,
> > +						  &adc_data);
> > +			if (ret)
> > +				goto unlock_fail;
> > +
> > +			*val = MAX9611_VOLTAGE_RAW(adc_data);
> > +
> > +			mutex_unlock(&dev->lock);
> > +			return IIO_VAL_INT;
> > +		}
> > +

this falls through, no break?

I'd move
                mutex_unlock(&dev->lock);
                return IIO_VAL_INT;
here


> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (chan->address) {

rather pointless for only one case?


> > +		case MAX9611_CHAN_VOLTAGE_INPUT:
> > +			*val = CIM_VOLTAGE_OFFSET_RAW;
> > +
> > +			return IIO_VAL_INT;
> > +		}
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->address) {
> > +		case MAX9611_CHAN_TEMPERATURE:
> > +			*val = TEMP_SCALE_NUM;
> > +			*val2 = TEMP_SCALE_DIV;
> > +
> > +			return IIO_VAL_FRACTIONAL;
> > +
> > +		case MAX9611_CHAN_VOLTAGE_INPUT:
> > +			*val = CIM_VOLTAGE_LSB_mV;
> > +			return IIO_VAL_INT;

default: return -EINVAL;

> > +		}

break; or something

> > +
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		mutex_lock(&dev->lock);
> > +
> > +		switch (chan->address) {
> > +		case MAX9611_CHAN_VOLTAGE_SENSE:
> > +			/*
> > +			 * processed (mV): (raw - offset) * LSB (nV) / 10^6
> > +			 *
> > +			 * Even if max9611 can output raw csa voltage readings,
> > +			 * use a produced value as scale depends on gain.
> > +			 */
> > +			ret = max9611_read_csa_voltage(dev, &adc_data,
> > +						       &gain_selector);
> > +			if (ret)
> > +				goto unlock_fail;
> > +
> > +			csa_gain = max9611_gain_conf[gain_selector];
> > +
> > +			adc_data -= csa_gain[CSA_GAIN_OFFS_RAW];
> > +			*val = MAX9611_VOLTAGE_RAW(adc_data) *
> > +			       csa_gain[CSA_GAIN_LSB_nV];
> > +			*val2 = 1000000;
> > +
> > +			mutex_unlock(&dev->lock);
> > +			return IIO_VAL_FRACTIONAL;
> > +
> > +		case MAX9611_CHAN_CURRENT_LOAD:
> > +			/* processed (mA): Vcsa (nV) / Rshunt (uOhm)  */
> > +			ret = max9611_read_csa_voltage(dev, &adc_data,
> > +						       &gain_selector);
> > +			if (ret)
> > +				goto unlock_fail;
> > +
> > +			csa_gain = max9611_gain_conf[gain_selector];
> > +
> > +			adc_data -= csa_gain[CSA_GAIN_OFFS_RAW];
> > +			*val = MAX9611_VOLTAGE_RAW(adc_data) *
> > +			       csa_gain[CSA_GAIN_LSB_nV];
> > +			*val2 = dev->shunt_resistor_uohm;
> > +
> > +			mutex_unlock(&dev->lock);
> > +			return IIO_VAL_FRACTIONAL;
> > +
> > +		case MAX9611_CHAN_POWER_LOAD:
> > +			/*
> > +			 * processed (mW): Vin (mV) * Vcsa (uV) /
> > +			 *		   Rshunt (uOhm)
> > +			 */
> > +			ret = max9611_read_single(dev, CONF_IN_VOLT,
> > +						  &adc_data);
> > +			if (ret)
> > +				goto unlock_fail;
> > +
> > +			adc_data -= CIM_VOLTAGE_OFFSET_RAW;
> > +			*val = MAX9611_VOLTAGE_RAW(adc_data) *
> > +			       CIM_VOLTAGE_LSB_mV;
> > +
> > +			ret = max9611_read_csa_voltage(dev, &adc_data,
> > +						       &gain_selector);
> > +			if (ret)
> > +				goto unlock_fail;
> > +
> > +			csa_gain = max9611_gain_conf[gain_selector];
> > +
> > +			/* divide by 10^3 here to avoid 32bit overflow */
> > +			adc_data -= csa_gain[CSA_GAIN_OFFS_RAW];
> > +			*val *= MAX9611_VOLTAGE_RAW(adc_data) *
> > +				csa_gain[CSA_GAIN_LSB_nV] / 1000;
> > +			*val2 = dev->shunt_resistor_uohm;
> > +
> > +			mutex_unlock(&dev->lock);
> > +			return IIO_VAL_FRACTIONAL;
> > +		}
> > +	}
> > +
> > +	ret = -EINVAL;
> > +
> > +unlock_fail:
> > +	mutex_unlock(&dev->lock);
> > +	return ret;
> > +
> > +}
> > +
> > +static ssize_t max9611_shunt_resistor_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct max9611_dev *max9611 = iio_priv(dev_to_iio_dev(dev));
> > +
> > +	return sprintf(buf, "%d\n", max9611->shunt_resistor_uohm);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(in_shunt_resistor_power, 0444,
> > +		       max9611_shunt_resistor_show, NULL, 0);
> > +static IIO_DEVICE_ATTR(in_shunt_resistor_current, 0444,
> > +		       max9611_shunt_resistor_show, NULL, 0);
> > +
> > +static struct attribute *max9611_attributes[] = {
> > +	&iio_dev_attr_in_shunt_resistor_power.dev_attr.attr,
> > +	&iio_dev_attr_in_shunt_resistor_current.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group max9611_attribute_group = {
> > +	.attrs = max9611_attributes,
> > +};
> > +
> > +static const struct iio_info indio_info = {
> > +	.driver_module	= THIS_MODULE,
> > +	.read_raw	= max9611_read_raw,
> > +	.attrs		= &max9611_attribute_group,
> > +};
> > +
> > +static int max9611_init(struct max9611_dev *max9611)
> > +{
> > +	struct i2c_client *client = max9611->i2c_client;
> > +	u16 regval;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_WRITE_BYTE	|
> > +				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> > +		dev_err(max9611->dev,
> > +			"No smbus support in I2c adapter: aborting probe.\n");
> This isn't necessarily an accurate message.  I2c adapter might support
> smbus_read_byte only rather than word reads for example.
> 
> Maybe make it more explict as to what we need?
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Configure MUX to read temperature */
> > +	ret = i2c_smbus_write_byte_data(max9611->i2c_client,
> > +					MAX9611_REG_CTRL1, MAX9611_MUX_TEMP);
> > +	if (ret) {
> > +		dev_err(max9611->dev, "i2c write byte failed: 0x%2x - 0x%2x\n",
> > +			MAX9611_REG_CTRL1, MAX9611_MUX_TEMP);
> > +		return ret;
> > +	}
> > +	ret = i2c_smbus_write_byte_data(max9611->i2c_client,
> > +					MAX9611_REG_CTRL2, 0);
> > +	if (ret) {
> > +		dev_err(max9611->dev, "i2c write byte failed: 0x%2x - 0x%2x\n",
> > +			MAX9611_REG_CTRL2, 0);
> > +		return ret;
> > +	}
> > +	usleep_range(1000, 2000);
> > +
> > +	/* Make sure die temperature is in range to test communications. */
> > +	ret = i2c_smbus_read_word_swapped(max9611->i2c_client,
> > +					  MAX9611_REG_TEMP_DATA);
> > +	if (ret < 0) {
> > +		dev_err(max9611->dev, "i2c read word from 0x%2x failed\n",
> > +			MAX9611_REG_TEMP_DATA);
> > +		return ret;
> > +	}
> > +	regval = ret & ~TEMP_MASK;
> > +
> > +	if ((regval > TEMP_MAX_RAW_POS &&
> > +	     regval < TEMP_MIN_RAW_NEG) ||
> > +	     regval > TEMP_MAX_RAW_NEG) {
> > +		dev_err(max9611->dev,
> > +			"Invalid value received from ADC 0x%4x: aborting\n",
> > +			regval);
> > +		return -EIO;
> > +	}
> > +
> > +	/* Mux shall be zeroed back before applying other configurations */
> > +	ret = i2c_smbus_write_byte_data(max9611->i2c_client,
> > +					MAX9611_REG_CTRL1, 0);
> > +	if (ret) {
> > +		dev_err(max9611->dev, "i2c write byte failed: 0x%2x - 0x%2x\n",
> > +			MAX9611_REG_CTRL1, 0);
> > +		return ret;
> > +	}
> > +	usleep_range(1000, 2000);
> > +
> > +	return 0;
> > +}
> > +
> > +static int max9611_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	const char * const shunt_res_prop = "shunt-resistor-uohm";
> > +	struct device_node *of_node = client->dev.of_node;
> > +	struct max9611_dev *max9611;
> > +	struct iio_dev *indio_dev;
> > +	unsigned int of_shunt;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
> > +	if (IS_ERR(indio_dev))
> > +		return PTR_ERR(indio_dev);
> > +
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	max9611			= iio_priv(indio_dev);
> > +	max9611->dev		= &client->dev;
> > +	max9611->i2c_client	= client;
> > +	mutex_init(&max9611->lock);
> > +
> > +	ret = of_property_read_u32(of_node, shunt_res_prop, &of_shunt);
> > +	if (ret) {
> > +		dev_err(&client->dev,
> > +			"Missing %s property for %s node\n",
> > +			shunt_res_prop, of_node->full_name);
> > +		return ret;
> > +	}
> > +	max9611->shunt_resistor_uohm = of_shunt;
> > +
> > +	ret = max9611_init(max9611);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->dev.parent	= &client->dev;
> > +	indio_dev->dev.of_node	= client->dev.of_node;
> > +	indio_dev->name		= client->dev.of_node->name;
> What's this going to give for the name?  Name in IIO is supposed to
> be an indication of the part rather than anything more explicit.
> That's not easily obtained from device tree directly...
> 
> > +	indio_dev->modes	= INDIO_DIRECT_MODE;
> > +	indio_dev->info		= &indio_info;
> > +	indio_dev->channels	= max9611_channels;
> > +	indio_dev->num_channels	= ARRAY_SIZE(max9611_channels);
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id max9611_of_table[] = {
> > +	{.compatible = "maxim,max9611"},
> > +	{.compatible = "maxim,max9612"},
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, max9611_of_table);
> > +
> > +static struct i2c_driver max9611_driver = {
> > +	.driver = {
> > +		   .name = DRIVER_NAME,
> > +		   .owner = THIS_MODULE,
> > +		   .of_match_table = max9611_of_table,
> > +	},
> > +	.probe = max9611_probe,
> > +};
> > +module_i2c_driver(max9611_driver);
> > +
> > +MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
> > +MODULE_DESCRIPTION("Maxim max9611/12 current sense amplifier with 12bit ADC");
> > +MODULE_LICENSE("GPL v2");
> > 
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
