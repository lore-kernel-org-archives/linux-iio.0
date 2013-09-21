Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56832 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IULNJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:13:09 -0400
Message-ID: <523D8D69.4040202@kernel.org>
Date: Sat, 21 Sep 2013 13:13:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@gmail.com>
Subject: Re: [PATCH 11/24] iio:st_sensors: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Denis Ciocca <denis.ciocca@gmail.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 71a2c5f..1665c8e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -113,11 +113,8 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	if (len < 0)
>  		goto st_sensors_get_buffer_element_error;
>  
> -	if (indio_dev->scan_timestamp)
> -		*(s64 *)((u8 *)sdata->buffer_data +
> -				ALIGN(len, sizeof(s64))) = pf->timestamp;
> -
> -	iio_push_to_buffers(indio_dev, sdata->buffer_data);
> +	iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
> +		pf->timestamp);
>  
>  st_sensors_get_buffer_element_error:
>  	iio_trigger_notify_done(indio_dev->trig);
> 
