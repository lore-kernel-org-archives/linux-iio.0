Return-Path: <lars@metafoo.de>
Message-ID: <4EA57EB6.1020801@metafoo.de>
Date: Mon, 24 Oct 2011 17:05:26 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Channel-less IIO events
References: <4EA56C67.7020203@metafoo.de> <4EA57547.3010804@cam.ac.uk>
In-Reply-To: <4EA57547.3010804@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/24/2011 04:25 PM, Jonathan Cameron wrote:
> On 10/24/11 14:47, Lars-Peter Clausen wrote:
>> Hi,
>>
>> Some chips generate events which don't really map to a channel, but are
>> rather chip global. For example over-temperature events.
> That one is a channel.
>> Do you think this is something we should add support for or should we rather
>> use a dummy channel, which doesn't report any actual values, for propagating
>> the event?
> Yup, have a temp channel for that one.  Conceptually you might have two chips
> that are otherwise identical but one has a readable temp channel, the other
> doesn't.  Userspace that is interested only in events won't care about
> this difference.  Also we want to report what the conditions are as if it were
> a channel we could read.  We want to know at what temperature this occurs.

Ok, what should a read on such a channel return, an error value or just an
dummy value?


> [...]
>>
>> My idea for supporting channel-less events is to add a event_mask to struct
>> iio_info, which would be used just like a channels event_mask, but there
>> would be no index for the sysfs attributes and for events we would set the
>> event number to 0xffff.
> Could you give more examples?  The temp one to my mind definitely needs a
> channel, perhaps others do not?  I am not against in principal but not
> yet certain exactly when this would make sense...

over-temperature is the only one i've seen so far. but other could be
under-current or voltage for the whole chip.

Thanks
- Lars
