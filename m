Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbeKEByL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 20:54:11 -0500
Date: Sun, 4 Nov 2018 16:38:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
Message-ID: <20181104163834.43dab5fd@archlinux>
In-Reply-To: <20181103224948.31014-3-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-3-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Nov 2018 19:49:44 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, ad2s90_probe ignored the return code from spi_setup, not
> handling its possible failure. This patch makes ad2s90_probe check if
> the code is an error code and, if so, do the following:
> 
> - Call dev_err with an appropriate error message.
> - Return the spi_setup's error code.
> 
> Note: The 'return ret' statement could be out of the 'if' block, but
> this whole block will be moved up in the function in the patch:
> 'staging:iio:ad2s90: Move device registration to the end of probe'.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Very nicely presented patch.  Thanks.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index ba55de29ef36..4908c8a95fad 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -86,7 +86,12 @@ static int ad2s90_probe(struct spi_device *spi)
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
>  
>  	return 0;
>  }
