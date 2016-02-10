Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30851 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbcBJJqG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 10 Feb 2016 04:46:06 -0500
Message-ID: <56BB06DC.8060606@parrot.com>
Date: Wed, 10 Feb 2016 10:46:04 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: Re: using monotonic clok for timstamping
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de> <56B63C8E.3020309@kernel.org> <56B865FC.7020106@metafoo.de> <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk> <56B9C826.1090309@parrot.com> <56BA5176.6020108@metafoo.de>
In-Reply-To: <56BA5176.6020108@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 02/09/2016 09:52 PM, Lars-Peter Clausen wrote:
> On 02/09/2016 12:06 PM, Gregor Boirie wrote:
>> To sump up, implementing timestamping clock selection support in IIO
>> should be based on the following principles.
>>
>> Selected timestamping clock is a per-device attribute which the userspace
>> may access through a sysfs file.
>>
>> It must be applicable to both buffered samples and events.
> Just playing out ideas here to make sure we have everything covered, but
> could be there be a setup where you'd want different timestamps for events
> and buffers?
I'm not familiar enough with events to tell.

>> Userspace may choose amongst a subset of available POSIX clocks. A good
>> starting point would be: CLOCK_REALTIME, CLOCK_MONOTONIC,
>> CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE,
>> CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and CLOCK_TAI.
>> Please delete as appropriate if needed and see clock_gettime(2).
>>
>> One remaining question is : how do we ensure sample and event timestamps
>> consistency with respect to clock changes ? 2 suggestions:
>> * reject the ability to select a new clock as long as an events chardev is
>> opened
>>    or a buffered samples channel is enabled ;
>> * clock may be changed at any time since it could be implemented in an atomic
>>    way (a simple atomic_t can hold an int / clockid_t if I'm no wrong).
> Not sure if we need to prevent it. If somebody changes it during an active
> measurement it is their problem I'd say.
I like this way of keeping it simple. However, wouldn't this make the API
inhomogeneous ? After all, many channel related operations return
-EBUSY while flowing samples...
