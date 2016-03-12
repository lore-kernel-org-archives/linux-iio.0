Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43496 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbcCLKfv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 05:35:51 -0500
Subject: Re: [PATCH v2 1/4] iio: adc: add NXP LPC18xx ADC driver
To: Joachim Eastwood <manabian@gmail.com>
References: <1457262795-20282-1-git-send-email-manabian@gmail.com>
 <1457262795-20282-2-git-send-email-manabian@gmail.com>
 <56E3EFAC.8090906@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3F104.20105@kernel.org>
Date: Sat, 12 Mar 2016 10:35:48 +0000
MIME-Version: 1.0
In-Reply-To: <56E3EFAC.8090906@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/16 10:30, Jonathan Cameron wrote:
> On 06/03/16 11:13, Joachim Eastwood wrote:
>> Add base support for the 10-bit SAR ADC peripheral found
>> on NXP LPC18xx/43xx SoCs.
>>
>> This is a minimal driver that does not support burst mode,
>> interrupts, DMA or hardware triggers.
>>
>> User manual with register description can be found on:
>> LPC18xx: www.nxp.com/documents/user_manual/UM10430.pdf
>> LPC43xx: www.nxp.com/documents/user_manual/UM10503.pdf
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Applied to the togreg branch of iio.git - initially pushed out as testing
> for the autobuilders to play with it.
Actually I've backed this out.  Picked up on a few things lookint
at the DAC driver that apply here too.

Clearly half asleep this morning!

Sorry,

