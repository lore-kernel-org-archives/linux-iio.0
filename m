Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:52016 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab0EKRb6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2010 13:31:58 -0400
Message-ID: <4BE994F4.4030608@cam.ac.uk>
Date: Tue, 11 May 2010 18:33:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: adis16220 capture event
References: <AANLkTinVNqGBQqVaitQHwxmh_EVzkNhLNpl1Fzyc0eTC@mail.gmail.com> 	<4BE93FF2.9020605@cam.ac.uk> <AANLkTikhQp8XjgfDfdK_TZwmDjRuFq6QUp0yVX5S4w1O@mail.gmail.com>
In-Reply-To: <AANLkTikhQp8XjgfDfdK_TZwmDjRuFq6QUp0yVX5S4w1O@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/10 16:07, Barry Song wrote:
> On Tue, May 11, 2010 at 7:30 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>
>> On 05/11/10 08:59, Barry Song wrote:
>>> Jonathan,
>>> adis16260 in drivers/staging/iio/gyro/ has been ready too.
>>> Do you have time to take a look at the datasheet of adis16220? I think
>>> it is much different. The chip has no register to show the current
>>> sample value. It only has a capture buffer mode.  For every capture(by
>>> manual or by period at least 1 second), the ADIS16220 produces and
>>> stores 1024
>>> samples of acceleration and analog input channel data into the capture
>>> buffers. It has no a fixed frequency to sample, by depends on user
>>> commands or timer to trigger a capture.
>>
>> I've been waiting for a device like this to be supported :)
>>
>>> I think current iio doesn't support it at all:
>>> 1. sysfs node is useless to show current value
>> Indeed so don't supply one.  All the sysfs interfaces are optional and should
>> only be supplied where they make sense.
>>> 2. it doesn't sample periodically, so ring is useless too.
>> Agreed that the ring buffer you have been using for the others is
>> inappropriate. However, what you have below looks very like a
>> hardware buffer (see the accel/sca3000_ring.c for an example).
>>> Its work flow is:
>>> capture -> 1024 data -> capture -> 1024 data -> capture -> 1024 data ....
>>> I want to add a binary sysfs node for capture buffer.
>> No. This really isn't a single value so it won't be accepted for mainline.
> binary sysfs node is not a single value but a document which can hold
> much data. some devices like i2c eeprom are using bin_attribute to
> support read and write a big memory.
I agree it happens.  The general view is very anti doing this however.
Chrdev's are definitely the way to go for large data drops like this.
> 
>>  Every time, users
>>> begin a capture, after finishing, read 1024 data from the binary node.
>>>
>>> Do you have any idea?
>> Yes. I'd set the whole thing up as a hardware buffer. As an aside, we
>> really need to get the word 'ring' out of the code at some point given
>> quite a few implementations aren't going to be rings.
> i don't think it is a hardware ring buffer. 
No indeed, it isn't. It is however a hardware buffer of data capture at a
number of time instances.  The data isn't a single time point, but rather
a set over a period of time.  This is what I meant about the problem with
the word 'ring'. The intention was always to support other types of buffer,
very much including the type we have here.  This actually looks almost
exactly like a non periodic trigger (e.g. gpio etc) filling a fifo,
be it with a large number of samples over a period around the current time.

Just because most of our uses so far are periodic, there is no inherent
reason why they all should be.  For a while I considered implementing
all event's coming from the devices as triggers but decided it was better
to stick to only the obvious ones (datardy) so as to keep things simple
when people were implementing the simpler drivers (without buffering).

>every-time, data number is
> fixed 1024 for a capture event. Without periodic input, a binary node
> should be enough for this.
That depends on how often you device is likely to trigger. Also there is
the question of generality.  We will get other devices like this. Some of
them are going to trigger rather quickly.

By all means put it in as a binary sysfs attribute for now, but take into
account that it may well be unacceptable to upstream.  I'm yet to be
convinced this isn't a hardware buffer looking just like any other, be
it with slightly odd triggering.  Perhaps this is one to work on at a
later date.

Jonathan
> 
>>
>> From the datasheet I see there are a couple of different ways to trigger
>> capture.  I would be inclined to handle the manual mode via a trigger.
>> I think a general userspace manual trigger would be helpful anyway for
>> testing other devices if nothing else.  Probably just a sysfs attribute
>> called capture_now that otherwise looks much like the gpio trigger.
>>
>> The timer option is more or less the equivalent of a conventional fixed
>> frequency capture (be it with a lot of data per capture!). One could
>> supply a trigger to indicate this has finished. Probably better to have
>> the event in question come from the buffer event chrdev (see below).
>>
>> The last option of doing it based on an event is more interesting.
>> The options that come to mind are:
>>
>> * A seperate trigger - You would need a way for other devices to know the
>>  trigger has fired. This would pretty much require tying the alarm in question
>>  to one of the gpio pins so as to pass the notification on.  Perhaps this only
>>  happens if another device attaches to the trigger? (bit fiddly to code).
>>
>> * Do it internally as control attributes of a new hardware buffer.
>>  If you are also supporting general alarm events the logic would get a little
>>  complex as obviously these could be shared (event can trigger a buffer fill
>>  as well as causing an external gpio interrupt).
>>
>> I would prefer the first option, but the second is fine for now if it is
>> easier to code up.  The first allows us to say chain on a gyro to get
>> additional info triggered off trigger events from adis16220.  Clearly
>> there are a few complexities to be considered.  For one thing the exact
>> nature of the trigger consumer function would be different from the userspace
>> trigger (when it would cause a capture) to the event based triggers
>> (where the capture would already have happened).  This is actually a case
>> that needs better handling in some of the current drivers.  In theory
>> with the lis3l02dq for example, one can trigger another device off it's
>> datardy signal without actually triggering the lis3l02dq itself.  This
>> would result in no read of data and the datardy signal would not clear.
>> Obviously this would be a pretty strange thing to do, but the interface
>> does allow it and so it ought to be nicely handled.  Currently it is not!
>> That one has been at the bottom of the todo list for a long time.
>>
>> The new buffer would have an event chrdev from which a new type of event
>> can be read (not sure on naming, something like BUFFER_CAPTURE_EVENT_FINISHED)
>> It would also have an access chrdev as per the software ring you have
>> been using so far.  This access chrdev will read directly (via spi) from the
>> buffer on the device.  A while back there was some discussion about whether
>> devices like these (with hardware buffering) should always feed into an
>> intermediate software buffer.  Personally I don't think they need to and
>> if we decide otherwise this can always be added at a later date.
>>
>> Obviously there would be a number of new abi elements introduced that might
>> well generalize over a range of devices, so if you go this way please propose
>> them formally on the list (and possibly also lkml) for discussion.
>>
>> Thanks,
>>
>> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

