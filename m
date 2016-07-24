Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59328 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbcGXNST (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 09:18:19 -0400
Subject: Re: [PATCH v2 2/3] iio: stx104: Add IIO support for the ADC channels
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <cover.1468944073.git.vilhelm.gray@gmail.com>
 <f1d94226cc1ffb2341535965ad1835f3f668e3c5.1468944073.git.vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1ed9ee97-32d7-310b-3c24-b4cf54a37c4e@kernel.org>
Date: Sun, 24 Jul 2016 14:18:16 +0100
MIME-Version: 1.0
In-Reply-To: <f1d94226cc1ffb2341535965ad1835f3f668e3c5.1468944073.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 17:25, William Breathitt Gray wrote:
> The Apex Embedded Systems STX104 features 16 channels of single-ended (8
> channels of true differential) 16-bit analog input. Differential input
> configuration may be selected via a physical jumper on the device.
> Similarly, input polarity (unipolar/bipolar) is configured via a
> physical jumper on the device.
> 
> Input gain selection is available to the user via software, thus
> allowing eight possible input ranges: +-10V, +-5V, +-2.5V, +-1.25V,
> 0 to 10V, 0 to 5V, 0 to 2.5V, and 0 to 1.25V. Four input gain
> configurations are supported: x1, x2, x4, and x8.
> 
> This ADC resolution is 16-bits (1/65536 of full scale). Analog input
> samples are taken on software trigger; neither FIFO sampling nor
> interrupt triggering is supported by this driver.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
A few bits inline.

Jonathan
> ---
>  drivers/iio/dac/Kconfig  |  15 +++--
>  drivers/iio/dac/stx104.c | 159 ++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 147 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index ca81447..60294ef 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -246,14 +246,19 @@ config MCP4922
>  	  will be called mcp4922.
>  
>  config STX104
> -	tristate "Apex Embedded Systems STX104 DAC driver"
> +	tristate "Apex Embedded Systems STX104 driver"
>  	depends on X86 && ISA_BUS_API
>  	select GPIOLIB
>  	help
> -	  Say yes here to build support for the 2-channel DAC and GPIO on the
> -	  Apex Embedded Systems STX104 integrated analog PC/104 card. The base
> -	  port addresses for the devices may be configured via the base array
> -	  module parameter.
> +	  Say yes here to build support for the Apex Embedded Systems STX104
> +	  integrated analog PC/104 card.
> +
> +	  This driver supports the 16 channels of single-ended (8 channels of
> +	  differential) analog inputs, 2 channels of analog output, 4 digital
> +	  inputs, and 4 digital outputs provided by the STX104.
> +
> +	  The base port addresses for the devices may be configured via the base
> +	  array module parameter.
>  
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
> diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
> index bebbd00..51f6534 100644
> --- a/drivers/iio/dac/stx104.c
> +++ b/drivers/iio/dac/stx104.c
> @@ -1,5 +1,5 @@
>  /*
> - * DAC driver for the Apex Embedded Systems STX104
> + * IIO driver for the Apex Embedded Systems STX104
>   * Copyright (C) 2016 William Breathitt Gray
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -20,21 +20,32 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/isa.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/spinlock.h>
>  
> -#define STX104_NUM_CHAN 2
> +#define STX104_EXTENT 16
>  
> -#define STX104_CHAN(chan) {				\
> +#define STX104_IO_CHAN(chan, dir) {			\
>  	.type = IIO_VOLTAGE,				\
>  	.channel = chan,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  	.indexed = 1,					\
> -	.output = 1					\
> +	.output = dir					\
> +}
> +#define STX104_GAIN_CHAN {					\
> +	.type = IIO_VOLTAGE,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
> +	.output = 1						\
>  }
> +#define STX104_OUT_CHAN(chan) STX104_IO_CHAN(chan, 1)
> +#define STX104_IN_CHAN(chan) STX104_IO_CHAN(chan, 0)
>  
> -#define STX104_EXTENT 16
> +#define STX104_NUM_OUT_CHAN 2
> +#define STX104_NUM_GAIN_CHAN 1
> +#define STX104_NUM_IN_CHAN 16
> +#define STX104_IN_CHAN_OFFSET (STX104_NUM_OUT_CHAN + STX104_NUM_GAIN_CHAN)
>  
>  static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
>  static unsigned int num_stx104;
> @@ -47,7 +58,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
>   * @base:		base port address of the IIO device
>   */
>  struct stx104_iio {
> -	unsigned chan_out_states[STX104_NUM_CHAN];
> +	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
>  	unsigned base;
>  };
>  
> @@ -79,39 +90,123 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
>  	struct stx104_iio *const priv = iio_priv(indio_dev);
> +	long adc_sample;
> +	unsigned int adc_config;
> +	long adbu;
> +	unsigned int gain;
> +
> +	/* handle output channels */
> +	if (chan->output) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_RAW:
> +			*val = priv->chan_out_states[chan->channel];
> +			return IIO_VAL_INT;
> +		case IIO_CHAN_INFO_HARDWAREGAIN:
> +			*val = 1 << (inb(priv->base + 11) & 0x3);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
>  
>  	if (mask != IIO_CHAN_INFO_RAW)
>  		return -EINVAL;
>  
> -	*val = priv->chan_out_states[chan->channel];
> -
> -	return IIO_VAL_INT;
> +	/* select ADC channel */
> +	outb(chan->channel | (chan->channel << 4), priv->base + 2);
> +
> +	/* trigger ADC sample capture and wait for completion */
> +	outb(0, priv->base);
> +	while (inb(priv->base + 8) & BIT(7));
> +
> +	adc_sample = inw(priv->base);
> +
> +	/* get ADC bipolar/unipolar and gain configuration */
> +	adc_config = inb(priv->base + 11);
> +	adbu = !(adc_config & BIT(2));
> +	gain = adc_config & 0x3;
> +
> +	/* Value conversion math:
Fix the multiline comment syntax please.
/*
 * Value...
> +	 * ----------------------
> +	 * scale = adc_sample / 65536
> +	 * range = 10 / (1 << gain)
> +	 * voltage = scale * (range + adbu * range) - adbu * range
> +	 *
> +	 * Simplified:
> +	 * -----------
> +	 * voltage = 5 * (adc_sample * (1 + adbu) - adbu * 65536) /
> +	 *	(1 << (15 + gain))
> +	 *
> +	 * Portability Caution:
> +	 * --------------------
> +	 * *val will be set to a value between -327680 and 327675; in order to
> +	 * prevent integer underflow/overflow, the int data type of the
> +	 * implementation should be capable of representing this value range.
32 bits should easily do this.... Which is the kernel minimum size for int...

> +	 */
> +	*val = 5 * (adc_sample * (1 + adbu) - adbu * 65536);
> +	*val2 = 15 + gain;
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
>  }
>  
>  static int stx104_write_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int val, int val2, long mask)
>  {
>  	struct stx104_iio *const priv = iio_priv(indio_dev);
> -	const unsigned chan_addr_offset = 2 * chan->channel;
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> -
> -	priv->chan_out_states[chan->channel] = val;
> -	outw(val, priv->base + 4 + chan_addr_offset);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/* DAC can only accept up to a 16-bit value */
> +		if ((unsigned int)val > 65535)
> +			return -EINVAL;
> +
> +		priv->chan_out_states[chan->channel] = val;
> +		outw(val, priv->base + 4 + 2 * chan->channel);
> +
> +		return 0;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		/* Only four gain states (x1, x2, x4, x8) */
> +		switch (val) {
> +		case 1:
> +			outb(0, priv->base + 11);
> +			break;
> +		case 2:
> +			outb(1, priv->base + 11);
> +			break;
> +		case 4:
> +			outb(2, priv->base + 11);
> +			break;
> +		case 8:
> +			outb(3, priv->base + 11);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +	}
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static const struct iio_info stx104_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = stx104_read_raw,
> -	.write_raw = stx104_write_raw
> +	.write_raw = stx104_write_raw,
>  };
>  
> -static const struct iio_chan_spec stx104_channels[STX104_NUM_CHAN] = {
> -	STX104_CHAN(0),
> -	STX104_CHAN(1)
> +/* stx104_channels is not const in order to allow for the configuration of
> + * differential channels in the probe callback if a device is setup for such
> + */
> +static struct iio_chan_spec stx104_channels[] = {
> +	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
> +	STX104_GAIN_CHAN,
> +	STX104_IN_CHAN(0), STX104_IN_CHAN(1), STX104_IN_CHAN(2),
> +	STX104_IN_CHAN(3), STX104_IN_CHAN(4), STX104_IN_CHAN(5),
> +	STX104_IN_CHAN(6), STX104_IN_CHAN(7), STX104_IN_CHAN(8),
> +	STX104_IN_CHAN(9), STX104_IN_CHAN(10), STX104_IN_CHAN(11),
> +	STX104_IN_CHAN(12), STX104_IN_CHAN(13), STX104_IN_CHAN(14),
> +	STX104_IN_CHAN(15)
>  };
Presumably we have the potential for more than one of these boards in a
machine?  If so you'll need to take a copy of this array for each
of them as you modify it.  If not all the devices will share this
one copy..

As there only seem to be a couple of options, I'd select between
two different iio_chan_spec arrays instead of modifying them 
during probe.
>  
>  static int stx104_gpio_get_direction(struct gpio_chip *chip,
> @@ -181,6 +276,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	struct stx104_iio *priv;
>  	struct stx104_gpio *stx104gpio;
>  	struct stx104_dev *stx104dev;
> +	struct iio_chan_spec *input_channel;
> +	int i;
>  	int err;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> @@ -204,13 +301,31 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  
>  	indio_dev->info = &stx104_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(stx104_channels);
> +
> +	/* determine if differential inputs */
> +	if (inb(base[id] + 8) & BIT(5)) {
> +		indio_dev->num_channels -= STX104_NUM_IN_CHAN / 2;
> +
> +		input_channel = stx104_channels + STX104_IN_CHAN_OFFSET;
> +		for (i = 0; i < STX104_NUM_IN_CHAN / 2; input_channel++) {
> +			input_channel->differential = 1;
> +			input_channel->channel2 = i;
> +		}
> +	}
> +
>  	indio_dev->channels = stx104_channels;
> -	indio_dev->num_channels = STX104_NUM_CHAN;
>  	indio_dev->name = dev_name(dev);
>  
>  	priv = iio_priv(indio_dev);
>  	priv->base = base[id];
>  
> +	/* configure device for software trigger operation */
> +	outb(0, base[id] + 9);
> +
> +	/* initialize gain setting to x1 */
> +	outb(0, base[id] + 11);
> +
>  	/* initialize DAC output to 0V */
>  	outw(0, base[id] + 4);
>  	outw(0, base[id] + 6);
> @@ -271,5 +386,5 @@ static struct isa_driver stx104_driver = {
>  module_isa_driver(stx104_driver, num_stx104);
>  
>  MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> -MODULE_DESCRIPTION("Apex Embedded Systems STX104 DAC driver");
> +MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
>  MODULE_LICENSE("GPL v2");
> 

