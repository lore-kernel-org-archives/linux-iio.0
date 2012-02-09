Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 9 Feb 2012 11:17:18 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	linus.walleij@linaro.org, maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20120209191718.GA10999@kroah.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-2-git-send-email-jic23@kernel.org>
 <20120209181056.GA957@kroah.com>
 <4F3411BA.5070401@kernel.org>
 <20120209185754.GA10284@kroah.com>
 <20120209191509.GM3058@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120209191509.GM3058@opensource.wolfsonmicro.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 09, 2012 at 07:15:10PM +0000, Mark Brown wrote:
> On Thu, Feb 09, 2012 at 10:57:54AM -0800, Greg KH wrote:
> 
> > So, would the "keep looping until all dependancies are met" patches from
> > Grant that have been floating around for a while, solve this issue?
> > Modules would properly initialize only when the needed other bits are
> > present, which solves the problems the regulators and other drivers have
> > today.
> 
> > If so, then I suggest we get that code into the tree soon, and then all
> > of this "wierd" logic would go away, right?
> 
> Could you identify the logic you're talking about here?  Looking at the
> last patch set I can find[1] this all looks very vanilla for this sort of
> subsystem?  You've got a mapping mechanism and a get function but that's
> about it which is all pretty normal.  Grant's changes make module
> probing nicer in that you don't need to worry about the order in which
> things get registered but I can't see anything here which is
> particularly related to that ordering.
> 
> All the code is doing is providing a mechanism for drivers that need IIO
> facilities to locate the thing that's providing their IIO facilities
> (which is in the general case going to be board specific on a totally
> unrelated chip in a different part of the system and discovered through
> reading the schematic) without requiring custom code in every single
> single IIO using device to do the mapping.  Instead the boards use a
> standard subsystem facility to tell the IIO core what's wired where and
> then the core matches things up for them.
> 
> This is nothing to do with init ordering, it's all about the two devices
> finding each other at all.

Ok, if that's all this is for, they why name it "iio in-kernel logic"?
That made me believe that this is something that is needed if anyone who
happens to want to use the iio interface needs it.

If it's just "iio discovery" then call it that :)

thanks,

greg k-h
