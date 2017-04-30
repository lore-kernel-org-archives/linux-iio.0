Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34744 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033146AbdD3QTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:19:45 -0400
Subject: Re: [PATCH 2/2] iio: adc: Allow setting Shunt Voltage PGA gain and
 Bus Voltage range
To: Stefan Bruens <stefan.bruens@rwth-aachen.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
References: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de>
 <c94eddda-9d22-2f9a-a31d-9c7ae5e58440@kernel.org>
 <5135aead-65d6-35b2-8fed-f8ed2024cd51@kernel.org>
 <9342701.uSTzCLhmiO@pebbles.site>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b4eb76f-494d-138e-ec72-1fe7bbd20403@kernel.org>
Date: Sun, 30 Apr 2017 17:19:39 +0100
MIME-Version: 1.0
In-Reply-To: <9342701.uSTzCLhmiO@pebbles.site>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/17 21:37, Stefan Bruens wrote:
> On Mittwoch, 26. April 2017 08:59:47 CEST Jonathan Cameron wrote:
>> On 26/04/17 07:19, Jonathan Cameron wrote:
>>> On 17/04/17 23:08, Stefan Bruens wrote:
>>>> On Freitag, 14. April 2017 17:12:03 CEST Jonathan Cameron wrote:
> [...]
>>>
>>>> 4. Any user of the gain settings had to be made aware of the possibility
>>>> to
>>>> change it, no matter how it is exposed. Making it part of the scale, and
>>>> thus changing the meaning of the raw values, would be breaking the
>>>> existing ABI.> 
>>> The raw values should indeed not change.  That was a missunderstanding on
>>> my part.  Usually when a device has a PGA it is not compensated for in
>>> the output. So normally it's up to the driver to 'apply' the effective
>>> gain to the incoming reading.  When that isn't the case, it can be
>>> considered some sort of internal trim - hence the use of calibscale for
>>> this case.
>> Mulling this over, calibscale might not work either in this case. The
>> datasheet helpfully sometimes uses ranges and sometimes uses scale factors.
>> There is also obviously the calibration register kicking around which would
>> also be handled with calibscale if exposed to userspace (currently it isn't)
>>
>> I'm out of time tonight so will think it bit more about this and get back to
>> you in the next few days...
> 
> hardwaregain may be a viable option. For the shunt voltage, available values 
> would be [0.125, 0.25, 0.5, 1.0], for the bus range we would have either [0.5, 
> 1.0] or [1.0, 2.0] for bus ranges [32V, 16V].
> 
> Does hardwaregain have the right semantics for shunt voltage gain and/or bus 
> range?
Description we currently have in 
Documentation/ABI/testing/sysfs-bus-iio is:
		Hardware applied gain factor. If shared across all channels,
		<type>_hardwaregain is used.

Just thinking about the use cases, it is mostly used for cases where the
gain is not of the measurement being acquired, but rather of something related
(like the gain on time of flight sensors or pulse counters).

It also gets used for output devices and amplifiers though so kind of similar
as in those cases we felt calibrationscale was a bit of a stretch!

So yes, I can see that working.  Whether it is a better choice than 
simply allowing the range attributes (documented for this narrow
case to say they should only be used when the range is independent of
the scale) is an open question.  Given we have always preferred scales
to ranges if you think you can make hardwaregain fit well then lets
go with that, perhaps updating the docs to make this usecase explicit.

Looking back at the original emails we were actually thinking of
transistioning calibscale to hardwaregain in general as it covered
describing both uses, but it never happened...

J


> 
> Kind regards,
> 
> Stefan
> 

