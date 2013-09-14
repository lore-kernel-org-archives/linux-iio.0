Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39493 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab3INJhT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:37:19 -0400
Message-ID: <52343C6C.2060905@kernel.org>
Date: Sat, 14 Sep 2013 11:37:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: gyro: adis16260: Remove redundant break
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org> <1378894829-8173-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 11:20, Sachin Kamat wrote:
> 'break' after return is redundant. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git
> ---
>  drivers/iio/gyro/adis16260.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index 0654116..22b6fb8 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -239,7 +239,6 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = 250000 / 1453; /* 25 C = 0x00 */
>  		return IIO_VAL_INT;
> 
