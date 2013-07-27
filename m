Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53829 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3G0LBF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 07:01:05 -0400
Message-ID: <51F3B683.50209@kernel.org>
Date: Sat, 27 Jul 2013 13:01:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/15] staging:iio:adis16260: Fix minor style issue
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> Delete some extra whitespace.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index c70094f..4b62000 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -131,9 +131,9 @@ static ssize_t adis16260_read_frequency(struct device *dev,
>  		return ret;
>  
>  	if (spi_get_device_id(adis->spi)->driver_data) /* If an adis16251 */
> -		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
> +		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
>  	else
> -		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
> +		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
>  	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
>  	len = sprintf(buf, "%d SPS\n", sps);
>  	return len;
> 
