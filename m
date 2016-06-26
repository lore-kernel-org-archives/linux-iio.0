Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47197 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcFZObI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 10:31:08 -0400
Subject: Re: [PATCH 2/3] auxadc: Add Mediatek auxadc driver for mt2701.
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>
References: <1466753830-4542-1-git-send-email-zhiyong.tao@mediatek.com>
 <1466753830-4542-3-git-send-email-zhiyong.tao@mediatek.com>
 <alpine.DEB.2.02.1606241036400.10280@pmeerw.net>
Cc: knaack.h@gmx.de, lars@metafoo.de, srv_heupstream@mediatek.com,
	liguo.zhang@mediatek.com, yingjoe.chen@mediatek.com,
	eddie.huang@mediatek.com, erin.lo@mediatek.com,
	dawei.chien@mediatek.com, matthias.bgg@gmail.com,
	s.hauer@pengutronix.de, linux-iio@vger.kernel.org,
	linux-mediatek@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <38e8d819-e4f7-1b30-f286-e9b37680fea1@kernel.org>
Date: Sun, 26 Jun 2016 15:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1606241036400.10280@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/06/16 09:51, Peter Meerwald-Stadler wrote:
> 
>> Add Mediatek auxadc driver in iio.
>> It will register a device in iio and support iio.
>> So thermal can read auxadc channel to sample data by iio device.
>> It is tested successfully on mt2701 platform.
>> Mt8173 platform is not tested. But the expectation is compatible.
> 
> some reference to iio would be nice in the subject line
> 
> comments below
>  
>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
A few additions from me to add to Peter's already thorough review.
I'm being more fuss about naming than anything else.  Looks pretty
good otherwise.

