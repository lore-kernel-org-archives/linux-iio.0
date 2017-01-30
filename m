Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45696 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932324AbdA3PLN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 10:11:13 -0500
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
To: Jonathan Cameron <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <0d474586-89d9-9019-698d-bc47f4510573@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <2928029a-5c62-a2fe-5bed-87d4d08b6054@st.com>
Date: Mon, 30 Jan 2017 16:08:40 +0100
MIME-Version: 1.0
In-Reply-To: <0d474586-89d9-9019-698d-bc47f4510573@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

Thanks for the review. This drivers should disappear,
but i will integrate you comment/remark in my redesign.

Please find some comments below, on specific points

Regards
Arnaud


On 01/29/2017 12:53 PM, Jonathan Cameron wrote:
> On 23/01/17 16:32, Arnaud Pouliquen wrote:
>> DFSDM hardware IP can be used at the same time for ADC sigma delta
>> conversion and audio PDM microphone.
>> MFD driver is in charge of configuring IP registers and managing IP clocks.
>> For this it exports an API to handles filters and channels resources.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> This is somewhat of a beast.  I would be tempted to build it up in more
> bite sized chunks.
> 
> Obvious things to drop from a first version (basically to make it easier
> to review) would be injected supported.  There may well be others but you'll
> have a better feel for that than me.
i will pay attention for next version.
> 
> I really don't like the wrappers round the regmap functions though.
> They mean you are papering over errors if they occur and make the code
> slightly harder to read by implying that something else is going on.
> 
One aim of the wrapper was to simplify code review, seems that just the
opposite...
As i have around 50 regmap accesses, adding  a return/goto for each
error and at least an associated error messages for each function,
should add 100 to 150 extra lines...

> Yes the code will be longer without them, but you will also be forced to think
> properly about error paths.

I have a question around this. What should be the action if a register
access return an error?
Possible root causes:
	- bad address of the IP (DT)
	- IP not clocked or in reset (driver BUG).
	- IP is out of order (hardware issue)
	- bug in driver that access to an invalid address.

So except for the last root cause,we can suppose that every register
accesses should always be OK or KO...
This is also a reason of the wrapper. Detect driver bug, without adding
a test on each register access return.

Perhaps a compromise could be that test is done only during some
specific phase (probe, after reset deassertion, clock enabling...) and
then trust access without test?
Or simply add error message in regmap helper routines...

Please just tell/confirm me your preference.

> 
> Anyhow, was mostly reading this to get a feel for what was going on in the
> whole series so not really a terribly thorough review I'm afraid. Sorry about
> that!
More than enough for this first version :)

> 
> Jonathan
>> ---
>>  drivers/mfd/Kconfig             |   11 +
>>  drivers/mfd/Makefile            |    2 +
>>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
>>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
>>  5 files changed, 1601 insertions(+)
>>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
>>  create mode 100644 drivers/mfd/stm32-dfsdm.c
>>  create mode 100644 include/linux/mfd/stm32-dfsdm.h


[...]

>> diff --git a/drivers/mfd/stm32-dfsdm.c b/drivers/mfd/stm32-dfsdm.c
>> new file mode 100644
>> index 0000000..81ca29c
>> --- /dev/null
>> +++ b/drivers/mfd/stm32-dfsdm.c
>> @@ -0,0 +1,1044 @@
>> +/*
>> + * This file is part of STM32 DFSDM mfd driver
>> + *
>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> + * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
>> + *
>> + * License terms: GPL V2.0.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>> + * details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/mfd/stm32-dfsdm.h>
>> +
>> +#include "stm32-dfsdm-reg.h"
>> +
>> +#define DFSDM_UPDATE_BITS(regm, reg, mask, val) \
>> +		WARN_ON(regmap_update_bits(regm, reg, mask, val))
> Don't do these wrappers please. Handle error correctly in all cases.
> Reviewing as I tend to do backwards through the driver, I thought these
> were doing something interesting.
> 
> Effectively you have no error handling as a result of these which needs
> fixing.
> 
>> +
>> +#define DFSDM_REG_READ(regm, reg, val) \
>> +		WARN_ON(regmap_read(regm, reg, val))
>> +
>> +#define DFSDM_REG_WRITE(regm, reg, val) \
>> +		WARN_ON(regmap_write(regm, reg, val))
>> +
>> +#define STM32H7_DFSDM_NUM_FILTERS	4
>> +#define STM32H7_DFSDM_NUM_INPUTS	8
>> +
>> +enum dfsdm_clkout_src {
>> +	DFSDM_CLK,
>> +	AUDIO_CLK
>> +};
>> +
>> +struct stm32_dev_data {
>> +	const struct stm32_dfsdm dfsdm;
>> +	const struct regmap_config *regmap_cfg;
>> +};
>> +
>> +struct dfsdm_priv;
>> +
>> +struct filter_params {
>> +	unsigned int id;
>> +	int irq;
>> +	struct stm32_dfsdm_fl_event event;
>> +	u32 event_mask;
>> +	struct dfsdm_priv *priv; /* Cross ref for context */
>> +	unsigned int ext_ch_mask;
>> +	unsigned int scan_ch;
>> +};
>> +
>> +struct ch_params {
>> +	struct stm32_dfsdm_channel ch;
>> +};
>> +
> I'd like to see a lot more comments in here.  Perhaps full kernel-doc
> as some elements are not that obvious at least to a fairly casual read.
> 
Description in device-tree tree bindings and cover-letter is not
sufficient? you would a doc in Document/arm/stm32?

