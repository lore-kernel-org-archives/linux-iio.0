Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57457 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcBYTuH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2016 14:50:07 -0500
Subject: Re: [PATCH 1/5] iio: imu: mpu6050: use inv_mpu6050_sensor_show return
 code
To: Matt Ranostay <matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
 <1456177151-15881-2-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CF5AEC.1000402@kernel.org>
Date: Thu, 25 Feb 2016 19:50:04 +0000
MIME-Version: 1.0
In-Reply-To: <1456177151-15881-2-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/16 21:39, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Wouldn't apply automatically so I did it manually.

Anyhow, applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play tennis with it.

J
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 225860016fed..4324328fd304 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -275,7 +275,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  		case IIO_TEMP:
>  			/* wait for stablization */
>  			msleep(INV_MPU6050_SENSOR_UP_TIME);
> -			inv_mpu6050_sensor_show(st, st->reg->temperature,
> +			ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>  							IIO_MOD_X, val);
>  			break;
>  		default:
> 

