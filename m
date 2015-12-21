Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:48219 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbbLUJiN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 21 Dec 2015 04:38:13 -0500
Date: Mon, 21 Dec 2015 10:38:11 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Ludovic Desroches <ludovic.desroches@atmel.com>
cc: jic23@kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc
 driver
In-Reply-To: <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <alpine.DEB.2.02.1512211029260.14320@pmeerw.net>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com> <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This driver supports the new version of the Atmel ADC device introduced
> with the SAMA5D2 SoC family.

some minor, quick comments below...
 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  27 ++
>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/at91_adc8xx.c                      | 417 +++++++++++++++++++++
>  4 files changed, 456 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
>  create mode 100644 drivers/iio/adc/at91_adc8xx.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> new file mode 100644
> index 0000000..64ad6a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> @@ -0,0 +1,27 @@
> +* AT91 SAMA5D2 Analog to Digital Converter (ADC)
> +
> +Required properties:
> +  - compatible: Should be "atmel,sama5d2-adc".
> +  - reg: Should contain ADC registers location and length.
> +  - interrupts: Should contain the IRQ line for the ADC.
> +  - clocks: phandles to clocks.
> +  - clock-names: tuple listing clock names.
> +      Required elements: "adc_clk", "adc_op_clk". "adc_clk" is the peripheral
> +      clock, "adc_clk" is the sampling clock.
> +  - vref-supply: Supply used as reference for conversions.
> +
> +Optional properties:
> +  - vddana-supply: Supply for the adc device.
> +
> +
> +Example:
> +
> +adc: adc@fc030000 {
> +	compatible = "atmel,sama5d2-adc";
> +	reg = <0xfc030000 0x100>;
> +	interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks = <&adc_clk>, <&adc_op_clk>;
> +	clock-names = "adc_clk", "adc_op_clk";
> +	vddana-supply = <&vdd_3v3_lp_reg>;
> +	vref-supply = <&vdd_3v3_lp_reg>;
> +}
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9162dfe..5819e41 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -131,6 +131,17 @@ config AT91_ADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called at91_adc.
>  
> +config AT91_ADC8xx
> +	tristate "Atmel AT91 ADC 8xx"
> +	depends on ARCH_AT91
> +	depends on INPUT
> +	help
> +	  Say yes here to build support for Atmel ADC 8xx which is available
> +	  from SAMA5D2 SoC family.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called at91_adc8xx.
> +
>  config AXP288_ADC
>  	tristate "X-Powers AXP288 ADC driver"
>  	depends on MFD_AXP20X
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 91a65bf..d684a52 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> +obj-$(CONFIG_AT91_ADC8xx) += at91_adc8xx.o
>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
> diff --git a/drivers/iio/adc/at91_adc8xx.c b/drivers/iio/adc/at91_adc8xx.c
> new file mode 100644
> index 0000000..8b4a6e7
> --- /dev/null
> +++ b/drivers/iio/adc/at91_adc8xx.c
> @@ -0,0 +1,417 @@
> +/*
> + * Atmel ADC driver for SAMA5D2 devices and later.
> + *
> + * Copyright (C) 2015 Atmel,
> + *               2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define ADC_CR		0x00			/* Control Register */

please use a prefix such as AT91_ADC8XX_

