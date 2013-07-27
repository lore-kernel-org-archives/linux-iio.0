Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53753 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3G0K4Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:56:16 -0400
Message-ID: <51F3B563.4070204@kernel.org>
Date: Sat, 27 Jul 2013 12:56:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/15] staging:iio:adis16260: Don't set default scan mask
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> The recomentation for IIO driver is to leave all scan elements off by default
> and let userspace decide which channels need to be enabled.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 5cec675..e42a581 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -325,20 +325,6 @@ static int adis16260_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_free_dev;
>  
> -	if (indio_dev->buffer) {
> -		/* Set default scan mode */
> -		iio_scan_mask_set(indio_dev, indio_dev->buffer,
> -				  ADIS16260_SCAN_SUPPLY);
> -		iio_scan_mask_set(indio_dev, indio_dev->buffer,
> -				  ADIS16260_SCAN_GYRO);
> -		iio_scan_mask_set(indio_dev, indio_dev->buffer,
> -				  ADIS16260_SCAN_AUX_ADC);
> -		iio_scan_mask_set(indio_dev, indio_dev->buffer,
> -				  ADIS16260_SCAN_TEMP);
> -		iio_scan_mask_set(indio_dev, indio_dev->buffer,
> -				  ADIS16260_SCAN_ANGL);
> -	}
> -
>  	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(adis);
>  	if (ret)
> 
