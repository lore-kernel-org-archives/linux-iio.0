Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34124 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757464AbeD1P5U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Apr 2018 11:57:20 -0400
Date: Sat, 28 Apr 2018 16:57:17 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: imu: inv_mpu6050: clean read channel data
 error path
Message-ID: <20180428165717.5e127f3c@archlinux>
In-Reply-To: <1524479613-23954-4-git-send-email-jmaneyrol@invensense.com>
References: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
        <1524479613-23954-4-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Apr 2018 12:33:33 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Delete the useless ored result and give a second chance to turn
> the chip back off at the end.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hmm. I'm not totally sold on the 'try powering down' again
option.  That seems somewhat inelegant.  Ah well, it's a minor
thing as all sorts of horrible things will happen if we fail the second
powerdown anyway.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 79b44fd..aafa777 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -338,7 +338,7 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	int result;
> -	int ret = IIO_VAL_INT;
> +	int ret;
>  
>  	result = iio_device_claim_direct_mode(indio_dev);
>  	if (result)
> @@ -383,14 +383,18 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
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

