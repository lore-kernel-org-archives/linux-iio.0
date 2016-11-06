Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55777 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbcKFMft (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 07:35:49 -0500
Subject: Re: [PATCH 1/2] iio: bmi160: Support hardware fifo
To: Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b7dd5694-b757-c0d1-3400-46e92b8deb58@kernel.org>
Date: Sun, 6 Nov 2016 12:35:42 +0000
MIME-Version: 1.0
In-Reply-To: <20161103112527.29623-1-m.niestroj@grinn-global.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 11:25, Marcin Niestroj wrote:
> This patch was developed primarily based on bmc150_accel hardware fifo
> implementation.
> 
> IRQ handler was added, which for now is responsible only for handling
> watermark interrupts. The BMI160 chip has two interrupt outputs. By
> default INT is considered to be connected. If INT2 is used instead, the
> interrupt-names device-tree property can be used to specify that.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
I agree with Peter that there should have been a few precursor patches
to this one doing various cleanups and reworking bits that you have
in here.  Would have made it easier to review (always a good thing :)

In general the resulting code looks good to me.  A few little
additional comments inline from me.  Mostly about small code ordering things
and function rename suggestions that would make the code more 'obviously'
correct.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/bmi160/bmi160.h      |   3 +-
>  drivers/iio/imu/bmi160/bmi160_core.c | 633 +++++++++++++++++++++++++++++++++--
>  drivers/iio/imu/bmi160/bmi160_i2c.c  |   7 +-
>  drivers/iio/imu/bmi160/bmi160_spi.c  |   3 +-
>  4 files changed, 618 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index d2ae6ed..4a7c10e 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -4,7 +4,8 @@
>  extern const struct regmap_config bmi160_regmap_config;
>  
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> -		      const char *name, bool use_spi);
> +		      const char *name, int irq,
> +		      bool use_spi, bool block_supported);
>  void bmi160_core_remove(struct device *dev);
>  
>  #endif  /* BMI160_H_ */
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index e0251b8..153734c 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -2,6 +2,7 @@
>   * BMI160 - Bosch IMU (accel, gyro plus external magnetometer)
>   *
>   * Copyright (c) 2016, Intel Corporation.
> + * Copyright (c) 2016, Grinn
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -9,7 +10,7 @@
>   *
>   * IIO core driver for BMI160, with support for I2C/SPI busses
>   *
> - * TODO: magnetometer, interrupts, hardware FIFO
> + * TODO: magnetometer, interrupts
>   */
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -22,8 +23,12 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  
> +#include <linux/of_irq.h>
> +
>  #include "bmi160.h"
>  
> +#define BMI160_IRQ_NAME		"bmi160_event"
> +
>  #define BMI160_REG_CHIP_ID	0x00
>  #define BMI160_CHIP_ID_VAL	0xD1
>  
> @@ -34,6 +39,21 @@
>  #define BMI160_REG_DATA_GYRO_XOUT_L	0x0C
>  #define BMI160_REG_DATA_ACCEL_XOUT_L	0x12
>  
> +#define BMI160_REG_STATUS		0x1B
> +#define BMI160_STATUS_MAG_MAN_OP	BIT(2)
> +
> +#define BMI160_REG_INT_STATUS0		0x1C
> +
> +#define BMI160_REG_INT_STATUS1		0x1D
> +#define BMI160_INT_STATUS_FWM		BIT(6)
> +
> +#define BMI160_REG_INT_STATUS2		0x1E
> +
> +#define BMI160_REG_INT_STATUS3		0x1F
> +
> +#define BMI160_REG_FIFO_LENGTH		0x22
> +#define BMI160_REG_FIFO_DATA		0x24
> +
>  #define BMI160_REG_ACCEL_CONFIG		0x40
>  #define BMI160_ACCEL_CONFIG_ODR_MASK	GENMASK(3, 0)
>  #define BMI160_ACCEL_CONFIG_BWP_MASK	GENMASK(6, 4)
> @@ -55,6 +75,36 @@
>  #define BMI160_GYRO_RANGE_250DPS	0x03
>  #define BMI160_GYRO_RANGE_125DPS	0x04
>  
> +#define BMI160_REG_FIFO_CONFIG_0	0x46
> +
> +#define BMI160_REG_FIFO_CONFIG_1	0x47
> +#define BMI160_FIFO_GYRO_EN		BIT(7)
> +#define BMI160_FIFO_ACCEL_EN		BIT(6)
> +#define BMI160_FIFO_MAGN_EN		BIT(5)
> +#define BMI160_FIFO_HEADER_EN		BIT(4)
> +#define BMI160_FIFO_TAG_INT1_EN		BIT(3)
> +#define BMI160_FIFO_TAG_INT2_EN		BIT(2)
> +#define BMI160_FIFO_TIME_EN		BIT(1)
> +
> +#define BMI160_REG_INT_EN_1		0x51
> +#define BMI160_INT_FWM_EN		BIT(6)
> +#define BMI160_INT_FFULL_EN		BIT(5)
> +#define BMI160_INT_DRDY_EN		BIT(4)
> +
> +#define BMI160_REG_INT_OUT_CTRL		0x53
> +#define BMI160_INT2_OUTPUT_EN		BIT(7)
> +#define BMI160_INT1_OUTPUT_EN		BIT(3)
> +
> +#define BMI160_REG_INT_LATCH		0x54
> +
> +#define BMI160_REG_INT_MAP_1		0x56
> +#define BMI160_INT1_MAP_DRDY		BIT(7)
> +#define BMI160_INT1_MAP_FWM		BIT(6)
> +#define BMI160_INT1_MAP_FFULL		BIT(5)
> +#define BMI160_INT2_MAP_DRDY		BIT(3)
> +#define BMI160_INT2_MAP_FWM		BIT(2)
> +#define BMI160_INT2_MAP_FFULL		BIT(1)
> +
>  #define BMI160_REG_CMD			0x7E
>  #define BMI160_CMD_ACCEL_PM_SUSPEND	0x10
>  #define BMI160_CMD_ACCEL_PM_NORMAL	0x11
> @@ -66,6 +116,8 @@
>  
>  #define BMI160_REG_DUMMY		0x7F
>  
> +#define BMI160_FIFO_LENGTH		1024
> +
>  #define BMI160_ACCEL_PMU_MIN_USLEEP	3200
>  #define BMI160_ACCEL_PMU_MAX_USLEEP	3800
>  #define BMI160_GYRO_PMU_MIN_USLEEP	55000
> @@ -110,8 +162,33 @@ enum bmi160_sensor_type {
>  	BMI160_NUM_SENSORS /* must be last */
>  };
>  
> +struct bmi160_irq_data {
> +	unsigned int map_fwm;
> +	unsigned int output_en;
> +};
> +
> +static const struct bmi160_irq_data bmi160_irq1_data = {
> +	.map_fwm = BMI160_INT1_MAP_FWM,
> +	.output_en = BMI160_INT1_OUTPUT_EN,
> +};
> +
> +static const struct bmi160_irq_data bmi160_irq2_data = {
> +	.map_fwm = BMI160_INT2_MAP_FWM,
> +	.output_en = BMI160_INT2_OUTPUT_EN,
> +};
> +
>  struct bmi160_data {
>  	struct regmap *regmap;
> +	struct mutex mutex;
> +	const struct bmi160_irq_data *irq_data;
> +	int irq;
> +	int64_t timestamp;
> +	int64_t fifo_sample_period;
> +	bool fifo_enabled;
> +	unsigned int fifo_config;
> +	unsigned int fifo_sample_size;
> +	u8 *fifo_buffer;
> +	unsigned int watermark;
>  };
>  
>  const struct regmap_config bmi160_regmap_config = {
> @@ -159,11 +236,11 @@ struct bmi160_pmu_time {
>  static struct bmi160_pmu_time bmi160_pmu_time[] = {
>  	[BMI160_ACCEL] = {
>  		.min = BMI160_ACCEL_PMU_MIN_USLEEP,
> -		.max = BMI160_ACCEL_PMU_MAX_USLEEP
> +		.max = BMI160_ACCEL_PMU_MAX_USLEEP,
>  	},
>  	[BMI160_GYRO] = {
>  		.min = BMI160_GYRO_PMU_MIN_USLEEP,
> -		.max = BMI160_GYRO_PMU_MIN_USLEEP,
Guessing this one is a bug! 
> +		.max = BMI160_GYRO_PMU_MAX_USLEEP,
>  	},
>  };
>  
> @@ -285,7 +362,9 @@ int bmi160_set_mode(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	else
>  		cmd = bmi160_regs[t].pmu_cmd_suspend;
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_write(data->regmap, BMI160_REG_CMD, cmd);
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -298,6 +377,7 @@ static
>  int bmi160_set_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
>  		     int uscale)
>  {
> +	int ret;
>  	int i;
>  
>  	for (i = 0; i < bmi160_scale_table[t].num; i++)
> @@ -307,8 +387,12 @@ int bmi160_set_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	if (i == bmi160_scale_table[t].num)
>  		return -EINVAL;
>  
> -	return regmap_write(data->regmap, bmi160_regs[t].range,
> -			    bmi160_scale_table[t].tbl[i].bits);
> +	mutex_lock(&data->mutex);
> +	ret = regmap_write(data->regmap, bmi160_regs[t].range,
> +			   bmi160_scale_table[t].tbl[i].bits);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
>  }
>  
>  static
> @@ -317,7 +401,9 @@ int bmi160_get_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
>  {
>  	int i, ret, val;
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_read(data->regmap, bmi160_regs[t].range, &val);
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -340,7 +426,9 @@ static int bmi160_get_data(struct bmi160_data *data, int chan_type,
>  
>  	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(__le16);
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(__le16));
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -353,6 +441,7 @@ static
>  int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  		   int odr, int uodr)
>  {
> +	int ret;
>  	int i;
>  
>  	for (i = 0; i < bmi160_odr_table[t].num; i++)
> @@ -363,20 +452,30 @@ int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	if (i >= bmi160_odr_table[t].num)
>  		return -EINVAL;
>  
> -	return regmap_update_bits(data->regmap,
> -				  bmi160_regs[t].config,
> -				  bmi160_regs[t].config_odr_mask,
> -				  bmi160_odr_table[t].tbl[i].bits);
> +	mutex_lock(&data->mutex);
> +	ret = regmap_update_bits(data->regmap,
> +				 bmi160_regs[t].config,
> +				 bmi160_regs[t].config_odr_mask,
> +				 bmi160_odr_table[t].tbl[i].bits);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
>  }
>  
> -static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
> -			  int *odr, int *uodr)
> +static int64_t bmi160_frequency_to_period(int odr, int uodr)
>  {
> -	int i, val, ret;
> +	uint64_t period = 1000000000000000;
> +	int64_t frequency = (int64_t) odr * 1000000 + uodr;
>  
> -	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
> -	if (ret < 0)
> -		return ret;
> +	do_div(period, frequency);
> +
> +	return period;
> +}
> +
> +static const struct bmi160_odr *bmi160_reg_to_odr(enum bmi160_sensor_type t,
> +						unsigned int val)
> +{
> +	int i;
>  
>  	val &= bmi160_regs[t].config_odr_mask;
>  
> @@ -385,10 +484,52 @@ static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  			break;
>  
>  	if (i >= bmi160_odr_table[t].num)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
> +
> +	return &bmi160_odr_table[t].tbl[i];
> +}
> +
> +static int bmi160_get_sample_period(struct bmi160_data *data,
> +				enum bmi160_sensor_type t,
> +				int64_t *sample_period)
> +{
> +	const struct bmi160_odr *odr_entry;
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
> +	if (ret < 0)
> +		return ret;
>  
> -	*odr = bmi160_odr_table[t].tbl[i].odr;
> -	*uodr = bmi160_odr_table[t].tbl[i].uodr;
> +	odr_entry = bmi160_reg_to_odr(t, val);
> +	if (IS_ERR(odr_entry))
> +		return PTR_ERR(odr_entry);
> +
> +	*sample_period = bmi160_frequency_to_period(odr_entry->odr,
> +						odr_entry->uodr);
> +
> +	return 0;
> +}
> +
> +static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
> +			  int *odr, int *uodr)
> +{
> +	const struct bmi160_odr *odr_entry;
> +	int ret;
> +	unsigned int val;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
> +	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		return ret;
> +
> +	odr_entry = bmi160_reg_to_odr(t, val);
> +	if (IS_ERR(odr_entry))
> +		return PTR_ERR(odr_entry);
> +
> +	*odr = odr_entry->odr;
> +	*uodr = odr_entry->uodr;
>  
>  	return 0;
>  }
> @@ -402,14 +543,18 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>  	__le16 sample;
>  
> +	mutex_lock(&data->mutex);
>  	for_each_set_bit(i, indio_dev->active_scan_mask,
>  			 indio_dev->masklength) {
>  		ret = regmap_bulk_read(data->regmap, base + i * sizeof(__le16),
>  				       &sample, sizeof(__le16));
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&data->mutex);
>  			goto done;
> +		}
>  		buf[j++] = sample;
>  	}
> +	mutex_unlock(&data->mutex);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>  					   iio_get_time_ns(indio_dev));
> @@ -493,11 +638,364 @@ static const struct attribute_group bmi160_attrs_group = {
>  	.attrs = bmi160_attrs,
>  };
>
Naming to my mind would imply we are causing the period to be updated
rather than reading the updated value that hte hardware is giving us.