>> +struct dfsdm_priv {
>> +	struct platform_device *pdev;
>> +	struct stm32_dfsdm dfsdm;
>> +
>> +	spinlock_t lock; /* Used for resource sharing & interrupt lock */
>> +
>> +	/* Filters */
>> +	struct filter_params *filters;
>> +	unsigned int free_filter_mask;
>> +	unsigned int scd_filter_mask;
>> +	unsigned int ckab_filter_mask;
>> +
>> +	/* Channels */
>> +	struct stm32_dfsdm_channel *channels;
>> +	unsigned int free_channel_mask;
>> +	atomic_t n_active_ch;
>> +
>> +	/* Clock */
>> +	struct clk *clk;
>> +	struct clk *aclk;
>> +	unsigned int clkout_div;
>> +	unsigned int clkout_freq_req;
>> +
>> +	/* Registers*/
>> +	void __iomem *base;
>> +	struct regmap *regmap;
>> +	phys_addr_t phys_base;
>> +};
>> +
>> +/*
>> + * Common
>> + */
>> +static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	if (reg < DFSDM_FILTER_BASE_ADR)
>> +		return false;
>> +
>> +	/*
>> +	 * Mask is done on register to avoid to list registers of all them
>> +	 * filter instances.
>> +	 */
>> +	switch (reg & DFSDM_FILTER_REG_MASK) {
>> +	case DFSDM_CR1(0) & DFSDM_FILTER_REG_MASK:
>> +	case DFSDM_ISR(0) & DFSDM_FILTER_REG_MASK:
>> +	case DFSDM_JDATAR(0) & DFSDM_FILTER_REG_MASK:
>> +	case DFSDM_RDATAR(0) & DFSDM_FILTER_REG_MASK:
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static const struct regmap_config stm32h7_dfsdm_regmap_cfg = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = sizeof(u32),
>> +	.max_register = DFSDM_CNVTIMR(STM32H7_DFSDM_NUM_FILTERS - 1),
>> +	.volatile_reg = stm32_dfsdm_volatile_reg,
>> +	.fast_io = true,
>> +};
>> +
>> +static const struct stm32_dev_data stm32h7_data = {
>> +	.dfsdm.max_channels = STM32H7_DFSDM_NUM_INPUTS,
>> +	.dfsdm.max_filters = STM32H7_DFSDM_NUM_FILTERS,
>> +	.regmap_cfg = &stm32h7_dfsdm_regmap_cfg,
>> +};
>> +

[...]

