Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 8 Mar 2014 08:11:26 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO new drivers, features and cleanups for 3.15 - set 3
Message-ID: <20140308161126.GA24802@kroah.com>
References: <5318CB62.2020103@kernel.org>
 <20140306193355.GA12474@kroah.com>
 <531B3C25.90609@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <531B3C25.90609@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Mar 08, 2014 at 04:49:57PM +0100, Lars-Peter Clausen wrote:
> On 03/06/2014 08:33 PM, Greg Kroah-Hartman wrote:
> > On Thu, Mar 06, 2014 at 07:24:18PM +0000, Jonathan Cameron wrote:
> >> The following changes since commit aa256f8d0dd9c2dff872849418d8e09e5d06718f:
> >>
> >>    Merge tag 'iio-for-3.15b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2014-02-23 09:08:34 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>
> >>    git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.15c
> >
> > Pulled and pushed out.
> >
> > What's the status of the remaining drivers/staging/iio/ stuff?  Anything
> > major keeping them from all moving out of staging sometime soon?
> 
> I think we are past the point were we can move big chunks of drivers. The 
> drivers that are in good shape have already been moved. What's left has 
> issues, some smaller, some bigger. Moving things out of staging is 
> progressing, but it is progressing one driver at a time.

Fair enough.  How about the "dummy" drivers?  I don't see them listed in
the TODO file, is there a description of what needs to be done for those
that could be done by someone who is new to kernel development to get a
wider range of developers working on this?

thanks,

greg k-h