> +#define		ADC_CR_SWRST		BIT(0)		/* Software Reset */
> +#define		ADC_CR_START		BIT(1)		/* Start Conversion */
> +#define		ADC_CR_TSCALIB		BIT(2)		/* Touchscreen Calibration */
> +#define		ADC_CR_CMPRST		BIT(4)		/* Comparison Restart */
> +#define ADC_MR		0x04			/* Mode Register */
> +#define		ADC_MR_TRGSEL(v)	(v << 1)	/* Trigger Selection */
> +#define			ADC_MR_TRGSEL_TRIG0	0		/* ADTRG */
> +#define			ADC_MR_TRGSEL_TRIG1	1		/* TIOA0 */
> +#define			ADC_MR_TRGSEL_TRIG2	2		/* TIOA1 */
> +#define			ADC_MR_TRGSEL_TRIG3	3		/* TIOA2 */
> +#define			ADC_MR_TRGSEL_TRIG4	4		/* PWM event line 0 */
> +#define			ADC_MR_TRGSEL_TRIG5	5		/* PWM event line 1 */
> +#define			ADC_MR_TRGSEL_TRIG6	6		/* TIOA3 */
> +#define			ADC_MR_TRGSEL_TRIG7	7		/* RTCOUT0 */
> +#define		ADC_MR_SLEEP		BIT(5)		/* Sleep Mode */
> +#define		ADC_MR_FWUP		BIT(6)		/* Fast Wake Up */
> +#define		ADC_MR_PRESCAL(v)	(v << 8)	/* Prescaler Rate Selection */
> +#define			ADC_MR_PRESCAL_MAX	0xffff
> +#define		ADC_MR_STARTUP(v)	(v << 16)	/* Startup Time */
> +#define			ADC_MR_STARTUP_SUT0	0		/* 0 period of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT8	1		/* 8 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT16	2		/* 16 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT24	3		/* 24 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT64	4		/* 64 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT80	5		/* 80 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT96	6		/* 96 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT112	7		/* 112 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT512	8		/* 512 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT576	9		/* 576 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT640	10		/* 640 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT704	11		/* 704 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT768	12		/* 768 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT832	13		/* 832 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT896	14		/* 896 periods of ADCCLK */
> +#define			ADC_MR_STARTUP_SUT960	15		/* 960 periods of ADCCLK */
> +#define		ADC_MR_ANACH		BIT(23)		/* Analog Change */
> +#define		ADC_MR_TRACKTIM(v)	(v << 24)	/* Tracking Time */
> +#define			ADC_MR_TRACKTIM_MAX	0xff
> +#define		ADC_MR_TRANSFER(v)	(v << 28)	/* Transfer Time */
> +#define			ADC_MR_TRANSFER_MAX	0x3
> +#define		ADC_MR_USEQ		BIT(31)		/* Use Sequence Enable */
> +#define ADC_SEQR1	0x08			/* Channel Sequence Register 1 */
> +#define ADC_SEQR2	0x0c			/* Channel Sequence Register 2 */
> +#define ADC_CHER	0x10			/* Channel Enable Register */
> +#define ADC_CHDR	0x14			/* Channel Disable Register */
> +#define ADC_CHSR	0x18			/* Channel Status Register */
> +#define ADC_LCDR	0x20			/* Last Converted Data Register */
> +#define ADC_IER		0x24			/* Interrupt Enable Register */
> +#define ADC_IDR		0x28			/* Interrupt Disable Register */
> +#define ADC_IMR		0x2c			/* Interrupt Mask Register */
> +#define ADC_ISR		0x30			/* Interrupt Status Register */
> +#define ADC_LCTMR	0x34			/* Last Channel Trigger Mode Register */
> +#define ADC_LCCWR	0x38			/* Last Channel Compare Window Register */
> +#define ADC_OVER	0x3c			/* Overrun Status Register */
> +#define ADC_EMR		0x40			/* Extended Mode Register */
> +#define ADC_CWR		0x44			/* Compare Window Register */
> +#define ADC_CGR		0x48			/* Channel Gain Register */
> +#define ADC_COR		0x4c			/* Channel Offset Register */
> +#define ADC_CDR0	0x50			/* Channel Data Register 0 */
> +#define ADC_ACR		0x94			/* Analog Control Register */
> +#define ADC_TSMR	0xb0			/* Touchscreen Mode Register */
> +#define ADC_XPOSR	0xb4			/* Touchscreen X Position Register */
> +#define ADC_YPOSR	0xb8			/* Touchscreen Y Position Register */
> +#define ADC_PRESSR	0xbc			/* Touchscreen Pressure Register */
> +#define ADC_TRGR	0xc0			/* Trigger Register */
> +#define ADC_COSR	0xd0			/* Correction Select Register */
> +#define ADC_CVR		0xd4			/* Correction Value Register */
> +#define ADC_CECR	0xd8			/* Channel Error Correction Register */
> +#define ADC_WPMR	0xe4			/* Write Protection Mode Register */
> +#define ADC_WPSR	0xe8			/* Write Protection Status Register */
> +#define ADC_VERSION	0xfc			/* Version Register */
> +
> +#define AT91_ADC_CHAN(num, addr)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.channel = num,						\
> +		.address = addr,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 12,					\
> +			.storagebits = 14,				\

storagebits should be a multiple of 8

