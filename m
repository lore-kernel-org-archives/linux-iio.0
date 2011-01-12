Return-Path: <greg@kroah.com>
Date: Wed, 12 Jan 2011 07:34:13 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Roland Stigge <stigge@antcom.de>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
Message-ID: <20110112153413.GA21087@kroah.com>
References: <4D29C64E.4040806@antcom.de>
 <4D2A373B.6060901@cam.ac.uk>
 <4D2C8348.2090606@antcom.de>
 <4D2CB0D7.8020802@cam.ac.uk>
 <4D2D77FD.50408@antcom.de>
 <4D2D8E86.2000204@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D2D8E86.2000204@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jan 12, 2011 at 11:20:38AM +0000, Jonathan Cameron wrote:
> On 01/12/11 09:44, Roland Stigge wrote:
> > Hi,
> > 
> > On 01/11/2011 08:34 PM, Jonathan Cameron wrote:
> >>> On 01/09/2011 11:31 PM, Jonathan Cameron wrote:
> >>>> Pretty clean and nice driver so it was an easy review and should
> >>>> be trivial to fix up for a merge.
> >>>
> >>> Thanks for your review!
> >>>
> >>> I'm attaching my update. Some notes:
> >>>
> >>> * I used the attributes out1_* how I found it in the other DAC driver
> >>> already available
> >> Cool, except for the out12_raw which could easily be the 12th channel.
> >> This has to be one of the two options suggested the other day.
> >> May require some macro magic. IIRC the relevant macro would be.
> >>
> >> IIO_DEVICE_ATTR_NAMED(out1and2_raw, out1&2_raw, S_IWUSR, ... 
> > 
> > Update attached as suggested. :-)
> > 
> > Thanks!
> > 
> > Roland
> 
> Probably worth sending it to Greg KH in a new thread so that he
> picks up on the fact that it is ready to merge. Given the volume
> of email he probably gets I doubt he is still reading this thread!
> No need to cc that to the list given we have this email.

Heh, I'm still here reading this :)

Roland sent me an updated version, I'll queue that up after .38-rc1 is
out.

thanks,

greg k-h
