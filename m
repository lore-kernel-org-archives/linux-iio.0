Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCrU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:47:20 -0500
Date: Sat, 1 Dec 2018 15:34:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 2/7] staging:iio:ad2s90: Remove spi setup that should
 be done via dt
Message-ID: <20181201153428.399caf50@archlinux>
In-Reply-To: <20181124002312.6923-3-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-3-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Nov 2018 22:23:07 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> The ad2s90 driver currently sets some spi settings (max_speed_hz and
> mode) at ad2s90_probe. Since the maximum frequency is a required element
> in DT binding for spi slave devices and because the spi mode for the
> device can be either (0,0) or (1,1), these settings should be handled
> via device tree, not in the driver's code. This patch removes them from
> the probe function.
> 
> Note: The way in which the mentioned spi settings need to be specified
> on the ad2s90's node of a device tree will be documented in the future
> patch "dt-bindings:iio:resolver: Add docs for ad2s90".
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

Applied,

Thanks,

Jonathan

> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Rewritten patch message to better explain why the code snippet in
>  question should be removed.
> 
>  drivers/staging/iio/resolver/ad2s90.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index fdae067ed866..abb9b9147ee6 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad2s90_state *st;
> -	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	/* need 600ns between CS and the first falling edge of SCLK */
> -	spi->max_speed_hz = 830000;
> -	spi->mode = SPI_MODE_3;
> -	ret = spi_setup(spi);
> -
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "spi_setup failed!\n");
> -		return ret;
> -	}
> -
>  	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