I'd rename as simple _read_sample_period

> +static int bmi160_update_sample_period(struct bmi160_data *data,
> +				enum bmi160_sensor_type sensor_type)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int64_t sample_period;
> +	int ret;
> +
> +	ret = bmi160_get_sample_period(data, sensor_type, &sample_period);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (data->fifo_sample_period) {
> +		if (data->fifo_sample_period != sample_period) {
> +			dev_warn(dev, "Enabled sensors have unequal ODR values\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		data->fifo_sample_period = sample_period;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi160_fifo_enable(struct iio_dev *indio_dev,
> +			struct bmi160_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	int ret;
> +	int i;
> +	unsigned int val;
> +	unsigned int fifo_config = 0;
> +
> +	/* Set fifo sample size and period */
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +			indio_dev->masklength) {
> +		if (i <= BMI160_SCAN_GYRO_Z)
> +			fifo_config |= BMI160_FIFO_GYRO_EN;
> +		else if (i <= BMI160_SCAN_ACCEL_Z)
> +			fifo_config |= BMI160_FIFO_ACCEL_EN;
> +	}
> +
> +	data->fifo_sample_period = 0;
> +	data->fifo_sample_size = 0;
> +	if (fifo_config & BMI160_FIFO_GYRO_EN) {
> +		data->fifo_sample_size += 6;
> +		ret = bmi160_update_sample_period(data, BMI160_GYRO);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (fifo_config & BMI160_FIFO_ACCEL_EN) {
> +		data->fifo_sample_size += 6;
> +		ret = bmi160_update_sample_period(data, BMI160_ACCEL);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Set watermark level and write real value back, as it will be used
> +	 * in timestamp calculation.
> +	 */
> +	val = data->watermark * data->fifo_sample_size;
> +	if (val > BMI160_FIFO_LENGTH - 1) {
> +		val = BMI160_FIFO_LENGTH - 1;
> +		data->watermark = val / data->fifo_sample_size;
> +	}
> +	val = data->watermark * data->fifo_sample_size / 4;
> +
> +	ret = regmap_write(regmap, BMI160_REG_FIFO_CONFIG_0, val);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set watermark\n");
> +		return ret;
> +	}
> +
> +	/* Enable FIFO channels */
> +	ret = regmap_write(regmap, BMI160_REG_FIFO_CONFIG_1,
> +			fifo_config);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to write FIFO_CONFIG_1\n");
> +		return ret;
> +	}
> +
> +	data->fifo_config = fifo_config;
> +	data->fifo_enabled = true;
> +
> +	return 0;
> +}
> +
> +static int bmi160_fifo_disable(struct bmi160_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	int ret;
> +
> +	/* Disable all FIFO channels */
> +	ret = regmap_write(regmap, BMI160_REG_FIFO_CONFIG_1, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to write FIFO_CONFIG_1\n");
> +		return ret;
> +	}
> +
> +	data->fifo_enabled = false;
> +
> +	return 0;
> +}
> +
> +static int bmi160_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return iio_triggered_buffer_postenable(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_MAP_1,
> +			data->irq_data->map_fwm, data->irq_data->map_fwm);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_EN_1,
> +				BMI160_INT_FWM_EN, BMI160_INT_FWM_EN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = bmi160_fifo_enable(indio_dev, data);
> +
> +unlock:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bmi160_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret = 0;
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return iio_triggered_buffer_predisable(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +
I would rather expect this unwind to reverse the order of the setup above.
Either that is obviously correct, or there should be some comments in here
indicating why not.
> +	ret = regmap_update_bits(regmap, BMI160_REG_INT_EN_1,
> +				BMI160_INT_FWM_EN, 0);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = bmi160_fifo_disable(data);
> +
> +unlock:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops bmi160_buffer_ops = {
> +	.postenable = bmi160_buffer_postenable,
> +	.predisable = bmi160_buffer_predisable,
> +};
> +
> +static ssize_t bmi160_get_fifo_state(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	bool state;
> +
> +	mutex_lock(&data->mutex);
> +	state = data->fifo_enabled;
> +	mutex_unlock(&data->mutex);
> +
> +	return sprintf(buf, "%d\n", (int) state);
> +}
> +
> +static ssize_t bmi160_get_fifo_watermark(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	int wm;
> +
> +	mutex_lock(&data->mutex);
> +	wm = data->watermark;
> +	mutex_unlock(&data->mutex);
> +
> +	return sprintf(buf, "%d\n", wm);
> +}
> +
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_CONST_ATTR(hwfifo_watermark_max,
> +		      __stringify(BMI160_FIFO_LENGTH));
> +static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
> +		       bmi160_get_fifo_state, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
> +		       bmi160_get_fifo_watermark, NULL, 0);
> +
> +static const struct attribute *bmi160_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
There are enough of these drivers now that sometimes soon we should
revisit the question of pulling these into the core.  Can certainly
concieve of downstream consumer devices (in particular the iio_input
bridge when that finally resurfaces - my fault) wanting to be able to
manipulate or at least have visibilty of these.

> +	NULL,
> +};
> +
> +static int bmi160_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +
> +	if (val > BMI160_FIFO_LENGTH)
> +		val = BMI160_FIFO_LENGTH;
> +
> +	data->watermark = val;
> +
> +	return 0;
> +}
> +
> +static int bmi160_fifo_transfer(struct bmi160_data *data,
> +				char *buffer, int num_bytes)
> +{
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	size_t step = regmap_get_raw_read_max(regmap);
> +	int ret = 0;
> +	int i;
> +
> +	if (!step || step > num_bytes)
> +		step = num_bytes;
> +	else if (step < num_bytes)
> +		step = data->fifo_sample_size;
> +
> +	for (i = 0; i < num_bytes; i += step) {
> +		ret = regmap_raw_read(regmap, BMI160_REG_FIFO_DATA,
> +				&buffer[i], step);
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret)
> +		dev_err(dev,
> +			"Error transferring data from fifo in single steps of %zu\n",
> +			step);
> +
> +	return ret;
> +}
> +
> +static int __bmi160_fifo_flush(struct iio_dev *indio_dev,
> +			unsigned int samples, bool irq)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	int ret;
> +	__le16 fifo_length;
> +	unsigned int fifo_samples;
> +	unsigned int fifo_bytes;
> +	u8 *buffer = data->fifo_buffer;
> +	u8 *buffer_iter;
> +	int64_t last_timestamp, timestamp;
> +	unsigned int last_samples;
> +	unsigned int i;
> +
> +	/* Get the current FIFO length */
> +	ret = regmap_bulk_read(regmap, BMI160_REG_FIFO_LENGTH,
> +			&fifo_length, sizeof(__le16));
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading FIFO_LENGTH\n");
> +		return ret;
> +	}
> +
> +	fifo_bytes = le16_to_cpu(fifo_length);
> +	fifo_samples = fifo_bytes / data->fifo_sample_size;
> +
> +	if (fifo_bytes % data->fifo_sample_size)
> +		dev_warn(dev, "fifo_bytes %u is not dividable by %u\n",
> +			fifo_bytes, data->fifo_sample_size);
> +
> +	if (!fifo_samples)
> +		return 0;
> +
> +	if (samples && fifo_samples > samples) {
> +		fifo_samples = samples;
> +		fifo_bytes = fifo_samples * data->fifo_sample_size;
> +	}
> +
> +	/*
> +	 * If we are not called from IRQ, it means that we are flushing data
> +	 * on demand. In that case we do not have latest timestamp saved in
> +	 * data->timestamp. Get the time now instead.
> +	 *
> +	 * In case of IRQ flush, saved timestamp shows the time when number
> +	 * of samples configured by watermark were ready. Currently there might
> +	 * be more samples already.
> +	 * If we are not called from IRQ, than we are getting the current fifo
> +	 * length, as we are setting timestamp just after getting it.
> +	 */
It's a real pain that people almost always want timestamps with IMU data :(
Ah well, this is about the best that can be done...
> +	if (!irq) {
> +		last_timestamp = iio_get_time_ns(indio_dev);
> +		last_samples = fifo_samples;
> +	} else {
> +		last_timestamp = data->timestamp;
> +		last_samples = data->watermark;
> +	}
> +
> +	/* Get all measurements */
> +	ret = bmi160_fifo_transfer(data, buffer, fifo_bytes);
> +	if (ret)
> +		return ret;
> +
> +	/* Handle demux */
> +	timestamp = last_timestamp - (last_samples * data->fifo_sample_period);
> +	buffer_iter = buffer;
> +	for (i = 0; i < fifo_samples; i++) {
> +		u8 tmp_buf[indio_dev->scan_bytes];
> +
> +		memcpy(tmp_buf, buffer_iter, data->fifo_sample_size);
> +
> +		timestamp += data->fifo_sample_period;
> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +						tmp_buf,
> +						timestamp);
Not a comment on your code which is correct as it stands, but...

