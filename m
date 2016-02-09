Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44567 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcBIVCG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 16:02:06 -0500
Subject: Re: using monotonic clok for timstamping
To: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de>
 <56B63C8E.3020309@kernel.org> <56B865FC.7020106@metafoo.de>
 <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk>
 <56B9C826.1090309@parrot.com> <56BA5176.6020108@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA53CC.40808@kernel.org>
Date: Tue, 9 Feb 2016 21:02:04 +0000
MIME-Version: 1.0
In-Reply-To: <56BA5176.6020108@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/16 20:52, Lars-Peter Clausen wrote:
> On 02/09/2016 12:06 PM, Gregor Boirie wrote:
>> To sump up, implementing timestamping clock selection support in IIO
>> should be based on the following principles.
>>
>> Selected timestamping clock is a per-device attribute which the userspace
>> may access through a sysfs file.
>>
>> It must be applicable to both buffered samples and events.
> 
> Just playing out ideas here to make sure we have everything covered, but
> could be there be a setup where you'd want different timestamps for events
> and buffers?
I hope not..
> 
>>
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
>>   or a buffered samples channel is enabled ;
>> * clock may be changed at any time since it could be implemented in an atomic
>>   way (a simple atomic_t can hold an int / clockid_t if I'm no wrong).
> 
> Not sure if we need to prevent it. If somebody changes it during an active
> measurement it is their problem I'd say.
A fair point if we document it clearly as 'HERE BE DRAGONS!'
Won't typically crash anything, just give crazy answers :)
> 

