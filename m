Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1603300946280.14313@pmeerw.net>
References: <1459261653-13070-1-git-send-email-linus.walleij@linaro.org>
	<alpine.DEB.2.02.1603291632370.16868@pmeerw.net>
	<CACRpkdYQ1tZdfQew456Q1iFT=MO_2PB_fBPaE_wd5XqKO8cs-w@mail.gmail.com>
	<alpine.DEB.2.02.1603300946280.14313@pmeerw.net>
Date: Wed, 30 Mar 2016 10:28:30 +0200
Message-ID: <CACRpkdY2AP=UOg=yqyQi61+Z=rs+cvf4xmkZhnGgekdht1wfOg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: new driver for the ROHM BH1780
From: Linus Walleij <linus.walleij@linaro.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 30, 2016 at 9:48 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:

>> >> +     case IIO_CHAN_INFO_SCALE:
>> >> +             /* Returns raw lux value */
>> >> +             *val = 1;
>> >
>> > not needed to scale by 1.0
>> >
>> >> +             *val2 = 0;
>> >> +             return IIO_VAL_INT;
>>
>> How do you mean?
>> If I don't implement this (just let this function return negative)
>> this happens:
>>
>> iio:device1 ls
>> dev                              of_node
>> in_illuminance_integration_time  power
>> in_illuminance_raw               subsystem
>> in_illuminance_scale             uevent
>>
>> iio:device1 cat in_illuminance_scale
>> cat: read error: Invalid argument
>>
>> Do you mean all userspace programs should assume scale by 1x
>> if they get an error when they try to read the scale file, or is there
>> a bug in IIO such that this file should return "1" if the callback asking for
>> IIO_CHAN_INFO_SCALE returns negative?
>
> IIO_CHAN_INFO_SCALE is optional, if it is not given 1.0 is to be assumed
>
> you do not give _OFFSET as well and assume that offset is 0.0 when
> interpreting _RAW

I see what you mean, but the actual error I did was this:

> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +                                   BIT(IIO_CHAN_INFO_SCALE) |
> +                                   BIT(IIO_CHAN_INFO_INT_TIME)

If I drop IIO_CHAN_INFO_SCALE I don't get the file in sysfs
even and then the userspace should assume scale by 1.
I assume. OK changed it like so...

Yours,
Linus Walleij
