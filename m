Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbeETLCi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 07:02:38 -0400
Date: Sun, 20 May 2018 12:02:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 07/12] staging: iio: ad2s1200: Add dt table
Message-ID: <20180520120231.594d4c49@archlinux>
In-Reply-To: <eb4fa431405d0d4e73889d440b3b1c95d5c47e54.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <eb4fa431405d0d4e73889d440b3b1c95d5c47e54.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:22:41 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Add device tree table for matching with the vendor ID.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied

Thanks,

Jonathan
> ---
> Changes in v4:
>  - Introduced in this version.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 9a8aa2448897..67d9747f88a6 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -154,6 +154,13 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> +static const struct of_device_id ad2s1200_of_match[] = {
> +	{ .compatible = "adi,ad2s1200", },
> +	{ .compatible = "adi,ad2s1205", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad2s1200_of_match);
> +
>  static const struct spi_device_id ad2s1200_id[] = {
>  	{ "ad2s1200" },
>  	{ "ad2s1205" },
> @@ -164,6 +171,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1200_id);
>  static struct spi_driver ad2s1200_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(ad2s1200_of_match),
>  	},
>  	.probe = ad2s1200_probe,
>  	.id_table = ad2s1200_id,

