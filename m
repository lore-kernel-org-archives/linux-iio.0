Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdFUT6r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:58:47 -0400
Date: Wed, 21 Jun 2017 20:58:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/5] iio: accel: st_accel_spi: add OF capability to
 st_accel_spi
Message-ID: <20170621205843.1b94e503@kernel.org>
In-Reply-To: <20170620195212.23213-4-lorenzo.bianconi@st.com>
References: <20170620195212.23213-1-lorenzo.bianconi@st.com>
        <20170620195212.23213-4-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Jun 2017 21:52:10 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add device tree support for LIS3DH accel sensor.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
I'm going to hold this one for a little while as I have an open question to Rob on
how to support package in package devices.

I suspect his answer will have a baring on this as well.
> ---
>  drivers/iio/accel/st_accel_spi.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index d13742edee0e..b7252a8ab494 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -18,6 +18,22 @@
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_accel.h"
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id st_accel_of_match[] = {
> +	{
> +		.compatible = "st,lis302dl-spi"
> +	},
> +	{
> +		.compatible = "st,lis3dh-accel",
> +		.data = LIS3DH_ACCEL_DEV_NAME,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, st_accel_of_match);
> +#else
> +#define st_accel_of_match	NULL
> +#endif
> +
>  static int st_accel_spi_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -30,6 +46,8 @@ static int st_accel_spi_probe(struct spi_device *spi)
>  
>  	adata = iio_priv(indio_dev);
>  
> +	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
> +				 spi->modalias, sizeof(spi->modalias));
>  	st_sensors_spi_configure(indio_dev, spi, adata);
>  
>  	err = st_accel_common_probe(indio_dev);
> @@ -61,14 +79,6 @@ static const struct spi_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id st_accel_of_match[] = {
> -	{ .compatible = "st,lis302dl-spi" },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, st_accel_of_match);
> -#endif
> -
>  static struct spi_driver st_accel_driver = {
>  	.driver = {
>  		.name = "st-accel-spi",

