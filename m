Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56912 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab3IULQt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:16:49 -0400
Message-ID: <523D8E45.8040201@kernel.org>
Date: Sat, 21 Sep 2013 13:17:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 17/24] iio:tcs3472: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-17-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/light/tcs3472.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 7bf2969..0bc15cf 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -192,10 +192,8 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>  		len += 2;
>  	}
>  
> -	if (indio_dev->scan_timestamp)
> -		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
> -			= iio_get_time_ns();
> -	iio_push_to_buffers(indio_dev, data->buffer);
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +		iio_get_time_ns());
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> 
