Return-Path: <SRS0=ViTE=53=linaro.org=lee.jones@kernel.org>
Date: Thu, 22 Jun 2017 16:44:42 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org,
	thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
	alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
	benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] mfd: Add STM32 LPTimer driver
Message-ID: <20170622154442.ettmcvzo7znu3scn@dell>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1498055415-31513-3-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 21 Jun 2017, Fabrice Gasnier wrote:

> STM32 Low-Power Timer hardware block can be used for:
> - PWM generation
> - IIO trigger (in sync with PWM)
> - IIO quadrature encoder counter
> PWM and IIO timer configuration are mixed in the same registers so
> we need a multi fonction driver to be able to share those registers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Lee's remarks: various comments, max register define, s/Low Power/Low-Power,
>   clock name, removed reset, add kernel doc for stm32_lptimer struct
> ---
>  drivers/mfd/Kconfig               |  14 +++++
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/stm32-lptimer.c       | 107 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-lptimer.h |  62 ++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/mfd/stm32-lptimer.c
>  create mode 100644 include/linux/mfd/stm32-lptimer.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3eb5c93..8e1ca44 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1683,6 +1683,20 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
>  
> +config MFD_STM32_LPTIMER
> +	tristate "Support for STM32 Low-Power Timer"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable STM32 Low-Power Timer driver
> +	  used for PWM, IIO Trigger, IIO Encoder and Counter. Shared
> +	  resources are also dealt with here.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stm32-lptimer.
> +
>  config MFD_STM32_TIMERS
>  	tristate "Support for STM32 Timers"
>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c16bf1e..a5308d8 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -219,5 +219,6 @@ obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>  
> +obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
>  obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
>  obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
> diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
> new file mode 100644
> index 0000000..075330a
> --- /dev/null
> +++ b/drivers/mfd/stm32-lptimer.c
> @@ -0,0 +1,107 @@
> +/*
> + * STM32 Low-Power Timer parent driver.
> + *
> + * Copyright (C) STMicroelectronics 2017
> + *
> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
> + *
> + * Inspired by Benjamin Gaignard's stm32-timers driver
> + *
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/mfd/stm32-lptimer.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +
> +#define STM32_LPTIM_MAX_REGISTER	0x3fc
> +
> +static const struct regmap_config stm32_lptimer_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = STM32_LPTIM_MAX_REGISTER,
> +};
> +
> +static int stm32_lptimer_detect_encoder(struct stm32_lptimer *ddata)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Quadrature encoder mode bit can only be written and read back when
> +	 * Low-Power Timer supports it.
> +	 */
> +	ret = regmap_update_bits(ddata->regmap, STM32_LPTIM_CFGR,
> +				 STM32_LPTIM_ENC, STM32_LPTIM_ENC);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(ddata->regmap, STM32_LPTIM_CFGR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(ddata->regmap, STM32_LPTIM_CFGR,
> +				 STM32_LPTIM_ENC, 0);
> +	if (ret)
> +		return ret;
> +
> +	ddata->has_encoder = !!(val & STM32_LPTIM_ENC);
> +
> +	return 0;
> +}
> +
> +static int stm32_lptimer_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stm32_lptimer *ddata;
> +	struct resource *res;
> +	void __iomem *mmio;
> +	int ret;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mmio = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(mmio))
> +		return PTR_ERR(mmio);
> +
> +	ddata->regmap = devm_regmap_init_mmio_clk(dev, "mux", mmio,
> +						  &stm32_lptimer_regmap_cfg);
> +	if (IS_ERR(ddata->regmap))
> +		return PTR_ERR(ddata->regmap);
> +
> +	ddata->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return PTR_ERR(ddata->clk);
> +
> +	ret = stm32_lptimer_detect_encoder(ddata);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static const struct of_device_id stm32_lptimer_of_match[] = {
> +	{ .compatible = "st,stm32-lptimer", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_lptimer_of_match);
> +
> +static struct platform_driver stm32_lptimer_driver = {
> +	.probe = stm32_lptimer_probe,
> +	.driver = {
> +		.name = "stm32-lptimer",
> +		.of_match_table = stm32_lptimer_of_match,
> +	},
> +};
> +module_platform_driver(stm32_lptimer_driver);
> +
> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 Low-Power Timer");
> +MODULE_ALIAS("platform:stm32-lptimer");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
> new file mode 100644
> index 0000000..77c7cf4
> --- /dev/null
> +++ b/include/linux/mfd/stm32-lptimer.h
> @@ -0,0 +1,62 @@
> +/*
> + * STM32 Low-Power Timer parent driver.
> + *
> + * Copyright (C) STMicroelectronics 2017
> + *
> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
> + *
> + * Inspired by Benjamin Gaignard's stm32-timers driver
> + *
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef _LINUX_STM32_LPTIMER_H_
> +#define _LINUX_STM32_LPTIMER_H_
> +
> +#include <linux/clk.h>
> +#include <linux/regmap.h>
> +
> +#define STM32_LPTIM_ISR		0x00	/* Interrupt and Status Reg  */
> +#define STM32_LPTIM_ICR		0x04	/* Interrupt Clear Reg       */
> +#define STM32_LPTIM_IER		0x08	/* Interrupt Enable Reg      */
> +#define STM32_LPTIM_CFGR	0x0C	/* Configuration Reg         */
> +#define STM32_LPTIM_CR		0x10	/* Control Reg               */
> +#define STM32_LPTIM_CMP		0x14	/* Compare Reg               */
> +#define STM32_LPTIM_ARR		0x18	/* Autoreload Reg            */
> +#define STM32_LPTIM_CNT		0x1C	/* Counter Reg               */
> +
> +/* STM32_LPTIM_ISR - bit fields */
> +#define STM32_LPTIM_CMPOK_ARROK		GENMASK(4, 3)
> +#define STM32_LPTIM_ARROK		BIT(4)
> +#define STM32_LPTIM_CMPOK		BIT(3)
> +
> +/* STM32_LPTIM_ICR - bit fields */
> +#define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
> +
> +/* STM32_LPTIM_CR - bit fields */
> +#define STM32_LPTIM_CNTSTRT	BIT(2)
> +#define STM32_LPTIM_ENABLE	BIT(0)
> +
> +/* STM32_LPTIM_CFGR - bit fields */
> +#define STM32_LPTIM_ENC		BIT(24)
> +#define STM32_LPTIM_COUNTMODE	BIT(23)
> +#define STM32_LPTIM_WAVPOL	BIT(21)
> +#define STM32_LPTIM_PRESC	GENMASK(11, 9)
> +#define STM32_LPTIM_CKPOL	GENMASK(2, 1)
> +
> +/* STM32_LPTIM_ARR */
> +#define STM32_LPTIM_MAX_ARR	0xFFFF
> +
> +/**
> + * struct stm32_lptimer - STM32 Low-Power Timer data assigned by parent device
> + * @clk: clock reference for this instance
> + * @regmap: register map reference for this instance
> + * @has_encoder: indicates this Low-Power Timer supports encoder mode
> + */
> +struct stm32_lptimer {
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	bool has_encoder;
> +};
> +
> +#endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
