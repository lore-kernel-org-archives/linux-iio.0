Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60787 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcBUVMZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 16:12:25 -0500
Subject: Re: [PATCH] iio: imu: mpu6050: remove trailing whitespaces
To: Matt Ranostay <matt.ranostay@intel.com>, adriana.reus@intel.com
References: <1455775103-18130-1-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA2836.6000908@kernel.org>
Date: Sun, 21 Feb 2016 21:12:22 +0000
MIME-Version: 1.0
In-Reply-To: <1455775103-18130-1-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/16 05:58, Matt Ranostay wrote:
> removed several trailing whitespaces before assignment operations
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Applied with some fuzz from other recent patches on this driver.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 225860016fed..cbc8c74d4692 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -244,7 +244,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  				if (result)
>  					goto error_read_raw;
>  			}
> -			ret =  inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
> +			ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
>  						chan->channel2, val);
>  			if (!st->chip_config.gyro_fifo_enable ||
>  					!st->chip_config.enable) {
> @@ -567,7 +567,7 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
>  		.type = _type,                                        \
>  		.modified = 1,                                        \
>  		.channel2 = _channel2,                                \
> -		.info_mask_shared_by_type =  BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
>  		.scan_index = _index,                                 \
>  		.scan_type = {                                        \
> @@ -587,7 +587,7 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
>  	 */
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
>  				| BIT(IIO_CHAN_INFO_OFFSET)
>  				| BIT(IIO_CHAN_INFO_SCALE),
>  		.scan_index = -1,
> 

