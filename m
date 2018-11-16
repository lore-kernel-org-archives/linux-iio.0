Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:58988 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeKQDak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Nov 2018 22:30:40 -0500
Date: Fri, 16 Nov 2018 17:17:22 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Buffers and sampling frequency
Message-ID: <20181116171722.7dfb04bb@archlinux>
In-Reply-To: <9a7e271c-92d5-f8f4-b077-8e24d8d7798f@gmail.com>
References: <9a7e271c-92d5-f8f4-b077-8e24d8d7798f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 14 Nov 2018 09:36:42 -0800
David Frey <dpfrey@gmail.com> wrote:

> Hi,
Hi David,

> 
> I'm trying to add triggered buffer support to the bmi160 IMU driver and
> a question came up that I don't know the answer to.  The driver defines
> an x, y, z channel of type IIO_ACCEL and an x, y, z channel of type
> IIO_ANGL_VEL.  Then within each of these channel definitions,
> info_mask_shared_by_type is set to:
> BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ)
> 
> This means that the driver allows for a different sampling frequency on
> the accelerometer and gyro components.  The chip has a hardware FIFO and
> the chip is configurable whether the FIFO is in headerless or header
> mode.  In header mode the header tells the reader the structure of the
> data.  Here's a relevant snippet from the datasheet
> (https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMI160-DS000-07.pdf):

Yeah. This is an annoyingly common hardware design.  To my mind it's overkill
as the chances of any software actually taking full advantage of different
frequencies of data is fairly low.

Also note that typically sampling frequency controls have additional side
effects in terms of filtering etc which apply to data not coming through
the fifos.

> 
> > In contrast, the header mode is intended for situations where flexibility
>in the data structure is required, e.g. when sensor run at different ODRs or
> when switching sensors on or off on the fly during operation.
  
> 
> Do IIO buffers support the case where multiple channels are enabled
> that have different ODRs (sampling frequencies)?  It seems to me like
> the client on the receiving end of the buffer will receive samples of
> a fixed size equal to the sum of the sizes of all the enabled
> channels and that the client can only look at which channels are
> enabled.  They can't distinguish which channels are populated in the
> current sample.

Indeed you are correct on that but there are ways of handling this if
it actually matters enough.

> 
> Am I correct about this limitation?  If so, what is the suggested
> behavior by the driver?  Should the channel definitions be changed so
> that sampling frequency is info_mask_shared_by_all?  Or should I do
> something like use iio_buffer_setup_ops.validate_scan_mask to validate
> that the sampling frequency is equal for all channels specified by the
> scan_mask?

So, when we first met devices that did this sort of tagged data (which
as you have observed doesn't fit with our data model at all), we did
exactly what you say and had drivers only support a shared data rate
across all their data types (basically don't use the tagged modes).

There is however, one bit exception in tree which offers another (more
complex path), the lsm6dsx.  In that case we actually register multiple
iio devices, one per data type, handle the complexity of bringing them
up appropriately and then push data to the right iio device dependant
on the tag.  I've always been in two minds about this.  One side effect
is you loose the implicit association between channels of different types
and have to align the data using timestamps in userspace which is ugly,
but if we need to support it that is the only way to do it in a model
where we don't carry meta data in the buffer.

Now to support this in the bmi160 which supports (I believe) the
headerless mode already, we would have to continue supporting a single
device, but could potentially have additional auxilliary devices on which
channels can be enabled if you want to have the data with header mode
with uneven sampling frequencies.  It can be done, but it'll make for
a somewhat unexpected userspace interface which is perhaps not a good
thing.  

So the question is whether your question is abstract, or you have a
real usecase that needs the uneven sampling?  Or have you just spotted
a bug with how it currently works and want to fix that (so the frequencies
are in lock when the buffer is enabled?)

> 
> Thanks,
> David

Jonathan
