Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3Ldt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 07:33:49 -0400
Date: Fri, 30 Mar 2018 12:33:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 3/6] Staging: iio: adis16209: Add a blank line after
 return statements
Message-ID: <20180330123343.7748a973@archlinux>
In-Reply-To: <517fdc2cff0ef238e74c2114fba1a73d2a40a999.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
        <517fdc2cff0ef238e74c2114fba1a73d2a40a999.1522306893.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Mar 2018 14:44:42 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Add a blank line after return statements to improve the code
> readability.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 8f4fa6b..ee7e87b 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -277,6 +277,7 @@ static int adis16209_probe(struct spi_device *spi)
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> +
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -290,6 +291,7 @@ static int adis16209_probe(struct spi_device *spi)
>  	ret = adis_init(st, indio_dev, spi, &adis16209_data);
>  	if (ret)
>  		return ret;
> +
>  	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>  	if (ret)
>  		return ret;

