Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48402 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3K3LOd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:14:33 -0500
Message-ID: <5299C898.5020501@kernel.org>
Date: Sat, 30 Nov 2013 11:14:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 15/15] staging:iio:ad9834: Mark transfer buffers as __b16
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-15-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/staging/iio/frequency/ad9834.c:45:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:45:26:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:45:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:47:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:47:26:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:47:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:59:18: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:59:18:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:59:18:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:100:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:100:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:100:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:108:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:108:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:108:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:122:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:122:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:122:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:131:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:131:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:131:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:194:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:194:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:194:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9834.c:387:18: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9834.c:387:18:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9834.c:387:18:    got restricted __be16 [usertype] <noident>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/frequency/ad9834.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
> index ed5ed8d..8ca6e52 100644
> --- a/drivers/staging/iio/frequency/ad9834.h
> +++ b/drivers/staging/iio/frequency/ad9834.h
> @@ -65,8 +65,8 @@ struct ad9834_state {
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	unsigned short			data ____cacheline_aligned;
> -	unsigned short			freq_data[2] ;
> +	__be16				data ____cacheline_aligned;
> +	__be16				freq_data[2];
>  };
>  
>  
> 
