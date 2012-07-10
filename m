Return-Path: <jic23@kernel.org>
Message-ID: <4FFBE302.40606@kernel.org>
Date: Tue, 10 Jul 2012 09:08:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
 Jon Brenner <jbrenner@taosinc.com>,
 linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] IIO channel type and modifiers for CCT and RGBC data
References: <1337183202.6344.1.camel@jonz-ub2> <alpine.DEB.2.01.1206140006370.29697@pmeerw.net> <4FD9906C.7090400@cam.ac.uk>
In-Reply-To: <4FD9906C.7090400@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Jon,

Peter raised the question below about this.

Now we have two varients of this patch. As it was original yours
Jon, could you rustle up a new version incorporating Peter's
one and if both of you sign off / ack it, I'll merge it.

Jonathan
> On 6/13/2012 11:09 PM, Peter Meerwald wrote:
>>
>>> Add iio channel type and modifiers for Correlated Color Temperature
>>> (CCT)
>>> and RGBC (red/green/blue/clear) data.
>>
>>> +What:
>>> /sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
>>> +What:
>>> /sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
>>> +What:
>>> /sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
>>> +What:
>>> /sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
>>> +KernelVersion:    3.4.0
>>> +Contact:    linux-iio@vger.kernel.org
>>> +Description:
>>> +        This property is supported by sensors that have a RGBC
>>> +        sensing mode. This value should be the output from a reading
>>> +        and if expressed in SI units, should include _input. If this
>>> +        value is not in SI units (irradiance, uW/mm), then it should
>>> +        include _raw.
>>
>> should the irradiance unit be uW/mm^2 ??
> or just W/m^2? Whichever people prefer! Good spot Peter.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