> +		},							\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.datasheet_name = "CH"#num,				\
> +		.indexed = 1,						\
> +	}
> +
> +#define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
> +#define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
> +
> +struct at91_adc_soc_info {
> +	unsigned			startup_time;
> +	unsigned			min_f_adc;
> +	unsigned			max_f_adc;
> +	const struct iio_chan_spec	*channels;
> +	int				num_channels;
> +};
> +
> +struct at91_adc_state {
> +	void __iomem			*base;
> +	struct clk			*per_clk;
> +	struct clk			*adc_clk;
> +	int				irq;
> +	struct regulator		*reg;
> +	struct regulator		*vref;
> +	u32				vref_uv;
> +	struct at91_adc_soc_info	*soc_info;
> +	wait_queue_head_t		wq_data_available;
> +	bool				done;
> +	const struct iio_chan_spec	*chan;
> +	u32				last_value;
> +	struct mutex			lock;
> +};
> +
> +static struct at91_adc_soc_info at91_adc_sama5d2_soc_info = {
> +	.startup_time = 4,
> +	.min_f_adc = 200000,
> +	.max_f_adc = 20000000,
> +};
> +
> +static const struct iio_chan_spec at91_adc_channels[] = {
> +	AT91_ADC_CHAN(0, 0x50),
> +	AT91_ADC_CHAN(1, 0x54),
> +	AT91_ADC_CHAN(2, 0x58),
> +	AT91_ADC_CHAN(3, 0x5c),
> +	AT91_ADC_CHAN(4, 0x60),
> +	AT91_ADC_CHAN(5, 0x64),
> +	AT91_ADC_CHAN(6, 0x68),
> +	AT91_ADC_CHAN(7, 0x6c),
> +	AT91_ADC_CHAN(8, 0x70),
> +	AT91_ADC_CHAN(9, 0x74),
> +	AT91_ADC_CHAN(10, 0x78),
> +	AT91_ADC_CHAN(11, 0x7c),
> +};
> +
> +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio = private;
> +	struct at91_adc_state *st = iio_priv(indio);
> +	u32 status = at91_adc_readl(st, ADC_ISR);
> +
> +	status &= at91_adc_readl(st, ADC_IMR);
> +	if (status & 0xFFF) {

you are mixing uppercase and lowercase hex constants, i.e. 0xfff vs. 0xFFF

> +		st->last_value = at91_adc_readl(st, st->chan->address);
> +		st->done = true;
> +		wake_up_interruptible(&st->wq_data_available);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static bool at91_adc_freq_supported(struct at91_adc_state *st, unsigned freq)
> +{
> +	return ((freq >= st->soc_info->min_f_adc)
> +		&& (freq <= st->soc_info->max_f_adc));
> +}
> +
> +static unsigned at91_adc_startup_time(unsigned startup_time_min,
> +				      unsigned adc_clk_khz)
> +{
> +	const unsigned startup_lookup[] = {
> +		0,     8,  16,  24,
> +		64,   80,  96, 112,
> +		512, 576, 640, 704,
> +		768, 832, 896, 960
> +		};

do we need the ADC_MR_STARTUP_SUT #defines then?

> +	unsigned ticks_min, i;
> +
> +	/*
> +	 * Since the adc frequency is checked before, there is no reason
> +	 * to not meet the startup time constraint.
> +	 */
> +
> +	ticks_min = startup_time_min * adc_clk_khz / 1000;
> +	for (i = 0; i < ARRAY_SIZE(startup_lookup); i++)
> +		if (startup_lookup[i] > ticks_min)
> +			break;
> +
> +	return i;
> +}
> +
> +static int at91_adc_init(struct at91_adc_state *st)
> +{
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	unsigned f_adc, f_per, prescal, startup;
> +
> +	at91_adc_writel(st, ADC_CR, ADC_CR_SWRST);
> +	at91_adc_writel(st, ADC_IDR, 0xffffffff);
> +
> +	f_adc = clk_get_rate(st->adc_clk);
> +	if (!at91_adc_freq_supported(st, f_adc)) {
> +		dev_err(&indio_dev->dev, "unsupported adc clock frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	f_per = clk_get_rate(st->per_clk);
> +	prescal = (f_per / (2 * f_adc)) - 1;
> +
> +	startup = at91_adc_startup_time(st->soc_info->startup_time,
> +					f_adc / 1000);
> +
> +	at91_adc_writel(st, ADC_MR,
> +			ADC_MR_TRANSFER(2)
> +			| ADC_MR_STARTUP(startup)
> +			| ADC_MR_PRESCAL(prescal));
> +
> +	dev_dbg(&indio_dev->dev, "startup: %u, prescal: %u\n",
> +		startup, prescal);
> +
> +	return 0;
> +}
> +
> +static int at91_adc_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->chan = chan;

why? isn't this potentially dangerous outside the mutex lock?

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +
> +		at91_adc_writel(st, ADC_CHER, BIT(chan->channel));
> +		at91_adc_writel(st, ADC_IER, BIT(chan->channel));
> +		at91_adc_writel(st, ADC_CR, ADC_CR_START);
> +
> +		ret = wait_event_interruptible_timeout(st->wq_data_available,
> +						       st->done,
> +						       msecs_to_jiffies(1000));
> +		if (ret == 0)
> +			ret = -ETIMEDOUT;
> +
> +		if (ret <= 0) {

probably ret < 0

> +			at91_adc_writel(st, ADC_CHDR, BIT(chan->channel));
> +			at91_adc_writel(st, ADC_IDR, BIT(chan->channel));
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +
> +		if (chan->scan_type.sign == 's')

only 'u' is used so far

> +			*val = sign_extend32(st->last_value,
> +					     chan->scan_type.realbits - 1);
> +		else
> +			*val = st->last_value;
> +		at91_adc_writel(st, ADC_CHDR, BIT(chan->channel));
> +		at91_adc_writel(st, ADC_IDR, BIT(chan->channel));
> +		st->done = false;
> +
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_uv / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info at91_adc_info = {
> +	.read_raw = &at91_adc_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int at91_adc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct at91_adc_state *st;
> +	struct resource	*res;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +					  sizeof(struct at91_adc_state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &at91_adc_info;
> +	indio_dev->channels = at91_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(at91_adc_channels);
> +
> +	st = iio_priv(indio_dev);
> +	st->soc_info = (struct at91_adc_soc_info *)
> +			of_device_get_match_data(&pdev->dev);
> +	init_waitqueue_head(&st->wq_data_available);
> +	mutex_init(&st->lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	st->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(st->base))
> +		return PTR_ERR(st->base);
> +
> +	st->irq = platform_get_irq(pdev, 0);
> +	if (st->irq < 0)
> +		return st->irq;
> +
> +	st->per_clk = devm_clk_get(&pdev->dev, "adc_clk");
> +	if (IS_ERR(st->per_clk))
> +		return PTR_ERR(st->per_clk);
> +
> +	st->adc_clk = devm_clk_get(&pdev->dev, "adc_op_clk");
> +	if (IS_ERR(st->adc_clk))
> +		return PTR_ERR(st->adc_clk);
> +
> +	st->reg = devm_regulator_get(&pdev->dev, "vddana");
> +	if (IS_ERR(st->reg))
> +		return PTR_ERR(st->reg);
> +
> +	st->vref = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR(st->vref))
> +		return PTR_ERR(st->vref);
> +
> +	ret = devm_request_irq(&pdev->dev, st->irq, at91_adc_interrupt, 0,
> +			       pdev->dev.driver->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	st->vref_uv = regulator_get_voltage(st->vref);
> +	if (st->vref_uv <= 0) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	ret = at91_adc_init(st);
> +	if (ret)
> +		goto error;
> +
> +	ret = clk_prepare_enable(st->adc_clk);
> +	ret = clk_prepare_enable(st->per_clk);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_info(&pdev->dev, "version: %x\n",
> +		 readl_relaxed(st->base + ADC_VERSION));
> +
> +error:
> +	return ret;
> +}
> +
> +static int at91_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	clk_disable_unprepare(st->per_clk);
> +	clk_disable_unprepare(st->adc_clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id at91_adc_dt_match[] = {
> +	{
> +		.compatible = "atmel,sama5d2-adc",
> +		.data = &at91_adc_sama5d2_soc_info
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, at91_adc_dt_match);
> +
> +static struct platform_driver at91_adc_driver = {
> +	.probe = at91_adc_probe,
> +	.remove = at91_adc_remove,
> +	.driver = {
> +		.name = "at91_adc8xx",
> +		.of_match_table = at91_adc_dt_match,
> +	},
> +};
> +module_platform_driver(at91_adc_driver)
> +
> +MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
> +MODULE_DESCRIPTION("Atmel AT91 ADC 8xx");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
