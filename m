Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3KgM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 06:36:12 -0400
Date: Fri, 30 Mar 2018 11:36:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps
Message-ID: <20180330113606.1eba6011@archlinux>
In-Reply-To: <20180328174029.1045-1-mkelly@xevo.com>
References: <20180328174029.1045-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 28 Mar 2018 10:40:29 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> When interrupts are generated at a slower rate than the FIFO fills up,
> we will have fewer timestamps than samples. Currently, we fill in 0 for
> any unmatched timestamps. However, this is very confusing for userspace,
> which does not expect discontinuities in timestamps and must somehow
> work around the issue.
> 
> Improve the situation by interpolating timestamps when we can't map them
> 1:1 to data. We do this by assuming the timestamps we have are the most
> recent and interpolating backwards to fill the older data. This makes
> sense because inv_mpu6050_read_fifo gets called right after an interrupt
> is generated, presumably when a datum was generated, so the most recent
> timestamp matches up with the most recent datum. In addition, this
> assumption is borne out by observation, which shows monotonically
> increasing timestamps when interpolating this way but discontinuities
> when interpolating in the other direction.
> 
> Although this method is not perfectly accurate, it is probably the best
> we can do if we don't get one interrupt per datum.
This patch worries me somewhat - we are basically guessing what the cause
of the missed interrupts was.  If for example the fifo read itself
takes a long time, the interrupt time we have is actually valid for
the first sample and we should in interpolating forwards in time.

It sounds from discussions like something else is broken on your
board.  I like the idea of interpolating interrupts, but would like to
conduct the same experiments you did when we are running at high speeds
and seeing misses - not on the test case you currently have.

The problem then will be estimating how long the interrupt took to
be handed vs the read out rate of the fifo.  Chances are our 'correct'
timestamp is somewhat after the first reading but well before the last
one.

Anyhow, let us know once you have the thing running properly at
high speed then we can work out how best to address this.

Jonathan

> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 50 +++++++++++++++++++++++++++---
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> v1:
> - Set a missing timestamp to the last timestamp we saw.
> v2:
> - Interpolate missing timestamps.
> v3:
> - Slight optimization to move timestamp_interp += into the result == 0 case.
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7d64be353403..4a95ff8df3b9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -83,6 +83,7 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.fsr = INV_MPU6050_FSR_2000DPS,
>  	.lpf = INV_MPU6050_FILTER_20HZ,
>  	.fifo_rate = INV_MPU6050_INIT_FIFO_RATE,
> +	.fifo_period = NSEC_PER_SEC / INV_MPU6050_INIT_FIFO_RATE,
>  	.gyro_fifo_enable = false,
>  	.accl_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
> @@ -630,6 +631,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	if (result)
>  		goto fifo_rate_fail_power_off;
>  	st->chip_config.fifo_rate = fifo_rate;
> +	st->chip_config.fifo_period = NSEC_PER_SEC / fifo_rate;
>  
>  	result = inv_mpu6050_set_lpf(st, fifo_rate);
>  	if (result)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 065794162d65..3bc7d62822ca 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -86,6 +86,7 @@ enum inv_devices {
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
>   *  @fifo_rate:		FIFO update rate.
> + *  @fifo_period:	FIFO update period, in nanoseconds.
>   */
>  struct inv_mpu6050_chip_config {
>  	unsigned int fsr:2;
> @@ -94,6 +95,7 @@ struct inv_mpu6050_chip_config {
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
>  	u16 fifo_rate;
> +	u32 fifo_period;
>  };
>  
>  /**
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index ff81c6aa009d..40610a316eb0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -126,7 +126,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	int result;
>  	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>  	u16 fifo_count;
> +	u16 fifo_items;
> +	s32 fifo_diff;
>  	s64 timestamp;
> +	s64 timestamp_interp;
> +	s64 offset;
>  
>  	mutex_lock(&st->lock);
>  	if (!(st->chip_config.accl_fifo_enable |
> @@ -156,9 +160,25 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
>  		goto flush_fifo;
>  	/* Timestamp mismatch. */
> +	fifo_items = fifo_count / bytes_per_datum;
>  	if (kfifo_len(&st->timestamps) >
> -	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
> +	    fifo_items + INV_MPU6050_TIME_STAMP_TOR)
>  		goto flush_fifo;
> +
> +	/*
> +	 * If we have more data than timestamps, the timestamps we have
> +	 * correspond to the newest items in the FIFO, since some data was
> +	 * generated without a corresponding interrupt and thus timestamp. Since
> +	 * we remove FIFO items oldest to newest, we need to interpolate the
> +	 * older timestamps based on the number of missing timestamps.
> +	 */
> +	fifo_diff = fifo_items - kfifo_len(&st->timestamps);
> +	if (fifo_diff > 0)
> +		offset = st->chip_config.fifo_period * fifo_diff;
> +	else
> +		offset = 0;
> +
> +	timestamp_interp = 0;
>  	while (fifo_count >= bytes_per_datum) {
>  		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>  					  data, bytes_per_datum);
> @@ -166,9 +186,31 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  			goto flush_fifo;
>  
>  		result = kfifo_out(&st->timestamps, &timestamp, 1);
> -		/* when there is no timestamp, put timestamp as 0 */
> -		if (result == 0)
> -			timestamp = 0;
> +		/* When there is no timestamp, interpolate based on period */
> +		if (result == 0) {
> +			/*
> +			 * We have no more timestamps left, so interpolate the
> +			 * rest of them.
> +			 */
> +			if (likely(timestamp_interp != 0))
> +				timestamp_interp += st->chip_config.fifo_period;
> +			else
> +				/*
> +				 * In this unlikely error case, we should output
> +				 * a 0 timestamp instead of 0 + FIFO period.
> +				 */
> +				dev_err(regmap_get_device(st->map),
> +					"Timestamp FIFO is empty!\n");
> +			timestamp = timestamp_interp;
> +		} else {
> +			/*
> +			 * If we are interpolating, this is an older datum with
> +			 * a newer timestamp, so offset it backwards to account
> +			 * for the time gap.  Otherwise, offset will be 0.
> +			 */
> +			timestamp -= offset;
> +			timestamp_interp = timestamp;
> +		}
>  
>  		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
>  							    timestamp);

