Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44694 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab2LRTUX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Dec 2012 14:20:23 -0500
Message-ID: <50D0C1F2.3050401@kernel.org>
Date: Tue, 18 Dec 2012 19:20:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge GAO <ggao@invensense.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V6] Invensense MPU6050 Device Driver.
References: <1355539376-11711-1-git-send-email-ggao@invensense.com>
In-Reply-To: <1355539376-11711-1-git-send-email-ggao@invensense.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/15/2012 02:42 AM, Ge GAO wrote:
> From: Ge Gao <ggao@invensense.com>
>
> --This the basic function of Invensense MPU6050 Deivce driver.
> --MPU6050 is a gyro/accel combo device.
> --This does not contain any secondary I2C slave devices.
> --This does not contain DMP functions. DMP is a on-chip engine
>   that can do powerful process of motion gestures such as tap,
>   screen orientation, etc.
>
Hi,

Sorry for the slow response

Anyhow, first a couple of questions.
1) Is it worth making timestamps optional?
I'm guessing the fifo's have watershead interrupts, so you could do
a much more efficient reading of them if it wasn't for the timestamps.

2) Is the carefully established revision info used for anything?
(if not drop it until you need it for future driver features).

If I have understood the new logic for the enable, it's a little
counter intuitive to have non buffered reads only work when the
buffer is enabled...  Curriously this is the exact opposite
of the majority of drivers where having the buffer enabled makes
it positively hard to get a current reading.

Fine in priciple as it doesn't break the abi, but nice if the
device would power up on a raw read, take a reading then
power down again.  How horendous would that be to do?

Otherwise, various comments inline. Looking much nicer.


> Signed-off-by: Ge Gao <ggao@invensense.com>
> ---
Here you should have a summary of changes since the last version.

