Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:37882 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeDUPLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Apr 2018 11:11:11 -0400
Date: Sat, 21 Apr 2018 16:11:07 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: imu: inv_mpu6050: clean read channel data
 error path
Message-ID: <20180421161107.4f9b3535@archlinux>
In-Reply-To: <1523952442-20104-4-git-send-email-jmaneyrol@invensense.com>
References: <1523952442-20104-1-git-send-email-jmaneyrol@invensense.com>
        <1523952442-20104-4-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Apr 2018 10:07:22 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

Nice to have some description of how it was cleaned + a signed-off-by...

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index a0cecd9..b842caf 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -330,7 +330,7 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	int result;
> -	int ret = IIO_VAL_INT;
> +	int ret;
>  
>  	result = iio_device_claim_direct_mode(indio_dev);
>  	if (result)
> @@ -375,14 +375,18 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  		break;
>  	}
>  
> -error_power_off:
> -	result |= inv_mpu6050_set_power_itg(st, false);
> -error_release:
> -	iio_device_release_direct_mode(indio_dev);
> +	result = inv_mpu6050_set_power_itg(st, false);
>  	if (result)
> -		return result;
> +		goto error_power_off;
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +error_release:
> +	iio_device_release_direct_mode(indio_dev);
> +	return result;
>  }
>  
>  static int

