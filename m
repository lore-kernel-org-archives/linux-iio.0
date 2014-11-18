Return-Path: <lars@metafoo.de>
Message-ID: <546B769D.1060204@metafoo.de>
Date: Tue, 18 Nov 2014 17:41:01 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: jic23@kernel.org, Octavian Purdila <octavian.purdila@intel.com>
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: Re: [RFC 0/8] iio: add support for hardware fifo
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com> <20141118132405.EF30A40277@saturn.retrosnub.co.uk>
In-Reply-To: <20141118132405.EF30A40277@saturn.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/18/2014 02:24 PM, jic23@kernel.org wrote:
> Octavian Purdila writes:
>> Hi everybody,
> Hi Octavian.
>>
>> I hope this RFC is a good starting point to discuss support for
>> hardware fifo in IIO. The main reason to support it is to reduce the
>> power consumtion, by allowing the CPU to enter deep sleep states for
>> longer periods of time.
> A worthwhile aim indeed.
>>
>> Don't get discourage by the large number of patches most of them are
>> refactors in the bmc150 driver, to make it easier to add support for
>> the hardware fifo (basically to make adding interrupts and
>> events/triggers easier).
>> For discussing the hardware fifo stuff, only the first and last
>> patches are important: the first adds new IIO attributes so that we
>> can expose the hardware fifo and the last implements hadware fifo for
>> IIO (as an example of how would a device use the exposed attributes).
>> Note that the attributes can be exposed on a per device or per channel
>> basis, since it seems both types of hardware fifos exists: those that
>> store all data in a single fifo (temperature, accelerometer,
>> magnetometer, etc.) and those that have separate fifos for
>> accelerometer, gyroscope, etc. Thankfully, at the driver level we just
>> need to use the appropriate sharing level to support one mode or the
>> other.
> If this is the case, then the buffered outputs will have to be separate
> so we know what is coming.  E.g. it will have to be effectively treated
> as separate iio_buffers.  Now we have devices that already do (see some
> of the more interesting SOC ADCs)
> Is this actually the case for the bmc150? If you could point at
> devices where it is then it would be great (as mentioned above one
> or two SOC ADCs have a bonkers level of flexibility).
> My reading of the datasheet is that the data is interleaved in the
> buffer for any channels enable.
>>
>> Also note that this patch is orthogonal to the software watermark /
>> batching patch send on the list a while back.
>
> I'm not so sure this is orthogonal at all.   That proposal was actually
> about hardware support.  I pushed back that I wanted any new interface
> to work whether or not there was hardware support.  In a sense that is
> a more complex problem - hence the discussion became a little bit focused
> on that case.
> The intent there was to hide the implementation details of exactly this
> sort of hardware/software buffer interaction.
> Perhaps some history is in order.
> We had exactly what you propose here a long time back with the sca3000
> accelerometer (which is why there is still core support for hardware
> buffers).  The interface was precisely the watershed type you have
> here.
> A review by Arnd Bergman pointed out that this was seriously clunky.
> It puts data related to the in-band data flow into our out-of-band channel.
> His suggestion was to allow for watershed interrupts using one of the
> more interesting POLL types leaving the main poll for the data flow.
> Arnd also suggested the bits about using anonymous chardevs for the event
> reporting etc.  The unusual form of poll bit never got implemented,
> but in the interests of moving forward with the common case and because
> they were on there way out anyway the watershed interrupts were dropped.
> The more recent discussion came to the conclusion that there was no need
> to use the weird forms of poll.  We could simply have an attribute to
> control when poll was fired.  The only bit that caused friction was whether
> there should be a timeout or not.
> Now, when then ti_am35xx driver came along it became clear that it wasn't
> actually terribly useful exposing the hardware buffers directly to
> user space.  The buffers tend not to be terribly long (in your bma160) I
> see they are only 32 elements.  As such the conclusion was that it makes
> more sense to use the buffers as temporary storage to smooth out the
> data flow.  Thus that driver fills a software buffer from a hardware
> buffer.  This seems the method that is most likely to work long term.
> I note this is effectively what you have here, though I'm not sure of
> the advantage of the explicit software flush over just reading the data
> whenever the interrupt fires.
> Hence we started with something that at least superficially (I haven't
> had a chance to go through the implementation in detail yet)
> looks similar to what you have but ended up changing the method of
> signalling to and from userspace.
> Hardware buffer -> Software buffer -> user space.
> Userspace watershed control -> Software buffer watershed control
> -> Hardware buffer watershed control.
> If userspace sets the watershed to say 16 then, as well as setting
> that level in the software buffer it should be passed on to the
> device driver allowing the watershed there to be set appropriately.
> Now things get interesting if userspace sets the watershed to a value
> that makes no sense for the hardware (say 17 on a device that does
> power of 2 values only) as then it will have to fall back to
> grabbing every one (Watershed of 1).  Perhaps we can provide 'hints'
> for this?

Fully agreed, I do have a accelerometer in the pipeline which has a built-in 
FIFO and the plan was to do exactly what you just described. Pick up the 
watershed patches and then configure the FIFO threshold level according to 
the configured level.

In my opinion the internal FIFO in a device should be as transparent to 
userspace as possible. E.g. instead of having to separately flush the FIFO 
the FIFO should be flushed when the buffer is enabled, etc.

- Lars