We should really get a  useful utility functions in place:

iio_push_to_buffer_with_timestamp_safe(struct iio_dev *, void *data, void *working, timestamp);
Which would use the working space to do your little data shuffle as here - if
the timestamp is enabled, and skip it if not.

We've been meaning to add a multiple element push to buffer, so we'd need
a little helper to do the data shuffling for that as well (probably just
looping on the _safe version of the local push.)

> +
> +		buffer_iter += data->fifo_sample_size;
> +	}
> +
> +	return fifo_samples;
> +}
> +
> +static int bmi160_fifo_flush(struct iio_dev *indio_dev, unsigned int samples)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = __bmi160_fifo_flush(indio_dev, samples, false);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info bmi160_info = {
> -	.driver_module = THIS_MODULE,
> -	.read_raw = bmi160_read_raw,
> -	.write_raw = bmi160_write_raw,
> -	.attrs = &bmi160_attrs_group,
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= bmi160_read_raw,
> +	.write_raw		= bmi160_write_raw,
> +	.attrs			= &bmi160_attrs_group,
> +};
The realignment adds nothing but noise - so I wouldn't do it.  These always
seem very nice and pretty but then we get another addition that requires
futher indenting and suddenly we have another pointless 15 lines of patch.
The only exception in my mind is things like filling in numerical arrays
where readability is really enhanced.