>> +
>> +/**
>> + * stm32_dfsdm_get_filter_dma_addr - Get register address for dma transfer.
>> + *
>> + * @dfsdm: Handle used to retrieve dfsdm context.
>> + * @fl_id: Filter id.
>> + * @conv: Conversion type.
>> + */
>> +dma_addr_t stm32_dfsdm_get_filter_dma_phy_addr(struct stm32_dfsdm *dfsdm,
>> +					       unsigned int fl_id,
>> +					       enum stm32_dfsdm_conv_type conv)
>> +{
>> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
>> +
>> +	if (conv == DFSDM_FILTER_REG_CONV)
>> +		return (dma_addr_t)(priv->phys_base + DFSDM_RDATAR(fl_id));
>> +	else
>> +		return (dma_addr_t)(priv->phys_base + DFSDM_JDATAR(fl_id));
>> +}
>> +
>> +/**
>> + * stm32_dfsdm_register_fl_event - Register filter event.
> What is a filter event?  More details good on things that are very
> device specific like this.
Filter events correspond to filter IRQ status, will be handled in a
different way in IIO.
>> + *
>> + * @dfsdm: Handle used to retrieve dfsdm context.
>> + * @fl_id: Filter id.
>> + * @event: Event to unregister.
>> + * @chan_mask: Mask of channels associated to filter.
>> + *
>> + * The function enables associated IRQ.
>> + */
>> +int stm32_dfsdm_register_fl_event(struct stm32_dfsdm *dfsdm, unsigned int fl_id,
>> +				  enum stm32_dfsdm_events event,
>> +				  unsigned int chan_mask)
>> +{
>> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
>> +	unsigned long flags, ulmask = chan_mask;
>> +	int ret, i;
>> +
>> +	dev_dbg(&priv->pdev->dev, "%s:for filter %d: event %#x ch_mask %#x\n",
>> +		__func__, fl_id, event, chan_mask);
>> +
>> +	if (event > DFSDM_EVENT_CKA)
>> +		return -EINVAL;
>> +
>> +	/* Clear interrupt before enable them */
>> +	ret = stm32_dfsdm_clear_event(priv, fl_id, event, chan_mask);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	spin_lock_irqsave(&priv->lock, flags);
>> +	/* Enable interrupts */
>> +	switch (event) {
>> +	case DFSDM_EVENT_SCD:
>> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
>> +					  DFSDM_CHCFGR1_SCDEN_MASK,
>> +					  DFSDM_CHCFGR1_SCDEN(1));
>> +		}
>> +		if (!priv->scd_filter_mask)
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
>> +					  DFSDM_CR2_SCDIE_MASK,
>> +					  DFSDM_CR2_SCDIE(1));
>> +		priv->scd_filter_mask |= BIT(fl_id);
>> +		break;
>> +	case DFSDM_EVENT_CKA:
>> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
>> +					  DFSDM_CHCFGR1_CKABEN_MASK,
>> +					  DFSDM_CHCFGR1_CKABEN(1));
>> +		}
>> +		if (!priv->ckab_filter_mask)
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
>> +					  DFSDM_CR2_CKABIE_MASK,
>> +					  DFSDM_CR2_CKABIE(1));
>> +		priv->ckab_filter_mask |= BIT(fl_id);
>> +		break;
>> +	default:
>> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(fl_id), event, event);
>> +	}
>> +	priv->filters[fl_id].event_mask |= event;
>> +	spin_unlock_irqrestore(&priv->lock, flags);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dfsdm_register_fl_event);
>> +
>> +/**
>> + * stm32_dfsdm_unregister_fl_event - Unregister filter event.
>> + *
>> + * @dfsdm: Handle used to retrieve dfsdm context.
>> + * @fl_id: Filter id.
>> + * @event: Event to unregister.
>> + * @chan_mask: Mask of channels associated to filter.
>> + *
>> + * The function disables associated IRQ.
>> + */
>> +int stm32_dfsdm_unregister_fl_event(struct stm32_dfsdm *dfsdm,
>> +				    unsigned int fl_id,
>> +				    enum stm32_dfsdm_events event,
>> +				    unsigned int chan_mask)
>> +{
>> +	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
>> +	unsigned long flags, ulmask = chan_mask;
>> +	int i;
>> +
>> +	dev_dbg(&priv->pdev->dev, "%s:for filter %d: event %#x ch_mask %#x\n",
>> +		__func__, fl_id, event, chan_mask);
>> +
>> +	if (event > DFSDM_EVENT_CKA)
>> +		return -EINVAL;
>> +
>> +	spin_lock_irqsave(&priv->lock, flags);
>> +	/* Disable interrupts */
>> +	switch (event) {
>> +	case DFSDM_EVENT_SCD:
>> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
>> +					  DFSDM_CHCFGR1_SCDEN_MASK,
>> +					  DFSDM_CHCFGR1_SCDEN(0));
>> +		}
>> +		priv->scd_filter_mask &= ~BIT(fl_id);
>> +		if (!priv->scd_filter_mask)
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
>> +					  DFSDM_CR2_SCDIE_MASK,
>> +					  DFSDM_CR2_SCDIE(0));
>> +		break;
>> +	case DFSDM_EVENT_CKA:
>> +		for_each_set_bit(i, &ulmask, priv->dfsdm.max_channels) {
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CHCFGR1(i),
>> +					  DFSDM_CHCFGR1_CKABEN_MASK,
>> +					  DFSDM_CHCFGR1_CKABEN(0));
>> +		}
>> +		priv->ckab_filter_mask &= ~BIT(fl_id);
>> +		if (!priv->ckab_filter_mask)
>> +			DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(0),
>> +					  DFSDM_CR2_CKABIE_MASK,
>> +					  DFSDM_CR2_CKABIE(0));
>> +		break;
>> +	default:
>> +		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_CR2(fl_id), event, 0);
>> +	}
>> +
>> +	priv->filters[fl_id].event_mask &= ~event;
>> +	spin_unlock_irqrestore(&priv->lock, flags);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dfsdm_unregister_fl_event);

[...]
>> +/* DFSDM filter conversion type */
>> +enum stm32_dfsdm_conv_type {
>> +	DFSDM_FILTER_REG_CONV,      /* Regular conversion */
>> +	DFSDM_FILTER_SW_INJ_CONV,   /* Injected conversion */
>> +	DFSDM_FILTER_TRIG_INJ_CONV, /* Injected conversion */
>> +};
>> +
>> +/* DFSDM filter regular synchronous mode */
>> +enum stm32_dfsdm_conv_rsync {
>> +	DFSDM_FILTER_RSYNC_OFF, /* regular conversion asynchronous */
>> +	DFSDM_FILTER_RSYNC_ON,  /* regular conversion synchronous with filter0*/
> stray 0?
Should read "filter instance 0"...
This corresponds to a specificity of the DFSDM hardware. DFSDM can offer
possibility to synchronize each filter output with the filter 0 instance
output.
As example, this can be used to synchronize several audio microphones.
Filter 0 is allocated to main microphones and the other filters for
background microphones (notice that we need one filter per 1-bit PDM stream)

[...]
