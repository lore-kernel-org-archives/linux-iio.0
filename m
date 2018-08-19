Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeHST2O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:28:14 -0400
Date: Sun, 19 Aug 2018 17:16:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: ms5611: remove deprecated compatible
 strings
Message-ID: <20180819171613.0f74335c@archlinux>
In-Reply-To: <20180816184915.32138-1-tduszyns@gmail.com>
References: <20180816184915.32138-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 16 Aug 2018 20:49:15 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Compatible strings tend to follow manufacturer,model format.
> In case one wants to do a matching with manufacturer stripped
> off he can still do so since SPI/I2C core will try id_table
> based matching anyway.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/ms5611_i2c.c | 2 --
>  drivers/iio/pressure/ms5611_spi.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 55fb5fc0b6ea..0469c8ae1134 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -117,9 +117,7 @@ static int ms5611_i2c_remove(struct i2c_client *client)
>  #if defined(CONFIG_OF)
>  static const struct of_device_id ms5611_i2c_matches[] = {
>  	{ .compatible = "meas,ms5611" },
> -	{ .compatible = "ms5611" },
>  	{ .compatible = "meas,ms5607" },
> -	{ .compatible = "ms5607" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 932e05001e1a..cd11d022208e 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -119,9 +119,7 @@ static int ms5611_spi_remove(struct spi_device *spi)
>  #if defined(CONFIG_OF)
>  static const struct of_device_id ms5611_spi_matches[] = {
>  	{ .compatible = "meas,ms5611" },
> -	{ .compatible = "ms5611" },
>  	{ .compatible = "meas,ms5607" },
> -	{ .compatible = "ms5607" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ms5611_spi_matches);
