Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 28 Jun 2014 12:03:16 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mwelling@ieee.org
Subject: Re: [PATCH v4 1/1] staging: iio: ad9850.c: code cleanup
Message-ID: <20140628160316.GB11019@kroah.com>
References: <936f1ac494ee8708e37a8cb16a70aa3f007e93cd.1403966025.git.guillaume@morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <936f1ac494ee8708e37a8cb16a70aa3f007e93cd.1403966025.git.guillaume@morinfr.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 28, 2014 at 05:54:39PM +0200, Guillaume Morin wrote:
> checkpath.pl was complaining about value_mask:
> ERROR: Macros with complex values should be enclosed in parenthesis
> 
> I fixed this by simply removing it since it's not used (as well as another
> macro).  Got rid of the un-necessary error_ret label as well.
> 
> Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
> Reported-by: Michael Welling <mwelling@ieee.org>
> ---
> Changes since v3:
> - Added Reported-by: Michael Welling <mwelling@ieee.org>
> 
>  drivers/staging/iio/frequency/ad9850.c |    6 ------
>  1 file changed, 6 deletions(-)

Very good, thanks for pushing through and doing this.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
