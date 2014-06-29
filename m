Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 29 Jun 2014 22:43:32 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: BMC150 accel support
In-Reply-To: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.DEB.2.01.1406292208010.25585@pmeerw.net>
References: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> This change implements BMC150 accelerometer driver. A BMC150 package
> consist of a compass and an accelerometer. This driver only implements
> accelerometer part.
> Spec downloaded from:
> http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-03.pdf

comments inline (nitpicking)

> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 12addf2..5704d6b 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -17,6 +17,19 @@ config BMA180
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma180.
>  
> +config BMC150_ACCEL
> +	tristate "Bosch BMC150 Accelerometer Driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for the Bosch BMC150 accelerometer.
> +	  Currently this only supports the device via an i2c interface.
> +
> +	  This is a combo module with both accelerometer and magnetometer.
> +	  This driver is only implementing accelerometer part, which has
> +	  its own address and register map.
> +
>  config HID_SENSOR_ACCEL_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 6578ca1..a593996 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -4,6 +4,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_BMA180) += bma180.o
> +obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> new file mode 100644
> index 0000000..330a3d7
> --- /dev/null
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -0,0 +1,947 @@
> +/*
> + * BMC150 3-axis accelerometer driver
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
> +#define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
> +
> +#define BMC150_ACCEL_REG_CHIP_ID		0x00
> +#define BMC150_ACCEL_CHIP_ID_VAL		0xFA
> +
> +#define BMC150_ACCEL_REG_PMU_LPW		0x11
> +#define BMC150_ACCEL_PMU_SLP_MASK		0xE0
> +#define BMC150_ACCEL_PMU_SLP_SHIFT		5
> +#define BMC150_ACCEL_PMU_BIT_SLEEP_DUR_MASK	0x17
> +#define BMC150_ACCEL_PMU_BIT_SLEEP_DUR_SHIFT	1
> +
> +#define BMC150_ACCEL_REG_PMU_RANGE		0x0F
> +
> +#define BMC150_ACCEL_DEF_RANGE_2G		0x03
> +#define BMC150_ACCEL_DEF_RANGE_4G		0x05
> +#define BMC150_ACCEL_DEF_RANGE_8G		0x08
> +#define BMC150_ACCEL_DEF_RANGE_16G		0x0C
> +
> +/* Default BW: 125Hz */
> +#define BMC150_ACCEL_REG_PMU_BW			0x10
> +#define BMC150_ACCEL_DEF_BW			125
> +
> +#define BMC150_ACCEL_REG_INT_MAP_0		0x19
> +#define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE	BIT(2)
> +
> +#define BMC150_ACCEL_REG_INT_RST_LATCH		0x21
> +#define BMC150_ACCEL_INT_MODE_LATCH_RESET	0x80
> +#define BMC150_ACCEL_INT_MODE_LATCH_INT		0x0F
> +
> +#define BMC150_ACCEL_REG_INT_EN_0		0x16
> +#define BMC150_ACCEL_INT_EN_BIT_SLP_X		BIT(0)
> +#define BMC150_ACCEL_INT_EN_BIT_SLP_Y		BIT(1)
> +#define BMC150_ACCEL_INT_EN_BIT_SLP_Z		BIT(2)
> +
> +#define BMC150_ACCEL_REG_INT_OUT_CTRL		0x20
> +#define BMC150_ACCEL_INT_OUT_CTRL_INT1_LVL	BIT(0)
> +
> +#define BMC150_ACCEL_REG_INT_5			0x27
> +#define BMC150_ACCEL_SLOPE_DUR_MASK		0x03
> +
> +#define BMC150_ACCEL_REG_INT_6			0x28
> +#define BMC150_ACCEL_SLOPE_THRES_MASK		0xFF
> +
> +#define BMC150_ACCEL_REG_XOUT_L			0x02

only XOUT_L is used

