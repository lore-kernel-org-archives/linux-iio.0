Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 28 Jun 2014 11:30:27 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mwelling@ieee.org
Subject: Re: [PATCH v3 1/1] staging: iio: ad9850.c: code cleanup
Message-ID: <20140628153027.GF29548@kroah.com>
References: <936f1ac494ee8708e37a8cb16a70aa3f007e93cd.1403965958.git.guillaume@morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <936f1ac494ee8708e37a8cb16a70aa3f007e93cd.1403965958.git.guillaume@morinfr.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 28, 2014 at 05:13:19PM +0200, Guillaume Morin wrote:
> checkpath.pl was complaining about value_mask:
> ERROR: Macros with complex values should be enclosed in parenthesis
> 
> I fixed this by simply removing it since it's not used (as well as another macro).
> Got rid of the un-necessary error_ret label as well.  Both changes were suggested
> by Michael Welling.

Very good.  But (you knew there was a but, right?)

When giving credit to someone else like this, you can just do it with a
simple:

Reported-by: Michael Welling <mwelling@ieee.org>

in the signed-off-by area, no need to write a sentance about it.

Care to try a 4th time here?

thanks,

greg k-h
