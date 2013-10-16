Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55422 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761215Ab3JPRL6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:11:58 -0400
Message-ID: <525ED714.1010300@kernel.org>
Date: Wed, 16 Oct 2013 19:12:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/17] iio:ad7887: Remove redundant call to iio_sw_buffer_preenable().
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-4-git-send-email-lars@metafoo.de>
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
>  drivers/iio/adc/ad7887.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index faedd0e..acb7f90 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -78,11 +78,6 @@ enum ad7887_supported_device_ids {
>  static int ad7887_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7887_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = iio_sw_buffer_preenable(indio_dev);
> -	if (ret < 0)
> -		return ret;
>  
>  	/* We know this is a single long so can 'cheat' */
>  	switch (*indio_dev->active_scan_mask) {
> 