>  Documentation/ABI/testing/sysfs-bus-iio-mpu6050  |   14 +
>  drivers/iio/imu/Kconfig                          |    2 +
>  drivers/iio/imu/Makefile                         |    2 +
>  drivers/iio/imu/inv_mpu6050/Kconfig              |   13 +
>  drivers/iio/imu/inv_mpu6050/Makefile             |   11 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       |  800 ++++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h        |  394 +++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c       |  241 +++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c       |  331 +++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c    |   65 ++
>  include/linux/platform_data/invensense_mpu6050.h |   32 +
>  11 files changed, 1905 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>  create mode 100644 drivers/iio/imu/inv_mpu6050/Kconfig
>  create mode 100644 drivers/iio/imu/inv_mpu6050/Makefile
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>  create mode 100644 include/linux/platform_data/invensense_mpu6050.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-mpu6050 b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
> new file mode 100644
> index 0000000..6a8a2b4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
> @@ -0,0 +1,14 @@
May seem silly, but in_gyro_matrix etc would be more inline with the
rest of the abi.
> +What:           /sys/bus/iio/devices/iio:deviceX/gyro_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/accel_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/magn_matrix
> +KernelVersion:  3.4.0
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		This is mounting matrix for motion sensors. Mounting matrix
> +		is a 3x3 unitary matrix. A typical mounting matrix would look like
> +		[0, 1, 0; 1, 0, 0; 0, 0, -1]. Using this information, it would be
> +		easy to tell the relative positions among sensors as well as their
> +		positions relative to the board that holds these sensors. Identity matrix
> +		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and device are perfectly
> +		aligned with each other. All axes are exactly the same.
> +
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 3d79a40..723563b 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -25,3 +25,5 @@ config IIO_ADIS_LIB_BUFFER
>  	help
>  	  A set of buffer helper functions for the Analog Devices ADIS* device
>  	  family.
> +
> +source "drivers/iio/imu/inv_mpu6050/Kconfig"
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index cfe5763..1b41584 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -8,3 +8,5 @@ adis_lib-y += adis.o
>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
>  obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
> +
> +obj-y += inv_mpu6050/
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> new file mode 100644
> index 0000000..938a870
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
Hmm. I guess the huge amount of other stuff we saw in the first posting
(this is much better btw!) justfies the directory...
> @@ -0,0 +1,13 @@
> +#
> +# inv-mpu6050 drivers for Invensense MPU devices and combos
> +#
> +
> +config INV_MPU6050_IIO
> +	tristate "Invensense MPU6050 devices"
> +	depends on I2C && SYSFS && IIO
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  This driver supports the Invensense MPU6050 devices.
> +	  It is a gyroscope/accelerometer combo device.
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050.
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> new file mode 100644
> index 0000000..5161777
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# Makefile for Invensense MPU6050 device.
> +#
> +
> +obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
> +
> +inv-mpu6050-objs := inv_mpu_core.o
> +inv-mpu6050-objs += inv_mpu_ring.o
> +inv-mpu6050-objs += inv_mpu_misc.o
> +inv-mpu6050-objs += inv_mpu_trigger.o
Why not just list them all on one line?
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> new file mode 100644
> index 0000000..b32a3be
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -0,0 +1,800 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
Loose the blank line.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/kfifo.h>
> +#include <linux/spinlock.h>
> +#include "inv_mpu_iio.h"
> +
> +static const struct inv_hw_s hw_info[INV_NUM_PARTS] = {
> +	{117, "MPU6050"},
> +};
> +static const int gyro_scale_6050[] = {250, 500, 1000, 2000};
> +static const int accel_scale[] = {2, 4, 8, 16};
> +
> +static const struct inv_reg_map_s reg_set_6050 = {
> +	.sample_rate_div	= MPU_REG_SAMPLE_RATE_DIV,
> +	.lpf                    = MPU_REG_CONFIG,
> +	.bank_sel               = MPU_REG_BANK_SEL,
> +	.user_ctrl              = MPU_REG_USER_CTRL,
> +	.fifo_en                = MPU_REG_FIFO_EN,
> +	.gyro_config            = MPU_REG_GYRO_CONFIG,
> +	.accl_config            = MPU_REG_ACCEL_CONFIG,
> +	.fifo_count_h           = MPU_REG_FIFO_COUNT_H,
> +	.fifo_r_w               = MPU_REG_FIFO_R_W,
> +	.raw_gyro               = MPU_REG_RAW_GYRO,
> +	.raw_accl               = MPU_REG_RAW_ACCEL,
> +	.temperature            = MPU_REG_TEMPERATURE,
> +	.int_enable             = MPU_REG_INT_ENABLE,
> +	.int_status             = MPU_REG_INT_STATUS,
> +	.pwr_mgmt_1             = MPU_REG_PWR_MGMT_1,
> +	.pwr_mgmt_2             = MPU_REG_PWR_MGMT_2,
> +	.mem_start_addr         = MPU_REG_MEM_START_ADDR,
> +	.mem_r_w                = MPU_REG_MEM_RW,
> +	.prgm_strt_addrh        = MPU_REG_PRGM_STRT_ADDRH,
> +};
> +
> +static const struct inv_chip_config_s chip_config_6050 = {
> +	.fsr = INV_FSR_2000DPS,
> +	.lpf = INV_FILTER_20HZ,
> +	.fifo_rate = INIT_FIFO_RATE,
> +	.gyro_fifo_enable = true,
> +	.accl_fifo_enable = true,
> +	.accl_fs = INV_FS_02G,
> +
loose the blank line here.
> +};
> +
> +int mpu_write_reg(struct inv_mpu_iio_s *st, int reg, u8 val)
> +{
> +	int result;
> +	u8 d;
> +
> +	d = val;
Err, why?  Maybe I'm just asleep this evening...
> +
> +	result = i2c_smbus_write_i2c_block_data(st->client,
> +					reg, 1, &d);
> +
> +	return result;
> +}
> +
> +int inv_switch_engine(struct inv_mpu_iio_s *st, bool en, u32 mask)
> +{
> +	const struct inv_reg_map_s *reg;
> +	u8 data, mgmt_1;
> +	int result;
> +
> +	reg = st->reg;
> +	/* switch clock needs to be careful. Only when gyro is on, can
> +	   clock source be switched to gyro. Otherwise, it must be set to
> +	   internal clock */
> +	if (MPU_BIT_PWR_GYRO_STBY == mask) {
> +		result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->pwr_mgmt_1, 1, &mgmt_1);
> +		if (result != 1)
> +			return result;
> +
> +		mgmt_1 &= ~MPU_BIT_CLK_MASK;
> +	}
> +
> +	if ((MPU_BIT_PWR_GYRO_STBY == mask) && (!en)) {
> +		/* turning off gyro requires switch to internal clock first.
> +		   Then turn off gyro engine */
> +		mgmt_1 |= INV_CLK_INTERNAL;
> +		result = mpu_write_reg(st, reg->pwr_mgmt_1, mgmt_1);
> +		if (result)
> +			return result;
> +	}
> +
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->pwr_mgmt_2, 1, &data);
> +	if (result != 1)
> +		return result;
> +	if (en)
> +		data &= ~mask;
> +	else
> +		data |= mask;
> +	result = mpu_write_reg(st, reg->pwr_mgmt_2, data);
> +	if (result)
> +		return result;
> +
> +	if ((MPU_BIT_PWR_GYRO_STBY == mask) && en) {
> +		/* only gyro on needs sensor up time */
> +		msleep(SENSOR_UP_TIME);
> +		/* after gyro is on & stable, switch internal clock to PLL */
> +		mgmt_1 |= INV_CLK_PLL;
> +		result = mpu_write_reg(st, reg->pwr_mgmt_1, mgmt_1);
> +		if (result)
> +			return result;
> +	}
> +
> +	return 0;
> +}
> +
> +int inv_set_power_itg(struct inv_mpu_iio_s *st, bool power_on)
> +{
> +	const struct inv_reg_map_s *reg;
> +	u8 data;
> +	int result;
> +
> +	reg = st->reg;
> +	if (power_on)
> +		data = 0;
> +	else
> +		data = MPU_BIT_SLEEP;
> +	result = mpu_write_reg(st, reg->pwr_mgmt_1, data);
> +	if (result)
> +		return result;
> +
> +	if (power_on)
> +		msleep(REG_UP_TIME);
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_init_config() - Initialize hardware, disable FIFO.
> + *  @indio_dev:	Device driver instance.
> + *  Initial configuration:
> + *  FSR: +/- 2000DPS
> + *  DLPF: 20Hz
> + *  FIFO rate: 50Hz
> + *  Clock source: Gyro PLL
> + */
> +static int inv_init_config(struct iio_dev *indio_dev)
> +{
> +	const struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +
> +	reg = st->reg;
> +	result = inv_set_power_itg(st, true);
> +	if (result)
> +		return result;
> +	d = (INV_FSR_2000DPS << GYRO_CONFIG_FSR_SHIFT);
> +	result = mpu_write_reg(st, reg->gyro_config, d);
> +	if (result)
> +		return result;
> +
> +	d = INV_FILTER_20HZ;
> +	result = mpu_write_reg(st, reg->lpf, d);
> +	if (result)
> +		return result;
> +
> +	d = ONE_K_HZ / INIT_FIFO_RATE - 1;
> +	result = mpu_write_reg(st, reg->sample_rate_div, d);
> +	if (result)
> +		return result;
> +	st->irq_dur_ns = INIT_DUR_TIME,
> +
> +	d = (INV_FS_02G << ACCL_CONFIG_FSR_SHIFT);
> +	result = mpu_write_reg(st, reg->accl_config, d);
> +	if (result)
> +		return result;
> +
> +	memcpy(&st->chip_config, &chip_config_6050,
> +		sizeof(struct inv_chip_config_s));
> +	result = inv_set_power_itg(st, false);
> +	if (result)
> +		return result;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_temperature_show() - Read temperature data directly from registers.
> + *              the temperature is calculated by the following
> +		formula:
> +		temp_offset + q30_mult(temp << temp_shift, temp_scale).
> +		q30_mult is defined as:
> +		q30_mult(a, b) = (a * b) >> 30;
> + */
> +static int inv_temperature_show(struct inv_mpu_iio_s  *st, int *val)
> +{
> +	const struct inv_reg_map_s *reg;
> +	int result;
> +	s16 temp;
> +	u8 data[2];
> +
> +	reg = st->reg;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->temperature, 2, data);
> +	if (result != 2) {
> +		dev_err(&st->client->adapter->dev, "%s failed %d\n", __func__,
> +				result);
> +		return -EINVAL;
> +	}
Cast to a be16 or even better, have data as the right type and don't cast at all.
> +	temp = (s16)(be16_to_cpup((s16 *)&data[0]));
> +	*val = temp;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +/**
> + *  inv_sensor_show() - Read accel data directly from registers.
> + */
> +static int inv_sensor_show(struct inv_mpu_iio_s  *st, int reg,
> +				int axis, int *val)
> +{
> +	int ind, result;
> +	u8 d[2];
> +
> +	ind = (axis - IIO_MOD_X) * 2;
> +	result = i2c_smbus_read_i2c_block_data(st->client, reg + ind,  2, d);
> +	if (result != 2)
> +		return -EINVAL;
I'd have d of it's actual type and do the cast in the i2c call.
> +	*val = (short)be16_to_cpup((__be16 *)(d));
> +
> +	return IIO_VAL_INT;
> +}
> +
> +/**
> + *  mpu_read_raw() - read raw method.
> + */
> +static int mpu_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val,
> +			      int *val2,
> +			      long mask) {
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case 0:
> +		if (!st->chip_config.enable)
> +			return -EPERM;
Hmm so can only read when the chip is enabled...

I must agree with Lars on this. It's uggly and not how any other part
behaves.  I'd agree changing parameters when buffering is running
is probably worth blocking. But I'd expect non buffered reading to
be fine with the device powering up on demand.

> +		/* when it is enabled, power is already on */
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			return inv_sensor_show(st, st->reg->raw_gyro,
> +						chan->channel2, val);
> +		case IIO_ACCEL:
> +			return inv_sensor_show(st, st->reg->raw_accl,
> +						chan->channel2, val);
> +		case IIO_TEMP:
> +			return inv_temperature_show(st, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val = gyro_scale_6050[st->chip_config.fsr];
> +
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			*val = accel_scale[st->chip_config.accl_fs];
> +
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = MPU6050_TEMP_SCALE;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = MPU6050_TEMP_OFFSET;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + *  inv_write_fsr() - Configure the gyro's scale range.
> + */
> +static int inv_write_fsr(struct inv_mpu_iio_s *st, int fsr)
> +{
> +	const struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +
> +	reg = st->reg;
> +	if ((fsr < 0) || (fsr > MAX_GYRO_FS_PARAM))
> +		return -EINVAL;
> +	if (fsr == st->chip_config.fsr)
> +		return 0;
> +
> +	d = (fsr << GYRO_CONFIG_FSR_SHIFT);
> +	result = mpu_write_reg(st, reg->gyro_config, d);
> +	if (result)
> +		return result;
> +	st->chip_config.fsr = fsr;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_write_accel_fs() - Configure the accelerometer's scale range.
> + */
> +static int inv_write_accel_fs(struct inv_mpu_iio_s *st, int fs)
> +{
> +	int result;
> +	const struct inv_reg_map_s *reg;
> +	u8 d;
> +
> +	if (fs < 0 || fs > MAX_ACCL_FS_PARAM)
> +		return -EINVAL;
> +	if (fs == st->chip_config.accl_fs)
> +		return 0;
> +
> +	reg = st->reg;
> +	d = (fs << ACCL_CONFIG_FSR_SHIFT);
> +	result = mpu_write_reg(st, reg->accl_config, d);
> +	if (result)
> +		return result;
> +	st->chip_config.accl_fs = fs;
> +
> +	return 0;
> +}
> +
> +/**
> + *  mpu_write_raw() - write raw method.
> + */
> +static int mpu_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask) {
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +	int result;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	/* we should only update scale when the chip is disabled, i.e.,
> +		not running */
Could update and flush the fifo, but I can see that would get messy...
> +	if (st->chip_config.enable) {
  	   why -EPERM?  EBUSY would be more conventional.
	   Permissions fine, but device doing something else.
I'd prefer a goto and unlock in only one place.  Easier to read.
> +		mutex_unlock(&indio_dev->mlock);
> +		return -EPERM;
> +	}
> +	result = inv_set_power_itg(st, true);
> +	if (result) {
> +		mutex_unlock(&indio_dev->mlock);
> +		return result;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			result = inv_write_fsr(st, val);
> +			break;
> +		case IIO_ACCEL:
> +			result = inv_write_accel_fs(st, val);
> +			break;
> +		default:
> +			result = -EINVAL;
> +			break;
> +		}
> +	default:
> +		result = -EINVAL;
> +	}
> +
> +	result = inv_set_power_itg(st, false);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return result;
> +}
> +
> +
> + /*  inv_set_lpf() - set low pass filer based on fifo rate.
> + *                  Based on the Nyquist principle, the sampling rate must
> + *                  exceed twice of the bandwidth of the signal, or there
> + *                  would be alising. This function basically search for the
> + *                  correct low pass parameters based on the fifo rate, e.g,
> + *                  sampling frequency.
> + */
> +static int inv_set_lpf(struct inv_mpu_iio_s *st, int rate)
> +{
> +	const int hz[] = {188, 98, 42, 20, 10, 5};
> +	const int d[] = {INV_FILTER_188HZ, INV_FILTER_98HZ,
> +			INV_FILTER_42HZ, INV_FILTER_20HZ,
> +			INV_FILTER_10HZ, INV_FILTER_5HZ};
> +	int i, h, result;
> +	u8 data;
> +	const struct inv_reg_map_s *reg;
> +
> +	reg = st->reg;
> +	h = (rate >> 1);
> +	i = 0;
> +	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> +		i++;
> +	data = d[i];
> +	result = mpu_write_reg(st, reg->lpf, data);
> +	if (result)
> +		return result;
> +	st->chip_config.lpf = data;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_fifo_rate_store() - Set fifo rate.
> + */
> +static ssize_t inv_fifo_rate_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	s32 fifo_rate;
> +	u8 data;
> +	int result;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	const struct inv_reg_map_s *reg;
> +
> +	if (kstrtoint(buf, 10, &fifo_rate))
> +		return -EINVAL;
> +	if ((fifo_rate < MIN_FIFO_RATE) || (fifo_rate > MAX_FIFO_RATE))
> +		return -EINVAL;
> +	if (fifo_rate == st->chip_config.fifo_rate)
> +		return count;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	if (st->chip_config.enable) {
> +		mutex_unlock(&indio_dev->mlock);
> +		return -EPERM;
> +	}
> +	result = inv_set_power_itg(st, true);
> +	if (result) {
I'd do this with a suitable goto hence handling the
unlock in only one place.  Easier to check that way ;)
> +		mutex_unlock(&indio_dev->mlock);
> +		return result;
> +	}
> +
> +	reg = st->reg;
> +	data = ONE_K_HZ / fifo_rate - 1;
> +	result = mpu_write_reg(st, reg->sample_rate_div, data);
> +	if (result)
> +		goto fifo_rate_fail;
> +	st->chip_config.fifo_rate = fifo_rate;
> +
> +	result = inv_set_lpf(st, fifo_rate);
> +	if (result)
> +		goto fifo_rate_fail;
> +	st->irq_dur_ns = (data + 1) * NSEC_PER_MSEC;
> +
> +fifo_rate_fail:
> +	result |= inv_set_power_itg(st, false);
> +	mutex_unlock(&indio_dev->mlock);
> +	if (result)
> +		return result;
> +
> +	return count;
> +}
> +
> +/**
> + *  inv_fifo_rate_show() - Get the current sampling rate.
> + */
> +static ssize_t inv_fifo_rate_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +
> +	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
> +}
> +
> +/**
> + * inv_attr_show() -  calling this function will show current
> + *                     parameters.
> + */
> +static ssize_t inv_attr_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	s8 *m;
> +
> +	switch (this_attr->address) {
> +	case ATTR_GYRO_MATRIX:
> +		m = st->plat_data.orientation;
> +
> +		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> +	case ATTR_ACCL_MATRIX:
> +		m = st->plat_data.orientation;
> +
> +		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> +	default:
> +		return -EPERM;
> +	}
> +}
> +
> +#define INV_MPU_CHAN(_type, _channel2, _index)                        \
> +	{                                                             \
> +		.type = _type,                                        \
> +		.modified = 1,                                        \
> +		.channel2 = _channel2,                                \
> +		.info_mask =  IIO_CHAN_INFO_SCALE_SHARED_BIT          \
> +				| IIO_CHAN_INFO_RAW_SEPARATE_BIT,     \
> +		.scan_index = _index,                                 \
> +		.scan_type = {                                        \
> +				.sign = 's',                           \
> +				.realbits = 16,                       \
> +				.storagebits = 16,                    \
> +				.shift = 0 ,                          \
> +				.endianness = IIO_BE,                \
> +			     },                                       \
> +	}
> +
> +static const struct iio_chan_spec inv_mpu_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU_SCAN_TIMESTAMP),
> +	/* Note that temperature should only appear in the raw format,
> +	   not the final scan elements output. */
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask =  IIO_CHAN_INFO_RAW_SEPARATE_BIT
> +				| IIO_CHAN_INFO_OFFSET_SEPARATE_BIT
> +				| IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> +		.scan_index = -1,
> +	},
> +	INV_MPU_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU_SCAN_GYRO_X),
> +	INV_MPU_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU_SCAN_GYRO_Y),
> +	INV_MPU_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU_SCAN_GYRO_Z),
> +
> +	INV_MPU_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU_SCAN_ACCL_X),
> +	INV_MPU_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU_SCAN_ACCL_Y),
> +	INV_MPU_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU_SCAN_ACCL_Z),
> +};
> +
> +/*constant IIO attribute */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
> +	inv_fifo_rate_store);
> +/* clock source is the clock used to power the sensor. If gyro is enabled,
> + * it is recommended to use gyro for maximum accuracy.
> + */
> +static IIO_DEVICE_ATTR(gyro_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_GYRO_MATRIX);
> +static IIO_DEVICE_ATTR(accel_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_ACCL_MATRIX);
> +
> +static struct attribute *inv_attributes[] = {
> +	&iio_dev_attr_gyro_matrix.dev_attr.attr,
> +	&iio_dev_attr_accel_matrix.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group inv_attribute_group = {
> +	.attrs = inv_attributes
> +};
> +
> +static const struct iio_info mpu_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &mpu_read_raw,
> +	.write_raw = &mpu_write_raw,
> +	.attrs = &inv_attribute_group,
> +};
> +
> +/**
> + *  inv_check_setup_chip() - check and setup chip type.
> + */
> +static int inv_check_and_setup_chip(struct inv_mpu_iio_s *st,
> +		const struct i2c_device_id *id)
> +{
> +	const struct inv_reg_map_s *reg;
> +	int result;
> +
> +	st->chip_type = INV_MPU6050;
> +	st->hw  = &hw_info[st->chip_type];
> +	st->reg = &reg_set_6050;
> +	reg     = st->reg;
> +	/* reset to make sure previous state are not there */
> +	result = mpu_write_reg(st, reg->pwr_mgmt_1, MPU_BIT_H_RESET);
> +	if (result)
> +		return result;
> +	msleep(POWER_UP_TIME);
> +	/* toggle power state */
Why?  Needs documenting.
> +	result = inv_set_power_itg(st, false);
> +	if (result)
> +		return result;
> +	result = inv_set_power_itg(st, true);
> +	if (result)
> +		return result;
> +	/* turn off MEMS engine at start up */
> +	result = inv_switch_engine(st, false, MPU_BIT_PWR_GYRO_STBY);
> +	if (result)
> +		return result;
> +
> +	result = inv_switch_engine(st, false, MPU_BIT_PWR_ACCL_STBY);
> +	if (result)
> +		return result;
> +
> +	result = inv_get_silicon_rev_mpu6050(st);
> +	if (result) {
> +		dev_err(&st->client->adapter->dev, "%s failed %d\n", __func__,
> +				result);
> +		inv_set_power_itg(st, false);
> +		return result;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_mpu_probe() - probe function.
May seem silly, but please document the parameters.
Basically, running kerneldoc scripts should generate no
warnings or errors.
> + */
> +static int inv_mpu_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct inv_mpu_iio_s *st;
> +	struct iio_dev *indio_dev;
> +	int result;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		result = -ENOSYS;
> +		goto out_no_free;
> +	}
> +	indio_dev = iio_device_alloc(sizeof(*st));
> +	if (indio_dev == NULL) {
> +		result =  -ENOMEM;
> +		goto out_no_free;
> +	}
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	/* put cast here to avoid compilation warning */
> +	st->plat_data =
> +		*(struct mpu_platform_data *)dev_get_platdata(&client->dev);
> +	/* power is turned on inside check chip type*/
> +	result = inv_check_and_setup_chip(st, id);
> +	if (result)
> +		goto out_free;
> +
> +	result = inv_init_config(indio_dev);
> +	if (result) {
> +		dev_err(&client->dev,
> +			"Could not initialize device.\n");
> +		goto out_free;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->channels = inv_mpu_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +
> +	indio_dev->info = &mpu_info;
> +	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
> +
> +	result = inv_mpu_configure_ring(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->dev, "configure buffer fail %d\n",
> +				result);
> +		goto out_free;
> +	}
> +	st->irq = client->irq;
Why not just use st->client->irq and skip the copy?
> +	result = inv_mpu_probe_trigger(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->dev, "trigger probe fail %d\n", result);
> +		goto out_unreg_ring;
> +	}
> +
> +	INIT_KFIFO(st->timestamps);
> +	spin_lock_init(&st->time_stamp_lock);
> +	result = iio_device_register(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->dev, "IIO register fail %d\n", result);
> +		goto out_remove_trigger;
> +	}
> +
> +	return 0;
> +
> +out_remove_trigger:
> +	inv_mpu_remove_trigger(st);
> +out_unreg_ring:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +out_free:
> +	iio_device_free(indio_dev);
> +out_no_free:
> +
> +	return result;
> +}
> +
> +/**
> + *  inv_mpu_remove() - remove function.
> + */
> +static int inv_mpu_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +
> +	kfifo_free(&st->timestamps);
That seems like an incorrect bit of ordering. Logically until
unregister is called, the interfaces are still all there to
run the buffer etc.  Hence free your kfifo after the unregister.
Actually it's allocated in the structure directly, you shouldn't
free it at all. It'll get cleaned up with the structure when
the iio device is freed.
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	iio_device_free(indio_dev);
> +	inv_mpu_remove_trigger(st);
st is removed as part ofhte iio_device_free call
so this ordering needs fixing...

