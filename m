Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47851 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967659AbaLLMwX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 07:52:23 -0500
Message-ID: <548AE501.7060602@kernel.org>
Date: Fri, 12 Dec 2014 12:52:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>	<20141118132405.EF30A40277@saturn.retrosnub.co.uk> <CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>
In-Reply-To: <CAE1zotJny3-Zcd81HUYNpNZJHkt=t6e2TANzVQ=-FU239MLarw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/14 15:03, Octavian Purdila wrote:
> On Tue, Nov 18, 2014 at 3:24 PM, <jic23@kernel.org> wrote:
>>
>> Octavian Purdila writes:
>>>
>>> Hi everybody,
>>
>> Hi Octavian.
>>>
> 
> Hi Jonathan,
> 
> Thanks for taking the time to look at this and for the detailed
> feedback. I am new to IIO, so I may not understand your comments
> fully, hope you will have patience with me :)
> 
>>>
>>> I hope this RFC is a good starting point to discuss support for
>>> hardware fifo in IIO. The main reason to support it is to reduce the
>>> power consumtion, by allowing the CPU to enter deep sleep states for
>>> longer periods of time.
>>
>> A worthwhile aim indeed.
> 
> BTW, the larger context into which we are looking at this, is the new
> batching Android API:
> 
> http://source.android.com/devices/sensors/batching.html
> 
>>>
>>>
>>> Don't get discourage by the large number of patches most of them are
>>> refactors in the bmc150 driver, to make it easier to add support for
>>> the hardware fifo (basically to make adding interrupts and
>>> events/triggers easier).
>>> For discussing the hardware fifo stuff, only the first and last
>>> patches are important: the first adds new IIO attributes so that we
>>> can expose the hardware fifo and the last implements hadware fifo for
>>> IIO (as an example of how would a device use the exposed attributes).
>>> Note that the attributes can be exposed on a per device or per channel
>>> basis, since it seems both types of hardware fifos exists: those that
>>> store all data in a single fifo (temperature, accelerometer,
>>> magnetometer, etc.) and those that have separate fifos for
>>> accelerometer, gyroscope, etc. Thankfully, at the driver level we just
>>> need to use the appropriate sharing level to support one mode or the
>>> other.
>>
>> If this is the case, then the buffered outputs will have to be separate
>> so we know what is coming.  E.g. it will have to be effectively treated
>> as separate iio_buffers.  Now we have devices that already do (see some
>> of the more interesting SOC ADCs)
>> Is this actually the case for the bmc150? If you could point at
>> devices where it is then it would be great (as mentioned above one
>> or two SOC ADCs have a bonkers level of flexibility).
>> My reading of the datasheet is that the data is interleaved in the
>> buffer for any channels enable.
>>
> 
> While working on this I did though about exposing the hardware fifo by
> implementing a custom iio bufer. However, the iio buffers are much
> more flexible that most hadware fifos. In bmc150' case, the fifo case
> store x,y,z data or x or y or z data. It can not store x,y or x,z,
> etc. And if I understand correctly, the user can enable x,z collection
> for the device buffer. Also I have noticed that there can be multiple
> buffers attached to a device, for what it seems to be demuxing
> buffers?
The demuxing is also used to allow handling the x,y cases etc you have
above.  Available_scan_masks sets which things the hardware supports, then
the demux will rip out the elements actually requested by userspace.

The other use is the inkernel 'push' interface.  The original target
was an iio to input bridge, but I got side tracked and no one else
has yet picked up that driver (google will find it for you) and pushed
it through the last few things needed to make it a nice input driver.
The biggest nasty corner is no one likes the iio_hwmon dt bindings and
at the moment the iio_input ones would be similar.  Other options
exist for setting up these links (configfs perhaps?) but nothing much
has happened on that front.  I have some configfs patches for other
userspace setup tasks - particularly creating sysfs based triggers etc
but those aren't ready to go yet either!

