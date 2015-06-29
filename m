Return-Path: <knaack.h@gmx.de>
Message-ID: <559199E7.10607@gmx.de>
Date: Mon, 29 Jun 2015 21:17:59 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: magnetometer: Add support for MEMSIC
 MMC35240 sensor
References: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>	<1429891112-11888-2-git-send-email-daniel.baluta@intel.com>	<55907E2F.3030308@gmx.de> <CAEnQRZBpzEo1xcQJh7-Uo+WL_TOkUKhUR3QtTfXor=yKtwXh4g@mail.gmail.com>
In-Reply-To: <CAEnQRZBpzEo1xcQJh7-Uo+WL_TOkUKhUR3QtTfXor=yKtwXh4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Daniel Baluta schrieb am 29.06.2015 um 09:52:
> On Mon, Jun 29, 2015 at 2:07 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> Daniel Baluta schrieb am 24.04.2015 um 17:58:
>>> Minimal implementation for MMC35240 3-axis magnetometer
>>> sensor. It provides processed readings and possiblity to change
>>> the sampling frequency.
>>>
>>
>> Hi Daniel,
>> please find a few issues inline, which you could address in a next
>> rework patch set. I would have sent a patch for the critical stuff,
>> but was obviously too stupid to find a data sheet :-(
> 
> Well, there is no public datasheet. We are discussing with the vendor
> to make it public.
> 
<...>
>>> +static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
>>> +{
>>> +     int ret;
>>> +     u8 coil_bit;
>>> +
>>> +     /*
>>> +      * Recharge the capacitor at VCAP pin, requested to be issued
>>> +      * before a SET/RESET command.
>>> +      */
>>> +     ret = regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
>>> +                              MMC35240_CTRL0_REFILL_BIT,
>>> +                              MMC35240_CTRL0_REFILL_BIT);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     usleep_range(MMC35240_WAIT_CHARGE_PUMP, MMC35240_WAIT_CHARGE_PUMP + 1);
>>> +
>>> +     if (set)
>>> +             coil_bit = MMC35240_CTRL0_SET_BIT;
>>> +     else
>>> +             coil_bit = MMC35240_CTRL0_RESET_BIT;
>>> +
>>> +     return regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
>>> +                               MMC35240_CTRL0_REFILL_BIT,
>>> +                               coil_bit);
>>
>> coil_bit is in any case outside the mask of MMC35240_CTRL0_REFILL_BIT.
>> Not sure about the whole intention, meaning in which state
>> MMC35240_CTRL0_REFILL_BIT is supposed to be (set) when either
>> MMC35240_CTRL0_SET_BIT or MMC35240_CTRL0_RESET_BIT is written.
> 
> Yes, this is a bug. We have a patch prepared for it. Will send once Jonathan is
> ready to accept bugfixes. Together with this:
> 
> http://marc.info/?l=linux-iio&m=143489464403101&w=2
> 

Sending it out earlier gives people more time to review (or may allow more people
to review).

> 
>>
>>> +}

<...>
>>> +
>>> +static int mmc35240_take_measurement(struct mmc35240_data *data)
>>> +{
>>> +     int ret, tries = 100;
>>> +     unsigned int reg_status;
>>> +
>>> +     ret = regmap_write(data->regmap, MMC35240_REG_CTRL0,
>>> +                        MMC35240_CTRL0_TM_BIT);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     while (tries-- > 0) {
>>> +             ret = regmap_read(data->regmap, MMC35240_REG_STATUS,
>>> +                               &reg_status);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +             if (reg_status & MMC35240_STATUS_MEAS_DONE_BIT)
>>> +                     break;
>>
>> I would actually return 0 here, as measurement was successful. That
>> would mean that getting outside the loop is the error case and would
>> make the check obsolete.
> 
> You are right, this could also work. Anyhow, I think code is easier to
> understand as it is. The check for (tries < 0) makes it very clear, that the
> data was not ready.
> 
> Getting outside the loop in the error case is harder to understand at a first
> glance.
> 

I can not really agree. The mission is accomplished at the break, so better
take the shortest way out (return 0 usually reflects that). Still going through
a check that won't trigger in this case just adds bloat without any benefit.
It's not a bug, so I don't feel too strong to fix it myself (still too much
reviews to be done). Sorry for annoying with such issues, spending my childhood
with slow and low memory 8 bit machines just left a mark ;-)

>>
>>> +             msleep(20);
>>> +     }
>>> +
>>> +     if (tries < 0) {
>>> +             dev_err(&data->client->dev, "data not ready\n");
>>> +             return -EIO;
>>
>> Doesn't this qualify more for a timeout error, rather than I/O?
> 
> Looking at the IIO drivers, most of them return EIO in such case.
> (grep for EIO in drivers/iio/light for example)
> 

I don't feel too strong about this. I just regard I/O errors as indication
that communication with the device went wrong. But when getting here, it
always told to be busy.

> <snip>
> 
>>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>>> +             mutex_lock(&data->mutex);
>>> +             ret = regmap_read(data->regmap, MMC35240_REG_CTRL1, &reg);
>>> +             mutex_unlock(&data->mutex);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +
>>> +             i = (reg & MMC35240_CTRL1_BW_MASK) >> MMC35240_CTRL1_BW_SHIFT;
>>> +             if (i < 0 || i > ARRAY_SIZE(mmc35240_samp_freq))
>>
>> I would drop i and keep using reg. Has the nice side effect that you don't
>> need to check for negative values.
> 
> Ok.
> 
> 
> <snip>
> 
>>> +
>>> +static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +     switch (reg) {
>>> +     case MMC35240_REG_CTRL0:
>>> +     case MMC35240_REG_CTRL1:
>>
>> I would regard MMC35240_REG_ID as non-volatile, as well. Or is it because it
>> is just accessed once?
> 
> Correct, we access it only once.
> 
> Hartmut, thanks a lot for your reviews!
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
