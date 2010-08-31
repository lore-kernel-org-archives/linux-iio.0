Return-Path: <greg@kroah.com>
Date: Tue, 31 Aug 2010 11:40:08 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] staging:iio rename ring attributes
Message-ID: <20100831184008.GA14829@kroah.com>
References: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <1283247175-12835-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <4C7D48CE.9060106@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C7D48CE.9060106@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 31, 2010 at 07:24:14PM +0100, Jonathan Cameron wrote:
> On 08/31/10 10:32, Manuel Stahl wrote:
> > bps -> bytes_per_datum
> > ring_enable -> enable
> As a heads up... This breaks the example code in Documentation. I'll clean
> that up when I have a moment.  My fault given I changed the abi doc
> and didn't carry it through.
> 
> Greg - No problems with anything actually built by the kernel so don't let
> this hold the patch up.

Ok, will go apply these as-is.

thanks,

greg k-h
