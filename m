Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52269 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdANQM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 11:12:27 -0500
Subject: Re: Using IIO for high-speed DAQ
To: Matthias Klumpp <matthias@tenstral.net>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
Date: Sat, 14 Jan 2017 16:12:23 +0000
MIME-Version: 1.0
In-Reply-To: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/01/17 14:13, Matthias Klumpp wrote:
> Hello!
> I would like to use IIO for high-speed data acquisition. In order to
> do that I implemented a new IIO driver for the ADC chip I am using
> (MAX1133, maximum sampling frequency 200ksps).
> 
> The initial approach with triggered buffers was way too slow,
> achieving only a maximum sampling frequency of 4ksps.
Any idea where the bottle neck was specifically?  I'm guessing it
might have been on the userspace side, but not certain.
People have the ti_am335x ADC on the beaglebone black running
at 200ksps without using the DMA buffer interface (through the
kfifo) Now this uses dma internally and the board has a fifo
so the data turns up in blocks so it's not really comparable.

https://www.spinics.net/lists/linux-iio/msg27422.html

> I now changed the driver to use DMA, using the recent code landed in
> IIO. The DMA dummy driver was very helpful as a template for writing
> the new code and seeing how all parts fit together (why isn't this
> included in the kernel?).
It originally got stalled on some other changes occurring in the dummy
driver (I think it was moving out of staging at the time).
Since then I know Lars has wanted to change some stuff in the
DMA buffers that has been making him not want to publicise that too
much!

When you say use DMA, this part is an SPI device - so are you hand
rolling DMA transfers from the spi controller?

We've discussed in the past (long time ago now!) how to use spi
controllers that support streaming modes but nothing has really come
of it yet. What SPI controller are you using?

Last time I was trying to do similar things (was a while ago now)
I fairly quickly hit the limitation that the round trip time on SPI
transfers even when using DMA was a lot longer than the theoretical.
Any idea where you will be limited with that?

> 
> I am now achieving sampling frequencies of 6.6ksps, which is far
> better but still way below what the chip can do. As a bonus, I got rid
> of the need to trigger scans explicitly, which is quite nice for my
> application.
> 
> In any case, 6.6ksps is still pretty slow, and I would ideally like to
> sample with at least 10ksps, and sampling 200ksps would of course be
> the ideal goal.
> 
> The question is, can IIO do that, and if so, how? Using iio_readdev
> from libiio on my device prints a warning about high-speed mode not
> being enabled, but I couldn't find much information on how to enable
> that properly.
> Maybe Lars-Peter Clausen could comment on that.
> 
> In general, if I can't use IIO, I would be stuck with rolling my own
> driver without the benefit of using the IIO subsystem, or tap into
> COMEDI which is a complete overkill for this usecase.
> 
> In any case, it would be awesome if someone could give me some
> pointers on what to do here (I know Analog Devices uses IIO for an
> oscilloscope application, so I guess high sampling rates are possible,
> the question is how one can achieve that and if it makes sense at
> all).
Lars would indeed be the person I'd ask about this.  I've cc'd
him directly as often emails get buried in the list and missed
by people for at least a little while.

Keep us informed of how you get on. Will be useful info for others.

Jonathan
> 
> Kind regards,
>     Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

