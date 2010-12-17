Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45706 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534Ab0LQOtd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2010 09:49:33 -0500
Message-ID: <4D0B7888.6050007@cam.ac.uk>
Date: Fri, 17 Dec 2010 14:49:44 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: different ring buffer usage scenario
References: <544AC56F16B56944AEC3BD4E3D591771324BEA42CB@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324BEA42CB@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/17/10 13:47, Hennerich, Michael wrote:
> Hi Jonathan,
> 
> I'm currently working on a high speed ADC driver, that requires a different ring buffer use case scenario.
> Let me explain a little bit the setup. I'm running Linux on a Microblaze softcore inside an Virtex6 FPGA.
> Part of the system is a peripheral interface block, we call it the ADC Interface Module (AIM).
> External to the FPGA we connect a single channel high speed ADC AD9649, to the AIM signals.
> 
> The AIM features a FIFO, with watermark interrupt capabilities. There are two modes that need to be supported.
> Continues Sampling Mode and Single Shot Sample Mode. In Single Shot Sample Mode, the user reads an arbitrary
> Number of samples from the ADC, and then the sampling stops. This mode does not need to have a ringbuffer at all.
> A simple chardev might be sufficient.
> 
> Any objections creating a driver private chardev?
None at all.
Is it appropriate to maintain the interfaces and buffer description we have for those where there
is a buffer involved?  I think those interfaces are flexible enough... If not we probably
want to make it so they are.

I did think of creating a pass through buffer that would effectively allow other devices
to simulate this behaviour. Basically to the core it would look like a buffer, but it
would only store one scan and then only if someone has the chrdev open. It would support select type
calls. This would be needed for the input bridge to no apply any delay to the data stream.

Not actually done any work on it though.
> 
> In Continues Sampling Mode we store continuously data into the ringbuffer, and assume that userspace reader can catch up.
> Now looking at the existing sw_ring, we don't need the scan element
> concepts, no timestamps and bytes_per_datum is going to be used in a
> different fashion.
Interface wise I'd still like to see the attrs indicate the scan elements etc (though there will only
be one).  That way the userspace code can work with this alongside devices that need that support.
The scan element attributes should obviously be read only.
Certainly no need to support timestamps. Just don't add the relevant scan element attribute.
> Ideally bytes_per_datum defaults to the ADC width.
The datum in this case corresponds to a single reading so I think that would be the case.
> However right now it is used to set the number of bytes stored into the ring by a call to ring->access.store_to().
> bytes_per_datum currently must be constant while the ring is enabled.
> However we need to store an arbitrary number of elements into the buffer.
Ah, I see what you mean. You need a store_n rather than a store_1 facility on the buffer.
> 
> Following example:
> The AIM internal fifo can hold 512 elements, we set the fifo almost
> full watermark to 400 elements. In the ISR we read the number of
> elements that are currently in the fifo. This number will be > the
> fifo almost full watermark (e.g. 400 elements) but likely less than
> the fifo size.
(aside) As a practical point of view I'd be inclined to not bother checking what
is there.  Just read your 400 then wait for the interrupt to occur again. I would
think that will be sufficient to ensure you don't loose data.
> 
> Do you think it is possible to modify iio_store_to_sw_ring(), without breaking the implementation, to support this kind of use?
Lets add a new function for this rather than modifying the current one.
If we add an op to those in the generic buffer structure we can have some buffer implementations support
this and some not.

We really need to replace that ring buffer. I haven't looked at how the unified
ring buffer code (from tracing etc) is going recently. Kfifo would work but is
a little clunky for our normal use cases.

In the meantime I don't think there is any fundamental reason why we can't do
a iio_store_to_sw_ring_n. It does get a bit more complex though as we will
have write sets of records that overlap the loop point of the ring.

This particular case fits rather better than our normal ones into using the kfifo
buffers.  The advantage is we know our record length and it never changes so we
can cleanly use kfifo_in and friends to handle your case.  I did post a proof
of concept for using kfifo a while back but it used dynamic records and hence
wouldn't be suitable here.  Looks like that should be revisited. Perhaps we can get
reasonable support and performance by just using a single byte fifo element and
handling record sizes ourselves.

Jonathan
