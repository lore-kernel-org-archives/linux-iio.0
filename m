Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39844 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761083AbbKUQr4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 11:47:56 -0500
Subject: Re: [PATCH v3 1/4] iio: adc: add IMX7D ADC driver support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Haibo Chen <haibo.chen@freescale.com>
References: <1448034495-1759-1-git-send-email-haibo.chen@freescale.com>
 <1448034495-1759-2-git-send-email-haibo.chen@freescale.com>
 <alpine.DEB.2.02.1511201651070.10019@pmeerw.net>
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650A038.2060208@kernel.org>
Date: Sat, 21 Nov 2015 16:47:52 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1511201651070.10019@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/11/15 16:05, Peter Meerwald-Stadler wrote:
> 
>> Freescale i.MX7D soc contains a new ADC IP. This patch add this ADC
>> driver support, and the driver only support ADC software trigger.
> 
> some minor comments below
A few additional bits and pieces from me.

Jonathan
>  
>> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
>> ---
>>  drivers/iio/adc/Kconfig     |   9 +
>>  drivers/iio/adc/Makefile    |   1 +
>>  drivers/iio/adc/imx7d_adc.c | 570 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 580 insertions(+)
>>  create mode 100644 drivers/iio/adc/imx7d_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 7868c74..bf0611c 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -194,6 +194,15 @@ config HI8435
>>  	  This driver can also be built as a module. If so, the module will be
>>  	  called hi8435.
>>  
>> +config IMX7D_ADC
>> +	tristate "IMX7D ADC driver"
>> +	depends on OF
>> +	help
>> +	  Say yes here to build support for IMX7D ADC.
>> +
>> +	  This driver can also be built as a module. If so, the module will be
>> +	  called imx7d_adc.
>> +
>>  config LP8788_ADC
>>  	tristate "LP8788 ADC driver"
>>  	depends on MFD_LP8788
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 99b37a9..282ffc01 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>>  obj-$(CONFIG_HI8435) += hi8435.o
>> +obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>>  obj-$(CONFIG_MAX1027) += max1027.o
>>  obj-$(CONFIG_MAX1363) += max1363.o
>> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
>> new file mode 100644
>> index 0000000..d9547bf
>> --- /dev/null
>> +++ b/drivers/iio/adc/imx7d_adc.c
>> @@ -0,0 +1,570 @@
>> +/*
>> + * Freescale i.MX7D ADC driver
>> + *
>> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/err.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/driver.h>
>> +
>> +/* ADC register */
>> +#define IMX7D_REG_ADC_CH_A_CFG1			0x00
>> +#define IMX7D_REG_ADC_CH_A_CFG2			0x10
>> +#define IMX7D_REG_ADC_CH_B_CFG1			0x20
>> +#define IMX7D_REG_ADC_CH_B_CFG2			0x30
>> +#define IMX7D_REG_ADC_CH_C_CFG1			0x40
>> +#define IMX7D_REG_ADC_CH_C_CFG2			0x50
>> +#define IMX7D_REG_ADC_CH_D_CFG1			0x60
>> +#define IMX7D_REG_ADC_CH_D_CFG2			0x70
>> +#define IMX7D_REG_ADC_CH_SW_CFG			0x80
>> +#define IMX7D_REG_ADC_TIMER_UNIT		0x90
>> +#define IMX7D_REG_ADC_DMA_FIFO			0xa0
>> +#define IMX7D_REG_ADC_FIFO_STATUS		0xb0
>> +#define IMX7D_REG_ADC_INT_SIG_EN		0xc0
>> +#define IMX7D_REG_ADC_INT_EN			0xd0
>> +#define IMX7D_REG_ADC_INT_STATUS		0xe0
>> +#define IMX7D_REG_ADC_CHA_B_CNV_RSLT		0xf0
>> +#define IMX7D_REG_ADC_CHC_D_CNV_RSLT		0x100
>> +#define IMX7D_REG_ADC_CH_SW_CNV_RSLT		0x110
>> +#define IMX7D_REG_ADC_DMA_FIFO_DAT		0x120
>> +#define IMX7D_REG_ADC_ADC_CFG			0x130
>> +
>> +#define IMX7D_EACH_CHANNEL_REG_SHIF		0x20
>> +
>> +#define IMX7D_REG_ADC_CH_CFG1_CHANNEL_EN			(0x1 << 31)
>> +#define IMX7D_REG_ADC_CH_CFG1_CHANNEL_DISABLE			(0x0 << 31)
>> +#define IMX7D_REG_ADC_CH_CFG1_CHANNEL_SINGLE			BIT(30)
>> +#define IMX7D_REG_ADC_CH_CFG1_CHANNEL_AVG_EN			BIT(29)
>> +#define IMX7D_REG_ADC_CH_CFG1_CHANNEL_SEL_SHIF			24
>> +
>> +#define IMX7D_REG_ADC_CH_CFG2_AVG_NUM_4				(0x0 << 12)
>> +#define IMX7D_REG_ADC_CH_CFG2_AVG_NUM_8				(0x1 << 12)
>> +#define IMX7D_REG_ADC_CH_CFG2_AVG_NUM_16			(0x2 << 12)
>> +#define IMX7D_REG_ADC_CH_CFG2_AVG_NUM_32			(0x3 << 12)
>> +
>> +#define IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_4			(0x0 << 29)
>> +#define IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_8			(0x1 << 29)
>> +#define IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_16			(0x2 << 29)
>> +#define IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_32			(0x3 << 29)
>> +#define IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_64			(0x4 << 29)
>> +#define IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_128			(0x5 << 29)
>> +
>> +#define IMX7D_REG_ADC_ADC_CFG_ADC_CLK_DOWN			BIT(31)
>> +#define IMX7D_REG_ADC_ADC_CFG_ADC_POWER_DOWN			BIT(1)
>> +#define IMX7D_REG_ADC_ADC_CFG_ADC_EN				BIT(0)
>> +
>> +#define IMX7D_REG_ADC_INT_CHA_COV_INT_EN			BIT(8)
>> +#define IMX7D_REG_ADC_INT_CHB_COV_INT_EN			BIT(9)
>> +#define IMX7D_REG_ADC_INT_CHC_COV_INT_EN			BIT(10)
>> +#define IMX7D_REG_ADC_INT_CHD_COV_INT_EN			BIT(11)
>> +#define IMX7D_REG_ADC_INT_CHANNEL_INT_EN			(IMX7D_REG_ADC_INT_CHA_COV_INT_EN | \
>> +								 IMX7D_REG_ADC_INT_CHB_COV_INT_EN | \
>> +								 IMX7D_REG_ADC_INT_CHC_COV_INT_EN | \
>> +								 IMX7D_REG_ADC_INT_CHD_COV_INT_EN)
>> +#define IMX7D_REG_ADC_INT_STATUS_CHANNEL_INT_STATUS		0xf00
>> +
>> +#define IMX7D_ADC_TIMEOUT		msecs_to_jiffies(100)
>> +
>> +enum imx7d_adc_clk_pre_div {
>> +	IMX7D_ADC_ANALOG_CLK_PRE_DIV_4,
>> +	IMX7D_ADC_ANALOG_CLK_PRE_DIV_8,
>> +	IMX7D_ADC_ANALOG_CLK_PRE_DIV_16,
>> +	IMX7D_ADC_ANALOG_CLK_PRE_DIV_32,
>> +	IMX7D_ADC_ANALOG_CLK_PRE_DIV_64,
>> +	IMX7D_ADC_ANALOG_CLK_PRE_DIV_128,
>> +};
>> +
>> +enum imx7d_adc_average_num {
>> +	IMX7D_ADC_AVERAGE_NUM_4,
>> +	IMX7D_ADC_AVERAGE_NUM_8,
>> +	IMX7D_ADC_AVERAGE_NUM_16,
>> +	IMX7D_ADC_AVERAGE_NUM_32,
>> +};
>> +
>> +struct imx7d_adc_feature {
>> +	enum imx7d_adc_clk_pre_div clk_pre_div;
>> +	enum imx7d_adc_average_num avg_num;
>> +
>> +	u32 core_time_unit;	/* impact the sample rate */
>> +
>> +	bool average_en;
>> +};
>> +
>> +struct imx7d_adc {
>> +	struct device *dev;
>> +	void __iomem *regs;
>> +	struct clk *clk;
>> +
>> +	u32 vref_uv;
>> +	u32 value;
>> +	u32 channel;
>> +	u32 pre_div_num;
>> +
>> +	struct regulator *vref;
>> +	struct imx7d_adc_feature adc_feature;
>> +
>> +	struct completion completion;
>> +};
>> +
>> +struct imx7d_adc_analogue_core_clk {
>> +	u32 pre_div;
>> +	u32 reg_config;
>> +};
>> +
>> +#define IMX7D_ADC_ALALOGUE_CLK_CONFIG(_pre_div, _reg_conf) {	\
> 
> _ADC_ANALOGUE
> 
>> +	.pre_div = (_pre_div),					\
>> +	.reg_config = (_reg_conf),				\
>> +}
>> +
>> +static const struct imx7d_adc_analogue_core_clk imx7d_adc_analogue_clk[] = {
>> +	IMX7D_ADC_ALALOGUE_CLK_CONFIG(4, IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_4),
>> +	IMX7D_ADC_ALALOGUE_CLK_CONFIG(8, IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_8),
>> +	IMX7D_ADC_ALALOGUE_CLK_CONFIG(16, IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_16),
>> +	IMX7D_ADC_ALALOGUE_CLK_CONFIG(32, IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_32),
>> +	IMX7D_ADC_ALALOGUE_CLK_CONFIG(64, IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_64),
>> +	IMX7D_ADC_ALALOGUE_CLK_CONFIG(128, IMX7D_REG_ADC_TIMER_UNIT_PRE_DIV_128),
>> +};
>> +
>> +#define IMX7D_ADC_CHAN(_idx, _chan_type) {			\
>> +	.type = (_chan_type),					\
> 
> type is always IIO_VOLTAGE, no need for _chan_type
> 
>> +	.indexed = 1,						\
>> +	.channel = (_idx),					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>> +}
>> +
>> +static const struct iio_chan_spec imx7d_adc_iio_channels[] = {
>> +	IMX7D_ADC_CHAN(0, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(1, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(2, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(3, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(4, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(5, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(6, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(7, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(8, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(9, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(10, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(11, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(12, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(13, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(14, IIO_VOLTAGE),
>> +	IMX7D_ADC_CHAN(15, IIO_VOLTAGE),
>> +};
>> +
>> +static const u32 imx7d_adc_average_num[] = {
>> +	IMX7D_REG_ADC_CH_CFG2_AVG_NUM_4,
>> +	IMX7D_REG_ADC_CH_CFG2_AVG_NUM_8,
>> +	IMX7D_REG_ADC_CH_CFG2_AVG_NUM_16,
>> +	IMX7D_REG_ADC_CH_CFG2_AVG_NUM_32,
>> +};
>> +
>> +static void imx7d_adc_feature_config(struct imx7d_adc *info)
>> +{
>> +	info->adc_feature.clk_pre_div = IMX7D_ADC_ANALOG_CLK_PRE_DIV_4;
>> +	info->adc_feature.avg_num = IMX7D_ADC_AVERAGE_NUM_32;
>> +	info->adc_feature.core_time_unit = 1;
>> +	info->adc_feature.average_en = true;
>> +}
>> +
>> +static void imx7d_adc_sample_set(struct imx7d_adc *info)
> 
> _sample_rate_set
> 
>> +{
>> +	struct imx7d_adc_feature *adc_feature = &info->adc_feature;
>> +	struct imx7d_adc_analogue_core_clk adc_analogure_clk;
>> +	u32 i;
>> +	u32 sample_rate = 0;
>> +
>> +	/*
>> +	 * Before sample set, disable channel A,B,C,D. Here we
>> +	 * clear the bit 31 of register REG_ADC_CH_A\B\C\D_CFG1.
>> +	 */
>> +	for (i = 0; i < 4; i++)
>> +		writel(IMX7D_REG_ADC_CH_CFG1_CHANNEL_DISABLE,
>> +			info->regs + i * IMX7D_EACH_CHANNEL_REG_SHIF);
>> +
>> +	adc_analogure_clk = imx7d_adc_analogue_clk[adc_feature->clk_pre_div];
>> +	sample_rate |= adc_analogure_clk.reg_config;
>> +	info->pre_div_num = adc_analogure_clk.pre_div;
>> +
>> +	sample_rate |= adc_feature->core_time_unit;
>> +	writel(sample_rate, info->regs + IMX7D_REG_ADC_TIMER_UNIT);
>> +}
>> +
>> +static void imx7d_adc_hw_init(struct imx7d_adc *info)
>> +{
>> +	u32 cfg;
> 
> newline
> 
>> +	/* power up and enable adc analogue core */
>> +	cfg = readl(info->regs + IMX7D_REG_ADC_ADC_CFG);
>> +	cfg &= ~(IMX7D_REG_ADC_ADC_CFG_ADC_CLK_DOWN | IMX7D_REG_ADC_ADC_CFG_ADC_POWER_DOWN);
>> +	cfg |= IMX7D_REG_ADC_ADC_CFG_ADC_EN;
>> +	writel(cfg, info->regs + IMX7D_REG_ADC_ADC_CFG);
>> +
>> +	/* enable channel A,B,C,D interrupt */
>> +	writel(IMX7D_REG_ADC_INT_CHANNEL_INT_EN, info->regs + IMX7D_REG_ADC_INT_SIG_EN);
>> +	writel(IMX7D_REG_ADC_INT_CHANNEL_INT_EN, info->regs + IMX7D_REG_ADC_INT_EN);
>> +
>> +	imx7d_adc_sample_set(info);
>> +}
>> +
>> +static void imx7d_adc_channel_set(struct imx7d_adc *info)
>> +{
>> +	u32 cfg1 = 0;
>> +	u32 cfg2;
>> +	u32 channel;
>> +
>> +	channel = info->channel;
>> +
>> +	/* the channel choose single conversion, and enable average mode */
>> +	cfg1 |= (IMX7D_REG_ADC_CH_CFG1_CHANNEL_EN |
>> +		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_SINGLE);
>> +	if (info->adc_feature.average_en)
>> +		cfg1 |= IMX7D_REG_ADC_CH_CFG1_CHANNEL_AVG_EN;
>> +
>> +	/*
>> +	 * physical channel 0 chose logical channel A
>> +	 * physical channel 1 chose logical channel B
>> +	 * physical channel 2 chose logical channel C
>> +	 * physical channel 3 chose logical channel D
>> +	 */
>> +	cfg1 |= (channel << IMX7D_REG_ADC_CH_CFG1_CHANNEL_SEL_SHIF);
>> +
>> +	/* read register REG_ADC_CH_A\B\C\D_CFG2, according to the channel chosen */
>> +	cfg2 = readl(info->regs + IMX7D_EACH_CHANNEL_REG_SHIF * channel + 0x10);
> 
> what is the magic 0x10
> 
>> +
>> +	cfg2 |= imx7d_adc_average_num[info->adc_feature.avg_num];
>> +
>> +	/* write the register REG_ADC_CH_A\B\C\D_CFG2, according to the channel chosen */
>> +	writel(cfg2, info->regs + IMX7D_EACH_CHANNEL_REG_SHIF * channel + 0x10);
>> +	writel(cfg1, info->regs + IMX7D_EACH_CHANNEL_REG_SHIF * channel);
>> +}
>> +
>> +static u32 imx7d_adc_get_sample_rate(struct imx7d_adc *info)
>> +{
>> +	/* input clock is always 24MHz */
>> +	u32 input_clk = 24000000;
>> +	u32 analogue_core_clk;
>> +	u32 core_time_unit = info->adc_feature.core_time_unit;
>> +	u32 sample_clk;
>> +	u32 tmp;
>> +
>> +	analogue_core_clk = input_clk / info->pre_div_num;
>> +	tmp = (core_time_unit + 1) * 6;
>> +	sample_clk = analogue_core_clk / tmp;
>> +
>> +	return sample_clk;
return analogue_clock_clk / tmp;

i.e. no point in having the local variable that I can see.


>> +}
>> +
>> +static int imx7d_adc_read_raw(struct iio_dev *indio_dev,
>> +			struct iio_chan_spec const *chan,
>> +			int *val,
>> +			int *val2,
>> +			long mask)
>> +{
>> +	struct imx7d_adc *info = iio_priv(indio_dev);
>> +
>> +	u32 channel;
>> +	long ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&indio_dev->mlock);
>> +		reinit_completion(&info->completion);
>> +
>> +		channel = (chan->channel) & 0x03;
> 
> parenthesis not needed
> 
>> +		info->channel = channel;
>> +		imx7d_adc_channel_set(info);
>> +
>> +		ret = wait_for_completion_interruptible_timeout
>> +				(&info->completion, IMX7D_ADC_TIMEOUT);
>> +		if (ret == 0) {
>> +			mutex_unlock(&indio_dev->mlock);
>> +			return -ETIMEDOUT;
>> +		}
>> +		if (ret < 0) {
>> +			mutex_unlock(&indio_dev->mlock);
>> +			return ret;
>> +		}
>> +
>> +		*val = info->value;
>> +		mutex_unlock(&indio_dev->mlock);
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		info->vref_uv = regulator_get_voltage(info->vref);
>> +		*val = info->vref_uv / 1000;
>> +		*val2 = 12;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = imx7d_adc_get_sample_rate(info);
>> +		*val2 = 0;
> 
> no need to set val2
> 
>> +		return IIO_VAL_INT;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int imx7d_adc_read_data(struct imx7d_adc *info)
>> +{
>> +	u32 channel;
>> +	u32 value;
>> +
>> +	channel = (info->channel) & 0x03;
> 
> parenthesis not needed
> 
>> +
>> +	/*
>> +	 * channel A and B conversion result share one register,
>> +	 * bit[27~16] is the channel B conversion result,
>> +	 * bit[11~0] is the channel A conversion result.
>> +	 * channel C and D is the same.
>> +	 */
>> +	if (channel < 2)
>> +		value = readl(info->regs + IMX7D_REG_ADC_CHA_B_CNV_RSLT);
>> +	else
>> +		value = readl(info->regs + IMX7D_REG_ADC_CHC_D_CNV_RSLT);
>> +	if (channel & 0x1)	/* channel B or D */
>> +		value = (value >> 16) & 0xFFF;
>> +	else			/* channel A or C */
>> +		value &= 0xFFF;
>> +
>> +	return value;
>> +}
>> +
>> +static irqreturn_t imx7d_adc_isr(int irq, void *dev_id)
>> +{
>> +	struct imx7d_adc *info = (struct imx7d_adc *)dev_id;
>> +	int status;
>> +
>> +	status = readl(info->regs + IMX7D_REG_ADC_INT_STATUS);
>> +	if (status & IMX7D_REG_ADC_INT_STATUS_CHANNEL_INT_STATUS) {
>> +		info->value = imx7d_adc_read_data(info);
>> +		complete(&info->completion);
>> +
>> +		/*
>> +		 * The register IMX7D_REG_ADC_INT_STATUS can't clear
>> +		 * itself after read operation, need software to write
>> +		 * 0 to the related bit. Here we clear the channel A/B/C/D
>> +		 * conversion finished flag.
>> +		 */
>> +		status &= ~IMX7D_REG_ADC_INT_STATUS_CHANNEL_INT_STATUS;
>> +		writel(status, info->regs + IMX7D_REG_ADC_INT_STATUS);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	/* For other bits of register IMX7D_REG_ADC_INT_STATUS, ignore them */
>> +	writel(0, info->regs + IMX7D_REG_ADC_INT_STATUS);

This is dubious as it will clear an interrupt that we haven't handled.
I guess it's perhaps a pragmatic protection against something weird
having happened, but as a general rule we shouldn't be acknowledging
an interrupt we haven't done anything about..

If there is a geniune case where we want to do this, then please document it.

>> +	return IRQ_NONE;
>> +}
>> +
>> +static int imx7d_adc_reg_access(struct iio_dev *indio_dev,
>> +			unsigned reg, unsigned writeval,
>> +			unsigned *readval)
>> +{
>> +	struct imx7d_adc *info = iio_priv(indio_dev);
>> +
>> +	if ((readval == NULL) ||
>> +		((reg % 4) || (reg > IMX7D_REG_ADC_ADC_CFG)))
>> +		return -EINVAL;
>> +
>> +	*readval = readl(info->regs + reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_info imx7d_adc_iio_info = {
>> +	.driver_module = THIS_MODULE,
>> +	.read_raw = &imx7d_adc_read_raw,
>> +	.debugfs_reg_access = &imx7d_adc_reg_access,
>> +};
>> +
>> +static const struct of_device_id imx7d_adc_match[] = {
>> +	{ .compatible = "fsl,imx7d-adc", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, imx7d_adc_match);
>> +
>> +static int imx7d_adc_probe(struct platform_device *pdev)
>> +{
>> +	struct imx7d_adc *info;
>> +	struct iio_dev *indio_dev;
>> +	struct resource *mem;
>> +	int irq;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct imx7d_adc));
Convention in IIO has become sizeof(*info));  It tends to be obviously
trivially correct so saves on actually checking the types when reviewing!
(utter nitpick!)
>> +	if (!indio_dev) {
>> +		dev_err(&pdev->dev, "Failed allocating iio device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	info = iio_priv(indio_dev);
>> +	info->dev = &pdev->dev;
>> +
>> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	info->regs = devm_ioremap_resource(&pdev->dev, mem);
>> +	if (IS_ERR(info->regs)) {
>> +		ret = PTR_ERR(info->regs);
>> +		dev_err(&pdev->dev, "failed to remap adc memory: %d\n", ret);
> 
> Failed or failed?
> 
>> +		return ret;
>> +	}
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "no irq resource?\n");
>> +		return irq;
>> +	}
>> +
>> +	info->clk = devm_clk_get(&pdev->dev, "adc");
>> +	if (IS_ERR(info->clk)) {
>> +		ret = PTR_ERR(info->clk);
>> +		dev_err(&pdev->dev, "failed getting clock, err = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	info->vref = devm_regulator_get(&pdev->dev, "vref");
>> +	if (IS_ERR(info->vref)) {
>> +		ret = PTR_ERR(info->vref);
>> +		dev_err(&pdev->dev, "failed getting reference voltage: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regulator_enable(info->vref);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>> +	init_completion(&info->completion);
>> +
>> +	indio_dev->name = dev_name(&pdev->dev);
>> +	indio_dev->dev.parent = &pdev->dev;
>> +	indio_dev->dev.of_node = pdev->dev.of_node;
Interesting, but what's the of_node for here?  It's not used
that I can see.

>> +	indio_dev->info = &imx7d_adc_iio_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = imx7d_adc_iio_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(imx7d_adc_iio_channels);
>> +
>> +	ret = clk_prepare_enable(info->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev,
>> +			"Could not prepare or enable the clock.\n");
>> +		goto error_adc_clk_enable;
>> +	}
>> +
>> +	ret = devm_request_irq(info->dev, irq,
>> +				imx7d_adc_isr, 0,
>> +				dev_name(&pdev->dev), info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
>> +		goto error_iio_device_register;
>> +	}
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
>> +		goto error_iio_device_register;
>> +	}
>> +
>> +	imx7d_adc_feature_config(info);
>> +	imx7d_adc_hw_init(info);
This is always a 'bad smell'...  The few cases of this that had snuck into
IIO are getting cleaned up currently.

If you need to do this init, then we have a race as the iio_device_register
call exposes all userspace and in kernel interfaces - from that call anything
can be turned on etc.  Hence that call should be the last one in init rather
than still needing to initialize the hardware afterwards.

>> +
>> +	return 0;
>> +
>> +error_iio_device_register:
>> +	clk_disable_unprepare(info->clk);
>> +error_adc_clk_enable:
>> +	regulator_disable(info->vref);
>> +
>> +	return ret;
>> +}
>> +
>> +static int imx7d_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct imx7d_adc *info = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +	regulator_disable(info->vref);
>> +	clk_disable_unprepare(info->clk);
> 
> should be in the same order as in _probe(), so
> iio_device_unregister()
> clk_disable_unprepare()
> regulator_disable()
Absolutely.  May not matter from a bug point of view, but makes it
easier to review as it is 'obviously right' rather than requiring
the reviewer to think too much!

See comment below that you may well want to power it down as you do
in suspend somewhere in here.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused imx7d_adc_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct imx7d_adc *info = iio_priv(indio_dev);
>> +	u32 adc_cfg;
>> +
>> +	adc_cfg = readl(info->regs + IMX7D_REG_ADC_ADC_CFG);
>> +	adc_cfg |= IMX7D_REG_ADC_ADC_CFG_ADC_CLK_DOWN |
>> +		   IMX7D_REG_ADC_ADC_CFG_ADC_POWER_DOWN;
>> +	adc_cfg &= ~IMX7D_REG_ADC_ADC_CFG_ADC_EN;
>> +	writel(adc_cfg, info->regs + IMX7D_REG_ADC_ADC_CFG);
Given this stuff sort of reverse that done in the init call, I wonder
if

a) you should have an _exit call - or rename both approriately
b) you should be powering down the device in the remove call using this
new function.  It 'might' power down when you tell it to disable the
regulator, but it might well not if that is either fixed or shared by
other devices.

>> +
>> +	clk_disable_unprepare(info->clk);
>> +	regulator_disable(info->vref);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused imx7d_adc_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct imx7d_adc *info = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = regulator_enable(info->vref);
>> +	if (ret)
Bit uneven on when you spit out messages in here... I'd be tempted
to output a message on each error OR don't output any at all.

>> +		return ret;
>> +
>> +	ret = clk_prepare_enable(info->clk);
>> +	if (ret) {
>> +		dev_err(info->dev,
>> +			"Could not prepare or enable clock.\n");
>> +		regulator_disable(info->vref);
>> +		return ret;
>> +	}
>> +
>> +	imx7d_adc_hw_init(info);
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
>> +
>> +static struct platform_driver imx7d_adc_driver = {
>> +	.probe		= imx7d_adc_probe,
>> +	.remove		= imx7d_adc_remove,
>> +	.driver		= {
>> +		.name	= "imx7d_adc",
>> +		.of_match_table = imx7d_adc_match,
>> +		.pm	= &imx7d_adc_pm_ops,
>> +	},
>> +};
>> +
>> +module_platform_driver(imx7d_adc_driver);
>> +
>> +MODULE_AUTHOR("Haibo Chen <haibo.chen@freescale.com>");
>> +MODULE_DESCRIPTION("Freeacale IMX7D ADC driver");
>> +MODULE_LICENSE("GPL v2");
>>
> 

