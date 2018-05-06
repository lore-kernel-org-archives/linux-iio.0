Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53536 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeEFRBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 May 2018 13:01:55 -0400
Date: Sun, 6 May 2018 18:01:53 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: fix user_ctrl register
 overwritten
Message-ID: <20180506180153.46c62fb6@archlinux>
In-Reply-To: <1525083251-8368-4-git-send-email-jmaneyrol@invensense.com>
References: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
        <1525083251-8368-4-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 30 Apr 2018 12:14:11 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> When in spi mode, we are setting i2c disable bit in user_ctrl
> register. But the register is overwritten after when turning fifo
> on. So save user_ctrl init value and always use it when updating
> the register.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied, thanks.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  7 ++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 13 +++++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  5 +++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  3 ++-
>  5 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7358935..50c33e2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -88,6 +88,7 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.gyro_fifo_enable = false,
>  	.accl_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
> +	.user_ctrl = 0,
>  };
>  
>  /* Indexed by enum inv_devices */
> @@ -972,15 +973,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	if (result)
>  		return result;
>  
> -	if (inv_mpu_bus_setup)
> -		inv_mpu_bus_setup(indio_dev);
> -
>  	result = inv_mpu6050_init_config(indio_dev);
>  	if (result) {
>  		dev_err(dev, "Could not initialize device.\n");
>  		return result;
>  	}
>  
> +	if (inv_mpu_bus_setup)
> +		inv_mpu_bus_setup(indio_dev);
> +
>  	dev_set_drvdata(dev, indio_dev);
>  	indio_dev->dev.parent = dev;
>  	/* name will be NULL when enumerated via ACPI */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index dfb9e4e..c54da77 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -97,6 +97,7 @@ struct inv_mpu6050_chip_config {
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
>  	u16 fifo_rate;
> +	u8 user_ctrl;
>  };
>  
>  /**
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 1b57354..e7b23e3 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -51,13 +51,14 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  	if (result)
>  		goto reset_fifo_fail;
>  	/* disable fifo reading */
> -	result = regmap_write(st->map, st->reg->user_ctrl, 0);
> +	result = regmap_write(st->map, st->reg->user_ctrl,
> +			      st->chip_config.user_ctrl);
>  	if (result)
>  		goto reset_fifo_fail;
>  
>  	/* reset FIFO*/
> -	result = regmap_write(st->map, st->reg->user_ctrl,
> -			      INV_MPU6050_BIT_FIFO_RST);
> +	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
> +	result = regmap_write(st->map, st->reg->user_ctrl, d);
>  	if (result)
>  		goto reset_fifo_fail;
>  
> @@ -72,9 +73,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  		if (result)
>  			return result;
>  	}
> -	/* enable FIFO reading and I2C master interface*/
> -	result = regmap_write(st->map, st->reg->user_ctrl,
> -			      INV_MPU6050_BIT_FIFO_EN);
> +	/* enable FIFO reading */
> +	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
> +	result = regmap_write(st->map, st->reg->user_ctrl, d);
>  	if (result)
>  		goto reset_fifo_fail;
>  	/* enable sensor output to FIFO */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index fe0bf5a..227f50a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -31,8 +31,9 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_write(st->map, INV_MPU6050_REG_USER_CTRL,
> -			   INV_MPU6050_BIT_I2C_IF_DIS);
> +	st->chip_config.user_ctrl |= INV_MPU6050_BIT_I2C_IF_DIS;
> +	ret = regmap_write(st->map, st->reg->user_ctrl,
> +			   st->chip_config.user_ctrl);
>  	if (ret) {
>  		inv_mpu6050_set_power_itg(st, false);
>  		return ret;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 0d7db27..d3e26ae 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -76,7 +76,8 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			goto error_accl_off;
>  
> -		result = regmap_write(st->map, st->reg->user_ctrl, 0);
> +		result = regmap_write(st->map, st->reg->user_ctrl,
> +				      st->chip_config.user_ctrl);
>  		if (result)
>  			goto error_accl_off;
>  

