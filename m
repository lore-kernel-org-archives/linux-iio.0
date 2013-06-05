Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-235.synserver.de ([212.40.185.235]:1158 "EHLO
	smtp-out-235.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab3FEO0d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 10:26:33 -0400
Message-ID: <51AF4A51.5090609@metafoo.de>
Date: Wed, 05 Jun 2013 16:25:21 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter.Clausen@analog.com, dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 3/4] iio: frequency: adf4350: Add support for
 clock consumer framework
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com> <1370266249-26338-3-git-send-email-michael.hennerich@analog.com> <51AE277B.1070302@kernel.org> <51AEE974.3030000@analog.com>
In-Reply-To: <51AEE974.3030000@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/05/2013 09:32 AM, Michael Hennerich wrote:
> On 06/04/2013 07:44 PM, Jonathan Cameron wrote:
>> On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Preferably get clkin (PLL reference clock) from clock framework
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ERROR: "clk_round_rate" [drivers/iio/frequency/adf4350.ko] undefined!
>> make[1]: *** [__modpost] Error 1
>>
>> on my arm test build. Sorry, I was being lazy before and hadn't done
>> any test builds till I tried merging it.  Backed out the merge of this
>> patch for now.
>>
>> clk.h does say that api is optional for machine classes.  No idea what you
>> want to
>> do about this.
> 
> The CLK API is optional in the driver - so I prefer to keep it like that and
> don't make
> the driver depend on COMMON_CLK.
> 
> The simplest and probably the best workaround is to guard the CLK Round/Set
> code with
> #if defined(CONFIG_COMMON_CLK).
> 
> Thoughts?
> 

This is not a bug in the driver. If the clk API is not implemented it is
stubbed out. It looks as if Jonathan is testing on a platform which
implements the clk API but not clk_round_rate() (None of the other clk_*
symbols are undefined).

Jonathan on which platform are you testing this?

- Lars

