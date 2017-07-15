Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbdGOL7a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 07:59:30 -0400
Date: Sat, 15 Jul 2017 12:59:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/5] iio: imu: inv_mpu6050: whitespaces and formatting
 cleanup
Message-ID: <20170715125929.60a604c0@kernel.org>
In-Reply-To: <CY4PR1201MB018490CFD19C5A1E9D61AA02C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB018490CFD19C5A1E9D61AA02C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 13:34:19 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> No code change only formatting.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
I'm not sure I'd have removed some of the blank lines within functions
as if anything that makes the code slightly less readable.

Rest is good though and I don't feel strongly enough about it
to request you respin this patch.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  42 ++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |   5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 118 ++++++++++++++---------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |   6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |   2 -
>  5 files changed, 79 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 3af5877..5290e59 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -272,6 +272,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> +
>  	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>  	result = regmap_write(st->map, st->reg->gyro_config, d);
>  	if (result)
> @@ -331,12 +332,11 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  	return IIO_VAL_INT;
>  }
>  
> -static int
> -inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> -		     struct iio_chan_spec const *chan,
> -		     int *val, int *val2, long mask)
> +static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
>  {
> -	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	int ret = 0;
>  
>  	switch (mask) {
> @@ -405,19 +405,16 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  			*val  = 0;
>  			*val2 = gyro_scale_6050[st->chip_config.fsr];
>  			mutex_unlock(&st->lock);
> -
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			*val = 0;
>  			*val2 = accel_scale[st->chip_config.accl_fs];
>  			mutex_unlock(&st->lock);
> -
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
>  			*val = 0;
>  			*val2 = INV_MPU6050_TEMP_SCALE;
> -
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
> @@ -426,7 +423,6 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  		switch (chan->type) {
>  		case IIO_TEMP:
>  			*val = INV_MPU6050_TEMP_OFFSET;
> -
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> @@ -445,7 +441,6 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
>  			return IIO_VAL_INT;
> -
>  		default:
>  			return -EINVAL;
>  		}
> @@ -465,7 +460,6 @@ static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
>  			result = regmap_write(st->map, st->reg->gyro_config, d);
>  			if (result)
>  				return result;
> -
>  			st->chip_config.fsr = i;
>  			return 0;
>  		}
> @@ -503,7 +497,6 @@ static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
>  			result = regmap_write(st->map, st->reg->accl_config, d);
>  			if (result)
>  				return result;
> -
>  			st->chip_config.accl_fs = i;
>  			return 0;
>  		}
> @@ -610,9 +603,9 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  /**
>   * inv_mpu6050_fifo_rate_store() - Set fifo rate.
>   */
> -static ssize_t
> -inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
> -			    const char *buf, size_t count)
> +static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
>  {
>  	s32 fifo_rate;
>  	u8 d;
> @@ -663,9 +656,8 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  /**
>   * inv_fifo_rate_show() - Get the current sampling rate.
>   */
> -static ssize_t
> -inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
> -		   char *buf)
> +static ssize_t inv_fifo_rate_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
>  	unsigned fifo_rate;
> @@ -700,7 +692,6 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
>  	case ATTR_GYRO_MATRIX:
>  	case ATTR_ACCL_MATRIX:
>  		m = st->plat_data.orientation;
> -
>  		return scnprintf(buf, PAGE_SIZE,
>  			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
>  			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> @@ -785,17 +776,17 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
>  /* constant IIO attribute */
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
>  static IIO_CONST_ATTR(in_anglvel_scale_available,
> -					  "0.000133090 0.000266181 0.000532362 0.001064724");
> +		      "0.000133090 0.000266181 0.000532362 0.001064724");
>  static IIO_CONST_ATTR(in_accel_scale_available,
> -					  "0.000598 0.001196 0.002392 0.004785");
> +		      "0.000598 0.001196 0.002392 0.004785");
>  static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
> -	inv_mpu6050_fifo_rate_store);
> +			      inv_mpu6050_fifo_rate_store);
>  
>  /* Deprecated: kept for userspace backward compatibility. */
>  static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
> -	ATTR_GYRO_MATRIX);
> +		       ATTR_GYRO_MATRIX);
>  static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
> -	ATTR_ACCL_MATRIX);
> +		       ATTR_ACCL_MATRIX);
>  
>  static struct attribute *inv_attributes[] = {
>  	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,  /* deprecated */
> @@ -829,7 +820,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	unsigned int regval;
>  	int i;
>  
> -	st->hw  = &hw_info[st->chip_type];
> +	st->hw = &hw_info[st->chip_type];
>  	st->reg = hw_info[st->chip_type].reg;
>  
>  	/* check chip self-identification */
> @@ -983,7 +974,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  
>  #ifdef CONFIG_PM_SLEEP
> -
>  static int inv_mpu_resume(struct device *dev)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index d18604b..bbb1cdf 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -50,7 +50,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> -	/* It doesn't really mattter, if any of the calls fails */
> +	/* It doesn't really matter, if any of the calls fails */
>  	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
>  	inv_mpu6050_set_power_itg(st, false);
>  	mutex_unlock(&st->lock);
> @@ -166,7 +166,6 @@ static int inv_mpu_remove(struct i2c_client *client)
>  	{"icm20608", INV_ICM20608},
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
>  
>  static const struct of_device_id inv_of_match[] = {
> @@ -198,7 +197,6 @@ static int inv_mpu_remove(struct i2c_client *client)
>  	{"INVN6500", INV_MPU6500},
>  	{ },
>  };
> -
>  MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
>  
>  static struct i2c_driver inv_mpu_driver = {
> @@ -212,7 +210,6 @@ static int inv_mpu_remove(struct i2c_client *client)
>  		.pm     =       &inv_mpu_pmops,
>  	},
>  };
> -
>  module_i2c_driver(inv_mpu_driver);
>  
>  MODULE_AUTHOR("Invensense Corporation");
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index f680d00..b677172 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -129,11 +129,11 @@ struct inv_mpu6050_hw {
>  struct inv_mpu6050_state {
>  #define TIMESTAMP_FIFO_SIZE 16
>  	struct mutex lock;
> -	struct iio_trigger  *trig;
> +	struct iio_trigger *trig;
>  	struct inv_mpu6050_chip_config chip_config;
>  	const struct inv_mpu6050_reg_map *reg;
>  	const struct inv_mpu6050_hw *hw;
> -	enum   inv_devices chip_type;
> +	enum inv_devices chip_type;
>  	spinlock_t time_stamp_lock;
>  	struct i2c_mux_core *muxc;
>  	struct i2c_client *mux_client;
> @@ -146,84 +146,84 @@ struct inv_mpu6050_state {
>  };
>  
>  /*register and associated bit definition*/
> -#define INV_MPU6050_REG_ACCEL_OFFSET        0x06
> -#define INV_MPU6050_REG_GYRO_OFFSET         0x13
> +#define INV_MPU6050_REG_ACCEL_OFFSET		0x06
> +#define INV_MPU6050_REG_GYRO_OFFSET		0x13
>  
> -#define INV_MPU6050_REG_SAMPLE_RATE_DIV     0x19
> -#define INV_MPU6050_REG_CONFIG              0x1A
> -#define INV_MPU6050_REG_GYRO_CONFIG         0x1B
> -#define INV_MPU6050_REG_ACCEL_CONFIG        0x1C
> +#define INV_MPU6050_REG_SAMPLE_RATE_DIV		0x19
> +#define INV_MPU6050_REG_CONFIG			0x1A
> +#define INV_MPU6050_REG_GYRO_CONFIG		0x1B
> +#define INV_MPU6050_REG_ACCEL_CONFIG		0x1C
>  
> -#define INV_MPU6050_REG_FIFO_EN             0x23
> -#define INV_MPU6050_BIT_ACCEL_OUT           0x08
> -#define INV_MPU6050_BITS_GYRO_OUT           0x70
> +#define INV_MPU6050_REG_FIFO_EN			0x23
> +#define INV_MPU6050_BIT_ACCEL_OUT		0x08
> +#define INV_MPU6050_BITS_GYRO_OUT		0x70
>  
> -#define INV_MPU6050_REG_INT_ENABLE          0x38
> -#define INV_MPU6050_BIT_DATA_RDY_EN         0x01
> -#define INV_MPU6050_BIT_DMP_INT_EN          0x02
> +#define INV_MPU6050_REG_INT_ENABLE		0x38
> +#define INV_MPU6050_BIT_DATA_RDY_EN		0x01
> +#define INV_MPU6050_BIT_DMP_INT_EN		0x02
>  
> -#define INV_MPU6050_REG_RAW_ACCEL           0x3B
> -#define INV_MPU6050_REG_TEMPERATURE         0x41
> -#define INV_MPU6050_REG_RAW_GYRO            0x43
> +#define INV_MPU6050_REG_RAW_ACCEL		0x3B
> +#define INV_MPU6050_REG_TEMPERATURE		0x41
> +#define INV_MPU6050_REG_RAW_GYRO		0x43
>  
> -#define INV_MPU6050_REG_USER_CTRL           0x6A
> -#define INV_MPU6050_BIT_FIFO_RST            0x04
> -#define INV_MPU6050_BIT_DMP_RST             0x08
> -#define INV_MPU6050_BIT_I2C_MST_EN          0x20
> -#define INV_MPU6050_BIT_FIFO_EN             0x40
> -#define INV_MPU6050_BIT_DMP_EN              0x80
> -#define INV_MPU6050_BIT_I2C_IF_DIS          0x10
> +#define INV_MPU6050_REG_USER_CTRL		0x6A
> +#define INV_MPU6050_BIT_FIFO_RST		0x04
> +#define INV_MPU6050_BIT_DMP_RST			0x08
> +#define INV_MPU6050_BIT_I2C_MST_EN		0x20
> +#define INV_MPU6050_BIT_FIFO_EN			0x40
> +#define INV_MPU6050_BIT_DMP_EN			0x80
> +#define INV_MPU6050_BIT_I2C_IF_DIS		0x10
>  
> -#define INV_MPU6050_REG_PWR_MGMT_1          0x6B
> -#define INV_MPU6050_BIT_H_RESET             0x80
> -#define INV_MPU6050_BIT_SLEEP               0x40
> -#define INV_MPU6050_BIT_CLK_MASK            0x7
> +#define INV_MPU6050_REG_PWR_MGMT_1		0x6B
> +#define INV_MPU6050_BIT_H_RESET			0x80
> +#define INV_MPU6050_BIT_SLEEP			0x40
> +#define INV_MPU6050_BIT_CLK_MASK		0x7
>  
> -#define INV_MPU6050_REG_PWR_MGMT_2          0x6C
> -#define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
> -#define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
> +#define INV_MPU6050_REG_PWR_MGMT_2		0x6C
> +#define INV_MPU6050_BIT_PWR_ACCL_STBY		0x38
> +#define INV_MPU6050_BIT_PWR_GYRO_STBY		0x07
>  
> -#define INV_MPU6050_REG_FIFO_COUNT_H        0x72
> -#define INV_MPU6050_REG_FIFO_R_W            0x74
> +#define INV_MPU6050_REG_FIFO_COUNT_H		0x72
> +#define INV_MPU6050_REG_FIFO_R_W		0x74
>  
> -#define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
> -#define INV_MPU6050_FIFO_COUNT_BYTE          2
> -#define INV_MPU6050_FIFO_THRESHOLD           500
> +#define INV_MPU6050_BYTES_PER_3AXIS_SENSOR	6
> +#define INV_MPU6050_FIFO_COUNT_BYTE		2
> +#define INV_MPU6050_FIFO_THRESHOLD		500
>  
>  /* mpu6500 registers */
> -#define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
> -#define INV_MPU6500_REG_ACCEL_OFFSET        0x77
> +#define INV_MPU6500_REG_ACCEL_CONFIG_2		0x1D
> +#define INV_MPU6500_REG_ACCEL_OFFSET		0x77
>  
>  /* delay time in milliseconds */
> -#define INV_MPU6050_POWER_UP_TIME            100
> -#define INV_MPU6050_TEMP_UP_TIME             100
> -#define INV_MPU6050_SENSOR_UP_TIME           30
> +#define INV_MPU6050_POWER_UP_TIME		100
> +#define INV_MPU6050_TEMP_UP_TIME		100
> +#define INV_MPU6050_SENSOR_UP_TIME		30
>  
>  /* delay time in microseconds */
> -#define INV_MPU6050_REG_UP_TIME_MIN          5000
> -#define INV_MPU6050_REG_UP_TIME_MAX          10000
> +#define INV_MPU6050_REG_UP_TIME_MIN		5000
> +#define INV_MPU6050_REG_UP_TIME_MAX		10000
>  
> -#define INV_MPU6050_TEMP_OFFSET	             12421
> -#define INV_MPU6050_TEMP_SCALE               2941
> -#define INV_MPU6050_MAX_GYRO_FS_PARAM        3
> -#define INV_MPU6050_MAX_ACCL_FS_PARAM        3
> -#define INV_MPU6050_THREE_AXIS               3
> -#define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
> -#define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
> +#define INV_MPU6050_TEMP_OFFSET			12421
> +#define INV_MPU6050_TEMP_SCALE			2941
> +#define INV_MPU6050_MAX_GYRO_FS_PARAM		3
> +#define INV_MPU6050_MAX_ACCL_FS_PARAM		3
> +#define INV_MPU6050_THREE_AXIS			3
> +#define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT	3
> +#define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT	3
>  
>  /* 6 + 6 round up and plus 8 */
> -#define INV_MPU6050_OUTPUT_DATA_SIZE         24
> +#define INV_MPU6050_OUTPUT_DATA_SIZE		24
>  
> -#define INV_MPU6050_REG_INT_PIN_CFG	0x37
> -#define INV_MPU6050_BIT_BYPASS_EN	0x2
> -#define INV_MPU6050_INT_PIN_CFG		0
> +#define INV_MPU6050_REG_INT_PIN_CFG		0x37
> +#define INV_MPU6050_BIT_BYPASS_EN		0x2
> +#define INV_MPU6050_INT_PIN_CFG			0
>  
>  /* init parameters */
> -#define INV_MPU6050_INIT_FIFO_RATE           50
> -#define INV_MPU6050_TIME_STAMP_TOR           5
> -#define INV_MPU6050_MAX_FIFO_RATE            1000
> -#define INV_MPU6050_MIN_FIFO_RATE            4
> -#define INV_MPU6050_ONE_K_HZ                 1000
> +#define INV_MPU6050_INIT_FIFO_RATE		50
> +#define INV_MPU6050_TIME_STAMP_TOR		5
> +#define INV_MPU6050_MAX_FIFO_RATE		1000
> +#define INV_MPU6050_MIN_FIFO_RATE		4
> +#define INV_MPU6050_ONE_K_HZ			1000
>  
>  #define INV_MPU6050_REG_WHOAMI			117
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index ff81c6a..f5c2e07 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -55,7 +55,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  	if (result)
>  		goto reset_fifo_fail;
>  
> -	/* reset FIFO*/
> +	/* reset FIFO */
>  	result = regmap_write(st->map, st->reg->user_ctrl,
>  			      INV_MPU6050_BIT_FIFO_RST);
>  	if (result)
> @@ -72,7 +72,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  		if (result)
>  			return result;
>  	}
> -	/* enable FIFO reading and I2C master interface*/
> +	/* enable FIFO reading and I2C master interface */
>  	result = regmap_write(st->map, st->reg->user_ctrl,
>  			      INV_MPU6050_BIT_FIFO_EN);
>  	if (result)
> @@ -150,7 +150,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
>  	if (fifo_count < bytes_per_datum)
>  		goto end_session;
> -	/* fifo count can't be odd number, if it is odd, reset fifo*/
> +	/* fifo count can't be odd number, if it is odd, reset fifo */
>  	if (fifo_count & 1)
>  		goto flush_fifo;
>  	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 93fdd17..cc43cb1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -81,7 +81,6 @@ static int inv_mpu_probe(struct spi_device *spi)
>  	{"icm20608", INV_ICM20608},
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(spi, inv_mpu_id);
>  
>  static const struct acpi_device_id inv_acpi_match[] = {
> @@ -99,7 +98,6 @@ static int inv_mpu_probe(struct spi_device *spi)
>  		.pm     =       &inv_mpu_pmops,
>  	},
>  };
> -
>  module_spi_driver(inv_mpu_driver);
>  
>  MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");

