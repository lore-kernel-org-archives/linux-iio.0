Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUjb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:39:31 -0400
Date: Sat, 24 Jun 2017 21:39:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: magnetometer: st_magn_spi: add OF capability
 to st_magn_spi
Message-ID: <20170624213926.02618aef@kernel.org>
In-Reply-To: <20170620195212.23213-5-lorenzo.bianconi@st.com>
References: <20170620195212.23213-1-lorenzo.bianconi@st.com>
        <20170620195212.23213-5-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Jun 2017 21:52:11 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add device tree support for LIS3MDL magnetometer sensor
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  drivers/iio/magnetometer/st_magn_spi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index f3cb4dc05391..4847375f2c0d 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -18,6 +18,19 @@
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_magn.h"
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id st_magn_of_match[] = {
> +	{
> +		.compatible = "st,lis3mdl-magn",
Ideally we should drop the magn as that is all this part is...
> +		.data = LIS3MDL_MAGN_DEV_NAME,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, st_magn_of_match);
> +#else
> +#define st_magn_of_match	NULL
> +#endif
> +
>  static int st_magn_spi_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -30,6 +43,8 @@ static int st_magn_spi_probe(struct spi_device *spi)
>  
>  	mdata = iio_priv(indio_dev);
>  
> +	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
> +				 spi->modalias, sizeof(spi->modalias));
>  	st_sensors_spi_configure(indio_dev, spi, mdata);
>  
>  	err = st_magn_common_probe(indio_dev);
> @@ -57,6 +72,7 @@ MODULE_DEVICE_TABLE(spi, st_magn_id_table);
>  static struct spi_driver st_magn_driver = {
>  	.driver = {
>  		.name = "st-magn-spi",
> +		.of_match_table = of_match_ptr(st_magn_of_match),
>  	},
>  	.probe = st_magn_spi_probe,
>  	.remove = st_magn_spi_remove,

