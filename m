Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 12 May 2012 07:33:03 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Remove unused iio_device_put()
Message-ID: <20120512143303.GA1972@kroah.com>
References: <1336741993-30310-1-git-send-email-lars@metafoo.de>
 <20120512141807.GA30846@kroah.com>
 <4FAE7296.90903@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FAE7296.90903@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, May 12, 2012 at 04:24:22PM +0200, Lars-Peter Clausen wrote:
> On 05/12/2012 04:18 PM, Greg Kroah-Hartman wrote:
> > On Fri, May 11, 2012 at 03:13:13PM +0200, Lars-Peter Clausen wrote:
> >> This function is currently unused and we do not have a matching iio_device_get()
> >> function either, so just remove it.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >> Acked-by: Jonathan Cameron <jic23@kernel.org>
> > 
> > No, I see a number of places it should be used.  Don't do "raw"
> > put_device() calls, every one of them could be making this call instead,
> > right?
> 
> Hm, right in the new inkern code there are some put_device calls on
> indio_dev.dev, I missed those, sorry. But we should really add a matching
> iio_device_get() as well.

I agree, and then fix up the inkern.c calls to call that as well :)

thanks,

greg k-h