A remove should reverse the steps of a probe in the
oposite order.  (if nothing else, much harder
to make a mistake that way and easier to check for
reviewers ;)
> +
> +	return 0;
> +}
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int inv_mpu_resume(struct device *dev)
> +{
> +	struct inv_mpu_iio_s *st =
> +			iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +
> +	return inv_set_power_itg(st, true);
> +}
> +
> +static int inv_mpu_suspend(struct device *dev)
> +{
> +	struct inv_mpu_iio_s *st =
> +			iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +
> +	return inv_set_power_itg(st, false);
Might look clunky but I'd still do this in one line.
> +}
> +static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
> +
> +#define INV_MPU_PMOPS (&inv_mpu_pmops)
> +#else
> +#define INV_MPU_PMOPS NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
> +/* device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct i2c_device_id inv_mpu_id[] = {
> +	{"mpu6050", INV_MPU6050},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
> +
> +static struct i2c_driver inv_mpu_driver = {
> +	.probe		=	inv_mpu_probe,
> +	.remove		=	inv_mpu_remove,
> +	.id_table	=	inv_mpu_id,
> +	.driver = {
> +		.owner	=	THIS_MODULE,
> +		.name	=	"inv-mpu6050",
> +		.pm     =       INV_MPU_PMOPS,
> +	},
> +};
> +#if 1
Err. Clear this out please.
> +static int __init inv_mpu_init(void)
> +{
> +	int result = i2c_add_driver(&inv_mpu_driver);
> +	if (result)
> +		return result;
> +	return 0;
> +}
> +
> +static void __exit inv_mpu_exit(void)
> +{
> +	i2c_del_driver(&inv_mpu_driver);
> +}
> +
> +module_init(inv_mpu_init);
> +module_exit(inv_mpu_exit);
> +#else
> +module_i2c_driver(inv_mpu_driver);
> +#endif
> +
> +MODULE_AUTHOR("Invensense Corporation");
> +MODULE_DESCRIPTION("Invensense device driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> new file mode 100644
> index 0000000..9b218d8
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -0,0 +1,394 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
I get the feeling some of these could be driven down into the
parts of the driver that actually use them (where they
are used at all).
> +#include <linux/i2c.h>
> +#include <linux/kfifo.h>
> +#include <linux/miscdevice.h>
why?

> +#include <linux/input.h>
why?

> +#include <linux/spinlock.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/platform_data/invensense_mpu6050.h>
> +
> +/**
> + *  struct inv_reg_map_s - Notable slave registers.
> + *  @sample_rate_div:	Divider applied to gyro output rate.
> + *  @lpf:		Configures internal low pass filter.
> + *  @bank_sel:		Selects between memory banks.
> + *  @user_ctrl:		Enables/resets the FIFO.
> + *  @fifo_en:		Determines which data will appear in FIFO.
> + *  @gyro_config:	gyro config register.
> + *  @accl_config:	accel config register
> + *  @fifo_count_h:	Upper byte of FIFO count.
> + *  @fifo_r_w:		FIFO register.
> + *  @raw_gyro		Address of first gyro register.
> + *  @raw_accl		Address of first accel register.
> + *  @temperature	temperature register
> + *  @int_enable:	Interrupt enable register.
> + *  @int_status:	Interrupt flags.
> + *  @pwr_mgmt_1:	Controls chip's power state and clock source.
> + *  @pwr_mgmt_2:	Controls power state of individual sensors.
> + *  @mem_start_addr:	Address of first memory read.
> + *  @mem_r_w:		Access to memory.
> + *  @prgm_strt_addrh	firmware program start address register
> + */
> +struct inv_reg_map_s {
> +	u8 sample_rate_div;
> +	u8 lpf;
> +	u8 bank_sel;
> +	u8 user_ctrl;
> +	u8 fifo_en;
> +	u8 gyro_config;
> +	u8 accl_config;
> +	u8 fifo_count_h;
> +	u8 fifo_r_w;
> +	u8 raw_gyro;
> +	u8 raw_accl;
> +	u8 temperature;
> +	u8 int_enable;
> +	u8 int_status;
> +	u8 pwr_mgmt_1;
> +	u8 pwr_mgmt_2;
> +	u8 mem_start_addr;
> +	u8 mem_r_w;
> +	u8 prgm_strt_addrh;
> +};
blank line here.
> +/*device enum */
> +enum inv_devices {
> +	INV_MPU6050,
> +	INV_NUM_PARTS
> +};
> +
> +/**
> + *  struct test_setup_t - set up parameters for self test.
> + *  @gyro_sens: sensitity for gyro.
> + *  @sample_rate: sample rate, i.e, fifo rate.
> + *  @lpf:	low pass filter.
> + *  @fsr:	full scale range.
> + *  @accl_fs:	accel full scale range.
> + *  @accl_sens:	accel sensitivity
> + */
> +struct test_setup_t {
> +	int gyro_sens;
> +	int sample_rate;
> +	int lpf;
> +	int fsr;
> +	int accl_fs;
> +	u32 accl_sens[3];
> +};
> +
> +/**
> + *  struct inv_hw_s - Other important hardware information.
> + *  @num_reg:	Number of registers on device.
> + *  @name:      name of the chip
> + */
> +struct inv_hw_s {
> +	u8 num_reg;
> +	u8 *name;
> +};
> +
> +/**
> + *  struct inv_chip_config_s - Cached chip configuration data.
> + *  @fsr:		Full scale range.
> + *  @lpf:		Digital low pass filter frequency.
> + *  @clk_src:		Clock source.
> + *  @enable:		master enable state.
> + *  @accl_fs:		accel full scale range.
> + *  @accl_fifo_enable:	enable accel data output
> + *  @gyro_fifo_enable:	enable gyro data output
> + *  @fifo_rate:		FIFO update rate.
> + */
> +struct inv_chip_config_s {
Convention is just unsigned int for a bitfield. Can't see
why the exact size matters here?
> +	u32 fsr:2;
> +	u32 lpf:3;
> +	u32 enable:1;
> +	u32 accl_fs:2;
> +	u32 accl_fifo_enable:1;
> +	u32 gyro_fifo_enable:1;
> +	u16 fifo_rate;
> +};
> +
> +/**
> + *  struct inv_chip_info_s - Chip related information.
> + *  @product_id:	Product id.
> + *  @product_revision:	Product revision.
> + *  @silicon_revision:	Silicon revision.
> + *  @software_revision:	software revision.
> + *  @multi:		accel specific multiplier.
> + *  @compass_sens:	compass sensitivity.
> + *  @gyro_sens_trim:	Gyro sensitivity trim factor.
> + *  @accl_sens_trim:    accel sensitivity trim factor.
> + */
> +struct inv_chip_info_s {
> +	u8 product_id;
> +	u8 product_revision;
> +	u8 silicon_revision;
> +	u8 software_revision;
> +	u8 multi;
> +	u32 gyro_sens_trim;
> +	u32 accl_sens_trim;
> +};
> +
> +/**
> + *  struct inv_mpu_iio_s - Driver state variables.
> + *  @chip_config:	Cached attribute information.
> + *  @chip_info:		Chip information from read-only registers.
> + *  @reg:		Map of important registers.
> + *  @hw:		Other hardware-specific information.
> + *  @chip_type:		chip type.
> + *  @time_stamp_lock:	spin lock to time stamp.
> + *  @client:		i2c client handle.
> + *  @plat_data:		platform data.
> + *  @timestamps:        kfifo queue to store time stamp.
> + *  @irq:               irq number store.
> + *  @irq_dur_ns:        duration between each irq.
> + *  @last_isr_time:     last isr time.
> + */
is the _s for structure?  If so, drop it everywhere. If not
then what is it for?  Perhaps call this inv_mpu_state or similar?
The iio bit seems a little odd in an iio driver...
> +struct inv_mpu_iio_s {
> +#define TIMESTAMP_FIFO_SIZE 16
> +	struct iio_trigger  *trig;
> +	struct inv_chip_config_s chip_config;
> +	struct inv_chip_info_s chip_info;
> +	const struct inv_reg_map_s *reg;
> +	const struct inv_hw_s *hw;
> +	enum   inv_devices chip_type;
> +	spinlock_t time_stamp_lock;
> +	struct i2c_client *client;
> +	struct mpu_platform_data plat_data;
> +	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
> +	s16 irq;
> +	u32 irq_dur_ns;
> +	s64 last_isr_time;
> +};
> +
> +/* produces an unique identifier for each device based on the
> +   combination of product version and product revision */
> +struct prod_rev_map_t {
> +	u16 mpl_product_key;
> +	u8 silicon_rev;
> +	u16 gyro_trim;
> +	u16 accel_trim;
> +};
> +
> +/*register and associated bit definition*/
> +#define MPU_REG_YGOFFS_TC           0x1
> +#define MPU_BIT_I2C_MST_VDDIO		0x80
> +
> +#define MPU_REG_XA_OFFS_L_TC        0x7
> +#define MPU_REG_PRODUCT_ID          0xC
> +#define MPU_REG_ST_GCT_X            0xD
> +#define MPU_REG_SAMPLE_RATE_DIV     0x19
> +#define MPU_REG_CONFIG              0x1A
> +
> +#define MPU_REG_GYRO_CONFIG         0x1B
> +
> +#define MPU_REG_ACCEL_CONFIG	0x1C
> +
> +#define MPU_REG_FIFO_EN             0x23
> +#define MPU_BIT_ACCEL_OUT			0x08
> +#define MPU_BITS_GYRO_OUT			0x70
> +
> +
> +#define MPU_REG_I2C_MST_CTRL        0x24
> +#define MPU_BIT_WAIT_FOR_ES			0x40
> +
> +#define MPU_REG_I2C_SLV0_ADDR       0x25
> +#define MPU_BIT_I2C_READ			0x80
> +
> +#define MPU_REG_I2C_SLV0_REG        0x26
> +
> +#define MPU_REG_I2C_SLV0_CTRL       0x27
> +#define MPU_BIT_SLV_EN			0x80
> +
> +#define MPU_REG_I2C_SLV1_ADDR       0x28
> +#define MPU_REG_I2C_SLV1_REG        0x29
> +#define MPU_REG_I2C_SLV1_CTRL       0x2A
> +#define MPU_REG_I2C_SLV4_CTRL       0x34
> +
> +#define MPU_REG_INT_PIN_CFG         0x37
> +#define MPU_BIT_BYPASS_EN                   0x2
> +
> +#define MPU_REG_INT_ENABLE          0x38
> +#define MPU_BIT_DATA_RDY_EN                 0x01
> +#define MPU_BIT_DMP_INT_EN                  0x02
> +
> +#define MPU_REG_DMP_INT_STATUS      0x39
> +#define MPU_REG_INT_STATUS          0x3A
> +#define MPU_REG_RAW_ACCEL           0x3B
> +#define MPU_REG_TEMPERATURE         0x41
> +#define MPU_REG_RAW_GYRO            0x43
> +#define MPU_REG_EXT_SENS_DATA_00    0x49
> +#define MPU_REG_I2C_SLV1_DO         0x64
> +
> +#define MPU_REG_I2C_MST_DELAY_CTRL  0x67
> +#define MPU_BIT_SLV0_DLY_EN                 0x01
> +#define MPU_BIT_SLV1_DLY_EN                 0x02
> +
> +#define MPU_REG_USER_CTRL           0x6A
> +#define MPU_BIT_FIFO_RST                    0x04
> +#define MPU_BIT_DMP_RST                     0x08
> +#define MPU_BIT_I2C_MST_EN                  0x20
> +#define MPU_BIT_FIFO_EN                     0x40
> +#define MPU_BIT_DMP_EN                      0x80
> +
> +#define MPU_REG_PWR_MGMT_1          0x6B
> +#define MPU_BIT_H_RESET                     0x80
> +#define MPU_BIT_SLEEP                       0x40
> +#define MPU_BIT_CLK_MASK                    0x7
> +
> +#define MPU_REG_PWR_MGMT_2          0x6C
> +#define MPU_BIT_PWR_ACCL_STBY               0x38
> +#define MPU_BIT_PWR_GYRO_STBY               0x07
> +#define MPU_BIT_LPA_FREQ                    0xC0
> +
> +#define MPU_REG_BANK_SEL            0x6D
> +#define MPU_REG_MEM_START_ADDR      0x6E
> +#define MPU_REG_MEM_RW              0x6F
> +#define MPU_REG_PRGM_STRT_ADDRH     0x70
> +#define MPU_REG_FIFO_COUNT_H        0x72
> +#define MPU_REG_FIFO_R_W            0x74
> +
> +/* data definitions */
> +#define Q30_MULTI_SHIFT          30
> +
> +#define BYTES_PER_3AXIS_SENSOR   6
> +#define FIFO_COUNT_BYTE          2
> +#define FIFO_THRESHOLD           500
> +#define POWER_UP_TIME            100
> +#define SENSOR_UP_TIME           30
> +#define REG_UP_TIME              5
> +#define MPU_MEM_BANK_SIZE        256
> +#define MPU6050_TEMP_OFFSET	 2462307L
> +#define MPU6050_TEMP_SCALE       2977653L
> +#define MPU_TEMP_SHIFT           16
> +#define LPA_FREQ_SHIFT           6
> +#define COMPASS_RATE_SCALE       10
> +#define MAX_GYRO_FS_PARAM        3
> +#define MAX_ACCL_FS_PARAM        3
> +#define MAX_LPA_FREQ_PARAM       3
> +#define THREE_AXIS               3
> +#define GYRO_CONFIG_FSR_SHIFT    3
> +#define ACCL_CONFIG_FSR_SHIFT    3
> +#define GYRO_DPS_SCALE           250
> +#define MEM_ADDR_PROD_REV        0x6
> +#define SOFT_PROD_VER_BYTES      5
> +#define SELF_TEST_SUCCESS        1
> +#define MS_PER_DMP_TICK          20
> +/* 6 + 6 round up and plus 8 */
> +#define OUTPUT_DATA_SIZE         24
> +
> +/* init parameters */
> +#define INIT_FIFO_RATE           50
> +#define INIT_DUR_TIME           ((1000 / INIT_FIFO_RATE) * NSEC_PER_MSEC)
> +#define MPL_PROD_KEY(ver, rev) (ver * 100 + rev)
> +#define NUM_OF_PROD_REVS (ARRAY_SIZE(prod_rev_map))
> +/*---- MPU6050 Silicon Revisions ----*/
> +#define MPU_SILICON_REV_A2                    1       /* MPU6050A2 Device */
> +#define MPU_SILICON_REV_B1                    2       /* MPU6050B1 Device */
> +
> +#define MPU_BIT_PRFTCH_EN                         0x40
> +#define MPU_BIT_CFG_USER_BANK                     0x20
> +#define BITS_MEM_SEL                          0x1f
> +
> +#define TIME_STAMP_TOR                        5
> +#define MAX_CATCH_UP                          5
> +#define DEFAULT_ACCL_TRIM                     16384
> +#define MAX_FIFO_RATE                         1000
> +#define MIN_FIFO_RATE                         4
> +#define ONE_K_HZ                              1000
Some consistent prefixes would cut down on chance of a name clash in the future.
I'd just prefix everything with INV, or MPU
> +
> +#define INV_ELEMENT_MASK                  0x00FF
> +#define INV_GYRO_ACC_MASK                 0x007E
> +
> +/* scan element definition */
> +enum inv_mpu_scan {
> +	INV_MPU_SCAN_GYRO_X,
> +	INV_MPU_SCAN_GYRO_Y,
> +	INV_MPU_SCAN_GYRO_Z,
> +	INV_MPU_SCAN_ACCL_X,
> +	INV_MPU_SCAN_ACCL_Y,
> +	INV_MPU_SCAN_ACCL_Z,
> +	INV_MPU_SCAN_TIMESTAMP,
> +};
> +
> +enum inv_filter_e {
> +	INV_FILTER_256HZ_NOLPF2 = 0,
> +	INV_FILTER_188HZ,
> +	INV_FILTER_98HZ,
> +	INV_FILTER_42HZ,
> +	INV_FILTER_20HZ,
> +	INV_FILTER_10HZ,
> +	INV_FILTER_5HZ,
> +	INV_FILTER_2100HZ_NOLPF,
> +	NUM_FILTER
> +};
> +
> +/*==== MPU6050B1 MEMORY ====*/
/* is plenty of highlighting ;)
> +enum MPU_MEMORY_BANKS {
> +	MEM_RAM_BANK_0 = 0,
> +	MEM_RAM_BANK_1,
> +	MEM_RAM_BANK_2,
> +	MEM_RAM_BANK_3,
> +	MEM_RAM_BANK_4,
> +	MEM_RAM_BANK_5,
> +	MEM_RAM_BANK_6,
> +	MEM_RAM_BANK_7,
> +	MEM_RAM_BANK_8,
> +	MEM_RAM_BANK_9,
> +	MEM_RAM_BANK_10,
> +	MEM_RAM_BANK_11,
> +	MPU_MEM_NUM_RAM_BANKS,
> +	MPU_MEM_OTP_BANK_0 = 16
> +};
> +
> +/* IIO attribute address */
> +enum MPU_IIO_ATTR_ADDR {
> +	ATTR_GYRO_MATRIX,
> +	ATTR_ACCL_MATRIX,
> +};
> +
> +enum inv_accl_fs_e {
> +	INV_FS_02G = 0,
> +	INV_FS_04G,
> +	INV_FS_08G,
> +	INV_FS_16G,
> +	NUM_ACCL_FSR
> +};
> +
> +enum inv_fsr_e {
> +	INV_FSR_250DPS = 0,
> +	INV_FSR_500DPS,
> +	INV_FSR_1000DPS,
> +	INV_FSR_2000DPS,
> +	NUM_FSR
> +};
> +
> +enum inv_clock_sel_e {
> +	INV_CLK_INTERNAL = 0,
> +	INV_CLK_PLL,
> +	NUM_CLK
> +};
> +
> +int inv_mpu_configure_ring(struct iio_dev *indio_dev);
> +int inv_mpu_probe_trigger(struct iio_dev *indio_dev);
> +void inv_mpu_remove_trigger(struct inv_mpu_iio_s *st);
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st);
> +int set_inv_enable(struct iio_dev *indio_dev, bool enable);
inv_set_enable would be a more consistent name!
> +int inv_switch_engine(struct inv_mpu_iio_s *st, bool en, u32 mask);
> +int mpu_write_reg(struct inv_mpu_iio_s *st, int reg, u8 val);
> +int inv_set_power_itg(struct inv_mpu_iio_s *st, bool power_on);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c
> new file mode 100644
> index 0000000..f28efb1
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c
> @@ -0,0 +1,241 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
> +
> +/*
> +* inv_mpu_misc.c: this file is for miscellaneous functions for inv mpu
> +*                 driver, such as silicon revision.
We know the file name ;)  The comment can be pushed up into the first
comment block (or dropped)
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/kfifo.h>
> +#include <linux/poll.h>
> +#include <linux/miscdevice.h>
> +
> +#include "inv_mpu_iio.h"
> +/* NOTE: product entries are in chronological order */
> +static const struct prod_rev_map_t prod_rev_map[] = {
> +	/* prod_ver = 0 */
> +	{MPL_PROD_KEY(0,   1), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   2), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   3), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   4), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   5), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   6), MPU_SILICON_REV_A2, 131, 16384},
> +	/* prod_ver = 1, forced to 0 for MPU6050 A2 */
> +	{MPL_PROD_KEY(0,   7), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   8), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   9), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  10), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  11), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  12), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  13), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  14), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  15), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  27), MPU_SILICON_REV_A2, 131, 16384},
> +	/* prod_ver = 1 */
> +	{MPL_PROD_KEY(1,  16), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,  17), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,  18), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,  19), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,  20), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,  28), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,   1), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,   2), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,   3), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,   4), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,   5), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(1,   6), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 2 */
> +	{MPL_PROD_KEY(2,   7), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(2,   8), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(2,   9), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(2,  10), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(2,  11), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(2,  12), MPU_SILICON_REV_B1, 131, 16384},
> +	{MPL_PROD_KEY(2,  29), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 3 */
> +	{MPL_PROD_KEY(3,  30), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 4 */
> +	{MPL_PROD_KEY(4,  31), MPU_SILICON_REV_B1, 131,  8192},
> +	{MPL_PROD_KEY(4,   1), MPU_SILICON_REV_B1, 131,  8192},
> +	{MPL_PROD_KEY(4,   3), MPU_SILICON_REV_B1, 131,  8192},
> +	/* prod_ver = 5 */
> +	{MPL_PROD_KEY(5,   3), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 6 */
> +	{MPL_PROD_KEY(6,  19), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 7 */
> +	{MPL_PROD_KEY(7,  19), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 8 */
> +	{MPL_PROD_KEY(8,  19), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 9 */
> +	{MPL_PROD_KEY(9,  19), MPU_SILICON_REV_B1, 131, 16384},
> +	/* prod_ver = 10 */
> +	{MPL_PROD_KEY(10, 19), MPU_SILICON_REV_B1, 131, 16384}
> +};
> +
> +/*
> +*   List of product software revisions
> +*
> +*   NOTE :
> +*   software revision 0 falls back to the old detection method
> +*   based off the product version and product revision per the
> +*   table above
> +*/
> +static const struct prod_rev_map_t sw_rev_map[] = {
> +	{0,		     0,   0,     0},
> +	{1, MPU_SILICON_REV_B1, 131,  8192},	/* rev C */
> +	{2, MPU_SILICON_REV_B1, 131, 16384}	/* rev D */
> +};
> +
> +static int mpu_memory_read(struct inv_mpu_iio_s *st,
> +			   u16 mem_addr, u32 len, u8 *data)
> +{
> +	u8 bank[2] = {MPU_REG_BANK_SEL, mem_addr >> 8};
> +	u8 addr[2] = {MPU_REG_MEM_START_ADDR, mem_addr & 0xff};
> +	u8 buf = MPU_REG_MEM_RW;
> +	int res;
> +	struct i2c_msg msgs[4] = {
> +		{
> +			.addr  = st->client->addr,
> +			.flags = 0,
> +			.buf   = bank,
> +			.len   = sizeof(bank),
> +		}, {
> +			.addr  = st->client->addr,
> +			.flags = 0,
> +			.buf   = addr,
> +			.len   = sizeof(addr),
> +		}, {
> +			.addr  = st->client->addr,
> +			.flags = 0,
> +			.buf   = &buf,
> +			.len   = 1,
> +		}, {
> +			.addr  = st->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf   = data,
> +			.len   = len,
> +		}
> +	};
> +
> +	res = i2c_transfer(st->client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (res != 4) {
> +		if (res >= 0)
If you have an error in res, then return that rather than
making up your own.
> +			res = -EIO;
> +		return res;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +/**
> + *  index_of_key() - Inverse lookup of the index of an MPL product key.
> + *  @key:    the MPL product indentifier also referred to as 'key'.
> + *  @return the index position of the key in the array.
> + */
> +static s16 index_of_key(u16 key)
> +{
> +	int i;
> +	for (i = 0; i < NUM_OF_PROD_REVS; i++)
> +		if (prod_rev_map[i].mpl_product_key == key)
> +			return (s16)i;
> +
> +	return -EINVAL;
> +}
> +
I can't immediately see this info being used... (though I am being
lazy and not searching for everything set in here ;)
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	u8 prod_ver, prod_rev, bank;
> +	u16 key, sw_rev, index, mem_addr;
> +	const struct inv_reg_map_s *reg;
> +	struct prod_rev_map_t *p_rev;
> +	u8 regs[SOFT_PROD_VER_BYTES];
> +	struct inv_chip_info_s *chip_info = &st->chip_info;
> +
> +	prod_ver = 0;
> +	prod_rev = 0;
> +	bank = (MPU_BIT_PRFTCH_EN | MPU_BIT_CFG_USER_BANK |
> +					MPU_MEM_OTP_BANK_0);
> +	mem_addr = ((bank << 8) | MEM_ADDR_PROD_REV);
> +	reg = st->reg;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       MPU_REG_PRODUCT_ID,
> +					       1, &prod_ver);
> +	if (result != 1)
> +		return result;
> +	prod_ver &= 0xf;
> +	/* OTP memory read need more time after power up */
> +	msleep(POWER_UP_TIME);
> +	result = mpu_memory_read(st, mem_addr, 1, &prod_rev);
> +	if (result)
> +		return result;
> +	prod_rev >>= 2;
> +	/* clean the prefetch and cfg user bank bits */
> +	result = mpu_write_reg(st, reg->bank_sel, 0);
> +	if (result)
> +		return result;
> +	/* get the software-product version, read from XA_OFFS_L */
Why?  It's nice an all, but does it matter?
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +						MPU_REG_XA_OFFS_L_TC,
> +						SOFT_PROD_VER_BYTES, regs);
> +	if (result != SOFT_PROD_VER_BYTES)
> +		return -EINVAL;
> +
> +	sw_rev = (regs[4] & 0x01) << 2 |	/* 0x0b, bit 0 */
> +		 (regs[2] & 0x01) << 1 |	/* 0x09, bit 0 */
> +		 (regs[0] & 0x01);		/* 0x07, bit 0 */
> +	/* if 0, use the product key to determine the type of part */
> +	if (sw_rev == 0) {
> +		key = MPL_PROD_KEY(prod_ver, prod_rev);
> +		if (key == 0)
> +			return -EINVAL;
> +		index = index_of_key(key);
> +		if (index < 0 || index >= NUM_OF_PROD_REVS)
> +			return -EINVAL;
> +		/* check MPL is compiled for this device */
> +		if (prod_rev_map[index].silicon_rev != MPU_SILICON_REV_B1)
> +			return -EINVAL;
> +		p_rev = (struct prod_rev_map_t *)&prod_rev_map[index];
> +	/* if valid, use the software product key */
> +	} else if (sw_rev < ARRAY_SIZE(sw_rev_map)) {
> +		p_rev = (struct prod_rev_map_t *)&sw_rev_map[sw_rev];
> +	} else {
> +		return -EINVAL;
> +	}
> +	chip_info->product_id = prod_ver;
These are all very nice, but not as far as I can see used anywhere..
You could spit them out to debugfs I guess...

If not, don't bother reading them until there is a reason to do so.
> +	chip_info->product_revision = prod_rev;
> +	chip_info->silicon_revision = p_rev->silicon_rev;
> +	chip_info->software_revision = sw_rev;
> +	chip_info->gyro_sens_trim = p_rev->gyro_trim;
> +	chip_info->accl_sens_trim = p_rev->accel_trim;
> +	if (chip_info->accl_sens_trim == 0)
> +		chip_info->accl_sens_trim = DEFAULT_ACCL_TRIM;
> +	chip_info->multi = DEFAULT_ACCL_TRIM / chip_info->accl_sens_trim;
> +	if (chip_info->multi != 1)
> +		dev_err(&st->client->adapter->dev, "multi is %d\n",
> +				chip_info->multi);
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> new file mode 100644
> index 0000000..d349797
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -0,0 +1,331 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/kfifo.h>
> +#include <linux/poll.h>
> +#include "inv_mpu_iio.h"
> +
> +static void inv_scan_query(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +	struct iio_buffer *ring = indio_dev->buffer;
> +
> +	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_X) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Y) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Z))

st->chip_config.gyro_fifo_enable = iio_scan_mask_query(...) etc.
Also this is actualy reading the wrong mask now we have multiple buffers
supported.  (must check to see if anyone else is doing this...)
Should be reading indio_dev->active_scan_mask, not the ring
specific one (might need an additional utility function adding to the core).

> +		st->chip_config.gyro_fifo_enable = 1;
> +	else
> +		st->chip_config.gyro_fifo_enable = 0;
> +
> +	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_ACCL_X) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_ACCL_Y) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_ACCL_Z))
> +		st->chip_config.accl_fifo_enable = 1;
> +	else
> +		st->chip_config.accl_fifo_enable = 0;
> +}
> +
> +/**
> + *  reset_fifo() - Reset FIFO related registers.
> + *  @indio_dev:	   Device driver instance.
> + */
> +static int inv_reset_fifo(struct iio_dev *indio_dev)
> +{
> +	const struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +
> +	reg = st->reg;
> +	/* disable interrupt */
> +	result = mpu_write_reg(st, reg->int_enable, 0);
> +	if (result) {
> +		dev_err(&st->client->dev, "int_enable failed %d\n", result);
> +		return result;
> +	}
> +	/* disable the sensor output to FIFO */
> +	result = mpu_write_reg(st, reg->fifo_en, 0);
> +	if (result)
> +		goto reset_fifo_fail;
> +	/* disable fifo reading */
> +	result = mpu_write_reg(st, reg->user_ctrl, 0);
> +	if (result)
> +		goto reset_fifo_fail;
> +
> +	/* reset FIFO*/
> +	result = mpu_write_reg(st, reg->user_ctrl, MPU_BIT_FIFO_RST);
> +	if (result)
> +		goto reset_fifo_fail;
> +	st->last_isr_time = iio_get_time_ns();
> +	/* enable interrupt */
> +	if (st->chip_config.accl_fifo_enable ||
> +	    st->chip_config.gyro_fifo_enable) {
> +		result = mpu_write_reg(st, reg->int_enable,
> +					MPU_BIT_DATA_RDY_EN);
> +		if (result)
> +			return result;
> +	}
> +	/* enable FIFO reading and I2C master interface*/
> +	result = mpu_write_reg(st, reg->user_ctrl, MPU_BIT_FIFO_EN);
> +	if (result)
> +		goto reset_fifo_fail;
> +	/* enable sensor output to FIFO */
> +	d = 0;
> +	if (st->chip_config.gyro_fifo_enable)
> +		d |= MPU_BITS_GYRO_OUT;
> +	if (st->chip_config.accl_fifo_enable)
> +		d |= MPU_BIT_ACCEL_OUT;
> +	result = mpu_write_reg(st, reg->fifo_en, d);
> +	if (result)
> +		goto reset_fifo_fail;
> +
> +	return 0;
> +
> +reset_fifo_fail:
> +	dev_err(&st->client->dev, "reset fifo failed %d\n", result);
> +	result = mpu_write_reg(st, reg->int_enable, MPU_BIT_DATA_RDY_EN);
> +
> +	return result;
> +}
> +
> +/**
> + *  set_inv_enable() - enable chip functions.
> + *  @indio_dev:	Device driver instance.
> + *  @enable: enable/disable
> + */
> +int set_inv_enable(struct iio_dev *indio_dev, bool enable)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	const struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +
> +	reg = st->reg;
> +	if (enable) {
> +		result = inv_set_power_itg(st, true);
> +		if (result)
> +			return result;
> +		inv_scan_query(indio_dev);
> +		if (st->chip_config.gyro_fifo_enable) {
> +			result = inv_switch_engine(st, true,
> +					MPU_BIT_PWR_GYRO_STBY);
> +			if (result)
> +				return result;
> +		}
> +		if (st->chip_config.accl_fifo_enable) {
> +			result = inv_switch_engine(st, true,
> +					MPU_BIT_PWR_ACCL_STBY);
> +			if (result)
> +				return result;
> +		}
> +		result = inv_reset_fifo(indio_dev);
> +		if (result)
> +			return result;
> +	} else {
> +		d = 0;
> +		result = mpu_write_reg(st, reg->fifo_en, d);
> +		if (result)
> +			return result;
> +
> +		result = mpu_write_reg(st, reg->int_enable, d);
> +		if (result)
> +			return result;
> +
> +		result = mpu_write_reg(st, reg->user_ctrl, d);
> +		if (result)
> +			return result;
> +
> +		result = inv_switch_engine(st, false, MPU_BIT_PWR_GYRO_STBY);
> +		if (result)
> +			return result;
> +
> +		result = inv_switch_engine(st, false, MPU_BIT_PWR_ACCL_STBY);
> +		if (result)
> +			return result;
> +		result = inv_set_power_itg(st, false);
> +		if (result)
> +			return result;
> +	}
> +	st->chip_config.enable = enable;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_clear_kfifo() - clear time stamp fifo
> + *  @st:	Device driver instance.
> + */
> +static void inv_clear_kfifo(struct inv_mpu_iio_s *st)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(&st->time_stamp_lock, flags);
> +	kfifo_reset(&st->timestamps);
> +	spin_unlock_irqrestore(&st->time_stamp_lock, flags);
> +}
> +
> +/**
> + *  inv_irq_handler() - Cache a timestamp at each data ready interrupt.
> + */
> +static irqreturn_t inv_irq_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	s64 timestamp;
> +	int catch_up;
> +	s64 time_since_last_irq;
> +
> +	timestamp = iio_get_time_ns();
> +	time_since_last_irq = timestamp - st->last_isr_time;
> +	spin_lock(&st->time_stamp_lock);
> +	catch_up = 0;
> +	/* This handles when we missed a few IRQ's. So the time between two IRQ
> +	   are too big. The sensor data is already in the FIFO. So we need to
> +	   catch up. If too much gap is detected, ignore and we will reset
> +	   inside reset_fifo function */
Just to throw out another option.  When I hit a similar issue I decided
it was best left to userspace and simply set the timestamp to 0 to indicate
that it was invalid.

