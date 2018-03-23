Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:46423 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752048AbeCWNUh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Mar 2018 09:20:37 -0400
Date: Fri, 23 Mar 2018 13:20:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Veenstra <davidjulianveenstra@gmail.com>
CC: <lars@metafoo.de>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 07/11] staging: iio: ad2s1200: Ensure udelay(1) in all
 necessary code paths
Message-ID: <20180323142024.00005edb@huawei.com>
In-Reply-To: <0bf705c8d642bdd9d3a3b7e4653028a88df76ff9.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
        <0bf705c8d642bdd9d3a3b7e4653028a88df76ff9.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 18 Mar 2018 14:36:15 +0100
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> After a successful spi transaction, a udelay(1) is needed.
> This doesn't happen for the default case of the switch statement
> in ad2s1200_read_raw. This patch makes sure that it does.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Given this one can't actually happen as the chan->type
is always one of the two options, I can't see the point
in making sure we sleep.

The default is really just there to catch bugs and to suppress
the build warning we would otherwise get.

So I am unconvinced on this patch.

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index e0e7c88368ed..6ce9ca13094a 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -78,20 +78,22 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  	switch (chan->type) {
>  	case IIO_ANGL:
>  		*val = vel >> 4;
> +		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_ANGL_VEL:
>  		*val = sign_extend32((s16)vel >> 4, 11);
> +		ret = IIO_VAL_INT;
>  		break;
>  	default:
> -		mutex_unlock(&st->lock);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		break;
>  	}
>  
>  	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
>  	udelay(1);
>  	mutex_unlock(&st->lock);
>  
> -	return IIO_VAL_INT;
> +	return ret;
>  }
>  
>  static const struct iio_chan_spec ad2s1200_channels[] = {

