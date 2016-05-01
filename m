Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48760 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbcEAVZ7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:25:59 -0400
Subject: Re: [PATCH 4/7] iio: inv_mpu6050: Cache non-volatile bits of
 user_ctrl
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <61308d29e0ab8e42c5def8f556e2c3ee86a41c1c.1461953982.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <26adc8b9-b39e-876c-2e01-10b53a46c621@kernel.org>
Date: Sun, 1 May 2016 18:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <61308d29e0ab8e42c5def8f556e2c3ee86a41c1c.1461953982.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 20:02, Crestez Dan Leonard wrote:
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Again, fine but irritating that you have to do this!

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 9 ++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 4 +++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 297b0ef..bd2c0fd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -80,6 +80,7 @@ enum inv_devices {
>   *  @enable:		master enable state.
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
> + *  @user_ctrl:		The non-volatile bits of user_ctrl
>   *  @fifo_rate:		FIFO update rate.
>   */
>  struct inv_mpu6050_chip_config {
> @@ -89,6 +90,7 @@ struct inv_mpu6050_chip_config {
>  	unsigned int enable:1;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
> +	u8 user_ctrl;
>  	u16 fifo_rate;
>  };
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 3fc0b71..56ee1e2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -53,13 +53,15 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  	if (result)
>  		goto reset_fifo_fail;
>  	/* disable fifo reading */
> -	result = regmap_write(st->map, st->reg->user_ctrl, 0);
> +	st->chip_config.user_ctrl &= ~INV_MPU6050_BIT_FIFO_EN;
> +	result = regmap_write(st->map, st->reg->user_ctrl,
> +			      st->chip_config.user_ctrl);
>  	if (result)
>  		goto reset_fifo_fail;
>  
>  	/* reset FIFO*/
>  	result = regmap_write(st->map, st->reg->user_ctrl,
> -			      INV_MPU6050_BIT_FIFO_RST);
> +			      st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST);
>  	if (result)
>  		goto reset_fifo_fail;
>  
> @@ -76,8 +78,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  			return result;
>  	}
>  	/* enable FIFO reading and I2C master interface*/
> +	st->chip_config.user_ctrl |= INV_MPU6050_BIT_FIFO_EN;
>  	result = regmap_write(st->map, st->reg->user_ctrl,
> -			      INV_MPU6050_BIT_FIFO_EN);
> +			      st->chip_config.user_ctrl);
>  	if (result)
>  		goto reset_fifo_fail;
>  	/* enable sensor output to FIFO */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 1a6bad3..fc55923 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -74,7 +74,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			return result;
>  
> -		result = regmap_write(st->map, st->reg->user_ctrl, 0);
> +		st->chip_config.user_ctrl &= ~INV_MPU6050_BIT_FIFO_EN;
> +		result = regmap_write(st->map, st->reg->user_ctrl,
> +				      st->chip_config.user_ctrl);
>  		if (result)
>  			return result;
>  
> 

