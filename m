Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42773 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbaKEOB3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 09:01:29 -0500
Message-ID: <545A2DB8.8050607@kernel.org>
Date: Wed, 05 Nov 2014 14:01:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:ade7758: Fix check if channels are enabled
 in prenable
References: <1415120596-21704-1-git-send-email-lars@metafoo.de> <1415120596-21704-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1415120596-21704-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/14 17:03, Lars-Peter Clausen wrote:
> We should check if a channel is enabled, not if no channels are enabled.
> 
> Fixes: 550268ca1111 ("staging:iio: scrap scan_count and ensure all drivers use active_scan_mask")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,
> ---
>  drivers/staging/iio/meter/ade7758_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 628e902..6e90064 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -87,7 +87,7 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	unsigned channel;
>  
> -	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
> +	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
>  		return -EINVAL;
>  
>  	channel = find_first_bit(indio_dev->active_scan_mask,
> 
