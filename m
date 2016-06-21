Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34634 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcFUK4P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 06:56:15 -0400
Received: by mail-yw0-f177.google.com with SMTP id i12so10056482ywa.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2016 03:55:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2c4390cc-a80c-8649-b8c5-a9656786b559@kernel.org>
References: <1466330790-2820-1-git-send-email-raveendra.padasalagi@broadcom.com>
	<1466330790-2820-3-git-send-email-raveendra.padasalagi@broadcom.com>
	<2c4390cc-a80c-8649-b8c5-a9656786b559@kernel.org>
Date: Tue, 21 Jun 2016 16:25:47 +0530
Message-ID: <CAAFb_vp4y8kS4KXPAWwfC-Ew0hZRF-QPOcV5wjbJUwACoX_iAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: Add driver for Broadcom iproc-static-adc
From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Richardson <jonathar@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pramod Kumar <pramod.kumar@broadcom.com>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the review comments. I will address these in the next patch.
Please find my reply inline.

Regards,
Raveendra

On Mon, Jun 20, 2016 at 1:05 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 19/06/16 11:06, Raveendra Padasalagi wrote:
>> This patch adds basic driver implementation for Broadcom's
>> static adc controller used in iProc SoC's family.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Hi All,
>
> The inconvenience of lunch and an afternoon of gardening occured in the
> middle of this review, so much of what I have may well have been covered
> by Peter!
>
> Anyhow, various bits inline.  In particular, there is very little handling
> of potential regmap functions returning errors in here.  I know they are
> pretty unlikely, but I think it would be nice to handle them anyway.
>
> Interesting bit of kit so I hope you have the oportunity to look at fuller
> support of those fifos. Any public info on the part in question?

Currently details of ADC controller is not publicly available. Yes, I
have plan for
improving this driver to make use of fifo's in the next step, This ADC has
a continuous capture mode feature.

