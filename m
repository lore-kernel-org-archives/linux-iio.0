Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55411 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3FKT2y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 15:28:54 -0400
Message-ID: <51B77A73.1030008@kernel.org>
Date: Tue, 11 Jun 2013 20:28:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:dac: Add support for the AD7303
References: <1370969775-11180-1-git-send-email-lars@metafoo.de> <51B76987.4070200@kernel.org> <51B76C3A.2050804@metafoo.de>
In-Reply-To: <51B76C3A.2050804@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2013 07:28 PM, Lars-Peter Clausen wrote:
> On 06/11/2013 08:16 PM, Jonathan Cameron wrote:
>> On 06/11/2013 05:56 PM, Lars-Peter Clausen wrote:
>>> This patch adds support for the AD7303. The AD7303 is a simple 2 channel 8 bit
>>> DAC with an SPI interface.
>>>
>>
>> Do we need an explicit, 'Use the reference regulator' element in device tree
>> /platform data?  (I know this is done in existing drivers) Or would a simple
>> lack of having one specified be sufficient?
> 
> Yes, the problem is that if the regulator framework is disabled or
> CONFIG_REGULATOR_DUMMY is set regulator_get() returns a valid (dummy)
> regulator. So we can't distinguish between whether a regulator is present or
> not in that case. But we need to configure the device according to whether
> there is an external ref or not. Of course scale reporting won't work if the
> regulator framework is disabled, but at least the device works still fine
> otherwise.
> 
>>  Are there real cases where
>> a board is designed with one, but we want to not use it (other than bugs
>> of course ;)  Doesn't seem to be documented.
> 
> No, if you don't want to use it even though it is on the board just don't
> specify it. E.g. in the devicetree case we use the presence of the property
> whether to use the internal or external reference.
> 
Fair enough and thanks for clarifying this.
>>
>> Otherwise, whether you put a blank line before return statements is a bit
>> random in this driver.
>>
>> Rest is fine and I'm only bring the above up because its that sort of an evening ;)
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,


