Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbcBFSdv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:33:51 -0500
Subject: Re: using monotonic clok for timstamping
To: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B63C8E.3020309@kernel.org>
Date: Sat, 6 Feb 2016 18:33:50 +0000
MIME-Version: 1.0
In-Reply-To: <56B1E2D8.90308@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/16 11:22, Lars-Peter Clausen wrote:
> On 02/03/2016 11:55 AM, Gregor Boirie wrote:
>> Dear  all,
>>
>> Our application relies on precise and monotonic timestamping of IMU samples
>> (and other sensors).
>> I am wondering what reasons / use cases led to the choice of realtime clock
>> to implement
>> iio_get_time_ns (not to mention time gaps that may be seen after wake up
>> from sleep states).
> 
> It's more of an oversight than a deliberate design decision. I noticed this
> problem as well a while ago and wanted to re-write things to use the
> monotonic clock, but then realized that this would be a ABI change so
> dropped it and forgot about it again.
There are certainly cases where the other clock would make sense (for slow
sampling device where being as correct as possible is the most important
thing).

However as Lars observed it was as well considered a choice as it should have
been as this dates back all the way.
> 
>>
>> As a dirty hack, I simply rewrote iio_get_time_ns on our platform. But I
>> suspect it would be usefull as
>> a long term solution, to give userland the ability to choose a particular
>> posix clock (realtime, monotonic,
>> etc...) on a per device and / or driver basis through a sysfs attribute for
>> example.
> 
> This is probably the only viable solution while keeping the ABI backwards
> compatible.
Agreed - preference for per device instance sysfs attribute.
If it were just the buffered timestamp readings, we could make it an attribute
for that single channel, but timestamps are also used with events and we
would therefore probably want it to be consistent for a whole instance of the
device.

Jonathan
> 
> - Lars
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