> Thanks
>
> Jonathan
>> ---
>>  drivers/iio/adc/Kconfig         |  13 +
>>  drivers/iio/adc/Makefile        |   1 +
>>  drivers/iio/adc/bcm_iproc_adc.c | 563 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 577 insertions(+)
>>  create mode 100644 drivers/iio/adc/bcm_iproc_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 25378c5..195dcd4 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -153,6 +153,19 @@ config AXP288_ADC
>>         To compile this driver as a module, choose M here: the module will be
>>         called axp288_adc.
>>
>> +config BCM_IPROC_ADC
>> +     tristate "Broadcom IPROC ADC driver"
>> +     depends on ARCH_BCM_IPROC || COMPILE_TEST
>> +     depends on MFD_SYSCON
>> +     default ARCH_BCM_CYGNUS
>> +     help
>> +       Say Y here if you want to add support for the Broadcom static
>> +       ADC driver.
>> +
>> +       Broadcom iProc ADC driver. Broadcom iProc ADC controller has 8
>> +       channels. The driver allows the user to read voltage and
>> +       temperature values.
>> +
>>  config BERLIN2_ADC
>>       tristate "Marvell Berlin2 ADC driver"
>>       depends on ARCH_BERLIN
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 38638d4..0ba0d50 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD799X) += ad799x.o
>>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
>>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>> +obj-$(CONFIG_BCM_IPROC_ADC) += bcm_iproc_adc.o
>>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
>> new file mode 100644
>> index 0000000..6bfc160
>> --- /dev/null
>> +++ b/drivers/iio/adc/bcm_iproc_adc.c
>> @@ -0,0 +1,563 @@
>> +/*
>> + * Copyright 2016 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation (the "GPL").
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License version 2 (GPLv2) for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * version 2 (GPLv2) along with this source code.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/machine.h>
> Why?  Not immediately seeing any use of iio_maps in here...

Yes, we don't need iio_maps.will remove it in the next patch.

>> +#include <linux/iio/driver.h>
> snap.
>> +
>> +#define IPROC_ADC_READ_TIMEOUT        (HZ*2)
>> +
>> +/* Register offsets */
>> +#define REGCTL1                              0x00
>> +#define REGCTL2                              0x04
>> +#define INTERRUPT_THRES                      0x08
>> +#define INTRPT_MASK                  0x0c
>> +#define INTRPT_STATUS                        0x10
>> +#define ANALOG_CONTROL                       0x1c
>> +#define CONTROLLER_STATUS            0x14
>> +#define AUX_DATA                     0x20
>> +#define SOFT_BYPASS_CONTROL          0x38
>> +#define SOFT_BYPASS_DATA             0x3C
>> +
>> +/* ADC Channel register offsets */
>> +#define ADC_CHANNEL_REGCTL1          0x800
>> +#define ADC_CHANNEL_REGCTL2          0x804
>> +#define ADC_CHANNEL_STATUS           0x808
>> +#define ADC_CHANNEL_INTERRUPT_STATUS 0x80c
>> +#define ADC_CHANNEL_INTERRUPT_MASK   0x810
>> +#define ADC_CHANNEL_DATA             0x814
>> +#define ADC_CHANNEL_OFFSET           0x20
>> +
>> +/* Masks for RegCtl2 */
>> +#define ADC_AUXIN_SCAN_ENA           BIT(0)
>> +#define ADC_PWR_LDO                  BIT(5)
>> +#define ADC_PWR_ADC                  BIT(4)
>> +#define ADC_PWR_BG                   BIT(3)
>> +#define ADC_CONTROLLER_EN            BIT(17)
>> +
>> +/* Masks for Interrupt_Mask and Interrupt_Status reg */
>> +#define ADC_AUXDATA_RDY_INTR         BIT(3)
>> +#define ADC_INTR_SHIFT                       9
>> +#define ADC_INTR_MASK                        (0xFF << ADC_INTR_SHIFT)
>> +
>> +/* Number of time to retry a set of the interrupt mask reg */
>> +#define INTMASK_RETRY_ATTEMPTS               10
>> +
>> +/* ANALOG_CONTROL Bit Masks */
>> +#define CHANNEL_SEL_SHIFT            11
>> +#define CHANNEL_SEL_MASK             (0x7 << CHANNEL_SEL_SHIFT)
>> +
>> +/* ADC_CHANNEL_REGCTL1 Bit Masks */
>> +#define CHANNEL_ROUNDS_SHIFT         0x2
>> +#define CHANNEL_ROUNDS_MASK          (0x3F << CHANNEL_ROUNDS_SHIFT)
>> +#define CHANNEL_MODE_SHIFT           0x1
>> +#define CHANNEL_MODE_MASK            (0x1 << CHANNEL_MODE_SHIFT)
>> +#define CHANNEL_MODE_TDM             (0x1)
>> +#define CHANNEL_MODE_SNAPSHOT                (0x0)
>> +#define CHANNEL_ENABLE_SHIFT         0x0
>> +#define CHANNEL_ENABLE_MASK          (0x1)
>> +
>> +#define CHANNEL_ENABLE                       (0x1)
>> +#define CHANNEL_DISABLE                      (0x0)
>> +
>> +/* ADC_CHANNEL_REGCTL2 Bit Masks */
>> +#define CHANNEL_WATERMARK_SHIFT              0x0
>> +#define CHANNEL_WATERMARK_MASK               (0x3F << CHANNEL_WATERMARK_SHIFT)
>> +
>> +#define WATER_MARK_LEVEL             (0x1)
>> +
>> +/* ADC_CHANNEL_STATUS Bit Masks */
>> +#define CHANNEL_DATA_LOST_SHIFT              0x0
>> +#define CHANNEL_DATA_LOST_MASK               (0x0 << CHANNEL_DATA_LOST_SHIFT)
>> +#define CHANNEL_VALID_ENTERIES_SHIFT 0x1
>> +#define CHANNEL_VALID_ENTERIES_MASK  (0xFF << CHANNEL_VALID_ENTERIES_SHIFT)
>> +#define CHANNEL_TOTAL_ENTERIES_SHIFT 0x9
>> +#define CHANNEL_TOTAL_ENTERIES_MASK  (0xFF << CHANNEL_TOTAL_ENTERIES_SHIFT)
>> +
>> +/* ADC_CHANNEL_INTERRUPT_MASK Bit Masks */
>> +#define CHANNEL_WTRMRK_INTR_SHIFT    (0x0)
>> +#define CHANNEL_WTRMRK_INTR_MASK     (0x1 << CHANNEL_WTRMRK_INTR_SHIFT)
>> +#define CHANNEL_FULL_INTR_SHIFT              0x1
>> +#define CHANNEL_FULL_INTR_MASK               (0x1 << CHANNEL_FULL_INTR_SHIFT)
>> +#define CHANNEL_EMPTY_INTR_SHIFT     0x2
>> +#define CHANNEL_EMPTY_INTR_MASK              (0x1 << CHANNEL_EMPTY_INTR_SHIFT)
> All the above want a suitable prefix fo avoid potential name clashes with
> stuff defined in headers in the future.  Perhaps IPROC_CHANNEL_EMPTY_INTR_MASK
> or similar?  Another convention is to have the name in some way indicate
> which address it is for when relevant.

