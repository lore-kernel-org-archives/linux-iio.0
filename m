Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35755 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcEDOg7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:36:59 -0400
Subject: Re: [RFC] iio: Add support for describing scan offsets in buffer ops
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <5728A9B5.6080902@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <a9f31cb3-07f8-b0dd-4eab-89f29e3fed98@kernel.org>
Date: Wed, 4 May 2016 09:44:27 +0100
MIME-Version: 1.0
In-Reply-To: <5728A9B5.6080902@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/16 14:37, Crestez Dan Leonard wrote:
> Hello,
> 
> This is a tentative proposal with no code attached. This issue came up
> while hacking on the mpu6050 driver but it applies to other complex
> devices and a solution belongs in the IIO core.
I'm not so convinced (yet).  This is actually a fairly unusual case and the
'byte mangling' can often be handled in a relatively fixed way in a
driver whereas it can be more complex in the core.

Interesting idea though..  Effectively you are hand specifying the
demux tables that we generate and making them more flexible.
> 
> One IIO limitation is that while samples can be described through a
> relatively generic scan_type they must be placed in the output buffer
> according to an specific iio alignment algorithm. For example if the
> device has one 16bit channel and one 32bit channel the output needs to
> have 16bits of padding between them. When this does not match the
> hardware format the solution is for the driver to unpack the hardware
> samples and repack them in the iio format.
It's pretty much got to happen somewhere to get the data into a form that
can be used at speed. Remember we are doing this on the back of expensive
bus transactions (a lot of the time).
> 
> I propose that we add a new function in iio_buffer_setup_ops which looks
> like this:
> 
> int (*get_scan_offsets)(struct iio_dev *indio_dev,
>                         off_t *scan_offsets,
> 			size_t *sample_bytes);
> 
> This would be called when enabling a buffer to fetch the offset in the
> sample for each channel (by scan_index) based on the currently
> configured scan mask. Then the iio core would then handle rearranging
> sample bytes as expected by the buffer consumer. Driver implementations
> could look something like this:
> 
> off_t pos = 0;
> if (scan_mask & (1 << SCAN_INDEX_TEMP))) {
>     scan_offsets[SCAN_INDEX_TEMP] = pos++;
> }
> /* No 2-bytes alignment here! */
> if (scan_mask & SCAN_MASK_ACCEL_ANY) {
>     scan_offsets[SCAN_INDEX_ACCEL_X] = pos + 0;
>     scan_offsets[SCAN_INDEX_ACCEL_Y] = pos + 2;
>     scan_offsets[SCAN_INDEX_ACCEL_Z] = pos + 4;
>     pos += 6;
> }
> *sample_bytes = pos;
Sure - this side is straight forward enough.  It's the core complexity
that makes me wonder if this is worthwhile.  Btw if this is worth doing
then we should really be looking at non byte aligned packed records as
well (just to make it really hideous!)

The killer in here is endian requirements. If the core is repacking data
it will need to understand these completely.  Two options exist, either
the core needs to 'edit' the shift provided by the driver, or it needs
to do endian dependent data realignment.

Take a typical 3 byte unaligned packed record being expanded to a
4 byte aligned record.  I think the easy cases are:

ABC -> 0ABC
CBA -> CBA0
so endian dependent shifts.

Whereas a repack in the driver should inherently know what the right combination
should be. 

I'm not saying it couldn't be done in the core of course, merely that
it is more complex that it initially looks.

I've already suggested we might look at doing a few 'special cases'
to relax the power of two requirement - but I'd do that off the back of
the current description rather than introducing another.  It does have
the same complexity issues though so until we have code I'm
unconvinced it is worth it.

> 
> This could be implemented as an extension to the current buffer demuxing
> support which currently only deals with differences in scan_masks. This
> mechanism would very nicely deal with devices where it is not possible
> to select X/Y/Z individually because the iio core would just ignore the
> gap in offsets.
> 
> This can even be exposed to userspace in a compatible manner. User would
> do something like:
> 
>     ioctl(iio_fd, IIO_USER_HANDLES_SCAN_OFFSETS, 1);
>     ioctl(iio_fd, IIO_GET_SCAN_OFFSETS, &scan_offsets, &sample_bytes);
> 
> When the consumer is marked as aware of scan offsets this way the iio
> core can skip demuxing for increased performance. The IIO core can
> implement IIO_GET_SCAN_OFFSETS itself when the driver has no custom
> implementation. An application could rely on IIO_GET_SCAN_OFFSETS for
> all devices as long as it's acceptable to ignore old kernels.
Be careful here. The demux wasn't actually written in the first
place for this usage at all (it was an added bonus)

It's about sending different streams
of data to different consumers. That is definitely not compatible
with passing this stuff up to user space as it's downright complex
to do.  Making in kernel consumers aware of this more complex handling
is going to be fiddly.  Again could be done, but is it worth it?
I suppose we could make the demux aware of what it is sending to, but
that adds more complexity.
> 
> This would be particularly useful if IIO sample buffers are
> memory-mapped eventually. I think that this extension would be
> incrementally useful to that effort.

Perhaps.  I'm interested to hear other views on this suggestion, but
right now I'm not convinced.  I'd argue that we want clean data
presentations to userspace and that the restrictions as they currently
stand are not really that burdensome on the data.

The exception is dma buffers - in those cases it really might be the
case that we want to allow more complex alignment.

Right now there is no option to have multiple consumers for a dma
buffer and I'm not sure there ever will be.  However, they don't
fall into categories where we use the multiconsumer stuff now
(which is mostly about SoC ADCs with lots of different types of
channel for things like thermal / battery monitoring - there are
other issues there between polled and pushed data flows, but that
is a whole different issue!)

Hence for DMA buffers there is no need to enforce the power of
two byte alignment requirements though, the first time this
happens we should think carefully about whether we 'want' to
allow the additional flexibility.

Jonathan
 

