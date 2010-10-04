Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48638 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0JDKNw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 06:13:52 -0400
Message-ID: <4CA9AA2B.8040507@cam.ac.uk>
Date: Mon, 04 Oct 2010 11:19:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike R9FT <mike.r9ft@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	drivers@analog.com
Subject: Re: dac5624 driver
References: <AANLkTi=17PHUZFi=-HqYqydF7cE20bwwAqtAar0cC6Xa@mail.gmail.com>
In-Reply-To: <AANLkTi=17PHUZFi=-HqYqydF7cE20bwwAqtAar0cC6Xa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/10 06:18, Mike R9FT wrote:
> Hi,
> 
> I am tried to work with this driver. It works, but I need more
> performance. For example, I whant update output with 400 Hz frequency.
> What I need? May be RING buffering should be implemented or any? Can
> anyboody tell me, please. Thanks.
>
Hi Mike,

I'm guessing (after a bit of checking relevant trees) that you are referring
to the ad5624r driver from the blackfin tree?  I've cc'd Analog who are
responsible for that driver.  They will probably be pleased to here someone
is using that driver!

So far, despite the name, we have done very little with output drivers. The
buffering that is currently implemented is all tied to input drivers.

Looking quickly at the driver, it has only sysfs attributes for writing the
values so it was never designed for speedy changes.

We did have a few discussions about how to go about handing buffering to dacs
but I don't think anything was ever implemented.

>>From what I recall it came down to the question of how to synchronise the
underlying spi transfers (which are typically done with dma). Without doing
that in some fashion, at best we would get a fairly unpredictable wave form
out of the dac.  Right now the archive (marc.info) isn't responding, so I can't
give you a direct link to the thread...  The email in question is from
Barry Song and is entitled Re: IIO ring buffer (3/3/2010).

He mentions the exact chip you are using and says that it has an internal buffer
and suggests a rough methodolgy...  Lets cut and paste roughly the relevant parts...


> On Thu, Mar 4, 2010 at 8:33 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> >
>> > Hi Barry,
>> >
>> > Sorry for the slow reply, been busy with the whole ALS thing
>> > (see lkml if you are interested) and chasing down some rtc issues.
>> >
>> > On 03/03/10 03:26, Barry Song wrote:
>>> > > DACs like AD5624R/5644R/5664R(http://www.analog.com/en/digital-to-analog-converters/da-converters/ad5624r/products/product.html)
>>> > > have no clock input and internal buffer. Some users maybe use it to
>>> > > get discrete analog signals, that means once one data is written to
>>> > > AD5624R, one new analog signal is output, then we don't need ring
>>> > > buffer.
>> > Makes sense, I guess for these we provide a sysfs type interface.
>>> > > But some other users maybe want the AD5624R to create
>>> > > continuous signals with a fixed frequency, then we need use ring
>>> > > buffer with linked DMA to input data to AD5624R with a constant rate.
>>> > > This case is same with audio play.
>>> > > To implement that, we need
>>> > > 1. Split ring buffer to some little fragments, one fragment is a DMA block.
>> > Makes sense, though we probably need to be a little careful
>> > as not spi implementations are going to do this via dma.
>>> > > 2. Ring buffer core layer must handle the play pointer and user
>>> > > writing pointer, stop the DMA automatically when user data under-run
>>> > > flows( valid data is less than one fragment in ring buffer)
>> > Probably a fifo rather than a ring buffer, but it doesn't change your
>> > point! At the moment I'm not seeing much shared functionality with the
>> > rest of IIO.  Perhaps we treat DAC elements in a similar way to triggers?
>> > That is a device may register them without registering anything else.
>> > Will keep matters nice and slim if we have devices such as this one that
>> > don't have any inputs.  The only disadvantage I can see is when we have
>> > interesting interactions between the dac's and inputs (such as a feedback
>> > channel).
> It should be a hardware ring buffer because we must have allocated it
> by consistent way ahead. The buffer has been ready and DMA link has
> been built when we begin any transfer. Sorry, i don't understand
> clearly about treating DACs as trigggers you said, here i think we
> only need interrupts/callbacks to update playback pointers.
I simply meant that one can treat them as effectively independant from
the core iio_device structures seeing as there is almost no shared functionality.
Thus a driver can register any of: iio_device (we may need to rename!), iio_trigger
and iio_dac.  In a similar way to the triggers a dac might be a child of an
iio_device, but also might exist on it's own if none of the other functionality
is needed (i.e. it is just a dac).

>> >
>>> > > 3. The DMA interrupt handler in the bottom driver should update the
>>> > > play pointer by a ring buffer core API to notify the play status.
>>> > > 4. The DMA should support  linked mode, once one DMA block is
>>> > > finished, another DMA fragment will be enabled by hardware
>>> > > automatically except that it is disabled due to underflow.
>> > The complexity I can see here is interacting with the underlying bus.
>> > It may be that we need to propose some changes to the spi infrastructure,
>> > it order to get the hooks you are referring to.  I'm really not keen in
>> > reinventing the wheel and providing bus interfaces within IIO.
>> > If we have new buses or new requirements for existing bus subsystems,
>> > we should propose them separately. They will almost certainly be of use
>> > elsewhere anyway!
> It maybe makes sense too to change current spi drivers. spi async mode
> can help if we change blackfin sport spi
> driver(http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/?action=browse&path=%2Ftrunk%2Fdrivers%2Fspi%2Fbfin_sport_spi.c&view=markup&revision=8051)
> to use linked DMA. DAC drivers only call spi_async and use the spi
> completion callback to update playback pointer. And sport spi driver
> manages the DMA link and keep the spi acccess running if there are
> still spi messages.
That sounds sensible (though I haven't looked at the specifics).
If possible make sure you maintain support for devices not capable
of using linked dma though.  I would suggest putting together an
example and proposing some suitable interfaces to be added to the spi
core (we can tackle other buses as they come up!)

> The performance should be better if current spi can be improved to
> support block mode but not manage spi transfer by single spi message.
> The same problem will happen to i2c bus if there are similar DACs using i2c bus.
>> >
>> > I've cc'd David and Grant to see if they have any initial comments on
>> > this or are aware of people doing similar stuff.  (it's all a bit
>> > vague at the moment for a post to the spi mailing list).  Maybe
>> > it is possible already to do this?  Certainly looks like this is the
>> > first area to investigate to me.
>> >
>> > Thanks,
>> >
>> > Jonathan
>> >

The spi guys never replied. Perhaps it is time to raise the issues from this
thread again.

I'm afraid I don't have any devices capable of doing this sort of synchronized
buffered output, so I can only offer rough advice on how to do it!

Jonathan
