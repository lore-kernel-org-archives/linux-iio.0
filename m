Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:60576 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbcGTGYn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 02:24:43 -0400
Message-ID: <1468995871.419.37.camel@mhfsdcap03>
Subject: Re: [PATCH v4 2/3] iio: adc: mt2701: Add Mediatek auxadc driver for
 mt2701.
From: zhiyong tao <zhiyong.tao@mediatek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
	<liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <erin.lo@mediatek.com>,
	<dawei.chien@mediatek.com>, <matthias.bgg@gmail.com>,
	<s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date: Wed, 20 Jul 2016 14:24:31 +0800
In-Reply-To: <1468994558.419.30.camel@mhfsdcap03>
References: <1468219197-9572-1-git-send-email-zhiyong.tao@mediatek.com>
	 <1468219197-9572-3-git-send-email-zhiyong.tao@mediatek.com>
	 <82fa5ffa-52be-e1ec-83dd-dd92b3f3ef5d@kernel.org>
	 <1468994558.419.30.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2016-07-20 at 14:02 +0800, zhiyong tao wrote:
> On Mon, 2016-07-18 at 18:12 +0100, Jonathan Cameron wrote:
> > On 11/07/16 07:39, Zhiyong Tao wrote:
> > > Add Mediatek auxadc driver based on iio.
> > > It will register a device in iio and support iio.
> > > So thermal can read auxadc channel to sample data by iio device.
> > > It is tested successfully on mt2701 platform.
> > > Mt8173 and mt6577 platforms are not tested.
> > > But the expectation is compatible.
> > > 
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Looks good to me.  Couple of really minor points / questions inline...
> > 
> > Just one thing to confirm... (you probably already answered this!)
> > What are the units of the voltage channels?
> > 
> > Jonathan
> 
> The units of the voltage channels are mv. 
> 
> > > ---
> > >  drivers/iio/adc/Kconfig         |   13 ++
> > >  drivers/iio/adc/Makefile        |    1 +
> > >  drivers/iio/adc/mt6577_auxadc.c |  294 +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 308 insertions(+)
> > >  create mode 100644 drivers/iio/adc/mt6577_auxadc.c
> > > 
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 25378c5..14929fc 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -305,6 +305,19 @@ config MCP3422
> > >  	  This driver can also be built as a module. If so, the module will be
> > >  	  called mcp3422.
> > >  
> > > +config MEDIATEK_MT6577_AUXADC
> > > +        tristate "MediaTek AUXADC driver"
> > > +        depends on ARCH_MEDIATEK || COMPILE_TEST
> > > +        depends on HAS_IOMEM
> > > +        help
> > > +          Say yes here to enable support for MediaTek mt65xx AUXADC.
> > > +
> > > +          The driver supports immediate mode operation to read from one of sixteen
> > > +          channels (external or internal).
> > > +
> > > +          This driver can also be built as a module. If so, the module will be
> > > +          called mt6577_auxadc.
> > > +
> > >  config MEN_Z188_ADC
> > >  	tristate "MEN 16z188 ADC IP Core support"
> > >  	depends on MCB
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 38638d4..8306347 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -30,6 +30,7 @@ obj-$(CONFIG_MAX1027) += max1027.o
> > >  obj-$(CONFIG_MAX1363) += max1363.o
> > >  obj-$(CONFIG_MCP320X) += mcp320x.o
> > >  obj-$(CONFIG_MCP3422) += mcp3422.o
> > > +obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
> > >  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
> > >  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
> > >  obj-$(CONFIG_NAU7802) += nau7802.o
> > > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > > new file mode 100644
> > > index 0000000..c7cc901
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > > @@ -0,0 +1,294 @@
> > > +/*
> > > + * Copyright (c) 2016 MediaTek Inc.
> > > + * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iio/iio.h>
> > > +
> > > +/* Register definitions */
> > > +#define MT6577_AUXADC_CON0                    0x00
> > > +#define MT6577_AUXADC_CON1                    0x04
> > > +#define MT6577_AUXADC_CON2                    0x10
> > > +#define MT6577_AUXADC_STA                     BIT(0)
> > > +
> > > +#define MT6577_AUXADC_DAT0                    0x14
> > > +#define MT6577_AUXADC_RDY0                    BIT(12)
> > > +
> > > +#define MT6577_AUXADC_MISC                    0x94
> > > +#define MT6577_AUXADC_PDN_EN                  BIT(14)
> > > +
> > > +#define MT6577_AUXADC_DAT_MASK                0xfff
> > > +#define MT6577_AUXADC_SLEEP_US                1000
> > > +#define MT6577_AUXADC_TIMEOUT_US              10000
> > > +#define MT6577_AUXADC_POWER_READY_MS          1
> > > +#define MT6577_AUXADC_SAMPLE_READY_US         25
> > > +
> > > +struct mt6577_auxadc_device {
> > > +	void __iomem *reg_base;
> > > +	struct clk *adc_clk;
> > > +	struct mutex lock;
> > > +};
> > > +
> > > +#define MT6577_AUXADC_CHANNEL(idx) {				    \
> > > +		.type = IIO_VOLTAGE,				    \
> > > +		.indexed = 1,					    \
> > > +		.channel = (idx),				    \
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> > > +}
> > > +
> > > +static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
> > > +	MT6577_AUXADC_CHANNEL(0),
> > > +	MT6577_AUXADC_CHANNEL(1),
> > > +	MT6577_AUXADC_CHANNEL(2),
> > > +	MT6577_AUXADC_CHANNEL(3),
> > > +	MT6577_AUXADC_CHANNEL(4),
> > > +	MT6577_AUXADC_CHANNEL(5),
> > > +	MT6577_AUXADC_CHANNEL(6),
> > > +	MT6577_AUXADC_CHANNEL(7),
> > > +	MT6577_AUXADC_CHANNEL(8),
> > > +	MT6577_AUXADC_CHANNEL(9),
> > > +	MT6577_AUXADC_CHANNEL(10),
> > > +	MT6577_AUXADC_CHANNEL(11),
> > > +	MT6577_AUXADC_CHANNEL(12),
> > > +	MT6577_AUXADC_CHANNEL(13),
> > > +	MT6577_AUXADC_CHANNEL(14),
> > > +	MT6577_AUXADC_CHANNEL(15),
> > > +};
> > > +
> > > +static int mt6577_auxadc_read(struct iio_dev *indio_dev,
> > > +			      struct iio_chan_spec const *chan)
> > > +{
> > > +	u32 rawdata, val;
> > > +	void __iomem *reg_channel;
> > > +	int ret;
> > > +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> > > +
> > > +	reg_channel = adc_dev->reg_base + MT6577_AUXADC_DAT0 +
> > > +		      chan->channel * 0x04;
> > > +
> > > +	mutex_lock(&adc_dev->lock);
> > > +
> > > +	val = readl(adc_dev->reg_base + MT6577_AUXADC_CON1);
> > > +	val &= ~(1 << chan->channel);
> > > +	writel(val, adc_dev->reg_base + MT6577_AUXADC_CON1);
> > > +
> > > +	/* read channel and make sure old ready bit == 0 */
> > > +	ret = readl_poll_timeout(reg_channel, val,
> > > +				 ((val & MT6577_AUXADC_RDY0) == 0),
> > > +				 MT6577_AUXADC_SLEEP_US,
> > > +				 MT6577_AUXADC_TIMEOUT_US);
> > > +	if (ret < 0) {
> > > +		dev_err(indio_dev->dev.parent,
> > > +			"wait for channel[%d] ready bit clear time out\n",
> > > +			chan->channel);
> > > +
> > > +		mutex_unlock(&adc_dev->lock);
> > > +
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	/* set bit to trigger sample */
> > > +	val = readl(adc_dev->reg_base + MT6577_AUXADC_CON1);
> > > +	val |= 1 << chan->channel;
> > > +	writel(val, adc_dev->reg_base + MT6577_AUXADC_CON1);
> > > +
> > > +	/* we must delay here for hardware sample channel data */
> > > +	udelay(MT6577_AUXADC_SAMPLE_READY_US);
> > > +
> > > +	/* check MTK_AUXADC_CON2 if auxadc is idle */
> > > +	ret = readl_poll_timeout(adc_dev->reg_base + MT6577_AUXADC_CON2, val,
> > > +				 ((val & MT6577_AUXADC_STA) == 0),
> > > +				 MT6577_AUXADC_SLEEP_US,
> > > +				 MT6577_AUXADC_TIMEOUT_US);
> > > +	if (ret < 0) {
> > > +		dev_err(indio_dev->dev.parent,
> > > +			"wait for auxadc idle time out\n");
> > > +
> > > +		mutex_unlock(&adc_dev->lock);
> > > +
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	/* read channel and make sure ready bit == 1 */
> > > +	ret = readl_poll_timeout(reg_channel, val,
> > > +				 ((val & MT6577_AUXADC_RDY0) != 0),
> > > +				 MT6577_AUXADC_SLEEP_US,
> > > +				 MT6577_AUXADC_TIMEOUT_US);
> > > +	if (ret < 0) {
> > > +		dev_err(indio_dev->dev.parent,
> > > +			"wait for channel[%d] data ready time out\n",
> > > +			chan->channel);
> > > +
> > > +		mutex_unlock(&adc_dev->lock);
> > > +
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	/* read data */
> > > +	rawdata = readl(reg_channel) & MT6577_AUXADC_DAT_MASK;
> > > +
> > > +	mutex_unlock(&adc_dev->lock);
> > > +
> > > +	return rawdata;
> > > +}
> > > +
> > > +static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
> > > +				  struct iio_chan_spec const *chan,
> > > +				  int *val,
> > > +				  int *val2,
> > > +				  long info)
> > > +{
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_PROCESSED:
> > > +		*val = mt6577_auxadc_read(indio_dev, chan);
> > > +		if (*val < 0) {
> > > +			dev_err(indio_dev->dev.parent,
> > > +				"failed to sample data on channel[%d]\n",
> > > +				chan->channel);
> > > +			return *val;
> > > +		}
> > > +		return IIO_VAL_INT;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static const struct iio_info mt6577_auxadc_info = {
> > > +	.driver_module = THIS_MODULE,
> > > +	.read_raw = &mt6577_auxadc_read_raw,
> > > +};
> > > +
> > > +static int mt6577_auxadc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct mt6577_auxadc_device *adc_dev;
> > > +	unsigned long adc_clk_rate;
> > > +	struct resource *res;
> > > +	struct iio_dev *indio_dev;
> > > +	int ret;
> > > +	u32 val;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	adc_dev = iio_priv(indio_dev);
> > > +	indio_dev->dev.parent = &pdev->dev;
> > > +	indio_dev->name = dev_name(&pdev->dev);
> > > +	indio_dev->info = &mt6577_auxadc_info;
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +	indio_dev->channels = mt6577_auxadc_iio_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(adc_dev->reg_base)) {
> > > +		dev_err(&pdev->dev, "failed to get auxadc base address.\n");
> > > +		return PTR_ERR(adc_dev->reg_base);
> > > +	}
> > > +
> > > +	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
> > > +	if (IS_ERR(adc_dev->adc_clk)) {
> > > +		dev_err(&pdev->dev, "failed to get auxadc clock\n");
> > > +		return PTR_ERR(adc_dev->adc_clk);
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(adc_dev->adc_clk);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
> > > +	if (!adc_clk_rate) {
> > > +		dev_err(&pdev->dev, "null clock rate!\n");
> > > +		goto err_disable_clk;
> > > +	}
> > > +
> > > +	mutex_init(&adc_dev->lock);
> > > +
> > > +	val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +	val |= MT6577_AUXADC_PDN_EN;
> > > +	writel(val, adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +	mdelay(MT6577_AUXADC_POWER_READY_MS);
> > > +
> > > +	val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +	if ((val & MT6577_AUXADC_PDN_EN) == 0) {
> > That's a high level of paranoia... Any reason to believe this might fail?
> 
> Someone reviews the code and gives a suggestion to power off chenck.
> If auxadc clk is off in the case, we can not write MT6577_AUXADC_PDN_EN
> in MT6577_AUXADC_MISC. So it may cause to enable auxadc power failed.
> 

sorry, I have searched the previous versions.
I found that I  misunderstand the intention.
The power on failed checked will be removed in the next version.

> > > +		dev_err(&pdev->dev, "failed to enable auxadc power!\n");
> > > +		goto err_disable_clk;
> > > +	}
> > > +
> > > +	platform_set_drvdata(pdev, indio_dev);
> > > +
> > > +	ret = iio_device_register(indio_dev);
> > > +	if (ret < 0) {
> > I'd have slightly preferred that this error unwind block was also
> > moved to on a goto.  Makes it easier to review as the error block then
> > matches remove (with expected differences!)  Really small point however.
> 
> I will update this in next version.
> 
> > 
> > > +		dev_err(&pdev->dev, "failed to register iio device!\n");
> > > +		val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +		val &= ~MT6577_AUXADC_PDN_EN;
> > > +		writel(val, adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +		goto err_disable_clk;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_disable_clk:
> > > +	clk_disable_unprepare(adc_dev->adc_clk);
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int mt6577_auxadc_remove(struct platform_device *pdev)
> > > +{
> > > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> > > +	u32 val;
> > > +
> > > +	iio_device_unregister(indio_dev);
> > > +
> > > +	val = readl(adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +	val &= ~MT6577_AUXADC_PDN_EN;
> > > +	writel(val, adc_dev->reg_base + MT6577_AUXADC_MISC);
> > > +
> > > +	clk_disable_unprepare(adc_dev->adc_clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id mt6577_auxadc_of_match[] = {
> > > +	{ .compatible = "mediatek,mt2701-auxadc", },
> > > +	{ .compatible = "mediatek,mt8173-auxadc", },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
> > > +
> > > +static struct platform_driver mt6577_auxadc_driver = {
> > > +	.driver = {
> > > +		.name   = "mt6577-auxadc",
> > > +		.of_match_table = mt6577_auxadc_of_match,
> > > +	},
> > > +	.probe	= mt6577_auxadc_probe,
> > > +	.remove	= mt6577_auxadc_remove,
> > > +};
> > > +module_platform_driver(mt6577_auxadc_driver);
> > > +
> > > +MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
> > > +MODULE_DESCRIPTION("MTK AUXADC Device Driver");
> > > +MODULE_LICENSE("GPL v2");
> > > 
> > 
> 