(I wouldn't have minded enough to comment if this hadn't been modifying
existing code but just introducing new indented code).
> +
> +static const struct iio_info bmi160_info_fifo = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= bmi160_read_raw,
> +	.write_raw		= bmi160_write_raw,
> +	.attrs			= &bmi160_attrs_group,
> +	.hwfifo_set_watermark	= bmi160_set_watermark,
> +	.hwfifo_flush_to_buffer	= bmi160_fifo_flush,
>  };
>  
>  static const char *bmi160_match_acpi_device(struct device *dev)
> @@ -561,12 +1059,54 @@ static void bmi160_chip_uninit(struct bmi160_data *data)
>  	bmi160_set_mode(data, BMI160_ACCEL, false);
>  }
>  
> +static int bmi160_enable_irq(struct bmi160_data *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_OUT_CTRL,
> +				data->irq_data->output_en,
> +				data->irq_data->output_en);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t bmi160_irq_thread_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	mutex_lock(&data->mutex);
> +	if (data->fifo_enabled)
> +		__bmi160_fifo_flush(indio_dev, BMI160_FIFO_LENGTH, true);
> +	else
> +		dev_warn(dev,
> +			"IRQ has been triggered, but FIFO is not enabled.\n");
> +	mutex_unlock(&data->mutex);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bmi160_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +
> +	data->timestamp = iio_get_time_ns(indio_dev);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> -		      const char *name, bool use_spi)
> +		const char *name, int irq,
> +		bool use_spi, bool block_supported)
>  {
>  	struct iio_dev *indio_dev;
>  	struct bmi160_data *data;
>  	int ret;
> +	int irq2;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -574,8 +1114,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
> +	data->irq = irq;
>  	data->regmap = regmap;
>  
> +	mutex_init(&data->mutex);
> +
>  	ret = bmi160_chip_init(data, use_spi);
>  	if (ret < 0)
>  		return ret;
> @@ -591,10 +1134,50 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->info = &bmi160_info;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -					 bmi160_trigger_handler, NULL);
> +					 bmi160_trigger_handler,
> +					 &bmi160_buffer_ops);
>  	if (ret < 0)
>  		goto uninit;
>  
> +	if (data->irq > 0) {
> +		/* Check which interrupt pin is connected to our board */
> +		irq2 = of_irq_get_byname(dev->of_node, "INT2");
> +		if (irq2 == data->irq) {
> +			dev_dbg(dev, "Using interrupt line INT2\n");
> +			data->irq_data = &bmi160_irq2_data;
> +		} else {
> +			dev_dbg(dev, "Using interrupt line INT1\n");
> +			data->irq_data = &bmi160_irq1_data;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev,
> +						data->irq,
> +						bmi160_irq_handler,
> +						bmi160_irq_thread_handler,
> +						IRQF_ONESHOT,
> +						BMI160_IRQ_NAME,
> +						indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = bmi160_enable_irq(data);
> +		if (ret < 0)
> +			goto buffer_cleanup;
> +
> +		if (block_supported) {
> +			indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
> +			indio_dev->info = &bmi160_info_fifo;
> +			indio_dev->buffer->attrs = bmi160_fifo_attributes;
> +			data->fifo_buffer = devm_kmalloc(dev,
> +							BMI160_FIFO_LENGTH,
> +							GFP_KERNEL);
> +			if (!data->fifo_buffer) {
> +				ret = -ENOMEM;
> +				goto buffer_cleanup;
> +			}
> +		}
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto buffer_cleanup;
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 07a179d..aa63f89 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -23,6 +23,10 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  {
>  	struct regmap *regmap;
>  	const char *name = NULL;
> +	bool block_supported =
> +		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
> +		i2c_check_functionality(client->adapter,
> +					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
>  
>  	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -34,7 +38,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  	if (id)
>  		name = id->name;
>  
> -	return bmi160_core_probe(&client->dev, regmap, name, false);
> +	return bmi160_core_probe(&client->dev, regmap, name, client->irq,
> +				false, block_supported);
>  }
>  
>  static int bmi160_i2c_remove(struct i2c_client *client)
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index 1ec8b12..9b57fbe 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -25,7 +25,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  			(int)PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
> -	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
> +	return bmi160_core_probe(&spi->dev, regmap, id->name, spi->irq,
> +				true, true);
>  }
>  
>  static int bmi160_spi_remove(struct spi_device *spi)
> 

