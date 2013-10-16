Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55580 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760737Ab3JPRQI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:16:08 -0400
Message-ID: <525ED80E.8090004@kernel.org>
Date: Wed, 16 Oct 2013 19:16:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 16/17] staging:iio:ade7758: Remove redundant call to iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-16-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/meter/ade7758_ring.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 7a448ff..c0accf8 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -87,15 +87,10 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ade7758_state *st = iio_priv(indio_dev);
>  	unsigned channel;
> -	int ret;
>  
>  	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
>  		return -EINVAL;
>  
> -	ret = iio_sw_buffer_preenable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	channel = find_first_bit(indio_dev->active_scan_mask,
>  				 indio_dev->masklength);
>  
> 
