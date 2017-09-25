Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934254AbdIYUju (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Sep 2017 16:39:50 -0400
Date: Mon, 25 Sep 2017 21:39:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: zpa2326: Remove always-true check which
 confuses gcc
Message-ID: <20170925213946.1d2c9824@archlinux>
In-Reply-To: <1499242499-18860-1-git-send-email-geert@linux-m68k.org>
References: <1499242499-18860-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  5 Jul 2017 10:14:59 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> With gcc 4.1.2:
> 
>     drivers/iio/pressure/zpa2326.c: In function ‘zpa2326_wait_oneshot_completion’:
>     drivers/iio/pressure/zpa2326.c:868: warning: ‘ret’ may be used uninitialized in this function
> 
> When testing for "timeout < 0", timeout is already guaranteed to be
> strict negative, so the branch is always taken, and ret is thus always
> initialized.  But (some version of) gcc is not smart enough to notice.
> 
> Remove the check to fix this.
> As there is no other code in between assigning the error codes and
> returning them, the error codes can be returned immediately, and the
> intermediate variable can be dropped.
> Drop the "else" to please checkpatch.
> 
> Fixes: e7215fe4d51e69c9 ("iio: pressure: zpa2326: report interrupted case as failure")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Sorry - this one got missed originally.  Not quite sure why!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/zpa2326.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index c92a95f9f52c2141..531b88ce336184d4 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -865,7 +865,6 @@ static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
>  static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
>  					   struct zpa2326_private *private)
>  {
> -	int          ret;
>  	unsigned int val;
>  	long     timeout;
>  
> @@ -887,14 +886,11 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
>  		/* Timed out. */
>  		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
>  			     timeout);
> -		ret = -ETIME;
> -	} else if (timeout < 0) {
> -		zpa2326_warn(indio_dev,
> -			     "wait for one shot interrupt cancelled");
> -		ret = -ERESTARTSYS;
> +		return -ETIME;
>  	}
>  
> -	return ret;
> +	zpa2326_warn(indio_dev, "wait for one shot interrupt cancelled");
> +	return -ERESTARTSYS;
>  }
>  
>  static int zpa2326_init_managed_irq(struct device          *parent,

