Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39684 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933124Ab3AIVoz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 16:44:55 -0500
Message-ID: <50EDE4D6.4070703@kernel.org>
Date: Wed, 09 Jan 2013 21:44:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/7] staging:iio:adis16080: Add device id table entry
 for the adis16100
References: <1357740079-12326-1-git-send-email-lars@metafoo.de> <1357740079-12326-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1357740079-12326-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 02:01 PM, Lars-Peter Clausen wrote:
> The adis16100 is very similar to the adis16080. The driver description already
> states that the driver supports the adis16100 as-well. But so far the there is
> no device id table for the adis16100 and the drivers does not bind to a device
> named adis16100.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied to togreg branch of iio.git
> ---
>  drivers/staging/iio/gyro/Kconfig          | 4 ++--
>  drivers/staging/iio/gyro/adis16080_core.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
> index ea295b2..2f9467e 100644
> --- a/drivers/staging/iio/gyro/Kconfig
> +++ b/drivers/staging/iio/gyro/Kconfig
> @@ -14,8 +14,8 @@ config ADIS16080
>  	tristate "Analog Devices ADIS16080/100 Yaw Rate Gyroscope with SPI driver"
>  	depends on SPI
>  	help
> -	  Say yes here to build support for Analog Devices adis16080/100 Yaw Rate
> -	  Gyroscope with SPI.
> +	  Say yes here to build support for Analog Devices ADIS16080, ADIS16100 Yaw
> +	  Rate Gyroscope with SPI.
>  
>  config ADIS16130
>  	tristate "Analog Devices ADIS16130 High Precision Angular Rate Sensor driver"
> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
> index 149ff99..0268f2a 100644
> --- a/drivers/staging/iio/gyro/adis16080_core.c
> +++ b/drivers/staging/iio/gyro/adis16080_core.c
> @@ -185,6 +185,13 @@ static int adis16080_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct spi_device_id adis16080_ids[] = {
> +	{ "adis16080", 0 },
> +	{ "adis16100", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, adis16080_ids);
> +
>  static struct spi_driver adis16080_driver = {
>  	.driver = {
>  		.name = "adis16080",
> @@ -192,10 +199,10 @@ static struct spi_driver adis16080_driver = {
>  	},
>  	.probe = adis16080_probe,
>  	.remove = adis16080_remove,
> +	.id_table = adis16080_ids,
>  };
>  module_spi_driver(adis16080_driver);
>  
>  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>  MODULE_DESCRIPTION("Analog Devices ADIS16080/100 Yaw Rate Gyroscope Driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:adis16080");
> 