> +#define BMC150_ACCEL_REG_XOUT_H			0x03
> +#define BMC150_ACCEL_REG_YOUT_L			0x04
> +#define BMC150_ACCEL_REG_YOUT_H			0x05
> +#define BMC150_ACCEL_REG_ZOUT_L			0x06
> +#define BMC150_ACCEL_REG_ZOUT_H			0x07
> +
> +#define BMC150_ACCEL_MAX_STARTUP_TIME_MS	100
> +
> +/* Slope duration in terms of number of samples */
> +#define BMC150_ACCEL_DEF_SLOPE_DURATION		2
> +/* in terms of multiples of g's/LSB, based on range */
> +#define BMC150_ACCEL_DEF_SLOPE_THRESHOLD	5
> +
> +/* Sleep Duration values */
> +#define BMC150_ACCEL_SLEEP_500_MICRO		0x05
> +#define BMC150_ACCEL_SLEEP_1_MS			0x06
> +#define BMC150_ACCEL_SLEEP_2_MS			0x07
> +#define BMC150_ACCEL_SLEEP_4_MS			0x08
> +#define BMC150_ACCEL_SLEEP_6_MS			0x09
> +#define BMC150_ACCEL_SLEEP_10_MS		0x0A
> +#define BMC150_ACCEL_SLEEP_25_MS		0x0B
> +#define BMC150_ACCEL_SLEEP_50_MS		0x0C
> +#define BMC150_ACCEL_SLEEP_100_MS		0x0D
> +#define BMC150_ACCEL_SLEEP_500_MS		0x0E
> +#define BMC150_ACCEL_SLEEP_1_SEC		0x0F
> +
> +/* Sleep Modes */
> +#define BMC150_ACCEL_SLEEP_MODE_NORMAL		0x00
> +#define BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND	0x01
> +#define BMC150_ACCEL_SLEEP_MODE_LPM		0x03
> +#define BMC150_ACCEL_SLEEP_MODE_SUSPEND		0x04
> +
> +struct bmc150_accel_data {
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	bool	trig_mode;
> +	struct mutex mutex;
> +	s16 buffer[3];
> +	int power_state;
> +	u8 bw_bits;
> +	u32 slope_dur;
> +	u32 slope_thres;
> +	u32 range;
> +};
> +
> +enum bmc150_accel_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +	int bw_bits;

bw_bits could/should be u8 (same as in bmc150_accel_data)

