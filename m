Return-Path: <ludovic.desroches@atmel.com>
Date: Mon, 18 Jan 2016 08:55:59 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<nicolas.ferre@atmel.com>, <alexandre.belloni@free-electrons.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>, <pmeerw@pmeerw.net>,
	<robh@kernel.org>
Subject: Re: [PATCH v3 1/5] iio:adc:at91_adc8xx: introduce new atmel adc
 driver
Message-ID: <20160118075559.GB10663@odux.rfo.atmel.com>
References: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
 <1452785897-16270-2-git-send-email-ludovic.desroches@atmel.com>
 <569A2937.609@kernel.org>
 <569A2AFC.4000304@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <569A2AFC.4000304@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jan 16, 2016 at 11:35:24AM +0000, Jonathan Cameron wrote:
> On 16/01/16 11:27, Jonathan Cameron wrote:
> > On 14/01/16 15:38, Ludovic Desroches wrote:
> >> This driver supports the new version of the Atmel ADC device introduced
> >> with the SAMA5D2 SoC family.
> >>
> >> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> > Looks good to me.  One totally trivial note inline (which I'm not even going
> > to bother changing whilst applying the patch - a good measure of how trivial ;)
> > 
> > Applied to the togreg branch of iio.git - initially pushed out as testing
> > for the autobuilders to play with it.
> Having said that - just noticed an oddity - why the DEPENDS on INPUT?
> I'll drop that as a probable cut and paste issue as right now it doesn't
> depend on INPUT (might at some later date of course!)  Whilst there - to
> improve general build coverage I've added COMPILE_TEST as an alternative
> to at91 (works fine on my x86_64 compiler for starters)
> 

Yes copy/paste issue. Thanks for the addition of COMPILE_TEST.

Regards

Ludovic

