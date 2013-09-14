Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39484 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab3INJhJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:37:09 -0400
Message-ID: <52343C63.7090508@kernel.org>
Date: Sat, 14 Sep 2013 11:37:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: gyro: adis16130: Remove redundant break
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 11:20, Sachin Kamat wrote:
> 'break' after return is redundant. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git
> ---
>  drivers/iio/gyro/adis16130.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
> index ac66fc1..9155cf6 100644
> --- a/drivers/iio/gyro/adis16130.c
> +++ b/drivers/iio/gyro/adis16130.c
> @@ -103,7 +103,6 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> @@ -115,7 +114,6 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		break;
>  	}
>  
>  	return -EINVAL;
> 
