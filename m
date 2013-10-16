Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55573 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab3JPRP4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:15:56 -0400
Message-ID: <525ED801.3060807@kernel.org>
Date: Wed, 16 Oct 2013 19:16:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 15/17] staging:iio:ad5933: Remove redundant call to iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-15-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

thanks
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index f570115..0a4298b 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -574,10 +574,6 @@ static int ad5933_ring_preenable(struct iio_dev *indio_dev)
>  	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
>  		return -EINVAL;
>  
> -	ret = iio_sw_buffer_preenable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = ad5933_reset(st);
>  	if (ret < 0)
>  		return ret;
> 
