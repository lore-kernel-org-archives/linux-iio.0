Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40521 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbaKRNYK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Nov 2014 08:24:10 -0500
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
From: jic23@kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
Date: Tue, 18 Nov 2014 13:24:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20141118132405.EF30A40277@saturn.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Octavian Purdila writes: 

> Hi everybody,
Hi Octavian.
> 
> I hope this RFC is a good starting point to discuss support for
> hardware fifo in IIO. The main reason to support it is to reduce the
> power consumtion, by allowing the CPU to enter deep sleep states for
> longer periods of time.
A worthwhile aim indeed.
> 
> Don't get discourage by the large number of patches most of them are
> refactors in the bmc150 driver, to make it easier to add support for
> the hardware fifo (basically to make adding interrupts and
> events/triggers easier). 
> 
> For discussing the hardware fifo stuff, only the first and last
> patches are important: the first adds new IIO attributes so that we
> can expose the hardware fifo and the last implements hadware fifo for
> IIO (as an example of how would a device use the exposed attributes). 
> 
> Note that the attributes can be exposed on a per device or per channel
> basis, since it seems both types of hardware fifos exists: those that
> store all data in a single fifo (temperature, accelerometer,
> magnetometer, etc.) and those that have separate fifos for
> accelerometer, gyroscope, etc. Thankfully, at the driver level we just
> need to use the appropriate sharing level to support one mode or the
> other.
If this is the case, then the buffered outputs will have to be separate
so we know what is coming.  E.g. it will have to be effectively treated
as separate iio_buffers.  Now we have devices that already do (see some
of the more interesting SOC ADCs) 

Is this actually the case for the bmc150? If you could point at
devices where it is then it would be great (as mentioned above one
or two SOC ADCs have a bonkers level of flexibility).
My reading of the datasheet is that the data is interleaved in the
buffer for any channels enable. 

> 
> Also note that this patch is orthogonal to the software watermark /
> batching patch send on the list a while back.

I'm not so sure this is orthogonal at all.   That proposal was actually
about hardware support.  I pushed back that I wanted any new interface
to work whether or not there was hardware support.  In a sense that is
a more complex problem - hence the discussion became a little bit focused
on that case. 

The intent there was to hide the implementation details of exactly this
sort of hardware/software buffer interaction. 

Perhaps some history is in order. 

We had exactly what you propose here a long time back with the sca3000
accelerometer (which is why there is still core support for hardware
buffers).  The interface was precisely the watershed type you have
here. 

A review by Arnd Bergman pointed out that this was seriously clunky. 

It puts data related to the in-band data flow into our out-of-band channel.
His suggestion was to allow for watershed interrupts using one of the
more interesting POLL types leaving the main poll for the data flow.
Arnd also suggested the bits about using anonymous chardevs for the event
reporting etc.  The unusual form of poll bit never got implemented,
but in the interests of moving forward with the common case and because
they were on there way out anyway the watershed interrupts were dropped. 

The more recent discussion came to the conclusion that there was no need
to use the weird forms of poll.  We could simply have an attribute to
control when poll was fired.  The only bit that caused friction was whether
there should be a timeout or not. 

Now, when then ti_am35xx driver came along it became clear that it wasn't
actually terribly useful exposing the hardware buffers directly to
user space.  The buffers tend not to be terribly long (in your bma160) I
see they are only 32 elements.  As such the conclusion was that it makes
more sense to use the buffers as temporary storage to smooth out the
data flow.  Thus that driver fills a software buffer from a hardware
buffer.  This seems the method that is most likely to work long term.
I note this is effectively what you have here, though I'm not sure of
the advantage of the explicit software flush over just reading the data
whenever the interrupt fires. 

Hence we started with something that at least superficially (I haven't
had a chance to go through the implementation in detail yet)
looks similar to what you have but ended up changing the method of
signalling to and from userspace. 

Hardware buffer -> Software buffer -> user space. 

Userspace watershed control -> Software buffer watershed control
 -> Hardware buffer watershed control. 

If userspace sets the watershed to say 16 then, as well as setting
that level in the software buffer it should be passed on to the
device driver allowing the watershed there to be set appropriately.
Now things get interesting if userspace sets the watershed to a value
that makes no sense for the hardware (say 17 on a device that does
power of 2 values only) as then it will have to fall back to
grabbing every one (Watershed of 1).  Perhaps we can provide 'hints'
for this? 

Anyhow, having given this general comment, I'll give some feedback on
the implementation details. 

Jonathan 

> 
> Octavian Purdila (8):
>   iio: add support for hardware fifo
>   iio: bmc150: refactor slope duration and threshold update
>   iio: bmc150: refactor interrupt enabling
>   iio: bmc150: exit early if event / trigger state is not changed
>   iio: bmc150: introduce bmc150_accel_interrupt
>   iio: bmc150: introduce bmc150_accel_trigger
>   iio: bmc150: introduce bmc150_accel_event
>   iio: bmc150: add support for hardware fifo 
> 
>  Documentation/ABI/testing/sysfs-bus-iio |  51 ++
>  drivers/iio/accel/bmc150-accel.c        | 976 ++++++++++++++++++++++----------
>  drivers/iio/industrialio-core.c         |   2 +
>  drivers/iio/industrialio-event.c        |   2 +
>  include/linux/iio/iio.h                 |  17 +
>  include/linux/iio/types.h               |   2 +
>  6 files changed, 739 insertions(+), 311 deletions(-) 
> 
> -- 
> 1.9.1 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
