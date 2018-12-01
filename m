Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCrB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:47:01 -0500
Date: Sat, 1 Dec 2018 15:34:10 +0000
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
Subject: Re: [PATCH v3 1/7] staging:iio:ad2s90: Add device tree support
Message-ID: <20181201153410.0a62c450@archlinux>
In-Reply-To: <20181124002312.6923-2-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-2-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Nov 2018 22:23:06 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds device tree support to ad2s90 with standard
> device tree id table.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Joanthan

> ---
> Changes in v3:
>  - Removed of_patch_ptr from of_match_table assignment
> 
> Changes in v2:
>  - none
> 
>  drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 3e257ac46f7a..fdae067ed866 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
>  	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
> +static const struct of_device_id ad2s90_of_match[] = {
> +	{ .compatible = "adi,ad2s90", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad2s90_of_match);
> +
>  static const struct spi_device_id ad2s90_id[] = {
>  	{ "ad2s90" },
>  	{}
> @@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
>  static struct spi_driver ad2s90_driver = {
>  	.driver = {
>  		.name = "ad2s90",
> +		.of_match_table = ad2s90_of_match,
>  	},
>  	.probe = ad2s90_probe,
>  	.id_table = ad2s90_id,
