Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54192 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbbA3Vzd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 16:55:33 -0500
Message-ID: <54CBFDD2.9020604@kernel.org>
Date: Fri, 30 Jan 2015 21:55:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: k.wrona@samsung.com, kbuild-all@01.org
Subject: Re: [PATCH] iio:common:ssp_sensors fix warnings due to 32 bit instead
 of 64 bit passed to do_div
References: <1422642358-30473-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1422642358-30473-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/15 18:25, Jonathan Cameron wrote:
> Fixes warnings with asm-generic/div64.h do_div such as:
>    In file included from drivers/iio/common/ssp_sensors/ssp_iio.c:20:0:
>    drivers/iio/common/ssp_sensors/ssp_iio_sensor.h: In function 'ssp_convert_to_freq':
>>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:16: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>    drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warning: right shift count >= width of type [enabled by default]
>>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warning: passing argument 1 of '__div64_32' from incompatible pointer type [enabled by default]
>    include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but argument is of type 'int *'
>    drivers/iio/common/ssp_sensors/ssp_iio.c: In function 'ssp_common_process_data':
>    include/linux/iio/buffer.h:142:32: warning: 'calculated_time' may be used uninitialized in this function [-Wuninitialized]
>    drivers/iio/common/ssp_sensors/ssp_iio.c:83:10: note: 'calculated_time' was declared here
> 
> Fixed by using straight coded version as per the description in the
> div64.h header, thus ensuring no issue with 32 bit integers.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
hmm. failed the build tests. I'd missed SSP_INVERTED_SCALING_FACTOR is forced
to be ULL.  Any reason for that? 

I can't immediately see that it is necessary. Being rather tired and
running out of evening, I've pushed a version with the LL dropped out
to testing to see if that causes any build issues.

What fun,

Jonathan
> ---
>  drivers/iio/common/ssp_sensors/ssp_iio_sensor.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> index dda267c9bd2a..fdf61a8c499a 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> @@ -53,7 +53,8 @@ static inline void ssp_convert_to_freq(u32 time, int *integer_part,
>  	}
>  
>  	*integer_part = SSP_FACTOR_WITH_MS / time;
> -	*fractional = do_div(*integer_part, SSP_INVERTED_SCALING_FACTOR);
> +	*fractional = *integer_part % SSP_INVERTED_SCALING_FACTOR;
> +	*integer_part = *integer_part / SSP_INVERTED_SCALING_FACTOR;
>  }
>  
>  /* Converts frequency to time in ms */
> 

