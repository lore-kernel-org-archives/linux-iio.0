Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2B2m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 21:28:42 -0400
Date: Sun, 28 Oct 2018 16:43:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
Message-ID: <20181028164329.57162e06@archlinux>
In-Reply-To: <20181027020005.3140-3-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-3-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 26 Oct 2018 23:00:01 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, ad2s90_probe ignored the return code from spi_setup, not
> handling its possible failure. This patch makes ad2s90_probe check if
> the code is an error code and, if so, do the following:
> 
> - Call dev_err with an appropriate error message.
> - Return the spi_setup's error code, aborting the execution of the
> rest of the function.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 11fac9f90148..d6a42e3f1bd8 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
>  	/* need 600ns between CS and the first falling edge of SCLK */
>  	spi->max_speed_hz = 830000;
>  	spi->mode = SPI_MODE_3;
> -	spi_setup(spi);
> +	ret = spi_setup(spi);
> +
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "spi_setup failed!\n");
> +		return ret;
> +	}
I would have reordered this first to be before the iio_device_register call.
The reason being that it would avoid this comment.

Drop the return ret out of the block above and return ret unconditionally.

I don't mind too much as I know this is moving later, but I only know that
because of the earlier discussion ;)  Few reviewers read the whole patch
set before responding to the early patches - it's just too much like hard
work.  So if you can do things in an order that minimizes standard responses
then that's great.

Patch is fine though - could be solved by a comment in the intro that
says the code in question will move in patch X.

Jonathan
>  
>  	return 0;
>  }
