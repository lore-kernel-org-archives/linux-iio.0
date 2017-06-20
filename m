Return-Path: <SRS0=rFZV=5Z=st.com=fabrice.gasnier@kernel.org>
Subject: Re: [PATCH 2/8] mfd: Add STM32 LPTimer driver
To: Lee Jones <lee.jones@linaro.org>
CC: <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
 <1497628726-7563-3-git-send-email-fabrice.gasnier@st.com>
 <20170619155106.aphrn2jxzzxszmrl@dell>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <7fb40d43-9d71-23d7-26d8-513098dd8cbd@st.com>
Date: Tue, 20 Jun 2017 17:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170619155106.aphrn2jxzzxszmrl@dell>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 06/19/2017 05:51 PM, Lee Jones wrote:
> On Fri, 16 Jun 2017, Fabrice Gasnier wrote:
>> STM32 Low Power Timer hardware block can be used for:
>> - PWM generation
>> - IIO trigger (in sync with PWM)
>> - IIO quadrature encoder counter
>> PWM and IIO timer configuration are mixed in the same registers so
>> we need a multi fonction driver to be able to share those registers.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/mfd/Kconfig               |  15 ++++++
>>  drivers/mfd/Makefile              |   1 +
>>  drivers/mfd/stm32-lptimer.c       | 110 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/stm32-lptimer.h |  55 +++++++++++++++++++
>>  4 files changed, 181 insertions(+)
>>  create mode 100644 drivers/mfd/stm32-lptimer.c
>>  create mode 100644 include/linux/mfd/stm32-lptimer.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 3eb5c93..32c1f3f 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1683,6 +1683,21 @@ config MFD_STW481X
>>  	  in various ST Microelectronics and ST-Ericsson embedded
>>  	  Nomadik series.
>>  
>> +config MFD_STM32_LPTIMER
>> +	tristate "Support for STM32 low power timer"
> 
> It think this should be "Low Power Timer" throughout.
> 
> Or even "Low-Power Timer".  You decide.

Hi Lee,

I'll pick your second proposal that also matches with reference manuals.

> 
>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP
>> +	select REGMAP_MMIO
>> +	select RESET_CONTROLLER
>> +	help
>> +	  Select this option to enable STM32 low power timer driver
>> +	  used for PWM, IIO trigger, IIO encoder and counter. This driver
> 
> "Counter"
Do you mean capital 'C' for counter (only) ?
Shall I also change "trigger" and "encoder" with capital letters too ?

> 
>> +	  allows to share the resources between these drivers.
> 
> "Shared resources are also dealt with here."  Or similar.
I'll fix it in v2.

> 
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called stm32-lptimer.
>> +
>>  config MFD_STM32_TIMERS
>>  	tristate "Support for STM32 Timers"
>>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index c16bf1e..a5308d8 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -219,5 +219,6 @@ obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
>>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>>  
>> +obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
>>  obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
>>  obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>> diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
>> new file mode 100644
>> index 0000000..fcfefa3
>> --- /dev/null
>> +++ b/drivers/mfd/stm32-lptimer.c
>> @@ -0,0 +1,110 @@
>> +/*
>> + * This file is part of STM32 low-power timer driver
> 
> This is a separate driver.  It isn't part of anything.
> 
> "STM32 Low Power Timer parent driver".
I'll fix it in v2.
> 
>> + * Copyright (C) STMicroelectronics 2017
>> + *
>> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> '\n' here.
I'll fix all missing lines in v2.
> 
>> + * Inspired from: stm32-timers from Benjamin Gaignard
> 
> "Inspired by Benjamin Gaignard's stm32-timers driver"
I'll fix it in v2.
> 
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
>> +
>> +#include <linux/mfd/stm32-lptimer.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/reset.h>
>> +
>> +static const struct regmap_config stm32_lptimer_regmap_cfg = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = sizeof(u32),
>> +	.max_register = 0x3fc,
> 
> This should be defined.
I'll fix it in v2.
> 
>> +};
>> +
>> +static int stm32_lptimer_detect_encoder(struct stm32_lptimer *ddata)
>> +{
>> +	u32 val, enc = STM32_LPTIM_ENC;
> 
> Why have enc?  Why not just use STM32_LPTIM_ENC?

This only allows to spare few lines bellow.
But I can remove it and use STM32_LPTIM_ENC instead.
Do you prefer I do this ?

> 
>> +	int ret;
>> +
>> +	/*
>> +	 * Quadrature encoder mode bit can only be written and read back when
>> +	 * LP Timer supports is.
> 
> "it"
> 
>> +	 */
>> +	ret = regmap_update_bits(ddata->regmap, STM32_LPTIM_CFGR, enc, enc);
>> +	if (ret)
>> +		return ret;
> 
> '\n' here.
> 
>> +	ret = regmap_read(ddata->regmap, STM32_LPTIM_CFGR, &val);
>> +	if (ret)
>> +		return ret;
> 
> '\n' here.
> 
>> +	ret = regmap_update_bits(ddata->regmap, STM32_LPTIM_CFGR, enc, 0);
>> +	if (ret)
>> +		return ret;
> 
> '\n' here.
> 
>> +	ddata->has_encoder = !!val;
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_lptimer_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct stm32_lptimer *ddata;
>> +	struct reset_control *rst;
> 
> This looks quite a lot like 'ret'.  Just use 'reset'.
I'll fix it in v2.
> 
>> +	struct resource *res;
>> +	void __iomem *mmio;
>> +	int ret;
>> +
>> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>> +	if (!ddata)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	mmio = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(mmio))
>> +		return PTR_ERR(mmio);
>> +
>> +	ddata->regmap = devm_regmap_init_mmio_clk(dev, "int", mmio,
> 
> Is that what the clock is called in the datasheet?

My mistake, this isn't clock name from the datasheet.
I kept same name from stm32-timers. I'll update this in v2.
In STM32H7 Reference Manual (RM0433) for, "Kernel clock distribution for
LPTIMs..." figure shows "CLKMUX" name for all LPTIM clock inputs.
It's not shown on STM32F7 (RM0385), only "low-power timer 1 clock".

Do you agree to call it "mux" here ?

> 
>> +						  &stm32_lptimer_regmap_cfg);
>> +	if (IS_ERR(ddata->regmap))
>> +		return PTR_ERR(ddata->regmap);
>> +
>> +	ddata->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(ddata->clk))
>> +		return PTR_ERR(ddata->clk);
>> +
>> +	rst = devm_reset_control_get_optional(dev, NULL);
>> +	if (IS_ERR(rst))
>> +		return PTR_ERR(rst);
>> +
>> +	if (rst) {
>> +		reset_control_assert(rst);
>> +		reset_control_deassert(rst);
>> +	}
> This is odd.  Please provide a comment as to why you're doing this.

