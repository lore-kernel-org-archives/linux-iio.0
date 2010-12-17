Return-Path: <greg@kroah.com>
Date: Fri, 17 Dec 2010 12:33:06 -0800
From: Greg KH <greg@kroah.com>
To: Robin Getz <robin.getz@analog.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, abbotti@mev.co.uk,
	fmhess@users.sourceforge.net,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	comedi_list@googlegroups.com
Subject: Re: IIO and Comedi
Message-ID: <20101217203306.GA13671@kroah.com>
References: <201012171513.03045.robin.getz@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201012171513.03045.robin.getz@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 17, 2010 at 03:13:02PM -0500, Robin Getz wrote:
> I'm just trying to rationalise something in my head...
> 
> In staging, there exists both iio, and comedi - which both seem to do similar 
> things (capture/create external analog signals), just with different 
> busses -- which is really different platforms (Desktop - PCI, PCIe vs 
> embedded - I2C, SPI, SoC, etc).
> 
> ./staging/iio
> ./staging/comedi
> 
> the problem (to me) is two different userspace interfaces.
> 
> For userspace, for those "typical" applications - oscilloscope, generator, 
> strip chart recorder, etc - it would be nice to have a common userspace lib 
> between the two - so I can prototype on a desktop via PCI DAQ card, and run 
> on my embedded system with a SPI converter.

I totally agree.

> I can't be the only one asking if there any desire to unify these before they 
> are moved to mainline (out of staging). If there isn't - that's OK too.

There's a desire to figure out a standardized kernel/user api for these
types of devices, if they are similar.

But, we also have to be mindful of the many years of applications that
rely on the comedi libraries.  comedi has been around since the 2.0
days, so ideally if we can keep the userspace library from having to
change its external api, we can do what we want with the kernel side.

So, any work you might want to do in this area is most appreciated.

thanks,

greg k-h
