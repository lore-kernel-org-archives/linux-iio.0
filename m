Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47153 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2IHJ50 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Sep 2012 05:57:26 -0400
Message-ID: <504B1684.3010407@kernel.org>
Date: Sat, 08 Sep 2012 10:57:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 10/10] iio:ad7476: Add support for ad7274/ad7275/ad7276/ad7277/ad7278
References: <1347021872-7885-1-git-send-email-lars@metafoo.de> <1347021872-7885-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2012 01:44 PM, Lars-Peter Clausen wrote:
> The ad7276/ad7277/ad7278 are similar to the ad7476/ad7477/ad7478 but have the
> same number of leading zeros as the ad7940. The ad7274/ad7275 have a extra pin
> for VREF where as for the ad7276/ad7277/ad7278 VREF is taken from VDD, but
> otherwise they are compatible to the ad7276/ad7277.
> 
This and all the other patches I haven't commented on look fine to me.
Looking forward to the updated series.

Hehe. You did a much better job of reviewing your own patches than I did ;)

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/Kconfig  |    6 +++---
>  drivers/iio/adc/ad7476.c |   20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7152a49..645c052 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -24,9 +24,9 @@ config AD7476
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Analog Devices AD7475, AD7476, AD7477,
> -	  AD7478, AD7466, AD7467, AD7468, AD7495, AD7910, AD7920, AD7920 SPI analog
> -	  to digital converters (ADC).
> +	  Say yes here to build support for Analog Devices AD7274, AD7275, AD7276,
> +	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> +	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
>  
>  	  If unsure, say N (but it's safe to say "Y").
>  
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 646df45..8c7e206 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -45,6 +45,9 @@ struct ad7476_state {
>  };
>  
>  enum ad7476_supported_device_ids {
> +	ID_AD7276,
> +	ID_AD7277,
> +	ID_AD7278,
>  	ID_AD7466,
>  	ID_AD7467,
>  	ID_AD7468,
> @@ -172,6 +175,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits))
>  
>  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> +	[ID_AD7276] = {
> +		.channel[0] = AD7940_CHAN(12),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
> +	[ID_AD7277] = {
> +		.channel[0] = AD7940_CHAN(10),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
> +	[ID_AD7278] = {
> +		.channel[0] = AD7940_CHAN(8),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
>  	[ID_AD7466] = {
>  		.channel[0] = AD7476_CHAN(12),
>  		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> @@ -280,6 +295,11 @@ static int __devexit ad7476_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad7476_id[] = {
> +	{"ad7274", ID_AD7276},
> +	{"ad7275", ID_AD7277},
> +	{"ad7276", ID_AD7276},
> +	{"ad7277", ID_AD7277},
> +	{"ad7278", ID_AD7278},
>  	{"ad7466", ID_AD7466},
>  	{"ad7467", ID_AD7467},
>  	{"ad7468", ID_AD7468},
> 
