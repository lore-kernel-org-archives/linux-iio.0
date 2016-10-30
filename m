Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42521 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbcJ3P17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 11:27:59 -0400
Subject: Re: [PATCH 02/10] iio: adc: Add stm32 support
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
 <1477412722-24061-3-git-send-email-fabrice.gasnier@st.com>
Cc: linux@armlinux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a1445535-5f86-e95d-ed38-03edb8c9f9d8@kernel.org>
Date: Sun, 30 Oct 2016 15:27:54 +0000
MIME-Version: 1.0
In-Reply-To: <1477412722-24061-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 17:25, Fabrice Gasnier wrote:
> This patch adds support for STMicroelectronics STM32 MCU's analog to
> digital converter.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hi Fabrice,

Sometimes I hate SoC ADCs.  For some reason the hardware designers seem to
try and throw everything and the kitchen sink at them.  Discontinuous mode
as an example in this device.  Not seen that particular piece of fun before
and glad to see you haven't 'yet' tried to support it!

Anyhow, the complexity of the hardware leads to an initially complex driver.
My first thought it that this would be easier to follow / review if we
built it up in smaller steps.   Perhaps ditch the injected channel support
entirely in the first instance.  I also wonder if you don't need to support
that whole thing (injected sampling) as another iio device entirely using the
same channels.  That's kind of what it is from a data flow point of view
(we've had arbitary sequencers before with priorities - don't think anyone
ever decided the pain was worth supporting the complexity, but right answer
has always been multiple IIO devices). 

You also have at least one layer of abstraction in here that serves no
current purpose.  Please clear that out for now. It'll make the code
shorter and easier to follow.  If/when other parts are introduced then
is the time to do that transistion to having the abstraction.

My first thought on the double / tripple adc handling is that you'd be better
off handling them as 3 separate devices then doing some 'unusual' trigger
handling to support the weird sequencing.  Guessing you thought about that?
If so could you lay out your reasoning for the single driver instance approach.
I'm not arguing against it btw, merely want to understand your reasoning!

It would be tricky given one set of channels are selectable over 3 devices
and there are constraints to enforce (not sampling same channel on two ADCs
at the same time) but not impossible...  Perhaps what you have here is
indeed simpler!

Whilst it's been a nasty job to review, I'm guessing writing it was
much worse ;)  Pretty good starting point though might take a little while
to pin down the remaining questions on how best to handle this particular
monster.

