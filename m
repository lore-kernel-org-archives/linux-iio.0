Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53620 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeEFRGt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 May 2018 13:06:49 -0400
Date: Sun, 6 May 2018 18:06:45 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 1/2] iio: imu: inv_mpu6050: minor wording fixes
Message-ID: <20180506180645.3cf3d4ca@archlinux>
In-Reply-To: <20180501175642.8551-2-mkelly@xevo.com>
References: <20180501175642.8551-1-mkelly@xevo.com>
        <20180501175642.8551-2-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  1 May 2018 10:56:41 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Just some minor grammar/spelling fixes of things I noticed while reading
> the code.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Good to clean this sort of thing up.

Thanks and applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to ignore it ;)

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index aafa77766b08..59dbdeb08da4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -176,7 +176,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  		return result;
>  
>  	if (en) {
> -		/* Wait for output stabilize */
> +		/* Wait for output to stabilize */
>  		msleep(INV_MPU6050_TEMP_UP_TIME);
>  		if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
>  			/* switch internal clock to PLL */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 90fdc5eaef53..65dcb92be9f6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -53,7 +53,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  
>  	mutex_lock(&st->lock);
>  
> -	/* It doesn't really mattter, if any of the calls fails */
> +	/* It doesn't really matter if any of the calls fail */
>  	regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
>  	inv_mpu6050_set_power_itg(st, false);
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index e51404fdce97..0cb7c20100ca 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -155,7 +155,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
>  
>  	/*
> -	 * read fifo_count register to know how many bytes inside FIFO
> +	 * read fifo_count register to know how many bytes are inside the FIFO
>  	 * right now
>  	 */
>  	result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
> @@ -165,7 +165,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
>  	if (fifo_count < bytes_per_datum)
>  		goto end_session;
> -	/* fifo count can't be odd number, if it is odd, reset fifo*/
> +	/* fifo count can't be an odd number. If it is odd, reset the FIFO. */
>  	if (fifo_count & 1)
>  		goto flush_fifo;
>  	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)

