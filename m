Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49418 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeE0KFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 May 2018 06:05:45 -0400
Date: Sun, 27 May 2018 11:05:43 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: imu: inv_mpu6050: switch to use sample rate
 divider
Message-ID: <20180527110543.3f40d6d4@archlinux>
In-Reply-To: <20180522141822.11598-2-jmaneyrol@invensense.com>
References: <20180522141822.11598-1-jmaneyrol@invensense.com>
        <20180522141822.11598-2-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 16:18:19 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Instead of storing fifo rate in Hz, store the chip internal sample
> rate divider. This will be more useful for timestamping. There
> are both equivalent.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied, thanks

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 18 +++++++++++-------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 16 +++++++++++++---
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 1e7e750294fc..2c3e666aa970 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -82,7 +82,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>  static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.fsr = INV_MPU6050_FSR_2000DPS,
>  	.lpf = INV_MPU6050_FILTER_20HZ,
> -	.fifo_rate = INV_MPU6050_INIT_FIFO_RATE,
> +	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE),
>  	.gyro_fifo_enable = false,
>  	.accl_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
> @@ -278,7 +278,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	if (result)
>  		goto error_power_off;
>  
> -	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
> +	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE);
>  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>  	if (result)
>  		goto error_power_off;
> @@ -628,7 +628,7 @@ static ssize_t
>  inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> -	s32 fifo_rate;
> +	int fifo_rate;
>  	u8 d;
>  	int result;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -644,8 +644,13 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	if (result)
>  		return result;
>  
> +	/* compute the chip sample rate divider */
> +	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(fifo_rate);
> +	/* compute back the fifo rate to handle truncation cases */
> +	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(d);
> +
>  	mutex_lock(&st->lock);
> -	if (fifo_rate == st->chip_config.fifo_rate) {
> +	if (d == st->chip_config.divider) {
>  		result = 0;
>  		goto fifo_rate_fail_unlock;
>  	}
> @@ -653,11 +658,10 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	if (result)
>  		goto fifo_rate_fail_unlock;
>  
> -	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
>  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>  	if (result)
>  		goto fifo_rate_fail_power_off;
> -	st->chip_config.fifo_rate = fifo_rate;
> +	st->chip_config.divider = d;
>  
>  	result = inv_mpu6050_set_lpf(st, fifo_rate);
>  	if (result)
> @@ -685,7 +689,7 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
>  	unsigned fifo_rate;
>  
>  	mutex_lock(&st->lock);
> -	fifo_rate = st->chip_config.fifo_rate;
> +	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
>  	mutex_unlock(&st->lock);
>  
>  	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index a92ddd45586c..a1130b9a420c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -86,7 +86,7 @@ enum inv_devices {
>   *  @accl_fs:		accel full scale range.
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
> - *  @fifo_rate:		FIFO update rate.
> + *  @divider:		chip sample rate divider (sample rate divider - 1)
>   */
>  struct inv_mpu6050_chip_config {
>  	unsigned int fsr:2;
> @@ -94,7 +94,7 @@ struct inv_mpu6050_chip_config {
>  	unsigned int accl_fs:2;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
> -	u16 fifo_rate;
> +	u8 divider;
>  	u8 user_ctrl;
>  };
>  
> @@ -228,7 +228,17 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_INIT_FIFO_RATE           50
>  #define INV_MPU6050_MAX_FIFO_RATE            1000
>  #define INV_MPU6050_MIN_FIFO_RATE            4
> -#define INV_MPU6050_ONE_K_HZ                 1000
> +
> +/* chip internal frequency: 1KHz */
> +#define INV_MPU6050_INTERNAL_FREQ_HZ		1000
> +/* return the frequency divider (chip sample rate divider + 1) */
> +#define INV_MPU6050_FREQ_DIVIDER(st)					\
> +	((st)->chip_config.divider + 1)
> +/* chip sample rate divider to fifo rate */
> +#define INV_MPU6050_FIFO_RATE_TO_DIVIDER(fifo_rate)			\
> +	((INV_MPU6050_INTERNAL_FREQ_HZ / (fifo_rate)) - 1)
> +#define INV_MPU6050_DIVIDER_TO_FIFO_RATE(divider)			\
> +	(INV_MPU6050_INTERNAL_FREQ_HZ / ((divider) + 1))
>  
>  #define INV_MPU6050_REG_WHOAMI			117
>  

