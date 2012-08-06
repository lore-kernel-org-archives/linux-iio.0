Return-Path: <lars@metafoo.de>
Message-ID: <501F8626.5030007@metafoo.de>
Date: Mon, 06 Aug 2012 10:53:58 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: Re: lis3l02dq_core fails to compile
References: <alpine.DEB.2.01.1208061029320.1363@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1208061029320.1363@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/06/2012 10:39 AM, Peter Meerwald wrote:
> Hello,
> 
> staging/iio/accel/lis3l02dq_core.c fails to compile when irq_to_gpio() is 
> not available
> 
> the solution is to pass both, irq and gpio via platform data (e.g. as 
> done by staging/iio/magnetometer/ak8975.c)?
> 

gpio_to_irq will always be available. While irq_to_gpio is deprecated. So it
should work if you just pass the gpio.

But looking at the driver it only seems to check if the IRQ is a valid GPIO,
but never seems use the GPIO pin otherwise. Maybe I missed something, but
I'd just remove the whole  gpio_is_valid(irq_to_gpio(spi->irq)) check.

- Lars
