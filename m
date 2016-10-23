Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57300 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcJWJm5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2016 05:42:57 -0400
Subject: Re: [PATCH v2 5/7] iio: dpot-dac: DAC driver based on a digital
 potentiometer
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1477176226-10566-1-git-send-email-peda@axentia.se>
 <1477176226-10566-6-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <16fb15a4-820a-2e48-921b-551e2338aefd@kernel.org>
Date: Sun, 23 Oct 2016 10:42:54 +0100
MIME-Version: 1.0
In-Reply-To: <1477176226-10566-6-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/10/16 23:43, Peter Rosin wrote:
> It is assumed the that the dpot is used as a voltage divider between the
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
Only suggstions is that some of the stuff for reading max value from
the channel wan't to get wrapped up in a utility function in iio/consumer.h
like the various channel value read and write functions.

As much of possible of internal IIO stuff should be opaque to consumers
(even when they happen to know about it as they are also IIO drivers ;)

Jonathan
> ---
>  MAINTAINERS                |   1 +
>  drivers/iio/dac/Kconfig    |  10 ++
>  drivers/iio/dac/Makefile   |   1 +
>  drivers/iio/dac/dpot-dac.c | 298 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 310 insertions(+)
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
> index 000000000000..5613eae32347
> --- /dev/null
> +++ b/drivers/iio/dac/dpot-dac.c
> @@ -0,0 +1,298 @@
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
> +	struct iio_dev *dpot_dev = dac->dpot->indio_dev;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return dpot_dev->info->read_avail(dpot_dev, dac->dpot->channel,
> +						  vals, type, length, mask);
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
> +	struct iio_channel *ch = dac->dpot;
> +	struct iio_dev *iio_ch_dev = ch->indio_dev;
> +	const int *vals;
> +	unsigned long long tmp;
> +	int type;
> +	int len;
> +	int ret;
> +	int val1;
> +	int val2;
> +	int max;
> +
Wants a wrapper in iio/consumer.h like we do for the various reads.
Otherwise, we'll end up with this as cut and paste boiler plate all over
the place.

> +	if (!iio_ch_dev->info->read_avail) {
> +		dev_err(dev, "dpot does not provide available raw values\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = iio_ch_dev->info->read_avail(iio_ch_dev, ch->channel,
> +					   &vals, &type, &len,
> +					   IIO_CHAN_INFO_RAW);
> +
> +	if (ret < 0) {
> +		dev_err(dev, "dpot failed to provide available raw values\n");
> +		return ret;
> +	}
(wrapper down to here..)
Worth noting that for the consumers they shouldn't need to know anything
about internal IIO structures (obviously you do here for other reasons
but try not to use that knowledge - should all be opaque outside the
subsystem.)
> +	if (type != IIO_VAL_INT) {
> +		dev_err(dev, "dpot provides strange raw values\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (ret) {
> +	case IIO_AVAIL_RANGE:
> +		if (len != 3) {
> +			dev_err(dev, "need a range of available values\n");
> +			return -EINVAL;
> +		}
> +		max = vals[2];
> +		break;
> +	default:
> +		dev_err(dev, "dpot doesn't provide range of available values\n");
You could handle the set of values but it would be more complex so fair
enough.  Any non linear dpots out there (with few enough values that we
can describe them in under page size)?
> +		return -EINVAL;
> +	}
> +
> +	switch (iio_read_channel_scale(dac->dpot, &val1, &val2)) {
> +	case IIO_VAL_INT:
> +		return max * val1;
> +	case IIO_VAL_FRACTIONAL:
> +		tmp = (unsigned long long)max * val1;
> +		do_div(tmp, val2);
> +		return tmp;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp = (s64)vals[0] * 1000000000LL * max >> vals[1];
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