I was thinking that using the prefix will again increase the size of the define
which will reduce the readability but yes as you say it's needed to avoid
name clashes. Will fix it in the next patch.

>> +
>> +#define WATER_MARK_INTR_ENABLE               (0x1)
>> +
>> +#define iproc_dbg_reg(dev, priv, reg) \
>> +do { \
>> +     u32 val; \
>> +     regmap_read(priv->regmap, reg, &val); \
>> +     dev_dbg(dev, "%20s= 0x%08x\n", #reg, val); \
>> +} while (0)
>> +
>> +struct iproc_adc_priv {
>> +     struct regmap *regmap;
>> +     struct clk *adc_clk;
>> +     struct mutex mutex;
>> +     int  irqno;
>> +     int chan_val;
>> +     int chan_id;    /* Channel id */
> interesting blend of no documentation and rather obvious documentation.
> It's all pretty obvious so I'd just not bother documented chan_id either!

will take care of this in the next patch to not to have obvious documentation.

>> +     struct completion completion;
>> +};
>> +
> Hmm. A lot of info to dump.  Perhaps debugfs support would make more
> sense?  Then any of this stuff could be available if anyone had reason
> to look at it?  Obviously these are all on dev_dbg anyway so it's not
> to much of an issue.

We don't need a debugfs support.
It's just added as a means to know the register values in case of failure
in writing the IPROC_INTERRUPT_MASK register. There was a very rare
issue where writing to this register does not take effect.

>> +static void iproc_adc_reg_dump(struct iio_dev *indio_dev)
>> +{
>> +     struct iproc_adc_priv *adc_priv;
>> +     struct device *dev = &indio_dev->dev;
>> +
>> +     adc_priv = iio_priv(indio_dev);
>> +
>> +     iproc_dbg_reg(dev, adc_priv, REGCTL1);
>> +     iproc_dbg_reg(dev, adc_priv, REGCTL2);
>> +     iproc_dbg_reg(dev, adc_priv, INTERRUPT_THRES);
>> +     iproc_dbg_reg(dev, adc_priv, INTRPT_MASK);
>> +     iproc_dbg_reg(dev, adc_priv, INTRPT_STATUS);
>> +     iproc_dbg_reg(dev, adc_priv, CONTROLLER_STATUS);
>> +     iproc_dbg_reg(dev, adc_priv, ANALOG_CONTROL);
>> +     iproc_dbg_reg(dev, adc_priv, AUX_DATA);
>> +     iproc_dbg_reg(dev, adc_priv, SOFT_BYPASS_CONTROL);
>> +     iproc_dbg_reg(dev, adc_priv, SOFT_BYPASS_DATA);
>> +}
>> +
>> +static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
>> +{
>> +     struct iproc_adc_priv *adc_priv;
>> +     struct iio_dev *indio_dev = data;
>> +     u32 channel_intr_status;
>> +     u32 intr_status;
>> +     u32 intr_mask;
>> +     irqreturn_t retval = IRQ_NONE;
>> +
>> +     adc_priv = iio_priv(indio_dev);
>> +
>> +     /*
>> +      * This interrupt is shared with the touchscreen driver.
>> +      * Make sure this interrupt is intended for us.
>> +      * Handle only ADC channel specific interrupts.
>> +      */
>> +     regmap_read(adc_priv->regmap, INTRPT_STATUS, &intr_status);
>> +     regmap_read(adc_priv->regmap, INTRPT_MASK, &intr_mask);
>> +     intr_status = intr_status & intr_mask;
>> +     channel_intr_status = (intr_status & ADC_INTR_MASK) >> ADC_INTR_SHIFT;
>> +     if (channel_intr_status)
>> +             retval = IRQ_WAKE_THREAD;
> I'd return IRQ_NONE below and IRQ_WAKE_THREAD above + drop the retval
> local variable entirely.

Yes, will fix it in next patch.

>> +     return retval;
>> +}
>> +
>> +static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
>> +{
>> +     irqreturn_t retval = IRQ_NONE;
>> +     struct iproc_adc_priv *adc_priv;
>> +     struct iio_dev *indio_dev = data;
>> +     unsigned int valid_entries;
>> +     u32 intr_status;
>> +     u32 intr_channels;
>> +     u32 channel_status;
>> +     u32 ch_intr_status;
>> +
>> +     adc_priv = iio_priv(indio_dev);
>> +
>> +     regmap_read(adc_priv->regmap, INTRPT_STATUS, &intr_status);
> Seems a little convoluted to read this again given we read it in the top half
> but I guess if this is cheap it is cleaner than stashing the value for
> consumption here.

I think reading in the register again is better than saving the value
read in top half.

>> +     dev_dbg(&indio_dev->dev, "iproc_adc_interrupt_thread(),INTRPT_STS:%x\n",
>> +                     intr_status);
>> +
>> +     intr_channels = (intr_status & ADC_INTR_MASK) >> ADC_INTR_SHIFT;
>> +     if (intr_channels) {
>> +             regmap_read(adc_priv->regmap,
>> +                         ADC_CHANNEL_INTERRUPT_STATUS +
>> +                         ADC_CHANNEL_OFFSET * adc_priv->chan_id,
>> +                         &ch_intr_status);
>> +             if (ch_intr_status & CHANNEL_WTRMRK_INTR_MASK) {
>> +                     regmap_write(adc_priv->regmap,
>> +                                     ADC_CHANNEL_INTERRUPT_MASK +
>> +                                     ADC_CHANNEL_OFFSET *
>> +                                     adc_priv->chan_id,
>> +                                     (ch_intr_status &
>> +                                     ~(CHANNEL_WTRMRK_INTR_MASK)));
> I'd normally expect to see an interrupt clear as late as possible - is there
> any potential for a second reading coming in, resulting in the interrupt being
> set again unintentionally?

There's not potential for a second reading coming in, I can clear it late.
Not an issue, will fix it in the next patch.

>> +
>> +                     regmap_read(adc_priv->regmap,
>> +                                     ADC_CHANNEL_STATUS +
>> +                                     ADC_CHANNEL_OFFSET * adc_priv->chan_id,
>> +                                     &channel_status);
>> +
>> +                     valid_entries = ((channel_status &
>> +                             CHANNEL_VALID_ENTERIES_MASK) >>
>> +                             CHANNEL_VALID_ENTERIES_SHIFT);
>> +                     if (valid_entries >= 1) {
>> +                             regmap_read(adc_priv->regmap,
>> +                                     ADC_CHANNEL_DATA +
>> +                                     ADC_CHANNEL_OFFSET *
>> +                                     adc_priv->chan_id,
>> +                                     &adc_priv->chan_val);
>> +                             complete(&adc_priv->completion);
>> +                     } else {
>> +                             dev_err(&indio_dev->dev,
>> +                                     "No data rcvd on channel %d\n",
>> +                                     adc_priv->chan_id);
>> +                     }
>> +             }
>> +             regmap_write(adc_priv->regmap,
>> +                         ADC_CHANNEL_INTERRUPT_STATUS +
>> +                         ADC_CHANNEL_OFFSET * adc_priv->chan_id,
>> +                         ch_intr_status);
>> +             regmap_write(adc_priv->regmap, INTRPT_STATUS, intr_channels);
>> +             retval = IRQ_HANDLED;
>> +     }
>> +     return retval;
>> +}
>> +
>> +int iproc_adc_read_raw(struct iio_dev *indio_dev,
>> +                        int channel,
>> +                        u16 *p_adc_data)
>> +{
>> +     int read_len = 0;
>> +     u32 val;
>> +     u32 mask;
>> +     u32 val_check;
>> +     int failed_cnt = 0;
>> +     struct iproc_adc_priv *adc_priv;
>> +
>> +     adc_priv = iio_priv(indio_dev);
> Roll two lines above into 1.

Ok.

>> +
>> +     mutex_lock(&adc_priv->mutex);
>> +
>> +     /* After a read is complete the ADC interrupts will be disabled so
> multiline comment syntax.

Ok. Yes, will take care of this in the next patch.

>> +      * we can assume this section of code is save from interrupts.
>> +      */
>> +     adc_priv->chan_val = -1;
>> +     adc_priv->chan_id = channel;
>> +
>> +     reinit_completion(&adc_priv->completion);
>> +     /* Clear any pending interrupt */
>> +     regmap_update_bits(adc_priv->regmap, INTRPT_STATUS, ADC_INTR_MASK |
>> +                     ADC_AUXDATA_RDY_INTR, ((CHANNEL_DISABLE << channel) <<
>> +                     ADC_INTR_SHIFT) | ADC_AUXDATA_RDY_INTR);
> The above could be broken in slightly more readable fashion perhaps...
> (not easy admittedly)

Bit difficult to break down.

>> +
>> +     /* Configure channel for snapshot mode and enable  */
>> +     val = (BIT(CHANNEL_ROUNDS_SHIFT) |
>> +            (CHANNEL_MODE_SNAPSHOT << CHANNEL_MODE_SHIFT) |
>> +            (CHANNEL_ENABLE << CHANNEL_ENABLE_SHIFT));
>> +
>> +     mask = CHANNEL_ROUNDS_MASK | CHANNEL_MODE_MASK | CHANNEL_ENABLE_MASK;
>> +     regmap_update_bits(adc_priv->regmap, (ADC_CHANNEL_REGCTL1 +
>> +                             ADC_CHANNEL_OFFSET * channel),
>> +                             mask, val);
>> +
>> +     /* Set the Watermark for a channel */
>> +     regmap_update_bits(adc_priv->regmap, (ADC_CHANNEL_REGCTL2 +
>> +                                           ADC_CHANNEL_OFFSET * channel),
>> +                        CHANNEL_WATERMARK_MASK, WATER_MARK_LEVEL);
> Funily enough, I'd use 1 in stead of the WATER_MARK_LEVEL define here.
> Makes it slightly easier to work out what is going on.
> (this looks like an interesting bit of hardware, will read what I can later!)

Yes,  Will fix it in the next patch.

>> +
>> +     /* Enable water mark interrupt */
>> +     regmap_update_bits(adc_priv->regmap, (ADC_CHANNEL_INTERRUPT_MASK +
>> +                                           ADC_CHANNEL_OFFSET * channel),
>> +                        CHANNEL_WTRMRK_INTR_MASK, WATER_MARK_INTR_ENABLE);
>> +     regmap_read(adc_priv->regmap, INTRPT_MASK, &val);
>> +
>> +     /* Enable ADC interrupt for a channel */
>> +     val |= (BIT(channel) << ADC_INTR_SHIFT);
>> +     regmap_write(adc_priv->regmap, INTRPT_MASK, val);
>> +
>> +     /* There seems to be a very rare issue where writing to this register
>> +      * does not take effect.  To work around the issue we will try multiple
>> +      * writes.  In total we will spend about 10*10 = 100 us attempting this.
>> +      * Testing has shown that this may loop a few time, but we have never
>> +      * hit the full count.
>> +      */
>> +     regmap_read(adc_priv->regmap, INTRPT_MASK, &val_check);
>> +     while (val_check != val) {
>> +             failed_cnt++;
>> +
>> +             if (failed_cnt > INTMASK_RETRY_ATTEMPTS)
>> +                     break;
>> +
>> +             udelay(10);
>> +             regmap_update_bits(adc_priv->regmap, INTRPT_MASK,
>> +                             ADC_INTR_MASK,
>> +                             ((CHANNEL_ENABLE << channel) <<
>> +                             ADC_INTR_SHIFT));
>> +
>> +             regmap_read(adc_priv->regmap, INTRPT_MASK, &val_check);
>> +     }
>> +
>> +     if (failed_cnt) {
>> +             dev_dbg(&indio_dev->dev,
>> +                     "IntMask failed (%d times)", failed_cnt);
>> +             if (failed_cnt > INTMASK_RETRY_ATTEMPTS) {
>> +                     dev_err(&indio_dev->dev,
>> +                             "IntMask set failed. Read will likely fail.");
>> +                     read_len = -EIO;
>> +                     goto adc_err;
>> +             };
>> +     }
>> +     regmap_read(adc_priv->regmap, INTRPT_MASK, &val_check);
>> +
>> +     if (wait_for_completion_timeout(&adc_priv->completion,
>> +             IPROC_ADC_READ_TIMEOUT) > 0) {
>> +
>> +             /* Only the lower 16 bits are relevant */
>> +             *p_adc_data = adc_priv->chan_val & 0xFFFF;
>> +             read_len = sizeof(*p_adc_data);
>> +
>> +     } else {
>> +             /* We never got the interrupt, something went wrong.
>> +              * Perhaps the interrupt may still be coming, we do not want
>> +              * that now.  Lets disable the ADC interrupt, and clear the
>> +              * status to put it back in to normal state.
>> +              */
>> +             read_len = -ETIMEDOUT;
>> +             goto adc_err;
>> +     }
>> +     mutex_unlock(&adc_priv->mutex);
>> +     return read_len;
>> +
>> +adc_err:
>> +     regmap_update_bits(adc_priv->regmap, INTRPT_MASK,
>> +                        ADC_INTR_MASK,
>> +                        ((CHANNEL_DISABLE << channel) << ADC_INTR_SHIFT));
>> +
>> +     regmap_update_bits(adc_priv->regmap, INTRPT_STATUS,
>> +                        ADC_INTR_MASK, ((CHANNEL_DISABLE << channel)
>> +                                        <<  ADC_INTR_SHIFT));
>> +
>> +     dev_err(&indio_dev->dev, "Timed out waiting for ADC data!\n");
>> +     iproc_adc_reg_dump(indio_dev);
>> +     mutex_unlock(&adc_priv->mutex);
> blank line preferred before return.

Ok, will fix it in the next patch.

>> +     return read_len;
>> +}
>> +
>> +static void iproc_adc_enable(struct iio_dev *indio_dev)
>> +{
>> +     u32 val;
>> +     u32 channel_id;
>> +     struct iproc_adc_priv *adc_priv;
>> +
>> +     adc_priv = iio_priv(indio_dev);
> Again I'd roll this and the above into a single line.

Ok, will fix it in the next patch.

>> +
>> +     /* Set i_amux = 3b'000, select channel 0 */
>> +     regmap_update_bits(adc_priv->regmap, ANALOG_CONTROL,
>> +                        CHANNEL_SEL_MASK, 0);
> I'd prefer to see some error handling in here.  Might be very unlikely
> that an error can occur, but best practice and all that.

My experience working with device is also same, very rarely seen issues
with read/writes.

>> +     adc_priv->chan_val = -1;
>> +
>> +     /* PWR up LDO, ADC, and Band Gap (0 to enable)
> Please use standard kernel multiline comment syntax. If not I'll only
> get 'fix' patches a few days after this hits the tree.

Yes, sure. Will fix it in next patch.

>> +      * Also enable ADC controller (set high)
>> +      */
>> +     regmap_read(adc_priv->regmap, REGCTL2, &val);
>> +
>> +     val &= ~(ADC_PWR_LDO | ADC_PWR_ADC | ADC_PWR_BG);
>> +
>> +     regmap_write(adc_priv->regmap, REGCTL2, val);
>> +
>> +     regmap_read(adc_priv->regmap, REGCTL2, &val);
>> +     val |= ADC_CONTROLLER_EN;
>> +     regmap_write(adc_priv->regmap, REGCTL2, val);
>> +     for (channel_id = 0; channel_id < indio_dev->num_channels;
>> +             channel_id++) {
>> +             regmap_write(adc_priv->regmap, ADC_CHANNEL_INTERRUPT_MASK +
>> +                          ADC_CHANNEL_OFFSET * channel_id, 0);
>> +             regmap_write(adc_priv->regmap, ADC_CHANNEL_INTERRUPT_STATUS +
>> +                          ADC_CHANNEL_OFFSET * channel_id, 0);
>> +     }
>> +}
>> +
>> +static void iproc_adc_disable(struct iio_dev *indio_dev)
>> +{
>> +     struct iproc_adc_priv *adc_priv;
>> +     u32 val;
>> +
>> +     adc_priv = iio_priv(indio_dev);
> I'd roll this in above

Yes.

> struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
> It's only offset macro magic, so not worthy of it's own line ;)
>> +
>> +     regmap_read(adc_priv->regmap, REGCTL2, &val);
>> +     val &= ~(ADC_CONTROLLER_EN);
>> +     regmap_write(adc_priv->regmap, REGCTL2, val);
>> +}
>> +
>> +static int iproc_read_raw(struct iio_dev *indio_dev,
>> +                       struct iio_chan_spec const *chan,
>> +                       int *val,
>> +                       int *val2,
>> +                       long mask)
>> +{
>> +     u16 adc_data;
>> +     int err;
>> +
>> +     if (mask != IIO_CHAN_INFO_RAW)
>> +             return -EINVAL;
>> +
>> +     err =  iproc_adc_read_raw(indio_dev,
>> +                             chan->channel,
>> +                             &adc_data);
> Excessive wrapping

Can't avoid Excessive wrapping :(

>> +     err =  iproc_adc_read_raw(indio_dev, chan->channel, &adc_data);
>
>> +     if (err < 0)
>> +             return err;
>> +
>> +     *val = adc_data;
> Slight preference for a blank line here..

Ok, will fix it in the next patch.

>> +     return IIO_VAL_INT;
>> +}
>> +
>> +static const struct iio_info iproc_adc_iio_info = {
>> +     .read_raw = &iproc_read_raw,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +#define ADC_CHANNEL(_index, _id) {                      \
>> +     .type = IIO_VOLTAGE,                            \
>> +     .indexed = 1,                                   \
>> +     .channel = _index,                              \
>> +     .address = _index,                              \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),   \
> No information at all available on voltage scalling on these channels?
> That would be ususual.  Obviously you may well have an analog front
> end doing crazy things, but would expect to at least be able to get
> hold of real values at the edge of the chip.

