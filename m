Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbeKEB6H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 20:58:07 -0500
Date: Sun, 4 Nov 2018 16:42:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 4/6] staging:iio:ad2s90: Move device registration to
 the end of probe
Message-ID: <20181104164229.128d2f17@archlinux>
In-Reply-To: <20181103224948.31014-5-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-5-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Nov 2018 19:49:46 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, devm_iio_device_register was being called before the
> spi_setup call and the spi_device's max_speed_hz and mode assignments.
> This could lead to a race condition since the driver was still being
> set up after it was already made ready to use. To fix it, this patch
> moves the device registration to the end of ad2s90_probe.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied.  This is definitely looking more like a 'modern' IIO driver.
All sorts of less than sensible things like this used to be done
when all of us were new to drivers.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 54ad85bd9dc6..8f79cccf4814 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -79,10 +79,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	/* need 600ns between CS and the first falling edge of SCLK */
>  	spi->max_speed_hz = 830000;
>  	spi->mode = SPI_MODE_3;
> @@ -93,7 +89,7 @@ static int ad2s90_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	return 0;
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
>  static const struct spi_device_id ad2s90_id[] = {
