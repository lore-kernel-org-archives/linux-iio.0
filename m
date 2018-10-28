Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2BZu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 21:25:50 -0400
Date: Sun, 28 Oct 2018 16:40:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/6] staging:iio:ad2s90: Make read_raw return
 spi_read's error code
Message-ID: <20181028164038.0c920358@archlinux>
In-Reply-To: <20181027020005.3140-2-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-2-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 26 Oct 2018 23:00:00 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, when spi_read returned an error code inside ad2s90_read_raw,
> the code was ignored and IIO_VAL_INT was returned. This patch makes the
> function return the error code returned by spi_read when it fails.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Matheus,

One quick process note is that it takes people a while to get around to reviewing
a series, so whilst it's tempting to very quickly send out a fix the moment
someone points out something that needs fixing, it is perhaps better to wait
at least a few days to see if you can pick up a few more reviews before you
do a V2.

A few comments on this one inline.  I think it can be done 'slightly'
(and I mean only slightly) nicer than the version you have.  Result is the
same though.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 59586947a936..11fac9f90148 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -35,12 +35,15 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  	struct ad2s90_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> +
Unconnected change.  I'm not against the change in principle but please
group white space tidying up in it's own patch.

>  	ret = spi_read(st->sdev, st->rx, 2);
> -	if (ret)
> -		goto error_ret;
> +	if (ret < 0) {
> +		mutex_unlock(&st->lock);
> +		return ret;
I'd actually prefer to keep the return path the same as before as then
it is easy (if the function gets more complex in future) to be sure
that all paths unlock the mutex.  
> +	}
> +
>  	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>  
> -error_ret:
>  	mutex_unlock(&st->lock);
>  
>  	return IIO_VAL_INT;
The 'standard' if slightly nasty way of doing this is:

	return ret ? ret : IIO_VAL_INT;
