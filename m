Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 18 Apr 2017 19:40:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] 5th set of IIO fixes for the 4.11 cycle.
Message-ID: <20170418174014.GC8087@kroah.com>
References: <1dbc0f18-d35b-2ee4-aeb5-db765388579e@kernel.org>
 <20170418151311.GB15343@kroah.com>
 <0345D842-DDD5-43ED-B6B0-22FB5C627DDF@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0345D842-DDD5-43ED-B6B0-22FB5C627DDF@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 18, 2017 at 05:18:30PM +0100, Jonathan Cameron wrote:
> 
> 
> On 18 April 2017 16:13:11 BST, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Fri, Apr 14, 2017 at 04:59:48PM +0100, Jonathan Cameron wrote:
> >> The following changes since commit
> >a6d361404d81a03107a3475876afc22e1b84d5de:
> >> 
> >>   Merge tag 'iio-fixes-for-4.11d' of
> >git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
> >staging-linus (2017-04-03 15:28:14 +0200)
> >> 
> >> are available in the git repository at:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> >tags/iio-fixes-for-4.11e
> >
> >Ugh, it's too late for 4.11, can I pull this into the -next branch and
> >just take it that way?
> >
> >Or do you want to redo this, with cc: stable markings to get into
> >4.11.1?
> >
> Might take me a little while to get to it, so pull into next branch and I'll send requests for stable
> once it hits mainline in the merge window.

Ok, now pulled in and pushed out in the staging-next branch.

thanks,

greg k-h