This is a 10 bit ADC which can measure 0 to 1.8V. Resulting in scale value
of 1.757812500(1800mv/1024). Will add support to know the scale value
in the next patch.

>> +     .datasheet_name = _id,                          \
>> +}
>> +
>> +static const struct iio_chan_spec iproc_adc_iio_channels[] = {
>> +     ADC_CHANNEL(0, "adc0"),
>> +     ADC_CHANNEL(1, "adc1"),
>> +     ADC_CHANNEL(2, "adc2"),
>> +     ADC_CHANNEL(3, "adc3"),
>> +     ADC_CHANNEL(4, "adc4"),
>> +     ADC_CHANNEL(5, "adc5"),
>> +     ADC_CHANNEL(6, "adc6"),
>> +     ADC_CHANNEL(7, "adc7"),
>> +};
>> +
>> +static int iproc_adc_probe(struct platform_device *pdev)
>> +{
>> +     struct iproc_adc_priv *adc_priv;
>> +     struct iio_dev *indio_dev = NULL;
>> +     int ret;
>> +
>> +     indio_dev = devm_iio_device_alloc(&pdev->dev,
>> +                                     sizeof(struct iproc_adc_priv));
> Personal preference is for sizeof(*adc_priv) as it adds an explicit
> label of what is going in here... (really minor point!)

Yes, will fix it in the next patch.

>> +     if (!indio_dev) {
>> +             dev_err(&pdev->dev, "failed to allocate iio device\n");
>> +             return -ENOMEM;
>> +     }
>> +     adc_priv = iio_priv(indio_dev);
>> +     platform_set_drvdata(pdev, indio_dev);
>> +
>> +     mutex_init(&adc_priv->mutex);
>> +
>> +     init_completion(&adc_priv->completion);
>> +
>> +     adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> +                        "adc-syscon");
>> +     if (IS_ERR(adc_priv->regmap)) {
>> +             dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
>> +             ret = PTR_ERR(adc_priv->regmap);
>> +             return ret;
>> +     }
>> +
>> +     adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
>> +     if (IS_ERR(adc_priv->adc_clk)) {
>> +             dev_err(&pdev->dev,
>> +                     "failed getting clock tsc_clk\n");
>> +             ret = PTR_ERR(adc_priv->adc_clk);
>> +             return ret;
>> +     }
>> +
>> +     /* get interrupt */
>> +     adc_priv->irqno = platform_get_irq(pdev, 0);
>> +     if (adc_priv->irqno <= 0) {
>> +             dev_err(&pdev->dev, "platform_get_irq failed\n");
>> +             ret = -ENODEV;
>> +             return ret;
>> +     }
>> +
>> +     regmap_update_bits(adc_priv->regmap, REGCTL2, ADC_AUXIN_SCAN_ENA, 0);
> In general I'd like to see more error handling around reads and writes
> to the device.

