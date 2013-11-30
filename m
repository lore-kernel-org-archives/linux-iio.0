Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48222 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3K3LHx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:07:53 -0500
Message-ID: <5299C708.5030600@kernel.org>
Date: Sat, 30 Nov 2013 11:07:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/15] iio:ad5686: Mark transfer buffer as __be32
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:41, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/iio/dac/ad5686.c:100:25: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5686.c:100:25:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5686.c:100:25:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5686.c:122:25: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5686.c:122:25:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5686.c:122:25:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5686.c:124:25: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5686.c:124:25:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5686.c:124:25:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/ad5686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 30e506e..e56ec0a 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -78,7 +78,7 @@ struct ad5686_state {
>  	 */
>  
>  	union {
> -		u32 d32;
> +		__be32 d32;
>  		u8 d8[4];
>  	} data[3] ____cacheline_aligned;
>  };
> 
