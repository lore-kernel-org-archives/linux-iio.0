Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53845 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3G0LBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 07:01:51 -0400
Message-ID: <51F3B6B1.1040702@kernel.org>
Date: Sat, 27 Jul 2013 13:01:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/15] staging:iio:adis16260: Remove 'SPS' suffix from
 samplerate attribute
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> This is not part of the ABI.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
I thought we had cleared all these out long ago.

Oh well,

Applied to the togreg branch of iio.git

Thanks.
> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 4b62000..a140d73 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -135,7 +135,7 @@ static ssize_t adis16260_read_frequency(struct device *dev,
>  	else
>  		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
>  	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
> -	len = sprintf(buf, "%d SPS\n", sps);
> +	len = sprintf(buf, "%d\n", sps);
>  	return len;
>  }
>  
> 
