Return-Path: <gregkh@suse.de>
Date: Mon, 12 Dec 2011 23:38:31 -0800
From: Greg KH <gregkh@suse.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Setup buffer access functions when
 allocating the buffer
Message-ID: <20111213073831.GB20154@suse.de>
References: <1323684545-11188-1-git-send-email-lars@metafoo.de>
 <20111213004659.GB11553@kroah.com>
 <8847cb76-be5b-41d3-b893-968bb9cb937a@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8847cb76-be5b-41d3-b893-968bb9cb937a@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 13, 2011 at 07:23:48AM +0000, Jonathan Cameron wrote:
> 
> 
> Greg KH <greg@kroah.com> wrote:
> 
> >On Mon, Dec 12, 2011 at 11:09:05AM +0100, Lars-Peter Clausen wrote:
> >> Setup the buffer access functions in the buffer allocate function.
> >There is no
> >> need to let each driver handle this on its own.
> >
> >That's nicer.
> >
> >So, you have different ways to have "buffers" and the driver doesn't
> >know what type you have, and it's chosen at build time?  Why are you
> >making the kernel builder make such a decision?  Why not just pick one,
> >that you know works well, and use it?
> >
> >You would get rid of a whole level of indirection that I really don't
> >think you need at all, right?
> 
> Because there is not currently a buffer that suits all use cases.
> One might be possible but would involve autoswitching between
> different approaches a hence have this indirection anyway, be it
> burried. Also note that some of the buffers are hardware.  Plus the
> pseudo buffer used for in kernel push interfaces is different again.
> That code has only reached RFC state so far.

So who choses the buffer type, the driver, or the kernel configurator,
or something else?

> >Make a decision, don't force someone else to make it for you...
> Defaults are sensible. Preventing other peoples use cases are not.

Ok, but you do agree that this patch is broken as-is, right?

thanks,

greg k-h
