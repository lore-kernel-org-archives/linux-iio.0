Return-Path: <gregor.boirie@parrot.com>
Message-ID: <56B9C826.1090309@parrot.com>
Date: Tue, 9 Feb 2016 12:06:14 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: using monotonic clok for timstamping
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de> <56B63C8E.3020309@kernel.org> <56B865FC.7020106@metafoo.de> <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk>
In-Reply-To: <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

To sump up, implementing timestamping clock selection support in IIO
should be based on the following principles.

Selected timestamping clock is a per-device attribute which the userspace
may access through a sysfs file.

It must be applicable to both buffered samples and events.

Userspace may choose amongst a subset of available POSIX clocks. A good
starting point would be: CLOCK_REALTIME, CLOCK_MONOTONIC,
CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE,
CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and CLOCK_TAI.
Please delete as appropriate if needed and see clock_gettime(2).

One remaining question is : how do we ensure sample and event timestamps
consistency with respect to clock changes ? 2 suggestions:
* reject the ability to select a new clock as long as an events chardev 
is opened
   or a buffered samples channel is enabled ;
* clock may be changed at any time since it could be implemented in an 
atomic
   way (a simple atomic_t can hold an int / clockid_t if I'm no wrong).

Regards.

On 02/08/2016 06:15 PM, Jonathan Cameron wrote:
>
> On 8 February 2016 09:55:08 GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 02/06/2016 07:33 PM, Jonathan Cameron wrote:
>>> On 03/02/16 11:22, Lars-Peter Clausen wrote:
>>>> On 02/03/2016 11:55 AM, Gregor Boirie wrote:
>>>>> Dear  all,
>>>>>
>>>>> Our application relies on precise and monotonic timestamping of IMU
>> samples
>>>>> (and other sensors).
>>>>> I am wondering what reasons / use cases led to the choice of
>> realtime clock
>>>>> to implement
>>>>> iio_get_time_ns (not to mention time gaps that may be seen after
>> wake up
>>>>> from sleep states).
>>>> It's more of an oversight than a deliberate design decision. I
>> noticed this
>>>> problem as well a while ago and wanted to re-write things to use the
>>>> monotonic clock, but then realized that this would be a ABI change
>> so
>>>> dropped it and forgot about it again.
>>> There are certainly cases where the other clock would make sense (for
>> slow
>>> sampling device where being as correct as possible is the most
>> important
>>> thing).
>> I'm not sure I understand what you are trying to say, maybe we are not
>> on
>> the same page. As far as I know both clocks have the same precession,
>> but
>> their absolute value differs.
>>
>> What iio_get_time_ns() currently returns is the system clock, which
>> changes
>> whenever the time is changed (e.g. to compensate for drift, or daylight
>> saving, etc.). This is obviously not so great if that happens in the
>> middle
>> of the capture since what you care about is the relative distance
>> between
>> the samples and if your time base changes you have no idea what that is
>> anymore.
>>
>> So the monotonic clock which just keeps going at a fixed interval would
>> be
>> the better choice.
> In general I agree. My thought was that there are plausible usecases where a
>   capture is every n minutes over days or years where a timestamp that tracks with
>   'corrections' would make sense as intervals are not always the most
>   important thing.
>
> Most cases if course the monotonic clock is the best one. I chose badly a long time ago! Risk is someone is relying on it for some reason.
>
> J
>
