Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56929 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3IULRl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:17:41 -0400
Message-ID: <523D8E74.50601@kernel.org>
Date: Sat, 21 Sep 2013 13:17:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 18/24] iio:gp2ap020a00f: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-18-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/light/gp2ap020a00f.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 62809b5..b1e4615 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -988,13 +988,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
>  		}
>  	}
>  
> -	if (indio_dev->scan_timestamp) {
> -		s64 *timestamp = (s64 *)((u8 *)priv->buffer +
> -						ALIGN(d_size, sizeof(s64)));
> -		*timestamp = pf->timestamp;
> -	}
> -
> -	iio_push_to_buffers(indio_dev, priv->buffer);
> +	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
> +		pf->timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
