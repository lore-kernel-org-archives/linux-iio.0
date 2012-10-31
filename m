Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48627 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab2JaKu2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Oct 2012 06:50:28 -0400
Message-ID: <5091026C.6070200@kernel.org>
Date: Wed, 31 Oct 2012 10:50:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 1/2] staging:iio:adt7410: Fix adt7410_set_mode return
 value
References: <1350898942-29586-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1350898942-29586-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/2012 10:42 AM, Lars-Peter Clausen wrote:
> The function is expected to return the number of bytes consumed and as long as
> not all bytes have been consumed the function will be called again. Currently
> the function returns 'ret', which will always be 0 in this case, so we end up in
> a endless loop since the caller will assume that no bytes have been consumed. So
> instead return len as it is supposed to.

> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Added to fixes-togreg branch of iio.git

> ---
>  drivers/staging/iio/adc/adt7410.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
> index 4157596..3cf5103 100644
> --- a/drivers/staging/iio/adc/adt7410.c
> +++ b/drivers/staging/iio/adc/adt7410.c
> @@ -190,7 +190,7 @@ static ssize_t adt7410_store_mode(struct device *dev,
>  
>  	chip->config = config;
>  
> -	return ret;
> +	return len;
>  }
>  
>  static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
> 
