Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30977 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbaIKMFz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Sep 2014 08:05:55 -0400
Date: Thu, 11 Sep 2014 05:05:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: IIO <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: Re: [PATCH v2 4/4] iio/adc/axp288: add support for axp288 gpadc
Message-ID: <20140911050513.31206b36@ultegra>
In-Reply-To: <alpine.DEB.2.01.1409091509110.26919@pmeerw.net>
References: <1410267775-4683-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1410267775-4683-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.01.1409091509110.26919@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 9 Sep 2014 15:46:31 +0200 (CEST)
Peter Meerwald <pmeerw@pmeerw.net> wrote:

> Hello,
> 
> > Platform driver for XPowers AXP288 ADC, which is a customized PMIC
> > for Intel
> 
> XPower's
> 
> > Baytrail-CR platforms. GPADC device enumerates as one of the PMIC
> > MFD cell devices. It uses IIO infrastructure to communicate with
> > userspace and consumer drivers.
> > 
> > Usages of ADC channels include battery charging and thermal sensors.
> > 
> > Based on initial work by:
> > Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> 
> some trivial comments inline
> 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iio/adc/Kconfig        |   8 ++
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/axp288_gpadc.c | 250
> > +++++++++++++++++++++++++++++++++++++++++ 3 files changed, 259
> > insertions(+) create mode 100644 drivers/iio/adc/axp288_gpadc.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 11b048a..f5c61c0 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -279,4 +279,12 @@ config XILINX_XADC
> >  	  The driver can also be build as a module. If so, the
> > module will be called xilinx-xadc.
> >  
> > +config AXP288_GPADC
> 
> alphabetic order please
> 
will do.
> > +	tristate "X-Power AXP288 GPADC driver"
> 
> XPower
> 
Acutally, their datasheet uses "X-Powers".
> > +	depends on MFD_AXP2XX
> > +	help
> > +	  Say yes here to have support for X-Power power
> > management IC (PMIC) ADC
> > +	  device. Depending on platform configuration, this
> > general purpose ADC can
> > +	  be used for sampling sensors such as thermal resisters.
> 
> resistors
> 
> > +
> >  endmenu
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index ad81b51..8bf0104 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -30,3 +30,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> >  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
> >  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> > +obj-$(CONFIG_AXP288_GPADC) += axp288_gpadc.o
> > diff --git a/drivers/iio/adc/axp288_gpadc.c
> > b/drivers/iio/adc/axp288_gpadc.c new file mode 100644
> > index 0000000..7ca6bbf
> > --- /dev/null
> > +++ b/drivers/iio/adc/axp288_gpadc.c
> > @@ -0,0 +1,250 @@
> > +/*
> > + * axp288_gpadc.c - Xpower AXP288 PMIC GPADC Driver
> > + *
> > + * Copyright (C) 2014 Intel Corporation
> > + *
> > + *
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify
> > + * it under the terms of the GNU General Public License as
> > published by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See
> > the GNU
> > + * General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/axp2xx.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/iio/driver.h>
> 
> newline
> 
> > +#define ADC_EN_MASK			0xF1
> > +#define ADC_TS_PIN_GPADC                0xF2
> > +#define ADC_TS_PIN_ON                   0xF3
> 
> use a likely unique prefix for all #defines, functions, e.g.
> AXP288_ADC_
> 
ok.
> > +
> > +struct gpadc_info {
> > +	unsigned int irq;
> 
> irq is 'int' in _probe()
> 
right, will fix
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +};
> > +
> > +#define ADC_CHANNEL(_type, _channel, _address)	        \
> > +
> > {								\
> > +		.indexed =
> > 1,						\
> > +		.type =
> > _type,						\
> > +		.channel =
> > _channel,					\
> > +		.address =
> > _address,					\
> > +		.datasheet_name =
> > "CH"#_channel,			\
> > +		.scan_index =
> > _channel,					\
> 
> driver doesn't offer buffered interface, so no scan_index, scan_type 
> needed
> 
good point.
> > +		.scan_type =
> > {						\
> > +			.sign =
> > 'u',					\
> > +			.realbits =
> > 12,					\
> > +			.storagebits =
> > 32,				\
> > +			.endianness =
> > IIO_LE,				\
> > +		},
> > \
> > +		.info_mask_separate =
> > BIT(IIO_CHAN_INFO_RAW),		\
> > +	}
> > +
> > +static const struct iio_chan_spec const axp288_adc_channels[] = {
> > +	ADC_CHANNEL(IIO_TEMP, 0, AXP288_TS_ADC_H),
> > +	ADC_CHANNEL(IIO_TEMP, 1, AXP288_PMIC_ADC_H),
> > +	ADC_CHANNEL(IIO_TEMP, 2, AXP288_GP_ADC_H),
> 
> what unit are these values in?
> IIO wants milli degrees Celsius
> 
the consumer of these channels are kernel drivers. so i will remove
them from sysfs. the consumer drivers knows the scale. e.g. the final
system board temperature is read by ACPI opregion handler then to a
ACPI INT3403 thermal zone driver under /sys/class/thermal/, so the unit
is converted there.
> > +	ADC_CHANNEL(IIO_CURRENT, 3, AXP20X_BATT_CHRG_I_H),
> > +	ADC_CHANNEL(IIO_CURRENT, 4, AXP20X_BATT_DISCHRG_I_H),
> 
> there are no current channels documented in 
> Documentation/ABI/testing/sysfs-bus-iio yet, need to describe
> 
> what unit?
> 
will do. they are mV and mA
> > +	ADC_CHANNEL(IIO_VOLTAGE, 5, AXP20X_BATT_V_H),
> > +};
> > +
> > +#define ADC_MAP(_adc_channel_label,
> > \
> > +		     _consumer_dev_name,			\
> > +
> > _consumer_channel)				\
> > +	{							\
> > +		.adc_channel_label = _adc_channel_label,	\
> > +		.consumer_dev_name = _consumer_dev_name,	\
> > +		.consumer_channel =
> > _consumer_channel,		\
> > +	}
> > +
> > +/* for consumer drivers */
> 
> const probably
iio_map_array_register() does not take const