Also I'd prefer to see optional timestamps.  Whilst we are here, this
is threaded and appropriately masked so we can't have more than one
instance of htis code at a time.  As such can we reduce the amount of
code the spin lock is held for?
> +	while ((time_since_last_irq > st->irq_dur_ns * 2) &&
> +	       (catch_up < MAX_CATCH_UP)) {
> +		st->last_isr_time += st->irq_dur_ns;
> +		kfifo_in(&st->timestamps,
> +			 &st->last_isr_time, 1);
> +		time_since_last_irq = timestamp - st->last_isr_time;
> +		catch_up++;
> +	}
> +	kfifo_in(&st->timestamps, &timestamp, 1);
> +	st->last_isr_time = timestamp;
> +	spin_unlock(&st->time_stamp_lock);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static int inv_report_gyro_accl(struct iio_dev *indio_dev, u8 *data, s64 t)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	int ind;
> +	struct inv_chip_config_s *conf;
> +	u64 *tmp;
> +
> +	conf = &st->chip_config;
> +	ind = 0;
> +	if (conf->accl_fifo_enable)
> +		ind += BYTES_PER_3AXIS_SENSOR;
> +
> +	if (conf->gyro_fifo_enable)
> +		ind += BYTES_PER_3AXIS_SENSOR;
You just computed this in the calling function.  I'd actually
scrap this function entirely and roll the remaining approx 4 lines
into the call site.
> +	tmp = (u64 *)data;
> +
> +	tmp[DIV_ROUND_UP(ind, 8)] = t;
> +
> +	if (ind > 0)
> +		iio_push_to_buffers(indio_dev, data);
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_read_fifo() - Transfer data from hardware FIFO to KFIFO.
> + */
> +static irqreturn_t inv_read_fifo(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	size_t bytes_per_datum;
> +	int result;
> +	u8 data[OUTPUT_DATA_SIZE];
> +	u16 fifo_count;
> +	s64 timestamp;
> +	const struct inv_reg_map_s *reg;
> +
> +	reg = st->reg;
> +	mutex_lock(&indio_dev->mlock);
> +	if (!(st->chip_config.accl_fifo_enable |
> +		st->chip_config.gyro_fifo_enable))
> +		goto end_session;
> +	bytes_per_datum = 0;
> +	if (st->chip_config.accl_fifo_enable)
> +		bytes_per_datum += BYTES_PER_3AXIS_SENSOR;
> +
> +	if (st->chip_config.gyro_fifo_enable)
> +		bytes_per_datum += BYTES_PER_3AXIS_SENSOR;
> +
> +	/* read fifo_count register to know how many bytes inside FIFO
> +	   right now */
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->fifo_count_h,
> +					       FIFO_COUNT_BYTE, data);
> +	if (result != FIFO_COUNT_BYTE)
> +		goto end_session;
> +	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
> +	if (fifo_count < bytes_per_datum)
> +		goto end_session;
> +	/* fifo count can't be odd number */
If it can't happen, why check?
> +	if (fifo_count & 1)
> +		goto flush_fifo;

