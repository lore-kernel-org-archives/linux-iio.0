Return-Path: <lee.jones@linaro.org>
Date: Mon, 16 Feb 2015 13:38:29 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Message-ID: <20150216133829.GG14545@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, 24 Jan 2015, Markus Pargmann wrote:

> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpose
> ADC but one is meant to be used for touchscreens.
> 
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> the correct components.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> 
> Notes:
>     Changes in v5:
>      - Remove ifdef CONFIG_OF as this driver is only for DT usage
>      - Remove module owner
>      - Add Kconfig dependencies ARCH_MX25 and OF
>     
>     @Jonathan Cameron:
>     I left your acked-by on the patch as these were small changes. If it should be
>     removed, please say so. Thanks
> 
>  drivers/mfd/Kconfig             |  10 +++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/fsl-imx25-tsadc.c   | 167 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/imx25-tsadc.h | 140 +++++++++++++++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b7311fabc..44fc15598a6a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -232,6 +232,16 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MX25_TSADC
> +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> +	select REGMAP_MMIO
> +	depends on SOC_IMX25
> +	depends on OF
> +	help
> +	  Enable support for the integrated Touchscreen and ADC unit of the
> +	  i.MX25 processors. They consist of a conversion queue for general
> +	  purpose ADC and a queue for Touchscreens.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e211381..3feeb29f5938 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -78,6 +78,8 @@ obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
>  obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
>  obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
>  
> +obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
> +
>  obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
> new file mode 100644
> index 000000000000..8e4013d57500
> --- /dev/null
> +++ b/drivers/mfd/fsl-imx25-tsadc.c
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright 2014 Markus Pargmann, Pengutronix <mpa@pengutronix.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/imx25-tsadc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

[...]

> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> +				struct mx25_tsadc *tsadc)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {

What if 0 is returned?

> +		dev_err(dev, "Failed to get irq\n");
> +		return irq;
> +	}
> +
> +	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
> +					      tsadc);
> +	if (!tsadc->domain) {
> +		dev_err(dev, "Failed to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> +	irq_set_handler_data(irq, tsadc);
> +
> +	return 0;
> +}

> diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx25-tsadc.h
> new file mode 100644
> index 000000000000..8086f18847fe
> --- /dev/null
> +++ b/include/linux/mfd/imx25-tsadc.h
> @@ -0,0 +1,140 @@
> +#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_

INPUT?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
