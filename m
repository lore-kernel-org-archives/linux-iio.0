Return-Path: <lars@metafoo.de>
Message-ID: <519CFCEB.1010606@metafoo.de>
Date: Wed, 22 May 2013 19:14:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guillaume Ballet <gballetwork@gmail.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 linux-iio@vger.kernel.org
Subject: Re: Why is only one int returned in iio_read_channel_processed?
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com> <519C7C29.9040707@jic23.retrosnub.co.uk> <519C7F93.9010606@metafoo.de> <519C8923.7020902@jic23.retrosnub.co.uk> <CAGi_vricp+o35GiycEeO=eXg4gwpiP3x1ZvU2JCP0-_vMwrwWw@mail.gmail.com> <519CAF57.5030301@metafoo.de> <CAGi_vrir0uQd4u9WgixQ5an+jE8WFTyVmBiFnmxa-y=DfeW61g@mail.gmail.com> <519CCAA2.2070408@metafoo.de> <CAGi_vrjk7FLvYhHSLbV9D4GGHY1X1k1fkuEXMkh9Mn7z_5qj1w@mail.gmail.com> <519CD307.8020404@metafoo.de> <CAGi_vri2=wV8+m=y7ODKwh=F7opd_ZWckfP6NF_OftFh4=A=4Q@mail.gmail.com>
In-Reply-To: <CAGi_vri2=wV8+m=y7ODKwh=F7opd_ZWckfP6NF_OftFh4=A=4Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/22/2013 05:24 PM, Guillaume Ballet wrote:
[...]
>>> Hence my need to call iio_read_channel_processed
>>> and not entrust anyone else with the conversion.
>>
>> Ah, ok, so your driver implements IIO_CHAN_INFO_PROCESSED instead of
>> IIO_CHAN_INFO_RAW. And you want to be able to specify your value with
>> sub-decimal precession, is this correct?
> 
> Absolutely.
> 
>>
>>>
>>> Could _you_ please explain what your concern with using the same format is?
>>
>> Because the definition of IIO_CHAN_INFO_PROCESSED is that the value has
>> already the proper unit and no unit conversion is necessary.
> 
> Now I see, thanks.
> 
> Getting back to the precision issue, I see that in
> iio_convert_raw_to_processed_unlocked() there is the following code:
> 
>          case IIO_VAL_INT_PLUS_MICRO:
>                  if (scale_val2 < 0)
>                          *processed = -raw64 * scale_val;
>                  else
>                          *processed = raw64 * scale_val;
>                  *processed += div_s64(raw64 * (s64)scale_val2 * scale,
>                                        1000000LL);
>                  break;
>          case IIO_VAL_INT_PLUS_NANO:
>                  if (scale_val2 < 0)
>                          *processed = -raw64 * scale_val;
>                  else
>                          *processed = raw64 * scale_val;
>                  *processed += div_s64(raw64 * (s64)scale_val2 * scale,
> 
> with processed being of type int *. So the sub-decimal precision is
> indeed lost. Is there a big issue with adapting the code to also
> handle sub-decimal precision, then?

Well it's not an issue per se, it's just that there are no in kernel users
which would be able to make use of this. The iio_convert_raw_to_processed()
function takes an additional scale parameter though which allows you to get
a value with a high precession. E.g. if you read a voltage channel with
scale set to 1000 you'll get the result in micro Volts instead of milli
Volts. The same parameter could be added to iio_read_channel_processed() and
you'd do similar calculations as in iio_convert_raw_to_processed(). Instead
of 'raw64 * scale_val' you'd just use 'val' and instead of 'raw64 *
scale_val2' you'd use 'val2'.

E.g. for IIO_VAL_INT_PLUS_MICRO:
                  if (val2 < 0)
                          *processed = -val;
                  else
                          *processed = val;
                  *processed += div_s64((s64)val2 * scale, 1000000LL);

and so on.


And I think for sysfs nodes it should already work fine, e.g. if you return
IIO_VAL_INT_PLUS_MICRO.

- Lars