> 
> That is why I thought of keeping the hardware fifo decoupled from the
> buffers and add a flush operation that will read the data from the
> fifo and push it to the device buffer(s). This way we don't affect the
> demuxing buffers logic.
Yes. I think we'll need to do something like that - just with a different
userspace interface to trigger this attempt to fetch extra data.
> 
>>>
>>> Also note that this patch is orthogonal to the software watermark /
>>> batching patch send on the list a while back.
>>
>>
>> I'm not so sure this is orthogonal at all.   That proposal was actually
>> about hardware support.  I pushed back that I wanted any new interface
>> to work whether or not there was hardware support.  In a sense that is
>> a more complex problem - hence the discussion became a little bit focused
>> on that case.
>> The intent there was to hide the implementation details of exactly this
>> sort of hardware/software buffer interaction.
> 
> The reason I say they are orthogonal (IMHO) is that the software
> watermark patch will only help reducing the number of kernel/user
> context switches by allowing more data to gather before waking up
> userspace. However, we will still have interrupts waking up the
> processor to store the samples in the kernel buffer. With a hardware
> fifo we can reduce that number of interrupts.
Sure - but there is nothing stopping us having the same interface for
both cases.
> 
>> Perhaps some history is in order.
>> We had exactly what you propose here a long time back with the sca3000
>> accelerometer (which is why there is still core support for hardware
>> buffers).  The interface was precisely the watershed type you have
>> here.
>> A review by Arnd Bergman pointed out that this was seriously clunky.
>> It puts data related to the in-band data flow into our out-of-band channel.
>> His suggestion was to allow for watershed interrupts using one of the
>> more interesting POLL types leaving the main poll for the data flow.
>> Arnd also suggested the bits about using anonymous chardevs for the event
>> reporting etc.  The unusual form of poll bit never got implemented,
>> but in the interests of moving forward with the common case and because
>> they were on there way out anyway the watershed interrupts were dropped.
> 
> You lost me here :) but I will look for that discussion and try to
> understand Arnd's review.
In short we did the way you suggest (more or less) before and decided it
was a bad route long run ;)
> 
>> The more recent discussion came to the conclusion that there was no need
>> to use the weird forms of poll.  We could simply have an attribute to
>> control when poll was fired.  The only bit that caused friction was whether
>> there should be a timeout or not.
>> Now, when then ti_am35xx driver came along it became clear that it wasn't
>> actually terribly useful exposing the hardware buffers directly to
>> user space.  The buffers tend not to be terribly long (in your bma160) I
>> see they are only 32 elements.
> 
> As I mentioned before, the main gain of using hardware fifo is to
> reduce the number of interrupts. Right now, if we have a rate of 25HZ
> we will get 25 interrupts per second. With hardware fifos we can
> reduce that significanlty, and even small buffers help.
Of course, that is why the hardware support is again becoming more common
(there was a phase a few years ago when this was happening, but it seems
it then went away again, probably because android etc didn't care)
> 
> 
>>  As such the conclusion was that it makes
>> more sense to use the buffers as temporary storage to smooth out the
>> data flow.  Thus that driver fills a software buffer from a hardware
>> buffer.  This seems the method that is most likely to work long term.
>> I note this is effectively what you have here, though I'm not sure of
>> the advantage of the explicit software flush over just reading the data
>> whenever the interrupt fires.
> 
> The explicit software flush allows userspace to balance power and
> latency. Userspace can use a timeout based poll to guarantee a maximum
> latency.  If we have enough data then we get an interrupt, we flush
> the fifo and read the data. If not, we get a timeout, we flush the
> fifo and read the data. Perhaps the explicit flush is not optimal and
> we can find out other ways, but in the end we should have a way to
> allow userspace to balance power and latency.
I wonder if we can have a callback in the driver that will be called to
see if more data is available if a 'too large' read is attempted?
Thus to do a full pull, one would simply read the size of the software
buffer + that of the hardware buffer (the maximum data that might be
available somewhere) Or perhaps twice the software buffer length...

Under normal circumstances userspace would never read more than is in
the software buffer so our current case would not change.  However
if needed this would trigger a hardware flush.
> 
>> Hence we started with something that at least superficially (I haven't
>> had a chance to go through the implementation in detail yet)
>> looks similar to what you have but ended up changing the method of
>> signalling to and from userspace.
>> Hardware buffer -> Software buffer -> user space.
>> Userspace watershed control -> Software buffer watershed control
>> -> Hardware buffer watershed control.
>> If userspace sets the watershed to say 16 then, as well as setting
>> that level in the software buffer it should be passed on to the
>> device driver allowing the watershed there to be set appropriately.
>> Now things get interesting if userspace sets the watershed to a value
>> that makes no sense for the hardware (say 17 on a device that does
>> power of 2 values only) as then it will have to fall back to
>> grabbing every one (Watershed of 1).  Perhaps we can provide 'hints'
>> for this?
> 
> As far as I understood, the proposed watermark implementation only
> affects the device buffer and as I mentioned above that will not help
> with reducing the interrupt rate.
> 
Plan was always to do more with it.  Like many nice bits and pieces
it fell by the wayside when the changes requested were very minor...

Ah well,

Jonathan
