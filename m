Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <alpine.DEB.2.02.1505281507511.30008@pmeerw.net>
References: <1432810354-24745-1-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1505281300180.30008@pmeerw.net>
	<CAEnQRZDioRjc0nLLncYitkjW7QyC4z+Ha6VE82h2RUScyXFx-Q@mail.gmail.com>
	<alpine.DEB.2.02.1505281507511.30008@pmeerw.net>
Date: Thu, 28 May 2015 17:17:03 +0300
Message-ID: <CAEnQRZD1FNdW_3XZ13uane-VeHN9fVQue6z_j-3=3eYvgHNL9w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: Add support for ROHM RPR0521 sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Vlad Dogaru <vlad.dogaru@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

<snip>

>> >> +static const struct iio_chan_spec rpr0521_channels[] = {
>> >> +     {
>> >> +             .type = IIO_INTENSITY,
>> >> +             .modified = 1,
>> >> +             .address = RPR0521_CHAN_ALS_DATA0,
>> >> +             .channel2 = IIO_MOD_LIGHT_BOTH,
>> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> >> +                     BIT(IIO_CHAN_INFO_CALIBSCALE),
>> >
>> > why CALIBSCALE and not SCALE?
>>
>> Because this is used to set/get gain, which is used by the hardware
>> to do proper scaling.
>>
>> AFAIK this should be calibscale.
>
> in sysfs-bus-iiof on CALIBSCALE: Hardware applied calibration scale factor
> (assumed to fix production inaccuracies).
>
> this doesn't seem applicable here, it is a gain factor controlling
> measurement resolution

Ok, I see now and it makes sense :).

# echo 1 > in_intensity_ir_calibscale
# cat in_intensity_ir_raw
79
# echo 64 > in_intensity_ir_calibscale
# cat in_intensity_ir_raw
5084

The user should get the same value regardless of the gain :), and in the
above example for x64 gain it should have a 1/64 scale.


<snip>

>> Or we can consider that the chan->type is always valid?
>
> I'd think so; you also assume that chan->address is valid
>
> I suggest to use chan->address to point to a table containing the
> address and the mask

<snip>

>> Which sensors? It means they do not agree with the ABI:
>>
>> http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L1131
>
> that 'clarification' was added recently,
> 614e8842ddf5502f0e781f91695bfbc1e1e1d9b6 (with 3.18)
> "Proximity measurement .. by observing reflectivity"
>
> high proximity <-> high reflectivity -- this is the reality of what most
> sensors output (including yours)
>
> proximity and distance are opposite concepts;
> high proximity <-> low distance, and vice versa
>
> the distance part doesn't make sense in the ABI description

At least sx9500 uses this convention and userspace applications rely on this.

>
>> >
>> >> +              */
>> >> +             if (chan->type == IIO_PROXIMITY)
>> >> +                     *val = RPR0521_PXS_MAX_VAL - *val;
>> >
>> > really this should be _PROCESSED, not _RAW?
>>
>> I understand and it makes sense. Anyhow, looking at
>> drivers/iio/proximity/sx9500.c
>> it seems to be using _RAW.
>>
>> > how to handle it for buffered reads?
>>
>> Not sure I understand this. Care to add more details :)?
>
>> I would expect that for buffer mode we create an item with 12 realbits and
>> 16 storage bits, and to copy the data from register to buffer.
>
> in buffered mode we want to avoid manipulating the data (i.e. MAX_DATA -
> measurement_value)
>
> since MAX_DATA is not exposed, user mode cannot do this computation and
> _RAW differs from the buffered output
>
> (I assume that we want to have buffered output correspond to _RAW values)
>
>> >> +     pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
>> >> +     pm_runtime_use_autosuspend(&client->dev);
>> >> +
>> >> +     return 0;
>> >
>> > maybe some whitespace here
>> >
>> do you mean remove the new line? :)
>
> add a newline if I predict Jonathan's perference correctly :)
>
