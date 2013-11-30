Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48215 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3K3LHa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:07:30 -0500
Message-ID: <5299C6F1.8080809@kernel.org>
Date: Sat, 30 Nov 2013 11:07:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/15] iio:ad5421: Mark transfer buffer as __be32
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:41, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/iio/dac/ad5421.c:134:25: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5421.c:134:25:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5421.c:134:25:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5421.c:168:25: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5421.c:168:25:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5421.c:168:25:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

thanks
> ---
>  drivers/iio/dac/ad5421.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index 3eeaa82..fcb599c 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -75,7 +75,7 @@ struct ad5421_state {
>  	 * transfer buffers to live in their own cache lines.
>  	 */
>  	union {
> -		u32 d32;
> +		__be32 d32;
>  		u8 d8[4];
>  	} data[2] ____cacheline_aligned;
>  };
> 
