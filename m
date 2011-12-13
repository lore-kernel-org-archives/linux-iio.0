Return-Path: <greg@kroah.com>
Date: Mon, 12 Dec 2011 16:46:59 -0800
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Setup buffer access functions when
 allocating the buffer
Message-ID: <20111213004659.GB11553@kroah.com>
References: <1323684545-11188-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323684545-11188-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 12, 2011 at 11:09:05AM +0100, Lars-Peter Clausen wrote:
> Setup the buffer access functions in the buffer allocate function. There is no
> need to let each driver handle this on its own.

That's nicer.

So, you have different ways to have "buffers" and the driver doesn't
know what type you have, and it's chosen at build time?  Why are you
making the kernel builder make such a decision?  Why not just pick one,
that you know works well, and use it?

You would get rid of a whole level of indirection that I really don't
think you need at all, right?

Make a decision, don't force someone else to make it for you...

greg k-h
