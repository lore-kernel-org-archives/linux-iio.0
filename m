Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58292 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIJOxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 10:53:20 -0400
Subject: Re: question about IIO buffer interface
To: Armando Visconti <armando.visconti@st.com>,
        linux-iio@vger.kernel.org
References: <e388b0fd-85a9-16d6-5ec9-28021f5a5f64@st.com>
Cc: Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        Denis CIOCCA <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1033a3e3-51e3-a962-15d5-a7002795033b@kernel.org>
Date: Sat, 10 Sep 2016 15:53:17 +0100
MIME-Version: 1.0
In-Reply-To: <e388b0fd-85a9-16d6-5ec9-28021f5a5f64@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/09/16 17:07, Armando Visconti wrote:
> Hi,
> 
> I'm using kernel 3.10, but question is valid for any kernel
> version.
> 
> I'm not able to clearly understand how the pre/post enable/disable
> routines should be implemented in the IIO driver for my sensor.
> 
> In particular, it is not clear to me where I should be expected
> to put the enable/disable of the sensor.
> 
> Looking at following comments inside include/linux/iio/iio.h, it
> seems to me that maybe the sensor enable should be put inside
> the postenable, and the sensor disabled inside the predisabled.
> 
>> * @preenable:        [DRIVER] function to run prior to marking buffer enabled
>> * @postenable:       [DRIVER] function to run after marking buffer enabled
>> * @predisable:       [DRIVER] function to run prior to marking buffer
>> *                    disabled
>> * @postdisable:      [DRIVER] function to run after marking buffer disabled
> 
> But it is not so evident looking at the IIO framework.
> Can someone put some light on it?

Hi,

Firstly this is an area we have been aware needs tidying up for a while
and has evolved into somewhat of a mess!

This separation into there being two callbacks is partly historical and
partly to allow a logical separation of functions.  We used to try
and do buffer enabling in a fairly lockless fashion wrt to sysfs
accesses etc but that has more or less gone out the window more
recently...  It was causing a lot of pain and bugs for very limited
gain.

I suspect we can clean this up a fair bit but would require
a fair bit of auditing to do it right!  I've been meaning to look
into this for some time but never quite get around to it.

There are three key events that occur between a preenable and postenable.

update_scan_mode -> this puts the hardware into a mode where it can
sample the necessary channels.  Sometimes this involves constructing stuff
in software such as a set of spi messages to dump out on each scan read.

iio_enable_buffers in the file industrialio-buffers.c makes a call to
iio_buffer_enable for each buffer.  This calls the enable callback for
the individual buffer implementation.  Note that for the simple kfifo
buffer this callback doesn't exist... 
Hmm. this might actually not be called anywhere any more... oops.
(just run a build test with them removed and it seems fine)

The second is the actual setting of the buffer mode.  This effects
queries that might control whether a sysfs read is possible or
something like a sampling frequency change which may not be possible
on some hardware.  Before we had coherent locking around the state
the ordering with respect to this mattered.  Now it probably doesn't.

Anyhow, the philosophy was:

preenable -> stuff related to getting ready for buffered operation.
This might be as simple as turning off something else that prevents
buffered operation. Often this is simply not provided as there
is nothing useful to be done.

update_scan_mode -> get the scan mode set up right for all the buffers
being feed by the iio_push_to_buffers calls.  

postenable -> Actually start the flow of data now all the flags are
lined up to say we are enabled.  So in a typical triggered-buffer
case call iio_trigger_attach_poll_func

In hardware buffer cases it can get a lot fiddlier but he principle
is the same.  Stuff to do before actually setting the scan mode
(sometimes things like clearing a fifo that is about to become
invalid go in the preenable and actually 'starting' the buffer
being filled again into the postenable on the basis it will
now be filled with the right things.) There is also the watermark
control stuff rolled in there.

It might be sensible at some point to flatten the above into one
function but it will require careful auditing to make sure
that we have no unintended side effects.

In the meantime it looks to me like we can drop the enable and
disable callbacks and the utility functions that call them.
I'm happy if someone else gets to this before I do!

Upshot in the meantime is that we are being very flexible on any
sensible use of the callbacks.  

If you don't have to do anything in update_scan_mask 
(which is the only call that gets passed the current set of
channels to be captured) then it really doesn't matter.

Otherwise separation is into stuff you want to do before setting
up stuff for the scanmask and stuff you have to do afterwards.

For the disable side:
predisable unwinds postenable and postdisable typically unwinds
preenable.

Jonathan

> 
> Thx,
> Armando
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