Jonathan
> ---
>  drivers/iio/adc/Kconfig             |   2 +
>  drivers/iio/adc/Makefile            |   1 +
>  drivers/iio/adc/stm32/Kconfig       |  34 ++
>  drivers/iio/adc/stm32/Makefile      |   4 +
>  drivers/iio/adc/stm32/stm32-adc.c   | 999 ++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/stm32/stm32-adc.h   | 442 ++++++++++++++++
>  drivers/iio/adc/stm32/stm32f4-adc.c | 574 +++++++++++++++++++++
>  7 files changed, 2056 insertions(+)
>  create mode 100644 drivers/iio/adc/stm32/Kconfig
>  create mode 100644 drivers/iio/adc/stm32/Makefile
>  create mode 100644 drivers/iio/adc/stm32/stm32-adc.c
>  create mode 100644 drivers/iio/adc/stm32/stm32-adc.h
>  create mode 100644 drivers/iio/adc/stm32/stm32f4-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7edcf32..5c96a55 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -583,4 +583,6 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called
>  	  xilinx-xadc.
>  
> +source "drivers/iio/adc/stm32/Kconfig"
> +
>  endmenu
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7a40c04..a9dbf3a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_AD7791) += ad7791.o
>  obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD799X) += ad799x.o
> +obj-$(CONFIG_ARCH_STM32) += stm32/
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
> diff --git a/drivers/iio/adc/stm32/Kconfig b/drivers/iio/adc/stm32/Kconfig
> new file mode 100644
> index 0000000..245d037
> --- /dev/null
> +++ b/drivers/iio/adc/stm32/Kconfig
> @@ -0,0 +1,34 @@
> +#
> +# STM32 familly ADC drivers
> +#
> +
> +config STM32_ADC
> +	tristate
> +	select REGULATOR
> +	select REGULATOR_FIXED_VOLTAGE
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build the driver for the STMicroelectronics
> +	  STM32 analog-to-digital converter (ADC).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called stm32-adc.
> +
> +config STM32F4_ADC
> +	tristate "STMicroelectronics STM32F4 adc"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on OF
> +	select STM32_ADC
> +	help
> +	  Say yes here to build support for STMicroelectronics stm32f4 Analog
> +	  to Digital Converter (ADC).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called stm32f4-adc.
> +
> +config STM32_ADC_DEBUG
> +	bool "Enable debug for stm32 ADC drivers"
> +	depends on STM32_ADC
> +	help
> +	  Say "yes" to enable debug messages, on stm32 ADC drivers.
> diff --git a/drivers/iio/adc/stm32/Makefile b/drivers/iio/adc/stm32/Makefile
> new file mode 100644
> index 0000000..83e8154
> --- /dev/null
> +++ b/drivers/iio/adc/stm32/Makefile
> @@ -0,0 +1,4 @@
> +# Core
> +subdir-ccflags-$(CONFIG_STM32_ADC_DEBUG) := -DDEBUG
> +obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> +obj-$(CONFIG_STM32F4_ADC) += stm32f4-adc.o
> diff --git a/drivers/iio/adc/stm32/stm32-adc.c b/drivers/iio/adc/stm32/stm32-adc.c
> new file mode 100644
> index 0000000..1e0850d
> --- /dev/null
> +++ b/drivers/iio/adc/stm32/stm32-adc.c
> @@ -0,0 +1,999 @@
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
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include "stm32-adc.h"
> +
> +/**
> + * stm32_adc_conf_scan_seq() - Build regular or injected channels scan sequence
> + * @indio_dev: IIO device
> + * @scan_mask: channels to be converted
> + *
> + * Conversion sequence :
> + * Configure ADC scan sequence based on selected channels in scan_mask.
> + * Add channels to SQR or JSQR registers, from scan_mask LSB to MSB, then
> + * program sequence len.
> + *
> + * Note: This can be done only when ADC enabled and no conversion is ongoing.
> + */
> +static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	const struct stm32_adc_regs *sq;
> +	const struct iio_chan_spec *chan;
> +	u32 val, bit;
> +	int sq_max, i = 0;
> +
> +	if (!stm32_adc_is_enabled(adc))
> +		return -EBUSY;
> +
> +	if (adc->injected) {
> +		if (stm32_adc_injected_started(adc))
> +			return -EBUSY;
> +
> +		sq = adc->common->data->adc_reginfo->jsqr_reg;
> +		sq_max = STM32_ADC_MAX_JSQ;
> +	} else {
> +		if (stm32_adc_regular_started(adc))
> +			return -EBUSY;
> +
> +		sq = adc->common->data->adc_reginfo->sqr_regs;
> +		sq_max = STM32_ADC_MAX_SQ;
> +	}
> +
> +	/* Build sequence for regular or injected channels */
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> +		chan = indio_dev->channels + bit;
> +		/*
> +		 * Assign one channel per SQ/JSQ entry in regular/injected
> +		 * sequence, starting with SQ1/JSQ1.
> +		 */
> +		i++;
> +		if (i > sq_max)
> +			return -EINVAL;
> +
> +		dev_dbg(adc->common->dev, "%s chan %d to %s%d\n",
> +			__func__, chan->channel, adc->injected ? "JSQ" : "SQ",
> +			i);
> +
> +		val = stm32_adc_readl(adc, sq[i].reg);
> +		val &= ~sq[i].mask;
> +		val |= (chan->channel << sq[i].shift) & sq[i].mask;
> +		stm32_adc_writel(adc, sq[i].reg, val);
> +	}
> +
> +	if (!i)
> +		return -EINVAL;
> +
> +	/* Sequence len */
> +	val = stm32_adc_readl(adc, sq[0].reg);
> +	val &= ~sq[0].mask;
> +	val |= ((i - 1) << sq[0].shift) & sq[0].mask;
> +	stm32_adc_writel(adc, sq[0].reg, val);
> +
> +	return 0;
> +}
> +
> +static int stm32_adc_conf_scan(struct iio_dev *indio_dev,
> +			       const unsigned long *scan_mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = stm32_adc_clk_sel(adc);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Clock sel failed\n");
> +		return ret;
> +	}
> +
> +	ret = stm32_adc_enable(adc);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to enable adc\n");
> +		return ret;
> +	}
> +
> +	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to configure sequence\n");
> +		goto err_dis;
> +	}
It's horrible but to end up in the 'obvious' state I'd disable the adc
again assuming that doesn't kill the stuff that is configured.
> +
> +	return 0;
> +
> +err_dis:
> +	stm32_adc_disable(adc);
> +
> +	return ret;
> +}
> +
> +/**
> + * stm32_adc_get_trig_index() - Get trigger index
> + * @indio_dev: IIO device
> + * @trig: trigger
> + *
> + * Returns trigger index, if trig matches one of the triggers registered by
> + * stm32 adc driver, -EINVAL otherwise.
> + */
> +static int stm32_adc_get_trig_index(struct iio_dev *indio_dev,
> +				    struct iio_trigger *trig)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct iio_trigger *tr;
> +	int i = 0;
> +
> +	list_for_each_entry(tr, &adc->extrig_list, alloc_list) {
> +		if (tr == trig)
> +			return i;
> +		i++;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * stm32_adc_set_trig() - Set a regular or injected trigger
> + * @indio_dev: IIO device
> + * @trig: IIO trigger
> + *
> + * Set trigger source/polarity (e.g. SW, or HW with polarity) :
> + * - if HW trigger disabled (e.g. trig == NULL, conversion launched by sw)
> + * - if HW trigger enabled, set source & polarity (trigger_pol / jtrigger_pol)
> + *
> + * Note: must be called when ADC is enabled
> + */
> +static int stm32_adc_set_trig(struct iio_dev *indio_dev,
> +			      struct iio_trigger *trig)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	const struct stm32_adc_trig_info *trig_info;
> +	const struct stm32_adc_trig_reginfo *reginfo;
> +	u32 val, extsel = 0, exten = STM32_EXTEN_SWTRIG;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!stm32_adc_is_enabled(adc))
> +		return -EBUSY;
> +
> +	if (adc->injected) {
> +		if (stm32_adc_injected_started(adc))
> +			return -EBUSY;
> +		reginfo = adc->common->data->adc_reginfo->jtrig_reginfo;
> +		trig_info = adc->common->data->jext_triggers;
> +	} else {
> +		if (stm32_adc_regular_started(adc))
> +			return -EBUSY;
> +		reginfo = adc->common->data->adc_reginfo->trig_reginfo;
> +		trig_info = adc->common->data->ext_triggers;
> +	}
> +
> +	if (trig) {
> +		ret = stm32_adc_get_trig_index(indio_dev, trig);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* trigger source */
> +		extsel = trig_info[ret].extsel;
> +		exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
> +	}
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	val = stm32_adc_readl(adc, reginfo->reg);
> +	val &= ~(reginfo->exten_mask | reginfo->extsel_mask);
> +	val |= (exten << reginfo->exten_shift) & reginfo->exten_mask;
> +	val |= (extsel << reginfo->extsel_shift) & reginfo->extsel_mask;
> +	stm32_adc_writel(adc, reginfo->reg, val);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +
> +	return 0;
> +}
> +
> +/**
> + * stm32_adc_conv_irq_enable() - Unmask end of conversion irq
> + * @adc: stm32 adc instance
> + *
> + * Unmask either eoc or jeoc, depending on injected configuration.
> + */
> +static void stm32_adc_conv_irq_enable(struct stm32_adc *adc)
> +{
> +	const struct stm32_adc_reginfo *reginfo =
> +		adc->common->data->adc_reginfo;
> +	u32 mask;
> +
> +	if (adc->injected)
> +		mask = reginfo->jeocie;
> +	else
> +		mask = reginfo->eocie;
> +
> +	stm32_adc_set_bits(adc, reginfo->ier, mask);
> +}
> +
> +/**
> + * stm32_adc_conv_irq_disable() - Mask end of conversion irq
> + * @adc: stm32 adc instance
> + *
> + * Mask either eoc or jeoc, depending on injected configuration.
> + */
> +static void stm32_adc_conv_irq_disable(struct stm32_adc *adc)
> +{
> +	const struct stm32_adc_reginfo *reginfo =
> +		adc->common->data->adc_reginfo;
> +	u32 mask;
> +
> +	if (adc->injected)
> +		mask = reginfo->jeocie;
> +	else
> +		mask = reginfo->eocie;
> +
> +	stm32_adc_clr_bits(adc, reginfo->ier, mask);
> +}
> +
> +/**
> + * stm32_adc_single_conv() - perform a single conversion
> + * @indio_dev: IIO device
> + * @chan: IIO channel
> + * @result: conversion result
> + *
> + * The function performs a single conversion on a given channel, by
> + * by:
> + * - creating scan mask with only one channel
> + * - using SW trigger
> + * - then start single conv
> + */
> +static int stm32_adc_single_conv(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 int *val)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	unsigned long *scan_mask;
> +	long timeout;
> +	u16 result;
> +	int ret;
> +
> +	scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength), sizeof(long),
> +			    GFP_KERNEL);
This is known maximum length... I'd just avoid the complexity of allocating
it like this - a comment would do the job to say it is the right length.
> +	if (!scan_mask)
> +		return -ENOMEM;
> +
> +	set_bit(chan->scan_index, scan_mask);
> +
> +	reinit_completion(&adc->completion);
> +
> +	adc->bufi = 0;
> +	adc->num_conv = 1;
> +	adc->buffer = &result;
> +
> +	ret = stm32_adc_conf_scan(indio_dev, scan_mask);
> +	if (ret)
> +		goto free;
> +
> +	/* No HW trigger: conversion can be launched in SW */
> +	ret = stm32_adc_set_trig(indio_dev, NULL);
Put it back again afterwards?  Otherwise some nasty race conditions look
likely to me.. (userspace sets trigger and is about to enable the buffer
when along comes this code and changes it underneath).
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Can't set SW trigger\n");
> +		goto adc_disable;
> +	}
> +
> +	stm32_adc_conv_irq_enable(adc);
> +
> +	ret = stm32_adc_start_conv(adc);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to start single conv\n");
> +		goto irq_disable;
> +	}
> +
> +	timeout = wait_for_completion_interruptible_timeout(
> +					&adc->completion, STM32_ADC_TIMEOUT);
> +	if (timeout == 0) {
> +		dev_warn(&indio_dev->dev, "Conversion timed out!\n");
> +		ret = -ETIMEDOUT;
> +	} else if (timeout < 0) {
> +		dev_warn(&indio_dev->dev, "Interrupted conversion!\n");
> +		ret = -EINTR;
> +	} else {
> +		*val = result & STM32_RESULT_MASK;
> +		ret = IIO_VAL_INT;
> +	}
> +
> +	if (stm32_adc_stop_conv(adc))
> +		dev_err(&indio_dev->dev, "stop failed\n");
> +
> +irq_disable:
> +	stm32_adc_conv_irq_disable(adc);
> +
> +adc_disable:
> +	stm32_adc_disable(adc);
> +
> +free:
> +	kfree(scan_mask);
> +	adc->buffer = NULL;
> +
> +	return ret;
> +}
> +
> +static int stm32_adc_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		if (chan->type == IIO_VOLTAGE)
> +			ret = stm32_adc_single_conv(indio_dev, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = adc->common->vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * stm32_adc_isr() - Treat interrupt for one ADC instance within ADC block
As this is kernel doc please document the parameter as well.  Otherwise
we'll get a pile of warnings!
> + */
> +static irqreturn_t stm32_adc_isr(struct stm32_adc *adc)
> +{
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	const struct stm32_adc_reginfo *reginfo =
> +		adc->common->data->adc_reginfo;
> +	u32 mask, clr_mask, status = stm32_adc_readl(adc, reginfo->isr);
> +
> +	if (adc->injected) {
> +		mask = reginfo->jeoc;
> +		clr_mask = mask;
> +	} else {
> +		mask = reginfo->eoc;
> +		/* don't clear 'eoc' as it is cleared when reading 'dr' */
> +		clr_mask = 0;
> +	}
> +
> +	/* clear irq */
> +	stm32_adc_writel(adc, reginfo->isr, status & ~clr_mask);
Want to do this in the non injected case? it's a noop isn't it?

> +	status &= mask;
> +
> +	/* Regular data */
> +	if (status & reginfo->eoc) {
Hmm.. this is a little bit of 'missuse' of the standard trigger architecture
but as long as it's restricted to just this device I don't suppose we need
to care.  Only reason we need it is to provide control of 'which' hardware
trigger is being used.

Guessing the DMA will almost always be turned on and will make this oddity
effectively disappear.
> +		adc->buffer[adc->bufi] = stm32_adc_readl(adc, reginfo->dr);
> +		if (iio_buffer_enabled(indio_dev)) {
> +			adc->bufi++;
> +			if (adc->bufi >= adc->num_conv) {
> +				stm32_adc_conv_irq_disable(adc);
> +				iio_trigger_poll(indio_dev->trig);
> +			}
> +		} else {
> +			complete(&adc->completion);
> +		}
> +	}
> +
> +	/* Injected data */
> +	if (status & reginfo->jeoc) {
> +		int i;
> +
> +		for (i = 0; i < adc->num_conv; i++) {
> +			adc->buffer[i] = stm32_adc_readl(adc, reginfo->jdr[i]);
> +			adc->bufi++;
> +		}
> +
> +		if (iio_buffer_enabled(indio_dev)) {
> +			stm32_adc_conv_irq_disable(adc);
> +			iio_trigger_poll(indio_dev->trig);
> +		} else {
> +			complete(&adc->completion);
> +		}
> +	}
> +
> +	/*
> +	 * In case end of conversion flags have been handled, this has been
> +	 * handled for this ADC instance
> +	 */
> +	if (status)
> +		return IRQ_HANDLED;
> +
> +	/* This adc instance didn't trigger this interrupt */
> +	return IRQ_NONE;
> +}
> +
> +/**
> + * stm32_adc_common_isr() - Common isr for the whole ADC block
> + *
> + * There is one IRQ for all ADCs in ADC block, check all instances.
> + */
> +static irqreturn_t stm32_adc_common_isr(int irq, void *data)
> +{
> +	struct stm32_adc_common *common = data;
> +	irqreturn_t ret = IRQ_NONE;
> +	struct stm32_adc *adc;
> +
> +	list_for_each_entry(adc, &common->adc_list, adc_list)
> +		ret |= stm32_adc_isr(adc);
Hmm.. ret |= is rather fragile.  Preferable to make the handling of NONE
vs IRQ_HANDLED explicit.

If you were to split the driver up as I suggested might make sense above,
then this would be done with an irq chip in a top level device (effectively
a very simple mfd).
> +
> +	return ret;
> +}
> +
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
> +	return stm32_adc_get_trig_index(indio_dev, trig) < 0 ? -EINVAL : 0;
> +}
> +
> +static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
I'm glad you kept this relatively simple compared to some of the
'fun' the hardware is capable of. Very wise!
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +	u32 bit;
> +
> +	adc->num_conv = 0;
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength)
> +		adc->num_conv++;
> +
> +	ret = stm32_adc_conf_scan(indio_dev, scan_mask);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
> +			      const struct of_phandle_args *iiospec)
> +{
> +	int i;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		if (indio_dev->channels[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * stm32_adc_debugfs_reg_access - read or write register value
> + *
> + * To read a value from an ADC register:
> + *   echo [ADC reg offset] > direct_reg_access
> + *   cat direct_reg_access
> + *
> + * To write a value in a ADC register:
> + *   echo [ADC_reg_offset] [value] > direct_reg_access
> + */
> +static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
> +					unsigned reg, unsigned writeval,
> +					unsigned *readval)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	if (!readval)
> +		stm32_adc_writel(adc, reg, writeval);
> +	else
> +		*readval = stm32_adc_readl(adc, reg);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info stm32_adc_iio_info = {
> +	.read_raw = stm32_adc_read_raw,
> +	.validate_trigger = stm32_adc_validate_trigger,
> +	.update_scan_mode = stm32_adc_update_scan_mode,
> +	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
> +	.of_xlate = stm32_adc_of_xlate,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int stm32_adc_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	stm32_adc_disable(adc);
This is a surprise as postdisbale should balance preenable...
Ah, you have update scan mode enabling the adc.  If you can balance it
better by moving that to preenable please do as it is more 'obviously' correct.
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> +	.postenable = &iio_triggered_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,
> +	.postdisable = &stm32_adc_buffer_postdisable,
> +};
> +
> +static int stm32_adc_validate_device(struct iio_trigger *trig,
> +				     struct iio_dev *indio_dev)
> +{
> +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> +
> +	return indio != indio_dev ? -EINVAL : 0;
> +}
> +
> +static int stm32_adc_set_trigger_state(struct iio_trigger *trig,
> +				       bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (state) {
> +		/* Reset adc buffer index */
> +		adc->bufi = 0;
> +
> +		/* Allocate adc buffer */
> +		adc->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
I'd be more cynical.  It's not that big a memory allocation at worst.
Just put a big enough buffer in your adc structure and don't bother doing
it dynamically.

If you didn't want to do it, it should be in the preenable callback rather
than the trigger state one (for semantic reasons rather than because it's a
bug)
> +		if (!adc->buffer)
> +			return -ENOMEM;
> +
> +		ret = stm32_adc_set_trig(indio_dev, trig);
> +		if (ret) {
> +			dev_err(&indio_dev->dev, "Can't set trigger\n");
> +			goto err_buffer_free;
> +		}
> +
> +		stm32_adc_conv_irq_enable(adc);
> +
> +		ret = stm32_adc_start_conv(adc);
> +		if (ret) {
> +			dev_err(&indio_dev->dev, "Failed to start\n");
> +			goto err_irq_trig_disable;
> +		}
> +	} else {
> +		ret = stm32_adc_stop_conv(adc);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to stop\n");
> +			return ret;
> +		}
> +
> +		stm32_adc_conv_irq_disable(adc);
> +
> +		ret = stm32_adc_set_trig(indio_dev, NULL);
> +		if (ret)
> +			dev_warn(&indio_dev->dev, "Can't clear trigger\n");
> +
> +		kfree(adc->buffer);
> +		adc->buffer = NULL;
> +	}
> +
> +	return 0;
> +
> +err_irq_trig_disable:
> +	stm32_adc_conv_irq_disable(adc);
> +	stm32_adc_set_trig(indio_dev, NULL);
> +
> +err_buffer_free:
> +	kfree(adc->buffer);
> +	adc->buffer = NULL;
> +
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops stm32_adc_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.validate_device = stm32_adc_validate_device,
> +	.set_trigger_state = stm32_adc_set_trigger_state,
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
> +static void stm32_adc_trig_unregister(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct iio_trigger *trig, *_t;
> +
> +	list_for_each_entry_safe(trig, _t, &adc->extrig_list, alloc_list) {
> +		iio_trigger_unregister(trig);
> +		list_del(&trig->alloc_list);
> +	}
> +}
> +
I'd like a bit of documentation on this and a few of the other more
complex functions.  Here it wasn't immediately obvious to me that it
was registering a large set of triggers.  Also, silly question but
do you have any means of controlling the various timer setups from userspace?

There have been numerous discussions over the years on having a generic
timer subsystem, but if anything got written it passed me by. I have a couple
of boards where it would be handy but never had the time to do more than
talk about it ;)
> +static int stm32_adc_trig_register(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct stm32_adc_common *common = adc->common;
> +	const struct stm32_adc_trig_info *ext = common->data->ext_triggers;
> +	struct iio_trigger *trig;
> +	int i, ret = 0;
> +
> +	if (adc->injected)
> +		ext = common->data->jext_triggers;
> +	else
> +		ext = common->data->ext_triggers;
> +
> +	for (i = 0; ext && ext[i].name; i++) {
> +		trig = devm_iio_trigger_alloc(common->dev, "%s_%s%d_%s",
> +					      indio_dev->name,
> +					      adc->injected ? "jext" : "ext",
> +					      ext[i].extsel, ext[i].name);
> +		if (!trig) {
> +			dev_err(common->dev, "trig %s_%s%d_%s alloc failed\n",
> +				indio_dev->name,
> +				adc->injected ? "jext" : "ext",
> +				ext[i].extsel, ext[i].name);
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		trig->dev.parent = common->dev;
> +		trig->ops = &stm32_adc_trigger_ops;
> +		iio_trigger_set_drvdata(trig, indio_dev);
> +
> +		ret = iio_trigger_register(trig);
> +		if (ret) {
> +			dev_err(common->dev,
> +				"trig %s_%s%d_%s register failed\n",
> +				indio_dev->name,
> +				adc->injected ? "jext" : "ext",
> +				ext[i].extsel, ext[i].name);
> +			goto err;
> +		}
> +
> +		list_add_tail(&trig->alloc_list, &adc->extrig_list);
> +	}
> +
> +	return 0;
> +err:
> +	stm32_adc_trig_unregister(indio_dev);
> +
> +	return ret;
> +}
> +
> +static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec *chan,
> +				    const struct stm32_adc_chan_spec *channel,
> +				    int scan_index)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	chan->type = channel->type;
> +	chan->channel = channel->channel;
> +	chan->datasheet_name = channel->name;
> +	chan->extend_name = channel->name;
> +	chan->scan_index = scan_index;
> +	chan->indexed = 1;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	chan->scan_type.sign = 'u';
> +	chan->scan_type.realbits = adc->common->data->highres;
> +	chan->scan_type.storagebits = STM32_STORAGEBITS;
This is one of those cases where actually I'd argue just having the number
here and not under a define would be clearer!  So just put 16 here.
> +	chan->scan_type.shift = 0;
Should be unneeded.  Shift of 0 is the obvious default so no info provided
to readers of the code either really.
> +}
> +
> +static int stm32_adc_chan_of_init(struct iio_dev *indio_dev,
> +				  const struct stm32_adc_info *adc_info)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct device_node *node = indio_dev->dev.of_node;
> +	struct property *prop;
> +	const __be32 *cur;
> +	struct iio_chan_spec *channels;
> +	int scan_index = 0, num_channels = 0;
> +	u32 val;
> +
> +	of_property_for_each_u32(node, "st,adc-channels", prop, cur, val)
> +		num_channels++;
> +
> +	channels = devm_kcalloc(&indio_dev->dev, num_channels,
> +				sizeof(struct iio_chan_spec), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	of_property_for_each_u32(node, "st,adc-channels", prop, cur, val) {
> +		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> +					&adc_info->channels[val],
> +					scan_index);
> +		scan_index++;
> +	}
> +
> +	adc->max_channels = adc_info->max_channels;
> +	indio_dev->num_channels = scan_index;
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}
> +
> +static int stm32_adc_register(struct stm32_adc_common *common,
> +			      struct device_node *child)
> +{
> +	struct iio_dev *indio_dev;
> +	struct stm32_adc *adc;
> +	int i, ret;
> +	u32 reg;
> +
> +	ret = of_property_read_u32(child, "reg", &reg);
> +	if (ret != 0) {
> +		dev_err(common->dev, "missing reg property\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; common->data->adc_info[i].channels; i++)
> +		if (common->data->adc_info[i].reg == reg)
> +			break;
> +
> +	if (i >= STM32_ADC_ID_MAX || !common->data->adc_info[i].channels) {
> +		dev_err(common->dev, "bad adc reg offset\n");
> +		return -ENOENT;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(common->dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err(common->dev, "iio device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc = iio_priv(indio_dev);
> +	adc->id = i;
> +	adc->offset = reg;
> +	adc->common = common;
> +	INIT_LIST_HEAD(&adc->extrig_list);
> +	spin_lock_init(&adc->lock);
> +	init_completion(&adc->completion);
> +
> +	if (child->name)
> +		indio_dev->name = child->name;
> +	else
> +		indio_dev->name = common->data->adc_info[i].name;
> +	indio_dev->dev.parent = common->dev;
> +	indio_dev->dev.of_node = child;
> +	indio_dev->info = &stm32_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (of_property_read_bool(child, "st,injected")) {
> +		dev_dbg(common->dev, "%s Configured to use injected\n",
> +			indio_dev->name);
> +		adc->injected = true;
> +	}
> +
> +	adc->clk = of_clk_get(child, 0);
> +	if (IS_ERR(adc->clk)) {
> +		adc->clk = NULL;
> +		dev_dbg(common->dev, "No child clk found\n");
> +	} else {
> +		ret = clk_prepare_enable(adc->clk);
> +		if (ret < 0)
> +			goto err_clk_put;
> +	}
> +
> +	ret = stm32_adc_chan_of_init(indio_dev, &common->data->adc_info[i]);
> +	if (ret < 0) {
> +		dev_err(common->dev, "iio channels init failed\n");
> +		goto err_clk_disable;
> +	}
> +
> +	ret = stm32_adc_trig_register(indio_dev);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 &iio_pollfunc_store_time,
> +					 &stm32_adc_trigger_handler,
> +					 &iio_triggered_buffer_setup_ops);
> +	if (ret) {
> +		dev_err(common->dev, "buffer setup failed\n");
> +		goto err_trig_unregister;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(common->dev, "iio dev register failed\n");
> +		goto err_buffer_cleanup;
> +	}
> +
> +	list_add_tail(&adc->adc_list, &common->adc_list);
> +
> +	return 0;
> +
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +err_trig_unregister:
> +	stm32_adc_trig_unregister(indio_dev);
> +
> +err_clk_disable:
> +	if (adc->clk)
> +		clk_disable_unprepare(adc->clk);
> +
> +err_clk_put:
> +	if (adc->clk)
> +		clk_put(adc->clk);
> +
> +	return ret;
> +}
> +
> +static void stm32_adc_unregister(struct stm32_adc *adc)
> +{
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	stm32_adc_trig_unregister(indio_dev);
> +	if (adc->clk) {
> +		clk_disable_unprepare(adc->clk);
> +		clk_put(adc->clk);
> +	}
> +}
> +
> +int stm32_adc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node, *child;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	struct stm32_adc_common *common;
> +	struct stm32_adc *adc;
> +	struct resource *res;
> +	int ret;
> +
> +	match = of_match_device(dev->driver->of_match_table, &pdev->dev);
> +	if (!match || !match->data) {
> +		dev_err(&pdev->dev, "compatible data not provided\n");
How would we have instantiated this if there was not a suitable match?
As such what does this check give us? (confused!)
> +		return -EINVAL;
> +	}
> +
> +	common = devm_kzalloc(&pdev->dev, sizeof(*common), GFP_KERNEL);
> +	if (!common)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	common->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(common->base))
> +		return PTR_ERR(common->base);
> +
> +	common->data = match->data;
> +	common->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, common);
> +	mutex_init(&common->lock);
> +	INIT_LIST_HEAD(&common->adc_list);
> +
> +	common->vref = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR(common->vref)) {
> +		ret = PTR_ERR(common->vref);
> +		dev_err(&pdev->dev, "vref get failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(common->vref);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "vref enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_get_voltage(common->vref);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
> +		goto err_regulator_disable;
> +	}
> +	common->vref_mv = ret / 1000;
> +	dev_dbg(&pdev->dev, "vref+=%dmV\n", common->vref_mv);
> +
> +	common->aclk = devm_clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(common->aclk)) {
> +		ret = PTR_ERR(common->aclk);
> +		dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> +		goto err_regulator_disable;
> +	}
> +
> +	ret = clk_prepare_enable(common->aclk);
> +	if (ret < 0) {
> +		dev_err(common->dev, "adc clk enable failed\n");
> +		goto err_regulator_disable;
> +	}
> +
> +	common->irq = platform_get_irq(pdev, 0);
> +	if (common->irq < 0) {
> +		dev_err(&pdev->dev, "failed to get irq\n");
> +		ret = common->irq;
> +		goto err_clk_disable;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, common->irq,	stm32_adc_common_isr,
> +			       0, pdev->name, common);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request irq\n");
> +		goto err_clk_disable;
> +	}
> +
> +	/* Parse adc child nodes to retrieve master/slave instances data */
> +	for_each_available_child_of_node(np, child) {
> +		ret = stm32_adc_register(common, child);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +
> +	dev_info(&pdev->dev, "registered\n");
No benefit in this info being provided (it's obvious, device just turned up
in sysfs :) So drop it.
> +
> +	return 0;
> +
> +err_unregister:
> +	list_for_each_entry(adc, &common->adc_list, adc_list)
> +		stm32_adc_unregister(adc);
> +
> +err_clk_disable:
> +	clk_disable_unprepare(common->aclk);
> +
> +err_regulator_disable:
> +	regulator_disable(common->vref);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_adc_probe);
> +
> +int stm32_adc_remove(struct platform_device *pdev)
> +{
> +	struct stm32_adc_common *common = platform_get_drvdata(pdev);
> +	struct stm32_adc *adc;
> +
> +	list_for_each_entry(adc, &common->adc_list, adc_list)
> +		stm32_adc_unregister(adc);
> +	clk_disable_unprepare(common->aclk);
> +	regulator_disable(common->vref);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stm32_adc_remove);
> +
> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 ADC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/stm32/stm32-adc.h b/drivers/iio/adc/stm32/stm32-adc.h
> new file mode 100644
> index 0000000..0be603c
> --- /dev/null
> +++ b/drivers/iio/adc/stm32/stm32-adc.h
> @@ -0,0 +1,442 @@
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
> +#define STM32_ADCX_COMN_OFFSET		0x300
> +#define STM32_ADC_ID_MAX		3
> +#define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
> +#define STM32_ADC_MAX_JSQ		4	/* JSQ1..JSQ4 */
> +
> +/* STM32 value masks */
> +#define STM32_RESULT_MASK	GENMASK(15, 0)
> +#define STM32_STORAGEBITS	16
> +
> +/* External trigger enable for regular or injected channels (exten/jexten) */
> +enum stm32_adc_exten {
> +	STM32_EXTEN_SWTRIG,
> +	STM32_EXTEN_HWTRIG_RISING_EDGE,
> +	STM32_EXTEN_HWTRIG_FALLING_EDGE,
> +	STM32_EXTEN_HWTRIG_BOTH_EDGES,
> +};
> +
> +enum stm32_adc_extsel {
> +	STM32_EXT0,
> +	STM32_EXT1,
> +	STM32_EXT2,
> +	STM32_EXT3,
> +	STM32_EXT4,
> +	STM32_EXT5,
> +	STM32_EXT6,
> +	STM32_EXT7,
> +	STM32_EXT8,
> +	STM32_EXT9,
> +	STM32_EXT10,
> +	STM32_EXT11,
> +	STM32_EXT12,
> +	STM32_EXT13,
> +	STM32_EXT14,
> +	STM32_EXT15,
> +	STM32_EXT16,
> +	STM32_EXT17,
> +	STM32_EXT18,
> +	STM32_EXT19,
> +	STM32_EXT20,
> +	STM32_EXT21,
> +	STM32_EXT22,
> +	STM32_EXT23,
> +	STM32_EXT24,
> +	STM32_EXT25,
> +	STM32_EXT26,
> +	STM32_EXT27,
> +	STM32_EXT28,
> +	STM32_EXT29,
> +	STM32_EXT30,
> +	STM32_EXT31,
> +};
> +
> +enum stm32_adc_jextsel {
> +	STM32_JEXT0,
> +	STM32_JEXT1,
> +	STM32_JEXT2,
> +	STM32_JEXT3,
> +	STM32_JEXT4,
> +	STM32_JEXT5,
> +	STM32_JEXT6,
> +	STM32_JEXT7,
> +	STM32_JEXT8,
> +	STM32_JEXT9,
> +	STM32_JEXT10,
> +	STM32_JEXT11,
> +	STM32_JEXT12,
> +	STM32_JEXT13,
> +	STM32_JEXT14,
> +	STM32_JEXT15,
> +	STM32_JEXT16,
> +	STM32_JEXT17,
> +	STM32_JEXT18,
> +	STM32_JEXT19,
> +	STM32_JEXT20,
> +	STM32_JEXT21,
> +	STM32_JEXT22,
> +	STM32_JEXT23,
> +	STM32_JEXT24,
> +	STM32_JEXT25,
> +	STM32_JEXT26,
> +	STM32_JEXT27,
> +	STM32_JEXT28,
> +	STM32_JEXT29,
> +	STM32_JEXT30,
> +	STM32_JEXT31,
> +};
> +
> +#define	STM32_ADC_TIMEOUT_US	100000
> +#define	STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
> +
> +/**
> + * struct stm32_adc_chan_spec - specification of stm32 adc channel
> + * @type:	IIO channel type
> + * @channel:	channel number (single ended)
> + * @name:	channel name (single ended)
> + */
> +struct stm32_adc_chan_spec {
> +	enum iio_chan_type	type;
> +	int			channel;
> +	const char		*name;
> +};
> +
> +/**
> + * struct stm32_adc_trig_info - ADC trigger info
> + * @extsel:		trigger selection for regular or injected
> + * @name:		name of the trigger, corresponding to its source
> + */
> +struct stm32_adc_trig_info {
> +	u32 extsel;
> +	const char *name;
> +};
> +
> +/**
> + * struct stm32_adc_info - stm32 ADC, per instance config data
> + * @name:		default name for this instance (like "adc1")
> + * @reg:		reg offset for this instance (e.g. 0x0 for adc1...)
> + * @channels:		Reference to stm32 channels spec
> + * @max_channels:	Number of single ended channels
> + */
> +struct stm32_adc_info {
> +	const char *name;
> +	u32 reg;
> +	const struct stm32_adc_chan_spec *channels;
> +	int max_channels;
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
> +/**
> + * stm32_adc_trig_reginfo - stm32 ADC trigger control registers description
> + * @reg:		trigger control register offset (exten/jexten)
> + * @exten_mask:		external trigger en/polarity mask in @reg
> + * @exten_shift:	external trigger en/polarity shift in @reg
> + * @extsel_mask:	external trigger source mask in @reg
> + * @extsel_shift:	external trigger source shift in @reg
> + */
> +struct stm32_adc_trig_reginfo {
> +	u32 reg;
> +	u32 exten_mask;
> +	u32 exten_shift;
> +	u32 extsel_mask;
> +	u32 extsel_shift;
> +};
> +
> +/**
> + * struct stm32_adc_reginfo - stm32 ADC registers description
> + * @isr:		interrupt status register offset
> + * @eoc:		end of conversion mask in @isr
> + * @jeoc:		end of injected conversion sequence mask in @isr
> + * @ier:		interrupt enable register offset
> + * @eocie:		end of conversion interrupt enable mask in @ier
> + * @jeocie:		end of injected conversion sequence interrupt en mask
> + * @dr:			data register offset
> + * @jdr:		injected data registers offsets
> + * @sqr_regs:		Regular sequence registers description
> + * @jsqr_reg:		Injected sequence register description
> + * @trig_reginfo:	regular trigger control registers description
> + * @jtrig_reginfo:	injected trigger control registers description
> + */
> +struct stm32_adc_reginfo {
> +	u32 isr;
> +	u32 eoc;
> +	u32 jeoc;
> +	u32 ier;
> +	u32 eocie;
> +	u32 jeocie;
> +	u32 dr;
> +	u32 jdr[4];
> +	const struct stm32_adc_regs *sqr_regs;
> +	const struct stm32_adc_regs *jsqr_reg;
> +	const struct stm32_adc_trig_reginfo *trig_reginfo;
> +	const struct stm32_adc_trig_reginfo *jtrig_reginfo;
> +};
> +
> +struct stm32_adc;
> +
> +/**
> + * struct stm32_adc_ops - stm32 ADC, compatible dependent data
> + * - stm32 ADC may work as single ADC, or as tightly coupled master/slave ADCs.
> + *
> + * @adc_info:		Array spec for stm32 adc master/slaves instances
> + * @ext_triggers:	Reference to trigger info for regular channels
> + * @jext_triggers:	Reference to trigger info for injected channels
> + * @adc_reginfo:	stm32 ADC registers description
> + * @highres:		Max resolution
> + * @max_clock_rate:	Max input clock rate
> + * @clk_sel:		routine to select common clock and prescaler
> + * @start_conv:		routine to start conversions
> + * @stop_conv:		routine to stop conversions
> + * @is_started:		routine to get adc 'started' state
> + * @regular_started	routine to check regular conversions status
> + * @injected_started	routine to check injected conversions status
> + * @enable:		optional routine to enable stm32 adc
> + * @disable:		optional routine to disable stm32 adc
> + * @is_enabled		reports enabled state
> + */
This is a big chunk of abstraction that seems excessive at the moment.
I'd rather see it introduced only just before it's actually used..
(I'm guessing it's intended for support of similar parts?)

Right now it just makes the driver harder to review.
> +struct stm32_adc_ops {
> +	const struct stm32_adc_info *adc_info;
> +	const struct stm32_adc_trig_info *ext_triggers;
> +	const struct stm32_adc_trig_info *jext_triggers;
> +	const struct stm32_adc_reginfo *adc_reginfo;
> +	int highres;
> +	unsigned long max_clock_rate;
> +	int (*clk_sel)(struct stm32_adc *adc);
> +	int (*start_conv)(struct stm32_adc *adc);
> +	int (*stop_conv)(struct stm32_adc *adc);
> +	bool (*is_started)(struct stm32_adc *adc);
> +	bool (*regular_started)(struct stm32_adc *adc);
> +	bool (*injected_started)(struct stm32_adc *adc);
> +	int (*enable)(struct stm32_adc *adc);
> +	void (*disable)(struct stm32_adc *adc);
> +	bool (*is_enabled)(struct stm32_adc *adc);
> +};
> +
> +struct stm32_adc_common;
> +
> +/**
> + * struct stm32_adc - private data of each ADC IIO instance
> + * @common:		reference to ADC block common data
> + * @adc_list:		current ADC entry in common ADC list
> + * @id:			ADC instance number (e.g. adc 1, 2 or 3)
> + * @offset:		ADC instance register offset in ADC block
> + * @max_channels:	Max channels number for this ADC.
> + * @extrig_list:	External trigger list (for regular channel)
> + * @completion:		end of single conversion completion
> + * @buffer:		data buffer
> + * @bufi:		data buffer index
> + * @num_conv:		expected number of scan conversions
> + * @injected:		use injected channels on this adc
> + * @lock:		spinlock
> + * @clk:		optional adc clock, for this adc instance
> + * @calib:		optional calibration data
> + * @en:			emulates enabled state on some stm32 adc
> + */
> +struct stm32_adc {
> +	struct stm32_adc_common	*common;
> +	struct list_head	adc_list;
> +	int			id;
> +	int			offset;
> +	int			max_channels;
> +	struct list_head	extrig_list;
> +	struct completion	completion;
> +	u16			*buffer;
> +	int			bufi;
> +	int			num_conv;
> +	bool			injected;
> +	spinlock_t		lock;		/* interrupt lock */
> +	struct clk		*clk;
> +	void			*calib;
> +	bool			en;
> +};
> +
> +/**
> + * struct stm32_adc_common - private data of ADC driver, common to all
> + * ADC instances (ADC block)
> + * @dev:		device for this controller
> + * @base:		control registers base cpu addr
> + * @irq:		Common irq line for all adc instances
> + * @data:		STM32 dependent data from compatible
> + * @adc_list:		list of all stm32 ADC in this ADC block
> + * @aclk:		common clock for the analog circuitry
> + * @vref:		regulator reference
> + * @vref_mv:		vref voltage (mv)
> + * @lock:		mutex
> + */
> +struct stm32_adc_common {
> +	struct device			*dev;
> +	void __iomem			*base;
> +	int				irq;
> +	const struct stm32_adc_ops	*data;
> +	struct list_head		adc_list;
> +	struct clk			*aclk;
> +	struct regulator		*vref;
> +	int				vref_mv;
> +	struct mutex			lock;	/* read_raw lock */
> +};
> +
> +/* Helper routines */
> +static inline int stm32_adc_start_conv(struct stm32_adc *adc)
> +{
> +	return adc->common->data->start_conv(adc);
> +}
> +
> +static inline int stm32_adc_stop_conv(struct stm32_adc *adc)
> +{
> +	return adc->common->data->stop_conv(adc);
> +}
> +
> +static inline bool stm32_adc_is_started(struct stm32_adc *adc)
> +{
> +	return adc->common->data->is_started(adc);
> +}
> +
> +static inline bool stm32_adc_regular_started(struct stm32_adc *adc)
> +{
> +	return adc->common->data->regular_started(adc);
> +}
> +
> +static inline bool stm32_adc_injected_started(struct stm32_adc *adc)
> +{
> +	return adc->common->data->injected_started(adc);
> +}
> +
> +static inline bool stm32_adc_clk_sel(struct stm32_adc *adc)
> +{
> +	return adc->common->data->clk_sel(adc);
> +}
> +
> +static inline int stm32_adc_enable(struct stm32_adc *adc)
> +{
> +	if (adc->common->data->enable)
> +		return adc->common->data->enable(adc);
> +
> +	adc->en = true;
> +
> +	return 0;
> +}
> +
> +static inline bool stm32_adc_is_enabled(struct stm32_adc *adc)
> +{
> +	if (adc->common->data->is_enabled)
> +		return adc->common->data->is_enabled(adc);
> +	else
> +		return adc->en;
> +}
> +
> +static inline void stm32_adc_disable(struct stm32_adc *adc)
> +{
> +	/* Check there is no regular or injected on-going conversions */
> +	if (stm32_adc_is_started(adc))
> +		return;
> +
> +	if (adc->common->data->disable)
> +		adc->common->data->disable(adc);
> +	else
> +		adc->en = false;
> +}
> +
> +/* STM32 ADC registers access routines */
> +static inline u32 stm32_adc_common_readl(struct stm32_adc_common *com, u32 reg)
> +{
> +	u32 val = readl_relaxed(com->base + reg);
> +
> +	return val;
> +}
> +
> +static inline void stm32_adc_common_writel(struct stm32_adc_common *com,
> +					   u32 reg, u32 val)
> +{
> +	writel_relaxed(val, com->base + reg);
> +}
> +
> +static inline u32 stm32_adc_readl(struct stm32_adc *adc, u32 reg)
> +{
> +	u32 val = readl_relaxed(adc->common->base + adc->offset + reg);
> +
> +	return val;
> +}
> +
> +#define stm32_adc_readl_addr(addr)	stm32_adc_readl(adc, addr)
> +
> +#define stm32_adc_readl_poll_timeout(reg, val, cond, sleep_us, timeout_us) \
> +	readx_poll_timeout(stm32_adc_readl_addr, reg, val, \
> +			   cond, sleep_us, timeout_us)
> +
> +static inline void stm32_adc_writel(struct stm32_adc *adc, u32 reg, u32 val)
> +{
> +	writel_relaxed(val, adc->common->base + adc->offset + reg);
> +}
> +
> +static inline void stm32_adc_set_bits(struct stm32_adc *adc, u32 reg, u32 bits)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	stm32_adc_writel(adc, reg, stm32_adc_readl(adc, reg) | bits);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
> +
> +static inline void stm32_adc_clr_bits(struct stm32_adc *adc, u32 reg, u32 bits)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	stm32_adc_writel(adc, reg, stm32_adc_readl(adc, reg) & ~bits);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
> +
> +/* STM32 common extended attributes */
> +extern const struct iio_enum stm32_adc_trig_pol;
> +int stm32_adc_probe(struct platform_device *pdev);
> +int stm32_adc_remove(struct platform_device *pdev);
> +
> +#endif
> diff --git a/drivers/iio/adc/stm32/stm32f4-adc.c b/drivers/iio/adc/stm32/stm32f4-adc.c
> new file mode 100644
> index 0000000..147fe9c
> --- /dev/null
> +++ b/drivers/iio/adc/stm32/stm32f4-adc.c
> @@ -0,0 +1,574 @@
> +/*
> + * This file is part of STM32F4 ADC driver
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
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/platform_device.h>
> +#include "stm32-adc.h"
> +
> +/*
> + * STM32F4 - ADC global register map
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
> +
> +/* STM32F4 - Registers for each ADC instance */
> +#define STM32F4_ADCX_SR			0x00
> +#define STM32F4_ADCX_CR1		0x04
> +#define STM32F4_ADCX_CR2		0x08
> +#define STM32F4_ADCX_SMPR1		0x0C
> +#define STM32F4_ADCX_SMPR2		0x10
> +#define STM32F4_ADCX_HTR		0x24
> +#define STM32F4_ADCX_LTR		0x28
> +#define STM32F4_ADCX_SQR1		0x2C
> +#define STM32F4_ADCX_SQR2		0x30
> +#define STM32F4_ADCX_SQR3		0x34
> +#define STM32F4_ADCX_JSQR		0x38
> +#define STM32F4_ADCX_JDR1		0x3C
> +#define STM32F4_ADCX_JDR2		0x40
> +#define STM32F4_ADCX_JDR3		0x44
> +#define STM32F4_ADCX_JDR4		0x48
> +#define STM32F4_ADCX_DR			0x4C
> +
> +/* STM32 - Master & slave registers (common for all instances: 1, 2 & 3) */
> +#define STM32F4_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
> +#define STM32F4_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x04)
> +#define STM32F4_ADC_CDR			(STM32_ADCX_COMN_OFFSET + 0x08)
> +
> +/* STM32F4_ADCX_SR - bit fields */
> +#define STM32F4_OVR			BIT(5)
> +#define STM32F4_STRT			BIT(4)
> +#define STM32F4_JSTRT			BIT(3)
> +#define STM32F4_JEOC			BIT(2)
> +#define STM32F4_EOC			BIT(1)
> +#define STM32F4_AWD			BIT(0)
> +
> +/* STM32F4_ADCX_CR1 - bit fields */
> +#define STM32F4_OVRIE			BIT(26)
> +#define STM32F4_RES_SHIFT		24
> +#define STM32F4_RES_MASK		GENMASK(25, 24)
> +#define STM32F4_AWDEN			BIT(23)
> +#define STM32F4_JAWDEN			BIT(22)
> +#define STM32F4_DISCNUM_SHIFT		13
> +#define STM32F4_DISCNUM_MASK		GENMASK(15, 13)
> +#define STM32F4_JDISCEN			BIT(12)
> +#define STM32F4_DISCEN			BIT(11)
> +#define STM32F4_JAUTO			BIT(10)
> +#define STM32F4_AWDSGL			BIT(9)
> +#define STM32F4_SCAN			BIT(8)
> +#define STM32F4_JEOCIE			BIT(7)
> +#define STM32F4_AWDIE			BIT(6)
> +#define STM32F4_EOCIE			BIT(5)
> +#define STM32F4_AWDCH_SHIFT		0
> +#define STM32F4_AWDCH_MASK		GENMASK(4, 0)
> +
> +/* STM32F4_ADCX_CR2 - bit fields */
> +#define STM32F4_SWSTART			BIT(30)
> +#define STM32F4_EXTEN_SHIFT		28
> +#define STM32F4_EXTEN_MASK		GENMASK(29, 28)
> +#define STM32F4_EXTSEL_SHIFT		24
> +#define STM32F4_EXTSEL_MASK		GENMASK(27, 24)
> +#define STM32F4_JSWSTART		BIT(22)
> +#define STM32F4_JEXTEN_SHIFT		20
> +#define STM32F4_JEXTEN_MASK		GENMASK(21, 20)
> +#define STM32F4_JEXTSEL_SHIFT		16
> +#define STM32F4_JEXTSEL_MASK		GENMASK(19, 16)
> +#define STM32F4_ALIGN			BIT(11)
> +#define STM32F4_EOCS			BIT(10)
> +#define STM32F4_DDS			BIT(9)
> +#define STM32F4_DMA			BIT(8)
> +#define STM32F4_CONT			BIT(1)
> +#define STM32F4_ADON			BIT(0)
> +
> +/* STM32F4_ADCX_SMPR1 - bit fields */
> +#define STM32F4_SMP18_SHIFT		24
> +#define STM32F4_SMP18_MASK		GENMASK(26, 24)
> +#define STM32F4_SMP17_SHIFT		21
> +#define STM32F4_SMP17_MASK		GENMASK(23, 21)
> +#define STM32F4_SMP16_SHIFT		18
> +#define STM32F4_SMP16_MASK		GENMASK(20, 18)
> +#define STM32F4_SMP15_SHIFT		15
> +#define STM32F4_SMP15_MASK		GENMASK(17, 15)
> +#define STM32F4_SMP14_SHIFT		12
> +#define STM32F4_SMP14_MASK		GENMASK(14, 12)
> +#define STM32F4_SMP13_SHIFT		9
> +#define STM32F4_SMP13_MASK		GENMASK(11, 9)
> +#define STM32F4_SMP12_SHIFT		6
> +#define STM32F4_SMP12_MASK		GENMASK(8, 6)
> +#define STM32F4_SMP11_SHIFT		3
> +#define STM32F4_SMP11_MASK		GENMASK(5, 3)
> +#define STM32F4_SMP10_SHIFT		0
> +#define STM32F4_SMP10_MASK		GENMASK(2, 0)
> +
> +/* STM32F4_ADCX_SMPR2 - bit fields */
> +#define STM32F4_SMP9_SHIFT		27
> +#define STM32F4_SMP9_MASK		GENMASK(29, 27)
> +#define STM32F4_SMP8_SHIFT		24
> +#define STM32F4_SMP8_MASK		GENMASK(26, 24)
> +#define STM32F4_SMP7_SHIFT		21
> +#define STM32F4_SMP7_MASK		GENMASK(23, 21)
> +#define STM32F4_SMP6_SHIFT		18
> +#define STM32F4_SMP6_MASK		GENMASK(20, 18)
> +#define STM32F4_SMP5_SHIFT		15
> +#define STM32F4_SMP5_MASK		GENMASK(17, 15)
> +#define STM32F4_SMP4_SHIFT		12
> +#define STM32F4_SMP4_MASK		GENMASK(14, 12)
> +#define STM32F4_SMP3_SHIFT		9
> +#define STM32F4_SMP3_MASK		GENMASK(11, 9)
> +#define STM32F4_SMP2_SHIFT		6
> +#define STM32F4_SMP2_MASK		GENMASK(8, 6)
> +#define STM32F4_SMP1_SHIFT		3
> +#define STM32F4_SMP1_MASK		GENMASK(5, 3)
> +#define STM32F4_SMP0_SHIFT		0
> +#define STM32F4_SMP0_MASK		GENMASK(2, 0)
> +enum stm32f4_adc_smpr {
> +	STM32F4_SMPR_3_CK_CYCLES,
> +	STM32F4_SMPR_15_CK_CYCLES,
> +	STM32F4_SMPR_28_CK_CYCLES,
> +	STM32F4_SMPR_56_CK_CYCLES,
> +	STM32F4_SMPR_84_CK_CYCLES,
> +	STM32F4_SMPR_112_CK_CYCLES,
> +	STM32F4_SMPR_144_CK_CYCLES,
> +	STM32F4_SMPR_480_CK_CYCLES,
> +};
> +
> +/* STM32F4_ADCX_SQR1 - bit fields */
> +#define STM32F4_L_SHIFT			20
> +#define STM32F4_L_MASK			GENMASK(23, 20)
> +#define STM32F4_SQ16_SHIFT		15
> +#define STM32F4_SQ16_MASK		GENMASK(19, 15)
> +#define STM32F4_SQ15_SHIFT		10
> +#define STM32F4_SQ15_MASK		GENMASK(14, 10)
> +#define STM32F4_SQ14_SHIFT		5
> +#define STM32F4_SQ14_MASK		GENMASK(9, 5)
> +#define STM32F4_SQ13_SHIFT		0
> +#define STM32F4_SQ13_MASK		GENMASK(4, 0)
> +
> +/* STM32F4_ADCX_SQR2 - bit fields */
> +#define STM32F4_SQ12_SHIFT		25
> +#define STM32F4_SQ12_MASK		GENMASK(29, 25)
> +#define STM32F4_SQ11_SHIFT		20
> +#define STM32F4_SQ11_MASK		GENMASK(24, 20)
> +#define STM32F4_SQ10_SHIFT		15
> +#define STM32F4_SQ10_MASK		GENMASK(19, 15)
> +#define STM32F4_SQ9_SHIFT		10
> +#define STM32F4_SQ9_MASK		GENMASK(14, 10)
> +#define STM32F4_SQ8_SHIFT		5
> +#define STM32F4_SQ8_MASK		GENMASK(9, 5)
> +#define STM32F4_SQ7_SHIFT		0
> +#define STM32F4_SQ7_MASK		GENMASK(4, 0)
> +
> +/* STM32F4_ADCX_SQR3 - bit fields */
> +#define STM32F4_SQ6_SHIFT		25
> +#define STM32F4_SQ6_MASK		GENMASK(29, 25)
> +#define STM32F4_SQ5_SHIFT		20
> +#define STM32F4_SQ5_MASK		GENMASK(24, 20)
> +#define STM32F4_SQ4_SHIFT		15
> +#define STM32F4_SQ4_MASK		GENMASK(19, 15)
> +#define STM32F4_SQ3_SHIFT		10
> +#define STM32F4_SQ3_MASK		GENMASK(14, 10)
> +#define STM32F4_SQ2_SHIFT		5
> +#define STM32F4_SQ2_MASK		GENMASK(9, 5)
> +#define STM32F4_SQ1_SHIFT		0
> +#define STM32F4_SQ1_MASK		GENMASK(4, 0)
> +
> +/* STM32F4_ADCX_JSQR - bit fields */
> +#define STM32F4_JL_SHIFT		20
> +#define STM32F4_JL_MASK			GENMASK(21, 20)
> +#define STM32F4_JSQ4_SHIFT		15
> +#define STM32F4_JSQ4_MASK		GENMASK(19, 15)
> +#define STM32F4_JSQ3_SHIFT		10
> +#define STM32F4_JSQ3_MASK		GENMASK(14, 10)
> +#define STM32F4_JSQ2_SHIFT		5
> +#define STM32F4_JSQ2_MASK		GENMASK(9, 5)
> +#define STM32F4_JSQ1_SHIFT		0
> +#define STM32F4_JSQ1_MASK		GENMASK(4, 0)
> +
> +/* STM32F4_ADC_CCR - bit fields */
> +#define STM32F4_ADC_ADCPRE_SHIFT	16
> +#define STM32F4_ADC_ADCPRE_MASK		GENMASK(17, 16)
> +
> +/*
> + * stm32 ADC1, ADC2 & ADC3 are tightly coupled and may be used in multi mode
> + * Define here all inputs for all ADC instances
> + */
> +static const struct stm32_adc_chan_spec stm32f4_adc1_channels[] = {
> +	/* master ADC1 */
> +	{ IIO_VOLTAGE, 0, "in0" },
> +	{ IIO_VOLTAGE, 1, "in1" },
> +	{ IIO_VOLTAGE, 2, "in2" },
> +	{ IIO_VOLTAGE, 3, "in3" },
> +	{ IIO_VOLTAGE, 4, "in4" },
> +	{ IIO_VOLTAGE, 5, "in5" },
> +	{ IIO_VOLTAGE, 6, "in6" },
> +	{ IIO_VOLTAGE, 7, "in7" },
> +	{ IIO_VOLTAGE, 8, "in8" },
> +	{ IIO_VOLTAGE, 9, "in9" },
> +	{ IIO_VOLTAGE, 10, "in10" },
> +	{ IIO_VOLTAGE, 11, "in11" },
> +	{ IIO_VOLTAGE, 12, "in12" },
> +	{ IIO_VOLTAGE, 13, "in13" },
> +	{ IIO_VOLTAGE, 14, "in14" },
> +	{ IIO_VOLTAGE, 15, "in15" },
> +	/* internal analog sources available on input 16 to 18 */
> +	{ IIO_VOLTAGE, 16, "in16" },
> +	{ IIO_VOLTAGE, 17, "in17" },
> +	{ IIO_VOLTAGE, 18, "in18" },
> +};
> +
> +static const struct stm32_adc_chan_spec stm32f4_adc23_channels[] = {
> +	/* slave ADC2 /	ADC3 */
> +	{ IIO_VOLTAGE, 0, "in0" },
> +	{ IIO_VOLTAGE, 1, "in1" },
> +	{ IIO_VOLTAGE, 2, "in2" },
> +	{ IIO_VOLTAGE, 3, "in3" },
> +	{ IIO_VOLTAGE, 4, "in4" },
> +	{ IIO_VOLTAGE, 5, "in5" },
> +	{ IIO_VOLTAGE, 6, "in6" },
> +	{ IIO_VOLTAGE, 7, "in7" },
> +	{ IIO_VOLTAGE, 8, "in8" },
> +	{ IIO_VOLTAGE, 9, "in9" },
> +	{ IIO_VOLTAGE, 10, "in10" },
> +	{ IIO_VOLTAGE, 11, "in11" },
> +	{ IIO_VOLTAGE, 12, "in12" },
> +	{ IIO_VOLTAGE, 13, "in13" },
> +	{ IIO_VOLTAGE, 14, "in14" },
> +	{ IIO_VOLTAGE, 15, "in15" },
> +};
> +
> +/* Triggers for regular channels */
> +static const struct stm32_adc_trig_info stm32f4_adc_ext_triggers[] = {
> +	{ STM32_EXT0, "TIM1_CH1" },
> +	{ STM32_EXT1, "TIM1_CH2" },
> +	{ STM32_EXT2, "TIM1_CH3" },
> +	{ STM32_EXT3, "TIM2_CH2" },
> +	{ STM32_EXT4, "TIM2_CH3" },
> +	{ STM32_EXT5, "TIM2_CH4" },
> +	{ STM32_EXT6, "TIM2_TRGO" },
> +	{ STM32_EXT7, "TIM3_CH1" },
> +	{ STM32_EXT8, "TIM3_TRGO" },
> +	{ STM32_EXT9, "TIM4_CH4" },
> +	{ STM32_EXT10, "TIM5_CH1" },
> +	{ STM32_EXT11, "TIM5_CH2" },
> +	{ STM32_EXT12, "TIM5_CH3" },
> +	{ STM32_EXT13, "TIM8_CH1" },
> +	{ STM32_EXT14, "TIM8_TRGO" },
> +	{ STM32_EXT15, "EXTI_11" },
> +	{},
> +};
> +
> +/* Triggers for injected channels */
> +static const struct stm32_adc_trig_info  stm32f4_adc_jext_triggers[] = {
> +	{ STM32_JEXT0, "TIM1_CH4" },
> +	{ STM32_JEXT1, "TIM1_TRGO" },
> +	{ STM32_JEXT2, "TIM2_CH1" },
> +	{ STM32_JEXT3, "TIM2_TRGO" },
> +	{ STM32_JEXT4, "TIM3_CH2" },
> +	{ STM32_JEXT5, "TIM3_CH4" },
> +	{ STM32_JEXT6, "TIM4_CH1" },
> +	{ STM32_JEXT7, "TIM4_CH2" },
> +	{ STM32_JEXT8, "TIM4_CH3" },
> +	{ STM32_JEXT9, "TIM4_TRGO" },
> +	{ STM32_JEXT10, "TIM5_CH4" },
> +	{ STM32_JEXT11, "TIM5_TRGO" },
> +	{ STM32_JEXT12, "TIM8_CH2" },
> +	{ STM32_JEXT13, "TIM8_CH3" },
> +	{ STM32_JEXT14, "TIM8_CH4" },
> +	{ STM32_JEXT15, "EXTI_15" },
> +	{},
> +};
> +
> +static const struct stm32_adc_info stm32f4_adc_info[] = {
> +	{
> +		.name = "adc1-master",
> +		.reg = 0x0,
> +		.channels = stm32f4_adc1_channels,
> +		.max_channels = ARRAY_SIZE(stm32f4_adc1_channels),
> +	},
> +	{
> +		.name = "adc2-slave",
> +		.reg = 0x100,
> +		.channels = stm32f4_adc23_channels,
> +		.max_channels = ARRAY_SIZE(stm32f4_adc23_channels),
> +	},
> +	{
> +		.name = "adc3-slave",
> +		.reg = 0x200,
> +		.channels = stm32f4_adc23_channels,
> +		.max_channels = ARRAY_SIZE(stm32f4_adc23_channels),
> +	},
> +	{},
> +};
> +
> +/**
> + * stm32f4_sqr_regs - describe regular sequence registers
> + * - L: sequence len (register & bit field)
> + * - SQ1..SQ16: sequence entries (register & bit field)
> + */
> +static const struct stm32_adc_regs stm32f4_sqr_regs[STM32_ADC_MAX_SQ + 1] = {
> +	/* L: len bit field description to be kept as first element */
> +	{ STM32F4_ADCX_SQR1, STM32F4_L_MASK, STM32F4_L_SHIFT },
> +	/* SQ1..SQ16 registers & bit fields */
> +	{ STM32F4_ADCX_SQR3, STM32F4_SQ1_MASK, STM32F4_SQ1_SHIFT },
> +	{ STM32F4_ADCX_SQR3, STM32F4_SQ2_MASK, STM32F4_SQ2_SHIFT },
> +	{ STM32F4_ADCX_SQR3, STM32F4_SQ3_MASK, STM32F4_SQ3_SHIFT },
> +	{ STM32F4_ADCX_SQR3, STM32F4_SQ4_MASK, STM32F4_SQ4_SHIFT },
> +	{ STM32F4_ADCX_SQR3, STM32F4_SQ5_MASK, STM32F4_SQ5_SHIFT },
> +	{ STM32F4_ADCX_SQR3, STM32F4_SQ6_MASK, STM32F4_SQ6_SHIFT },
> +	{ STM32F4_ADCX_SQR2, STM32F4_SQ7_MASK, STM32F4_SQ7_SHIFT },
> +	{ STM32F4_ADCX_SQR2, STM32F4_SQ8_MASK, STM32F4_SQ8_SHIFT },
> +	{ STM32F4_ADCX_SQR2, STM32F4_SQ9_MASK, STM32F4_SQ9_SHIFT },
> +	{ STM32F4_ADCX_SQR2, STM32F4_SQ10_MASK, STM32F4_SQ10_SHIFT },
> +	{ STM32F4_ADCX_SQR2, STM32F4_SQ11_MASK, STM32F4_SQ11_SHIFT },
> +	{ STM32F4_ADCX_SQR2, STM32F4_SQ12_MASK, STM32F4_SQ12_SHIFT },
> +	{ STM32F4_ADCX_SQR1, STM32F4_SQ13_MASK, STM32F4_SQ13_SHIFT },
> +	{ STM32F4_ADCX_SQR1, STM32F4_SQ14_MASK, STM32F4_SQ14_SHIFT },
> +	{ STM32F4_ADCX_SQR1, STM32F4_SQ15_MASK, STM32F4_SQ15_SHIFT },
> +	{ STM32F4_ADCX_SQR1, STM32F4_SQ16_MASK, STM32F4_SQ16_SHIFT },
> +};
> +
> +/**
> + * stm32f4_jsqr_reg - describe injected sequence register:
> + * - JL: injected sequence len
> + * - JSQ4..SQ1: sequence entries
> + * When JL == 3, ADC converts JSQ1, JSQ2, JSQ3, JSQ4
> + * When JL == 2, ADC converts JSQ2, JSQ3, JSQ4
> + * When JL == 1, ADC converts JSQ3, JSQ4
> + * When JL == 0, ADC converts JSQ4
> + */
> +static const struct stm32_adc_regs stm32f4_jsqr_reg[STM32_ADC_MAX_JSQ + 1] = {
> +	/* JL: len bit field description to be kept as first element */
> +	{STM32F4_ADCX_JSQR, STM32F4_JL_MASK, STM32F4_JL_SHIFT},
> +	/* JSQ4..JSQ1 registers & bit fields */
> +	{STM32F4_ADCX_JSQR, STM32F4_JSQ4_MASK, STM32F4_JSQ4_SHIFT},
> +	{STM32F4_ADCX_JSQR, STM32F4_JSQ3_MASK, STM32F4_JSQ3_SHIFT},
> +	{STM32F4_ADCX_JSQR, STM32F4_JSQ2_MASK, STM32F4_JSQ2_SHIFT},
> +	{STM32F4_ADCX_JSQR, STM32F4_JSQ1_MASK, STM32F4_JSQ1_SHIFT},
> +};
> +
> +static const struct stm32_adc_trig_reginfo stm32f4_adc_trig_reginfo = {
> +	.reg = STM32F4_ADCX_CR2,
> +	.exten_mask = STM32F4_EXTEN_MASK,
> +	.exten_shift = STM32F4_EXTEN_SHIFT,
> +	.extsel_mask = STM32F4_EXTSEL_MASK,
> +	.extsel_shift = STM32F4_EXTSEL_SHIFT,
> +};
> +
> +static const struct stm32_adc_trig_reginfo stm32f4_adc_jtrig_reginfo = {
> +	.reg = STM32F4_ADCX_CR2,
> +	.exten_mask = STM32F4_JEXTEN_MASK,
> +	.exten_shift = STM32F4_JEXTEN_SHIFT,
> +	.extsel_mask = STM32F4_JEXTSEL_MASK,
> +	.extsel_shift = STM32F4_JEXTSEL_SHIFT,
> +};
> +
> +static const struct stm32_adc_reginfo stm32f4_adc_reginfo = {
> +	.isr = STM32F4_ADCX_SR,
> +	.eoc = STM32F4_EOC,
> +	.jeoc = STM32F4_JEOC,
> +	.ier = STM32F4_ADCX_CR1,
> +	.eocie = STM32F4_EOCIE,
> +	.jeocie = STM32F4_JEOCIE,
> +	.dr = STM32F4_ADCX_DR,
> +	.jdr = {
> +		STM32F4_ADCX_JDR1,
> +		STM32F4_ADCX_JDR2,
> +		STM32F4_ADCX_JDR3,
> +		STM32F4_ADCX_JDR4,
> +	},
> +	.sqr_regs = stm32f4_sqr_regs,
> +	.jsqr_reg = stm32f4_jsqr_reg,
> +	.trig_reginfo = &stm32f4_adc_trig_reginfo,
> +	.jtrig_reginfo = &stm32f4_adc_jtrig_reginfo,
> +};
> +
> +static bool stm32f4_adc_is_started(struct stm32_adc *adc)
> +{
> +	u32 val = stm32_adc_readl(adc, STM32F4_ADCX_CR2) & STM32F4_ADON;
> +
> +	return !!val;
> +}
> +
> +static bool stm32f4_adc_regular_started(struct stm32_adc *adc)
> +{
> +	u32 val = stm32_adc_readl(adc, STM32F4_ADCX_SR) & STM32F4_STRT;
> +
> +	return !!val;
> +}
> +
> +static bool stm32f4_adc_injected_started(struct stm32_adc *adc)
> +{
> +	u32 val = stm32_adc_readl(adc, STM32F4_ADCX_SR) & STM32F4_JSTRT;
> +
> +	return !!val;
> +}
> +
> +/**
> + * stm32f4_adc_start_conv() - Start regular or injected conversions
> + * @adc: stm32 adc instance
> + *
> + * Start single conversions for regular or injected channels.
> + */
> +static int stm32f4_adc_start_conv(struct stm32_adc *adc)
> +{
> +	u32 trig_msk, start_msk;
> +
> +	dev_dbg(adc->common->dev, "%s %s\n", __func__,
> +		adc->injected ? "injected" : "regular");
> +
> +	stm32_adc_set_bits(adc, STM32F4_ADCX_CR1, STM32F4_SCAN);
> +
> +	if (!stm32f4_adc_is_started(adc)) {
> +		stm32_adc_set_bits(adc, STM32F4_ADCX_CR2,
> +				   STM32F4_EOCS | STM32F4_ADON);
> +
> +		/* Wait for Power-up time (tSTAB from datasheet) */
> +		usleep_range(2, 3);
> +	}
> +
> +	if (adc->injected) {
> +		trig_msk = STM32F4_JEXTEN_MASK;
> +		start_msk = STM32F4_JSWSTART;
> +	} else {
> +		trig_msk = STM32F4_EXTEN_MASK;
> +		start_msk = STM32F4_SWSTART;
> +	}
> +
> +	/* Software start ? (e.g. trigger detection disabled ?) */
> +	if (!(stm32_adc_readl(adc, STM32F4_ADCX_CR2) & trig_msk))
> +		stm32_adc_set_bits(adc, STM32F4_ADCX_CR2, start_msk);
> +
> +	return 0;
> +}
> +
> +static int stm32f4_adc_stop_conv(struct stm32_adc *adc)
> +{
> +	u32 val;
> +
> +	dev_dbg(adc->common->dev, "%s %s\n", __func__,
> +		adc->injected ? "injected" : "regular");
> +
> +	/* First disable trigger for either regular or injected channels */
> +	if (adc->injected) {
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_CR2, STM32F4_JEXTEN_MASK);
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_SR, STM32F4_JSTRT);
> +	} else {
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_CR2, STM32F4_EXTEN_MASK);
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_SR, STM32F4_STRT);
> +	}
> +
> +	/* Disable adc when all triggered conversion have been disabled */
> +	val = stm32_adc_readl(adc, STM32F4_ADCX_CR2);
> +	val &= STM32F4_EXTEN_MASK | STM32F4_JEXTEN_MASK;
> +	if (!val) {
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_CR1, STM32F4_SCAN);
> +		stm32_adc_clr_bits(adc, STM32F4_ADCX_CR2, STM32F4_ADON);
> +	}
> +
> +	return 0;
> +}
> +
> +/* ADC internal common clock prescaler division ratios */
> +static int stm32f4_pclk_div[] = {2, 4, 6, 8};
> +
> +/**
> + * stm32f4_adc_clk_sel() - Select ADC common clock prescaler
> + * @adc: stm32 adc instance
> + * Select clock prescaler used for analog conversions.
> + */
> +static int stm32f4_adc_clk_sel(struct stm32_adc *adc)
> +{
> +	struct stm32_adc_common *common = adc->common;
> +	unsigned long rate;
> +	u32 val;
> +	int i;
> +
> +	/* Common prescaler is set only once, when 1st ADC instance starts */
> +	list_for_each_entry(adc, &common->adc_list, adc_list)
> +		if (stm32f4_adc_is_started(adc))
> +			return 0;
> +
> +	rate = clk_get_rate(common->aclk);
> +	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
> +		if ((rate / stm32f4_pclk_div[i]) <=
> +		    common->data->max_clock_rate)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(stm32f4_pclk_div))
> +		return -EINVAL;
> +
> +	val = stm32_adc_common_readl(common, STM32F4_ADC_CCR);
> +	val &= ~STM32F4_ADC_ADCPRE_MASK;
> +	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
> +	stm32_adc_common_writel(common, STM32F4_ADC_CCR, val);
> +
> +	dev_dbg(common->dev, "Using analog clock source at %ld kHz\n",
> +		rate / (stm32f4_pclk_div[i] * 1000));
> +
> +	return 0;
> +}
> +
> +static const struct stm32_adc_ops stm32f4_adc_ops = {
> +	.adc_info = stm32f4_adc_info,
> +	.ext_triggers = stm32f4_adc_ext_triggers,
> +	.jext_triggers = stm32f4_adc_jext_triggers,
> +	.adc_reginfo = &stm32f4_adc_reginfo,
> +	.highres = 12,
> +	.max_clock_rate = 36000000,
> +	.clk_sel = stm32f4_adc_clk_sel,
> +	.start_conv = stm32f4_adc_start_conv,
> +	.stop_conv = stm32f4_adc_stop_conv,
> +	.is_started = stm32f4_adc_is_started,
> +	.regular_started = stm32f4_adc_regular_started,
> +	.injected_started = stm32f4_adc_injected_started,
> +};
> +
> +static const struct of_device_id stm32f4_adc_of_match[] = {
> +	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_ops},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32f4_adc_of_match);
> +
> +static struct platform_driver stm32f4_adc_driver = {
> +	.probe = stm32_adc_probe,
> +	.remove = stm32_adc_remove,
> +	.driver = {
> +		.name = "stm32f4-adc",
> +		.of_match_table = stm32f4_adc_of_match,
> +	},
> +};
> +
> +module_platform_driver(stm32f4_adc_driver);
> +
> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32F4 ADC driver");
> +MODULE_LICENSE("GPL v2");
> 

