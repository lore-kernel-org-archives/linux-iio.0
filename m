Return-Path: <j.anaszewski@samsung.com>
Message-id: <52148D57.6010002@samsung.com>
Date: Wed, 21 Aug 2013 11:50:15 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, linux-iio@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v4 2/3] iio: gp2ap020a00f: Add a driver for the device
References: <1376658739-3417-1-git-send-email-j.anaszewski@samsung.com>
 <520FD862.3070802@kernel.org> <52138250.6040101@samsung.com>
In-reply-to: <52138250.6040101@samsung.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/20/2013 04:50 PM, Jacek Anaszewski wrote:
> On 08/17/2013 10:09 PM, Jonathan Cameron wrote:
>> On 08/16/13 14:12, Jacek Anaszewski wrote:
>>> Add a new driver for the ambient light/proximity sensor
>>> device. The driver exposes three channels: light_clear
>>> light_ir and proximity. It also supports triggered buffer,
>>> high and low ambient light threshold event and proximity
>>> detection events.
>>>
>>> Signed-off-by: Jacek Anaszewski<j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>> Signed-off-by: Kyungmin Park<kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>
>> Looking good but a few little bits and pieces left.
>> Superfluous !! when converting to boolean.
>> If the proximity detection cannot start with thresholds set to
>> the current value then fail to start it, don't fudge the variables.
>>
>> One question that comes to mind as well.  Does the chip always return
>> a value in the same units whatever scale is being applied?  If so then
>> all is fine (and this is a cleverer chip than commonly seen!).
>
> The chip can be set into two modes: manual and auto calculation.
> In the manual mode it outputs the result of CLEAR photodiode
> in D0 register and the result of IR photodiode in D1 register.
> Illuminance value can be obtained by making some calculation
> basing on these two values and some variables factors.
> In the auto calculation mode it outputs the calculated result
> without the influence of infrared spectrum in lux units to the
> D0 register. In addition raw IR result is stored in the D1 register.
>
> In the recent patch I switched over to using auto calculation mode
> to avoid the problems with dynamically changing scale value.
>
>> Otherwise how does userspace know what it is getting?
>
> This was my concern when I asked in the other email how
> to inform the user what scale has been applied.
>
> Thanks,
> Jacek

In the RFC v5 I got rid of automatic setting of the maximum
measurable range which was a mistake, as I messed it up with
switching to auto calculation mode. The auto calculation mode
doesn't handle the situation when the output value is to high
to fit in 16-bit value - the maximum measurable range has to
be adjusted in such case.

In the auto calculation mode this is the maximum
measurable range alone which determines the scale for
the output value. The documentation recommends setting it
to x128 when the illuminance_clear output value exceeds 16000,
and to x8 when in high lux mode and the output value falls
below 1000, so this should be done automatically as the function
gp2ap020a00f_adjust_lux_mode did in the previous version
of the patch.

Nonetheless, this is the problem of dynamically changing
scale value. The other option could be exposing sysfs attribute
for changing the scale value, but there should be some information
provided at what output values the changes should be made.

How would you approach that?

Thanks,
Jacek
