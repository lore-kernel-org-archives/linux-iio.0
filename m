Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56526 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3IUKxR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:53:17 -0400
Message-ID: <523D88C1.6060805@kernel.org>
Date: Sat, 21 Sep 2013 12:53:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/10] iio:buffer_cb: Add missing iio_buffer_init()
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <1379534574-11213-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 21:02, Lars-Peter Clausen wrote:
> Make sure to properly initialize the IIO buffer data structure.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes togreg branch of iio.git

As requested, stopping here in the series for now.
> ---
>  drivers/iio/buffer_cb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
> index 578f719..841fec1 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/buffer_cb.c
> @@ -41,6 +41,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  		goto error_ret;
>  	}
>  
> +	iio_buffer_init(&cb_buff->buffer);
> +
>  	cb_buff->private = private;
>  	cb_buff->cb = cb;
>  	cb_buff->buffer.access = &iio_cb_access;
> 
