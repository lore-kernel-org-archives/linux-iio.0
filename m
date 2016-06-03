Return-Path: <ldewangan@nvidia.com>
Message-ID: <5751753D.40107@nvidia.com>
Date: Fri, 3 Jun 2016 17:47:01 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <robh+dt@kernel.org>,
	<corbet@lwn.net>, <lars@metafoo.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "Guenter
 Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver
 for TI INA3221
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com> <1464784454-7988-2-git-send-email-ldewangan@nvidia.com> <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org> <57516980.1040907@nvidia.com> <c12d7b59-3013-91fc-5414-5583bdb7d962@kernel.org>
In-Reply-To: <c12d7b59-3013-91fc-5414-5583bdb7d962@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On Friday 03 June 2016 05:39 PM, Jonathan Cameron wrote:
> On 03/06/16 12:26, Laxman Dewangan wrote:
>> On Friday 03 June 2016 03:36 PM, Jonathan Cameron wrote:
>>
>> I thought that all ADC or monitors are going to be part of IIO device
>> framework. I saw the ina2xx which is same (single channel) which was
>> my reference point.
> That had a rather specific use case IIRC - they needed the buffered support
> to get the data fast enough.

I think in our particular  requirements, we dont need the buffering 
support but HW keep monitor and check with warning/critical threshold to 
generate HW signal.
>>> Funily enough I know this datasheet a little as was evaluating
>>> it for use on some boards at the day job a week or so ago.
>>>
>>> Various comments inline. Major points are:
>>> * Don't use 'fake' channels to control events. If the events infrastructure
>>> doesn't handle your events, then fix that rather than working around it.
>>> * There is a lot of ABI in here concerned with oneshot vs continuous.
>>> This seems to me to be more than it should be. We wouldn't expect to
>>> see stuff changing as a result of switching between these modes other
>>> than wrt to when the data shows up.  So I'd expect to not see this
>>> directly exposed at all - but rather sit in oneshot unless either:
>>> 1) Buffered mode is running (not currently supported)
>>> 2) Alerts are on - which I think requires it to be in continuous mode.
>>>
>>> Other question to my mind is whether we should be reporting vshunt or
>>> (using device tree to pass resistance) current.
>> This is bus and shunt voltage device for power monitoring. In our
>> platforms, we use this device for bus current and so power monitor.
>>
>> We have two usecases, one is one shot, read when it needs it. And
>> other continuous when we have multiple core running then continuous
>> mode to get the power consumption by rail.
> That's fine, but continuous should be using the buffered interfaces
> really as that's there explicitly to support groups of channels
> captured using a sequencer.
>
> Then the abi ends up much more standard which is nice. Also allows
> for high speed ish continuous monitoring which is what the was
> I think the point of the single channel driver.

The requirement for continuous monitoring is to ADC generate alert when 
the current on bus cross the threshold of warning/critical level so that 
alert signal can be used for throttling.
So in my this particular usecase, we may not need buffered data.


>> Yaah, alert is used only on continuous mode and mainly used for
>> throttling when rail power goes beyond some limit.
> Of interesting in Linux, or routed directly to hardware?

Yaah, In some platform this is routed to the hardware for throttling.
