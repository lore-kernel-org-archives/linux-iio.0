Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 6 Aug 2012 11:04:16 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: Re: lis3l02dq_core fails to compile
In-Reply-To: <501F8626.5030007@metafoo.de>
Message-ID: <alpine.DEB.2.01.1208061100180.1363@pmeerw.net>
References: <alpine.DEB.2.01.1208061029320.1363@pmeerw.net> <501F8626.5030007@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> > staging/iio/accel/lis3l02dq_core.c fails to compile when irq_to_gpio() is 
> > not available
> > 
> > the solution is to pass both, irq and gpio via platform data (e.g. as 
> > done by staging/iio/magnetometer/ak8975.c)?

> gpio_to_irq will always be available. While irq_to_gpio is deprecated. So it
> should work if you just pass the gpio.

so: pass gpio via platform data, and derive irq from that

> But looking at the driver it only seems to check if the IRQ is a valid GPIO,
> but never seems use the GPIO pin otherwise. Maybe I missed something, but
> I'd just remove the whole  gpio_is_valid(irq_to_gpio(spi->irq)) check.

the irq is used in lis3l02dq_ring.c (I should have pointed that out):

static int lis3l02dq_trig_try_reen(struct iio_trigger *trig)
...
		if (gpio_get_value(irq_to_gpio(st->us->irq)))

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
