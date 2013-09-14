Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39500 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab3INJh0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:37:26 -0400
Message-ID: <52343C74.4060003@kernel.org>
Date: Sat, 14 Sep 2013 11:37:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: gyro: adxrs450: Remove redundant break
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org> <1378894829-8173-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 11:20, Sachin Kamat wrote:
> 'break' after return is redundant. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git
> ---
>  drivers/iio/gyro/adxrs450.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index 6dab299..c1f40ef 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -354,7 +354,6 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
>  		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
>  		if (ret)
> 
