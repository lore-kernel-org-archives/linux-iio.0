Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58561 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758784AbbJ3KBM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2015 06:01:12 -0400
In-Reply-To: <CAGhQ9Vx9PUT8kPQLceC6ZGseasyCawxoqnh3SvYL_=VdBhydjA@mail.gmail.com>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com> <1445374206-7277-1-git-send-email-manabian@gmail.com> <562CC0DA.4090400@kernel.org> <CAGhQ9Vx9PUT8kPQLceC6ZGseasyCawxoqnh3SvYL_=VdBhydjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis accelerometer driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 30 Oct 2015 10:00:46 +0000
To: Joachim Eastwood <manabian@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org
Message-ID: <55D34DF6-B80E-47A4-8E74-009AC1A0ABC0@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 29 October 2015 17:34:13 GMT+00:00, Joachim  Eastwood <manabian@gmail.com> wrote:
>Hi Jonathan,
>
>On 25 October 2015 at 12:45, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 20/10/15 21:50, Joachim Eastwood wrote:
>>> Add support for Freescale MMA7455L/MMA7456L 3-axis accelerometer
>>> in 10-bit mode for I2C and SPI bus. This rather simple driver that
>>> currently doesn't support all the hardware features of MMA7455L/
>>> MMA7456L.
>>>
>>> Tested on Embedded Artist's LPC4357 Dev Kit with MMA7455L on I2C
>bus.
>>>
>>> Data sheets for the two devices can be found here:
>>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf
>>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7456L.pdf
>>>
>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> Looks pretty good to me.  A few comments inline.
>> If we hadn't unfortunately just missed the merge window for IIO
>> I'd have probably taken it as is, but now we have plenty of time
>> to tidy up a few corners without effecting when people get to play
>> with it in distros.
>
>No, problem. I wasn't expecting it to go upstream during the upcoming
>window.
>
>
>>> +static int mma7455_write_raw(struct iio_dev *indio_dev,
>>> +                          struct iio_chan_spec const *chan,
>>> +                          int val, int val2, long mask)
>>> +{
>>> +     struct mma7455_data *mma7455 = iio_priv(indio_dev);
>>> +     int i;
>>> +
>>> +     if (iio_buffer_enabled(indio_dev))
>>> +             return -EBUSY;
>>
>> Whilst it is probably 'unwise' to prevent changes to samping
>frequency
>> and scale whilst the buffer is running, is there a hardware
>restriction
>> to prevent us doing so?  If so add a comment here.
>
>The data sheet doesn't really say one way or the other. So I think it
>should work, but as you say it's probably not a very good idea to
>change it during sampling. I'll change to code to allow it.
>
>
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>>> +             if (val == 250 && val2 == 0)
>>> +                     i = MMA7455_CTL1_DFBW_125HZ;
>>> +             else if (val == 125 && val2 == 0)
>>> +                     i = MMA7455_CTL1_DFBW_62_5HZ;
>>> +             else
>>> +                     return -EINVAL;
>>> +
>>> +             return regmap_update_bits(mma7455->regmap,
>MMA7455_REG_CTL1,
>>> +                                       MMA7455_CTL1_DFBW_MASK, i);
>>> +
>>> +     case IIO_CHAN_INFO_SCALE:
>>> +             /* In 10-bit mode there is only one scale available */
>>> +             if (val == 0 && val2 == MMA7455_10BIT_SCALE)
>>> +                     return 0;
>>> +             break;
>>> +     }
>>> +
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static ssize_t mma7455_show_samp_freq_avail(struct device *dev,
>>> +                                         struct device_attribute
>*attr,
>>> +                                         char *buf)
>>> +{
>>> +     return scnprintf(buf, PAGE_SIZE, "125 250\n");
>>> +}
>>> +
>>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma7455_show_samp_freq_avail);
>> There is IIO_CONST_ATTR for this sort of usage, but I guess you might
>> know this is going to get more complex in future?
>
>ah, nice, didn't know about IIO_CONST_ATTR. The hardware only support
>two sample rates so IIO_CONST_ATTR will do just fine.
>
>
>>> +const struct regmap_config mma7455_core_regmap = {
>>> +     .reg_bits = 8,
>>> +     .val_bits = 8,
>>> +     .max_register = MMA7455_REG_TW,
>> It does seem a little bit of a shame to not make use of more
>> regmap magic (e.g. caching) but I suppose this is just an initial
>> implementation of the driver and you can always add that stuff
>> later!
>
>I agree. If more properties like scaling and calibration is added
>using caching would be a good idea.
>
>
>I'll make a new version and send it within a couple of days or do want
>me to wait until the upcoming merge window closes?
Whenever you are ready.
>
>
>regards,
>Joachim Eastwood

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
