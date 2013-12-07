Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab3LGSym (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Dec 2013 13:54:42 -0500
Message-ID: <52A36EEB.9020707@kernel.org>
Date: Sat, 07 Dec 2013 18:54:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fugang Duan <B38611@freescale.com>
CC: shawn.guo@linaro.org, b20596@freescale.com, mark.rutland@arm.com,
	otavio@ossystems.com.br, pmeerw@pmeerw.net, lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
References: <1386151203-29728-1-git-send-email-B38611@freescale.com> <1386151203-29728-3-git-send-email-B38611@freescale.com>
In-Reply-To: <1386151203-29728-3-git-send-email-B38611@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/04/13 10:00, Fugang Duan wrote:
> Add Freescale Vybrid vf610 adc driver. The driver only support
> ADC software trigger.
>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Jonathan Cameron <jic23@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Otavio Salvador <otavio@ossystems.com.br>
> CC: Peter Meerwald <pmeerw@pmeerw.net>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Mostly looking good, but a fair number of comments inline, particularly
on the proposed userspace interfaces (which should have been clearly documented)

Also, it is often helpful to provide a link to device documentation if
it is available?
I think :

http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fpsp=1&WT_TYPE=Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation

is probably the right one - chapter 37.

For some of the interfaces proposed, I would like to get a better grasp
on whether they actualy want to be exposed to userspace or whether there
are 'right' options given other constraints.



> ---
>  drivers/iio/adc/Kconfig     |   10 +
>  drivers/iio/adc/Makefile    |    1 +
>  drivers/iio/adc/vf610_adc.c |  954 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 965 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 2209f28..1c8b956 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -197,6 +197,16 @@ config TWL6030_GPADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called twl6030-gpadc.
>
> +config VF610_ADC
> +	tristate "Freescale vf610 ADC driver"
> +	help
> +	  Say yes here if you want support for the Vybrid board analog-to-digital
> +	  converter.
> +	  Since the IP is used for i.MX6SLX, the driver also support i.MX6SLX.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called vf610_adc.
> +
>  config VIPERBOARD_ADC
>  	tristate "Viperboard ADC support"
>  	depends on MFD_VIPERBOARD && USB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ba9a10a..6d96b0f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
> +obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> new file mode 100644
> index 0000000..73f611b
> --- /dev/null
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -0,0 +1,954 @@
> +/*
> + * Freescale Vybrid vf610 ADC driver
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_platform.h>
> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/machine.h>
I would not normally expect to see machine.h included in a driver.
Why do you need it?
> +#include <linux/iio/driver.h>
> +
> +/* This will be the driver name the kernel reports */
> +#define DRIVER_NAME "vf610-adc"
> +
> +/* Vybrid/IMX ADC registers */
> +#define VF610_REG_ADC_HC0		0x00
> +#define VF610_REG_ADC_HC1		0x04
> +#define VF610_REG_ADC_HS		0x08
> +#define VF610_REG_ADC_R0		0x0c
> +#define VF610_REG_ADC_R1		0x10
> +#define VF610_REG_ADC_CFG		0x14
> +#define VF610_REG_ADC_GC		0x18
> +#define VF610_REG_ADC_GS		0x1c
> +#define VF610_REG_ADC_CV		0x20
> +#define VF610_REG_ADC_OFS		0x24
> +#define VF610_REG_ADC_CAL		0x28
> +#define VF610_REG_ADC_PCTL		0x30
> +
> +/* Configuration register field define */
> +#define VF610_ADC_MODE_BIT8		0x00
> +#define VF610_ADC_MODE_BIT10		0x04
> +#define VF610_ADC_MODE_BIT12		0x08
> +#define VF610_ADC_MODE_MASK		0x0c
> +#define VF610_ADC_DATA_BIT8_MASK	0xFF
> +#define VF610_ADC_DATA_BIT10_MASK	0x3FF
> +#define VF610_ADC_DATA_BIT12_MASK	0xFFF
> +#define VF610_ADC_BUSCLK2_SEL		0x01
> +#define VF610_ADC_ALTCLK_SEL		0x02
> +#define VF610_ADC_ADACK_SEL		0x03
> +#define VF610_ADC_ADCCLK_MASK		0x03
> +#define VF610_ADC_CLK_DIV2		0x20
> +#define VF610_ADC_CLK_DIV4		0x40
> +#define VF610_ADC_CLK_DIV8		0x60
> +#define VF610_ADC_CLK_MASK		0x60
> +#define VF610_ADC_ADLSMP_LONG		0x10
> +#define VF610_ADC_ADSTS_SHORT		0x100
> +#define VF610_ADC_ADSTS_NORMAL		0x200
> +#define VF610_ADC_ADSTS_LONG		0x300
> +#define VF610_ADC_ADSTS_MASK		0x300
> +#define VF610_ADC_ADLPC_EN		0x80
> +#define VF610_ADC_ADHSC_EN		0x400
> +#define VF610_ADC_REFSEL_VALT		0x100
> +#define VF610_ADC_REFSEL_VBG		0x1000
> +#define VF610_ADC_ADTRG_HARD		0x2000
> +#define VF610_ADC_AVGS_8		0x4000
> +#define VF610_ADC_AVGS_16		0x8000
> +#define VF610_ADC_AVGS_32		0xC000
> +#define VF610_ADC_AVGS_MASK		0xC000
> +#define VF610_ADC_OVWREN		0x10000
> +
> +/* General control register field define */
> +#define VF610_ADC_ADACKEN		0x1
> +#define VF610_ADC_DMAEN			0x2
> +#define VF610_ADC_ACREN			0x4
> +#define VF610_ADC_ACFGT			0x8
> +#define VF610_ADC_ACFE			0x10
> +#define VF610_ADC_AVGEN			0x20
> +#define VF610_ADC_ADCON			0x40
> +#define VF610_ADC_CAL			0x80
> +
> +/* Other field define */
> +#define VF610_ADC_IOPCTL5		0x20
> +#define VF610_ADC_ADCHC(x)		((x) & 0xF)
> +#define VF610_ADC_AIEN			(1 << 7)
> +#define VF610_ADC_CONV_DISABLE		0x1F
> +#define VF610_ADC_HS_COCO0		0x1
> +#define VF610_ADC_CALF			0x2
> +#define VF610_ADC_TIMEOUT		msecs_to_jiffies(100)
> +
> +/*
> + * ADC support 8/10/12 bit mode.
> + * mode <-> group number :
> + * 8 bit mode <-> 0, 10 bit mode <-> 1, 12 bit mode <-> 2
> + */
> +#define VF610_MODE_TO_GRNUM(x)		\
> +	((x == 8) ? 0 : ((x == 10) ? 1 : ((x == 12) ? 2 : 0)))
> +#define VF610_GRNUM_TO_MODE(x)		\
> +	((x == 0) ? 8 : ((x == 1) ? 10 : ((x == 2) ? 12 : 8)))
> +
> +enum clk_sel {
> +	VF610_ADCIOC_BUSCLK_SET,
> +	VF610_ADCIOC_ALTCLK_SET,
> +	VF610_ADCIOC_ADACK_SET,
> +};
> +
> +enum vol_ref {
> +	VF610_ADCIOC_VR_VREF_SET,
> +	VF610_ADCIOC_VR_VALT_SET,
> +	VF610_ADCIOC_VR_VBG_SET,
> +};
> +
> +struct vf610_adc_feature {
> +	enum clk_sel	clk_sel;
> +	enum vol_ref	vol_ref;
> +
> +	int	pctl;
> +	int	clk_div;
> +	int	sample_rate;
> +	int	res_mode;
> +
> +	bool	lpm;
> +	bool	high_speed;
> +	bool	calibration;
> +	bool	continual;
> +	bool	ovwren;
> +	bool	hw_trig;
There are a number of elements in here that are not implemented
and can not currently be enabled.  I would prefer to see these
removed for now and reintroduced in patches introducing those features.

> +	bool	dma_en;
> +	bool	async_clk_en;
> +	bool	hw_average_en;
> +	bool	cmp_func_en;
> +	bool	cmp_range_en;
> +	bool	cmp_greater_en;
> +};
> +
> +struct vf610_adc {
> +	struct device	*dev;
> +	void __iomem	*regs;
> +	struct clk	*clk;
> +
> +	u32	vref_uv;
> +	u32	value;
> +	struct regulator	*vref;
> +	struct vf610_adc_feature	adc_feature;
> +
> +	struct completion	completion;
> +};
> +
> +#define VF610_ADC_CHAN(_idx, _chan_type) {			\
> +	.type = (_chan_type),					\
> +	.indexed = 1,						\
> +	.channel = _idx,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> +	VF610_ADC_CHAN(0, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(1, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(2, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(3, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(4, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(5, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(6, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(7, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(8, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(9, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(10, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(11, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(12, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(13, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(14, IIO_VOLTAGE),
> +	VF610_ADC_CHAN(15, IIO_VOLTAGE),
> +};
> +
> +/*
> + * ADC sample frequency, unit is ADCK cycles.
> + * ADC clk source is ipg clock, which is the same as bus clock.
> + *
> + * ADC conversion time = SFCAdder + AverageNum x (BCT + LSTAdder)
> + * SFCAdder: fix to 8 ADCK cycles
> + * AverageNum: 1, 4, 32 samples for hardware average.
> + * BCT(base Conversion Time):
> + *	- 17 ADCK cycles for 8 bit mode
> + *	- 21 ADCK cycles for 10 bit mode
> + *	- 25 ADCK cycles for 25 bit mode
where did 25 bit mode come from?
> + *LSTAdder(Long Sample Time):
> + *	- 3 ADCK cycles
> + *	- 13 ADCK cycles
> + *	- 25 ADCK cycles
> + *
> + * The first group of sample frequency for 8 bit mode.
> + * The second is for 10 bit, and the third is for 12 bit.
> + *
> + * For each group freqency:
> + * Entry 0,1,2 -> 1 sample for each conversion
> + * Entry 4,5,6 -> hardware average 4 samples
> + * Entry 7,8,9 -> hardware average 32 samples
> + * Note: software trigger use 1 sample for one conversion.
> + */
> +static const u16 vf610_sample_freq_avail[3][9] = {
> +	{28, 38, 50, 88, 128, 176, 648, 968, 1352},
> +	{32, 42, 54, 104, 144, 192, 776, 1096, 1480},
> +	{36, 46, 58, 120, 160, 208, 904, 1224, 1608},
> +};
> +
> +static void vf610_adc_cfg_init(struct vf610_adc *info)
> +{
> +	struct device_node *np = info->dev->of_node;
> +
> +	/* set default Configuration for ADC controller */
> +	info->adc_feature.clk_sel = VF610_ADCIOC_BUSCLK_SET;
> +	info->adc_feature.vol_ref = VF610_ADCIOC_VR_VREF_SET;
> +
> +	info->adc_feature.calibration = true;
> +	info->adc_feature.continual = false;
> +	info->adc_feature.ovwren = true;
> +	info->adc_feature.hw_trig = false;
> +	info->adc_feature.dma_en = false;
> +	info->adc_feature.async_clk_en = false;
> +	info->adc_feature.hw_average_en	= false;
> +	info->adc_feature.cmp_func_en = false;
> +	info->adc_feature.cmp_range_en = false;
> +	info->adc_feature.cmp_greater_en = false;
> +	info->adc_feature.high_speed = false;
> +
> +	info->adc_feature.clk_div = 1;
> +	info->adc_feature.sample_rate = 1;
> +	info->adc_feature.res_mode = 12;
> +	info->adc_feature.lpm = true;
> +
> +	if (of_property_read_u32(np, "fsl,adc-io-pinctl",
> +			&info->adc_feature.pctl)) {
> +		info->adc_feature.pctl = VF610_ADC_IOPCTL5;
> +		dev_info(info->dev,
> +			"Missing adc-io-pinctl in dt, enable pin SE5.\n");
> +	}
> +}
> +
> +static void vf610_adc_cfg_post_set(struct vf610_adc *info)
> +{
> +	struct vf610_adc_feature *adc_feature = &info->adc_feature;
> +	int cfg_data = 0;
> +	int gc_data = 0;
> +
> +	switch (adc_feature->clk_sel) {
> +	case VF610_ADCIOC_ALTCLK_SET:
> +		cfg_data |= VF610_ADC_ALTCLK_SEL;
> +		break;
> +	case VF610_ADCIOC_ADACK_SET:
> +		cfg_data |= VF610_ADC_ADACK_SEL;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* low power set for calibration */
> +	cfg_data |= VF610_ADC_ADLPC_EN;
> +
> +	/* enable high speed for calibration */
> +	cfg_data |= VF610_ADC_ADHSC_EN;
> +
> +	/* voltage reference */
> +	switch (adc_feature->vol_ref) {
> +	case VF610_ADCIOC_VR_VREF_SET:
> +		break;
> +	case VF610_ADCIOC_VR_VALT_SET:
> +		cfg_data |= VF610_ADC_REFSEL_VALT;
> +		break;
> +	case VF610_ADCIOC_VR_VBG_SET:
> +		cfg_data |= VF610_ADC_REFSEL_VBG;
> +		break;
> +	default:
> +		dev_err(info->dev, "error voltage reference\n");
> +	}
> +
> +	/* trigger select */
> +	if (adc_feature->hw_trig)
> +		cfg_data |= VF610_ADC_ADTRG_HARD;
> +
> +	/* data overwrite enable */
> +	if (adc_feature->ovwren)
> +		cfg_data |= VF610_ADC_OVWREN;
> +
> +	/* Asynchronous clock output enable */
> +	if (adc_feature->async_clk_en)
> +		gc_data |= VF610_ADC_ADACKEN;
> +
> +	/* dma enable */
> +	if (adc_feature->dma_en)
> +		gc_data |= VF610_ADC_DMAEN;
> +
> +	/* continue function enable */
> +	if (adc_feature->continual)
> +		gc_data |= VF610_ADC_ADCON;
> +
> +	/* compare function enable */
> +	if (adc_feature->cmp_func_en)
> +		gc_data |= VF610_ADC_ACFE;
> +
> +	/* greater than enable */
> +	if (adc_feature->cmp_greater_en)
> +		gc_data |= VF610_ADC_ACFGT;
> +
> +	/* range enable */
> +	if (adc_feature->cmp_range_en)
> +		gc_data |= VF610_ADC_ACREN;
> +
> +	writel(cfg_data, info->regs + VF610_REG_ADC_CFG);
> +	writel(gc_data, info->regs + VF610_REG_ADC_GC);
> +}
> +
> +static void vf610_adc_calibration(struct vf610_adc *info)
> +{
> +	int adc_gc, hc_cfg;
> +	int timeout;
> +
> +	if (!info->adc_feature.calibration)
> +		return;
> +
> +	/* enable calibration interrupt */
> +	hc_cfg = VF610_ADC_AIEN | VF610_ADC_CONV_DISABLE;
> +	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> +
> +	adc_gc = readl(info->regs + VF610_REG_ADC_GC);
> +	writel(adc_gc | VF610_ADC_CAL, info->regs + VF610_REG_ADC_GC);
> +
> +	timeout = wait_for_completion_timeout
> +			(&info->completion, VF610_ADC_TIMEOUT);
> +	if (timeout == 0)
> +		dev_err(info->dev, "Timeout for adc calibration\n");
> +
> +	adc_gc = readl(info->regs + VF610_REG_ADC_GS);
> +	if (adc_gc & VF610_ADC_CALF)
> +		dev_err(info->dev, "ADC calibration failed\n");
> +
> +	info->adc_feature.calibration = false;
> +}
> +
> +static void vf610_adc_cfg_set(struct vf610_adc *info)
> +{
> +	struct vf610_adc_feature *adc_feature = &(info->adc_feature);
> +	int cfg_data;
> +
> +	cfg_data = readl(info->regs + VF610_REG_ADC_CFG);
> +
> +	/* low power configuration */
> +	cfg_data &= ~VF610_ADC_ADLPC_EN;
> +	if (adc_feature->lpm)
> +		cfg_data |= VF610_ADC_ADLPC_EN;
> +
> +	/* high speed operation */
> +	cfg_data &= ~VF610_ADC_ADHSC_EN;
> +	if (adc_feature->high_speed)
> +		cfg_data |= VF610_ADC_ADHSC_EN;
> +
> +	writel(cfg_data, info->regs + VF610_REG_ADC_CFG);
> +}
> +
> +static void vf610_adc_sample_set(struct vf610_adc *info)
> +{
> +	struct vf610_adc_feature *adc_feature = &(info->adc_feature);
> +	int cfg_data, gc_data;
> +
> +	cfg_data = readl(info->regs + VF610_REG_ADC_CFG);
> +	gc_data = readl(info->regs + VF610_REG_ADC_GC);
> +
> +	/* resolution mode */
> +	cfg_data &= ~VF610_ADC_MODE_MASK;
> +	switch (adc_feature->res_mode) {
> +	case 8:
> +		cfg_data |= VF610_ADC_MODE_BIT8;
> +		break;
> +	case 10:
> +		cfg_data |= VF610_ADC_MODE_BIT10;
> +		break;
> +	case 12:
> +		cfg_data |= VF610_ADC_MODE_BIT12;
> +		break;
> +	default:
> +		dev_err(info->dev, "error resolution mode\n");
> +		break;
> +	}
> +
> +	/* clock select and clock devider */
> +	cfg_data &= ~(VF610_ADC_CLK_MASK | VF610_ADC_ADCCLK_MASK);
> +	switch (adc_feature->clk_div) {
> +	case 1:
> +		break;
> +	case 2:
> +		cfg_data |= VF610_ADC_CLK_DIV2;
> +		break;
> +	case 4:
> +		cfg_data |= VF610_ADC_CLK_DIV4;
> +		break;
> +	case 8:
> +		cfg_data |= VF610_ADC_CLK_DIV8;
> +		break;
> +	case 16:
> +		switch (adc_feature->clk_sel) {
> +		case VF610_ADCIOC_BUSCLK_SET:
> +			cfg_data |= VF610_ADC_BUSCLK2_SEL | VF610_ADC_CLK_DIV8;
> +			break;
> +		default:
> +			dev_err(info->dev, "error clk divider\n");
> +			break;
> +		}
> +		break;
> +	}
> +
> +	/* Update the sample time duration */
> +	cfg_data &= ~(VF610_ADC_ADLSMP_LONG | VF610_ADC_ADSTS_MASK);
> +	switch (adc_feature->sample_rate % 3) {
> +	case 0:
> +		break;
> +	case 1:
> +		cfg_data |= VF610_ADC_ADLSMP_LONG;
> +		break;
> +	case 2:
> +		cfg_data |= VF610_ADC_ADLSMP_LONG | VF610_ADC_ADSTS_LONG;
> +		break;
> +	default:
> +		dev_err(info->dev, "Now don't support sample duration\n");
> +		break;
> +	}
> +
> +	/* update hardware average selection */
> +	cfg_data &= ~VF610_ADC_AVGS_MASK;
> +	gc_data &= ~VF610_ADC_AVGEN;
> +	switch (adc_feature->sample_rate / 3) {
> +	case 0:
> +		adc_feature->hw_average_en = false;
> +		break;
> +	case 1:
> +		gc_data |= VF610_ADC_AVGEN;
> +		adc_feature->hw_average_en = true;
> +		break;
> +	case 2:
> +		gc_data |= VF610_ADC_AVGEN;
> +		adc_feature->hw_average_en = true;
> +		cfg_data |= VF610_ADC_AVGS_32;
> +		break;
> +	default:
> +		dev_err(info->dev,
> +			"error hardware sample average select\n");
> +	}
> +
> +	writel(cfg_data, info->regs + VF610_REG_ADC_CFG);
> +	writel(gc_data, info->regs + VF610_REG_ADC_GC);
> +}
> +
> +static void vf610_adc_hw_init(struct vf610_adc *info)
> +{
> +	/* pin control for Sliding rheostat */
> +	writel(info->adc_feature.pctl, info->regs + VF610_REG_ADC_PCTL);
> +
> +	/* CFG: Feature set */
> +	vf610_adc_cfg_post_set(info);
> +	vf610_adc_sample_set(info);
> +
> +	/* adc calibration */
> +	vf610_adc_calibration(info);
> +
> +	/* CFG: power and speed set */
> +	vf610_adc_cfg_set(info);
> +}
> +
> +static int vf610_adc_read_data(struct vf610_adc *info)
> +{
> +	int result;
> +
> +	result = readl(info->regs + VF610_REG_ADC_R0);
> +
> +	switch (info->adc_feature.res_mode) {
> +	case 8:

In this case the defines are obscuring what is going on
so just use 0xFF etc directly here.

> +		result &= VF610_ADC_DATA_BIT8_MASK;
> +		break;
> +	case 10:
> +		result &= VF610_ADC_DATA_BIT10_MASK;
> +		break;
> +	case 12:
> +		result &= VF610_ADC_DATA_BIT12_MASK;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return result;
> +}
> +
> +static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
> +{
> +	struct vf610_adc *info = (struct vf610_adc *)dev_id;
> +	int coco;
> +
> +	coco = readl(info->regs + VF610_REG_ADC_HS);
> +	if (coco & VF610_ADC_HS_COCO0) {
> +		info->value = vf610_adc_read_data(info);
> +		complete(&info->completion);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t vf610_resolution_mode_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", info->adc_feature.res_mode);
> +}
> +
> +static ssize_t vf610_resolution_mode_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	info->adc_feature.res_mode = val;
> +	vf610_adc_sample_set(info);
> +
> +	return len;
> +}
> +
What are there results of entering low power mode?

Right now I am not convinced this could not be automatically
handled in the driver rather than requiring a specific knob.

There is usually a fair bit of resistence to adding this sort
of interface, purely because that chances of any userspace app
handling it correctly are extremely low.
> +static ssize_t vf610_low_power_mode_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", info->adc_feature.lpm);
> +}
> +
> +static ssize_t vf610_low_power_mode_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int val, ret;
> +
strtobool would make more sense I think.
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	info->adc_feature.lpm = val ? true : false;
> +	vf610_adc_cfg_set(info);
> +
> +	return len;
> +}
> +
> +/*
> + * The sys interface to read ADC internal clock frequency.
> + * ADC clock source is ipg clock.
> + * User can set the divider: 1,2,4,8,16
> + *
> + * User can get the sample rate from sysfs interface:
> + * Read "adc_internel_clk", unit is Hz.
> + * Read "adc in_voltage_sampling_frequency", unit is ADCK cycles.
> + *
> + * So, the current sample frequency:
> + * 		adc_internel_clk / in_voltage_sampling_frequency
> + */
> +static ssize_t vf610_read_sample_frequency(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int val, res_grp;
> +
> +	val = clk_get_rate(info->clk);
> +	res_grp = VF610_MODE_TO_GRNUM(info->adc_feature.res_mode);
> +
> +	return sprintf(buf, "adc sample freq: %dHz\n",
> +		val / (info->adc_feature.clk_div *
> +		vf610_sample_freq_avail[res_grp][info->adc_feature.sample_rate]));
> +}
> +
> +static ssize_t vf610_adc_internal_clk_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int val;
> +
> +	val = clk_get_rate(info->clk);
> +
> +	return sprintf(buf, "%d (adc internal clk freq: %dHz)\n",
> +				info->adc_feature.clk_div,
> +				val / info->adc_feature.clk_div);
> +}
> +
> +static ssize_t vf610_adc_internal_clk_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	info->adc_feature.clk_div = val;
> +	vf610_adc_sample_set(info);
> +
> +	return len;
> +}
> +
> +/*
> + * Here, just list sample frequency available for
> + * software trigger.
> + */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("28 32 36 38 42 46 50 54 58");
> +
> +static IIO_DEVICE_ATTR(resolution_mode, S_IWUSR | S_IRUGO,
> +			vf610_resolution_mode_show,
> +			vf610_resolution_mode_store, 0);
> +
> +static IIO_DEVICE_ATTR(low_power_mode, S_IWUSR | S_IRUGO,
> +			vf610_low_power_mode_show,
> +			vf610_low_power_mode_store, 0);
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO,
> +			vf610_read_sample_frequency,
> +			NULL);
> +
> +static IIO_CONST_ATTR(clk_divider_available, "1 2 4 8 16");
> +static IIO_DEVICE_ATTR(adc_internal_clk, S_IWUSR | S_IRUGO,
> +			vf610_adc_internal_clk_show,
> +			vf610_adc_internal_clk_store, 0);
I am guessing that the two above are related to the same control?
That isn't implied by there names!
> +
> +static struct attribute *vf610_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,

Please use the info_mask elements for the relevant channel and add
support to read_raw for samp_freq rather than hand coding it here.
I'm in the process of pulling all of these out in favour of that
support as if it is done like this, then there is no access to these
values for drivers within the kernel.

> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
Whilst I have proposed a framework to handle *_available attributes
via the core, it isn't ready to merge yet so this is currently the
right way to do this one!

> +	&iio_dev_attr_resolution_mode.dev_attr.attr,
I raised this question before - is there a use case for polled
acess (as provided so far in this driver) which is already
inherently slow in which one would want to vary the resolution?
If there is then this should be added as a new info_mask element
and provided by the read_raw/write_raw callbacks.

> +	&iio_dev_attr_low_power_mode.dev_attr.attr,
Some comments on this above.

> +	&iio_dev_attr_adc_internal_clk.dev_attr.attr,
These are very low level interfaces that won't make much sense
to expose to userspace.  There is no documentation on when one
would change this that I can see.  It probably effects a number
of things...

The possibly related long sample configuration is interesting..

>From the datasheet, these would typically
be changed to cope with high impedances or to allow for fast
operation / lower power operation  when the impedance of the connected source
is low....  Given this is about coping with input impedances I'd
argue that this is perhaps something that does belong in device tree
perhaps as a 'hint' on the input impedance.   The driver when
then only offer possible sampling frequencies given the restrictions
applied whatever is being measured (reflected in the clk divider).

> +	&iio_const_attr_clk_divider_available.dev_attr.attr,
Anything here that is no currently documented in
Documentation/bindings/testing/sysfs-bus-iio* needs to be proposed formally
as a new ABI element with documentation.

> +	NULL
> +};
> +
> +static const struct attribute_group vf610_attribute_group = {
> +	.attrs = vf610_attributes,
> +};
> +
> +static int vf610_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val,
> +			int *val2,
> +			long mask)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	unsigned int hc_cfg;
> +	unsigned long ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		reinit_completion(&info->completion);
> +
> +		hc_cfg = VF610_ADC_ADCHC(chan->channel);
> +		hc_cfg |= VF610_ADC_AIEN;
> +		writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> +		ret = wait_for_completion_interruptible_timeout
> +				(&info->completion, VF610_ADC_TIMEOUT);
> +		*val = info->value;
> +
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +		if (ret < 0)

return ret here - it will be -RESTARTSYS currently
but that's not to say the wait_for_completion call won't ever be
changed to return something more informative...

> +			return -ERESTARTSYS;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = info->vref_uv / 1000;
> +		*val2 = info->adc_feature.res_mode;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = VF610_MODE_TO_GRNUM(info->adc_feature.res_mode);
> +		*val = vf610_sample_freq_avail[ret][info->adc_feature.sample_rate];
> +		*val2 = 0;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int vf610_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val,
> +			int val2,
> +			long mask)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int i, j;
> +
> +	switch (mask) {
> +		case IIO_CHAN_INFO_SAMP_FREQ:
Please add a sanity check on val2 == 0 in here as that would indicate
an 'unexpected' input and should return -EINVAL.
> +			for (i = 0;
> +				i < ARRAY_SIZE(vf610_sample_freq_avail);
> +				i++)
> +				for (j = 0;
> +					j < ARRAY_SIZE(vf610_sample_freq_avail[0]);
> +					j++)
> +					if (val == vf610_sample_freq_avail[i][j]) {
> +						info->adc_feature.res_mode =
> +							VF610_GRNUM_TO_MODE(i);
> +						info->adc_feature.sample_rate = j;
> +						vf610_adc_sample_set(info);
> +						return 0;
> +					}
> +
> +			break;
> +
> +		default:
> +			break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int vf610_adc_reg_access(struct iio_dev *indio_dev,
> +			unsigned reg, unsigned writeval,
> +			unsigned *readval)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +
> +	if (readval == NULL)
> +		return -EINVAL;
> +
> +	*readval = readl(info->regs + reg);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info vf610_adc_iio_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &vf610_read_raw,
> +	.write_raw = &vf610_write_raw,
> +	.debugfs_reg_access = &vf610_adc_reg_access,
> +	.attrs = &vf610_attribute_group,
> +};
> +
> +static const struct of_device_id vf610_adc_match[] = {
> +	{ .compatible = "fsl,vf610-adc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, vf610_adc_dt_ids);
> +
> +static int vf610_adc_probe(struct platform_device *pdev)
> +{
> +	struct vf610_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	info = iio_priv(indio_dev);
> +	info->dev = &pdev->dev;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0) {
> +		dev_err(&pdev->dev, "no irq resource?\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(info->dev, irq,
> +				vf610_adc_isr, 0,
> +				dev_name(&pdev->dev), info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> +		return ret;
> +	}
> +
> +	info->clk = devm_clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(info->clk)) {
> +		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> +						PTR_ERR(info->clk));
> +		ret = PTR_ERR(info->clk);
> +		return ret;
> +	}
> +
> +	info->vref = devm_regulator_get(&pdev->dev, "vref");
I'd prefer the logic to be flipped here as it will give cleaner
code and conforms to a more standard pattern (thus making it
ever so slightly easier to review ;)

i.e.

	if (IS_ERR(info->vref))
		return PTR_ERR(info->vref);

	ret = regulator_enable(info->vref);
	if (ret)
		return ret;

	info->vref_uv = regulator_get_voltage(info->vref);

> +	if (!IS_ERR(info->vref)) {
> +		ret = regulator_enable(info->vref);
> +		if (ret)
> +			return ret;
> +
> +		info->vref_uv = regulator_get_voltage(info->vref);
> +	} else {
> +		return PTR_ERR(info->vref);
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&info->completion);
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->info = &vf610_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = vf610_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
> +
> +	ret = clk_prepare_enable(info->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Could not prepare or enable the clock.\n");
> +		goto error_adc_clk_enable;
> +	}
> +
> +	vf610_adc_cfg_init(info);
> +	vf610_adc_hw_init(info);
> +
Do not use the devm_iio_device_register here as you have stuff to
do in the remove.
Thus the userspace interfaces for the driver will still be present after
the regulator and clock have been disabled giving some possible interesting
results.

Note that the devm_ irq usage is also possibly risky so needs very careful
verification that there is no way an interrupt can occur during the remove.
I'd advise against using it.

Unfortunately, whilst devm stuff is great for simple allocations it
gets a little complex when there is anything else going on.

> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
> +		goto error_iio_device_register;
> +	}
> +
> +	return 0;
> +
> +
> +error_iio_device_register:
> +	clk_disable_unprepare(info->clk);
> +error_adc_clk_enable:
> +	regulator_disable(info->vref);
> +
> +	return ret;
> +}
> +
> +static int vf610_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +
> +	regulator_disable(info->vref);
> +	clk_disable_unprepare(info->clk);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int vf610_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int hc_cfg;
> +
> +	/* ADC controller enters to stop mode */
> +	hc_cfg = readl(info->regs + VF610_REG_ADC_HC0);
> +	hc_cfg |= VF610_ADC_CONV_DISABLE;
> +	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> +
> +	clk_disable_unprepare(info->clk);
> +	regulator_disable(info->vref);
> +
> +	return 0;
> +}
> +
> +static int vf610_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(info->vref);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(info->clk);
> +	if (ret)
> +		return ret;
> +
> +	vf610_adc_hw_init(info);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops,
> +			vf610_adc_suspend,
> +			vf610_adc_resume);
> +
> +static struct platform_driver vf610_adc_driver = {
> +	.probe          = vf610_adc_probe,
> +	.remove         = vf610_adc_remove,
> +	.driver         = {
> +		.name   = DRIVER_NAME,
> +		.owner  = THIS_MODULE,
> +		.of_match_table = vf610_adc_match,
> +		.pm     = &vf610_adc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(vf610_adc_driver);
> +
> +MODULE_AUTHOR("Fugang Duan <B38611@freescale.com>");
> +MODULE_DESCRIPTION("Freescale VF610 ADC driver");
> +MODULE_LICENSE("GPL v2");
>
