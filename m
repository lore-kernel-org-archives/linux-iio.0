Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56983 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3IULTf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:19:35 -0400
Message-ID: <523D8EEB.4050107@kernel.org>
Date: Sat, 21 Sep 2013 13:19:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 23/24] staging:iio:dummy: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-23-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-23-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 14:00, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/iio_simple_dummy_buffer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 3921865..09c93ac 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -82,11 +82,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  			len += 2;
>  		}
>  	}
> -	/* Store the timestamp at an 8 byte aligned offset */
> -	if (indio_dev->scan_timestamp)
> -		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
> -			= iio_get_time_ns();
> -	iio_push_to_buffers(indio_dev, data);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
>  
>  	kfree(data);
>  
> 
