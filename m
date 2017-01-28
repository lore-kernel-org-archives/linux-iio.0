Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46951 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdA1Sgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 13:36:49 -0500
Subject: Re: [PATCH v2 1/7] iio: adc: stm32: add support for triggered buffer
 mode
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
 <1485440915-30119-2-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a4320428-d175-89f1-aad2-dcf4fd7375b7@kernel.org>
Date: Sat, 28 Jan 2017 18:36:44 +0000
MIME-Version: 1.0
In-Reply-To: <1485440915-30119-2-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/17 14:28, Fabrice Gasnier wrote:
> STM32 ADC conversions can be launched using hardware triggers.
> It can be used to start conversion sequences (group of channels).
> Selected channels are select via sequence registers.
> Trigger source is selected via 'extsel' (external trigger mux).
> Trigger polarity is set to rising edge by default.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I thought about leaving this longer to see if anyone else wanted
to comment, but seeing as the changes are minor and the original
patches were about for over a week I'm happy to take these now.

If anyone was planning on taking a look, give me a shout and I'll
yank them back out for a bit.

Anyhow, I've pulled in the immutable branch from mfd to get the
prerequisites and applied this to my togreg branch - initially pushed
out as testing to see what the autobuilders make of them.

This series came together very nicely (and quickly *touch wood*)

Thanks,

