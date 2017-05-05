Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43078 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdEESzv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2017 14:55:51 -0400
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3ebf6029-aba6-d572-c618-32166a005f0f@kernel.org>
Date: Fri, 5 May 2017 19:55:49 +0100
MIME-Version: 1.0
In-Reply-To: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 07:31, Jan Kiszka wrote:
> This is an upstream port of an IIO driver for the TI ADC108S102 and
> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
> included.
> 
> Due to the lack of regulators under ACPI, we need a special device
> property to define the voltage provide to the VA pin of the ADC
> ("va-millivolt"). For DT usage, the regulator "vref-supply" is
> requested. Note that DT usage has not been tested.
> 
> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
> Todor Minchev <todor@minchev.co.uk>.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
A few comments inline, but nothing terribly significant.
> ---
> 
> Changes in v3:
>  - Reworked reference voltage handling, splitting up the different ACPI
>    case from DT usage. This also means that the "va-millivolt"
>    (formerly and incorrectly called "ext-vin-microvolt") becomes
>    ACPI-only
>  - Add DT binding (straightforward, no device specifics, but untested)
>  - Address smaller remarks by Andy
> 
>  .../devicetree/bindings/iio/adc/ti-adc108s102.txt  |  18 ++
>  drivers/iio/adc/Kconfig                            |  12 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-adc108s102.c                    | 338 +++++++++++++++++++++
>  4 files changed, 369 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
>  create mode 100644 drivers/iio/adc/ti-adc108s102.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
> new file mode 100644
> index 000000000000..bbbbb4a9f58f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
> @@ -0,0 +1,18 @@
> +* Texas Instruments' ADC108S102 and ADC128S102 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,adc108s102"
> + - reg: spi chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc108s102";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dedae7adbce9..8b7dae5604f2 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -572,6 +572,18 @@ config TI_ADC12138
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc12138.
>  
> +config TI_ADC108S102
> +	tristate "Texas Instruments ADC108S102 and ADC128S102 driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Texas Instruments ADC108S102 and
> +	  ADC128S102 ADC.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called ti-adc108s102.
> +
>  config TI_ADC128S052
>  	tristate "Texas Instruments ADC128S052/ADC122S021/ADC124S021"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d0012620cd1c..e6c20fe3d4eb 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
> +obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> new file mode 100644
> index 000000000000..88dc32dd45a9
> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -0,0 +1,338 @@
> +/*
> + * TI ADC108S102 SPI ADC driver
> + *
> + * Copyright (c) 2013-2015 Intel Corporation.
> + * Copyright (c) 2017 Siemens AG
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * This IIO device driver is designed to work with the following
> + * analog to digital converters from Texas Instruments:
> + *  ADC108S102
> + *  ADC128S102
> + * The communication with ADC chip is via the SPI bus (mode 3).
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/types.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +/*
> + * Defining the ADC resolution being 12 bits, we can use the same driver for
> + * both ADC108S102 (10 bits resolution) and ADC128S102 (12 bits resolution)
> + * chips. The ADC108S102 effectively returns a 12-bit result with the 2
> + * least-significant bits unset.
> + */
> +#define ADC108S102_BITS		12
> +#define ADC108S102_MAX_CHANNELS	8
> +
> +/*
> + * 16-bit SPI command format:
> + *   [15:14] Ignored
> + *   [13:11] 3-bit channel address
> + *   [10:0]  Ignored
> + */
> +#define ADC108S102_CMD(ch)		((u16)(ch) << 11)
> +
> +/*
> + * 16-bit SPI response format:
> + *   [15:12] Zeros
> + *   [11:0]  12-bit ADC sample (for ADC108S102, [1:0] will always be 0).
> + */
> +#define ADC108S102_RES_DATA(res)	((u16)res & GENMASK(11, 0))
> +
> +struct adc108s102_state {
> +	struct spi_device		*spi;
> +	struct regulator		*reg;
> +	u32				va_millivolt;
> +	/* SPI transfer used by triggered buffer handler*/
> +	struct spi_transfer		ring_xfer;
> +	/* SPI transfer used by direct scan */
> +	struct spi_transfer		scan_single_xfer;
> +	/* SPI message used by ring_xfer SPI transfer */
> +	struct spi_message		ring_msg;
> +	/* SPI message used by scan_single_xfer SPI transfer */
> +	struct spi_message		scan_single_msg;
> +
> +	/*
> +	 * SPI message buffers:
> +	 *  tx_buf: |C0|C1|C2|C3|C4|C5|C6|C7|XX|
> +	 *  rx_buf: |XX|R0|R1|R2|R3|R4|R5|R6|R7|tt|tt|tt|tt|
> +	 *
> +	 *  tx_buf: 8 channel read commands, plus 1 dummy command
> +	 *  rx_buf: 1 dummy response, 8 channel responses, plus 64-bit timestamp
> +	 */
> +	__be16				rx_buf[13] ____cacheline_aligned;
> +	__be16				tx_buf[9] ____cacheline_aligned;
I would have thought the SPI dma wouldn't take itself out so you should be
good with just the one cacheline_aligned?  Maybe I'm missing something.
> +};
> +
> +#define ADC108S102_V_CHAN(index)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = index,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.address = index,					\
> +		.scan_index = index,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = ADC108S102_BITS,			\
> +			.storagebits = 16,				\
> +			.endianness = IIO_BE,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec adc108s102_channels[] = {
> +	ADC108S102_V_CHAN(0),
> +	ADC108S102_V_CHAN(1),
> +	ADC108S102_V_CHAN(2),
> +	ADC108S102_V_CHAN(3),
> +	ADC108S102_V_CHAN(4),
> +	ADC108S102_V_CHAN(5),
> +	ADC108S102_V_CHAN(6),
> +	ADC108S102_V_CHAN(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +};
> +
> +static int adc108s102_update_scan_mode(struct iio_dev *indio_dev,
> +		unsigned long const *active_scan_mask)
> +{
> +	struct adc108s102_state *st = iio_priv(indio_dev);
> +	unsigned int bit, cmds;
> +
> +	/*
> +	 * Fill in the first x shorts of tx_buf with the number of channels
> +	 * enabled for sampling by the triggered buffer.
> +	 */
> +	cmds = 0;
> +	for_each_set_bit(bit, active_scan_mask, ADC108S102_MAX_CHANNELS)
> +		st->tx_buf[cmds++] = cpu_to_be16(ADC108S102_CMD(bit));
> +
> +	/* One dummy command added, to clock in the last response */
> +	st->tx_buf[cmds++] = 0x00;
> +
> +	/* build SPI ring message */
> +	st->ring_xfer.tx_buf = &st->tx_buf[0];
> +	st->ring_xfer.rx_buf = &st->rx_buf[0];
> +	st->ring_xfer.len = cmds * sizeof(st->tx_buf[0]);
> +
> +	spi_message_init_with_transfers(&st->ring_msg, &st->ring_xfer, 1);
> +
Nice ;)
> +	return 0;
> +}
> +
> +static irqreturn_t adc108s102_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adc108s102_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = spi_sync(st->spi, &st->ring_msg);
> +	if (ret < 0)
> +		goto out_notify;
> +
> +	/* Skip the dummy response in the first slot */
> +	iio_push_to_buffers_with_timestamp(indio_dev,
> +					   (u8 *)&st->rx_buf[1],
> +					   iio_get_time_ns(indio_dev));
> +
> +out_notify:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc108s102_scan_direct(struct adc108s102_state *st, unsigned int ch)
> +{
> +	int ret;
> +
> +	st->tx_buf[0] = cpu_to_be16(ADC108S102_CMD(ch));
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		return ret;
> +
> +	/* Skip the dummy response in the first slot */
> +	return be16_to_cpu(st->rx_buf[1]);
> +}
> +
> +static int adc108s102_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long m)
> +{
> +	struct adc108s102_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = adc108s102_scan_direct(st, chan->address);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ADC108S102_RES_DATA(ret);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (st->reg)
> +				*val = regulator_get_voltage(st->reg) / 1000;
> +			else
> +				*val = st->va_millivolt;
> +
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else {
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info adc108s102_info = {
> +	.read_raw		= &adc108s102_read_raw,
> +	.update_scan_mode	= &adc108s102_update_scan_mode,
> +	.driver_module		= THIS_MODULE,
> +};
> +
> +static int adc108s102_probe(struct spi_device *spi)
> +{
> +	struct adc108s102_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	if (ACPI_COMPANION(&spi->dev)) {
> +		st->reg = NULL;
> +		ret = device_property_read_u32(&spi->dev, "va-millivolt",
> +					    &st->va_millivolt);
> +		if (ret < 0) {
> +			dev_err(&spi->dev,
> +				"Missing va-millivolt device property\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +		st->reg = devm_regulator_get(&spi->dev, "vref");
> +		if (IS_ERR(st->reg))
> +			return PTR_ERR(st->reg);
> +
> +		ret = regulator_enable(st->reg);
Would be nice to do something smarter with the regs to not insist they
are on if no one cares, (i.e. runtime pm stuff) but that can follow later
if you feel like doing it at all!
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "Cannot enable vref regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi = spi;
> +
> +	indio_dev->name = spi->modalias;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adc108s102_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adc108s102_channels);
> +	indio_dev->info = &adc108s102_info;
> +
> +	/* Setup default message */
> +	st->scan_single_xfer.tx_buf = st->tx_buf;
> +	st->scan_single_xfer.rx_buf = st->rx_buf;
> +	st->scan_single_xfer.len = 2 * sizeof(st->tx_buf[0]);
> +
> +	spi_message_init_with_transfers(&st->scan_single_msg,
> +					&st->scan_single_xfer, 1);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +			&adc108s102_trigger_handler, NULL);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to register IIO device\n");
> +		goto error_disable_reg;
> +	}
> +	return 0;
> +
> +error_disable_reg:
> +	if (!IS_ERR(st->reg))
> +		regulator_disable(st->reg);
> +
> +	return ret;
> +}
> +
> +static int adc108s102_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adc108s102_state *st = iio_priv(indio_dev);
> +
> +	if (!IS_ERR(st->reg))
> +		regulator_disable(st->reg);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id adc108s102_of_match[] = {
> +	{ .compatible = "ti,adc108s102" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc108s102_of_match);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id adc108s102_acpi_ids[] = {
> +	{ "INT3495", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc108s102_acpi_ids);
> +#endif
> +
> +static const struct spi_device_id adc108s102_id[] = {
> +	{ "adc108s102", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adc108s102_id);
> +
> +static struct spi_driver adc108s102_driver = {
> +	.driver = {
> +		.name   = "adc108s102",
> +		.of_match_table = of_match_ptr(adc108s102_of_match),
> +		.acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
> +	},
> +	.probe		= adc108s102_probe,
> +	.remove		= adc108s102_remove,
> +	.id_table	= adc108s102_id,
> +};
> +module_spi_driver(adc108s102_driver);
> +
> +MODULE_AUTHOR("Bogdan Pricop <bogdan.pricop@emutex.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADC108S102 and ADC128S102 driver");
> +MODULE_LICENSE("GPL v2");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