why?
> +	if (fifo_count >  FIFO_THRESHOLD)
> +		goto flush_fifo;
> +	/* Timestamp mismatch. */
> +	if (kfifo_len(&st->timestamps) < fifo_count / bytes_per_datum)
> +		goto flush_fifo;
> +	if (kfifo_len(&st->timestamps) >
> +		fifo_count / bytes_per_datum + TIME_STAMP_TOR)
> +			goto flush_fifo;
> +	while (fifo_count >= bytes_per_datum) {
> +		result = i2c_smbus_read_i2c_block_data(st->client,
> +						       reg->fifo_r_w,
> +						       bytes_per_datum, data);
> +		if (result != bytes_per_datum)
> +			goto flush_fifo;
> +
> +		result = kfifo_out(&st->timestamps, &timestamp, 1);
> +		if (0 == result)
> +			goto flush_fifo;
> +		inv_report_gyro_accl(indio_dev, data, timestamp);
> +		fifo_count -= bytes_per_datum;
> +	}
> +
> +end_session:
> +	mutex_unlock(&indio_dev->mlock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +
> +flush_fifo:
> +	/* Flush HW and SW FIFOs. */
> +	inv_reset_fifo(indio_dev);
> +	inv_clear_kfifo(st);
> +	mutex_unlock(&indio_dev->mlock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int inv_mpu_configure_ring(struct iio_dev *indio_dev)
> +{
> +	return iio_triggered_buffer_setup(indio_dev,
> +					inv_irq_handler,
> +					inv_read_fifo,
> +					NULL);
> +}
> +
No blank line at end of file please (git am told me there were 4 of these).

> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> new file mode 100644
> index 0000000..fcf4595
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -0,0 +1,65 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
> +
> +#include "inv_mpu_iio.h"
> +
> +/**
> + * inv_mpu_data_rdy_trigger_set_state() set data ready interrupt state
If going to document, please do full kernel-doc and deal with any warnings/
errors that come up processing the resulting docs.
> + **/
> +static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						bool state)
> +{
> +	struct iio_dev *indio_dev = trig->private_data;
> +
> +	return set_inv_enable(indio_dev, state);
Combine the above into one line.
> +}
> +
> +static const struct iio_trigger_ops inv_mpu_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
You need some callbacks to prevent this being attached to another
trigger...
> +};
> +
> +int inv_mpu_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +
> +	st->trig = iio_trigger_alloc("%s-dev%d",
> +					indio_dev->name,
> +					indio_dev->id);
> +	ret = request_irq(st->irq, &iio_trigger_generic_data_rdy_poll,
> +				IRQF_TRIGGER_RISING,
> +				"inv_mpu",
> +				st->trig);
> +	if (st->trig == NULL)
> +		return -ENOMEM;
> +	st->trig->dev.parent = &st->client->dev;
> +	st->trig->private_data = indio_dev;
> +	st->trig->ops = &inv_mpu_trigger_ops;
> +	ret = iio_trigger_register(st->trig);
> +
> +	if (ret) {
> +		iio_trigger_free(st->trig);
> +		return -EPERM;
Please return whatever iio_trigger_register returns rather than
EPERM.  Also, you need to unwind the request_irq above if an
error occurs (and free the trigger for that matter)
Use the standard goto approach used all over
the kernel (as it's what we have grown to expect ;)
> +	}
> +	indio_dev->trig = st->trig;
> +
> +	return 0;
> +}
> +
> +void inv_mpu_remove_trigger(struct inv_mpu_iio_s *st)
> +{
> +	iio_trigger_unregister(st->trig);
> +	iio_trigger_free(st->trig);
> +}
> diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
> new file mode 100644
> index 0000000..6a368c1
> --- /dev/null
> +++ b/include/linux/platform_data/invensense_mpu6050.h
> @@ -0,0 +1,32 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
> +
> +#ifndef __MPU_H_
> +#define __MPU_H_
> +
> +/**
> + * struct mpu_platform_data - Platform data for the mpu driver
> + * @orientation:	Orientation matrix of the chip
> + *
> + * Contains platform specific information on how to configure the MPU6050 to
> + * work on this platform.  The orientation matricies are 3x3 rotation matricies
> + * that are applied to the data to rotate from the mounting orientation to the
> + * platform orientation.  The values must be one of 0, 1, or -1 and each row and
> + * column should have exactly 1 non-zero value.
> + */
> +struct mpu_platform_data {
> +	__s8 orientation[9];
> +};
> +
> +#endif	/* __MPU_H_ */
>
