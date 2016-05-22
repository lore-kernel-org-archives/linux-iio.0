Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52432 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcEVTzb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:55:31 -0400
Subject: Re: [PATCH 2/3] iio: proximity: as3935: remove triggered buffer
 processing
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
 <1463886063-20004-3-git-send-email-mranostay@gmail.com>
Cc: george.mccollister@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <687d13d6-dd9b-a357-09c7-cc1e4c821149@kernel.org>
Date: Sun, 22 May 2016 20:55:28 +0100
MIME-Version: 1.0
In-Reply-To: <1463886063-20004-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/16 04:01, Matt Ranostay wrote:
> Triggered buffers shouldn't return processed data, and the respective
> conversion was overflowing the defined .realbits for the channel.
> 
> Cc: george.mccollister@gmail.com
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git (because it was handy)
and marked for stable.
> ---
>  drivers/iio/proximity/as3935.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index f0a0def..6aed024 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -213,7 +213,6 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
>  	if (ret)
>  		goto err_read;
>  	val &= AS3935_DATA_MASK;
> -	val *= 1000;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &val, pf->timestamp);
>  err_read:
> 

