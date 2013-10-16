Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55530 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761297Ab3JPROd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:14:33 -0400
Message-ID: <525ED7AF.80000@kernel.org>
Date: Wed, 16 Oct 2013 19:15:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 12/17] staging:iio:lis3l02dq: Remove redundant call to
 iio_sw_buffer_preenable().
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/accel/lis3l02dq_ring.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 2d559ba..79cefe0 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -382,7 +382,6 @@ error_ret:
>  }
>  
>  static const struct iio_buffer_setup_ops lis3l02dq_buffer_setup_ops = {
> -	.preenable = &iio_sw_buffer_preenable,
>  	.postenable = &lis3l02dq_buffer_postenable,
>  	.predisable = &lis3l02dq_buffer_predisable,
>  };
> 