Jonathan
>> ---
>>  drivers/iio/adc/Kconfig         |   11 ++
>>  drivers/iio/adc/Makefile        |    1 +
>>  drivers/iio/adc/mt65xx_auxadc.c |  269
The naming is 'interesting'.  I'd just name it after the first major part
to be supported.  Hardware manufacturers (possibly including mediatek) play
with series numbers all the time so wild cards in part names often get
more confusing than just having an actual part number and listing the others
in the Kconfig help as well.
>>  +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 281 insertions(+)
>>  create mode 100644 drivers/iio/adc/mt65xx_auxadc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 25378c5..7684849 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -315,6 +315,17 @@ config MEN_Z188_ADC
>>  	  This driver can also be built as a module. If so, the module will be
>>  	  called men_z188_adc.
>>  
>> +config MEDIATEK_MT65XX_AUXADC
>> +	tristate "MediaTek AUXADC driver"
> 
> maybe some 'depends on' here so the driver is just visible for relevant 
> configs? see below, MXR_LRADC, for an example
Make sure to include CONFIG_TEST as well though to get build coverage from
the autobuilders.
> 
>> +	help
>> +	  Say yes here to enable support for MediaTek mt65xx AUXADC.
>> +
>> +	  The driver supports immediate mode operation to read from one of sixteen
>> +	  channels (external or internal).
>> +
>> +	  This driver can also be built as a module. If so, the module will be
>> +	  called mt65xx_auxadc.
>> +
>>  config MXS_LRADC
>>          tristate "Freescale i.MX23/i.MX28 LRADC"
>>          depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 38638d4..bc62209 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
>>  obj-$(CONFIG_MCP320X) += mcp320x.o
>>  obj-$(CONFIG_MCP3422) += mcp3422.o
>>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>> +obj-$(CONFIG_MEDIATEK_MT65XX_AUXADC) += mt65xx_auxadc.o
>>  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>>  obj-$(CONFIG_NAU7802) += nau7802.o
>>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>> diff --git a/drivers/iio/adc/mt65xx_auxadc.c
>>  b/drivers/iio/adc/mt65xx_auxadc.c
>> new file mode 100644
>> index 0000000..b3c059c
>> --- /dev/null
>> +++ b/drivers/iio/adc/mt65xx_auxadc.c
>> @@ -0,0 +1,269 @@
>> +/*
>> + * Copyright (c) 2016 MediaTek Inc.
>> + * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/io.h>
>> +#include <linux/iio/iio.h>
>> +
>> +/* Registers  define*/
> 
> delete one space before define, add a space after define; maybe 'Register 
> definitions' or 'Register defines' would read smoother
> 
>> +#define MT65XX_AUXADC_CON0                    0x00
>> +#define MT65XX_AUXADC_CON1                    0x04
>> +#define MT65XX_AUXADC_CON2                    0x10
>> +#define MT65XX_AUXADC_STA                     BIT(0)
>> +
>> +#define MT65XX_AUXADC_DAT0                    0x14
>> +#define MT65XX_AUXADC_RDY0                    BIT(12)
>> +
>> +#define MT65XX_AUXADC_MISC                    0x94
>> +#define MT65XX_AUXADC_PDN_EN                  BIT(14)
>> +
>> +#define MT65XX_AUXADC_DAT_MASK                0xfff
>> +#define MT65XX_AUXADC_SLEEP_US                1000
>> +#define MT65XX_AUXADC_TIMEOUT_US              10000
>> +#define MT65XX_AUXADC_POWER_READY_MS          1
>> +#define MT65XX_AUXADC_SAMPLE_READY_US         25
>> +
>> +struct mt65xx_auxadc_device {
>> +	void __iomem *reg_base;
>> +	struct clk *adc_clk;
>> +	struct mutex lock; /*generic mutex for auxadc driver*/
> 
> comment needed?
> 
>> +	unsigned int power_ready_ms;
>> +	unsigned int sample_ready_us;
>> +};
>> +
>> +#define MT65xx_AUXADC_CHANNEL(idx) {				       \
> 
> XX uppercase
> 
>> +		.type = IIO_VOLTAGE,				       \
>> +		.indexed = 1,					       \
>> +		.channel = (idx),				       \
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	       \
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>> +					    BIT(IIO_CHAN_INFO_OFFSET), \
>> +}
>> +
>> +static const struct iio_chan_spec mt65xx_auxadc_iio_channels[] = {
>> +	MT65xx_AUXADC_CHANNEL(0),
>> +	MT65xx_AUXADC_CHANNEL(1),
>> +	MT65xx_AUXADC_CHANNEL(2),
>> +	MT65xx_AUXADC_CHANNEL(3),
>> +	MT65xx_AUXADC_CHANNEL(4),
>> +	MT65xx_AUXADC_CHANNEL(5),
>> +	MT65xx_AUXADC_CHANNEL(6),
>> +	MT65xx_AUXADC_CHANNEL(7),
>> +	MT65xx_AUXADC_CHANNEL(8),
>> +	MT65xx_AUXADC_CHANNEL(9),
>> +	MT65xx_AUXADC_CHANNEL(10),
>> +	MT65xx_AUXADC_CHANNEL(11),
>> +	MT65xx_AUXADC_CHANNEL(12),
>> +	MT65xx_AUXADC_CHANNEL(13),
>> +	MT65xx_AUXADC_CHANNEL(14),
>> +	MT65xx_AUXADC_CHANNEL(15),
>> +};
>> +
>> +static int mt65xx_auxadc_read(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan)
>> +{
>> +	u32 rawdata, val;
>> +	void __iomem *reg_channel;
>> +	struct mt65xx_auxadc_device *adc_dev = iio_priv(indio_dev);
>> +
>> +	reg_channel = adc_dev->reg_base + MT65XX_AUXADC_DAT0 +
>> +		      chan->channel * 0x04;
>> +
>> +	mutex_lock(&adc_dev->lock);
>> +
>> +	val = readl(adc_dev->reg_base + MT65XX_AUXADC_CON1);
>> +	val &= ~(1 << chan->channel);
>> +	writel(val, adc_dev->reg_base + MT65XX_AUXADC_CON1);
>> +
>> +	/* read channel and make sure old ready bit ==0 */
>> +	readl_poll_timeout(reg_channel, val,
>> +			   ((val & MT65XX_AUXADC_RDY0) == 0),
>> +			   MT65XX_AUXADC_SLEEP_US,
>> +			   MT65XX_AUXADC_TIMEOUT_US);
> 
> this returns a code 0 or -ETIMEDOUT that probably should be checked
> 
>> +
>> +	/* set bit  to trigger sample */
> 
> double space after bit
> 
>> +	val = readl(adc_dev->reg_base + MT65XX_AUXADC_CON1);
>> +	val |= 1 << chan->channel;
>> +	writel(val, adc_dev->reg_base + MT65XX_AUXADC_CON1);
>> +
>> +	/* we must delay here for hardware sample channel data */
>> +	udelay(adc_dev->sample_ready_us);
>> +
>> +	/* check MTK_AUXADC_CON2 if auxadc is idle */
>> +	readl_poll_timeout(adc_dev->reg_base + MT65XX_AUXADC_CON2, val,
>> +			   ((val & MT65XX_AUXADC_STA) == 0),
>> +			   MT65XX_AUXADC_SLEEP_US,
>> +			   MT65XX_AUXADC_TIMEOUT_US);
>> +
>> +	/* read channel and make sure  ready bit ==1 */
space before 1 (nitpick but would conform to coding style if it were code ;)

>> +	readl_poll_timeout(reg_channel, val,
>> +			   ((val & MT65XX_AUXADC_RDY0) == 1),
>> +			   MT65XX_AUXADC_SLEEP_US,
>> +			   MT65XX_AUXADC_TIMEOUT_US);
>> +
>> +	/* read data */
>> +	rawdata = readl(reg_channel) & MT65XX_AUXADC_DAT_MASK;
>> +
>> +	mutex_unlock(&adc_dev->lock);
>> +
>> +	return rawdata;
>> +}
>> +
>> +static int mt65xx_auxadc_read_raw(struct iio_dev *indio_dev,
>> +				  struct iio_chan_spec const *chan,
>> +				  int *val,
>> +				  int *val2,
>> +				  long info)
>> +{
>> +	int ret;
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		*val = mt65xx_auxadc_read(indio_dev, chan);
>> +		ret = IIO_VAL_INT;
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 1;
> 
> no point in returning 1 and 0 for SCALE and OFFSET, these are the 
> default/assumed values if not given
If the device is really kicking out values in the base units for
it's type (millivolts) then have the channel type as _PROCESSED not
raw to indicate to userspace that it can be used directly without any
offsets or scales being applied.


> 
>> +		ret = IIO_VAL_INT;
>> +		break;
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		*val = 0;
>> +		ret = IIO_VAL_INT;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_info mt65xx_auxadc_info = {
>> +	.driver_module = THIS_MODULE,
>> +	.read_raw = &mt65xx_auxadc_read_raw,
>> +};
>> +
>> +static int mt65xx_auxadc_probe(struct platform_device *pdev)
>> +{
>> +	struct mt65xx_auxadc_device *adc_dev;
>> +	unsigned long adc_clk_rate;
>> +	struct resource *res;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +	u32 val;
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	adc_dev = iio_priv(indio_dev);
>> +	indio_dev->dev.parent = &pdev->dev;
>> +	indio_dev->name = dev_name(&pdev->dev);
>> +	indio_dev->info = &mt65xx_auxadc_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = mt65xx_auxadc_iio_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(mt65xx_auxadc_iio_channels);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(adc_dev->reg_base)) {
>> +		dev_err(&pdev->dev, "failed to get auxadc base address.\n");
>> +		return PTR_ERR(adc_dev->reg_base);
>> +	}
>> +
>> +	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
>> +	if (IS_ERR(adc_dev->adc_clk)) {
>> +		dev_err(&pdev->dev, "failed to get axuadc clock\n");
> 
> spelling: auxadc
> 
>> +		return PTR_ERR(adc_dev->adc_clk);
>> +	}
>> +
>> +	ret = clk_prepare_enable(adc_dev->adc_clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
>> +		return ret;
>> +	}
>> +
>> +	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
>> +	if (!adc_clk_rate) {
>> +		dev_err(&pdev->dev, "null clock rate!\n");
>> +		clk_disable_unprepare(adc_dev->adc_clk);
>> +		return -EINVAL;
>> +	}
>> +
>> +	adc_dev->power_ready_ms = MT65XX_AUXADC_POWER_READY_MS;
>> +	adc_dev->sample_ready_us = MT65XX_AUXADC_SAMPLE_READY_US;
>> +
>> +	mutex_init(&adc_dev->lock);
>> +
>> +	val = readl(adc_dev->reg_base + MT65XX_AUXADC_MISC);
>> +	val |= MT65XX_AUXADC_PDN_EN;
>> +	writel(val, adc_dev->reg_base + MT65XX_AUXADC_MISC);
>> +	mdelay(adc_dev->power_ready_ms);
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to register iio device!\n");
> 
> power down on failure?
> clk_disable_unprepare()?
Absolutely.  Anything you have in remove (other than very first statement)
should be mirrored in the error paths of probe.
> 
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
> 
> I'd rather put this before iio_device_register() to avoid a potential race 
> window
Whilst good practice in general, I'm not sure there is a race here.
It's only used in remove, which inherently can't race with probe.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int mt65xx_auxadc_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct mt65xx_auxadc_device *adc_dev = iio_priv(indio_dev);
>> +	u32 val;
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	val = readl(adc_dev->reg_base + MT65XX_AUXADC_MISC);
>> +	val &= ~MT65XX_AUXADC_PDN_EN;
>> +	writel(val, adc_dev->reg_base + MT65XX_AUXADC_MISC);
>> +
>> +	clk_disable_unprepare(adc_dev->adc_clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id mt65xx_auxadc_of_match[] = {
>> +	{ .compatible = "mediatek,mt2701-auxadc", },
>> +	{ .compatible = "mediatek,mt8173-auxadc", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mt65xx_auxadc_of_match);
>> +
>> +static struct platform_driver mt65xx_auxadc_driver = {
>> +	.driver = {
>> +		.name   = "mt65xx-auxadc",
>> +		.of_match_table = mt65xx_auxadc_of_match,
>> +	},
>> +	.probe	= mt65xx_auxadc_probe,
>> +	.remove	= mt65xx_auxadc_remove,
>> +};
>> +module_platform_driver(mt65xx_auxadc_driver);
>> +
>> +MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
>> +MODULE_DESCRIPTION("MTK AUXADC Device Driver");
>> +MODULE_LICENSE("GPL v2");
>>
> 