> 
>> Incidentally, if you want to play squash the false warnings I also get...
>>
>>    CC [M]  drivers/iio/frequency/adf4350.o
>> drivers/iio/frequency/adf4350.c: In function 'adf4350_read':
>> drivers/iio/frequency/adf4350.c:294:21: warning: 'val' may be used
>> uninitialized in this function
>>
>> which I don't think is addressed in this series.  IIRC it is an obvious
>> false positive
>> so I've never bothered mentioning it before :)
> Yes it is a false positive - and my compilers doesn't warn on it.
> Anyways I can initialize val...
> 
> -Michael
> 
>>
>>> ---
>>>   drivers/iio/frequency/adf4350.c |   58
>>> +++++++++++++++++++++++++++++++++------
>>>   1 file changed, 49 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iio/frequency/adf4350.c
>>> b/drivers/iio/frequency/adf4350.c
>>> index e76d4ac..f6849c8 100644
>>> --- a/drivers/iio/frequency/adf4350.c
>>> +++ b/drivers/iio/frequency/adf4350.c
>>> @@ -1,7 +1,7 @@
>>>   /*
>>>    * ADF4350/ADF4351 SPI Wideband Synthesizer driver
>>>    *
>>> - * Copyright 2012 Analog Devices Inc.
>>> + * Copyright 2012-2013 Analog Devices Inc.
>>>    *
>>>    * Licensed under the GPL-2.
>>>    */
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/gcd.h>
>>>   #include <linux/gpio.h>
>>>   #include <asm/div64.h>
>>> +#include <linux/clk.h>
>>>     #include <linux/iio/iio.h>
>>>   #include <linux/iio/sysfs.h>
>>> @@ -33,6 +34,7 @@ struct adf4350_state {
>>>       struct spi_device        *spi;
>>>       struct regulator        *reg;
>>>       struct adf4350_platform_data    *pdata;
>>> +    struct clk            *clk;
>>>       unsigned long            clkin;
>>>       unsigned long            chspc; /* Channel Spacing */
>>>       unsigned long            fpfd; /* Phase Frequency Detector */
>>> @@ -43,7 +45,7 @@ struct adf4350_state {
>>>       unsigned            r4_rf_div_sel;
>>>       unsigned long            regs[6];
>>>       unsigned long            regs_hw[6];
>>> -
>>> +    unsigned long long        freq_req;
>>>       /*
>>>        * DMA (thus cache coherency maintenance) requires the
>>>        * transfer buffers to live in their own cache lines.
>>> @@ -52,7 +54,6 @@ struct adf4350_state {
>>>   };
>>>     static struct adf4350_platform_data default_pdata = {
>>> -    .clkin = 122880000,
>>>       .channel_spacing = 10000,
>>>       .r2_user_settings = ADF4350_REG2_PD_POLARITY_POS |
>>>                   ADF4350_REG2_CHARGE_PUMP_CURR_uA(2500),
>>> @@ -235,6 +236,7 @@ static int adf4350_set_freq(struct adf4350_state *st,
>>> unsigned long long freq)
>>>           ADF4350_REG4_MUTE_TILL_LOCK_EN));
>>>         st->regs[ADF4350_REG5] = ADF4350_REG5_LD_PIN_MODE_DIGITAL;
>>> +    st->freq_req = freq;
>>>         return adf4350_sync_config(st);
>>>   }
>>> @@ -246,6 +248,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>>>   {
>>>       struct adf4350_state *st = iio_priv(indio_dev);
>>>       unsigned long long readin;
>>> +    unsigned long tmp;
>>>       int ret;
>>>         ret = kstrtoull(buf, 10, &readin);
>>> @@ -258,10 +261,23 @@ static ssize_t adf4350_write(struct iio_dev
>>> *indio_dev,
>>>           ret = adf4350_set_freq(st, readin);
>>>           break;
>>>       case ADF4350_FREQ_REFIN:
>>> -        if (readin > ADF4350_MAX_FREQ_REFIN)
>>> +        if (readin > ADF4350_MAX_FREQ_REFIN) {
>>>               ret = -EINVAL;
>>> -        else
>>> -            st->clkin = readin;
>>> +            break;
>>> +        }
>>> +
>>> +        if (st->clk) {
>>> +            tmp = clk_round_rate(st->clk, readin);
>>> +            if (tmp != readin) {
>>> +                ret = -EINVAL;
>>> +                break;
>>> +            }
>>> +            ret = clk_set_rate(st->clk, tmp);
>>> +            if (ret < 0)
>>> +                break;
>>> +        }
>>> +        st->clkin = readin;
>>> +        ret = adf4350_set_freq(st, st->freq_req);
>>>           break;
>>>       case ADF4350_FREQ_RESOLUTION:
>>>           if (readin == 0)
>>> @@ -308,6 +324,9 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>>>               }
>>>           break;
>>>       case ADF4350_FREQ_REFIN:
>>> +        if (st->clk)
>>> +            st->clkin = clk_get_rate(st->clk);
>>> +
>>>           val = st->clkin;
>>>           break;
>>>       case ADF4350_FREQ_RESOLUTION:
>>> @@ -318,6 +337,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>>>           break;
>>>       default:
>>>           ret = -EINVAL;
>>> +        val = 0;
>>>       }
>>>       mutex_unlock(&indio_dev->mlock);
>>>   @@ -360,14 +380,24 @@ static int adf4350_probe(struct spi_device *spi)
>>>       struct adf4350_platform_data *pdata = spi->dev.platform_data;
>>>       struct iio_dev *indio_dev;
>>>       struct adf4350_state *st;
>>> +    struct clk *clk = NULL;
>>>       int ret;
>>>         if (!pdata) {
>>>           dev_warn(&spi->dev, "no platform data? using default\n");
>>> -
>>>           pdata = &default_pdata;
>>>       }
>>>   +    if (!pdata->clkin) {
>>> +        clk = clk_get(&spi->dev, "clkin");
>>> +        if (IS_ERR(clk))
>>> +            return -EPROBE_DEFER;
>>> +
>>> +        ret = clk_prepare_enable(clk);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +    }
>>> +
>>>       indio_dev = iio_device_alloc(sizeof(*st));
>>>       if (indio_dev == NULL)
>>>           return -ENOMEM;
>>> @@ -395,7 +425,12 @@ static int adf4350_probe(struct spi_device *spi)
>>>       indio_dev->num_channels = 1;
>>>         st->chspc = pdata->channel_spacing;
>>> -    st->clkin = pdata->clkin;
>>> +    if (clk) {
>>> +        st->clk = clk;
>>> +        st->clkin = clk_get_rate(clk);
>>> +    } else {
>>> +        st->clkin = pdata->clkin;
>>> +    }
>>>         st->min_out_freq = spi_get_device_id(spi)->driver_data == 4351 ?
>>>           ADF4351_MIN_OUT_FREQ : ADF4350_MIN_OUT_FREQ;
>>> @@ -435,6 +470,8 @@ error_put_reg:
>>>       if (!IS_ERR(st->reg))
>>>           regulator_put(st->reg);
>>>   +    if (clk)
>>> +        clk_disable_unprepare(clk);
>>>       iio_device_free(indio_dev);
>>>         return ret;
>>> @@ -451,6 +488,9 @@ static int adf4350_remove(struct spi_device *spi)
>>>         iio_device_unregister(indio_dev);
>>>   +    if (st->clk)
>>> +        clk_disable_unprepare(st->clk);
>>> +
>>>       if (!IS_ERR(reg)) {
>>>           regulator_disable(reg);
>>>           regulator_put(reg);
>>> @@ -481,6 +521,6 @@ static struct spi_driver adf4350_driver = {
>>>   };
>>>   module_spi_driver(adf4350_driver);
>>>   -MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>>> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>>>   MODULE_DESCRIPTION("Analog Devices ADF4350/ADF4351 PLL");
>>>   MODULE_LICENSE("GPL v2");
>>>
> 
> 

