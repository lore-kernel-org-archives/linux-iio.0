Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54070 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab3IOQ6a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:58:30 -0400
Message-ID: <5235F553.8090802@kernel.org>
Date: Sun, 15 Sep 2013 18:58:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:buffer_cb: Constify iio_cb_access
References: <1379261395-16304-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1379261395-16304-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/13 17:09, Lars-Peter Clausen wrote:
> The iio_cb_access struct is never modified so we can mark it as const.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Good point.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/buffer_cb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
> index 9d19ba7..f406889 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/buffer_cb.c
> @@ -21,7 +21,7 @@ static int iio_buffer_cb_store_to(struct iio_buffer *buffer, u8 *data)
>  	return cb_buff->cb(data, cb_buff->private);
>  }
>  
> -static struct iio_buffer_access_funcs iio_cb_access = {
> +static const struct iio_buffer_access_funcs iio_cb_access = {
>  	.store_to = &iio_buffer_cb_store_to,
>  };
>  
> 