> Doing the COMPILE_TEST option tends to highlight any 'interesting' dependencies
> that happen to get pulled in by other at91 dependencies at the moment and
> reduces the chance of an IIO / kernel wide change breaking the driver.
> 
> Jonathan
> > 
> > Thanks,
> > 
> > Jonathan
> >> ---
> >>  .../bindings/iio/adc/at91-sama5d2_adc.txt          |  28 ++
> >>  drivers/iio/adc/Kconfig                            |  11 +
> >>  drivers/iio/adc/Makefile                           |   1 +
> >>  drivers/iio/adc/at91-sama5d2_adc.c                 | 509 +++++++++++++++++++++
> >>  4 files changed, 549 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> >>  create mode 100644 drivers/iio/adc/at91-sama5d2_adc.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> >> new file mode 100644
> >> index 0000000..3223684
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> >> @@ -0,0 +1,28 @@
> >> +* AT91 SAMA5D2 Analog to Digital Converter (ADC)
> >> +
> >> +Required properties:
> >> +  - compatible: Should be "atmel,sama5d2-adc".
> >> +  - reg: Should contain ADC registers location and length.
> >> +  - interrupts: Should contain the IRQ line for the ADC.
> >> +  - clocks: phandle to device clock.
> >> +  - clock-names: Must be "adc_clk".
> >> +  - vref-supply: Supply used as reference for conversions.
> >> +  - vddana-supply: Supply for the adc device.
> >> +  - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
> >> +  - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
> >> +  - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
> >> +
> >> +Example:
> >> +
> >> +adc: adc@fc030000 {
> >> +	compatible = "atmel,sama5d2-adc";
> >> +	reg = <0xfc030000 0x100>;
> >> +	interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
> >> +	clocks = <&adc_clk>;
> >> +	clock-names = "adc_clk";
> >> +	atmel,min-sample-rate-hz = <200000>;
> >> +	atmel,max-sample-rate-hz = <20000000>;
> >> +	atmel,startup-time-ms = <4>;
> >> +	vddana-supply = <&vdd_3v3_lp_reg>;
> >> +	vref-supply = <&vdd_3v3_lp_reg>;
> >> +}
> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> index 605ff42..f57b4ea 100644
> >> --- a/drivers/iio/adc/Kconfig
> >> +++ b/drivers/iio/adc/Kconfig
> >> @@ -131,6 +131,17 @@ config AT91_ADC
> >>  	  To compile this driver as a module, choose M here: the module will be
> >>  	  called at91_adc.
> >>  
> >> +config AT91_SAMA5D2_ADC
> >> +	tristate "Atmel AT91 SAMA5D2 ADC"
> >> +	depends on ARCH_AT91
> >> +	depends on INPUT
> >> +	help
> >> +	  Say yes here to build support for Atmel SAMA5D2 ADC which is
> >> +	  available on SAMA5D2 SoC family.
> >> +
> >> +	  To compile this driver as a module, choose M here: the module will be
> >> +	  called at91-sama5d2_adc.
> >> +
> >>  config AXP288_ADC
> >>  	tristate "X-Powers AXP288 ADC driver"
> >>  	depends on MFD_AXP20X
> >> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >> index 6435780..fb57e12 100644
> >> --- a/drivers/iio/adc/Makefile
> >> +++ b/drivers/iio/adc/Makefile
> >> @@ -14,6 +14,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
> >>  obj-$(CONFIG_AD7887) += ad7887.o
> >>  obj-$(CONFIG_AD799X) += ad799x.o
> >>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> >> +obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
> >>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
> >>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
> >>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
> >> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >> new file mode 100644
> >> index 0000000..ecb2d90
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >> @@ -0,0 +1,509 @@
> >> +/*
> >> + * Atmel ADC driver for SAMA5D2 devices and compatible.
> >> + *
> >> + * Copyright (C) 2015 Atmel,
> >> + *               2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> >> + *
> >> + * This software is licensed under the terms of the GNU General Public
> >> + * License version 2, as published by the Free Software Foundation, and
> >> + * may be copied, distributed, and modified under those terms.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >> + * GNU General Public License for more details.
> >> + */
> >> +
> >> +#include <linux/bitops.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/sched.h>
> >> +#include <linux/wait.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +#include <linux/regulator/consumer.h>
> >> +
> >> +/* Control Register */
> >> +#define AT91_SAMA5D2_CR		0x00
> >> +/* Software Reset */
> >> +#define	AT91_SAMA5D2_CR_SWRST		BIT(0)
> >> +/* Start Conversion */
> >> +#define	AT91_SAMA5D2_CR_START		BIT(1)
> >> +/* Touchscreen Calibration */
> >> +#define	AT91_SAMA5D2_CR_TSCALIB		BIT(2)
> >> +/* Comparison Restart */
> >> +#define	AT91_SAMA5D2_CR_CMPRST		BIT(4)
> >> +
> >> +/* Mode Register */
> >> +#define AT91_SAMA5D2_MR		0x04
> >> +/* Trigger Selection */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL(v)	((v) << 1)
> >> +/* ADTRG */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG0	0
> >> +/* TIOA0 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG1	1
> >> +/* TIOA1 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG2	2
> >> +/* TIOA2 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG3	3
> >> +/* PWM event line 0 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG4	4
> >> +/* PWM event line 1 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG5	5
> >> +/* TIOA3 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG6	6
> >> +/* RTCOUT0 */
> >> +#define	AT91_SAMA5D2_MR_TRGSEL_TRIG7	7
> >> +/* Sleep Mode */
> >> +#define	AT91_SAMA5D2_MR_SLEEP		BIT(5)
> >> +/* Fast Wake Up */
> >> +#define	AT91_SAMA5D2_MR_FWUP		BIT(6)
> >> +/* Prescaler Rate Selection */
> >> +#define	AT91_SAMA5D2_MR_PRESCAL(v)	((v) << AT91_SAMA5D2_MR_PRESCAL_OFFSET)
> >> +#define	AT91_SAMA5D2_MR_PRESCAL_OFFSET	8
> >> +#define	AT91_SAMA5D2_MR_PRESCAL_MAX	0xff
> >> +/* Startup Time */
> >> +#define	AT91_SAMA5D2_MR_STARTUP(v)	((v) << 16)
> >> +/* Analog Change */
> >> +#define	AT91_SAMA5D2_MR_ANACH		BIT(23)
> >> +/* Tracking Time */
> >> +#define	AT91_SAMA5D2_MR_TRACKTIM(v)	((v) << 24)
> >> +#define	AT91_SAMA5D2_MR_TRACKTIM_MAX	0xff
> >> +/* Transfer Time */
> >> +#define	AT91_SAMA5D2_MR_TRANSFER(v)	((v) << 28)
> >> +#define	AT91_SAMA5D2_MR_TRANSFER_MAX	0x3
> >> +/* Use Sequence Enable */
> >> +#define	AT91_SAMA5D2_MR_USEQ		BIT(31)
> >> +
> >> +/* Channel Sequence Register 1 */
> >> +#define AT91_SAMA5D2_SEQR1	0x08
> >> +/* Channel Sequence Register 2 */
> >> +#define AT91_SAMA5D2_SEQR2	0x0c
> >> +/* Channel Enable Register */
> >> +#define AT91_SAMA5D2_CHER	0x10
> >> +/* Channel Disable Register */
> >> +#define AT91_SAMA5D2_CHDR	0x14
> >> +/* Channel Status Register */
> >> +#define AT91_SAMA5D2_CHSR	0x18
> >> +/* Last Converted Data Register */
> >> +#define AT91_SAMA5D2_LCDR	0x20
> >> +/* Interrupt Enable Register */
> >> +#define AT91_SAMA5D2_IER		0x24
> >> +/* Interrupt Disable Register */
> >> +#define AT91_SAMA5D2_IDR		0x28
> >> +/* Interrupt Mask Register */
> >> +#define AT91_SAMA5D2_IMR		0x2c
> >> +/* Interrupt Status Register */
> >> +#define AT91_SAMA5D2_ISR		0x30
> >> +/* Last Channel Trigger Mode Register */
> >> +#define AT91_SAMA5D2_LCTMR	0x34
> >> +/* Last Channel Compare Window Register */
> >> +#define AT91_SAMA5D2_LCCWR	0x38
> >> +/* Overrun Status Register */
> >> +#define AT91_SAMA5D2_OVER	0x3c
> >> +/* Extended Mode Register */
> >> +#define AT91_SAMA5D2_EMR		0x40
> >> +/* Compare Window Register */
> >> +#define AT91_SAMA5D2_CWR		0x44
> >> +/* Channel Gain Register */
> >> +#define AT91_SAMA5D2_CGR		0x48
> >> +/* Channel Offset Register */
> >> +#define AT91_SAMA5D2_COR		0x4c
> >> +/* Channel Data Register 0 */
> >> +#define AT91_SAMA5D2_CDR0	0x50
> >> +/* Analog Control Register */
> >> +#define AT91_SAMA5D2_ACR		0x94
> >> +/* Touchscreen Mode Register */
> >> +#define AT91_SAMA5D2_TSMR	0xb0
> >> +/* Touchscreen X Position Register */
> >> +#define AT91_SAMA5D2_XPOSR	0xb4
> >> +/* Touchscreen Y Position Register */
> >> +#define AT91_SAMA5D2_YPOSR	0xb8
> >> +/* Touchscreen Pressure Register */
> >> +#define AT91_SAMA5D2_PRESSR	0xbc
> >> +/* Trigger Register */
> >> +#define AT91_SAMA5D2_TRGR	0xc0
> >> +/* Correction Select Register */
> >> +#define AT91_SAMA5D2_COSR	0xd0
> >> +/* Correction Value Register */
> >> +#define AT91_SAMA5D2_CVR		0xd4
> >> +/* Channel Error Correction Register */
> >> +#define AT91_SAMA5D2_CECR	0xd8
> >> +/* Write Protection Mode Register */
> >> +#define AT91_SAMA5D2_WPMR	0xe4
> >> +/* Write Protection Status Register */
> >> +#define AT91_SAMA5D2_WPSR	0xe8
> >> +/* Version Register */
> >> +#define AT91_SAMA5D2_VERSION	0xfc
> >> +
> >> +#define AT91_AT91_SAMA5D2_CHAN(num, addr)				\
> >> +	{								\
> >> +		.type = IIO_VOLTAGE,					\
> >> +		.channel = num,						\
> >> +		.address = addr,					\
> >> +		.scan_type = {						\
> >> +			.sign = 'u',					\
> >> +			.realbits = 12,					\
> >> +		},							\
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> >> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> >> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> >> +		.datasheet_name = "CH"#num,				\
> >> +		.indexed = 1,						\
> >> +	}
> >> +
> >> +#define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
> >> +#define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
> >> +
> >> +struct at91_adc_soc_info {
> >> +	unsigned			startup_time;
> >> +	unsigned			min_sample_rate;
> >> +	unsigned			max_sample_rate;
> >> +};
> >> +
> >> +struct at91_adc_state {
> >> +	void __iomem			*base;
> >> +	int				irq;
> >> +	struct clk			*per_clk;
> >> +	struct regulator		*reg;
> >> +	struct regulator		*vref;
> >> +	u32				vref_uv;
> >> +	const struct iio_chan_spec	*chan;
> >> +	bool				conversion_done;
> >> +	u32				conversion_value;
> >> +	struct at91_adc_soc_info	soc_info;
> >> +	wait_queue_head_t		wq_data_available;
> >> +	/*
> >> +	 * lock to prevent concurrent 'single conversion' requests through
> >> +	 * sysfs.
> >> +	 */
> >> +	struct mutex			lock;
> >> +};
> >> +
> >> +static const struct iio_chan_spec at91_adc_channels[] = {
> >> +	AT91_AT91_SAMA5D2_CHAN(0, 0x50),
> >> +	AT91_AT91_SAMA5D2_CHAN(1, 0x54),
> >> +	AT91_AT91_SAMA5D2_CHAN(2, 0x58),
> >> +	AT91_AT91_SAMA5D2_CHAN(3, 0x5c),
> >> +	AT91_AT91_SAMA5D2_CHAN(4, 0x60),
> >> +	AT91_AT91_SAMA5D2_CHAN(5, 0x64),
> >> +	AT91_AT91_SAMA5D2_CHAN(6, 0x68),
> >> +	AT91_AT91_SAMA5D2_CHAN(7, 0x6c),
> >> +	AT91_AT91_SAMA5D2_CHAN(8, 0x70),
> >> +	AT91_AT91_SAMA5D2_CHAN(9, 0x74),
> >> +	AT91_AT91_SAMA5D2_CHAN(10, 0x78),
> >> +	AT91_AT91_SAMA5D2_CHAN(11, 0x7c),
> >> +};
> >> +
> >> +static unsigned at91_adc_startup_time(unsigned startup_time_min,
> >> +				      unsigned adc_clk_khz)
> >> +{
> >> +	const unsigned startup_lookup[] = {
> >> +		  0,   8,  16,  24,
> >> +		 64,  80,  96, 112,
> >> +		512, 576, 640, 704,
> >> +		768, 832, 896, 960
> >> +		};
> >> +	unsigned ticks_min, i;
> >> +
> >> +	/*
> >> +	 * Since the adc frequency is checked before, there is no reason
> >> +	 * to not meet the startup time constraint.
> >> +	 */
> >> +
> >> +	ticks_min = startup_time_min * adc_clk_khz / 1000;
> >> +	for (i = 0; i < ARRAY_SIZE(startup_lookup); i++)
> >> +		if (startup_lookup[i] > ticks_min)
> >> +			break;
> >> +
> >> +	return i;
> >> +}
> >> +
> >> +static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
> >> +{
> >> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> >> +	unsigned f_per, prescal, startup;
> >> +
> >> +	f_per = clk_get_rate(st->per_clk);
> >> +	prescal = (f_per / (2 * freq)) - 1;
> >> +
> >> +	startup = at91_adc_startup_time(st->soc_info.startup_time,
> >> +					freq / 1000);
> >> +
> >> +	at91_adc_writel(st, AT91_SAMA5D2_MR,
> >> +			AT91_SAMA5D2_MR_TRANSFER(2)
> >> +			| AT91_SAMA5D2_MR_STARTUP(startup)
> >> +			| AT91_SAMA5D2_MR_PRESCAL(prescal));
> >> +
> >> +	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
> >> +		freq, startup, prescal);
> >> +}
> >> +
> >> +static unsigned at91_adc_get_sample_freq(struct at91_adc_state *st)
> >> +{
> >> +	unsigned f_adc, f_per = clk_get_rate(st->per_clk);
> >> +	unsigned mr, prescal;
> >> +
> >> +	mr = at91_adc_readl(st, AT91_SAMA5D2_MR);
> >> +	prescal = (mr >> AT91_SAMA5D2_MR_PRESCAL_OFFSET)
> >> +		  & AT91_SAMA5D2_MR_PRESCAL_MAX;
> >> +	f_adc = f_per / (2 * (prescal + 1));
> >> +
> >> +	return f_adc;
> >> +}
> >> +
> >> +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio = private;
> >> +	struct at91_adc_state *st = iio_priv(indio);
> >> +	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
> >> +	u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
> >> +
> >> +	if (status & imr) {
> >> +		st->conversion_value = at91_adc_readl(st, st->chan->address);
> >> +		st->conversion_done = true;
> >> +		wake_up_interruptible(&st->wq_data_available);
> >> +		return IRQ_HANDLED;
> >> +	}
> >> +
> >> +	return IRQ_NONE;
> >> +}
> >> +
> >> +static int at91_adc_read_raw(struct iio_dev *indio_dev,
> >> +			     struct iio_chan_spec const *chan,
> >> +			     int *val, int *val2, long mask)
> >> +{
> >> +	struct at91_adc_state *st = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		mutex_lock(&st->lock);
> >> +
> >> +		st->chan = chan;
> >> +
> >> +		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
> >> +		at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(chan->channel));
> >> +		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
> >> +
> >> +		ret = wait_event_interruptible_timeout(st->wq_data_available,
> >> +						       st->conversion_done,
> >> +						       msecs_to_jiffies(1000));
> >> +		if (ret == 0)
> >> +			ret = -ETIMEDOUT;
> >> +
> >> +		if (ret > 0) {
> >> +			*val = st->conversion_value;
> >> +			ret = IIO_VAL_INT;
> >> +			st->conversion_done = false;
> >> +		}
> >> +
> >> +		at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
> >> +		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
> >> +
> >> +		mutex_unlock(&st->lock);
> >> +		return ret;
> >> +
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val = st->vref_uv / 1000;
> >> +		*val2 = chan->scan_type.realbits;
> >> +		return IIO_VAL_FRACTIONAL_LOG2;
> >> +
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		*val = at91_adc_get_sample_freq(st);
> >> +		return IIO_VAL_INT;
> >> +
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static int at91_adc_write_raw(struct iio_dev *indio_dev,
> >> +			      struct iio_chan_spec const *chan,
> >> +			      int val, int val2, long mask)
> >> +{
> >> +	struct at91_adc_state *st = iio_priv(indio_dev);
> >> +
> >> +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> >> +		return -EINVAL;
> >> +
> >> +	if (val < st->soc_info.min_sample_rate ||
> >> +	    val > st->soc_info.max_sample_rate)
> >> +		return -EINVAL;
> >> +
> >> +	at91_adc_setup_samp_freq(st, val);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct iio_info at91_adc_info = {
> >> +	.read_raw = &at91_adc_read_raw,
> >> +	.write_raw = &at91_adc_write_raw,
> >> +	.driver_module = THIS_MODULE,
> >> +};
> >> +
> >> +static int at91_adc_probe(struct platform_device *pdev)
> >> +{
> >> +	struct iio_dev *indio_dev;
> >> +	struct at91_adc_state *st;
> >> +	struct resource	*res;
> >> +	int ret;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> >> +					  sizeof(struct at91_adc_state));
> > Utter nitpick that isn't going to hold up the patch...
> > I'd have done this as sizeof(*st)) but really doesn't matter.
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	indio_dev->dev.parent = &pdev->dev;
> >> +	indio_dev->name = dev_name(&pdev->dev);
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +	indio_dev->info = &at91_adc_info;
> >> +	indio_dev->channels = at91_adc_channels;
> >> +	indio_dev->num_channels = ARRAY_SIZE(at91_adc_channels);
> >> +
> >> +	st = iio_priv(indio_dev);
> >> +
> >> +	ret = of_property_read_u32(pdev->dev.of_node,
> >> +				   "atmel,min-sample-rate-hz",
> >> +				   &st->soc_info.min_sample_rate);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev,
> >> +			"invalid or missing value for atmel,min-sample-rate-hz\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = of_property_read_u32(pdev->dev.of_node,
> >> +				   "atmel,max-sample-rate-hz",
> >> +				   &st->soc_info.max_sample_rate);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev,
> >> +			"invalid or missing value for atmel,max-sample-rate-hz\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = of_property_read_u32(pdev->dev.of_node, "atmel,startup-time-ms",
> >> +				   &st->soc_info.startup_time);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev,
> >> +			"invalid or missing value for atmel,startup-time-ms\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	init_waitqueue_head(&st->wq_data_available);
> >> +	mutex_init(&st->lock);
> >> +
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	if (!res)
> >> +		return -EINVAL;
> >> +
> >> +	st->base = devm_ioremap_resource(&pdev->dev, res);
> >> +	if (IS_ERR(st->base))
> >> +		return PTR_ERR(st->base);
> >> +
> >> +	st->irq = platform_get_irq(pdev, 0);
> >> +	if (st->irq <= 0) {
> >> +		if (!st->irq)
> >> +			st->irq = -ENXIO;
> >> +
> >> +		return st->irq;
> >> +	}
> >> +
> >> +	st->per_clk = devm_clk_get(&pdev->dev, "adc_clk");
> >> +	if (IS_ERR(st->per_clk))
> >> +		return PTR_ERR(st->per_clk);
> >> +
> >> +	st->reg = devm_regulator_get(&pdev->dev, "vddana");
> >> +	if (IS_ERR(st->reg))
> >> +		return PTR_ERR(st->reg);
> >> +
> >> +	st->vref = devm_regulator_get(&pdev->dev, "vref");
> >> +	if (IS_ERR(st->vref))
> >> +		return PTR_ERR(st->vref);
> >> +
> >> +	ret = devm_request_irq(&pdev->dev, st->irq, at91_adc_interrupt, 0,
> >> +			       pdev->dev.driver->name, indio_dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regulator_enable(st->reg);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regulator_enable(st->vref);
> >> +	if (ret)
> >> +		goto reg_disable;
> >> +
> >> +	st->vref_uv = regulator_get_voltage(st->vref);
> >> +	if (st->vref_uv <= 0) {
> >> +		ret = -EINVAL;
> >> +		goto vref_disable;
> >> +	}
> >> +
> >> +	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
> >> +	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
> >> +
> >> +	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
> >> +
> >> +	ret = clk_prepare_enable(st->per_clk);
> >> +	if (ret)
> >> +		goto vref_disable;
> >> +
> >> +	ret = iio_device_register(indio_dev);
> >> +	if (ret < 0)
> >> +		goto per_clk_disable_unprepare;
> >> +
> >> +	dev_info(&pdev->dev, "version: %x\n",
> >> +		 readl_relaxed(st->base + AT91_SAMA5D2_VERSION));
> >> +
> >> +	return 0;
> >> +
> >> +per_clk_disable_unprepare:
> >> +	clk_disable_unprepare(st->per_clk);
> >> +vref_disable:
> >> +	regulator_disable(st->vref);
> >> +reg_disable:
> >> +	regulator_disable(st->reg);
> >> +	return ret;
> >> +}
> >> +
> >> +static int at91_adc_remove(struct platform_device *pdev)
> >> +{
> >> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >> +	struct at91_adc_state *st = iio_priv(indio_dev);
> >> +
> >> +	iio_device_unregister(indio_dev);
> >> +
> >> +	clk_disable_unprepare(st->per_clk);
> >> +
> >> +	regulator_disable(st->vref);
> >> +	regulator_disable(st->reg);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct of_device_id at91_adc_dt_match[] = {
> >> +	{
> >> +		.compatible = "atmel,sama5d2-adc",
> >> +	}, {
> >> +		/* sentinel */
> >> +	}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, at91_adc_dt_match);
> >> +
> >> +static struct platform_driver at91_adc_driver = {
> >> +	.probe = at91_adc_probe,
> >> +	.remove = at91_adc_remove,
> >> +	.driver = {
> >> +		.name = "at91-sama5d2_adc",
> >> +		.of_match_table = at91_adc_dt_match,
> >> +	},
> >> +};
> >> +module_platform_driver(at91_adc_driver)
> >> +
> >> +MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
> >> +MODULE_DESCRIPTION("Atmel AT91 SAMA5D2 ADC");
> >> +MODULE_LICENSE("GPL v2");
> >>
> > 
> 
