Return-Path: <alexandre.belloni@free-electrons.com>
Date: Thu, 19 Jun 2014 14:54:16 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO drivers left in drivers/staging/
Message-ID: <20140619125416.GT19375@piout.net>
References: <20140611013007.GA32756@kroah.com>
 <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com>
 <53998D43.9020209@gmail.com>
 <53A1895A.4090209@gmail.com>
 <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
 <20140618174717.GC11977@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140618174717.GC11977@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 18/06/2014 at 10:47:17 -0700, Greg KH wrote :
> On Wed, Jun 18, 2014 at 02:56:52PM +0200, Peter Meerwald wrote:
> > Hello Kristina,
> > 
> > > > Okay so right now I'm getting the following things I could work on:
> > > > 
> > > > 1) prefixes on define constants for lpc32xx_ADC (then trying to move it
> > > > out of staging and seeing what other issues people find?)
> > > > 2) resolver/CDC ABI documentation cleanup
> > > > 3) dummy driver fake event interrupt hack
> > > > 4) Lars may have more ideas?
> > > > 
> > > > The plan is for me to start working on this stuff full time next week,
> > > > so if you think of anything more, please let me know!
> > > 
> > > Haven't heard back from you about this. Have you found anything else
> > > that needs to be done with staging IIO drivers before they can be moved out?
> > 
> > IIO is a bit problematic since testing usually requires possessing the 
> > sensor chip
> 
> Any specific chips / devices we should look into buying for these
> drivers to help make it easier to do development?
> 

I would say that the latest addition to the TODO file is quite valid ;)
We have been looking at moving the mxs-lradc out of staging for a while
now. It still has a few contributions coming from time to time and can
definitely be improved. The main thing to do would be to create an MFD.

I understand this may be a considerable amount of work but it has the
advantage of allowing to have a look at at least 3 different subsystems.

I am willing to review and test patches.

I would suggest that board:
http://www.crystalfontz.com/product/CFA921TS

It may not be the cheapeast one but it has good mainline support and I
know it well.

Crystalfontz provided me some of their boards so that I could give them
out at ELC. If you are interested in the topic, it may be worth asking
whether they are willing to sponsor you ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