Yes, I'll remove it in next patchset (test purpose). It has already been
reset before boot.

> 
>> +	ret = stm32_lptimer_detect_encoder(ddata);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, ddata);
>> +
>> +	return devm_of_platform_populate(&pdev->dev);
>> +}
>> +
>> +static const struct of_device_id stm32_lptimer_of_match[] = {
>> +	{ .compatible = "st,stm32-lptimer", },
>> +	{ /* end node */ },
> 
> No need for the comment.
I'll fix it in v2.
> 
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32_lptimer_of_match);
>> +
>> +static struct platform_driver stm32_lptimer_driver = {
>> +	.probe = stm32_lptimer_probe,
>> +	.driver = {
>> +		.name = "stm32-lptimer",
>> +		.of_match_table = stm32_lptimer_of_match,
>> +	},
>> +};
>> +module_platform_driver(stm32_lptimer_driver);
>> +
>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics STM32 Low Power Timer");
>> +MODULE_ALIAS("platform:stm32-lptimer");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
>> new file mode 100644
>> index 0000000..72bc9be
>> --- /dev/null
>> +++ b/include/linux/mfd/stm32-lptimer.h
>> @@ -0,0 +1,55 @@
>> +/*
>> + * This file is part of STM32 low-power timer driver
>> + *
>> + * Copyright (C) STMicroelectronics 2016
>> + *
>> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
>> + * Inspired from: stm32-timers
> 
> Same as the comments I provided for the *.c file above.
I'll fix it in v2.
> 
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
>> +
>> +#ifndef _LINUX_STM32_LPTIMER_H_
>> +#define _LINUX_STM32_LPTIMER_H_
>> +
>> +#include <linux/clk.h>
>> +#include <linux/regmap.h>
>> +
>> +#define STM32_LPTIM_ISR		0x00	/* Interrupt and Status Reg  */
>> +#define STM32_LPTIM_ICR		0x04	/* Interrupt Clear Reg       */
>> +#define STM32_LPTIM_IER		0x08	/* Interrupt Enable Reg      */
>> +#define STM32_LPTIM_CFGR	0x0C	/* Configuration Reg         */
>> +#define STM32_LPTIM_CR		0x10	/* Control Reg               */
>> +#define STM32_LPTIM_CMP		0x14	/* Compare Reg               */
>> +#define STM32_LPTIM_ARR		0x18	/* Autoreload Reg            */
>> +#define STM32_LPTIM_CNT		0x1C	/* Counter Reg               */
>> +
>> +/* STM32_LPTIM_ISR - bit fields */
>> +#define STM32_LPTIM_CMPOK_ARROK		GENMASK(4, 3)
>> +#define STM32_LPTIM_ARROK		BIT(4)
>> +#define STM32_LPTIM_CMPOK		BIT(3)
>> +
>> +/* STM32_LPTIM_ICR - bit fields */
>> +#define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
>> +
>> +/* STM32_LPTIM_CR - bit fields */
>> +#define STM32_LPTIM_CNTSTRT	BIT(2)
>> +#define STM32_LPTIM_ENABLE	BIT(0)
>> +
>> +/* STM32_LPTIM_CFGR - bit fields */
>> +#define STM32_LPTIM_ENC		BIT(24)
>> +#define STM32_LPTIM_COUNTMODE	BIT(23)
>> +#define STM32_LPTIM_WAVPOL	BIT(21)
>> +#define STM32_LPTIM_PRESC	GENMASK(11, 9)
>> +#define STM32_LPTIM_CKPOL	GENMASK(2, 1)
>> +
>> +/* STM32_LPTIM_ARR */
>> +#define STM32_LPTIM_MAX_ARR	0xFFFF
>> +
>> +struct stm32_lptimer {
>> +	struct clk *clk;
>> +	struct regmap *regmap;
>> +	bool has_encoder;
>> +};
> 
> Please provide a kerneldoc type header for this struct.

I'll fix it in v2.

Thanks for your review,
Best Regards,
Fabrice

> 
>> +#endif
> 
