Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43044 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942079AbdAHJsu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:50 -0500
Subject: Re: [PATCH 1/1] iio: adc: tlc4541: add support for TI tlc4541 adc
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Phil Reid <preid@electromag.com.au>
References: <1483606546-13629-1-git-send-email-preid@electromag.com.au>
 <alpine.DEB.2.02.1701051004320.16779@pmeerw.net>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f5ca63e8-eba3-9946-a088-004261284709@kernel.org>
Date: Sat, 7 Jan 2017 22:27:27 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1701051004320.16779@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/17 09:21, Peter Meerwald-Stadler wrote:
> 
>> This adds TI's tlc4541 16-bit ADC driver. Which is a single channel
>> ADC. Supports raw and trigger buffer access.
> 
> comments below
>  
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>  .../devicetree/bindings/iio/adc/ti-tlc4541.txt     |  16 ++
>>  drivers/iio/adc/Kconfig                            |  11 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/ti-tlc4541.c                       | 266 +++++++++++++++++++++
>>  4 files changed, 294 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>>  create mode 100644 drivers/iio/adc/ti-tlc4541.c
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>> new file mode 100644
>> index 0000000..67caccd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>> @@ -0,0 +1,16 @@
>> +* Texas Instruments' TLC4541
>> +
>> +Required properties:
>> + - compatible: Should be one of
>> +	* "ti,tlc4541"
>> + - reg: spi chip select number for the device
> 
> SPI
> 
>> + - vref-supply: The regulator supply for ADC reference voltage
>> + - spi-max-frequency: Max SPI frequency to use (<= 200000)
>> +
>> +Example:
>> +adc@0 {
>> +	compatible = "ti,adc0832";
>> +	reg = <0>;
>> +	vref-supply = <&vdd_supply>;
>> +	spi-max-frequency = <200000>;
>> +};
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 99c0514..4dda3f0 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -525,6 +525,17 @@ config TI_AM335X_ADC
>>  	  To compile this driver as a module, choose M here: the module will be
>>  	  called ti_am335x_adc.
>>  
>> +config TI_TLC4541
>> +	tristate "Texas Instruments TLC4541 ADC driver"
>> +	depends on SPI
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  Say yes here to build support for Texas Instruments TLC4541 ADC chip.
>> +
>> +	  This driver can also be built as a module. If so, the module will be
>> +	  called ti-tlc4541.
>> +
>>  config TWL4030_MADC
>>  	tristate "TWL4030 MADC (Monitoring A/D Converter)"
>>  	depends on TWL4030_CORE
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 7a40c04..9bf2377 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -49,6 +49,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>> +obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>>  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>>  obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>> diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
>> new file mode 100644
>> index 0000000..a767707
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-tlc4541.c
>> @@ -0,0 +1,266 @@
>> +/*
>> + * TI tlc4541 ADC Driver
>> + *
>> + * Copyright (C) 2017 Phil Reid
>> + *
>> + * Datasheets can be found here:
>> + * http://www.ti.com/lit/gpn/tlc4541
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * The tlc4541 requires 24 clock cycles to start a transfer.
>> + * Conversion then takes 2.94us to complete before data is ready
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/sysfs.h>
>> +
>> +struct tlc4541_state {
>> +	struct spi_device               *spi;
>> +	struct regulator                *reg;
>> +	struct spi_transfer             scan_single_xfer[3];
>> +	struct spi_message              scan_single_msg;
>> +
>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +	__be16                          rx_buf[2] ____cacheline_aligned;
>> +};
>> +
>> +struct tlc4541_chip_info {
>> +	const struct iio_chan_spec *channels;
>> +	unsigned int num_channels;
>> +};
>> +
>> +enum tlc4541_id {
>> +	TLC4541,
>> +};
>> +
>> +#define TLC4541_V_CHAN(index, bits) {                                 \
>> +		.type = IIO_VOLTAGE,                                  \
>> +		.indexed = 1,                                         \
> 
> no need if there is just one channel
> 
>> +		.channel = index,                                     \
>> +		.info_mask_separate       = BIT(IIO_CHAN_INFO_RAW),   \
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>> +		.address = index,                                     \
> 
> .address not needed
> 
>> +		.scan_index = index,                                  \
>> +		.scan_type = {                                        \
>> +			.sign = 'u',                                  \
>> +			.realbits = (bits),                           \
>> +			.storagebits = 16,                            \
>> +			.endianness = IIO_BE,                         \
>> +		},                                                    \
>> +	}
>> +
>> +#define DECLARE_TLC4541_CHANNELS(name, bits) \
> 
> this flexibility is only needed when further chips are added; maybe start 
> simple and only implement what is needed at first
The only exception to keeping it simple as Peter has suggested would
be if this was just the first of a series of patches and later ones would
add the support for other devices.  If this is the case, please mention it
in the patch description.

If the other device support doesn't show up reasonably soon after the initial
driver, chances are someone will 'simplify' the code by removing this stuff.

Jonathan
> 
>> +const struct iio_chan_spec name ## _channels[] = { \
>> +	TLC4541_V_CHAN(0, bits), \
>> +	IIO_CHAN_SOFT_TIMESTAMP(1), \
>> +}
>> +
>> +static DECLARE_TLC4541_CHANNELS(tlc4541, 16);
>> +
>> +static const struct tlc4541_chip_info tlc4541_chip_info[] = {
>> +	[TLC4541] = {
>> +		.channels = tlc4541_channels,
>> +		.num_channels = ARRAY_SIZE(tlc4541_channels),
>> +	},
>> +};
>> +
>> +static irqreturn_t tlc4541_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct tlc4541_state *st = iio_priv(indio_dev);
>> +	u16 buf[8]; /* 2 bytes data + 6 bytes padding + 8 bytes timestamp */
>> +	int ret;
>> +
>> +	ret = spi_sync(st->spi, &st->scan_single_msg);
>> +	if (ret < 0)
>> +		goto done;
>> +
>> +	buf[0] = be16_to_cpu(st->rx_buf[0]);
> 
> endianness is set to IIO_BE in scan_type, so this conversion is not needed 
> and maybe also buf and the copy can be avoided if rx_buf is large enough
> 
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>> +					   iio_get_time_ns(indio_dev));
>> +
>> +done:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int tlc4541_get_range(struct tlc4541_state *st)
>> +{
>> +	int vref;
>> +
>> +	vref = regulator_get_voltage(st->reg);
>> +	if (vref < 0)
>> +		return vref;
>> +
>> +	vref /= 1000;
>> +
>> +	return vref;
>> +}
>> +
>> +static int tlc4541_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val,
>> +			    int *val2,
>> +			    long m)
>> +{
>> +	int ret = 0;
>> +	struct tlc4541_state *st = iio_priv(indio_dev);
>> +
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = iio_device_claim_direct_mode(indio_dev);
>> +		if (ret)
>> +			return ret;
>> +		ret = spi_sync(st->spi, &st->scan_single_msg);
>> +		iio_device_release_direct_mode(indio_dev);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = be16_to_cpu(st->rx_buf[0]);
> 
> on page 12 of the datasheet, the conversion results is in two registers? 
> and rx_buf has two elements?
> 
> haven't investigated in detail -- maybe a comment would be good to detail 
> operation?
> 
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		ret = tlc4541_get_range(st);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = ret;
>> +		*val2 = chan->scan_type.realbits;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info tlc4541_info = {
>> +	.read_raw = &tlc4541_read_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static int tlc4541_probe(struct spi_device *spi)
>> +{
>> +	struct tlc4541_state *st;
>> +	struct iio_dev *indio_dev;
>> +	const struct tlc4541_chip_info *info;
>> +	int ret;
>> +	int8_t device_init = 0;
>> +
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (indio_dev == NULL)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	spi_set_drvdata(spi, indio_dev);
>> +
>> +	st->spi = spi;
>> +
>> +	info = &tlc4541_chip_info[spi_get_device_id(spi)->driver_data];
>> +
>> +	indio_dev->name = spi_get_device_id(spi)->name;
>> +	indio_dev->dev.parent = &spi->dev;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = info->channels;
>> +	indio_dev->num_channels = info->num_channels;
>> +	indio_dev->info = &tlc4541_info;
>> +
>> +	/* perform reset */
>> +	spi_write(spi, &device_init, 1);
>> +
>> +	/* Setup default message */
>> +	st->scan_single_xfer[0].rx_buf = &st->rx_buf[0];
>> +	st->scan_single_xfer[0].len = 3;
>> +	st->scan_single_xfer[1].delay_usecs = 3;
>> +	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
>> +	st->scan_single_xfer[2].len = 2;
>> +
>> +	spi_message_init(&st->scan_single_msg);
>> +	spi_message_add_tail(&st->scan_single_xfer[0], &st->scan_single_msg);
>> +	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
>> +	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
>> +
>> +	st->reg = devm_regulator_get(&spi->dev, "vref");
>> +	if (IS_ERR(st->reg))
>> +		return PTR_ERR(st->reg);
>> +
>> +	ret = regulator_enable(st->reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +			&tlc4541_trigger_handler, NULL);
>> +	if (ret)
>> +		goto error_disable_reg;
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto error_cleanup_buffer;
>> +
>> +	return 0;
>> +
>> +error_cleanup_buffer:
>> +	iio_triggered_buffer_cleanup(indio_dev);
>> +error_disable_reg:
>> +	regulator_disable(st->reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static int tlc4541_remove(struct spi_device *spi)
>> +{
>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +	struct tlc4541_state *st = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +	iio_triggered_buffer_cleanup(indio_dev);
>> +	regulator_disable(st->reg);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +
>> +static const struct of_device_id tlc4541_dt_ids[] = {
>> +	{ .compatible = "ti,tlc4541", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
>> +
>> +#endif
>> +
>> +static const struct spi_device_id tlc4541_id[] = {
>> +	{"tlc4541", TLC4541},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(spi, tlc4541_id);
>> +
>> +static struct spi_driver tlc4541_driver = {
>> +	.driver = {
>> +		.name   = "tlc4541",
>> +		.of_match_table = of_match_ptr(tlc4541_dt_ids),
>> +	},
>> +	.probe          = tlc4541_probe,
>> +	.remove         = tlc4541_remove,
>> +	.id_table       = tlc4541_id,
>> +};
>> +module_spi_driver(tlc4541_driver);
>> +
>> +MODULE_AUTHOR("Phil Reid <preid@electromag.com.au>");
>> +MODULE_DESCRIPTION("Texas Instruments TLC4541 ADC");
>> +MODULE_LICENSE("GPL v2");
>>
> 

