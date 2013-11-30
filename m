Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48394 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3K3LOL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:14:11 -0500
Message-ID: <5299C882.8020509@kernel.org>
Date: Sat, 30 Nov 2013 11:14:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/15] staging:iio:ad9832: Mark transfer buffers as __be16
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-14-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/staging/iio/frequency/ad9832.c:43:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:43:26:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:43:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:46:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:46:26:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:46:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:49:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:49:26:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:49:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:52:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:52:26:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:52:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:65:27: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:65:27:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:65:27:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:68:27: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:68:27:    expected unsigned short [unsigned] [short] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:68:27:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:107:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:107:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9832.c:107:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:120:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:120:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9832.c:120:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:133:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:133:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9832.c:133:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:144:26: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:144:26:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9832.c:144:26:    got restricted __be16 [usertype] <noident>
> 	drivers/staging/iio/frequency/ad9832.c:277:18: warning: incorrect type in assignment (different base types)
> 	drivers/staging/iio/frequency/ad9832.c:277:18:    expected unsigned short [unsigned] data
> 	drivers/staging/iio/frequency/ad9832.c:277:18:    got restricted __be16 [usertype] <noident>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/frequency/ad9832.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
> index c5b701f..386f4dc 100644
> --- a/drivers/staging/iio/frequency/ad9832.h
> +++ b/drivers/staging/iio/frequency/ad9832.h
> @@ -92,9 +92,9 @@ struct ad9832_state {
>  	 * transfer buffers to live in their own cache lines.
>  	 */
>  	union {
> -		unsigned short		freq_data[4]____cacheline_aligned;
> -		unsigned short		phase_data[2];
> -		unsigned short		data;
> +		__be16			freq_data[4]____cacheline_aligned;
> +		__be16			phase_data[2];
> +		__be16			data;
>  	};
>  };
>  
> 
