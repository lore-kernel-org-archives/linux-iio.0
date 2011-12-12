Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:6780
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751423Ab1LLK0l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 05:26:41 -0500
Message-ID: <4EE5D49E.7010507@analog.com>
Date: Mon, 12 Dec 2011 11:17:02 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: pll: New driver for ADF4350/ADF4351 Wideband Synthesizers
 (PLL)
References: <1323436951-11246-1-git-send-email-michael.hennerich@analog.com> <4EE36FA1.5070902@kernel.org>
In-Reply-To: <4EE36FA1.5070902@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/2011 03:41 PM, Jonathan Cameron wrote:
> On 12/09/2011 01:22 PM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> This patch adds support for Analog Devices ADF4350/ADF4351
>> Wideband Synthesizers (35MHz to 4.4GHz).
> Hi Michael,
>
> Whilst I have no particular issue with having this device driver
> in IIO I can see that it has considerable overlap with the clock
> infrastructure. Perhaps you could give a quick summary of why it
> doesn't make more sense to fit this device in there?
Hi Jonathan,

The in-kernel clock infrastructure is aimed for SoC like
clock distribution. Typically one master clock,
and a number of scaled down clocks for the various clock
salve peripherals. For example typical clock slaves here are:
SPI, I2C, UART, MMC, Video, etc.

This PLL device is more aimed for generating a standalone clock
used in industrial and communications applications.
For example a Local Oscillator (LO) Frequency used with a Wide-band Mixer
generating another Intermediate Frequency (IF) which is then samples by an
ADC.

Also PLL input clocks are typically high stability, low phase noise 
clock sources,
an not something derived from a SoC clock.


> There are a number of 'magic' register elements in the platform
> data. I'd much prefer to see them broken down into their
> constituent parts.
>
> Various other bits and bobs inline...
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>> ---
>>   .../staging/iio/Documentation/sysfs-bus-iio-pll    |   46 ++
>>   drivers/staging/iio/Kconfig                        |    1 +
>>   drivers/staging/iio/Makefile                       |    1 +
>>   drivers/staging/iio/pll/Kconfig                    |   16 +
>>   drivers/staging/iio/pll/Makefile                   |    5 +
>>   drivers/staging/iio/pll/adf4350.c                  |  485 ++++++++++++++++++++
>>   drivers/staging/iio/pll/adf4350.h                  |  121 +++++
>>   7 files changed, 675 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>>   create mode 100644 drivers/staging/iio/pll/Kconfig
>>   create mode 100644 drivers/staging/iio/pll/Makefile
>>   create mode 100644 drivers/staging/iio/pll/adf4350.c
>>   create mode 100644 drivers/staging/iio/pll/adf4350.h
>>
>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-pll b/drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>> new file mode 100644
>> index 0000000..2aa2497
>> --- /dev/null
>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>> @@ -0,0 +1,46 @@
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/out_pllY_freq
>> +KernelVersion:       3.2.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Stores PLL Y frequency in Hz. Reading returns the
>> +             actual frequency in Hz. When setting a new frequency, the PLL
>> +             requires some time to lock. If available, the user can read
>> +             out_pllY_locked in order to check whether the PLL has locked
>> +             or not.
> Is the fact that it is a pll vital?  ultimately it's just a frequency output
> as far as we are concerned (up to the 'locked' stuff).  I wonder if we
> should
> be sharing more between this interface and the dds one.  (I'm happy to be
> convinced either way!)
In fact - I was thinking about the same thing.
The DDS parts are typically different from the PLL,
however there is a common denominator.

How about we rename iio/dds to iio/frequency.
But I'm a bit unsure about the naming convention.

For dds we have out_ddsX_freqY or out_ddsX_outY_enable.
shall we keep that scheme and likewise add:
out_pllX_freqY, or move on to something like:

out_devX_freqY ?
out_freqX_Y ?
out_outX_Y_enable ?


>     Having said that, the dds docs at least haven't
> caught up with the out_ and in_ prefixes which isn't a great start...
Thanks - I noticed that and a patch is already in my queue.

> How about semantics of having a write to this file wait to return until
> locking has occured?  Just a thought.
I could do that - but we need the pll_locked attribute anyways.
The PLL could unlock under certain circumstances.
We therefore need an option to check the lock state.

>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/out_pllY_freq_resolution
>> +KernelVersion:       3.2.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Stores PLL Y frequency resolution/channel spacing in Hz.
>> +             The value given directly influences the MODULUS used by
>> +             the fractional-N PLL. It is assumed that the algorithm
>> +             that is used to compute the various dividers, is able to
>> +             generate proper values for multiples of channel spacing.
>> +
> Is this dependent on where we are wrt to current frequency?
No, it gives you the option so set a channel spacing,
used in your application. For example 200kHz for UMTS, GSM
and 15kHz for LTE.
The value written goes into account, only in subsequent writes to 
out_pllY_freq.

