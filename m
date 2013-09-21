Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56865 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IULO6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:14:58 -0400
Message-ID: <523D8DD6.9050504@kernel.org>
Date: Sat, 21 Sep 2013 13:15:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/24] iio:adis16400: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-13-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/imu/adis16400_buffer.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
> index 054c01d..f2cf829 100644
> --- a/drivers/iio/imu/adis16400_buffer.c
> +++ b/drivers/iio/imu/adis16400_buffer.c
> @@ -82,13 +82,8 @@ irqreturn_t adis16400_trigger_handler(int irq, void *p)
>  		spi_setup(st->adis.spi);
>  	}
>  
> -	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (indio_dev->scan_timestamp) {
> -		void *b = adis->buffer + indio_dev->scan_bytes - sizeof(s64);
> -		*(s64 *)b = pf->timestamp;
> -	}
> -
> -	iio_push_to_buffers(indio_dev, adis->buffer);
> +	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> +		pf->timestamp);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
