Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49430 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeE0KGb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 May 2018 06:06:31 -0400
Date: Sun, 27 May 2018 11:06:29 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: imu: inv_mpu6050: better fifo overflow
 handling
Message-ID: <20180527110629.07fa7c17@archlinux>
In-Reply-To: <20180522141822.11598-4-jmaneyrol@invensense.com>
References: <20180522141822.11598-1-jmaneyrol@invensense.com>
        <20180522141822.11598-4-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 16:18:21 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Use fifo overflow bit from int status rather than using an
> arbitrary threshold.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index a1130b9a420c..6bc80ac9d120 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -166,6 +166,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_REG_RAW_GYRO            0x43
>  
>  #define INV_MPU6050_REG_INT_STATUS          0x3A
> +#define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
>  #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
>  
>  #define INV_MPU6050_REG_USER_CTRL           0x6A
> @@ -190,7 +191,6 @@ struct inv_mpu6050_state {
>  
>  #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
>  #define INV_MPU6050_FIFO_COUNT_BYTE          2
> -#define INV_MPU6050_FIFO_THRESHOLD           500
>  
>  /* mpu6500 registers */
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 7724888a4696..7a4aaed83044 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -110,6 +110,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  			"failed to ack interrupt\n");
>  		goto flush_fifo;
>  	}
> +	/* handle fifo overflow by reseting fifo */
> +	if (int_status & INV_MPU6050_BIT_FIFO_OVERFLOW_INT)
> +		goto flush_fifo;
>  	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {
>  		dev_warn(regmap_get_device(st->map),
>  			"spurious interrupt with status 0x%x\n", int_status);
> @@ -135,8 +138,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (result)
>  		goto end_session;
>  	fifo_count = get_unaligned_be16(&data[0]);
> -	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
> -		goto flush_fifo;
>  	/* compute and process all complete datum */
>  	nb = fifo_count / bytes_per_datum;
>  	for (i = 0; i < nb; ++i) {

