Return-Path: <greg@kroah.com>
Date: Tue, 23 Aug 2011 13:35:12 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/7] staging:iio:cleanups2 post iio_chan_spec_conversion
Message-ID: <20110823203512.GK25977@kroah.com>
References: <1313168165-16109-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313168165-16109-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 12, 2011 at 05:55:58PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> Note dependency on previous set.
> 
> staging:iio: iio_chan_spec conversions - after cleanups 
> 
> Two things here.
> 
> 1) removal of now unused headers.
> 2) remove a nasty cludge we used to reduce churn during move to iio_chan_spec.
> 
> It's possible either will cause issues for any new drivers crossing with this
> set.  Give me a yell if that happens.

All now applied.

thanks,

greg k-h
