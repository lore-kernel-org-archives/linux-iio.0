Return-Path: <jic23@kernel.org>
Message-ID: <4FD6F477.9030506@kernel.org>
Date: Tue, 12 Jun 2012 08:49:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: iio: vcnl4000 ALS/proximity driver
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <4FD635A0.7050507@kernel.org> <alpine.DEB.2.01.1206112328220.30702@pmeerw.net> <3a7abb16-df44-4b5b-9651-d0399659c4af@email.android.com>
In-Reply-To: <3a7abb16-df44-4b5b-9651-d0399659c4af@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 6:49 AM, Jonathan Cameron wrote:
>
> Peter Meerwald<pmeerw@pmeerw.net>  wrote:
>
>> Hello Jonathan,
>>
>>>> I am lost with the meaning and use of IIO modifiers...
>>> Quick and dirty summary.
>>> Calibscale is internally applied within the hardware (or occasionally
>>> software but looks like it was in the hardware from point of view
>>> of userspace!)
>> thank you for clarification
>>
>> Am I missing documentation somewhere?
>>
> Documentation/ABI/testing/sysfs-bus-iio.
+ drivers/staging/iio/documentation/sysfs-* for other bits and bobs. 
Mostly it
should be fairly obvious how stuff lines up.
>
>> some comments in iio/types.h iio/iio.h would avoid guesswork...
>>
>> enum iio_chan_type {
>> 	/* real channel types */	
>> are there unreal channels also? :)
ah, there were.  That comment is out of date.  This sort of thing is why
we try to keep minimal commenting in there unless absolutely necessary.
I suppose we could put a reference to say see the docs files...
>> what is IIO_ANGL_VEL vs. IIO_ANGL? VOLTAGE vs. ALTVOLTAGE?
Those should be pretty obvious and line up with the documentation.
  Angl_vel is the angular velocity. angl is the the angle.  Voltage is a 
dc voltage,
altvoltage is an alternating voltage. (this can mater as some 'interesting'
parts can sample the instantaneous voltage and also provide the rms voltage
under the assumption that it's a sinusoid.).
>>
>> what is LIGHT_BOTH?
Visible + infrared  (agreed that one is not good.  We've talked about
changing that, but nothing has happened about it yet...)
>>
>> it would be helpful what IIO_CHAN_INFO_SHARED_BIT vs
>> IIO_CHAN_INFO_SEPARATE_BIT relates to?
Maybe that one needs a comment..
Shared is across a channel type. E.g. in_accel_scale
vs separate which is per channel in_accel_x_scale.
>>
>> IIO_CHAN_INFO_SAMP_FREQ vs IIO_CHAN_INFO_FREQUENCY?
That should be in the sysfs docs.  samping frequency refers to sampling
whereas frequency refers to the frequency of the thing being measured
or (more typically) output.
>>
>> thanks, regards, p.
>>
>> -- 
>>
>> Peter Meerwald
>> +43-664-2444418 (mobile)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
