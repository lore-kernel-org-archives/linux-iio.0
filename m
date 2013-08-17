Return-Path: <zubair.lutfullah@gmail.com>
Date: Sat, 17 Aug 2013 19:51:13 +0100
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Zubair Lutfullah:  zubair.lutfullah@gmail.com, jic23@cam.ac.uk,
	dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de, gregkh@linuxfoundation.org, Russ.Dill@ti.com
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Message-ID: <20130817185112.GA2776@gmail.com>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <520CBEC6.8010400@kernel.org>
 <20130817085824.GA5090@gmail.com>
 <520F9395.3050900@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520F9395.3050900@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Aug 17, 2013 at 04:15:33PM +0100, Jonathan Cameron wrote:
> > I restructure the driver so that
> > enabling the buffer via userspace starts sampling the ADC channels.
> > Preenable/postenable do all that hard work.
> > 
> > I need to use iio_trigger_register to create an IIO trigger inside the
> > driver.
> > 
> > The IRQ handler for FIFO Threshold causes a trigger event.
> > 
> > The trigger handler pushes the entire fifo to userspace.
> > 
> > I'd like a small ACK before I get to work.
> > Just to make sure I got things correctly.
> Sounds right.
> 
> As I said above, in this case it would be perfectly acceptable to
> not expose the trigger at all (e.g. drive the buffer filling directly)
> as we can't use it for any other purposes anyway and using any other
> trigger to drive this part doesn't make much sense.
>

Not exposing the trigger would require workarounds for generic_buffer.c
and I'd like to avoid that. Its pretty harmless to have it anyways.

Thanks for the ACK. I'll send another series in a while after all this.

Zubair
