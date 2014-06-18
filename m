Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 18 Jun 2014 10:47:17 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO drivers left in drivers/staging/
Message-ID: <20140618174717.GC11977@kroah.com>
References: <20140611013007.GA32756@kroah.com>
 <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com>
 <53998D43.9020209@gmail.com>
 <53A1895A.4090209@gmail.com>
 <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 18, 2014 at 02:56:52PM +0200, Peter Meerwald wrote:
> Hello Kristina,
> 
> > > Okay so right now I'm getting the following things I could work on:
> > > 
> > > 1) prefixes on define constants for lpc32xx_ADC (then trying to move it
> > > out of staging and seeing what other issues people find?)
> > > 2) resolver/CDC ABI documentation cleanup
> > > 3) dummy driver fake event interrupt hack
> > > 4) Lars may have more ideas?
> > > 
> > > The plan is for me to start working on this stuff full time next week,
> > > so if you think of anything more, please let me know!
> > 
> > Haven't heard back from you about this. Have you found anything else
> > that needs to be done with staging IIO drivers before they can be moved out?
> 
> IIO is a bit problematic since testing usually requires possessing the 
> sensor chip

Any specific chips / devices we should look into buying for these
drivers to help make it easier to do development?

> regarding staging/iio/magnetometer/hmc5843:
> the driver has one specific DEVICE_ATTR left (meas_conf), otherwise clean 
> I think; so we could (a) document it as special ABI or (b) drop it

Which is it?  It should be easy to delete a driver :)

thanks,

greg k-h
