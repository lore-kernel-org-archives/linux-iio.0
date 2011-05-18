Return-Path: <greg@kroah.com>
Date: Wed, 18 May 2011 08:25:45 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 000/111] IIO: chan_spec intro, generic irq based triggers,
Message-ID: <20110518152545.GB8106@kroah.com>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 18, 2011 at 02:40:50PM +0100, Jonathan Cameron wrote:
> Dear Greg,
> 
> Here is the set I mentioned was coming.
> 
> Thomas Gleixner just pushed the required irq patches to the tip tree
> (though they aren't visible yet).
> 
> [tip:irq/core] genirq: Uninline and sanity check generic_handle_irq()
> fe12bc2c996d3e492b2920e32ac79f7bbae3e15d
> 
> and
> 
> [tip:irq/core] irq: Export functions to allow modular irq drivers
> edf76f8307c350bcb81f0c760118a991b3e62956
> 
> There are two other dependencies. One is a trivial missing header
> in arm (patch on it's way through the arm tree). Doesn't break building
> except on arm anyway.
> 
> The other is the strtobool that you added to driver-core
> Add a strtobool function matching semantics of existing in kernel equivalents
> ad58671cf32c74a8d6e8f51e63e9cf4e7a73bf1e

Hm, this is going to be "interesting" then.  I'll see if I can pull
these patches into my staging-next tree, or if I can just wait for them
to be merged before staging-next and hope that linux-next all works fine
for everyone...

thanks,

greg k-h
