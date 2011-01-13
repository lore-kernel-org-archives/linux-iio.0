Return-Path: <greg@kroah.com>
Date: Thu, 13 Jan 2011 08:49:38 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Roland Stigge <rst@work-microwave.de>, linux-iio@vger.kernel.org,
	Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH] iio: Fixpoint formatted output bugfix
Message-ID: <20110113164938.GA27468@kroah.com>
References: <1294908733-20354-1-git-send-email-rst@work-microwave.de>
 <4D2EDD50.7060508@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D2EDD50.7060508@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jan 13, 2011 at 11:09:04AM +0000, Jonathan Cameron wrote:
> On 01/13/11 08:52, Roland Stigge wrote:
> > From: Roland Stigge <stigge@antcom.de>
> > 
> > Fix some ADC drivers' _scale interface to correct fixpoint formatted output
> > 
> > Signed-off-by: Roland Stigge <stigge@antcom.de>
> > Acked-by: "Hennerich, Michael" <Michael.Hennerich@analog.com>
> Acked-by: "Jonathan Cameron <jic23@cam.ac.uk>"
> 
> Greg, this is a simple bug fix. The ad7476 and ad799x are in 2.6.37
> so it would be good to push this to stable as well.
> Do you want a broken out patch with just those two in it?

Yes, that would be great to have, can you split this into 2 different
patches so I can handle it that way easier?

thanks,

greg k-h
