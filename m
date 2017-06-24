Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdFXTvo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 15:51:44 -0400
Date: Sat, 24 Jun 2017 20:51:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] iio: pressure: st_pressure_spi: add OF capability to
 st_pressure_spi
Message-ID: <20170624205139.52cd341f@kernel.org>
In-Reply-To: <20170622175742.25696-1-lorenzo.bianconi@st.com>
References: <20170622175742.25696-1-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Jun 2017 19:57:42 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add device tree support for LPS22HB pressure sensor
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  drivers/iio/pressure/st_pressure_spi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 550508025af1..6dde7cc3e999 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -18,6 +18,19 @@
>  #include <linux/iio/common/st_sensors_spi.h>
>  #include "st_pressure.h"
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id st_press_of_match[] = {
> +	{
> +		.compatible = "st,lps22hb-press",
Rob requested the other day that we don't do this sort
of naming.  That particular discussion was about a dual
chip package. Here as far as I can tell the lsp22hb is
only ever a simple pressure sensor.  Hence can we drop the
-press? 
If we need to have it for backwards compatibility then
perhaps both is the way to go with the press version clearly
marked as deprecated.
> +		.data = LPS22HB_PRESS_DEV_NAME,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, st_press_of_match);
> +#else
> +#define st_press_of_match	NULL
> +#endif
> +
>  static int st_press_spi_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -30,6 +43,8 @@ static int st_press_spi_probe(struct spi_device *spi)
>  
>  	press_data = iio_priv(indio_dev);
>  
> +	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
> +				 spi->modalias, sizeof(spi->modalias));
>  	st_sensors_spi_configure(indio_dev, spi, press_data);
>  
>  	err = st_press_common_probe(indio_dev);
> @@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(spi, st_press_id_table);
>  static struct spi_driver st_press_driver = {
>  	.driver = {
>  		.name = "st-press-spi",
> +		.of_match_table = of_match_ptr(st_press_of_match),
>  	},
>  	.probe = st_press_spi_probe,
>  	.remove = st_press_spi_remove,

