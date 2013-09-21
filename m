Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56937 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3IULSH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:18:07 -0400
Message-ID: <523D8E92.90307@kernel.org>
Date: Sat, 21 Sep 2013 13:18:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/24] staging:iio:lis3l02dq: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-19-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-19-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied ot the togreg branch of iio.git

> ---
>  drivers/staging/iio/accel/lis3l02dq_ring.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 36dcc7e..aae86dd 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -146,11 +146,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
>  	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
>  		len = lis3l02dq_get_buffer_element(indio_dev, data);
>  
> -	  /* Guaranteed to be aligned with 8 byte boundary */
> -	if (indio_dev->scan_timestamp)
> -		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
> -			= pf->timestamp;
> -	iio_push_to_buffers(indio_dev, data);
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
>  
>  	kfree(data);
>  done:
> 
