Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56850 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IULOJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:14:09 -0400
Message-ID: <523D8DA5.5090105@kernel.org>
Date: Sat, 21 Sep 2013 13:14:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH 12/24] iio:itg3200: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/gyro/itg3200_buffer.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> index 6b3c301..e3b3c50 100644
> --- a/drivers/iio/gyro/itg3200_buffer.c
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -55,11 +55,8 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	if (indio_dev->scan_timestamp)
> -		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
> -				&pf->timestamp, sizeof(pf->timestamp));
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
>  
> -	iio_push_to_buffers(indio_dev, buf);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  error_ret:
> 
