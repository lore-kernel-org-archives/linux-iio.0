Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4FA93D00.2070906@analog.com>
Date: Tue, 8 May 2012 17:34:24 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio: frequency: New driver for Analog Devices ADF4350/ADF4351
 Wideband Synthesizers
References: <1336398556-5360-1-git-send-email-michael.hennerich@analog.com> <4FA932D9.5010006@cam.ac.uk>
In-Reply-To: <4FA932D9.5010006@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/08/2012 04:51 PM, Jonathan Cameron wrote:
> On 5/7/2012 2:49 PM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> Changes since V1:
>> Apply Jonathan's review feedback:
>>       Introduce and use IIO_ALTVOLTAGE.
>>       Fix up comments and documentation.
>>       Remove dead code.
>>       Reorder some code fragments.
>>       Add missing iio_device_free.
>>
>> Convert to new API.
>> Fix-up out of staging includes.
>> Removed pll_locked attribute.
>>
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>> ---
>>    .../Documentation/frequency/sysfs-bus-iio-adf4350  |   21 +
>>    drivers/staging/iio/frequency/Kconfig              |   18 +
>>    drivers/staging/iio/frequency/Makefile             |    1 +
>>    drivers/staging/iio/frequency/adf4350.c            |  490 ++++++++++++++++++++
>>    drivers/staging/iio/frequency/adf4350.h            |  130 ++++++
>>    5 files changed, 660 insertions(+), 0 deletions(-)
>>    create mode 100644 drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-adf4350
>>    create mode 100644 drivers/staging/iio/frequency/adf4350.c
>>    create mode 100644 drivers/staging/iio/frequency/adf4350.h
>>
>> diff --git a/drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-adf4350 b/drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-adf4350
>> new file mode 100644
>> index 0000000..d89aded
>> --- /dev/null
>> +++ b/drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-adf4350
>> @@ -0,0 +1,21 @@
>> +What:                /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
>> +KernelVersion:       3.4.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Stores channel Y frequency resolution/channel spacing in Hz.
>> +             The value given directly influences the MODULUS used by
>> +             the fractional-N PLL. It is assumed that the algorithm
>> +             that is used to compute the various dividers, is able to
>> +             generate proper values for multiples of channel spacing.
> This one brings up an interesting question. I've been wondering whether,
> rather than
> having the valid values for a given parameter only specified for some
> parameters, we
> should just make it obligatory for everything.  That way we can come up
> with a spec
> that includes min, max and interval or a specific set of values as
> appropriate.  What
> we have at the moment feels a bit adhoc...
>
> I was thinking of something like a callback along the lines of
>
> (would need an additional core mutex to protect against underlying changes)
>
> int read_range(const int **val[2], int *num)
>
> For simple set of values such as 1.000003, 1.000004,  1.000010 return is
> IIO_INT_PLUS_MICRO etc and
> val is [(1,3), (1,4), (1,10) ..] etc and num is the number of vals.  The
> core then
> formats the list as a space separated list.
>
> For values like you have here, with end points and an interval we have
> say, 1.3 to 1.7 interval 0.0001
> val is[(1,3), (0, 1000), (1,10)]   num could then be negative to
> indicate a set of ranges (typically 1)
>
> We'd pretty print it as something like.
>
> 1.3:0.0001:1.7 1.7:0.0002:1.9 etc
>
> That would give us a fairly flexible interface and also provide a way
> for in kernel users to query
> the possible values...

Don't know why you bring this up when commenting on
out_altvoltageY_frequency_resolution. This file is more meant
to be written, and influences the accuracy when setting
frequencies using out_altvoltageY_frequency.
In the various communication systems such as GSM, UMTS or even FM Radio
channels are spaced in some raster. Without proper setting of
out_altvoltageY_frequency_resolution, it may be the case that you hit
channel X without offset, while X+1 has some offset.

Anyways having a generic way to tell the internal or application space users
  min, max and the interval, is great thing to have!


