Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbdGWMOR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Jul 2017 08:14:17 -0400
Date: Sun, 23 Jul 2017 13:14:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
Subject: Re: DMA support for at91-sama5d2 ADC driver
Message-ID: <20170723131413.4a7129c9@kernel.org>
In-Reply-To: <bbcae099-6a22-bbf1-c7d4-a8ff7e339c4f@microchip.com>
References: <EA573BDD7CF69549972F7393812B404A558EA7@CHN-SV-EXMX03.mchp-main.com>
        <E01FD574-0ED8-4207-B589-065806ADC592@kernel.org>
        <bbcae099-6a22-bbf1-c7d4-a8ff7e339c4f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 19 Jul 2017 10:25:33 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Hello Lars, Jonathan,
> 
Lars is definitely a better person to reply to this
than me, but I'll have a go!
> After I had a deeper look into the DMA support in IIO,
> it looks to me like there are few distinct options to
> achieve this:
> 
> 1) Have a regular triggered kfifo buffer.
> Prepare dma transaction on buffer post-enable.
> Configure dma slave at probe.
> Trigger is already setup on buffer enable, so we have to just do
> trigger_poll on dma complete. Check the residues and push to iio_buffer
> all at once from the dma coherent buffer.
> Have a hwfifo in sysfs for the buffer. Use it to configure dma
> enable/disable and the dma buffer size for chunk conversions.
> With hwfifo disabled, just use regular kfifo triggered buffer with
> IRQ for each conversion.
When using the trigger infrastructure to do dma triggering not
it breaks with the 'standard' meaning of the individual
triggers.  As such it become necessary to restrict the
use of the trigger to just this one device (then no one cares
that the frequency is wrong).

Timestamps can also become really complicated to generate
with any accuracy.  Anyhow, this is all stuff other drivers
are handling so copy them.
> 
> 2) Here is the tricky part with the usage of the DMA-buffer.
> We can try to use this approach, and have the block size considering
> the hwfifo sysfs attribute.
> But this means we have to ditch the kfifo buffer. We can try to use a
> regular trigger on submit callback such that no DMA is involved. Then
> get the IRQ for each conversion and call the block done callback once
> the IRQ is received.
> If we have the hwfifo enabled, just prepare a DMA transaction and be
> done with it.
Triggers really have very little meaning once you are using the
dma-buffer infrastructure.  Lars is working on some more complex
handling for this, but I have no idea what stage that work is at.

You are right that it is an either kfifo or dma buffer choice.
Mostly the dma-buffer stuff is for very fast devices where the
overheads of the kfifo handling really matter and hence the
kfifo doesn't make any sense at all.
> 
> 3) Use the DMAengine buffer. Is this possible ? It looks like this
> option is the least configurable and cannot use both DMA and non-DMA
> transactions.
> 
> As it looks to me, we either start from a kfifo and add DMA support
> to it, or we start from a DMAbuffer and add non-dma to it.
> I am not sure which way is best to go, but, it is required that we can 
> enable or disable the hwfifo (DMA) from sysfs, so the buffer must be
> able to support both ways. However we can only expose one type of
> buffer to the iio device.
Explicitly disable it or do it using the hints of the
watershed for example to work out whether low latency is required or
not.

My gut feeling here is that for SoC ADCs in general the kfifo
fed by dma is the best compromise.  Only real question is
whether we can cope with 1MSPS using that approach.

Jonathan
> 
> Any opinion is appreciated,
> Thanks,
> Eugen
> 
> On 04.05.2017 19:21, Jonathan Cameron wrote:
> > 
> > 
> > On 4 May 2017 14:07:19 BST, Eugen.Hristev@microchip.com wrote:  
> >> Hello,
> >>
> >> I am making a proof of concept for DMA functionality for the
> >> at91-sama5d2 ADC driver.
> >> I would like to ask if it's better to implement in an old fashion way
> >> (request dma channel, allocate memory, start transfer), or try to
> >> integrate with the DMA-buffer in the iio subsystem ?
> >> Is there any driver using that system in the current kernel ?  
> > Lars?
> >   
> >>
> >> Also, is there a way to enable/disable DMA coming from the subsystem to
> >> the driver ? (I mean from sysfs, to have or create an option for the
> >> buffer to use DMA or not).
> >> Using DMA has the advantage of less interrupts coming, but much less
> >> granularity on the incoming triggered conversions. So I thought a way
> >> for the user to enable or disable it might be convenient.  
> > Use the fifo watermark stuff perhaps?
> > If set high enough use DMA, if lower then don't.
> > 
> > Complexity around triggering however. Generally DMA pushed to kfifo is done without triggers as
> > there is no per scan interrupt to hang other devices off.  Also no timestamps...  
> >>
> >>
> >> Thanks for all the inputs,
> >>
> >> Eugen Hristev
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> >   