I feel generally reads/writes failure is very rare and thought that
it's too much
of code to check return values in every read/write.
Let me try to add necessary read/write failure checks.

>> +
>> +     ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
>> +                             iproc_adc_interrupt_thread,
>> +                             iproc_adc_interrupt_handler,
>> +                             IRQF_SHARED, "iproc-adc", indio_dev);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "request_irq error %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     /* Enable clock */
>> +     ret = clk_prepare_enable(adc_priv->adc_clk);
>> +     if (ret) {
>> +             dev_err(&pdev->dev,
>> +                     "clk_prepare_enable failed %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     iproc_adc_enable(indio_dev);
>> +
>> +     indio_dev->name = dev_name(&pdev->dev);
>> +     indio_dev->dev.parent = &pdev->dev;
>> +     indio_dev->dev.of_node = pdev->dev.of_node;
>> +     indio_dev->info = &iproc_adc_iio_info;
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->channels = iproc_adc_iio_channels;
>> +     indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
>> +             goto err_clk;
>> +     }
>> +     return 0;
>> +
>> +err_clk:
>> +     iproc_adc_disable(indio_dev);
>> +     clk_disable_unprepare(adc_priv->adc_clk);
> Aside: If it had been necessary to set the platform_set_drvdata to
> NULL it would have been necessary here as well.
> Quick rule of thumb I use for reviewing is the error path in probe should
> match the code in remove (other than the very first call for obvious
> reasons)

Thanks for the info. Will fix this in the next patch.

>> +     return ret;
>> +}
>> +
>> +static int iproc_adc_remove(struct platform_device *pdev)
>> +{
>> +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +     struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
>> +
>> +     iio_device_unregister(indio_dev);
>> +     iproc_adc_disable(indio_dev);
>> +     clk_disable_unprepare(adc_priv->adc_clk);
>> +     iio_device_free(indio_dev);
> You are using a managed call to allocate this.  No need to free it.
> Actually as currently stands you are freeing it twice as a free should
> (if it were needed) should have been done with devm_iio_device_free to
> clear up the reference as well.

Yes, Thanks for the info. will fix it in next patch.

>> +     platform_set_drvdata(pdev, NULL);
> This is handled by the core and has been since :
> 0998d063 device-core: Ensure drvdata = NULL when no driver is bound

Ok, will remove this in the next patch.

> Nitpick : Blank line here before the return.

Ok, will fix it.

>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id iproc_adc_of_match[] = {
>> +     {.compatible = "brcm,iproc-static-adc", },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, iproc_adc_of_match);
>> +
>> +static struct platform_driver iproc_adc_driver = {
>> +     .probe  = iproc_adc_probe,
>> +     .remove = iproc_adc_remove,
>> +     .driver = {
>> +             .name   = "iproc-static-adc",
>> +             .of_match_table = of_match_ptr(iproc_adc_of_match),
>> +     },
>> +};
>> +
>> +
>> +module_platform_driver(iproc_adc_driver);
>> +
>> +MODULE_DESCRIPTION("IPROC ADC driver");
>> +MODULE_AUTHOR("Broadcom");
>> +MODULE_LICENSE("GPL v2");
>>
>
