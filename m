Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbeKEBvy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 20:51:54 -0500
Date: Sun, 4 Nov 2018 16:36:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 1/6] staging:iio:ad2s90: Make read_raw return
 spi_read's error code
Message-ID: <20181104163616.7c864dcc@archlinux>
In-Reply-To: <20181103224948.31014-2-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-2-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Nov 2018 19:49:43 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, when spi_read returned an error code inside ad2s90_read_raw,
> the code was ignored and IIO_VAL_INT was returned. This patch makes the
> function return the error code returned by spi_read when it fails.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 59586947a936..ba55de29ef36 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -36,11 +36,12 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&st->lock);
>  	ret = spi_read(st->sdev, st->rx, 2);
> -	if (ret)
> -		goto error_ret;
> +	if (ret < 0) {
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
>  	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>  
> -error_ret:
>  	mutex_unlock(&st->lock);
>  
>  	return IIO_VAL_INT;
