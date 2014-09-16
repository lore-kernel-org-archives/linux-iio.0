Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33777 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbaIPKJD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 16 Sep 2014 06:09:03 -0400
Date: Tue, 16 Sep 2014 03:00:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	IIO <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: Re: [PATCH v3 4/5] iio/adc/axp288: add support for axp288 gpadc
Message-ID: <20140916030032.6c0fe81f@ultegra>
In-Reply-To: <5414A075.6090904@kernel.org>
References: <1410477357-6407-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1410477357-6407-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.01.1409121428240.9934@pmeerw.net>
	<5414A075.6090904@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 13 Sep 2014 20:52:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 12/09/14 13:44, Peter Meerwald wrote:
> >
> >> Platform driver for XPowers AXP288 ADC, which is a sub-device of
> >> the customized PMIC for Intel Baytrail-CR platforms. GPADC device
> >> enumerates as one of the MFD cell devices. It uses IIO
> >> infrastructure to communicate with userspace and consumer drivers.
> >>
> >> Usages of ADC channels include battery charging and thermal
> >> sensors.
> >
> > minor nitpicking below
> A few more bits and pieces from me.
> 
> Jonathan
thanks for the review, comments below.
> >
> >> Based on initial work by:
> >> Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> >>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> ---
> >>  drivers/iio/adc/Kconfig        |   8 ++
> >>  drivers/iio/adc/Makefile       |   1 +
> >>  drivers/iio/adc/axp288_gpadc.c | 238
> >> +++++++++++++++++++++++++++++++++++++++++ 3 files changed, 247
> >> insertions(+) create mode 100644 drivers/iio/adc/axp288_gpadc.c
> >>
> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> index 11b048a..d02a08e 100644
> >> --- a/drivers/iio/adc/Kconfig
> >> +++ b/drivers/iio/adc/Kconfig
> >> @@ -127,6 +127,14 @@ config AT91_ADC
> >>  	help
> >>  	  Say yes here to build support for Atmel AT91 ADC.
> >>
> >> +config AXP288_GPADC
> >> +	tristate "X-Power AXP288 GPADC driver"
> >> +	depends on MFD_AXP2XX
> >> +	help
> >> +	  Say yes here to have support for X-Power power
> >> management IC (PMIC) ADC
> >> +	  device. Depending on platform configuration, this
> >> general purpose ADC can
> >> +	  be used for sampling sensors such as thermal resistors.
> >> +
> >>  config EXYNOS_ADC
> >>  	tristate "Exynos ADC driver support"
> >>  	depends on ARCH_EXYNOS || (OF && COMPILE_TEST)
> >> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >> index ad81b51..8bf0104 100644
> >> --- a/drivers/iio/adc/Makefile
> >> +++ b/drivers/iio/adc/Makefile
> >> @@ -30,3 +30,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
> >>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> >>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
> >>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> >> +obj-$(CONFIG_AXP288_GPADC) += axp288_gpadc.o
> >> diff --git a/drivers/iio/adc/axp288_gpadc.c
> >> b/drivers/iio/adc/axp288_gpadc.c new file mode 100644
> >> index 0000000..aaa24b0
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/axp288_gpadc.c
> >> @@ -0,0 +1,238 @@
> >> +/*
> >> + * axp288_gpadc.c - Xpower AXP288 PMIC GPADC Driver
> >
> > X-Power
> >
> >> + *
> >> + * Copyright (C) 2014 Intel Corporation
> >> + *
> >> + *
> >> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> modify
> >> + * it under the terms of the GNU General Public License as
> >> published by
> >> + * the Free Software Foundation; version 2 of the License.
> >> + *
> >> + * This program is distributed in the hope that it will be
> >> useful, but
> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> >> See the GNU
> >> + * General Public License for more details.
> >> + *
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/device.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/mfd/axp2xx.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/machine.h>
> >> +#include <linux/iio/driver.h>
> >> +
> >> +#define AXP288_ADC_EN_MASK		       0xF1
> >> +#define AXP288_ADC_TS_PIN_GPADC                0xF2
> >> +#define AXP288_ADC_TS_PIN_ON                   0xF3
> >> +
> >> +enum axp288_adc_id {
> >> +	AXP288_ADC_TS,
> >> +	AXP288_ADC_PMIC,
> >> +	AXP288_ADC_GP,
> >> +	AXP288_ADC_BATT_CHRG_I,
> >> +	AXP288_ADC_BATT_DISCHRG_I,
> >> +	AXP288_ADC_BATT_V,
> >> +	AXP288_ADC_NR_CHAN,
> >> +};
> >> +
> >> +static const int axp288_scale[AXP288_ADC_NR_CHAN] = {
> >
> > axp288_adc_scale
> >
> >> +	[AXP288_ADC_BATT_CHRG_I] = 1,
> >> +	[AXP288_ADC_BATT_DISCHRG_I] = 1,
> >> +	[AXP288_ADC_BATT_V] = 1,
> >> +};
> >> +
> >> +struct gpadc_info {
> >
> > axp288_adc_info
> >
> >> +	int irq;
> >> +	struct device *dev;
> >> +	struct regmap *regmap;
> >> +};
> >> +
> >> +#define ADC_CHANNEL(_type, _channel, _address,
> >> _info_mask)		\
> >
> > AXP288_ADC_CHANNEL
> >
> >> +
> >> {								\
> >> +		.indexed =
> >> 1,						\
> >> +		.type =
> >> _type,						\
> >> +		.channel =
> >> _channel,					\
> >> +		.address =
> >> _address,					\
> >> +		.datasheet_name =
> >> "CH"#_channel,			\
> >> +		.info_mask_separate =
> >> _info_mask,		        \
> >> +	}
> I'm not entirely convinced this little macro actually helps seeing as
> there is only one fixed element and a little saving on the datasheet
> name. Would be tempted to just list it long hand below for simplicity.
> 
I will use named initialization, i guess that is what you meant by long
hand?
> >> +
> >> +static const struct iio_chan_spec const axp288_adc_channels[] = {
> >> +	ADC_CHANNEL(IIO_TEMP, 0, AXP288_TS_ADC_H, 0),
> >> +	ADC_CHANNEL(IIO_TEMP, 1, AXP288_PMIC_ADC_H, 0),
> >> +	ADC_CHANNEL(IIO_TEMP, 2, AXP288_GP_ADC_H, 0),
> So these first three have no known scale or offset? Fair enough if
> true.
> 
yes. the in kernel consumer will know the scale. e.g. for ACPI
operational region use of the GP ADC channel, it expects raw reading
and converts data based on another table in ACPI.
> >> +	ADC_CHANNEL(IIO_CURRENT, 3, AXP20X_BATT_CHRG_I_H,
> >> +		(BIT(IIO_CHAN_INFO_RAW) |
> >> BIT(IIO_CHAN_INFO_SCALE))),
> So the output of these (raw*scale) is in milliamps as per the ABI?
> (it would be unusual if they are!)
> 
the raw data is already in milliamps with range 0-4095 (4095mA), I gave
scale of 1 or could be no scale. like you suggested below, use the
PROCESSED mask to avoid confusion is better.
> >> +	ADC_CHANNEL(IIO_CURRENT, 4, AXP20X_BATT_DISCHRG_I_H,
> >> +		(BIT(IIO_CHAN_INFO_RAW) |
> >> BIT(IIO_CHAN_INFO_SCALE))),
> >> +	ADC_CHANNEL(IIO_VOLTAGE, 5, AXP20X_BATT_V_H,
> >> +		(BIT(IIO_CHAN_INFO_RAW) |
> >> BIT(IIO_CHAN_INFO_SCALE))), +};
> >> +
> >> +#define
> >> ADC_MAP(_adc_channel_label,				\
> >
> > AXP288_ADC_MAP
> >
> >> +		     _consumer_dev_name,			\
> >> +
> >> _consumer_channel)				\
> >> +	{							\
> >> +		.adc_channel_label = _adc_channel_label,	\
> >> +		.consumer_dev_name = _consumer_dev_name,	\
> >> +		.consumer_channel =
> >> _consumer_channel,		\
> >> +	}
> >> +
> >> +/* for consumer drivers */
> >> +static struct iio_map axp288_iio_default_maps[] = {
> >
> > axp288_adc_iio_default_maps
> >
> >> +	ADC_MAP("TS_PIN", "axp288-batt", "axp288-batt-temp"),
> >> +	ADC_MAP("PMIC_TEMP", "axp288-pmic", "axp288-pmic-temp"),
> >> +	ADC_MAP("GPADC", "axp288-gpadc", "axp288-system-temp"),
> >> +	ADC_MAP("BATT_CHG_I", "axp288-chrg", "axp288-chrg-curr"),
> >> +	ADC_MAP("BATT_DISCHRG_I", "axp288-chrg",
> >> "axp288-chrg-d-curr"),
> >> +	ADC_MAP("BATT_V", "axp288-batt", "axp288-batt-volt"),
> >> +	{},
> >> +};
> >> +
> >> +static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> >> +			struct iio_chan_spec const *chan,
> >> +			int *val, int *val2, long mask)
> >> +{
> >> +	int ret;
> >> +	struct gpadc_info *info = iio_priv(indio_dev);
> >> +	unsigned int th, tl;
> >> +
> >> +	mutex_lock(&indio_dev->mlock);
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		/* special case for GPADC sample */
> >> +		if (chan->address == AXP288_GP_ADC_H)
> >> +			regmap_write(info->regmap,
> >> AXP288_ADC_TS_PIN_CTRL,
> >> +				AXP288_ADC_TS_PIN_GPADC);
> >> +		ret = regmap_read(info->regmap, chan->address,
> >> &th);
> >> +		if (ret) {
> >> +			dev_err(&indio_dev->dev, "sample raw data
> >> high failed\n");
> >> +			break;
> >> +		}
> >> +		ret = regmap_read(info->regmap, chan->address +
> >> 1, &tl);
> >> +		if (ret) {
> >> +			dev_err(&indio_dev->dev, "sample raw data
> >> low failed\n");
> >> +			break;
> >> +		}
> >> +
> >> +		*val = (th << 4) + ((tl >> 4) & 0x0F);
> >> +		ret = IIO_VAL_INT;
> >> +		break;
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val = axp288_scale[chan->channel];
> >
> > either set
> > *val2 = 0 or
> > ret = IIO_VAL_INT;
> This one. No point in misleading userspace into thinking their might
> be a decimal part sometimes. If they are as it appears all 1, then
> those channels can use IIO_CHAN_INFO_PROCESSED and skip exporting
> this at all.
> >
ditto.
> >> +		ret = IIO_VAL_INT_PLUS_MICRO;
> >> +		break;
> >> +	default:
> >> +		ret = -EINVAL;
> >> +	}
> >> +
> >> +	if (IIO_CHAN_INFO_RAW && chan->address == AXP288_GP_ADC_H)
> 
> Well, IIO_CHAN_INFO_RAW is always going to be false, so I'm guessing
> this isn't what was intended...
> mask == IIO_CHAN_INFO_RAW I would imagine.
right, good catch.
> >> +		regmap_write(info->regmap, AXP288_ADC_TS_PIN_CTRL,
> >> +			AXP288_ADC_TS_PIN_ON);
> >> +
> >> +	mutex_unlock(&indio_dev->mlock);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int axp288_gpadc_enable(struct regmap *regmap, bool enable)
> >
> > axp288_adc_enable()
> >
> >> +{
> >> +	unsigned int pin_on, adc_en;
> >> +
> >> +	if (enable) {
> >> +		pin_on = AXP288_ADC_TS_PIN_ON;
> >> +		adc_en = AXP288_ADC_EN_MASK;
> >> +	} else {
> >> +		pin_on = ~AXP288_ADC_TS_PIN_ON;
> >> +		adc_en = ~AXP288_ADC_EN_MASK;
> >> +	}
> >> +	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, pin_on))
> >> +		return -EIO;
> >> +
> >> +	return regmap_write(regmap, AXP20X_ADC_EN1,
> >> ~AXP288_ADC_EN_MASK); +}
> >> +
> >> +static const struct iio_info axp288_iio_info = {
> >
> > axp288_adc_iio_info
> or axp288_adc_info would do.
> >
ok
> >> +	.read_raw = &axp288_adc_read_raw,
> >> +	.driver_module = THIS_MODULE,
> >> +};
> >> +
> >> +static int axp288_gpadc_probe(struct platform_device *pdev)
> >
> > axp288_adc_probe()
> >
> >> +{
> >> +	int err;
> >> +	struct gpadc_info *info;
> >> +	struct iio_dev *indio_dev;
> >> +	struct axp2xx_dev *axp2xx =
> >> dev_get_drvdata(pdev->dev.parent);
> >> +	int irq;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> >> sizeof(*info));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	info = iio_priv(indio_dev);
> >> +	irq = platform_get_irq(pdev, 0);
> >
> > could save local irq variable and directly assign to info->irq
> >
> >> +	if (irq < 0) {
> >> +		dev_err(&pdev->dev, "no irq resource?\n");
> >> +		return irq;
> >> +	}
> >> +	info->irq = irq;
> >> +	platform_set_drvdata(pdev, indio_dev);
> >> +	info->regmap = axp2xx->regmap;
> >> +	axp288_gpadc_enable(axp2xx->regmap, true);
> >> +
> >> +	indio_dev->dev.parent = &pdev->dev;
> >> +	indio_dev->name = pdev->name;
> >> +	indio_dev->channels = axp288_adc_channels;
> >> +	indio_dev->num_channels = ARRAY_SIZE(axp288_adc_channels);
> >> +	indio_dev->info = &axp288_iio_info;
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +	/* REVISIT: override default map with platform data */
> >> +	err = iio_map_array_register(indio_dev,
> >> axp288_iio_default_maps);
> >> +	if (err)
> >
> > maybe err < 0, just to be consistent with below
> >
> >> +		goto err_disable_dev;
> >> +
> >> +	err = iio_device_register(indio_dev);
> >> +	if (err < 0) {
> >> +		dev_err(&pdev->dev, "unable to register iio
> >> device\n");
> >> +		goto err_array_unregister;
> >> +	}
> >> +	return 0;
> >> +
> >> +err_array_unregister:
> >> +	iio_map_array_unregister(indio_dev);
> >> +err_disable_dev:
> >> +	axp288_gpadc_enable(axp2xx->regmap, false);
> >> +	return err;
> >> +}
> >> +
> >> +static int axp288_gpadc_remove(struct platform_device *pdev)
> >> +{
> >> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >> +
> >> +	iio_device_unregister(indio_dev);
> >> +	iio_map_array_unregister(indio_dev);
> >
> > axp288_gpadc_enable(axp2xx->regmap, false);
> >
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct platform_driver axp288_gpadc_driver = {
> >> +	.probe = axp288_gpadc_probe,
> >> +	.remove = axp288_gpadc_remove,
> >> +	.driver = {
> >> +		.name = "axp288_adc",
> >> +		.owner = THIS_MODULE,
> >> +	},
> >> +};
> >> +
> >> +module_platform_driver(axp288_gpadc_driver);
> >> +
> >> +MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
> >> +MODULE_DESCRIPTION("Dollar Cove Xpower AXP288 General Purpose ADC
> >> Driver");
> >
> > X-Power
> >
> >> +MODULE_LICENSE("GPL");
> >>
> >
