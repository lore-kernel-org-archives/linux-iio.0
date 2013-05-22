Return-Path: <gballetwork@gmail.com>
MIME-Version: 1.0
In-Reply-To: <519CD307.8020404@metafoo.de>
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com>
	<519C7C29.9040707@jic23.retrosnub.co.uk>
	<519C7F93.9010606@metafoo.de>
	<519C8923.7020902@jic23.retrosnub.co.uk>
	<CAGi_vricp+o35GiycEeO=eXg4gwpiP3x1ZvU2JCP0-_vMwrwWw@mail.gmail.com>
	<519CAF57.5030301@metafoo.de>
	<CAGi_vrir0uQd4u9WgixQ5an+jE8WFTyVmBiFnmxa-y=DfeW61g@mail.gmail.com>
	<519CCAA2.2070408@metafoo.de>
	<CAGi_vrjk7FLvYhHSLbV9D4GGHY1X1k1fkuEXMkh9Mn7z_5qj1w@mail.gmail.com>
	<519CD307.8020404@metafoo.de>
Date: Wed, 22 May 2013 17:24:01 +0200
Message-ID: <CAGi_vri2=wV8+m=y7ODKwh=F7opd_ZWckfP6NF_OftFh4=A=4Q@mail.gmail.com>
Subject: Re: Why is only one int returned in iio_read_channel_processed?
From: Guillaume Ballet <gballetwork@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

>> I have a driver for an ADC block that measures miscellaneous values in
>> various units (temperature, voltage, current...) to be read from
>> drivers in other kernel subsystems (the power supply class, for
>> instance).
>
> This already works today with the current implementation of
> iio_read_channel_processed.

Indeed.

>
> Unit conversion has to be done by the IIO device itself as
>> it's done using tables that are provided by various vendors who don't
>> want them published.
>
> So how do you include the tables in the IIO driver if they can't be published?

I will load them as a blob from the device tree. It doesn't need to
have a very high level of protection - I just need to ensure that
those values aren't hard-coded in a file under the GPL.

>
>> Hence my need to call iio_read_channel_processed
>> and not entrust anyone else with the conversion.
>
> Ah, ok, so your driver implements IIO_CHAN_INFO_PROCESSED instead of
> IIO_CHAN_INFO_RAW. And you want to be able to specify your value with
> sub-decimal precession, is this correct?

Absolutely.

>
>>
>> Could _you_ please explain what your concern with using the same format is?
>
> Because the definition of IIO_CHAN_INFO_PROCESSED is that the value has
> already the proper unit and no unit conversion is necessary.

Now I see, thanks.

Getting back to the precision issue, I see that in
iio_convert_raw_to_processed_unlocked() there is the following code:

         case IIO_VAL_INT_PLUS_MICRO:
                 if (scale_val2 < 0)
                         *processed = -raw64 * scale_val;
                 else
                         *processed = raw64 * scale_val;
                 *processed += div_s64(raw64 * (s64)scale_val2 * scale,
                                       1000000LL);
                 break;
         case IIO_VAL_INT_PLUS_NANO:
                 if (scale_val2 < 0)
                         *processed = -raw64 * scale_val;
                 else
                         *processed = raw64 * scale_val;
                 *processed += div_s64(raw64 * (s64)scale_val2 * scale,

with processed being of type int *. So the sub-decimal precision is
indeed lost. Is there a big issue with adapting the code to also
handle sub-decimal precision, then?

Guillaume
