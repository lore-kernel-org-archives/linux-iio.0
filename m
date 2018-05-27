Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49448 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeE0KHS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 May 2018 06:07:18 -0400
Date: Sun, 27 May 2018 11:07:16 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: imu: inv_mpu6050: new timestamp mechanism
Message-ID: <20180527110716.5b12016c@archlinux>
In-Reply-To: <20180522141822.11598-5-jmaneyrol@invensense.com>
References: <20180522141822.11598-1-jmaneyrol@invensense.com>
        <20180522141822.11598-5-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 16:18:22 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Check validity of interrupt timestamps by computing time between
> 2 interrupts. If it matches the chip frequency modulo 4%, it is
> used as the data timestamp and also for estimating the chip
> frequency measured from the system. Otherwise timestamp is
> computed using the estimated chip frequency.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  7 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 +++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 81 +++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 2c3e666aa970..93c64f30b615 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -295,6 +295,13 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	memcpy(&st->chip_config, hw_info[st->chip_type].config,
>  	       sizeof(struct inv_mpu6050_chip_config));
>  
> +	/*
> +	 * Internal chip period is 1ms (1kHz).
> +	 * Let's use at the beginning the theorical value before measuring
> +	 * with interrupt timestamps.
> +	 */
> +	st->chip_period = NSEC_PER_MSEC;
> +
>  	return inv_mpu6050_set_power_itg(st, false);
>  
>  error_power_off:
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 6bc80ac9d120..de8391693e17 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -125,6 +125,9 @@ struct inv_mpu6050_hw {
>   *  @map		regmap pointer.
>   *  @irq		interrupt number.
>   *  @irq_mask		the int_pin_cfg mask to configure interrupt type.
> + *  @chip_period:	chip internal period estimation (~1kHz).
> + *  @it_timestamp:	timestamp from previous interrupt.
> + *  @data_timestamp:	timestamp for next data sample.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -142,6 +145,9 @@ struct inv_mpu6050_state {
>  	int irq;
>  	u8 irq_mask;
>  	unsigned skip_samples;
> +	s64 chip_period;
> +	s64 it_timestamp;
> +	s64 data_timestamp;
>  };
>  
>  /*register and associated bit definition*/
> @@ -223,6 +229,8 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_LATCH_INT_EN	0x20
>  #define INV_MPU6050_BIT_BYPASS_EN	0x2
>  
> +/* Allowed timestamp period jitter in percent */
> +#define INV_MPU6050_TS_PERIOD_JITTER	4
>  
>  /* init parameters */
>  #define INV_MPU6050_INIT_FIFO_RATE           50
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 7a4aaed83044..6930af413397 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -23,12 +23,89 @@
>  #include <asm/unaligned.h>
>  #include "inv_mpu_iio.h"
>  
> +/**
> + *  inv_mpu6050_update_period() - Update chip internal period estimation
> + *
> + *  @st:		driver state
> + *  @timestamp:		the interrupt timestamp
> + *  @nb:		number of data set in the fifo
> + *
> + *  This function uses interrupt timestamps to estimate the chip period and
> + *  to choose the data timestamp to come.
> + */
> +static void inv_mpu6050_update_period(struct inv_mpu6050_state *st,
> +				      s64 timestamp, size_t nb)
> +{
> +	/* Period boundaries for accepting timestamp */
> +	const s64 period_min =
> +		(NSEC_PER_MSEC * (100 - INV_MPU6050_TS_PERIOD_JITTER)) / 100;
> +	const s64 period_max =
> +		(NSEC_PER_MSEC * (100 + INV_MPU6050_TS_PERIOD_JITTER)) / 100;
> +	const unsigned divider = INV_MPU6050_FREQ_DIVIDER(st);
> +	s64 delta, interval;
> +	bool use_it_timestamp = false;
> +
> +	if (st->it_timestamp == 0) {
> +		/* not initialized, forced to use it_timestamp */
> +		use_it_timestamp = true;
> +	} else if (nb == 1) {
> +		/*
> +		 * Validate the use of it timestamp by checking if interrupt
> +		 * has been delayed.
> +		 * nb > 1 means interrupt was delayed for more than 1 sample,
> +		 * so it's obviously not good.
> +		 * Compute the chip period between 2 interrupts for validating.
> +		 */
> +		delta = (timestamp - st->it_timestamp) / divider;
> +		if (delta > period_min && delta < period_max) {
> +			/* update chip period and use it timestamp */
> +			st->chip_period = (st->chip_period + delta) / 2;
> +			use_it_timestamp = true;
> +		}
> +	}
> +
> +	if (use_it_timestamp) {
> +		/*
> +		 * Manage case of multiple samples in the fifo (nb > 1):
> +		 * compute timestamp corresponding to the first sample using
> +		 * estimated chip period.
> +		 */
> +		interval = (nb - 1) * st->chip_period * divider;
> +		st->data_timestamp = timestamp - interval;
> +	}
> +
> +	/* save it timestamp */
> +	st->it_timestamp = timestamp;
> +}
> +
> +/**
> + *  inv_mpu6050_get_timestamp() - Return the current data timestamp
> + *
> + *  @st:		driver state
> + *  @return:		current data timestamp
> + *
> + *  This function returns the current data timestamp and prepares for next one.
> + */
> +static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
> +{
> +	s64 ts;
> +
> +	/* return current data timestamp and increment */
> +	ts = st->data_timestamp;
> +	st->data_timestamp += st->chip_period * INV_MPU6050_FREQ_DIVIDER(st);
> +
> +	return ts;
> +}
> +
>  int inv_reset_fifo(struct iio_dev *indio_dev)
>  {
>  	int result;
>  	u8 d;
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>  
> +	/* reset it timestamp validation */
> +	st->it_timestamp = 0;
> +
>  	/* disable interrupt */
>  	result = regmap_write(st->map, st->reg->int_enable, 0);
>  	if (result) {
> @@ -97,7 +174,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	int result;
>  	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>  	u16 fifo_count;
> -	s64 timestamp = pf->timestamp;
> +	s64 timestamp;
>  	int int_status;
>  	size_t i, nb;
>  
> @@ -140,6 +217,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	fifo_count = get_unaligned_be16(&data[0]);
>  	/* compute and process all complete datum */
>  	nb = fifo_count / bytes_per_datum;
> +	inv_mpu6050_update_period(st, pf->timestamp, nb);
>  	for (i = 0; i < nb; ++i) {
>  		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>  					  data, bytes_per_datum);
> @@ -150,6 +228,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  			st->skip_samples--;
>  			continue;
>  		}
> +		timestamp = inv_mpu6050_get_timestamp(st);
>  		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
>  	}
>  