> +} bmc150_accel_samp_freq_table[] = { {7, 810000, 0x08}, {15, 630000, 0x09},
> +				     {31, 250000, 0x0A}, {62, 500000, 0x0B},
> +				     {125, 0, 0x0C}, {250, 0, 0x0D},
> +				     {500, 0, 0x0E}, {1000, 0, 0x0F} };
> +
> +static const struct {
> +	int bw_bits;
> +	int msec;
> +} bmc150_accel_sample_upd_time[] = { {0x08, 64}, {0x09, 32}, {0x0A, 16},
> +				     {0x0B, 8}, {0x0C, 4},  {0x0D, 2},
> +				     {0x0E, 1}, {0x0F, 1} };
> +
> +static const struct {
> +	int scale;
> +	int range;
> +} bmc150_accel_scale_table[] = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
> +				 {19122, BMC150_ACCEL_DEF_RANGE_4G},
> +				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
> +				 {77057, BMC150_ACCEL_DEF_RANGE_16G} };
> +
> +
> +static int bmc150_accel_convert_sleep_value(int sleep_dur_us)
> +{
> +	int ret;
> +
> +	switch (sleep_dur_us) {

maybe one more table instead of a multi-line switch?

> +	case 0:
> +		ret = 0;
> +		break;
> +	case 500:
> +		ret = BMC150_ACCEL_SLEEP_500_MICRO;
> +		break;
> +	case 1000:
> +		ret = BMC150_ACCEL_SLEEP_1_MS;
> +		break;
> +	case 2000:
> +		ret = BMC150_ACCEL_SLEEP_2_MS;
> +		break;
> +	case 4000:
> +		ret = BMC150_ACCEL_SLEEP_4_MS;
> +		break;
> +	case 6000:
> +		ret = BMC150_ACCEL_SLEEP_6_MS;
> +		break;
> +	case 10000:
> +		ret = BMC150_ACCEL_SLEEP_10_MS;
> +		break;
> +	case 25000:
> +		ret = BMC150_ACCEL_SLEEP_25_MS;
> +		break;
> +	case 50000:
> +		ret = BMC150_ACCEL_SLEEP_50_MS;
> +		break;
> +	case 100000:
> +		ret = BMC150_ACCEL_SLEEP_100_MS;
> +		break;
> +	case 500000:
> +		ret = BMC150_ACCEL_SLEEP_500_MS;
> +		break;
> +	case 1000000:
> +		ret = BMC150_ACCEL_SLEEP_1_SEC;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_set_mode(struct bmc150_accel_data *data, int mode,
> +				 int dur_us)
> +{
> +	int ret;
> +	u8 lpw_bits = 0;

init of lpw_bits not needed

> +	int dur;
> +
> +	dur = bmc150_accel_convert_sleep_value(dur_us);
> +	if (dur < 0)
> +		return dur;
> +
> +	lpw_bits = mode << BMC150_ACCEL_PMU_SLP_SHIFT;
> +	lpw_bits |= (dur << BMC150_ACCEL_PMU_BIT_SLEEP_DUR_SHIFT);
> +
> +	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmc150_accel_convert_freq_to_bit(int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
> +		if (bmc150_accel_samp_freq_table[i].val == val)
> +			return bmc150_accel_samp_freq_table[i].bw_bits;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val)
> +{
> +	int ret;
> +	int bw_bits;

u8

> +
> +	bw_bits = bmc150_accel_convert_freq_to_bit(val);
> +	if (bw_bits < 0)
> +		return bw_bits;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_PMU_BW,
> +					bw_bits);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing pmu_bw\n");

reg_pmu_bw or pmu_bw? to make it consistent with above error message

> +		return ret;
> +	}
> +
> +	data->bw_bits = bw_bits;
> +
> +	return 0;
> +}
> +
> +static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Error:BMC150_ACCEL_REG_CHIP_ID\n");

maybe "Error reading reg_chip_id"

> +		return ret;
> +	}
> +
> +	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
> +	if (ret != BMC150_ACCEL_CHIP_ID_VAL) {
> +		dev_err(&data->client->dev, "invalid chip %x\n", ret);

error message start with uppercase elsewhere

> +		return -ENODEV;
> +	}
> +
> +	/* Set Bandwidth */
> +	ret = bmc150_accel_set_bw(data, BMC150_ACCEL_DEF_BW);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Default Range */
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_PMU_RANGE,
> +					BMC150_ACCEL_DEF_RANGE_4G);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +					"Error writing pmu_range\n");
> +		return ret;
> +	}
> +	data->range = BMC150_ACCEL_DEF_RANGE_4G;
> +
> +	data->slope_dur = BMC150_ACCEL_DEF_SLOPE_DURATION;
> +	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
> +
> +	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);

return bmc150_accel_set_mode()

> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_chip_setup_interrupt(struct bmc150_accel_data *data,
> +					  bool status)
> +{
> +	int ret;
> +
> +	/* Enable/Disable INT1 mapping */
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       BMC150_ACCEL_REG_INT_MAP_0);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error read reg_int_map0\n");
> +		return ret;
> +	}
> +	if (status)
> +		ret |= BMC150_ACCEL_INT_MAP_0_BIT_SLOPE;
> +	else
> +		ret &= ~BMC150_ACCEL_INT_MAP_0_BIT_SLOPE;
> +
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_INT_MAP_0,
> +					ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error write reg_int_map0\n");
> +		return ret;
> +	}
> +
> +	/* Set latched mode interrupt and clear any latched interrupt */
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_INT_RST_LATCH,
> +					BMC150_ACCEL_INT_MODE_LATCH_INT |
> +					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error write reg_rst_latch\n");

reg_int_rst_latch

> +		return ret;
> +	}
> +
> +	/* Enable/Disable slope interrupts */
> +	if (status) {
> +		/* Set slope duration (no of samples) */
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						BMC150_ACCEL_REG_INT_5,
> +						data->slope_dur);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error write eg_int_5\n");

reg_int_5

> +			return ret;
> +		}
> +
> +		/* Set slope thresholds */
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						BMC150_ACCEL_REG_INT_6,
> +						data->slope_thres);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error write reg_int_6\n");
> +			return ret;
> +		}
> +
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						BMC150_ACCEL_REG_INT_EN_0,
> +						BMC150_ACCEL_INT_EN_BIT_SLP_X |
> +						BMC150_ACCEL_INT_EN_BIT_SLP_Y |
> +						BMC150_ACCEL_INT_EN_BIT_SLP_Z);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error wr reg_int_en0\n");
> +			return ret;
> +		}