Jonathan
> 
> Thanks,
> 
> Jonathan
>> ---
>>  drivers/iio/adc/Kconfig       |  10 ++
>>  drivers/iio/adc/Makefile      |   1 +
>>  drivers/iio/adc/lpc18xx_adc.c | 228 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 239 insertions(+)
>>  create mode 100644 drivers/iio/adc/lpc18xx_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 932de1f9d1e7..85994e5889ec 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -234,6 +234,16 @@ config LP8788_ADC
>>  	  To compile this driver as a module, choose M here: the module will be
>>  	  called lp8788_adc.
>>  
>> +config LPC18XX_ADC
>> +	tristate "NXP LPC18xx ADC driver"
>> +	depends on ARCH_LPC18XX || COMPILE_TEST
>> +	depends on OF && HAS_IOMEM
>> +	help
>> +	  Say yes here to build support for NXP LPC18XX ADC.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called lpc18xx_adc.
>> +
>>  config MAX1027
>>  	tristate "Maxim max1027 ADC driver"
>>  	depends on SPI
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index b1aa456e6af3..1a4ac4590857 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -24,6 +24,7 @@ obj-$(CONFIG_HI8435) += hi8435.o
>>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>> +obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>>  obj-$(CONFIG_MAX1027) += max1027.o
>>  obj-$(CONFIG_MAX1363) += max1363.o
>>  obj-$(CONFIG_MCP320X) += mcp320x.o
>> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
>> new file mode 100644
>> index 000000000000..fbe9b7a7e6b8
>> --- /dev/null
>> +++ b/drivers/iio/adc/lpc18xx_adc.c
>> @@ -0,0 +1,228 @@
>> +/*
>> + * IIO ADC driver for NXP LPC18xx ADC
>> + *
>> + * Copyright (C) 2016 Joachim Eastwood <manabian@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * UNSUPPORTED hardware features:
>> + *  - Hardware triggers
>> + *  - Burst mode
>> + *  - Interrupts
>> + *  - DMA
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/driver.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +/* LPC18XX ADC registers and bits */
>> +#define LPC18XX_ADC_CR			0x000
>> +#define  LPC18XX_ADC_CR_CLKDIV_SHIFT	8
>> +#define  LPC18XX_ADC_CR_PDN		BIT(21)
>> +#define  LPC18XX_ADC_CR_START_NOW	(0x1 << 24)
>> +#define LPC18XX_ADC_GDR			0x004
>> +
>> +/* Data register bits */
>> +#define LPC18XX_ADC_SAMPLE_SHIFT	6
>> +#define LPC18XX_ADC_SAMPLE_MASK		0x3ff
>> +#define LPC18XX_ADC_CONV_DONE		BIT(31)
>> +
>> +/* Clock should be 4.5 MHz or less */
>> +#define LPC18XX_ADC_CLK_TARGET		4500000
>> +
>> +struct lpc18xx_adc {
>> +	void __iomem *base;
>> +	struct device *dev;
>> +	struct clk *clk;
>> +	struct regulator *vref;
>> +	u32 cr_reg;
>> +};
>> +
>> +#define LPC18XX_ADC_CHAN(_idx) {				\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = _idx,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +}
>> +
>> +static const struct iio_chan_spec lpc18xx_adc_iio_channels[] = {
>> +	LPC18XX_ADC_CHAN(0),
>> +	LPC18XX_ADC_CHAN(1),
>> +	LPC18XX_ADC_CHAN(2),
>> +	LPC18XX_ADC_CHAN(3),
>> +	LPC18XX_ADC_CHAN(4),
>> +	LPC18XX_ADC_CHAN(5),
>> +	LPC18XX_ADC_CHAN(6),
>> +	LPC18XX_ADC_CHAN(7),
>> +};
>> +
>> +static int lpc18xx_adc_read_chan(struct lpc18xx_adc *adc, unsigned int ch)
>> +{
>> +	int ret;
>> +	u32 reg;
>> +
>> +	reg = adc->cr_reg | BIT(ch) | LPC18XX_ADC_CR_START_NOW;
>> +	writel(reg, adc->base + LPC18XX_ADC_CR);
>> +
>> +	ret = readl_poll_timeout(adc->base + LPC18XX_ADC_GDR, reg,
>> +				 reg & LPC18XX_ADC_CONV_DONE, 3, 9);
>> +	if (ret) {
>> +		dev_warn(adc->dev, "adc read timed out\n");
>> +		return ret;
>> +	}
>> +
>> +	return (reg >> LPC18XX_ADC_SAMPLE_SHIFT) & LPC18XX_ADC_SAMPLE_MASK;
>> +}
>> +
>> +static int lpc18xx_adc_read_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int *val, int *val2, long mask)
>> +{
>> +	struct lpc18xx_adc *adc = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
Please use a local lock to protect channels.  The mlock is specifically
for use in protecting against moving in and out of buffered mode for
drivers in which individual reads will break buffered capture.

>> +		mutex_lock(&indio_dev->mlock);
>> +		*val = lpc18xx_adc_read_chan(adc, chan->channel);
>> +		mutex_unlock(&indio_dev->mlock);
>> +		if (*val < 0)
>> +			return *val;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = regulator_get_voltage(adc->vref) / 1000;
>> +		*val2 = 10;
>> +
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info lpc18xx_adc_info = {
>> +	.read_raw = lpc18xx_adc_read_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static int lpc18xx_adc_probe(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct lpc18xx_adc *adc;
>> +	struct resource *res;
>> +	unsigned int clkdiv;
>> +	unsigned long rate;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +	adc = iio_priv(indio_dev);
>> +	adc->dev = &pdev->dev;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	adc->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(adc->base))
>> +		return PTR_ERR(adc->base);
>> +
>> +	adc->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(adc->clk)) {
>> +		dev_err(&pdev->dev, "error getting clock\n");
>> +		return PTR_ERR(adc->clk);
>> +	}
>> +
>> +	rate = clk_get_rate(adc->clk);
>> +	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
>> +
>> +	adc->vref = devm_regulator_get(&pdev->dev, "vref");
>> +	if (IS_ERR(adc->vref)) {
>> +		dev_err(&pdev->dev, "error getting regulator\n");
>> +		return PTR_ERR(adc->vref);
>> +	}
>> +
>> +	indio_dev->name = dev_name(&pdev->dev);
>> +	indio_dev->dev.parent = &pdev->dev;
>> +	indio_dev->info = &lpc18xx_adc_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = lpc18xx_adc_iio_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(lpc18xx_adc_iio_channels);
>> +
>> +	ret = regulator_enable(adc->vref);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "unable to enable regulator\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_prepare_enable(adc->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "unable to enable clock\n");
>> +		goto dis_reg;
>> +	}
>> +
>> +	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
>> +			LPC18XX_ADC_CR_PDN;
>> +	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "unable to register device\n");
>> +		goto dis_clk;
>> +	}
>> +
>> +	return 0;
>> +
>> +dis_clk:
>> +	writel(0, adc->base + LPC18XX_ADC_CR);
>> +	clk_disable_unprepare(adc->clk);
>> +dis_reg:
>> +	regulator_disable(adc->vref);
>> +	return ret;
>> +}
>> +
>> +static int lpc18xx_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct lpc18xx_adc *adc = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	writel(0, adc->base + LPC18XX_ADC_CR);
>> +	clk_disable_unprepare(adc->clk);
>> +	regulator_disable(adc->vref);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id lpc18xx_adc_match[] = {
>> +	{ .compatible = "nxp,lpc1850-adc" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
>> +
>> +static struct platform_driver lpc18xx_adc_driver = {
>> +	.probe	= lpc18xx_adc_probe,
>> +	.remove	= lpc18xx_adc_remove,
>> +	.driver	= {
>> +		.name = "lpc18xx-adc",
>> +		.of_match_table = lpc18xx_adc_match,
>> +	},
>> +};
>> +module_platform_driver(lpc18xx_adc_driver);
>> +
>> +MODULE_DESCRIPTION("LPC18xx ADC driver");
>> +MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
>> +MODULE_LICENSE("GPL v2");
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

