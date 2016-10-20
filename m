Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:35161 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932582AbcJTL3H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Oct 2016 07:29:07 -0400
Date: Thu, 20 Oct 2016 13:29:01 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Peter Rosin <peda@axentia.se>
cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: dpot-dac: DAC driver based on a digital
 potentiometer
In-Reply-To: <1476955562-13673-3-git-send-email-peda@axentia.se>
Message-ID: <alpine.DEB.2.02.1610201254370.19919@pmeerw.net>
References: <1476955562-13673-1-git-send-email-peda@axentia.se> <1476955562-13673-3-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> It is assumed the that the dpot is used as a voltage divider between the
> current dpot wiper setting and the maximum resistance of the dpot. The
> divided voltage is provided by a vref regulator.
> 
>                   .------.
>    .-----------.  |      |
>    | Vref      |--'    .---.
>    | regulator |--.    |   |
>    '-----------'  |    | d |
>                   |    | p |
>                   |    | o |  wiper
>                   |    | t |<---------+
>                   |    |   |
>                   |    '---'       dac output voltage
>                   |      |
>                   '------+------------+

nice ASCII art :)
comments below, just nitpicking

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  MAINTAINERS                |   1 +
>  drivers/iio/dac/Kconfig    |  10 +++
>  drivers/iio/dac/Makefile   |   1 +
>  drivers/iio/dac/dpot-dac.c | 219 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+)
>  create mode 100644 drivers/iio/dac/dpot-dac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c68b72088945..8c8aae24b96b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6116,6 +6116,7 @@ M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> +F:	drivers/iio/dac/dpot-dac.c
>  
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 120b24478469..934d4138fcdb 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -200,6 +200,16 @@ config AD8801
>  	  To compile this driver as a module choose M here: the module will be called
>  	  ad8801.
>  
> +config DPOT_DAC
> +	tristate "DAC emulation using a DPOT"
> +	depends on OF
> +	help
> +	  Say yes here to build support for DAC emulation using a digital
> +	  potentiometer.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called iio-dpot-dac.

I guess the name will be dpot-dac?

> +
>  config LPC18XX_DAC
>  	tristate "NXP LPC18xx DAC driver"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 27642bbf75f2..f01bf4a99867 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_AD5686) += ad5686.o
>  obj-$(CONFIG_AD7303) += ad7303.o
>  obj-$(CONFIG_AD8801) += ad8801.o
>  obj-$(CONFIG_CIO_DAC) += cio-dac.o
> +obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
> new file mode 100644
> index 000000000000..94fbb4b27287
> --- /dev/null
> +++ b/drivers/iio/dac/dpot-dac.c
> @@ -0,0 +1,219 @@
> +/*
> + * IIO DAC emulation driver using a digital potentiometer
> + *
> + * Copyright (C) 2016 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * It is assumed the that the dpot is used as a voltage divider between the

delete first 'the'

> + * current dpot wiper setting and the maximum resistance of the dpot. The
> + * divided voltage is provided by a vref regulator.
> + *
> + *                   .------.
> + *    .-----------.  |      |
> + *    | Vref      |--'    .---.

vref maybe lowercase

> + *    | regulator |--.    |   |
> + *    '-----------'  |    | d |
> + *                   |    | p |
> + *                   |    | o |  wiper
> + *                   |    | t |<---------+
> + *                   |    |   |
> + *                   |    '---'       dac output voltage
> + *                   |      |
> + *                   '------+------------+
> + */
> +
> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct dpot_dac {
> +	struct regulator *vref;
> +	struct iio_channel *dpot;

const

> +	u32 max_ohms;
> +};
> +
> +static const struct iio_chan_spec dpot_dac_iio_channel = {
> +	.type = IIO_VOLTAGE,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +			    | BIT(IIO_CHAN_INFO_SCALE),
> +	.output = 1,
> +};
> +
> +static int dpot_dac_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct dpot_dac *dac = iio_priv(indio_dev);
> +	int ret;
> +	unsigned long long tmp;

s64 (which is used to cast below)

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_read_channel_raw(dac->dpot, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_read_channel_scale(dac->dpot, val, val2);
> +		switch (ret) {
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = (s64)*val * 1000000000LL;
> +			do_div(tmp, dac->max_ohms);
> +			tmp *= regulator_get_voltage(dac->vref) / 1000;
> +			do_div(tmp, 1000000000LL);
> +			*val = tmp;
> +			return ret;
> +		case IIO_VAL_INT:
> +			*val2 = 1;

I think this needs a comment to clarify what's going on...

> +			ret = IIO_VAL_FRACTIONAL;
> +			break;
> +		}
> +		*val *= regulator_get_voltage(dac->vref) / 1000;
> +		*val2 *= dac->max_ohms;
> +
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct dpot_dac *dac = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_write_channel_raw(dac->dpot, val);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info dpot_dac_info = {
> +	.read_raw = dpot_dac_read_raw,
> +	.write_raw = dpot_dac_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int dpot_dac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct dpot_dac *dac;
> +	enum iio_chan_type type;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*dac));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	dac = iio_priv(indio_dev);
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &dpot_dac_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &dpot_dac_iio_channel;
> +	indio_dev->num_channels = 1;

maybe ARRAY_SIZE(dpot_dac_iio_channel) to future-proof it

> +
> +	dac->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(dac->vref)) {
> +		if (PTR_ERR(dac->dpot) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get vref regulator\n");
> +		return PTR_ERR(dac->vref);
> +	}
> +
> +	dac->dpot = devm_iio_channel_get(dev, "dpot");
> +	if (IS_ERR(dac->dpot)) {
> +		if (PTR_ERR(dac->dpot) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get dpot input channel\n");
> +		return PTR_ERR(dac->dpot);
> +	}
> +
> +	switch (iio_read_channel_scale(dac->dpot, &ret, NULL)) {
> +	case IIO_VAL_INT:
> +	case IIO_VAL_FRACTIONAL:
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		break;
> +	default:
> +		dev_err(dev, "dpot has a scale that is too weird\n");

:-)

> +		return -EINVAL;
> +	}
> +
> +	ret = iio_get_channel_type(dac->dpot, &type);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (type != IIO_RESISTANCE) {
> +		dev_err(dev, "dpot is of the wrong type\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "dpot-dac,max-ohms",
> +				   &dac->max_ohms);
> +	if (ret) {
> +		dev_err(dev, "the dpot-dac,max-ohms property is missing\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(dac->vref);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the vref regulator\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register iio device\n");
> +		goto disable_reg;
> +	}
> +
> +	return 0;
> +
> +disable_reg:
> +	regulator_disable(dac->vref);
> +	return ret;
> +}
> +
> +static int dpot_dac_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct dpot_dac *dac = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(dac->vref);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dpot_dac_match[] = {
> +	{ .compatible = "dpot-dac" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dpot_dac_match);
> +
> +static struct platform_driver dpot_dac_driver = {
> +	.probe = dpot_dac_probe,
> +	.remove = dpot_dac_remove,
> +	.driver = {
> +		.name = "iio-dpot-dac",
> +		.of_match_table = dpot_dac_match,
> +	},
> +};
> +module_platform_driver(dpot_dac_driver);
> +
> +MODULE_DESCRIPTION("DAC emulation driver using a digital potentiometer");
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