>
>
>
> Not that there is any issue with what you have here, just that we should
> be able to
> do something more general!
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
>> +KernelVersion:       3.4.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Sets channel Y REFin frequency in Hz. In some clock chained
>> +             applications, the reference frequency used by the PLL may
>> +             change during runtime. This attribute allows the user to
>> +             adjust the reference frequency accordingly.
>> +             The value written has no effect until out_altvoltageY_frequency
>> +             is updated. Consider to use out_altvoltageY_powerdown to power
>> +             down the PLL and it's RFOut buffers during REFin changes.
>> diff --git a/drivers/staging/iio/frequency/Kconfig b/drivers/staging/iio/frequency/Kconfig
>> index 7b2c0c3..b142dd2 100644
>> --- a/drivers/staging/iio/frequency/Kconfig
>> +++ b/drivers/staging/iio/frequency/Kconfig
>> @@ -78,4 +78,22 @@ config AD9951
>>          ad9951, provides direct access via sysfs.
>>
>>    endmenu
>> +
>> +#
>> +# Phase-Locked Loop (PLL) frequency synthesizers
>> +#
>> +
>> +menu "Phase-Locked Loop (PLL) frequency synthesizers"
> Whenever you introduce a new menu, I have a frightenning feeling
> that lots more drivers will shortly follow :)
;-)
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
>>    endmenu
>> diff --git a/drivers/staging/iio/frequency/Makefile b/drivers/staging/iio/frequency/Makefile
>> index e0157b6..48e9d8c 100644
>> --- a/drivers/staging/iio/frequency/Makefile
>> +++ b/drivers/staging/iio/frequency/Makefile
>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AD9852) += ad9852.o
>>    obj-$(CONFIG_AD9910) += ad9910.o
>>    obj-$(CONFIG_AD9951) += ad9951.o
>>    obj-$(CONFIG_AD9523) += ad9523.o
>> +obj-$(CONFIG_ADF4350) += adf4350.o
>> diff --git a/drivers/staging/iio/frequency/adf4350.c b/drivers/staging/iio/frequency/adf4350.c
>> new file mode 100644
>> index 0000000..c063a02
>> --- /dev/null
>> +++ b/drivers/staging/iio/frequency/adf4350.c
>> @@ -0,0 +1,490 @@
>> +/*
>> + * ADF4350/ADF4351 SPI Wideband Synthesizer driver
>> + *
>> + * Copyright 2012 Analog Devices Inc.
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
>> +#include<linux/iio/iio.h>
>> +#include<linux/iio/sysfs.h>
>> +
>> +#include "adf4350.h"
>> +
>> +enum {
>> +     ADF4350_FREQ,
>> +     ADF4350_FREQ_REFIN,
>> +     ADF4350_FREQ_RESOLUTION,
>> +     ADF4350_PWRDOWN,
>> +};
>> +
>> +struct adf4350_state {
>> +     struct spi_device               *spi;
>> +     struct regulator                *reg;
>> +     struct adf4350_platform_data    *pdata;
>> +     unsigned long                   clkin;
>> +     unsigned long                   chspc; /* Channel Spacing */
>> +     unsigned long                   fpfd; /* Phase Frequency Detector */
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
>> +     .clkin = 122880000,
>> +     .channel_spacing = 10000,
>> +     .r2_user_settings = ADF4350_REG2_PD_POLARITY_POS,
>> +                         ADF4350_REG2_CHARGE_PUMP_CURR_uA(2500),
>> +     .r3_user_settings = ADF4350_REG3_12BIT_CLKDIV_MODE(0),
>> +     .r4_user_settings = ADF4350_REG4_OUTPUT_PWR(3) |
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
>> +                     ((i == ADF4350_REG0)&&   doublebuf)) {
>> +
>> +                     switch (i) {
>> +                     case ADF4350_REG1:
>> +                     case ADF4350_REG4:
>> +                             doublebuf = 1;
>> +                             break;
>> +                     }
>> +
>> +                     st->val  = cpu_to_be32(st->regs[i] | i);
>> +                     ret = spi_write(st->spi,&st->val, 4);
>> +                     if (ret<   0)
>> +                             return ret;
>> +                     st->regs_hw[i] = st->regs[i];
>> +                     dev_dbg(&st->spi->dev, "[%d] 0x%X\n",
>> +                             i, (u32)st->regs[i] | i);
>> +             }
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int adf4350_reg_access(struct iio_dev *indio_dev,
>> +                           unsigned reg, unsigned writeval,
>> +                           unsigned *readval)
>> +{
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +     int ret;
>> +
>> +     if (reg>   ADF4350_REG5)
>> +             return -EINVAL;
>> +
>> +     mutex_lock(&indio_dev->mlock);
>> +     if (readval == NULL) {
> Unusal bit of logic.  Why would writeval ever contain anything in those
> first 3 bits if it is invalid to do so?
The part uses these three bits as address offset. Debugfs users,
may think it's required to set when looking at the datasheet.
If not cleared it will confuse the register sync logic.

>> +             st->regs[reg] = writeval&   ~(BIT(0) | BIT(1) | BIT(2));
>> +             ret = adf4350_sync_config(st);
>> +     } else {
>> +             *readval =  st->regs_hw[reg];
>> +             ret = 0;
>> +     }
>> +     mutex_unlock(&indio_dev->mlock);
>> +
>> +     return ret;
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
>> +     } while (st->fpfd>   ADF4350_MAX_FREQ_PFD);
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
>> +     if (freq>   ADF4350_MAX_OUT_FREQ || freq<   st->min_out_freq)
>> +             return -EINVAL;
>> +
>> +     if (freq>   ADF4350_MAX_FREQ_45_PRESC) {
>> +             prescaler = ADF4350_REG1_PRESCALER;
>> +             mdiv = 75;
>> +     } else {
>> +             prescaler = 0;
>> +             mdiv = 23;
>> +     }
>> +
>> +     st->r4_rf_div_sel = 0;
>> +
>> +     while (freq<   ADF4350_MIN_VCO_FREQ) {
>> +             freq<<= 1;
>> +             st->r4_rf_div_sel++;
>> +     }
>> +
>> +     /*
>> +      * Allow a predefined reference division factor
>> +      * if not set, compute our own
>> +      */
>> +     if (pdata->ref_div_factor)
>> +             r_cnt = pdata->ref_div_factor - 1;
>> +
>> +     do  {
>> +             r_cnt = adf4350_tune_r_cnt(st, r_cnt);
>> +
>> +             st->r1_mod = st->fpfd / st->chspc;
>> +             while (st->r1_mod>   ADF4350_MAX_MODULUS) {
>> +                     r_cnt = adf4350_tune_r_cnt(st, r_cnt);
>> +                     st->r1_mod = st->fpfd / st->chspc;
>> +             }
>> +
>> +             tmp = freq * (u64)st->r1_mod + (st->fpfd>   1);
>> +             do_div(tmp, st->fpfd); /* Div round closest (n + d/2)/d */
>> +             st->r0_fract = do_div(tmp, st->r1_mod);
>> +             st->r0_int = tmp;
>> +     } while (mdiv>   st->r0_int);
>> +
>> +     band_sel_div = DIV_ROUND_UP(st->fpfd, ADF4350_MAX_BANDSEL_CLK);
>> +
>> +     if (st->r0_fract&&   st->r1_mod) {
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
>> +             1<<   st->r4_rf_div_sel, prescaler ? "8/9" : "4/5",
>> +             band_sel_div);
>> +
>> +     st->regs[ADF4350_REG0] = ADF4350_REG0_INT(st->r0_int) |
>> +                              ADF4350_REG0_FRACT(st->r0_fract);
>> +
>> +     st->regs[ADF4350_REG1] = ADF4350_REG1_PHASE(0) |
>> +                              ADF4350_REG1_MOD(st->r1_mod) |
>> +                              prescaler;
>> +
>> +     st->regs[ADF4350_REG2] =
>> +             ADF4350_REG2_10BIT_R_CNT(r_cnt) |
>> +             ADF4350_REG2_DOUBLE_BUFF_EN |
>> +             (pdata->ref_doubler_en ? ADF4350_REG2_RMULT2_EN : 0) |
>> +             (pdata->ref_div2_en ? ADF4350_REG2_RDIV2_EN : 0) |
>> +             (pdata->r2_user_settings&   (ADF4350_REG2_PD_POLARITY_POS |
>> +             ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
>> +             ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
>> +             ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
>> +
>> +     st->regs[ADF4350_REG3] = pdata->r3_user_settings&
>> +                              (ADF4350_REG3_12BIT_CLKDIV(0xFFF) |
>> +                              ADF4350_REG3_12BIT_CLKDIV_MODE(0x3) |
>> +                              ADF4350_REG3_12BIT_CSR_EN |
>> +                              ADF4351_REG3_CHARGE_CANCELLATION_EN |
>> +                              ADF4351_REG3_ANTI_BACKLASH_3ns_EN |
>> +                              ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH);
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
>> +static ssize_t adf4350_write(struct iio_dev *indio_dev,
>> +                                 uintptr_t private,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 const char *buf, size_t len)
>> +{
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +     unsigned long long readin;
>> +     int ret;
>> +
>> +     ret = kstrtoull(buf, 10,&readin);
>> +     if (ret)
>> +             return ret;
>> +
>> +     mutex_lock(&indio_dev->mlock);
>> +     switch ((u32)private) {
>> +     case ADF4350_FREQ:
>> +             ret = adf4350_set_freq(st, readin);
>> +             break;
>> +     case ADF4350_FREQ_REFIN:
>> +             if (readin>   ADF4350_MAX_FREQ_REFIN)
>> +                     ret = -EINVAL;
>> +             else
>> +                     st->clkin = readin;
>> +             break;
>> +     case ADF4350_FREQ_RESOLUTION:
>> +             if (readin == 0)
>> +                     ret = -EINVAL;
>> +             else
>> +                     st->chspc = readin;
>> +             break;
>> +     case ADF4350_PWRDOWN:
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
>> +static ssize_t adf4350_read(struct iio_dev *indio_dev,
>> +                                uintptr_t private,
>> +                                const struct iio_chan_spec *chan,
>> +                                char *buf)
>> +{
>> +     struct adf4350_state *st = iio_priv(indio_dev);
>> +     unsigned long long val;
>> +     int ret = 0;
>> +
>> +     mutex_lock(&indio_dev->mlock);
>> +     switch ((u32)private) {
>> +     case ADF4350_FREQ:
>> +             val = (u64)((st->r0_int * st->r1_mod) + st->r0_fract) *
>> +                     (u64)st->fpfd;
>> +             do_div(val, st->r1_mod * (1<<   st->r4_rf_div_sel));
>> +             /* PLL unlocked? return error */
>> +             if (gpio_is_valid(st->pdata->gpio_lock_detect))
>> +                     if (!gpio_get_value(st->pdata->gpio_lock_detect)) {
>> +                             dev_dbg(&st->spi->dev, "PLL un-locked\n");
>> +                             ret = -EBUSY;
>> +                     }
>> +             break;
>> +     case ADF4350_FREQ_REFIN:
>> +             val = st->clkin;
>> +             break;
>> +     case ADF4350_FREQ_RESOLUTION:
>> +             val = st->chspc;
>> +             break;
>> +     case ADF4350_PWRDOWN:
>> +             val = !!(st->regs[ADF4350_REG2]&   ADF4350_REG2_POWER_DOWN_EN);
>> +             break;
>> +     }
>> +     mutex_unlock(&indio_dev->mlock);
>> +
>> +     return ret<   0 ? ret : sprintf(buf, "%llu\n", val);
>> +}
>> +
>> +#define _ADF4350_EXT_INFO(_name, _ident) { \
>> +     .name = _name, \
>> +     .read = adf4350_read, \
>> +     .write = adf4350_write, \
>> +     .private = _ident, \
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info adf4350_ext_info[] = {
>> +     /* Ideally we use IIO_CHAN_INFO_FREQUENCY, but there are
>> +      * values>   2^32 in order to support the entire frequency range
>> +      * in Hz. Using scale is a bit ugly.
>> +      */
> hmm.. Add IIO_VAL_MEGA_PLUS_INT.. We were always going to need a bigger
> version at somepoint...
Well - we then need an s64, however read|write_raw feature s32 for
val and val2. So shall we pass low word in val and high word in val2?

>> +     _ADF4350_EXT_INFO("frequency", ADF4350_FREQ),
>> +     _ADF4350_EXT_INFO("frequency_resolution", ADF4350_FREQ_RESOLUTION),
>> +     _ADF4350_EXT_INFO("refin_frequency", ADF4350_FREQ_REFIN),
>> +     _ADF4350_EXT_INFO("powerdown", ADF4350_PWRDOWN),
>> +     { },
>> +};
>> +
>> +static const struct iio_chan_spec adf4350_chan = {
>> +     .type = IIO_ALTVOLTAGE,
>> +     .indexed = 1,
>> +     .output = 1,
>> +     .ext_info = adf4350_ext_info,
>> +};
>> +
>> +static const struct iio_info adf4350_info = {
>> +     .debugfs_reg_access =&adf4350_reg_access,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +static int __devinit adf4350_probe(struct spi_device *spi)
>> +{
>> +     struct adf4350_platform_data *pdata = spi->dev.platform_data;
>> +     struct iio_dev *indio_dev;
>> +     struct adf4350_state *st;
>> +     int ret;
>> +
>> +     if (!pdata) {
>> +             dev_warn(&spi->dev, "no platform data? using default\n");
>> +
>> +             pdata =&default_pdata;
>> +     }
>> +
>> +     indio_dev = iio_device_alloc(sizeof(*st));
>> +     if (indio_dev == NULL)
>> +             return -ENOMEM;
>> +
>> +     st = iio_priv(indio_dev);
>> +
>> +     st->reg = regulator_get(&spi->dev, "vcc");
>> +     if (!IS_ERR(st->reg)) {
>> +             ret = regulator_enable(st->reg);
>> +             if (ret)
>> +                     goto error_put_reg;
>> +     }
>> +
>> +     spi_set_drvdata(spi, indio_dev);
>> +     st->spi = spi;
>> +     st->pdata = pdata;
>> +
>> +     indio_dev->dev.parent =&spi->dev;
>> +     indio_dev->name = (pdata->name[0] != 0) ? pdata->name :
>> +             spi_get_device_id(spi)->name;
> That's ugly. Why have the pdata->name option?  Guessing this is
> a legacy hack, but please comment...
Actually it's required when having multiple instances in your system.
iio_utils use find_device_by_name. If you have two adf4351 it will fail
badly.
Appending bus and number might work as well, but I prefer to name
them by function. Such as adf4351-tx, adf4351-rx.


>> +
>> +     indio_dev->info =&adf4350_info;
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->channels =&adf4350_chan;
>> +     indio_dev->num_channels = 1;
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
> gpio_request_one?
Depends on GPIOLIB
>> +             ret = gpio_request(pdata->gpio_lock_detect, indio_dev->name);
>> +             if (ret) {
>> +                     dev_err(&spi->dev, "fail to request lock detect GPIO-%d",
>> +                             pdata->gpio_lock_detect);
>> +                     goto error_disable_reg;
>> +             }
>> +             gpio_direction_input(pdata->gpio_lock_detect);
>> +     }
>> +
>> +     if (pdata->power_up_frequency) {
>> +             ret = adf4350_set_freq(st, pdata->power_up_frequency);
>> +             if (ret)
>> +                     goto error_free_gpio;
>> +     }
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret)
>> +             goto error_free_gpio;
>> +
>> +     return 0;
>> +
>> +error_free_gpio:
>> +     if (gpio_is_valid(pdata->gpio_lock_detect))
>> +             gpio_free(pdata->gpio_lock_detect);
>> +
>> +error_disable_reg:
>> +     if (!IS_ERR(st->reg))
>> +             regulator_disable(st->reg);
>> +error_put_reg:
>> +     if (!IS_ERR(st->reg))
>> +             regulator_put(st->reg);
>> +
>> +     iio_device_free(indio_dev);
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
>> +     if (gpio_is_valid(st->pdata->gpio_lock_detect))
>> +             gpio_free(st->pdata->gpio_lock_detect);
>> +
> I'd normally expect remove to undwind in the opposite order to probe
> sets things up.  Hence this gpio stuff would be later...
ok
>> +     iio_device_unregister(indio_dev);
>> +
>> +     if (!IS_ERR(reg)) {
>> +             regulator_disable(reg);
>> +             regulator_put(reg);
>> +     }
>> +
>> +     iio_device_free(indio_dev);
>> +
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
> module_spi_driver?
Yes - thought we converted all drivers before.
Guess this driver slept too long in my dev branch.

>> +
>> +MODULE_AUTHOR("Michael Hennerich<hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices ADF4350/ADF4351 PLL");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/frequency/adf4350.h b/drivers/staging/iio/frequency/adf4350.h
>> new file mode 100644
>> index 0000000..1420015
>> --- /dev/null
>> +++ b/drivers/staging/iio/frequency/adf4350.h
>> @@ -0,0 +1,130 @@
>> +/*
>> + * ADF4350/ADF4351 SPI PLL driver
>> + *
>> + * Copyright 2012 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef IIO_PLL_ADF4350_H_
>> +#define IIO_PLL_ADF4350_H_
>> +
>> +/* Registers */
>> +#define ADF4350_REG0 0
>> +#define ADF4350_REG1 1
>> +#define ADF4350_REG2 2
>> +#define ADF4350_REG3 3
>> +#define ADF4350_REG4 4
>> +#define ADF4350_REG5 5
>> +
>> +/* REG0 Bit Definitions */
>> +#define ADF4350_REG0_FRACT(x)                        (((x)&   0xFFF)<<   3)
>> +#define ADF4350_REG0_INT(x)                  (((x)&   0xFFFF)<<   15)
>> +
>> +/* REG1 Bit Definitions */
>> +#define ADF4350_REG1_MOD(x)                  (((x)&   0xFFF)<<   3)
>> +#define ADF4350_REG1_PHASE(x)                        (((x)&   0xFFF)<<   15)
>> +#define ADF4350_REG1_PRESCALER                       (1<<   27)
>> +
>> +/* REG2 Bit Definitions */
>> +#define ADF4350_REG2_COUNTER_RESET_EN                (1<<   3)
>> +#define ADF4350_REG2_CP_THREESTATE_EN                (1<<   4)
>> +#define ADF4350_REG2_POWER_DOWN_EN           (1<<   5)
>> +#define ADF4350_REG2_PD_POLARITY_POS         (1<<   6)
>> +#define ADF4350_REG2_LDP_6ns                 (1<<   7)
>> +#define ADF4350_REG2_LDP_10ns                        (0<<   7)
>> +#define ADF4350_REG2_LDF_FRACT_N             (0<<   8)
>> +#define ADF4350_REG2_LDF_INT_N                       (1<<   8)
>> +#define ADF4350_REG2_CHARGE_PUMP_CURR_uA(x)  (((((x)-312) / 312)&   0xF)<<   9)
>> +#define ADF4350_REG2_DOUBLE_BUFF_EN          (1<<   13)
>> +#define ADF4350_REG2_10BIT_R_CNT(x)          ((x)<<   14)
>> +#define ADF4350_REG2_RDIV2_EN                        (1<<   24)
>> +#define ADF4350_REG2_RMULT2_EN                       (1<<   25)
>> +#define ADF4350_REG2_MUXOUT(x)                       ((x)<<   26)
>> +#define ADF4350_REG2_NOISE_MODE(x)           ((x)<<   29)
>> +#define ADF4350_MUXOUT_THREESTATE            0
>> +#define ADF4350_MUXOUT_DVDD                  1
>> +#define ADF4350_MUXOUT_GND                   2
>> +#define ADF4350_MUXOUT_R_DIV_OUT             3
>> +#define ADF4350_MUXOUT_N_DIV_OUT             4
>> +#define ADF4350_MUXOUT_ANALOG_LOCK_DETECT    5
>> +#define ADF4350_MUXOUT_DIGITAL_LOCK_DETECT   6
>> +
>> +/* REG3 Bit Definitions */
>> +#define ADF4350_REG3_12BIT_CLKDIV(x)         ((x)<<   3)
>> +#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)    ((x)<<   16)
>> +#define ADF4350_REG3_12BIT_CSR_EN            (1<<   18)
>> +#define ADF4351_REG3_CHARGE_CANCELLATION_EN  (1<<   21)
>> +#define ADF4351_REG3_ANTI_BACKLASH_3ns_EN    (1<<   22)
>> +#define ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH        (1<<   23)
>> +
>> +/* REG4 Bit Definitions */
>> +#define ADF4350_REG4_OUTPUT_PWR(x)           ((x)<<   3)
>> +#define ADF4350_REG4_RF_OUT_EN                       (1<<   5)
>> +#define ADF4350_REG4_AUX_OUTPUT_PWR(x)               ((x)<<   6)
>> +#define ADF4350_REG4_AUX_OUTPUT_EN           (1<<   8)
>> +#define ADF4350_REG4_AUX_OUTPUT_FUND         (1<<   9)
>> +#define ADF4350_REG4_AUX_OUTPUT_DIV          (0<<   9)
>> +#define ADF4350_REG4_MUTE_TILL_LOCK_EN               (1<<   10)
>> +#define ADF4350_REG4_VCO_PWRDOWN_EN          (1<<   11)
>> +#define ADF4350_REG4_8BIT_BAND_SEL_CLKDIV(x) ((x)<<   12)
>> +#define ADF4350_REG4_RF_DIV_SEL(x)           ((x)<<   20)
>> +#define ADF4350_REG4_FEEDBACK_DIVIDED                (0<<   23)
>> +#define ADF4350_REG4_FEEDBACK_FUND           (1<<   23)
>> +
>> +/* REG5 Bit Definitions */
>> +#define ADF4350_REG5_LD_PIN_MODE_LOW         (0<<   22)
>> +#define ADF4350_REG5_LD_PIN_MODE_DIGITAL     (1<<   22)
>> +#define ADF4350_REG5_LD_PIN_MODE_HIGH                (3<<   22)
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
>> + * @name:            Optional device name.
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
>> + *                   pll lock state is tested upon read.
>> + *                   If not used - set to -1.
>> + */
>> +
>> +struct adf4350_platform_data {
>> +     char                    name[32];
>> +     unsigned long           clkin;
>> +     unsigned long           channel_spacing;
>> +     unsigned long long      power_up_frequency;
>> +
>> +     unsigned short          ref_div_factor; /* 10-bit R counter */
>> +     bool                    ref_doubler_en;
>> +     bool                    ref_div2_en;
>> +
>> +     unsigned                r2_user_settings;
> You know I'd love to see these broken up into their constituent parts.
> Its not as
> crucial to see a lack of magic numbers in platform data as in userspace
> interfaces
> but it is nice...
It'll blow this struct...
You just need to OR the features you like.
They are all verbosely named and there is some safeguard
to prevent bits from being set, that are handled by the driver.

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