>> +What:                /sys/bus/iio/devices/iio:deviceX/out_pllY_refin_freq
>> +KernelVersion:       3.2.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Sets PLL Y REFin frequency in Hz. In some clock chained
>> +             applications, the reference frequency used by the PLL may
>> +             change during runtime. This attribute allows the user to
>> +             adjust the reference frequency accordingly.
> If this is a clock, doesn't the kernel have some reasonable extensive
> infrastructure for handling it?  linux/clk.h.  This isn't an area I know
> well so freel free to tell me why I'm completely wrong  :)
See comment above. The REFin frequency might be supplied by something
not under control of the kernel.

>> +             The value written has no effect until out_pllY_freq is updated.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/out_pllY_powerdown
>> +KernelVersion:       3.2.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             If available, this attribute allows the user to power down
>> +             the PLL and it's RFOut buffers. This is in particular useful
>> +             during REFin changes.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/out_pllY_locked
>> +KernelVersion:       3.2.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             If available, this attribute allows the user to determine
>> +             whether the PLL has locked by reading '1' or not '0'.
>> +
>> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
>> index 90162aa..d85e5ac 100644
>> --- a/drivers/staging/iio/Kconfig
>> +++ b/drivers/staging/iio/Kconfig
>> @@ -68,6 +68,7 @@ source "drivers/staging/iio/imu/Kconfig"
>>   source "drivers/staging/iio/light/Kconfig"
>>   source "drivers/staging/iio/magnetometer/Kconfig"
>>   source "drivers/staging/iio/meter/Kconfig"
>> +source "drivers/staging/iio/pll/Kconfig"
>>   source "drivers/staging/iio/resolver/Kconfig"
>>   source "drivers/staging/iio/trigger/Kconfig"
>>
>> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
>> index 1340aea..433b235 100644
>> --- a/drivers/staging/iio/Makefile
>> +++ b/drivers/staging/iio/Makefile
>> @@ -29,5 +29,6 @@ obj-y += imu/
>>   obj-y += light/
>>   obj-y += magnetometer/
>>   obj-y += meter/
>> +obj-y += pll/
>>   obj-y += resolver/
>>   obj-y += trigger/
>> diff --git a/drivers/staging/iio/pll/Kconfig b/drivers/staging/iio/pll/Kconfig
>> new file mode 100644
>> index 0000000..ebbe926
>> --- /dev/null
>> +++ b/drivers/staging/iio/pll/Kconfig
>> @@ -0,0 +1,16 @@
>> +#
>> +# Phase-Locked Loop (PLL) frequency synthesizers
>> +#
>> +menu "Phase-Locked Loop (PLL) frequency synthesizers"
>> +
>> +config ADF4350
>> +     tristate "Analog Devices ADF4350/ADF4351 Wideband Synthesizers"
>> +     depends on SPI
>> +     help
>> +       Say yes here to build support for Analog Devices  ADF4350/ADF4351
>> +       Wideband Synthesizers. The driver provides direct access via sysfs.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called adf4350.
>> +
>> +endmenu
>> diff --git a/drivers/staging/iio/pll/Makefile b/drivers/staging/iio/pll/Makefile
>> new file mode 100644
>> index 0000000..6990bd9
>> --- /dev/null
>> +++ b/drivers/staging/iio/pll/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# Phase-Locked Loop (PLL) frequency synthesizers
>> +#
>> +
>> +obj-$(CONFIG_ADF4350) += adf4350.o
>> diff --git a/drivers/staging/iio/pll/adf4350.c b/drivers/staging/iio/pll/adf4350.c
>> new file mode 100644
>> index 0000000..027a91e
>> --- /dev/null
>> +++ b/drivers/staging/iio/pll/adf4350.c
>> @@ -0,0 +1,485 @@
>> +/*
>> + * ADF4350/ADF4351 SPI Wideband Synthesizer driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include<linux/device.h>
>> +#include<linux/kernel.h>
>> +#include<linux/slab.h>
>> +#include<linux/sysfs.h>
>> +#include<linux/spi/spi.h>
>> +#include<linux/regulator/consumer.h>
>> +#include<linux/err.h>
>> +#include<linux/module.h>
>> +#include<linux/gcd.h>
>> +#include<linux/gpio.h>
>> +#include<asm/div64.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +
>> +#include "adf4350.h"
>> +
>> +enum {
>> +     ADF4350_SET_FREQ,
>> +     ADF4350_SET_FREQ_REFIN,
>> +     ADF4350_SET_FREQ_RESOLUTION,
>> +     ADF4350_PLL_LOCKED,
>> +     ADF4350_PLL_PWRDOWN,
>> +};
>> +
>> +struct adf4350_state {
>> +     struct spi_device               *spi;
>> +     struct regulator                *reg;
>> +     struct adf4350_platform_data    *pdata;
>> +     unsigned long                   clkin;
>> +     unsigned long                   chspc;
> Few cryptic names in here I'd like to see coments about..
PFD= Phase frequency detector
chspc = channel spacing

I'll add some comments.

>> +     unsigned long                   fpfd;
>> +     unsigned long                   min_out_freq;
>> +     unsigned                        r0_fract;
>> +     unsigned                        r0_int;
>> +     unsigned                        r1_mod;
>> +     unsigned                        r4_rf_div_sel;
>> +     unsigned long                   regs[6];
>> +     unsigned long                   regs_hw[6];
>> +
>> +     /*
>> +      * DMA (thus cache coherency maintenance) requires the
>> +      * transfer buffers to live in their own cache lines.
>> +      */
>> +     __be32                          val ____cacheline_aligned;
>> +};
>> +
>> +static struct adf4350_platform_data default_pdata = {
>> +     .clkin = 10000000,
>> +     .channel_spacing = 10000,
>> +     .r2_user_settings = ADF4350_REG2_PD_POLARITY_POS,
>> +                         ADF4350_REG2_CHARGE_PUMP_CURR_uA(2500),
>> +     .r3_user_settings = ADF4350_REG3_12BIT_CLKDIV_MODE(0),
>> +     .r4_user_settings = ADF4350_REG4_OUTPUT_PWR(0) |
>> +                         ADF4350_REG4_MUTE_TILL_LOCK_EN,
>> +     .gpio_lock_detect = -1,
>> +};
>> +
>> +static int adf4350_sync_config(struct adf4350_state *st)
>> +{
>> +     int ret, i, doublebuf = 0;
>> +
>> +     for (i = ADF4350_REG5; i>= ADF4350_REG0; i--) {
>> +             if ((st->regs_hw[i] != st->regs[i]) ||
>> +                     ((i == ADF4350_REG0)&&  doublebuf)) {
>> +
>> +                     switch (i) {
>> +                     case ADF4350_REG1:
>> +                     case ADF4350_REG4:
>> +                             doublebuf = 1;
>> +                             break;
>> +                     case ADF4350_REG0:
>> +                             doublebuf = 0;
> I don't think this value can ever make any difference to anything..
> You will only hit the cease statement when i == ...REG0 and that
> is last run of of the loop.
I know - I'll remove this case.

>> +                             break;
>> +                     }
>> +
>> +                     st->val  = cpu_to_be32(st->regs[i] | i);
>> +                     ret = spi_write(st->spi,&st->val, 4);
>> +                     if (ret<  0)
>> +                             return ret;
>> +                     st->regs_hw[i] = st->regs[i];
>> +                     dev_dbg(&st->spi->dev, "[%d] 0x%X\n",
>> +                             i, (u32)st->regs[i] | i);
>> +             }
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int adf4350_tune_r_cnt(struct adf4350_state *st, unsigned short r_cnt)
>> +{
>> +     struct adf4350_platform_data *pdata = st->pdata;
>> +
>> +     do {
>> +             r_cnt++;
>> +             st->fpfd = (st->clkin * (pdata->ref_doubler_en ? 2 : 1)) /
>> +                        (r_cnt * (pdata->ref_div2_en ? 2 : 1));
>> +     } while (st->fpfd>  ADF4350_MAX_FREQ_PFD);
>> +
>> +     return r_cnt;
>> +}
>> +
>> +static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>> +{
>> +     struct adf4350_platform_data *pdata = st->pdata;
>> +     u64 tmp;
>> +     u32 div_gcd, prescaler;
>> +     u16 mdiv, r_cnt = 0;
>> +     u8 band_sel_div;
>> +
>> +     if (freq>  ADF4350_MAX_OUT_FREQ || freq<  st->min_out_freq)
>> +             return -EINVAL;
>> +
>> +     if (freq>  ADF4350_MAX_FREQ_45_PRESC) {
>> +             prescaler = ADF4350_REG1_PRESCALER;
>> +             mdiv = 75;
>> +     } else {
>> +             prescaler = 0;
>> +             mdiv = 23;
>> +     }
>> +
>> +     st->r4_rf_div_sel = 0;
>> +
>> +     while (freq<  ADF4350_MIN_VCO_FREQ) {
>> +             freq<<= 1;
>> +             st->r4_rf_div_sel++;
>> +     }
>> +
> /*
>   * Allow...
>> +     /* Allow a predefined reference division factor
>> +      * if not set, compute our own
>> +      */
>> +     if (pdata->ref_div_factor)
>> +             r_cnt = pdata->ref_div_factor - 1;
>> +
>> +     do  {
>> +             r_cnt = adf4350_tune_r_cnt(st, r_cnt);
>> +
>> +             st->r1_mod = st->fpfd / st->chspc;
>> +             while (st->r1_mod>  ADF4350_MAX_MODULUS) {
>> +                     r_cnt = adf4350_tune_r_cnt(st, r_cnt);
>> +                     st->r1_mod = st->fpfd / st->chspc;
>> +             }
>> +
>> +             tmp = freq * (u64)st->r1_mod + (st->fpfd>  1);
>> +             do_div(tmp, st->fpfd); /* Div round closest (n + d/2)/d */
>> +             st->r0_fract = do_div(tmp, st->r1_mod);
>> +             st->r0_int = tmp;
>> +     } while (mdiv>  st->r0_int);
>> +
>> +     band_sel_div = DIV_ROUND_UP(st->fpfd, ADF4350_MAX_BANDSEL_CLK);
>> +
>> +     if (st->r0_fract&&  st->r1_mod) {
>> +             div_gcd = gcd(st->r1_mod, st->r0_fract);
>> +             st->r1_mod /= div_gcd;
>> +             st->r0_fract /= div_gcd;
>> +     } else {
>> +             st->r0_fract = 0;
>> +             st->r1_mod = 1;
>> +     }
>> +
>> +     dev_dbg(&st->spi->dev, "VCO: %llu Hz, PFD %lu Hz\n"
>> +             "REF_DIV %d, R0_INT %d, R0_FRACT %d\n"
>> +             "R1_MOD %d, RF_DIV %d\nPRESCALER %s, BAND_SEL_DIV %d\n",
>> +             freq, st->fpfd, r_cnt, st->r0_int, st->r0_fract, st->r1_mod,
>> +             1<<  st->r4_rf_div_sel, prescaler ? "8/9" : "4/5",
>> +             band_sel_div);
>> +
>> +     st->regs[ADF4350_REG0] = ADF4350_REG0_INT(st->r0_int) |
>> +                              ADF4350_REG0_FRACT(st->r0_fract);
>> +
>> +     st->regs[ADF4350_REG1] = ADF4350_REG1_PHASE(0) |
>> +                              ADF4350_REG1_MOD(st->r1_mod) |
>> +                              prescaler;
>> +
>> +     st->regs[ADF4350_REG3] = pdata->r3_user_settings&
>> +                              (ADF4350_REG3_12BIT_CLKDIV(0xFFF) |
>> +                              ADF4350_REG3_12BIT_CLKDIV_MODE(0x3) |
>> +                              ADF4350_REG3_12BIT_CSR_EN |
>> +                              ADF4351_REG3_CHARGE_CANCELLATION_EN |
>> +                              ADF4351_REG3_ANTI_BACKLASH_3ns_EN |
>> +                              ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH);
>> +
> Reorder these?  324 is unusual unless there is a reason...
The reason was, to group the indention style.

>> +     st->regs[ADF4350_REG2] =
>> +             ADF4350_REG2_10BIT_R_CNT(r_cnt) |
>> +             ADF4350_REG2_DOUBLE_BUFF_EN |
>> +             (pdata->ref_doubler_en ? ADF4350_REG2_RMULT2_EN : 0) |
>> +             (pdata->ref_div2_en ? ADF4350_REG2_RDIV2_EN : 0) |
>> +             (pdata->r2_user_settings&  (ADF4350_REG2_PD_POLARITY_POS |
>> +             ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
>> +             ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
>> +             ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
>> +
>> +     st->regs[ADF4350_REG4] =
>> +             ADF4350_REG4_FEEDBACK_FUND |
>> +             ADF4350_REG4_RF_DIV_SEL(st->r4_rf_div_sel) |
>> +             ADF4350_REG4_8BIT_BAND_SEL_CLKDIV(band_sel_div) |
>> +             ADF4350_REG4_RF_OUT_EN |
>> +             (pdata->r4_user_settings&
>> +             (ADF4350_REG4_OUTPUT_PWR(0x3) |
>> +             ADF4350_REG4_AUX_OUTPUT_PWR(0x3) |
>> +             ADF4350_REG4_AUX_OUTPUT_EN |
>> +             ADF4350_REG4_AUX_OUTPUT_FUND |
>> +             ADF4350_REG4_MUTE_TILL_LOCK_EN));
>> +
>> +     st->regs[ADF4350_REG5] = ADF4350_REG5_LD_PIN_MODE_DIGITAL;
>> +
>> +     return adf4350_sync_config(st);
>> +}
>> +
>> +static ssize_t adf4350_store(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             const char *buf, size_t len)
>> +{
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +     unsigned long long readin;
>> +     int ret;
>> +
>> +     ret = kstrtoull(buf, 10,&readin);
>> +     if (ret)
>> +             return ret;
>> +
>> +     mutex_lock(&indio_dev->mlock);
>> +     switch ((u32)this_attr->address) {
>> +     case ADF4350_SET_FREQ:
>> +             ret = adf4350_set_freq(st, readin);
>> +             break;
>> +     case ADF4350_SET_FREQ_REFIN:
>> +             if (readin>  ADF4350_MAX_FREQ_REFIN)
>> +                     ret = -EINVAL;
>> +             else
>> +                     st->clkin = readin;
>> +             break;
>> +     case ADF4350_SET_FREQ_RESOLUTION:
>> +             if (readin == 0)
>> +                     ret = -EINVAL;
>> +             else
>> +                     st->chspc = readin;
>> +             break;
>> +     case ADF4350_PLL_PWRDOWN:
>> +             if (readin)
>> +                     st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
>> +             else
>> +                     st->regs[ADF4350_REG2]&= ~ADF4350_REG2_POWER_DOWN_EN;
>> +
>> +             adf4350_sync_config(st);
>> +             break;
>> +     default:
>> +             ret = -ENODEV;
>> +     }
>> +     mutex_unlock(&indio_dev->mlock);
>> +
>> +     return ret ? ret : len;
>> +}
>> +
> One too many white lines here... (I'm in a fussy mood ;)
>> +
>> +static ssize_t adf4350_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +     unsigned long long val;
>> +
>> +     mutex_lock(&indio_dev->mlock);
>> +     switch ((u32)this_attr->address) {
>> +     case ADF4350_SET_FREQ:
>> +             val = (u64)((st->r0_int * st->r1_mod) + st->r0_fract) *
>> +                     (u64)st->fpfd;
>> +             do_div(val, st->r1_mod * (1<<  st->r4_rf_div_sel));
>> +             break;
>> +     case ADF4350_SET_FREQ_REFIN:
>> +             val = st->clkin;
>> +             break;
>> +     case ADF4350_SET_FREQ_RESOLUTION:
>> +             val = st->chspc;
>> +             break;
>> +     case ADF4350_PLL_LOCKED:
>> +             val = gpio_get_value(st->pdata->gpio_lock_detect);
>> +             break;
>> +     case ADF4350_PLL_PWRDOWN:
>> +             val = !!(st->regs[ADF4350_REG2]&  ADF4350_REG2_POWER_DOWN_EN);
>> +             break;
>> +     }
>> +     mutex_unlock(&indio_dev->mlock);
>> +
>> +     return sprintf(buf, "%llu\n", val);
>> +}
>> +
>> +static IIO_DEVICE_ATTR(out_pll0_freq, S_IRUGO | S_IWUSR,
>> +                     adf4350_show,
>> +                     adf4350_store,
>> +                     ADF4350_SET_FREQ);
>> +
>> +static IIO_DEVICE_ATTR(out_pll0_refin_freq, S_IRUGO | S_IWUSR,
>> +                     adf4350_show,
>> +                     adf4350_store,
>> +                     ADF4350_SET_FREQ_REFIN);
>> +
>> +static IIO_DEVICE_ATTR(out_pll0_freq_resolution, S_IRUGO | S_IWUSR,
>> +                     adf4350_show,
>> +                     adf4350_store,
>> +                     ADF4350_SET_FREQ_RESOLUTION);
>> +
>> +static IIO_DEVICE_ATTR(out_pll0_locked, S_IRUGO,
>> +                     adf4350_show,
>> +                     NULL,
>> +                     ADF4350_PLL_LOCKED);
>> +
>> +static IIO_DEVICE_ATTR(out_pll0_powerdown, S_IRUGO | S_IWUSR,
>> +                     adf4350_show,
>> +                     adf4350_store,
>> +                     ADF4350_PLL_PWRDOWN);
>> +
>> +static struct attribute *adf4350_attributes[] = {
>> +&iio_dev_attr_out_pll0_freq.dev_attr.attr,
>> +&iio_dev_attr_out_pll0_refin_freq.dev_attr.attr,
>> +&iio_dev_attr_out_pll0_freq_resolution.dev_attr.attr,
>> +&iio_dev_attr_out_pll0_locked.dev_attr.attr,
>> +&iio_dev_attr_out_pll0_powerdown.dev_attr.attr,
>> +     NULL,
>> +};
>> +
> I'd be tempted for simplicity to have this visible and return -ENODEV
> or similar to indicate it isn't wired up...  That will go much cleaner
> into the chan_spec stuff if we put these in there..
ok.

BTW - the is_visible stuff is currently not working in IIO at all.

Since iio_device_register_sysfs() doesn't copy this attribute_group member
into the new group. Lars will send a patch shortly.

>> +static mode_t adf4350_attr_is_visible(struct kobject *kobj,
>> +                                  struct attribute *attr, int n)
>> +{
>> +     struct device *dev = container_of(kobj, struct device, kobj);
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +
>> +     mode_t mode = attr->mode;
>> +
>> +     if ((attr ==&iio_dev_attr_out_pll0_locked.dev_attr.attr)&&
>> +             !gpio_is_valid(st->pdata->gpio_lock_detect))
>> +             mode = 0;
>> +
>> +     return mode;
>> +}
>> +
>> +static const struct attribute_group adf4350_attribute_group = {
>> +     .attrs = adf4350_attributes,
>> +     .is_visible = adf4350_attr_is_visible,
>> +};
>> +
>> +static const struct iio_info adf4350_info = {
>> +     .attrs =&adf4350_attribute_group,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +static int __devinit adf4350_probe(struct spi_device *spi)
>> +{
>> +     struct adf4350_platform_data *pdata = spi->dev.platform_data;
>> +     struct iio_dev *indio_dev;
>> +     struct adf4350_state *st;
>> +     struct regulator *reg;
>> +     int ret;
>> +
>> +     if (!pdata) {
>> +             dev_dbg(&spi->dev, "no platform data? using default\n");
>> +             pdata =&default_pdata;
>> +     }
>> +
>> +     reg = regulator_get(&spi->dev, "vcc");
>> +     if (!IS_ERR(reg)) {
>> +             ret = regulator_enable(reg);
>> +             if (ret)
>> +                     goto error_put_reg;
>> +     }
>> +
> Why not reorder slightly then you can do the reg and spi bits directly
> into st->reg and st->spi?  Avoids jumping through hoops on removal too.
ok
>> +     indio_dev = iio_allocate_device(sizeof(*st));
>> +     if (indio_dev == NULL) {
>> +             ret = -ENOMEM;
>> +             goto error_disable_reg;
>> +     }
>> +
>> +     spi_set_drvdata(spi, indio_dev);
>> +     st = iio_priv(indio_dev);
>> +     st->reg = reg;
>> +     st->spi = spi;
>> +     st->pdata = pdata;
>> +
>> +     indio_dev->dev.parent =&spi->dev;
>> +     indio_dev->name = spi_get_device_id(spi)->name;
>> +     indio_dev->info =&adf4350_info;
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +     st->chspc = pdata->channel_spacing;
>> +     st->clkin = pdata->clkin;
>> +
>> +     st->min_out_freq = spi_get_device_id(spi)->driver_data == 4351 ?
>> +             ADF4351_MIN_OUT_FREQ : ADF4350_MIN_OUT_FREQ;
>> +
>> +     memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
>> +
>> +     if (gpio_is_valid(pdata->gpio_lock_detect)) {
> gpio_request_one would be slightly cleaner.
Well - it adds another dependency to GPIOLIB.

>> +             ret = gpio_request(pdata->gpio_lock_detect, indio_dev->name);
>> +             if (ret) {
>> +                     dev_err(&spi->dev, "fail to request lock detect GPIO-%d",
>> +                             pdata->gpio_lock_detect);
>> +                     goto error_free_device;
>> +             }
>> +             gpio_direction_input(pdata->gpio_lock_detect);
>> +     }
>> +
>> +     if (pdata->power_up_frequency) {
>> +             ret = adf4350_set_freq(st, pdata->power_up_frequency);
>> +             if (ret)
>> +                     goto error_free_device;
>> +     }
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret)
>> +             goto error_free_device;
>> +
>> +     return 0;
>> +
>> +error_free_device:
>> +     iio_free_device(indio_dev);
>> +error_disable_reg:
>> +     if (!IS_ERR(reg))
>> +             regulator_disable(reg);
>> +error_put_reg:
>> +     if (!IS_ERR(reg))
>> +             regulator_put(reg);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __devexit adf4350_remove(struct spi_device *spi)
>> +{
>> +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +     struct regulator *reg = st->reg;
>> +
>> +     st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
>> +     adf4350_sync_config(st);
>> +
>> +     iio_device_unregister(indio_dev);
>> +     if (!IS_ERR(reg)) {
>> +             regulator_disable(reg);
>> +             regulator_put(reg);
>> +     }
> iio_free_device is now explicitly required...
Ups. Good catch.


>> +     return 0;
>> +}
>> +
>> +static const struct spi_device_id adf4350_id[] = {
>> +     {"adf4350", 4350},
>> +     {"adf4351", 4351},
>> +     {}
>> +};
>> +
>> +static struct spi_driver adf4350_driver = {
>> +     .driver = {
>> +             .name   = "adf4350",
>> +             .owner  = THIS_MODULE,
>> +     },
>> +     .probe          = adf4350_probe,
>> +     .remove         = __devexit_p(adf4350_remove),
>> +     .id_table       = adf4350_id,
>> +};
>> +
>> +static int __init adf4350_init(void)
>> +{
>> +     return spi_register_driver(&adf4350_driver);
>> +}
>> +module_init(adf4350_init);
>> +
>> +static void __exit adf4350_exit(void)
>> +{
>> +     spi_unregister_driver(&adf4350_driver);
>> +}
>> +module_exit(adf4350_exit);
>> +
>> +MODULE_AUTHOR("Michael Hennerich<hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices ADF4350/ADF4351 PLL");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/pll/adf4350.h b/drivers/staging/iio/pll/adf4350.h
>> new file mode 100644
>> index 0000000..fd2b6f0
>> --- /dev/null
>> +++ b/drivers/staging/iio/pll/adf4350.h
>> @@ -0,0 +1,121 @@
>> +/*
>> + * ADF4350/ADF4351 SPI PLL driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef IIO_PLL_ADF4350_H_
>> +#define IIO_PLL_ADF4350_H_
>> +
>> +/* Registers */
> Umm.. These doe feel a little bit pointless..  Perhaps just use
> the values in place of the defines for this one..
Hmm - I prefer to keep them.
They make sure that the reader understands that we touching device 
registers.
Ideally I would have named them a little bit more descriptive,
however given the fact that so many different bits and fields are 
stuffed into
single registers makes it difficult to find a proper name.

>> +#define ADF4350_REG0 0
>> +#define ADF4350_REG1 1
>> +#define ADF4350_REG2 2
>> +#define ADF4350_REG3 3
>> +#define ADF4350_REG4 4
>> +#define ADF4350_REG5 5
>> +
>> +/* REG0 Bit Definitions */
>> +#define ADF4350_REG0_FRACT(x)                        (((x)&  0xFFF)<<  3)
>> +#define ADF4350_REG0_INT(x)                  (((x)&  0xFFFF)<<  15)
>> +
>> +/* REG1 Bit Definitions */
>> +#define ADF4350_REG1_MOD(x)                  (((x)&  0xFFF)<<  3)
>> +#define ADF4350_REG1_PHASE(x)                        (((x)&  0xFFF)<<  15)
>> +#define ADF4350_REG1_PRESCALER                       (1<<  27)
>> +
>> +/* REG2 Bit Definitions */
>> +#define ADF4350_REG2_COUNTER_RESET_EN                (1<<  3)
>> +#define ADF4350_REG2_CP_THREESTATE_EN                (1<<  4)
>> +#define ADF4350_REG2_POWER_DOWN_EN           (1<<  5)
>> +#define ADF4350_REG2_PD_POLARITY_POS         (1<<  6)
>> +#define ADF4350_REG2_LDP_6ns                 (1<<  7)
>> +#define ADF4350_REG2_LDP_10ns                        (0<<  7)
>> +#define ADF4350_REG2_LDF_FRACT_N             (0<<  8)
>> +#define ADF4350_REG2_LDF_INT_N                       (1<<  8)
>> +#define ADF4350_REG2_CHARGE_PUMP_CURR_uA(x)  (((((x)-312) / 312)&  0xF)<<  9)
>> +#define ADF4350_REG2_DOUBLE_BUFF_EN          (1<<  13)
>> +#define ADF4350_REG2_10BIT_R_CNT(x)          ((x)<<  14)
>> +#define ADF4350_REG2_RDIV2_EN                        (1<<  24)
>> +#define ADF4350_REG2_RMULT2_EN                       (1<<  25)
>> +#define ADF4350_REG2_MUXOUT(x)                       ((x)<<  26)
>> +#define ADF4350_REG2_NOISE_MODE(x)           ((x)<<  29)
>> +
>> +/* REG3 Bit Definitions */
>> +#define ADF4350_REG3_12BIT_CLKDIV(x)         ((x)<<  3)
>> +#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)    ((x)<<  16)
>> +#define ADF4350_REG3_12BIT_CSR_EN            (1<<  18)
>> +#define ADF4351_REG3_CHARGE_CANCELLATION_EN  (1<<  21)
>> +#define ADF4351_REG3_ANTI_BACKLASH_3ns_EN    (1<<  22)
>> +#define ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH        (1<<  23)
>> +
>> +/* REG4 Bit Definitions */
>> +#define ADF4350_REG4_OUTPUT_PWR(x)           ((x)<<  3)
>> +#define ADF4350_REG4_RF_OUT_EN                       (1<<  5)
>> +#define ADF4350_REG4_AUX_OUTPUT_PWR(x)               ((x)<<  6)
>> +#define ADF4350_REG4_AUX_OUTPUT_EN           (1<<  8)
>> +#define ADF4350_REG4_AUX_OUTPUT_FUND         (1<<  9)
>> +#define ADF4350_REG4_AUX_OUTPUT_DIV          (0<<  9)
>> +#define ADF4350_REG4_MUTE_TILL_LOCK_EN               (1<<  10)
>> +#define ADF4350_REG4_VCO_PWRDOWN_EN          (1<<  11)
>> +#define ADF4350_REG4_8BIT_BAND_SEL_CLKDIV(x) ((x)<<  12)
>> +#define ADF4350_REG4_RF_DIV_SEL(x)           ((x)<<  20)
>> +#define ADF4350_REG4_FEEDBACK_DIVIDED                (0<<  23)
>> +#define ADF4350_REG4_FEEDBACK_FUND           (1<<  23)
>> +
>> +/* REG5 Bit Definitions */
>> +#define ADF4350_REG5_LD_PIN_MODE_LOW         (0<<  22)
>> +#define ADF4350_REG5_LD_PIN_MODE_DIGITAL     (1<<  22)
>> +#define ADF4350_REG5_LD_PIN_MODE_HIGH                (3<<  22)
>> +
>> +/* Specifications */
>> +#define ADF4350_MAX_OUT_FREQ         4400000000ULL /* Hz */
>> +#define ADF4350_MIN_OUT_FREQ         137500000 /* Hz */
>> +#define ADF4351_MIN_OUT_FREQ         34375000 /* Hz */
>> +#define ADF4350_MIN_VCO_FREQ         2200000000ULL /* Hz */
>> +#define ADF4350_MAX_FREQ_45_PRESC    3000000000ULL /* Hz */
>> +#define ADF4350_MAX_FREQ_PFD         32000000 /* Hz */
>> +#define ADF4350_MAX_BANDSEL_CLK              125000 /* Hz */
>> +#define ADF4350_MAX_FREQ_REFIN               250000000 /* Hz */
>> +#define ADF4350_MAX_MODULUS          4095
>> +
>> +/*
>> + * TODO: struct adf4350_platform_data needs to go into include/linux/iio
>> + */
>> +
>> +/**
>> + * struct adf4350_platform_data - platform specific information
>> + * @clkin:           REFin frequency in Hz.
>> + * @channel_spacing: Channel spacing in Hz (influences MODULUS).
>> + * @power_up_frequency:      Optional, If set in Hz the PLL tunes to the desired
>> + *                   frequency on probe.
>> + * @ref_div_factor:  Optional, if set the driver skips dynamic calculation
>> + *                   and uses this default value instead.
>> + * @ref_doubler_en:  Enables reference doubler.
>> + * @ref_div2_en:     Enables reference divider.
>> + * @r2_user_settings:        User defined settings for ADF4350/1 REGISTER_2.
>> + * @r3_user_settings:        User defined settings for ADF4350/1 REGISTER_3.
>> + * @r4_user_settings:        User defined settings for ADF4350/1 REGISTER_4.
>> + * @gpio_lock_detect:        Optional, if set with a valid GPIO number,
>> + *                   a PLL_LOCKED device attribute is created.
>> + *                   If not used - set to -1.
>> + */
>> +
>> +struct adf4350_platform_data {
>> +     unsigned long           clkin;
>> +     unsigned long           channel_spacing;
>> +     unsigned long long      power_up_frequency;
>> +
>> +     unsigned short          ref_div_factor; /* 10-bit R counter */
>> +     bool                    ref_doubler_en;
>> +     bool                    ref_div2_en;
>> +
> These next three are in the magic value category. I'd much rather see
> them broken down into their constituent elements.
I can do that but it will blow this struct.

I tried to verbosely name the register bit definitions.
And on the other side I made sure we mask out bits
not intended to be set in here.

>> +     unsigned                r2_user_settings;
>> +     unsigned                r3_user_settings;
>> +     unsigned                r4_user_settings;
>> +     int                     gpio_lock_detect;
>> +};
>> +
>> +#endif /* IIO_PLL_ADF4350_H_ */
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


