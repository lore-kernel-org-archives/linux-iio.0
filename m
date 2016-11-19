Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46621 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbcKSMRM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 07:17:12 -0500
Subject: Re: [PATCH v3 2/6] iio: adc: Add support for STM32 ADC core
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
 <1479223861-21747-3-git-send-email-fabrice.gasnier@st.com>
Cc: linux@armlinux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <09b63f8e-20c8-532e-2d97-2faa6dfe7538@kernel.org>
Date: Sat, 19 Nov 2016 12:17:08 +0000
MIME-Version: 1.0
In-Reply-To: <1479223861-21747-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/11/16 15:30, Fabrice Gasnier wrote:
> Add core driver for STMicroelectronics STM32 ADC (Analog to Digital
> Converter). STM32 ADC can be composed of up to 3 ADCs with shared
> resources like clock prescaler, common interrupt line and analog
> reference voltage.
> This core driver basically manages shared resources.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

There is nothing in here that demands selecting a fixed regulator.
I've also switched the select regulator over to depends on inline with
other drivers in IIO that have a hard dependency on regulators.
Other than that which showed up during build tests, looks good to me.
Shout if I've broken anything with this change.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig          |  13 ++
>  drivers/iio/adc/Makefile         |   1 +
>  drivers/iio/adc/stm32-adc-core.c | 303 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/stm32-adc-core.h |  52 +++++++
>  4 files changed, 369 insertions(+)
>  create mode 100644 drivers/iio/adc/stm32-adc-core.c
>  create mode 100644 drivers/iio/adc/stm32-adc-core.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7edcf32..ff30239 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -419,6 +419,19 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config STM32_ADC_CORE
> +	tristate "STMicroelectronics STM32 adc core"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on OF
> +	select REGULATOR
> +	select REGULATOR_FIXED_VOLTAGE
> +	help
> +	  Select this option to enable the core driver for STMicroelectronics
> +	  STM32 analog-to-digital converter (ADC).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called stm32-adc-core.
> +
>  config STX104
>  	tristate "Apex Embedded Systems STX104 driver"
>  	depends on X86 && ISA_BUS_API
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7a40c04..a1e8f44 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>  obj-$(CONFIG_STX104) += stx104.o
> +obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> new file mode 100644
> index 0000000..4214b0c
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -0,0 +1,303 @@
> +/*
> + * This file is part of STM32 ADC driver
> + *
> + * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
> + *
> + * Inspired from: fsl-imx25-tsadc
> + *
> + * License type: GPLv2
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#include "stm32-adc-core.h"
> +
> +/* STM32F4 - common registers for all ADC instances: 1, 2 & 3 */
> +#define STM32F4_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
> +#define STM32F4_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x04)
> +
> +/* STM32F4_ADC_CSR - bit fields */
> +#define STM32F4_EOC3			BIT(17)
> +#define STM32F4_EOC2			BIT(9)
> +#define STM32F4_EOC1			BIT(1)
> +
> +/* STM32F4_ADC_CCR - bit fields */
> +#define STM32F4_ADC_ADCPRE_SHIFT	16
> +#define STM32F4_ADC_ADCPRE_MASK		GENMASK(17, 16)
> +
> +/* STM32 F4 maximum analog clock rate (from datasheet) */
> +#define STM32F4_ADC_MAX_CLK_RATE	36000000
> +
> +/**
> + * struct stm32_adc_priv - stm32 ADC core private data
> + * @irq:		irq for ADC block
> + * @domain:		irq domain reference
> + * @aclk:		clock reference for the analog circuitry
> + * @vref:		regulator reference
> + * @common:		common data for all ADC instances
> + */
> +struct stm32_adc_priv {
> +	int				irq;
> +	struct irq_domain		*domain;
> +	struct clk			*aclk;
> +	struct regulator		*vref;
> +	struct stm32_adc_common		common;
> +};
> +
> +static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
> +{
> +	return container_of(com, struct stm32_adc_priv, common);
> +}
> +
> +/* STM32F4 ADC internal common clock prescaler division ratios */
> +static int stm32f4_pclk_div[] = {2, 4, 6, 8};
> +
> +/**
> + * stm32f4_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
> + * @priv: stm32 ADC core private data
> + * Select clock prescaler used for analog conversions, before using ADC.
> + */
> +static int stm32f4_adc_clk_sel(struct platform_device *pdev,
> +			       struct stm32_adc_priv *priv)
> +{
> +	unsigned long rate;
> +	u32 val;
> +	int i;
> +
> +	rate = clk_get_rate(priv->aclk);
> +	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
> +		if ((rate / stm32f4_pclk_div[i]) <= STM32F4_ADC_MAX_CLK_RATE)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(stm32f4_pclk_div))
> +		return -EINVAL;
> +
> +	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
> +	val &= ~STM32F4_ADC_ADCPRE_MASK;
> +	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
> +	writel_relaxed(val, priv->common.base + STM32F4_ADC_CCR);
> +
> +	dev_dbg(&pdev->dev, "Using analog clock source at %ld kHz\n",
> +		rate / (stm32f4_pclk_div[i] * 1000));
> +
> +	return 0;
> +}
> +
> +/* ADC common interrupt for all instances */
> +static void stm32_adc_irq_handler(struct irq_desc *desc)
> +{
> +	struct stm32_adc_priv *priv = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 status;
> +
> +	chained_irq_enter(chip, desc);
> +	status = readl_relaxed(priv->common.base + STM32F4_ADC_CSR);
> +
> +	if (status & STM32F4_EOC1)
> +		generic_handle_irq(irq_find_mapping(priv->domain, 0));
> +
> +	if (status & STM32F4_EOC2)
> +		generic_handle_irq(irq_find_mapping(priv->domain, 1));
> +
> +	if (status & STM32F4_EOC3)
> +		generic_handle_irq(irq_find_mapping(priv->domain, 2));
> +
> +	chained_irq_exit(chip, desc);
> +};
> +
> +static int stm32_adc_domain_map(struct irq_domain *d, unsigned int irq,
> +				irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_data(irq, d->host_data);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static void stm32_adc_domain_unmap(struct irq_domain *d, unsigned int irq)
> +{
> +	irq_set_chip_and_handler(irq, NULL, NULL);
> +	irq_set_chip_data(irq, NULL);
> +}
> +
> +static const struct irq_domain_ops stm32_adc_domain_ops = {
> +	.map = stm32_adc_domain_map,
> +	.unmap  = stm32_adc_domain_unmap,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static int stm32_adc_irq_probe(struct platform_device *pdev,
> +			       struct stm32_adc_priv *priv)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0) {
> +		dev_err(&pdev->dev, "failed to get irq\n");
> +		return priv->irq;
> +	}
> +
> +	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
> +					     &stm32_adc_domain_ops,
> +					     priv);
> +	if (!priv->domain) {
> +		dev_err(&pdev->dev, "Failed to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler(priv->irq, stm32_adc_irq_handler);
> +	irq_set_handler_data(priv->irq, priv);
> +
> +	return 0;
> +}
> +
> +static void stm32_adc_irq_remove(struct platform_device *pdev,
> +				 struct stm32_adc_priv *priv)
> +{
> +	int hwirq;
> +
> +	for (hwirq = 0; hwirq < STM32_ADC_MAX_ADCS; hwirq++)
> +		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
> +	irq_domain_remove(priv->domain);
> +	irq_set_chained_handler(priv->irq, NULL);
> +}
> +
> +static int stm32_adc_probe(struct platform_device *pdev)
> +{
> +	struct stm32_adc_priv *priv;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource *res;
> +	int ret;
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->common.base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->common.base))
> +		return PTR_ERR(priv->common.base);
> +
> +	priv->vref = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR(priv->vref)) {
> +		ret = PTR_ERR(priv->vref);
> +		dev_err(&pdev->dev, "vref get failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(priv->vref);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "vref enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_get_voltage(priv->vref);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
> +		goto err_regulator_disable;
> +	}
> +	priv->common.vref_mv = ret / 1000;
> +	dev_dbg(&pdev->dev, "vref+=%dmV\n", priv->common.vref_mv);
> +
> +	priv->aclk = devm_clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(priv->aclk)) {
> +		ret = PTR_ERR(priv->aclk);
> +		dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> +		goto err_regulator_disable;
> +	}
> +
> +	ret = clk_prepare_enable(priv->aclk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "adc clk enable failed\n");
> +		goto err_regulator_disable;
> +	}
> +
> +	ret = stm32f4_adc_clk_sel(pdev, priv);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "adc clk selection failed\n");
> +		goto err_clk_disable;
> +	}
> +
> +	ret = stm32_adc_irq_probe(pdev, priv);
> +	if (ret < 0)
> +		goto err_clk_disable;
> +
> +	platform_set_drvdata(pdev, &priv->common);
> +
> +	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to populate DT children\n");
> +		goto err_irq_remove;
> +	}
> +
> +	return 0;
> +
> +err_irq_remove:
> +	stm32_adc_irq_remove(pdev, priv);
> +
> +err_clk_disable:
> +	clk_disable_unprepare(priv->aclk);
> +
> +err_regulator_disable:
> +	regulator_disable(priv->vref);
> +
> +	return ret;
> +}
> +
> +static int stm32_adc_remove(struct platform_device *pdev)
> +{
> +	struct stm32_adc_common *common = platform_get_drvdata(pdev);
> +	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
> +
> +	of_platform_depopulate(&pdev->dev);
> +	stm32_adc_irq_remove(pdev, priv);
> +	clk_disable_unprepare(priv->aclk);
> +	regulator_disable(priv->vref);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id stm32_adc_of_match[] = {
> +	{ .compatible = "st,stm32f4-adc-core" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
> +
> +static struct platform_driver stm32_adc_driver = {
> +	.probe = stm32_adc_probe,
> +	.remove = stm32_adc_remove,
> +	.driver = {
> +		.name = "stm32-adc-core",
> +		.of_match_table = stm32_adc_of_match,
> +	},
> +};
> +module_platform_driver(stm32_adc_driver);
> +
> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 ADC core driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:stm32-adc-core");
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> new file mode 100644
> index 0000000..081fa5f
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -0,0 +1,52 @@
> +/*
> + * This file is part of STM32 ADC driver
> + *
> + * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
> + *
> + * License type: GPLv2
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __STM32_ADC_H
> +#define __STM32_ADC_H
> +
> +/*
> + * STM32 - ADC global register map
> + * ________________________________________________________
> + * | Offset |                 Register                    |
> + * --------------------------------------------------------
> + * | 0x000  |                Master ADC1                  |
> + * --------------------------------------------------------
> + * | 0x100  |                Slave ADC2                   |
> + * --------------------------------------------------------
> + * | 0x200  |                Slave ADC3                   |
> + * --------------------------------------------------------
> + * | 0x300  |         Master & Slave common regs          |
> + * --------------------------------------------------------
> + */
> +#define STM32_ADC_MAX_ADCS		3
> +#define STM32_ADCX_COMN_OFFSET		0x300
> +
> +/**
> + * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
> + * @base:		control registers base cpu addr
> + * @vref_mv:		vref voltage (mv)
> + */
> +struct stm32_adc_common {
> +	void __iomem			*base;
> +	int				vref_mv;
> +};
> +
> +#endif
> 