>>> ---
>>>  .../devicetree/bindings/iio/dac/ad7303.txt         |  23 ++
>>>  drivers/iio/dac/Kconfig                            |  10 +
>>>  drivers/iio/dac/Makefile                           |   1 +
>>>  drivers/iio/dac/ad7303.c                           | 315 +++++++++++++++++++++
>>>  include/linux/platform_data/ad7303.h               |  21 ++
>>>  5 files changed, 370 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad7303.txt
>>>  create mode 100644 drivers/iio/dac/ad7303.c
>>>  create mode 100644 include/linux/platform_data/ad7303.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
>>> new file mode 100644
>>> index 0000000..914610f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
>>> @@ -0,0 +1,23 @@
>>> +Analog Devices AD7303 DAC device driver
>>> +
>>> +Required properties:
>>> +	- compatible: Must be "adi,ad7303"
>>> +	- reg: SPI chip select number for the device
>>> +	- spi-max-frequency: Max SPI frequency to use (< 30000000)
>>> +	- Vdd-supply: Phandle to the Vdd power supply
>>> +
>>> +Optional properties:
>>> +	- REF-supply: Phandle to the external reference voltage supply. This should
>>> +	  only be set if there is an external reference voltage connected to the REF
>>> +	  pin. If the property is not set Vdd/2 is used as the reference voltage.
>>> +
>>> +Example:
>>> +
>>> +		ad7303@4 {
>>> +			compatible = "adi,ad7303";
>>> +			reg = <4>;
>>> +			spi-max-frequency = <10000000>;
>>> +			Vdd-supply = <&vdd_supply>;
>>> +			adi,use-external-reference;
>> above is a I think undocumented?
>>
>>> +			REF-supply = <&vref_supply>;
>>> +		};
>>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>>> index b61160b..c9c33ce 100644
>>> --- a/drivers/iio/dac/Kconfig
>>> +++ b/drivers/iio/dac/Kconfig
>>> @@ -130,6 +130,16 @@ config AD5686
>>>  	  To compile this driver as a module, choose M here: the
>>>  	  module will be called ad5686.
>>>  
>>> +config AD7303
>>> +	tristate "Analog Devices Analog Devices AD7303 DAC driver"
>>> +	depends on SPI
>>> +	help
>>> +	  Say yes here to build support for Analog Devices AD7303 Digital to Analog
>>> +	  Converters (DAC).
>>> +
>>> +	  To compile this driver as module choose M here: the module will be called
>>> +	  ad7303.
>>> +
>>>  config MAX517
>>>  	tristate "Maxim MAX517/518/519 DAC driver"
>>>  	depends on I2C
>>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>>> index 5b528eb..c8d7ab6 100644
>>> --- a/drivers/iio/dac/Makefile
>>> +++ b/drivers/iio/dac/Makefile
>>> @@ -14,5 +14,6 @@ obj-$(CONFIG_AD5755) += ad5755.o
>>>  obj-$(CONFIG_AD5764) += ad5764.o
>>>  obj-$(CONFIG_AD5791) += ad5791.o
>>>  obj-$(CONFIG_AD5686) += ad5686.o
>>> +obj-$(CONFIG_AD7303) += ad7303.o
>>>  obj-$(CONFIG_MAX517) += max517.o
>>>  obj-$(CONFIG_MCP4725) += mcp4725.o
>>> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
>>> new file mode 100644
>>> index 0000000..85aeef6
>>> --- /dev/null
>>> +++ b/drivers/iio/dac/ad7303.c
>>> @@ -0,0 +1,315 @@
>>> +/*
>>> + * AD7303 Digital to analog converters driver
>>> + *
>>> + * Copyright 2013 Analog Devices Inc.
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/module.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/sysfs.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/of.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +#include <linux/platform_data/ad7303.h>
>>> +
>>> +#define AD7303_CFG_EXTERNAL_VREF BIT(15)
>>> +#define AD7303_CFG_POWER_DOWN(ch) BIT(11 + (ch))
>>> +#define AD7303_CFG_ADDR_OFFSET	10
>>> +
>>> +#define AD7303_CMD_UPDATE_DAC	(0x3 << 8)
>>> +
>>> +/**
>>> + * struct ad7303_state - driver instance specific data
>>> + * @spi:		the device for this driver instance
>>> + * @config:		cached config register value
>>> + * @dac_cache:		current DAC raw value (chip does not support readback)
>>> + * @data:		spi transfer buffer
>>> + */
>>> +
>>> +struct ad7303_state {
>>> +	struct spi_device *spi;
>>> +	uint16_t config;
>>> +	uint8_t dac_cache[2];
>>> +
>>> +	struct regulator *vdd_reg;
>>> +	struct regulator *vref_reg;
>>> +
>>> +	/*
>>> +	 * DMA (thus cache coherency maintenance) requires the
>>> +	 * transfer buffers to live in their own cache lines.
>>> +	 */
>>> +	__be16 data ____cacheline_aligned;
>>> +};
>>> +
>>> +static int ad7303_write(struct ad7303_state *st, unsigned int chan,
>>> +	uint8_t val)
>>> +{
>>> +	st->data = cpu_to_be16(AD7303_CMD_UPDATE_DAC |
>>> +		(chan << AD7303_CFG_ADDR_OFFSET) |
>>> +		st->config | val);
>>> +
>>> +	return spi_write(st->spi, &st->data, sizeof(st->data));
>>> +}
>>> +
>>> +static ssize_t ad7303_read_dac_powerdown(struct iio_dev *indio_dev,
>>> +	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>>> +{
>>> +	struct ad7303_state *st = iio_priv(indio_dev);
>>> +
>>> +	return sprintf(buf, "%d\n", (bool)(st->config &
>>> +		AD7303_CFG_POWER_DOWN(chan->channel)));
>>> +}
>>> +
>>> +static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>>> +	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
>>> +	 size_t len)
>>> +{
>>> +	struct ad7303_state *st = iio_priv(indio_dev);
>>> +	bool pwr_down;
>>> +	int ret;
>>> +
>>> +	ret = strtobool(buf, &pwr_down);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +
>>> +	if (pwr_down)
>>> +		st->config |= AD7303_CFG_POWER_DOWN(chan->channel);
>>> +	else
>>> +		st->config &= ~AD7303_CFG_POWER_DOWN(chan->channel);
>>> +
>>> +	/* There is no noop cmd which allows us to only update the powerdown
>>> +	 * mode, so just write one of the DAC channels again */
>>> +	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
>>> +
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +	return ret ? ret : len;
>>> +}
>>> +
>>> +static int ad7303_get_vref(struct ad7303_state *st,
>>> +	struct iio_chan_spec const *chan)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (st->config & AD7303_CFG_EXTERNAL_VREF)
>>> +		return regulator_get_voltage(st->vref_reg);
>>> +
>>> +	ret = regulator_get_voltage(st->vdd_reg);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	return ret / 2;
>>> +}
>>> +
>>> +static int ad7303_read_raw(struct iio_dev *indio_dev,
>>> +	struct iio_chan_spec const *chan, int *val, int *val2, long info)
>>> +{
>>> +	struct ad7303_state *st = iio_priv(indio_dev);
>>> +	int vref_uv;
>>> +
>>> +	switch (info) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		*val = st->dac_cache[chan->channel];
>>> +		return IIO_VAL_INT;
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		vref_uv = ad7303_get_vref(st, chan);
>>> +		if (vref_uv < 0)
>>> +			return vref_uv;
>>> +
>>> +		*val = 2 * vref_uv / 1000;
>>> +		*val2 = chan->scan_type.realbits;
>>> +
>>> +		return IIO_VAL_FRACTIONAL_LOG2;
>>> +	default:
>>> +		break;
>>> +	}
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static int ad7303_write_raw(struct iio_dev *indio_dev,
>>> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
>>> +{
>>> +	struct ad7303_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>>> +			return -EINVAL;
>>> +
>>> +		mutex_lock(&indio_dev->mlock);
>>> +		ret = ad7303_write(st, chan->address, val);
>>> +		if (ret == 0)
>>> +			st->dac_cache[chan->channel] = val;
>>> +		mutex_unlock(&indio_dev->mlock);
>>> +		break;
>>> +	default:
>>> +		ret = -EINVAL;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct iio_info ad7303_info = {
>>> +	.read_raw = ad7303_read_raw,
>>> +	.write_raw = ad7303_write_raw,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static const struct iio_chan_spec_ext_info ad7303_ext_info[] = {
>>> +	{
>>> +		.name = "powerdown",
>>> +		.read = ad7303_read_dac_powerdown,
>>> +		.write = ad7303_write_dac_powerdown,
>>> +	},
>>> +	{ },
>>> +};
>>> +
>>> +#define AD7303_CHANNEL(chan) {					\
>>> +	.type = IIO_VOLTAGE,					\
>>> +	.indexed = 1,						\
>>> +	.output = 1,						\
>>> +	.channel = (chan),					\
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>>> +	.address = (chan),					\
>>> +	.scan_type = {						\
>>> +		.sign = 'u',					\
>>> +		.realbits = '8',				\
>>> +		.storagebits = '8',				\
>>> +		.shift = '0',					\
>>> +	},							\
>>> +	.ext_info = ad7303_ext_info,				\
>>> +}
>>> +
>>> +static const struct iio_chan_spec ad7303_channels[] = {
>>> +	AD7303_CHANNEL(0),
>>> +	AD7303_CHANNEL(1),
>>> +};
>>> +
>>> +static int ad7303_probe(struct spi_device *spi)
>>> +{
>>> +	const struct spi_device_id *id = spi_get_device_id(spi);
>>> +	struct iio_dev *indio_dev;
>>> +	struct ad7303_state *st;
>>> +	bool ext_ref;
>>> +	int ret;
>>> +
>>> +	indio_dev = iio_device_alloc(sizeof(*st));
>>> +	if (indio_dev == NULL)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +	spi_set_drvdata(spi, indio_dev);
>>> +
>>> +	st->spi = spi;
>>> +
>>> +	st->vdd_reg = regulator_get(&spi->dev, "Vdd");
>>> +	if (IS_ERR(st->vdd_reg)) {
>>> +		ret = PTR_ERR(st->vdd_reg);
>>> +		goto err_free;
>>> +	}
>>> +
>>> +	ret = regulator_enable(st->vdd_reg);
>>> +	if (ret)
>>> +		goto err_put_vdd_reg;
>>> +
>>> +	if (spi->dev.of_node) {
>>> +		ext_ref = of_property_read_bool(spi->dev.of_node,
>>> +				"REF-supply");
>>> +	} else {
>>> +		struct ad7303_platform_data *pdata = spi->dev.platform_data;
>>> +		if (pdata && pdata->use_external_ref)
>>> +			ext_ref = true;
>>> +		else
>>> +		    ext_ref = false;
>>> +	}
>>> +
>>> +	if (ext_ref) {
>>> +		st->vref_reg = regulator_get(&spi->dev, "REF");
>>> +		if (IS_ERR(st->vref_reg))
>>> +			goto err_disable_vdd_reg;
>>> +
>>> +		ret = regulator_enable(st->vref_reg);
>>> +		if (ret)
>>> +			goto err_put_vref_reg;
>>> +
>>> +		st->config |= AD7303_CFG_EXTERNAL_VREF;
>>> +	}
>>> +
>>> +	indio_dev->dev.parent = &spi->dev;
>>> +	indio_dev->name = id->name;
>>> +	indio_dev->info = &ad7303_info;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = ad7303_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(ad7303_channels);
>>> +
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret)
>>> +		goto err_disable_vref_reg;
>>> +
>>> +	return 0;
>>> +
>>> +err_disable_vref_reg:
>>> +	if (st->vref_reg)
>>> +		regulator_disable(st->vref_reg);
>>> +err_put_vref_reg:
>>> +	if (st->vref_reg)
>>> +		regulator_put(st->vref_reg);
>>> +err_disable_vdd_reg:
>>> +	regulator_disable(st->vdd_reg);
>>> +err_put_vdd_reg:
>>> +	regulator_put(st->vdd_reg);
>>> +err_free:
>>> +	iio_device_free(indio_dev);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int ad7303_remove(struct spi_device *spi)
>>> +{
>>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +	struct ad7303_state *st = iio_priv(indio_dev);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +
>>> +	if (st->vref_reg) {
>>> +		regulator_disable(st->vref_reg);
>>> +		regulator_put(st->vref_reg);
>>> +	}
>>> +	regulator_disable(st->vdd_reg);
>>> +	regulator_put(st->vdd_reg);
>>> +
>>> +	iio_device_free(indio_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct spi_device_id ad7303_spi_ids[] = {
>>> +	{ "ad7303", 0 },
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, ad7303_spi_ids);
>>> +
>>> +static struct spi_driver ad7303_driver = {
>>> +	.driver = {
>>> +		.name = "ad7303",
>>> +		.owner = THIS_MODULE,
>>> +	},
>>> +	.probe = ad7303_probe,
>>> +	.remove = ad7303_remove,
>>> +	.id_table = ad7303_spi_ids,
>>> +};
>>> +module_spi_driver(ad7303_driver);
>>> +
>>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>>> +MODULE_DESCRIPTION("Analog Devices AD7303 DAC driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/include/linux/platform_data/ad7303.h b/include/linux/platform_data/ad7303.h
>>> new file mode 100644
>>> index 0000000..de6a7a6
>>> --- /dev/null
>>> +++ b/include/linux/platform_data/ad7303.h
>>> @@ -0,0 +1,21 @@
>>> +/*
>>> + * Analog Devices AD7303 DAC driver
>>> + *
>>> + * Copyright 2013 Analog Devices Inc.
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#ifndef __IIO_ADC_AD7303_H__
>>> +#define __IIO_ADC_AD7303_H__
>>> +
>>> +/**
>>> + * struct ad7303_platform_data - AD7303 platform data
>>> + * @use_external_ref: If set to true use an external voltage reference connected
>>> + * to the REF pin, otherwise use the internal reference derived from Vdd.
>>> + */
>>> +struct ad7303_platform_data {
>>> +	bool use_external_ref;
>>> +};
>>> +
>>> +#endif
>>>
> 
