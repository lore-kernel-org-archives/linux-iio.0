Return-Path: <lars@metafoo.de>
Subject: Re: using monotonic clok for timstamping
To: Jonathan Cameron <jic23@kernel.org>,
 Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de>
 <56B63C8E.3020309@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B865FC.7020106@metafoo.de>
Date: Mon, 8 Feb 2016 10:55:08 +0100
MIME-Version: 1.0
In-Reply-To: <56B63C8E.3020309@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 02/06/2016 07:33 PM, Jonathan Cameron wrote:
> On 03/02/16 11:22, Lars-Peter Clausen wrote:
>> On 02/03/2016 11:55 AM, Gregor Boirie wrote:
>>> Dear  all,
>>>
>>> Our application relies on precise and monotonic timestamping of IMU samples
>>> (and other sensors).
>>> I am wondering what reasons / use cases led to the choice of realtime clock
>>> to implement
>>> iio_get_time_ns (not to mention time gaps that may be seen after wake up
>>> from sleep states).
>>
>> It's more of an oversight than a deliberate design decision. I noticed this
>> problem as well a while ago and wanted to re-write things to use the
>> monotonic clock, but then realized that this would be a ABI change so
>> dropped it and forgot about it again.
> There are certainly cases where the other clock would make sense (for slow
> sampling device where being as correct as possible is the most important
> thing).

I'm not sure I understand what you are trying to say, maybe we are not on
the same page. As far as I know both clocks have the same precession, but
their absolute value differs.

What iio_get_time_ns() currently returns is the system clock, which changes
whenever the time is changed (e.g. to compensate for drift, or daylight
saving, etc.). This is obviously not so great if that happens in the middle
of the capture since what you care about is the relative distance between
the samples and if your time base changes you have no idea what that is anymore.

So the monotonic clock which just keeps going at a fixed interval would be
the better choice.
