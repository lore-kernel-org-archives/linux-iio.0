Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47000 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab2IHJgb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Sep 2012 05:36:31 -0400
Message-ID: <504B119E.8060005@kernel.org>
Date: Sat, 08 Sep 2012 10:36:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 01/10] staging:iio:ad7476: Fix off by one error for channel
 shift
References: <1347021872-7885-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2012 01:44 PM, Lars-Peter Clausen wrote:
> The datasheet is a bit confusing about this. It says that a dataword has 4
> leading zeros, but the first zero is already put on the bus when CS is pulled
> low and the second zero is put on the bus on the first leading edge of SCLK, so
> when the first bit is sampled on the first trailing edge it will sample what the
> datasheet refers to as the second leading zero. Subsequently we only see 3
> leading zeros in the 16 bit dataword and the result we get is shifted to the
> left by one bit. Fix this by adjusting the channel shift by 1.
> 
I'll take your word for it :)
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/ad7476_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index 4f6d59e..33435ed 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -76,7 +76,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  		.sign = 'u',					\
>  		.realbits = bits,				\
>  		.storagebits = 16,				\
> -		.shift = 12 - bits,				\
> +		.shift = 13 - bits,				\
>  	},							\
>  }
>  
> 
