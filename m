Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39352 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbFXSUm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jun 2015 14:20:42 -0400
Message-ID: <558AF4F7.3090409@kernel.org>
Date: Wed, 24 Jun 2015 19:20:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jeremy Trimble <jeremy.trimble@gmail.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: iio: Multiple iio_buffer per device
References: <CAHYiM2+6wVqLsJTkBqXkumQRp272TMd7SYq4APnHDRDVu2CMGA@mail.gmail.com>
In-Reply-To: <CAHYiM2+6wVqLsJTkBqXkumQRp272TMd7SYq4APnHDRDVu2CMGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/15 22:17, Jeremy Trimble wrote:
> Hello all.
> 
> I've got some custom hardware that provides data in response to an
> explicit request (or stream of such requests).  I'd like to use
> iio_buffer to catch the data that is returned .  However, I'd also
> like multiple users (i.e. multiple openers of the device) to be able
> to be able to send requests to the device and each receive the results
> into their own separate buffer.
> 
> I've implemented a system like this in the past through ad-hoc use of
> mmap(), wrote my own userspace buffer interaction library (a la
> libiio), and allowing requests to be submitted through ioctl().
> However, I'd like to use iio_buffer here if possible, as it is more
> widely-supported than my own one-off solution.
> 
> Are there any instances of multiple buffers being associated with an
> IIO device (or such buffers being created on-the-fly)?  Has this kind
> of idea ever been discussed before?
There was a near case to this with one of the soc ADCs where we had
a huge degree of flexibility.  I'm stretching back a way, but I think
it might have been the mx28 driver... I fear it never got cleaned up/
finished off.   You had the option to have up to 8ish
different channel sequencers running in parallel.  The conclusion in
discussions on that was that the only option would be to register
multiple IIO devices from the driver.  Too much ABI is buffer or
trigger linked to have it in a unified iio device.  Naturally the
multiple iio_devices could all be handled by a single driver and
parent device. 
As for dynamic creation.. Traditionally (i.e. how we used to do it)
in IIO we did this via magic attributes in sysfs.  This isn't a
particularly clean or sensible way of doing things.  There has
been recent work on adding a configfs interface for 'device' creation
in IIO (for stuff like software triggers and also more complex elements
such as bridge drivers to hwmon / input). We could add a 'drivers'
directory to that (though things have gone quiet on those patches
after we concluded some changes to configfs would make them better
and those involved got busy) and allow for driver specific
instantiation as you sound like you need.

As far as I know yours is the first driver that supports effectively
unlimited separate 'buffers' hence you get to tread new ground!

We have (in theory) everything in place that would needed to support
a single buffer being demultiplexed into a number of different buffers
(though we don't have any means of creating them on the fly).  This
doesn't really fit with your description though.

Jonathan

> 
> Thanks.
> -Jeremy Trimble