thanks for the review.

Jacob
> 
> > +static struct iio_map axp288_iio_default_maps[] = {
> > +	ADC_MAP("TS_PIN", "axp288-batt", "axp288-batt-temp"),
> > +	ADC_MAP("PMIC_TEMP", "axp288-pmic", "axp288-pmic-temp"),
> > +	ADC_MAP("GPADC", "axp288-gpadc", "axp288-system-temp"),
> > +	ADC_MAP("BATT_CHG_I", "axp288-chrg", "axp288-chrg-curr"),
> > +	ADC_MAP("BATT_DISCHRG_I", "axp288-chrg",
> > "axp288-chrg-d-curr"),
> > +	ADC_MAP("BATT_V", "axp288-batt", "axp288-batt-volt"),
> > +	{},
> > +};
> > +
> > +static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan,
> > +			int *val, int *val2, long m)
> > +{
> > +	int ret;
> > +	struct gpadc_info *info = iio_priv(indio_dev);
> > +	unsigned int th, tl;
> > +
> > +	mutex_lock(&indio_dev->mlock);
> > +
> > +	/* special case for GPADC sample */
> > +	if (chan->address == AXP288_GP_ADC_H)
> > +		regmap_write(info->regmap, AXP288_ADC_TS_PIN_CTRL,
> > +			ADC_TS_PIN_GPADC);
> > +
> > +	ret = regmap_read(info->regmap, chan->address, &th);
> > +	if (ret) {
> > +		dev_err(&indio_dev->dev, "sample raw data high
> > failed\n");
> > +		goto exit_done;
> > +	}
> > +
> > +	ret = regmap_read(info->regmap, chan->address + 1, &tl);
> > +	if (ret) {
> > +		dev_err(&indio_dev->dev, "sample raw data low
> > failed\n");
> > +		goto exit_done;
> > +	}
> > +
> > +	*val = (th << 4) + ((tl >> 4) & 0x0F);
> > +	ret = IIO_VAL_INT;
> > +
> > +exit_done:
> > +	if (chan->address == AXP288_GP_ADC_H)
> > +		regmap_write(info->regmap, AXP288_ADC_TS_PIN_CTRL,
> > +			ADC_TS_PIN_ON);
> > +
> > +	mutex_unlock(&indio_dev->mlock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int axp288_gpadc_enable(struct regmap *regmap, bool enable)
> > +{
> > +	unsigned int pin_on, adc_en;
> > +
> > +	if (enable) {
> > +		pin_on = ADC_TS_PIN_ON;
> > +		adc_en = ADC_EN_MASK;
> > +	} else {
> > +		pin_on = ~ADC_TS_PIN_ON;
> > +		adc_en = ~ADC_EN_MASK;
> > +	}
> > +	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, pin_on))
> > +		return -EIO;
> > +
> > +	return regmap_write(regmap, AXP20X_ADC_EN1, ~ADC_EN_MASK);
> > +}
> > +
> > +static const struct iio_info axp288_iio_info = {
> > +	.read_raw = &axp288_adc_read_raw,
> > +	.driver_module = THIS_MODULE,
> > +};
> > +
> > +static int axp288_gpadc_probe(struct platform_device *pdev)
> > +{
> > +	int err;
> > +	struct gpadc_info *info;
> > +	struct iio_dev *indio_dev;
> > +	struct axp2xx_dev *axp2xx =
> > dev_get_drvdata(pdev->dev.parent);
> > +	int irq;
> > +
> > +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> > sizeof(*info));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	info = iio_priv(indio_dev);
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "no irq resource?\n");
> > +		return irq;
> > +	}
> > +	info->irq = irq;
> > +	platform_set_drvdata(pdev, indio_dev);
> > +	info->regmap = axp2xx->regmap;
> > +	axp288_gpadc_enable(axp2xx->regmap, true);
> > +
> > +	indio_dev->dev.parent = &pdev->dev;
> > +	indio_dev->name = pdev->name;
> > +	indio_dev->channels = axp288_adc_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(axp288_adc_channels);
> > +	indio_dev->info = &axp288_iio_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	/* REVISIT: override default map with platform data */
> > +	err = iio_map_array_register(indio_dev,
> > axp288_iio_default_maps);
> > +	if (err)
> > +		goto err_disable_dev;
> > +
> > +	err = iio_device_register(indio_dev);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "unable to register iio
> > device\n");
> > +		goto err_array_unregister;
> > +	}
> > +	return 0;
> > +
> > +err_array_unregister:
> > +	iio_map_array_unregister(indio_dev);
> > +err_disable_dev:
> > +	axp288_gpadc_enable(axp2xx->regmap, false);
> > +	return err;
> > +}
> > +
> > +static int axp288_gpadc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	iio_map_array_unregister(indio_dev);
> 
> axp288_gpadc_enable(axp2xx->regmap, false);
> 
> > +
> > +	return 0;
> > +}
> > +
> > +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> > +static int axp288_gpadc_suspend(struct device *dev)
> > +{
> > +	int ret;
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct gpadc_info *info = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&indio_dev->mlock);
> > +	ret = axp288_gpadc_enable(info->regmap, false);
> > +	mutex_unlock(&indio_dev->mlock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int axp288_gpadc_resume(struct device *dev)
> > +{
> > +	int ret;
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct gpadc_info *info = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&indio_dev->mlock);
> > +	ret = axp288_gpadc_enable(info->regmap, true);
> > +	mutex_unlock(&indio_dev->mlock);
> > +
> > +	return ret;
> > +}
> > +#endif
> > +
> > +static UNIVERSAL_DEV_PM_OPS(axp288_gpadc_pm_ops,
> > axp288_gpadc_suspend,
> > +			axp288_gpadc_resume, NULL);
> > +
> > +static struct platform_driver axp288_gpadc_driver = {
> > +	.probe = axp288_gpadc_probe,
> > +	.remove = axp288_gpadc_remove,
> > +	.driver = {
> > +		.name = "axp288_adc",
> > +		.owner = THIS_MODULE,
> > +		.pm = &axp288_gpadc_pm_ops,
> > +	},
> > +};
> > +
> > +module_platform_driver(axp288_gpadc_driver);
> > +
> > +MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
> > +MODULE_DESCRIPTION("Dollar Cove Xpower AXP288 General Purpose ADC
> > Driver"); +MODULE_LICENSE("GPL");
> > 
> 

[Jacob Pan]
