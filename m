Return-Path: <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
To: Lee Jones <lee.jones@linaro.org>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, maxime.ripard@free-electrons.com,
 wens@csie.org, thomas.petazzoni@free-electrons.com,
 antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
Date: Mon, 12 Sep 2016 11:43:51 +0200
MIME-Version: 1.0
In-Reply-To: <20160912091829.GB1873@dell>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 12/09/2016 11:18, Lee Jones wrote:
> On Thu, 08 Sep 2016, Quentin Schulz wrote:
> 
[...]
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called sun4i-gpadc-mfd.
> 
> Drop the -mfd.
> 
>>  config MFD_AS3711
>>  	bool "AMS AS3711"
>>  	select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 42a66e1..3b964d7 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -205,3 +205,5 @@ intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
>>  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
>>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>> +
>> +obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc-mfd.o
>> diff --git a/drivers/mfd/sun4i-gpadc-mfd.c b/drivers/mfd/sun4i-gpadc-mfd.c
>> new file mode 100644
>> index 0000000..b499545
>> --- /dev/null
>> +++ b/drivers/mfd/sun4i-gpadc-mfd.c
> 
> Drop the -mfd.
> 
>> @@ -0,0 +1,174 @@
>> +/* ADC MFD core driver for sunxi platforms
>> + *
>> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/mfd/sun4i-gpadc-mfd.h>
>> +
>> +static struct resource adc_resources[] = {
>> +	{
>> +		.name	= "FIFO_DATA_PENDING",
>> +		.start	= SUN4I_GPADC_IRQ_FIFO_DATA,
>> +		.end	= SUN4I_GPADC_IRQ_FIFO_DATA,
>> +		.flags	= IORESOURCE_IRQ,
>> +	}, {
>> +		.name	= "TEMP_DATA_PENDING",
>> +		.start	= SUN4I_GPADC_IRQ_TEMP_DATA,
>> +		.end	= SUN4I_GPADC_IRQ_TEMP_DATA,
>> +		.flags	= IORESOURCE_IRQ,
>> +	},
>> +};
> 
> Use the RES_IRQ_* defines.
> 
>> +static const struct regmap_irq sun4i_gpadc_mfd_regmap_irq[] = {
>> +	REGMAP_IRQ_REG(SUN4I_GPADC_IRQ_FIFO_DATA, 0,
>> +		       SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN),
>> +	REGMAP_IRQ_REG(SUN4I_GPADC_IRQ_TEMP_DATA, 0,
>> +		       SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN),
>> +};
>> +
>> +static const struct regmap_irq_chip sun4i_gpadc_mfd_regmap_irq_chip = {
>> +	.name = "sun4i_gpadc_mfd_irq_chip",
>> +	.status_base = SUN4I_GPADC_INT_FIFOS,
>> +	.ack_base = SUN4I_GPADC_INT_FIFOS,
>> +	.mask_base = SUN4I_GPADC_INT_FIFOC,
>> +	.init_ack_masked = true,
>> +	.mask_invert = true,
>> +	.irqs = sun4i_gpadc_mfd_regmap_irq,
>> +	.num_irqs = ARRAY_SIZE(sun4i_gpadc_mfd_regmap_irq),
>> +	.num_regs = 1,
>> +};
>> +
>> +static struct mfd_cell sun4i_gpadc_mfd_cells[] = {
>> +	{
>> +		.name	= "sun4i-a10-gpadc-iio",
>> +		.resources = adc_resources,
>> +		.num_resources = ARRAY_SIZE(adc_resources),
>> +	}, {
>> +		.name = "iio_hwmon",
>> +	}
> 
> Single line please
> 
> { .name = "iio_hwmon" }
>

+	{
+		.name	= "sun4i-a10-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	}, { .name = "iio_hwmon" }

or

+	{
+		.name	= "sun4i-a10-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	},
+	{ .name = "iio_hwmon" }

?
>> +};
>> +
>> +static struct mfd_cell sun5i_gpadc_mfd_cells[] = {
>> +	{
>> +		.name	= "sun5i-a13-gpadc-iio",
>> +		.resources = adc_resources,
>> +		.num_resources = ARRAY_SIZE(adc_resources),
>> +	}, {
>> +		.name = "iio_hwmon",
>> +	},
>> +};
> 
> As above.
> 
>> +static struct mfd_cell sun6i_gpadc_mfd_cells[] = {
>> +	{
>> +		.name	= "sun6i-a31-gpadc-iio",
>> +		.resources = adc_resources,
>> +		.num_resources = ARRAY_SIZE(adc_resources),
>> +	}, {
>> +		.name = "iio_hwmon",
>> +	},
>> +};
> 
> As above.
> 
>> +static const struct regmap_config sun4i_gpadc_mfd_regmap_config = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = 4,
>> +	.fast_io = true,
>> +};
>> +
>> +static const struct of_device_id sun4i_gpadc_mfd_of_match[] = {
>> +	{
>> +		.compatible = "allwinner,sun4i-a10-ts",
>> +		.data = &sun4i_gpadc_mfd_cells,
>> +	}, {
>> +		.compatible = "allwinner,sun5i-a13-ts",
>> +		.data = &sun5i_gpadc_mfd_cells,
>> +	}, {
>> +		.compatible = "allwinner,sun6i-a31-ts",
>> +		.data = &sun6i_gpadc_mfd_cells,
>> +	}, { /* sentinel */ }
>> +};
> 
> Don't mix OF and MFD functionality.
> 
> Why don't you create a node for "iio_hwmon" and have
> platform_of_populate() do your bidding?
> 

We are using a stable binding which we cannot modify. This means, the DT
in its current state can only be modified to add features, which is not
the case of this driver (it is a rewriting of an existing driver which
uses the rtp node).

>> +static int sun4i_gpadc_mfd_probe(struct platform_device *pdev)
> 
> Remove all mention of "mfd" from this file.
> 
> (Accept the calls to the MFD API of course).
> 
[...]
>> +
>> +MODULE_DEVICE_TABLE(of, sun4i_gpadc_mfd_of_match);
> 
> Place this directly under the table.
> 
>> +static struct platform_driver sun4i_gpadc_mfd_driver = {
>> +	.driver = {
>> +		.name = "sun4i-adc-mfd",
>> +		.of_match_table = of_match_ptr(sun4i_gpadc_mfd_of_match),
>> +	},
>> +	.probe = sun4i_gpadc_mfd_probe,
> 
> No .remove?
> 

No, everything in probe is handled with devm functions.

[...]
>> +struct sun4i_gpadc_mfd_dev {
>> +	struct device			*dev;
>> +	struct regmap			*regmap;
>> +	struct regmap_irq_chip_data	*regmap_irqc;
>> +	void __iomem			*regs;
> 
> It's *much* more common to call this 'base'.
> 
>> +};
>> +
>> +#endif
> 

ACK for everything else.

Thanks,
Quentin
