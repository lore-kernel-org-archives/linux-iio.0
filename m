Return-Path: <zubair.lutfullah@gmail.com>
Date: Sun, 4 Aug 2013 16:42:31 +0100
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Zubair Lutfullah:  zubair.lutfullah@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, gregkh@linuxfoundation.org,
	Russ.Dill@ti.com
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Message-ID: <20130804154230.GA32073@gmail.com>
References: <1374882674-18403-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374882674-18403-3-git-send-email-zubair.lutfullah@gmail.com>
 <51FE357C.2040401@kernel.org>
 <20130804131109.GA30541@gmail.com>
 <51FE8107.4020201@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51FE8107.4020201@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Aug 04, 2013 at 05:27:51PM +0100, Jonathan Cameron wrote:
> > 
> > The trigger here is simply to give certain functionality like an oscilloscope 
> > trigger. The control is given to the userspace application via IIO triggers 
> > (so sysfs/gpio/timer etc can be used)
> > 
> > A buffer of samples is read on one trigger.
> That buffer is filled continuously?

Yes.
Very similar to an oscilloscope trigger.

Upon receiving a trigger, enabled channels are sampled continuously and 
pushed to userspace via iio_push_to_buffer

> > 
> > generic_buffer.c reads the samples with a simple sysfs trigger.
> > 
> I'm not sure what the point of the sysfs trigger here is.  Why not
> just push from the fifo directly out when a watershed interrupt occurs
> on the hardware buffer?
> 

So that any IIO trigger can be used to initiate sampling. sysfs/gpio/timer etc.
Also in this way, generic buffer.c can be used without patching it to remove
trigger checks.

What you state is exactly what happens. When the HW fifo threshold is reached,
the samples are read and sent to userspace via iio_push_to_buffers.

The trigger is used *only* to initiate the process.

> > So.
> > Additional description in the git log only?
> > 
> > I'll add following in log message.
> > "Any IIO trigger can be used to trigger driver to read a buffer
> > of samples from enabled channels."
