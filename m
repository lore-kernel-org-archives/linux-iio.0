Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41989 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcJ3NeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 09:34:01 -0400
Subject: Re: [PATCH v3 6/8] iio: dpot-dac: DAC driver based on a digital
 potentiometer
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
 <1477262381-7800-7-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <301ab064-cd90-d99d-a05a-8a50ba759c62@kernel.org>
Date: Sun, 30 Oct 2016 13:33:58 +0000
MIME-Version: 1.0
In-Reply-To: <1477262381-7800-7-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/10/16 23:39, Peter Rosin wrote:
> It is assumed that the dpot is used as a voltage divider between the
> current dpot wiper setting and the maximum resistance of the dpot. The
> divided voltage is provided by a vref regulator.
> 
>                   .------.
>    .-----------.  |      |
>    | vref      |--'    .---.
>    | regulator |--.    |   |
>    '-----------'  |    | d |
>                   |    | p |
>                   |    | o |  wiper
>                   |    | t |<---------+
>                   |    |   |
>                   |    '---'       dac output voltage
>                   |      |
>                   '------+------------+
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Only a trivial suggestion to drop the devinfo about max ohms now it's
exposed (effectively) via the dpot driver. (really minor though so don't bother
respinning for that!)

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-dac-dpot-dac         |   8 +
>  MAINTAINERS                                        |   2 +
>  drivers/iio/dac/Kconfig                            |  10 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/dpot-dac.c                         | 267 +++++++++++++++++++++
>  5 files changed, 288 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
>  create mode 100644 drivers/iio/dac/dpot-dac.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
> new file mode 100644
> index 000000000000..580e93f373f6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
> @@ -0,0 +1,8 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw_available
> +Date:		October 2016
> +KernelVersion:	4.9
> +Contact:	Peter Rosin <peda@axentia.se>
> +Description:
> +		The range of available values represented as the minimum value,
> +		the step and the maximum value, all enclosed in square brackets.
> +		Example: [0 1 256]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6218010128dc..d7375f45ff0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6115,7 +6115,9 @@ IIO DIGITAL POTENTIOMETER DAC
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
>  F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> +F:	drivers/iio/dac/dpot-dac.c
>  
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 120b24478469..d3084028905b 100644
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
> +	  called dpot-dac.
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
> index 000000000000..f227a211d34d
> --- /dev/null
> +++ b/drivers/iio/dac/dpot-dac.c
> @@ -0,0 +1,267 @@
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
> + * It is assumed that the dpot is used as a voltage divider between the
> + * current dpot wiper setting and the maximum resistance of the dpot. The
> + * divided voltage is provided by a vref regulator.
> + *
> + *                   .------.
> + *    .-----------.  |      |
> + *    | vref      |--'    .---.
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
> +	u32 max_ohms;
> +};
> +
> +static const struct iio_chan_spec dpot_dac_iio_channel = {
> +	.type = IIO_VOLTAGE,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +			    | BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +	.output = 1,
> +	.indexed = 1,
> +};
> +
> +static int dpot_dac_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct dpot_dac *dac = iio_priv(indio_dev);
> +	int ret;
> +	unsigned long long tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_read_channel_raw(dac->dpot, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_read_channel_scale(dac->dpot, val, val2);
> +		switch (ret) {
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = *val * 1000000000LL;
> +			do_div(tmp, dac->max_ohms);
> +			tmp *= regulator_get_voltage(dac->vref) / 1000;
> +			do_div(tmp, 1000000000LL);
> +			*val = tmp;
> +			return ret;
> +		case IIO_VAL_INT:
> +			/*
> +			 * Convert integer scale to fractional scale by
> +			 * setting the denominator (val2) to one...
> +			 */
> +			*val2 = 1;
> +			ret = IIO_VAL_FRACTIONAL;
> +			/* ...and fall through. */
> +		case IIO_VAL_FRACTIONAL:
> +			*val *= regulator_get_voltage(dac->vref) / 1000;
> +			*val2 *= dac->max_ohms;
> +			break;
> +		}
> +
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int dpot_dac_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	struct dpot_dac *dac = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_read_avail_channel_raw(dac->dpot,
> +						  vals, type, length);
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
> +	.read_avail = dpot_dac_read_avail,
> +	.write_raw = dpot_dac_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int dpot_dac_channel_max_ohms(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &indio_dev->dev;
> +	struct dpot_dac *dac = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +	int ret;
> +	int val;
> +	int val2;
> +	int max;
> +
> +	ret = iio_read_max_channel_raw(dac->dpot, &max);
> +	if (ret < 0) {
> +		dev_err(dev, "dpot does not indicate its raw maximum value\n");
> +		return ret;
> +	}
> +
> +	switch (iio_read_channel_scale(dac->dpot, &val, &val2)) {
> +	case IIO_VAL_INT:
> +		return max * val;
> +	case IIO_VAL_FRACTIONAL:
> +		tmp = (unsigned long long)max * val;
> +		do_div(tmp, val2);
> +		return tmp;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp = (s64)val * 1000000000LL * max >> val2;
> +		do_div(tmp, 1000000000LL);
> +		return tmp;
> +	default:
> +		dev_err(dev, "dpot has a scale that is too weird\n");
> +	}
> +
> +	return -EINVAL;
> +}
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
> +	ret = iio_get_channel_type(dac->dpot, &type);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (type != IIO_RESISTANCE) {
> +		dev_err(dev, "dpot is of the wrong type\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = dpot_dac_channel_max_ohms(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +	dac->max_ohms = ret;
> +	dev_info(dev, "dpot max is %d\n", dac->max_ohms);
Given we can query this (indirectly) from the dpot itself, I'd drop this now.

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

