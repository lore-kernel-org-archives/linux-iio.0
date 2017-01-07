Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42979 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937432AbdAHJs1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:27 -0500
Subject: Re: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d6661ff6-442c-5535-aec2-35066577f119@kernel.org>
Date: Sat, 7 Jan 2017 14:31:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170102163723.7939-9-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/17 11:37, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
> 
> Moreover, the AXP20X can also expose the current current and voltage
> values of the AC power supply.
> 
> This adds the driver which exposes the status of the AC power supply of
> the AXP20X and AXP22X PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
For the IIO bits
Acked-by: Jonathan Cameron <jic23@kernel.org>

Trivial comment inline.
> ---
>  drivers/power/supply/Kconfig           |  12 ++
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/axp20x_ac_power.c | 251 +++++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/power/supply/axp20x_ac_power.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..c552b4b 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -214,6 +214,18 @@ config BATTERY_DA9150
>  	  This driver can also be built as a module. If so, the module will be
>  	  called da9150-fg.
>  
> +config CHARGER_AXP20X
> +	tristate "X-Powers AXP20X and AXP22X AC power supply driver"
> +	depends on MFD_AXP20X
> +	depends on AXP20X_ADC
> +	depends on IIO
> +	help
> +	  Say Y here to enable support for X-Powers AXP20X and AXP22X PMICs' AC
> +	  power supply.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called axp20x_ac_power.
> +
>  config AXP288_CHARGER
>  	tristate "X-Powers AXP288 Charger"
>  	depends on MFD_AXP20X && EXTCON_AXP288
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 36c599d..7d22417 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_TEST_POWER)	+= test_power.o
>  
>  obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
>  obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
> +obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
>  obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
>  obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
>  obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
> new file mode 100644
> index 0000000..d7bc25c
> --- /dev/null
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -0,0 +1,251 @@
> +/*
> + * AXP20X and AXP22X PMICs' ACIN power supply driver
> + *
> + * Copyright (C) 2016 Free Electrons
> + *	Quentin Schulz <quentin.schulz@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under  the terms of the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/iio/consumer.h>
> +
> +#define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
> +#define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
> +
> +#define DRVNAME "axp20x-ac-power-supply"
> +
> +struct axp20x_ac_power {
> +	struct device_node *np;
> +	struct regmap *regmap;
> +	struct power_supply *supply;
> +	int axp20x_id;
> +	struct iio_channel *acin_v;
> +	struct iio_channel *acin_i;
> +};
> +
> +static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
> +{
> +	struct axp20x_ac_power *power = devid;
> +
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int axp20x_ac_power_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
> +	int ret, reg;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (reg & AXP20X_PWR_STATUS_ACIN_PRESENT) {
> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +			return 0;
> +		}
> +
> +		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = !!(reg & AXP20X_PWR_STATUS_ACIN_PRESENT);
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = !!(reg & AXP20X_PWR_STATUS_ACIN_AVAIL);
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = iio_read_channel_processed(power->acin_v, &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * IIO framework gives mV but Power Supply framework gives µV.
> +		 */
single line comment syntax throughout or we'll have to face a patch 'fixing' it.
> +		val->intval *= 1000;
> +
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret = iio_read_channel_processed(power->acin_i, &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * IIO framework gives mV but Power Supply framework gives µV.
> +		 */
> +		val->intval *= 1000;
> +
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static enum power_supply_property axp20x_ac_power_properties[] = {
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static enum power_supply_property axp22x_ac_power_properties[] = {
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc axp20x_ac_power_desc = {
> +	.name = "axp20x-ac",
> +	.type = POWER_SUPPLY_TYPE_MAINS,
> +	.properties = axp20x_ac_power_properties,
> +	.num_properties = ARRAY_SIZE(axp20x_ac_power_properties),
> +	.get_property = axp20x_ac_power_get_property,
> +};
> +
> +static const struct power_supply_desc axp22x_ac_power_desc = {
> +	.name = "axp22x-ac",
> +	.type = POWER_SUPPLY_TYPE_MAINS,
> +	.properties = axp22x_ac_power_properties,
> +	.num_properties = ARRAY_SIZE(axp22x_ac_power_properties),
> +	.get_property = axp20x_ac_power_get_property,
> +};
> +
> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg = {};
> +	struct axp20x_ac_power *power;
> +	static const char * const axp20x_irq_names[] = { "ACIN_PLUGIN",
> +		"ACIN_REMOVAL", NULL };
> +	static const char * const *irq_names;
> +	const struct power_supply_desc *ac_power_desc;
> +	int i, irq, ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	if (!axp20x) {
> +		dev_err(&pdev->dev, "Parent drvdata not set\n");
> +		return -EINVAL;
> +	}
> +
> +	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +	if (!power)
> +		return -ENOMEM;
> +
> +	power->axp20x_id = (int)of_device_get_match_data(&pdev->dev);
> +
> +	irq_names = axp20x_irq_names;
> +
> +	if (power->axp20x_id == AXP202_ID) {
> +		ac_power_desc = &axp20x_ac_power_desc;
> +
> +		power->acin_v = devm_iio_channel_get(&pdev->dev, "acin_v");
> +		if (IS_ERR(power->acin_v)) {
> +			if (PTR_ERR(power->acin_v) == -ENODEV)
> +				return -EPROBE_DEFER;
> +			return PTR_ERR(power->acin_v);
> +		}
> +
> +		power->acin_i = devm_iio_channel_get(&pdev->dev, "acin_i");
> +		if (IS_ERR(power->acin_i)) {
> +			if (PTR_ERR(power->acin_i) == -ENODEV)
> +				return -EPROBE_DEFER;
> +			return PTR_ERR(power->acin_i);
> +		}
> +	} else {
> +		ac_power_desc = &axp22x_ac_power_desc;
> +	}
> +
> +	power->np = pdev->dev.of_node;
> +	power->regmap = axp20x->regmap;
> +
> +	platform_set_drvdata(pdev, power);
> +
> +	psy_cfg.of_node = pdev->dev.of_node;
> +	psy_cfg.drv_data = power;
> +
> +	power->supply = devm_power_supply_register(&pdev->dev, ac_power_desc,
> +						   &psy_cfg);
> +	if (IS_ERR(power->supply))
> +		return PTR_ERR(power->supply);
> +
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i = 0; irq_names[i]; i++) {
> +		irq = platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +		ret = devm_request_any_context_irq(&pdev->dev, irq,
> +						   axp20x_ac_power_irq, 0,
> +						   DRVNAME, power);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axp20x_ac_power_match[] = {
> +	{
> +		.compatible = "x-powers,axp202-ac-power-supply",
> +		.data = (void *)AXP202_ID,
> +	}, {
> +		.compatible = "x-powers,axp221-ac-power-supply",
> +		.data = (void *)AXP221_ID,
> +	}, { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> +
> +static struct platform_driver axp20x_ac_power_driver = {
> +	.probe = axp20x_ac_power_probe,
> +	.driver = {
> +		.name = DRVNAME,
> +		.of_match_table = axp20x_ac_power_match,
> +	},
> +};
> +
> +module_platform_driver(axp20x_ac_power_driver);
> +
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_DESCRIPTION("AXP20X and AXP22X PMICs' AC power supply driver");
> +MODULE_LICENSE("GPL");
> 

