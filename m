Return-Path: <hadess@hadess.net>
Message-ID: <1404216616.7785.1.camel@nuvo>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Reyad Attiyat
	 <reyad.attiyat@gmail.com>, linux-iio@vger.kernel.org, Benjamin Tissoires
	 <benjamin.tissoires@redhat.com>
Date: Tue, 01 Jul 2014 14:10:16 +0200
In-Reply-To: <53A57414.8000104@kernel.org>
References: <1403100542.30918.29.camel@nuvo>
		 <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
		 <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
	 <53A57414.8000104@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hey again Jonathan,

On Sat, 2014-06-21 at 13:01 +0100, Jonathan Cameron wrote:
<snip>
> Just to throw it in there.  There is an out of tree bridge driver from
> IIO to input.  It's only out of tree because I haven't had a chance to
> tidy it up (anyone else is welcome to take this on if they like!)
> Google for iio_input.c to find it.
> 
> The intent of that was to allow general accelerometer drivers and similar
> in IIO to work in conjunction with iio-input to provide input style interfaces.
> This came about after previous debates on where the 'right' place for
> accelerometers was in the kernel. I believe that at least in principle,
> Dmitry was happy with this concept.

After updating forward-porting the driver so that it runs on a more
recent version of the kernel, I tried to get it running.

I'm guessing that you expected the iio_input driver to be instantiated
by a board specific file. Is there any way to have it generically try
out all the IIO devices, similarly to pci_register_driver()? Or should I
do that in the hid-sensor-accel driver?

Cheers
