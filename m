Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59064 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbcGXMUD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 08:20:03 -0400
Subject: Re: [PATCH v2] iio: Add IIO support for the Measurement Computing
 CIO-DAC family
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <20160712133314.GA12420@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <51df4147-20e6-5fa4-c890-8b671c755cc3@kernel.org>
Date: Sun, 24 Jul 2016 13:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <20160712133314.GA12420@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/07/16 14:33, William Breathitt Gray wrote:
> The Measurement Computing CIO-DAC is a family of 16-bit and 12-bit
> analog output devices. The analog outputs are from AD660BN/AD7237
> converters with each output buffered by an OP-27. Voltage ranges are
> configured via physical jumpers on the device.
> 
> This driver does not support the devices' simulataneous update mode; the
> XFER jumper option should be deselected for all analog output channels.
> 
> This driver provides IIO support for the Measurement Computing CIO-DAC
> family: CIO-DAC16, CIO-DAC08, and PC104-DAC06. The base port addresses
> for the devices may be configured via the base array module parameter.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Looks good to me.

Applied to the togreg branch of iio.git - will be initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
>   - Change description from "DAC driver" to the more apt "IIO driver"
>   - Update message body to reflect 16-bit DAC resolution
>   - Change chan_out_states to hold ints in order to match val data type
>   - Verify val is within appropriate DAC value range before accepting
> 
>  MAINTAINERS               |   6 ++
>  drivers/iio/dac/Kconfig   |   9 +++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/cio-dac.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 drivers/iio/dac/cio-dac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 345e757..b5c802d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7318,6 +7318,12 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
> +MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
> +M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/dac/cio-dac.c
> +
>  MEDIA DRIVERS FOR RENESAS - VSP1
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index ca81447..b9f0442 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -181,6 +181,15 @@ config AD7303
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad7303.
>  
> +config CIO_DAC
> +	tristate "Measurement Computing CIO-DAC IIO driver"
> +	depends on X86 && ISA_BUS_API
> +	help
> +	  Say yes here to build support for the Measurement Computing CIO-DAC
> +	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
> +	  base port addresses for the devices may be configured via the base
> +	  array module parameter.
> +
>  config LPC18XX_DAC
>  	tristate "NXP LPC18xx DAC driver"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8b78d5c..b1a1206 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
>  obj-$(CONFIG_AD7303) += ad7303.o
> +obj-$(CONFIG_CIO_DAC) += cio-dac.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> new file mode 100644
> index 0000000..5a743e2
> --- /dev/null
> +++ b/drivers/iio/dac/cio-dac.c
> @@ -0,0 +1,144 @@
> +/*
> + * IIO driver for the Measurement Computing CIO-DAC
> + * Copyright (C) 2016 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * This driver supports the following Measurement Computing devices: CIO-DAC16,
> + * CIO-DAC06, and PC104-DAC06.
> + */
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/isa.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +
> +#define CIO_DAC_NUM_CHAN 16
> +
> +#define CIO_DAC_CHAN(chan) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.channel = chan,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.indexed = 1,					\
> +	.output = 1					\
> +}
> +
> +#define CIO_DAC_EXTENT 32
> +
> +static unsigned int base[max_num_isa_dev(CIO_DAC_EXTENT)];
> +static unsigned int num_cio_dac;
> +module_param_array(base, uint, &num_cio_dac, 0);
> +MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
> +
> +/**
> + * struct cio_dac_iio - IIO device private data structure
> + * @chan_out_states:	channels' output states
> + * @base:		base port address of the IIO device
> + */
> +struct cio_dac_iio {
> +	int chan_out_states[CIO_DAC_NUM_CHAN];
> +	unsigned int base;
> +};
> +
> +static int cio_dac_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +	struct cio_dac_iio *const priv = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	*val = priv->chan_out_states[chan->channel];
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int cio_dac_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct cio_dac_iio *const priv = iio_priv(indio_dev);
> +	const unsigned int chan_addr_offset = 2 * chan->channel;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	/* DAC can only accept up to a 16-bit value */
> +	if ((unsigned int)val > 65535)
> +		return -EINVAL;
> +
> +	priv->chan_out_states[chan->channel] = val;
> +	outw(val, priv->base + chan_addr_offset);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info cio_dac_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = cio_dac_read_raw,
> +	.write_raw = cio_dac_write_raw
> +};
> +
> +static const struct iio_chan_spec cio_dac_channels[CIO_DAC_NUM_CHAN] = {
> +	CIO_DAC_CHAN(0), CIO_DAC_CHAN(1), CIO_DAC_CHAN(2), CIO_DAC_CHAN(3),
> +	CIO_DAC_CHAN(4), CIO_DAC_CHAN(5), CIO_DAC_CHAN(6), CIO_DAC_CHAN(7),
> +	CIO_DAC_CHAN(8), CIO_DAC_CHAN(9), CIO_DAC_CHAN(10), CIO_DAC_CHAN(11),
> +	CIO_DAC_CHAN(12), CIO_DAC_CHAN(13), CIO_DAC_CHAN(14), CIO_DAC_CHAN(15)
> +};
> +
> +static int cio_dac_probe(struct device *dev, unsigned int id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct cio_dac_iio *priv;
> +	unsigned int i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	if (!devm_request_region(dev, base[id], CIO_DAC_EXTENT,
> +		dev_name(dev))) {
> +		dev_err(dev, "Unable to request port addresses (0x%X-0x%X)\n",
> +			base[id], base[id] + CIO_DAC_EXTENT);
> +		return -EBUSY;
> +	}
> +
> +	indio_dev->info = &cio_dac_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = cio_dac_channels;
> +	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
> +	indio_dev->name = dev_name(dev);
> +
> +	priv = iio_priv(indio_dev);
> +	priv->base = base[id];
> +
> +	/* initialize DAC outputs to 0V */
> +	for (i = 0; i < 32; i += 2)
> +		outw(0, base[id] + i);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static struct isa_driver cio_dac_driver = {
> +	.probe = cio_dac_probe,
> +	.driver = {
> +		.name = "cio-dac"
> +	}
> +};
> +
> +module_isa_driver(cio_dac_driver, num_cio_dac);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Measurement Computing CIO-DAC IIO driver");
> +MODULE_LICENSE("GPL v2");
> 