remove ret < 0 check, can use the check below

> +
> +	} else
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						BMC150_ACCEL_REG_INT_EN_0,
> +						0);
> +
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_en0\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_chip_ack_intr(struct bmc150_accel_data *data)
> +{
> +	int ret;
> +
> +	/* Set latched mode interrupt and clear any latched interrupt */
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_INT_RST_LATCH,
> +					BMC150_ACCEL_INT_MODE_LATCH_INT |
> +					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_rst_latch\n");

reg_int_rst_latch

> +		return ret;
> +	}
> +
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_get_bw(struct bmc150_accel_data *data, int *val,
> +			       int *val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
> +		if (bmc150_accel_samp_freq_table[i].bw_bits == data->bw_bits) {
> +			*val = bmc150_accel_samp_freq_table[i].val;
> +			*val2 = bmc150_accel_samp_freq_table[i].val2;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bmc150_accel_get_acc_reg(struct bmc150_accel_data *data, int axis)
> +{
> +	u8 reg = BMC150_ACCEL_REG_XOUT_L + axis * 2;

use enum bmc150_accel_axis for axis?

> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read accel_%c registers\n", 'x' + axis);

"Failed to read..."

> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_get_startup_times(struct bmc150_accel_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmc150_accel_sample_upd_time); ++i) {
> +		if (bmc150_accel_sample_upd_time[i].bw_bits == data->bw_bits)
> +			return bmc150_accel_sample_upd_time[i].msec;
> +
> +	}
> +
> +	return BMC150_ACCEL_MAX_STARTUP_TIME_MS;
> +}
> +
> +static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bmc150_accel_scale_table); ++i) {
> +		if (bmc150_accel_scale_table[i].scale == val) {
> +			ret = i2c_smbus_write_byte_data(
> +					data->client,
> +					BMC150_ACCEL_REG_PMU_RANGE,
> +					bmc150_accel_scale_table[i].range);
> +			if (ret < 0) {
> +				dev_err(&data->client->dev,
> +					"Error writing pmu_range\n");
> +				return ret;
> +			}
> +			data->range = bmc150_accel_scale_table[i].range;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bmc150_accel_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->mutex);
> +		if (iio_buffer_enabled(indio_dev))
> +			ret = -EBUSY;

I think it would be cleaner to return -EBUSY here instead of below

> +		else {
> +			int sleep_val;
> +			if (!data->power_state) {
> +				ret = bmc150_accel_set_mode(data,
> +						BMC150_ACCEL_SLEEP_MODE_NORMAL,
> +						0);
> +				if (ret < 0) {
> +					mutex_unlock(&data->mutex);
> +					return ret;
> +				}
> +				sleep_val =
> +					bmc150_accel_get_startup_times(data);
> +				if (sleep_val < 20)
> +					usleep_range(sleep_val * 1000, 20000);
> +				else
> +					msleep_interruptible(sleep_val);
> +			}
> +			++data->power_state;
> +			ret = bmc150_accel_get_acc_reg(data, chan->scan_index);
> +			if (--data->power_state == 0)
> +				bmc150_accel_set_mode(data,
> +						BMC150_ACCEL_SLEEP_MODE_SUSPEND,
> +						0);
> +				/* Nothing can be done if above call fails */
> +		}
> +		mutex_unlock(&data->mutex);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret >> 4, 11);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		switch (data->range) {
> +		case BMC150_ACCEL_DEF_RANGE_2G:
> +			*val = 9610;

val2 maybe?

> +			break;
> +		case BMC150_ACCEL_DEF_RANGE_4G:
> +			*val2 = 19122;
> +			break;
> +		case BMC150_ACCEL_DEF_RANGE_8G:
> +			*val2 = 38344;
> +			break;
> +		case BMC150_ACCEL_DEF_RANGE_16G:
> +			*val2 = 77057;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmc150_accel_get_bw(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bmc150_accel_write_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int val, int val2, long mask)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmc150_accel_set_bw(data, val);
> +		mutex_unlock(&data->mutex);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val)
> +			return -EINVAL;
> +		mutex_lock(&data->mutex);
> +		ret = bmc150_accel_set_scale(data, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/* power_mode ABI is a documented ABI for accelerometers, utiliziing
> + * this makes lot of sense when no buffered mode available because
> + * of lake of interrupt configuration. If user mode calls to read raw
> + * value with a very high frequency, instead of turn on/off for each
> + * read, keeping system on by setting power mode to "on" will give
> + * better performance.
> + */
> +static const char * const bmc150_accel_power_modes[] = {
> +	"off",
> +	"on",
> +};
> +
> +static int bmc150_accel_get_power_mode(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	return data->power_state;
> +}
> +
> +static int bmc150_accel_set_power_mode(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       unsigned int mode)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->mutex);
> +	if (mode) {
> +		if (!data->power_state)
> +			ret = bmc150_accel_set_mode(data,
> +						BMC150_ACCEL_SLEEP_MODE_NORMAL,
> +						0);
> +		++data->power_state;

power_state should not be incremented if set_mode() fails

> +	} else {
> +		if (--data->power_state == 0)
> +			ret = bmc150_accel_set_mode(data,
> +					BMC150_ACCEL_SLEEP_MODE_SUSPEND,
> +					0);
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bmc150_validate_trigger(struct iio_dev *indio_dev,
> +				   struct iio_trigger *trig)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	if (data->trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> +		"7.810000 15.630000 31.250000 62.500000 125 250 500 1000");
> +
> +static struct attribute *bmc150_accel_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bmc150_accel_attrs_group = {
> +	.attrs = bmc150_accel_attributes,
> +};
> +
> +static const struct iio_enum bmc150_accel_power_mode_enum = {
> +	.items = bmc150_accel_power_modes,
> +	.num_items = ARRAY_SIZE(bmc150_accel_power_modes),
> +	.get = bmc150_accel_get_power_mode,
> +	.set = bmc150_accel_set_power_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
> +	IIO_ENUM("power_mode", true, &bmc150_accel_power_mode_enum),
> +	IIO_ENUM_AVAILABLE("power_mode", &bmc150_accel_power_mode_enum),
> +	{ },
> +};
> +
> +#define BMC150_ACCEL_CHANNEL(_axis) {					\
> +	.type = IIO_ACCEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##_axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.scan_index = AXIS_##_axis,					\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 12,						\
> +		.storagebits = 16,					\
> +		.shift = 4,						\
> +	},								\
> +	.ext_info = bmc150_accel_ext_info,				\
> +}
> +
> +static const struct iio_chan_spec bmc150_accel_channels[] = {
> +	BMC150_ACCEL_CHANNEL(X),
> +	BMC150_ACCEL_CHANNEL(Y),
> +	BMC150_ACCEL_CHANNEL(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct iio_info bmc150_accel_info = {
> +	.attrs			= &bmc150_accel_attrs_group,
> +	.read_raw		= bmc150_accel_read_raw,
> +	.write_raw		= bmc150_accel_write_raw,
> +	.validate_trigger	= bmc150_validate_trigger,
> +	.driver_module		= THIS_MODULE,
> +};
> +
> +static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int bit, ret, i = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
> +			 indio_dev->masklength) {
> +		ret = bmc150_accel_get_acc_reg(data, bit);
> +		if (ret < 0) {
> +			bmc150_accel_chip_ack_intr(data);
> +			mutex_unlock(&data->mutex);
> +			goto err;
> +		}
> +		data->buffer[i++] = ret;
> +	}
> +
> +	bmc150_accel_chip_ack_intr(data);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   pf->timestamp);
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						   bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	if (state) {
> +		bmc150_accel_chip_setup_interrupt(data, true);
> +		if (!data->power_state)
> +			bmc150_accel_set_mode(data,
> +					BMC150_ACCEL_SLEEP_MODE_NORMAL,
> +					0);

return value of set_mode() is ignored, power_state should not be 
incremented in case of error

> +		++data->power_state;
> +	} else {
> +		if (--data->power_state == 0)
> +			bmc150_accel_set_mode(data,
> +					BMC150_ACCEL_SLEEP_MODE_SUSPEND,
> +					0);
> +		bmc150_accel_chip_setup_interrupt(data, false);
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops bmc150_accel_trigger_ops = {
> +	.set_trigger_state = bmc150_accel_data_rdy_trigger_set_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int bmc150_accel_acpi_gpio_probe(struct i2c_client *client,
> +					struct bmc150_accel_data *data)
> +{
> +	const struct acpi_device_id *id;
> +	struct device *dev;
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	if (!client)
> +		return -EINVAL;
> +
> +	dev = &client->dev;
> +	if (!ACPI_HANDLE(dev))
> +		return -ENODEV;
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	/* data ready gpio interrupt pin */
> +	gpio = devm_gpiod_get_index(dev, "bmc150_accel_int", 0);

maybe use a #define for the GPIO name?

> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "acpi gpio get index failed\n");
> +		return PTR_ERR(gpio);
> +	}
> +
> +	ret = gpiod_direction_input(gpio);
> +	if (ret)
> +		return ret;
> +
> +	ret = gpiod_to_irq(gpio);
> +
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct bmc150_accel_data *data;
> +	struct iio_dev *indio_dev;
> +	struct iio_trigger *trig = NULL;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	ret = bmc150_accel_chip_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = bmc150_accel_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bmc150_accel_channels);
> +	indio_dev->name = BMC150_ACCEL_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &bmc150_accel_info;
> +
> +	if (client->irq < 0)
> +		client->irq = bmc150_accel_acpi_gpio_probe(client, data);
> +
> +	if (client->irq >= 0) {
> +		trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> +					 indio_dev->id);
> +		if (!trig)
> +			return -ENOMEM;
> +
> +		data->trig_mode = true;
> +
> +		ret = devm_request_irq(&client->dev, client->irq,
> +				       iio_trigger_generic_data_rdy_poll,
> +				       IRQF_TRIGGER_RISING,
> +				       BMC150_ACCEL_IRQ_NAME,
> +				       trig);
> +		if (ret) {
> +			dev_err(&client->dev, "unable to request IRQ\n");
> +			goto err_trigger_free;
> +		}
> +
> +		trig->dev.parent = &client->dev;
> +		trig->ops = &bmc150_accel_trigger_ops;
> +		iio_trigger_set_drvdata(trig, indio_dev);
> +		data->trig = trig;
> +		indio_dev->trig = trig;
> +
> +		ret = iio_trigger_register(trig);
> +		if (ret)
> +			goto err_trigger_free;
> +
> +		ret = iio_triggered_buffer_setup(indio_dev,
> +						 &iio_pollfunc_store_time,
> +						 bmc150_accel_trigger_handler,
> +						 NULL);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"iio triggered buffer setup failed\n");
> +			goto err_trigger_unregister;
> +		}
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to register iio device\n");
> +		goto err_buffer_cleanup;
> +	}
> +
> +	return 0;
> +
> +err_buffer_cleanup:
> +	if (data->trig_mode)
> +		iio_triggered_buffer_cleanup(indio_dev);
> +err_trigger_unregister:
> +	if (data->trig_mode)
> +		iio_trigger_unregister(trig);
> +err_trigger_free:
> +	if (data->trig_mode)
> +		iio_trigger_free(trig);
> +
> +	return ret;
> +}
> +
> +static int bmc150_accel_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	if (data->trig_mode) {
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		iio_trigger_unregister(data->trig);
> +		iio_trigger_free(data->trig);
> +	}
> +
> +	mutex_lock(&data->mutex);
> +	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int bmc150_accel_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int bmc150_accel_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	if (data->power_state)
> +		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(bmc150_accel_pm_ops, bmc150_accel_suspend,
> +			 bmc150_accel_resume);
> +#define BMC150_ACCEL_PM_OPS (&bmc150_accel_pm_ops)
> +#else
> +#define BMC150_ACCEL_PM_OPS NULL
> +#endif
> +
> +static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> +	{"BSBA0150", 0},
> +	{"BMC150A", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> +
> +static const struct i2c_device_id bmc150_accel_id[] = {
> +	{"bmc150_accel", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
> +
> +static struct i2c_driver bmc150_accel_driver = {
> +	.driver = {
> +		.name	= BMC150_ACCEL_DRV_NAME,
> +		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
> +		.pm	= BMC150_ACCEL_PM_OPS,
> +	},
> +	.probe		= bmc150_accel_probe,
> +	.remove		= bmc150_accel_remove,
> +	.id_table	= bmc150_accel_id,
> +};
> +module_i2c_driver(bmc150_accel_driver);
> +
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMC150 accelerometer driver");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