Jonathan 
> ---
> Changes in v2:
> based on Jonathan's comments:
> - remove all STM32F4_SQx[SHIFT/MASK], put the numbers directly in sq
>   description array.
> - make data buffer part of stm32_adc structure (remove preenable and
>   postdisable routines)
> - add comment on reading DR to clear OEC flag
> - use bitmap_weight()
> - fix error handling in stm32_adc_buffer_postenable()
> ---
>  drivers/iio/adc/Kconfig     |   2 +
>  drivers/iio/adc/stm32-adc.c | 317 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 298 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9c8b558..33341f4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -446,6 +446,8 @@ config STM32_ADC_CORE
>  	depends on ARCH_STM32 || COMPILE_TEST
>  	depends on OF
>  	depends on REGULATOR
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Select this option to enable the core driver for STMicroelectronics
>  	  STM32 analog-to-digital converter (ADC).
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 5715e79..1e382b6 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -22,6 +22,10 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -58,21 +62,37 @@
>  
>  /* STM32F4_ADC_CR2 - bit fields */
>  #define STM32F4_SWSTART			BIT(30)
> +#define STM32F4_EXTEN_SHIFT		28
>  #define STM32F4_EXTEN_MASK		GENMASK(29, 28)
> +#define STM32F4_EXTSEL_SHIFT		24
> +#define STM32F4_EXTSEL_MASK		GENMASK(27, 24)
>  #define STM32F4_EOCS			BIT(10)
>  #define STM32F4_ADON			BIT(0)
>  
> -/* STM32F4_ADC_SQR1 - bit fields */
> -#define STM32F4_L_SHIFT			20
> -#define STM32F4_L_MASK			GENMASK(23, 20)
> -
> -/* STM32F4_ADC_SQR3 - bit fields */
> -#define STM32F4_SQ1_SHIFT		0
> -#define STM32F4_SQ1_MASK		GENMASK(4, 0)
> -
> +#define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
>  #define STM32_ADC_TIMEOUT_US		100000
>  #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
>  
> +/* External trigger enable */
> +enum stm32_adc_exten {
> +	STM32_EXTEN_SWTRIG,
> +	STM32_EXTEN_HWTRIG_RISING_EDGE,
> +	STM32_EXTEN_HWTRIG_FALLING_EDGE,
> +	STM32_EXTEN_HWTRIG_BOTH_EDGES,
> +};
> +
> +/**
> + * stm32_adc_regs - stm32 ADC misc registers & bitfield desc
> + * @reg:		register offset
> + * @mask:		bitfield mask
> + * @shift:		left shift
> + */
> +struct stm32_adc_regs {
> +	int reg;
> +	int mask;
> +	int shift;
> +};
> +
>  /**
>   * struct stm32_adc - private data of each ADC IIO instance
>   * @common:		reference to ADC block common data
> @@ -82,15 +102,19 @@
>   * @clk:		clock for this adc instance
>   * @irq:		interrupt for this adc instance
>   * @lock:		spinlock
> + * @bufi:		data buffer index
> + * @num_conv:		expected number of scan conversions
>   */
>  struct stm32_adc {
>  	struct stm32_adc_common	*common;
>  	u32			offset;
>  	struct completion	completion;
> -	u16			*buffer;
> +	u16			buffer[STM32_ADC_MAX_SQ];
>  	struct clk		*clk;
>  	int			irq;
>  	spinlock_t		lock;		/* interrupt lock */
> +	unsigned int		bufi;
> +	unsigned int		num_conv;
>  };
>  
>  /**
> @@ -126,6 +150,33 @@ struct stm32_adc_chan_spec {
>  };
>  
>  /**
> + * stm32f4_sq - describe regular sequence registers
> + * - L: sequence len (register & bit field)
> + * - SQ1..SQ16: sequence entries (register & bit field)
> + */
> +static const struct stm32_adc_regs stm32f4_sq[STM32_ADC_MAX_SQ + 1] = {
> +	/* L: len bit field description to be kept as first element */
> +	{ STM32F4_ADC_SQR1, GENMASK(23, 20), 20 },
> +	/* SQ1..SQ16 registers & bit fields (reg, mask, shift) */
> +	{ STM32F4_ADC_SQR3, GENMASK(4, 0), 0 },
> +	{ STM32F4_ADC_SQR3, GENMASK(9, 5), 5 },
> +	{ STM32F4_ADC_SQR3, GENMASK(14, 10), 10 },
> +	{ STM32F4_ADC_SQR3, GENMASK(19, 15), 15 },
> +	{ STM32F4_ADC_SQR3, GENMASK(24, 20), 20 },
> +	{ STM32F4_ADC_SQR3, GENMASK(29, 25), 25 },
> +	{ STM32F4_ADC_SQR2, GENMASK(4, 0), 0 },
> +	{ STM32F4_ADC_SQR2, GENMASK(9, 5), 5 },
> +	{ STM32F4_ADC_SQR2, GENMASK(14, 10), 10 },
> +	{ STM32F4_ADC_SQR2, GENMASK(19, 15), 15 },
> +	{ STM32F4_ADC_SQR2, GENMASK(24, 20), 20 },
> +	{ STM32F4_ADC_SQR2, GENMASK(29, 25), 25 },
> +	{ STM32F4_ADC_SQR1, GENMASK(4, 0), 0 },
> +	{ STM32F4_ADC_SQR1, GENMASK(9, 5), 5 },
> +	{ STM32F4_ADC_SQR1, GENMASK(14, 10), 10 },
> +	{ STM32F4_ADC_SQR1, GENMASK(19, 15), 15 },
> +};
> +
> +/**
>   * STM32 ADC registers access routines
>   * @adc: stm32 adc instance
>   * @reg: reg offset in adc instance
> @@ -211,6 +262,104 @@ static void stm32_adc_stop_conv(struct stm32_adc *adc)
>  }
>  
>  /**
> + * stm32_adc_conf_scan_seq() - Build regular channels scan sequence
> + * @indio_dev: IIO device
> + * @scan_mask: channels to be converted
> + *
> + * Conversion sequence :
> + * Configure ADC scan sequence based on selected channels in scan_mask.
> + * Add channels to SQR registers, from scan_mask LSB to MSB, then
> + * program sequence len.
> + */
> +static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	u32 val, bit;
> +	int i = 0;
> +
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> +		chan = indio_dev->channels + bit;
> +		/*
> +		 * Assign one channel per SQ entry in regular
> +		 * sequence, starting with SQ1.
> +		 */
> +		i++;
> +		if (i > STM32_ADC_MAX_SQ)
> +			return -EINVAL;
> +
> +		dev_dbg(&indio_dev->dev, "%s chan %d to SQ%d\n",
> +			__func__, chan->channel, i);
> +
> +		val = stm32_adc_readl(adc, stm32f4_sq[i].reg);
> +		val &= ~stm32f4_sq[i].mask;
> +		val |= chan->channel << stm32f4_sq[i].shift;
> +		stm32_adc_writel(adc, stm32f4_sq[i].reg, val);
> +	}
> +
> +	if (!i)
> +		return -EINVAL;
> +
> +	/* Sequence len */
> +	val = stm32_adc_readl(adc, stm32f4_sq[0].reg);
> +	val &= ~stm32f4_sq[0].mask;
> +	val |= ((i - 1) << stm32f4_sq[0].shift);
> +	stm32_adc_writel(adc, stm32f4_sq[0].reg, val);
> +
> +	return 0;
> +}
> +
> +/**
> + * stm32_adc_get_trig_extsel() - Get external trigger selection
> + * @trig: trigger
> + *
> + * Returns trigger extsel value, if trig matches, -EINVAL otherwise.
> + */
> +static int stm32_adc_get_trig_extsel(struct iio_trigger *trig)
> +{
> +	return -EINVAL;
> +}
> +
> +/**
> + * stm32_adc_set_trig() - Set a regular trigger
> + * @indio_dev: IIO device
> + * @trig: IIO trigger
> + *
> + * Set trigger source/polarity (e.g. SW, or HW with polarity) :
> + * - if HW trigger disabled (e.g. trig == NULL, conversion launched by sw)
> + * - if HW trigger enabled, set source & polarity
> + */
> +static int stm32_adc_set_trig(struct iio_dev *indio_dev,
> +			      struct iio_trigger *trig)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 val, extsel = 0, exten = STM32_EXTEN_SWTRIG;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (trig) {
> +		ret = stm32_adc_get_trig_extsel(trig);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* set trigger source and polarity (default to rising edge) */
> +		extsel = ret;
> +		exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
> +	}
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	val = stm32_adc_readl(adc, STM32F4_ADC_CR2);
> +	val &= ~(STM32F4_EXTEN_MASK | STM32F4_EXTSEL_MASK);
> +	val |= exten << STM32F4_EXTEN_SHIFT;
> +	val |= extsel << STM32F4_EXTSEL_SHIFT;
> +	stm32_adc_writel(adc, STM32F4_ADC_CR2, val);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +
> +	return 0;
> +}
> +
> +/**
>   * stm32_adc_single_conv() - Performs a single conversion
>   * @indio_dev: IIO device
>   * @chan: IIO channel
> @@ -228,21 +377,20 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	long timeout;
>  	u32 val;
> -	u16 result;
>  	int ret;
>  
>  	reinit_completion(&adc->completion);
>  
> -	adc->buffer = &result;
> +	adc->bufi = 0;
>  
> -	/* Program chan number in regular sequence */
> -	val = stm32_adc_readl(adc, STM32F4_ADC_SQR3);
> -	val &= ~STM32F4_SQ1_MASK;
> -	val |= chan->channel << STM32F4_SQ1_SHIFT;
> -	stm32_adc_writel(adc, STM32F4_ADC_SQR3, val);
> +	/* Program chan number in regular sequence (SQ1) */
> +	val = stm32_adc_readl(adc, stm32f4_sq[1].reg);
> +	val &= ~stm32f4_sq[1].mask;
> +	val |= chan->channel << stm32f4_sq[1].shift;
> +	stm32_adc_writel(adc, stm32f4_sq[1].reg, val);
>  
>  	/* Set regular sequence len (0 for 1 conversion) */
> -	stm32_adc_clr_bits(adc, STM32F4_ADC_SQR1, STM32F4_L_MASK);
> +	stm32_adc_clr_bits(adc, stm32f4_sq[0].reg, stm32f4_sq[0].mask);
>  
>  	/* Trigger detection disabled (conversion can be launched in SW) */
>  	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2, STM32F4_EXTEN_MASK);
> @@ -258,7 +406,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  	} else if (timeout < 0) {
>  		ret = timeout;
>  	} else {
> -		*res = result;
> +		*res = adc->buffer[0];
>  		ret = IIO_VAL_INT;
>  	}
>  
> @@ -301,17 +449,56 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  static irqreturn_t stm32_adc_isr(int irq, void *data)
>  {
>  	struct stm32_adc *adc = data;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>  	u32 status = stm32_adc_readl(adc, STM32F4_ADC_SR);
>  
>  	if (status & STM32F4_EOC) {
> -		*adc->buffer = stm32_adc_readw(adc, STM32F4_ADC_DR);
> -		complete(&adc->completion);
> +		/* Reading DR also clears EOC status flag */
> +		adc->buffer[adc->bufi] = stm32_adc_readw(adc, STM32F4_ADC_DR);
> +		if (iio_buffer_enabled(indio_dev)) {
> +			adc->bufi++;
> +			if (adc->bufi >= adc->num_conv) {
> +				stm32_adc_conv_irq_disable(adc);
> +				iio_trigger_poll(indio_dev->trig);
> +			}
> +		} else {
> +			complete(&adc->completion);
> +		}
>  		return IRQ_HANDLED;
>  	}
>  
>  	return IRQ_NONE;
>  }
>  
> +/**
> + * stm32_adc_validate_trigger() - validate trigger for stm32 adc
> + * @indio_dev: IIO device
> + * @trig: new trigger
> + *
> + * Returns: 0 if trig matches one of the triggers registered by stm32 adc
> + * driver, -EINVAL otherwise.
> + */
> +static int stm32_adc_validate_trigger(struct iio_dev *indio_dev,
> +				      struct iio_trigger *trig)
> +{
> +	return stm32_adc_get_trig_extsel(trig) < 0 ? -EINVAL : 0;
> +}
> +
> +static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
> +
> +	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
>  			      const struct of_phandle_args *iiospec)
>  {
> @@ -350,11 +537,86 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
>  
>  static const struct iio_info stm32_adc_iio_info = {
>  	.read_raw = stm32_adc_read_raw,
> +	.validate_trigger = stm32_adc_validate_trigger,
> +	.update_scan_mode = stm32_adc_update_scan_mode,
>  	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
>  	.of_xlate = stm32_adc_of_xlate,
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Can't set trigger\n");
> +		return ret;
> +	}
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret < 0)
> +		goto err_clr_trig;
> +
> +	/* Reset adc buffer index */
> +	adc->bufi = 0;
> +
> +	stm32_adc_conv_irq_enable(adc);
> +	stm32_adc_start_conv(adc);
> +
> +	return 0;
> +
> +err_clr_trig:
> +	stm32_adc_set_trig(indio_dev, NULL);
> +
> +	return ret;
> +}
> +
> +static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	stm32_adc_stop_conv(adc);
> +	stm32_adc_conv_irq_disable(adc);
> +
> +	ret = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret < 0)
> +		dev_err(&indio_dev->dev, "predisable failed\n");
> +
> +	if (stm32_adc_set_trig(indio_dev, NULL))
> +		dev_err(&indio_dev->dev, "Can't clear trigger\n");
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops stm32_adc_buffer_setup_ops = {
> +	.postenable = &stm32_adc_buffer_postenable,
> +	.predisable = &stm32_adc_buffer_predisable,
> +};
> +
> +static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
> +
> +	/* reset buffer index */
> +	adc->bufi = 0;
> +	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> +					   pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	/* re-enable eoc irq */
> +	stm32_adc_conv_irq_enable(adc);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  				    struct iio_chan_spec *chan,
>  				    const struct stm32_adc_chan_spec *channel,
> @@ -471,14 +733,26 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_clk_disable;
>  
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 &iio_pollfunc_store_time,
> +					 &stm32_adc_trigger_handler,
> +					 &stm32_adc_buffer_setup_ops);
> +	if (ret) {
> +		dev_err(&pdev->dev, "buffer setup failed\n");
> +		goto err_clk_disable;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "iio dev register failed\n");
> -		goto err_clk_disable;
> +		goto err_buffer_cleanup;
>  	}
>  
>  	return 0;
>  
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
>  err_clk_disable:
>  	clk_disable_unprepare(adc->clk);
>  
> @@ -491,6 +765,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	clk_disable_unprepare(adc->clk);
>  
>  	return 0;
> 

