Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:42448 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab3BEB2b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2013 20:28:31 -0500
Received: by mail-ee0-f53.google.com with SMTP id e53so3562841eek.40
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2013 17:28:29 -0800 (PST)
From: Ge Gao <ggao@invensense.com>
References: <52d13e205f916eefa0b7fda2c8d0f20a@mail.gmail.com>
 <2b0b8fba-fc2c-44fb-9512-d86e87b698c1@email.android.com> <51101648.7000205@metafoo.de>
In-Reply-To: <51101648.7000205@metafoo.de>
MIME-Version: 1.0
Date: Mon, 4 Feb 2013 17:28:26 -0800
Message-ID: <4781ec0fc6f6eb18cc8470fabce3e2a6@mail.gmail.com>
Subject: RE: [PATCH] [V9] Invensense MPU6050 Device Driver.
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Lars and Jonanthan,
	I have one question regarding the timestamp inside IRQ. I found that the
timestamp taken during IRQ is not accurate and it varies a lot. I can see
the hardware interrupt came in a regular pace while the timestamp taken
varies violently(up to 50% or more). It seems that it is because the data
cache that stores the timestamp(xtime) is not updated when there is
interrupt. So it actually takes the wrong timestamp. I searched online and
didn't find any useful ideas. I think taking timestamp during IRQ is a
common practice. Is there any existing solution for this or did I do
anything wrong? The code in the current patch is inv_mpu6050_irq_handler()
of inv_mpu_ring.c. Thanks.

Best Regards,

Ge GAO


-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]
Sent: Monday, February 04, 2013 12:13 PM
To: Jonathan Cameron
Cc: Ge Gao; linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.

On 02/04/2013 08:42 PM, Jonathan Cameron wrote:
> I don't really mind. If you are happy with my patch I can just merge the
> two together.
>
> Only remaining question to my mind is if Lars wants to give a reviewed-by
> or take another look.
>

I'll try to take a look at it tomorrow.

- Lars

>
>
> Ge Gao <ggao@invensense.com> wrote:
>
>> Dear Jonanthan,
>> 	Thanks for the suggestions.  So do you need another submission of
>> patch? I think a patch from you would fix everything as you mentioned
>> in the email.
>>
>> Best Regards,
>>
>> Ge GAO
>>
>>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Sunday, February 03, 2013 7:51 AM
>> To: Ge GAO
>> Cc: Lars-Peter Clausen; linux-iio@vger.kernel.org
>> Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.
>>
>> On 02/02/2013 12:26 AM, Ge GAO wrote:
>>> From: Ge Gao <ggao@invensense.com>
>>>
>>> --This the basic function of Invensense MPU6050 Deivce driver.
>>> --align coding style.
>>> --rearrange function from ring to trigger.
>>> --other cleanup.
>>>
>>> Signed-off-by: Ge Gao <ggao@invensense.com>
>> Couple of trivial nitpicks inline.
>>
>> Kernel-doc syntax is inconsistent. Try actually running the
>> scripts over code and fix the errors/warnings.   What I've done
>> so far is just be eye but it'll give you an idea.
>>
>> As it's all trivial stuff I'll send you a patch fixing it up in a
>> minute.  If you want to fill in missing variables in the kernel-doc
>> that would be nice but certainly isn't important.
>>
>> On trivial suggestion to do with dropping the reg element from your
>> device structure (as it's always available indirectly) but that's
>> entirely up to you.
>>
>> Anyhow the stuff here is trivial (if worth doing) and with those in
>> place I'll apply the patch if Lars is also happy.
>>
>> Jonathan
>>
>>> ---
>>>  documentation/ABI/testing/sysfs-bus-iio-mpu6050  |   14 +
>>>  drivers/iio/imu/Kconfig                          |    2 +
>>>  drivers/iio/imu/Makefile                         |    2 +
>>>  drivers/iio/imu/inv_mpu6050/Kconfig              |   13 +
>>>  drivers/iio/imu/inv_mpu6050/Makefile             |    6 +
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       |  786
>> ++++++++++++++++++++++
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h        |  247 +++++++
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c       |  194 ++++++
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c    |  153 +++++
>>>  include/linux/platform_data/invensense_mpu6050.h |   32 +
>>>  10 files changed, 1449 insertions(+), 0 deletions(-)  create mode
>>> 100644 Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/Kconfig
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/Makefile
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>>>  create mode 100644 include/linux/platform_data/invensense_mpu6050.h
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>> b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>>> new file mode 100644
>>> index 0000000..d4ec747
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>>> @@ -0,0 +1,14 @@
>>> +What:           /sys/bus/iio/devices/iio:deviceX/in_gyro_matrix
>>> +What:           /sys/bus/iio/devices/iio:deviceX/in_accel_matrix
>>> +What:           /sys/bus/iio/devices/iio:deviceX/in_magn_matrix
>>> +KernelVersion:  3.4.0
>>> +Contact:        linux-iio@vger.kernel.org
>>> +Description:
>>> +		This is mounting matrix for motion sensors. Mounting
>> matrix
>>> +		is a 3x3 unitary matrix. A typical mounting matrix would
>> look like
>>> +		[0, 1, 0; 1, 0, 0; 0, 0, -1]. Using this information, it
>> would be
>>> +		easy to tell the relative positions among sensors as well
>> as their
>>> +		positions relative to the board that holds these sensors.
>> Identity matrix
>>> +		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and device
>> are perfectly
>>> +		aligned with each other. All axes are exactly the same.
>>> +
>>> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig index
>>> 3d79a40..723563b 100644
>>> --- a/drivers/iio/imu/Kconfig
>>> +++ b/drivers/iio/imu/Kconfig
>>> @@ -25,3 +25,5 @@ config IIO_ADIS_LIB_BUFFER
>>>  	help
>>>  	  A set of buffer helper functions for the Analog Devices ADIS*
>> device
>>>  	  family.
>>> +
>>> +source "drivers/iio/imu/inv_mpu6050/Kconfig"
>>> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
>>> index cfe5763..1b41584 100644
>>> --- a/drivers/iio/imu/Makefile
>>> +++ b/drivers/iio/imu/Makefile
>>> @@ -8,3 +8,5 @@ adis_lib-y += adis.o
>>>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
>>>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
>>>  obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
>>> +
>>> +obj-y += inv_mpu6050/
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig
>> b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> new file mode 100644
>>> index 0000000..b5cfa3a
>>> --- /dev/null
>>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> @@ -0,0 +1,13 @@
>>> +#
>>> +# inv-mpu6050 drivers for Invensense MPU devices and combos #
>>> +
>>> +config INV_MPU6050_IIO
>>> +	tristate "Invensense MPU6050 devices"
>>> +	depends on I2C && SYSFS
>>> +	select IIO_TRIGGERED_BUFFER
>>> +	help
>>> +	  This driver supports the Invensense MPU6050 devices.
>>> +	  It is a gyroscope/accelerometer combo device.
>>> +	  This driver can be built as a module. The module will be called
>>> +	  inv-mpu6050.
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile
>> b/drivers/iio/imu/inv_mpu6050/Makefile
>>> new file mode 100644
>>> index 0000000..3a677c7
>>> --- /dev/null
>>> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
>>> @@ -0,0 +1,6 @@
>>> +#
>>> +# Makefile for Invensense MPU6050 device.
>>> +#
>>> +
>>> +obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o inv-mpu6050-objs :=
>>> +inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> new file mode 100644
>>> index 0000000..bea47d0
>>> --- /dev/null
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -0,0 +1,786 @@
>>> +/*
>>> +* Copyright (C) 2012 Invensense, Inc.
>>> +*
>>> +* This software is licensed under the terms of the GNU General
>> Public
>>> +* License version 2, as published by the Free Software Foundation,
>> and
>>> +* may be copied, distributed, and modified under those terms.
>>> +*
>>> +* This program is distributed in the hope that it will be useful,
>>> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +* GNU General Public License for more details.
>>> +*/
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/err.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/sysfs.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/kfifo.h>
>>> +#include <linux/spinlock.h>
>>> +#include "inv_mpu_iio.h"
>>> +
>>> +/* this is the gyro scale translated from dynamic range plus/minus
>>> +   {250, 500, 1000, 2000} to rad/s */ static const int
>>> +gyro_scale_6050[] = {133090, 266181, 532362,
>> 1064724};
>>> +
>>> +/* this is the accel scale translated from dynamic range plus/minus
>>> +   {2, 4, 8, 16} to m/s^2 */
>>> +static const int accel_scale[] = {598, 1196, 2392, 4785};
>>> +
>>> +static const struct inv_mpu6050_reg_map reg_set_6050 = {
>>> +	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
>>> +	.lpf                    = INV_MPU6050_REG_CONFIG,
>>> +	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
>>> +	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
>>> +	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
>>> +	.accl_config            = INV_MPU6050_REG_ACCEL_CONFIG,
>>> +	.fifo_count_h           = INV_MPU6050_REG_FIFO_COUNT_H,
>>> +	.fifo_r_w               = INV_MPU6050_REG_FIFO_R_W,
>>> +	.raw_gyro               = INV_MPU6050_REG_RAW_GYRO,
>>> +	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
>>> +	.temperature            = INV_MPU6050_REG_TEMPERATURE,
>>> +	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
>>> +	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>>> +	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>>> +};
>>> +
>>> +static const struct inv_mpu6050_chip_config chip_config_6050 = {
>>> +	.fsr = INV_MPU6050_FSR_2000DPS,
>>> +	.lpf = INV_MPU6050_FILTER_20HZ,
>>> +	.fifo_rate = INV_MPU6050_INIT_FIFO_RATE,
>>> +	.gyro_fifo_enable = false,
>>> +	.accl_fifo_enable = false,
>>> +	.accl_fs = INV_MPU6050_FS_02G,
>>> +};
>>> +
>>> +static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
>>> +	{
>>> +		.num_reg = 117,
>>> +		.name = "MPU6050",
>>> +		.reg = &reg_set_6050,
>>> +		.config = &chip_config_6050,
>>> +	},
>>> +};
>>> +
>>> +int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8
>> d)
>>> +{
>>> +	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d); }
>>> +
>>> +int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool
>>> +en,
>> u32 mask)
>>> +{
>>> +	u8 d, mgmt_1;
>>> +	int result;
>>> +
>> Another wrong multiline comment syntax.
>>> +	/* switch clock needs to be careful. Only when gyro is on, can
>>> +	   clock source be switched to gyro. Otherwise, it must be set to
>>> +	   internal clock */
>>> +	if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
>>> +		result = i2c_smbus_read_i2c_block_data(st->client,
>>> +				       st->reg->pwr_mgmt_1, 1, &mgmt_1);
>>> +		if (result != 1)
>>> +			return result;
>>> +
>>> +		mgmt_1 &= ~INV_MPU6050_BIT_CLK_MASK;
>>> +	}
>>> +
>>> +	if ((INV_MPU6050_BIT_PWR_GYRO_STBY == mask) && (!en)) {
>>> +		/* turning off gyro requires switch to internal clock
>> first.
>>> +		   Then turn off gyro engine */
>>> +		mgmt_1 |= INV_CLK_INTERNAL;
>>> +		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>> mgmt_1);
>>> +		if (result)
>>> +			return result;
>>> +	}
>>> +
>>> +	result = i2c_smbus_read_i2c_block_data(st->client,
>>> +				       st->reg->pwr_mgmt_2, 1, &d);
>>> +	if (result != 1)
>>> +		return result;
>>> +	if (en)
>>> +		d &= ~mask;
>>> +	else
>>> +		d |= mask;
>>> +	result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_2, d);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	if (en) {
>>> +		/* Wait for output stablize */
>>> +		msleep(INV_MPU6050_TEMP_UP_TIME);
>>> +		if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
>>> +			/* switch internal clock to PLL */
>>> +			mgmt_1 |= INV_CLK_PLL;
>>> +			result = inv_mpu6050_write_reg(st,
>>> +					st->reg->pwr_mgmt_1, mgmt_1);
>>> +			if (result)
>>> +				return result;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool
>> power_on)
>>> +{
>>> +	int result;
>>> +
>>> +	if (power_on)
>>> +		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>> 0);
>>> +	else
>>> +		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>>> +						INV_MPU6050_BIT_SLEEP);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	if (power_on)
>>> +		msleep(INV_MPU6050_REG_UP_TIME);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
>>> + *
>>> + *  Initial configuration:
>>> + *  FSR: +/- 2000DPS
>>> + *  DLPF: 20Hz
>>> + *  FIFO rate: 50Hz
>>> + *  Clock source: Gyro PLL
>>> + */
>>> +static int inv_mpu6050_init_config(struct iio_dev *indio_dev) {
>>> +	int result;
>>> +	u8 d;
>>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>> +
>>> +	result = inv_mpu6050_set_power_itg(st, true);
>>> +	if (result)
>>> +		return result;
>>> +	d = (INV_MPU6050_FSR_2000DPS <<
>> INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>>> +	result = inv_mpu6050_write_reg(st, st->reg->gyro_config, d);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	d = INV_MPU6050_FILTER_20HZ;
>>> +	result = inv_mpu6050_write_reg(st, st->reg->lpf, d);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
>>> +	result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
>>> +	result = inv_mpu6050_write_reg(st, st->reg->accl_config, d);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	memcpy(&st->chip_config, hw_info[st->chip_type].config,
>>> +		sizeof(struct inv_mpu6050_chip_config));
>>> +	result = inv_mpu6050_set_power_itg(st, false);
>>> +
>>> +	return result;
>>> +}
>>> +
>>> +static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st,
>> int
>> reg,
>>> +				int axis, int *val)
>>> +{
>>> +	int ind, result;
>>> +	__be16 d;
>>> +
>>> +	ind = (axis - IIO_MOD_X) * 2;
>>> +	result = i2c_smbus_read_i2c_block_data(st->client, reg + ind,  2,
>>> +						(u8 *)&d);
>>> +	if (result != 2)
>>> +		return -EINVAL;
>>> +	*val = (short)be16_to_cpup(&d);
>>> +
>>> +	return IIO_VAL_INT;
>>> +}
>>> +
>>> +static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>>> +			      struct iio_chan_spec const *chan,
>>> +			      int *val,
>>> +			      int *val2,
>>> +			      long mask) {
>>> +	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +	{
>>> +		int ret, result;
>>> +
>>> +		ret = IIO_VAL_INT;
>>> +		result = 0;
>>> +		mutex_lock(&indio_dev->mlock);
>>> +		if (!st->chip_config.enable) {
>>> +			result = inv_mpu6050_set_power_itg(st, true);
>>> +			if (result)
>>> +				goto error_read_raw;
>>> +		}
>>> +		/* when enable is on, power is already on */
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			if (!st->chip_config.gyro_fifo_enable ||
>>> +					!st->chip_config.enable) {
>>> +				result = inv_mpu6050_switch_engine(st,
>> true,
>>> +
>> INV_MPU6050_BIT_PWR_GYRO_STBY);
>>> +				if (result)
>>> +					goto error_read_raw;
>>> +			}
>>> +			ret =  inv_mpu6050_sensor_show(st,
>> st->reg->raw_gyro,
>>> +						chan->channel2, val);
>>> +			if (!st->chip_config.gyro_fifo_enable ||
>>> +					!st->chip_config.enable) {
>>> +				result = inv_mpu6050_switch_engine(st,
>> false,
>>> +
>> INV_MPU6050_BIT_PWR_GYRO_STBY);
>>> +				if (result)
>>> +					goto error_read_raw;
>>> +			}
>>> +			break;
>>> +		case IIO_ACCEL:
>>> +			if (!st->chip_config.accl_fifo_enable ||
>>> +					!st->chip_config.enable) {
>>> +				result = inv_mpu6050_switch_engine(st,
>> true,
>>> +
>> INV_MPU6050_BIT_PWR_ACCL_STBY);
>>> +				if (result)
>>> +					goto error_read_raw;
>>> +			}
>>> +			ret = inv_mpu6050_sensor_show(st,
>> st->reg->raw_accl,
>>> +						chan->channel2, val);
>>> +			if (!st->chip_config.accl_fifo_enable ||
>>> +					!st->chip_config.enable) {
>>> +				result = inv_mpu6050_switch_engine(st,
>> false,
>>> +
>> INV_MPU6050_BIT_PWR_ACCL_STBY);
>>> +				if (result)
>>> +					goto error_read_raw;
>>> +			}
>>> +			break;
>>> +		case IIO_TEMP:
>>> +			/* wait for stablization */
>>> +			msleep(INV_MPU6050_SENSOR_UP_TIME);
>>> +			inv_mpu6050_sensor_show(st, st->reg->temperature,
>>> +							IIO_MOD_X, val);
>>> +			break;
>>> +		default:
>>> +			ret = -EINVAL;
>>> +			break;
>>> +		}
>>> +error_read_raw:
>>> +		if (!st->chip_config.enable)
>>> +			result |= inv_mpu6050_set_power_itg(st, false);
>>> +		mutex_unlock(&indio_dev->mlock);
>>> +		if (result)
>>> +			return result;
>>> +
>>> +		return ret;
>>> +	}
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			*val  = 0;
>>> +			*val2 = gyro_scale_6050[st->chip_config.fsr];
>>> +
>>> +			return IIO_VAL_INT_PLUS_NANO;
>>> +		case IIO_ACCEL:
>>> +			*val = 0;
>>> +			*val2 = accel_scale[st->chip_config.accl_fs];
>>> +
>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>> +		case IIO_TEMP:
>>> +			*val = 0;
>>> +			*val2 = INV_MPU6050_TEMP_SCALE;
>>> +
>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	case IIO_CHAN_INFO_OFFSET:
>>> +		switch (chan->type) {
>>> +		case IIO_TEMP:
>>> +			*val = INV_MPU6050_TEMP_OFFSET;
>>> +
>>> +			return IIO_VAL_INT;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +static int inv_mpu6050_write_fsr(struct inv_mpu6050_state *st, int
>> fsr)
>>> +{
>>> +	int result;
>>> +	u8 d;
>>> +
>>> +	if (fsr < 0 || fsr > INV_MPU6050_MAX_GYRO_FS_PARAM)
>>> +		return -EINVAL;
>>> +	if (fsr == st->chip_config.fsr)
>>> +		return 0;
>>> +
>>> +	d = (fsr << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>>> +	result = inv_mpu6050_write_reg(st, st->reg->gyro_config, d);
>>> +	if (result)
>>> +		return result;
>>> +	st->chip_config.fsr = fsr;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int inv_mpu6050_write_accel_fs(struct inv_mpu6050_state *st,
>> int
>> fs)
>>> +{
>>> +	int result;
>>> +	u8 d;
>>> +
>>> +	if (fs < 0 || fs > INV_MPU6050_MAX_ACCL_FS_PARAM)
>>> +		return -EINVAL;
>>> +	if (fs == st->chip_config.accl_fs)
>>> +		return 0;
>>> +
>>> +	d = (fs << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
>>> +	result = inv_mpu6050_write_reg(st, st->reg->accl_config, d);
>>> +	if (result)
>>> +		return result;
>>> +	st->chip_config.accl_fs = fs;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>>> +			       struct iio_chan_spec const *chan,
>>> +			       int val,
>>> +			       int val2,
>>> +			       long mask) {
>>> +	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>>> +	int result;
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	/* we should only update scale when the chip is disabled, i.e.,
>>> +		not running */
>>> +	if (st->chip_config.enable) {
>>> +		result = -EBUSY;
>>> +		goto error_write_raw;
>>> +	}
>>> +	result = inv_mpu6050_set_power_itg(st, true);
>>> +	if (result)
>>> +		goto error_write_raw;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			result = inv_mpu6050_write_fsr(st, val);
>>> +			break;
>>> +		case IIO_ACCEL:
>>> +			result = inv_mpu6050_write_accel_fs(st, val);
>>> +			break;
>>> +		default:
>>> +			result = -EINVAL;
>>> +			break;
>>> +		}
>>> +		break;
>>> +	default:
>>> +		result = -EINVAL;
>>> +		break;
>>> +	}
>>> +
>>> +error_write_raw:
>>> +	result |= inv_mpu6050_set_power_itg(st, false);
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +
>>> +	return result;
>>> +}
>>> +
>> Wrong multiline syntax
>>> + /*  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
>>> + *                  Based on the Nyquist principle, the sampling
>> rate
>> must
>>> + *                  exceed twice of the bandwidth of the signal, or
>> there
>>> + *                  would be alising. This function basically search
>> for the
>>> + *                  correct low pass parameters based on the fifo
>> rate,
>> e.g,
>>> + *                  sampling frequency.
>>> + */
>>> +static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int
>> rate)
>>> +{
>>> +	const int hz[] = {188, 98, 42, 20, 10, 5};
>>> +	const int d[] = {INV_MPU6050_FILTER_188HZ,
>> INV_MPU6050_FILTER_98HZ,
>>> +			INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
>>> +			INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ};
>>> +	int i, h, result;
>>> +	u8 data;
>>> +
>>> +	h = (rate >> 1);
>>> +	i = 0;
>>> +	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
>>> +		i++;
>>> +	data = d[i];
>>> +	result = inv_mpu6050_write_reg(st, st->reg->lpf, data);
>>> +	if (result)
>>> +		return result;
>>> +	st->chip_config.lpf = data;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + *  inv_mpu6050_fifo_rate_store() - Set fifo rate.
>>> + */
>>> +static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
>>> +	struct device_attribute *attr, const char *buf, size_t count) {
>>> +	s32 fifo_rate;
>>> +	u8 d;
>>> +	int result;
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>> +
>>> +	if (kstrtoint(buf, 10, &fifo_rate))
>>> +		return -EINVAL;
>>> +	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
>>> +				fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
>>> +		return -EINVAL;
>>> +	if (fifo_rate == st->chip_config.fifo_rate)
>>> +		return count;
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	if (st->chip_config.enable) {
>>> +		result = -EBUSY;
>>> +		goto fifo_rate_fail;
>>> +	}
>>> +	result = inv_mpu6050_set_power_itg(st, true);
>>> +	if (result)
>>> +		goto fifo_rate_fail;
>>> +
>>> +	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
>>> +	result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
>>> +	if (result)
>>> +		goto fifo_rate_fail;
>>> +	st->chip_config.fifo_rate = fifo_rate;
>>> +
>>> +	result = inv_mpu6050_set_lpf(st, fifo_rate);
>>> +	if (result)
>>> +		goto fifo_rate_fail;
>>> +
>>> +fifo_rate_fail:
>>> +	result |= inv_mpu6050_set_power_itg(st, false);
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	return count;
>>> +}
>>> +
>>> +/*
>>> + *  inv_fifo_rate_show() - Get the current sampling rate.
>>> + */
>>> +static ssize_t inv_fifo_rate_show(struct device *dev,
>>> +	struct device_attribute *attr, char *buf) {
>>> +	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
>>> +
>>> +	return sprintf(buf, "%d\n", st->chip_config.fifo_rate); }
>>> +
>>> +/*
>>> + * inv_attr_show() -  calling this function will show current
>>> + *                     parameters.
>>> + */
>>> +static ssize_t inv_attr_show(struct device *dev,
>>> +	struct device_attribute *attr, char *buf) {
>>> +	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
>>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>> +	s8 *m;
>>> +
>>> +	switch (this_attr->address) {
>>> +	/* In MPU6050, the two matrix are the same because gyro and accel
>>> +	   are integrated in one chip */
>>> +	case ATTR_GYRO_MATRIX:
>>> +	case ATTR_ACCL_MATRIX:
>>> +		m = st->plat_data.orientation;
>>> +
>>> +		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d,
>> %d\n",
>>> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7],
>> m[8]);
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * inv_mpu6050_validate_trigger() - validate_trigger callback for
>> invensense
>>> + *                                  MPU6050 device.
>>> + * @indio_dev: The IIO device
>>> + * @trig: The new trigger
>>> + *
>>> + * Returns: 0 if the 'trig' matches the trigger registered by the
>> MPU6050
>>> + * device, -EINVAL otherwise.
>>> + */
>>> +static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
>>> +					struct iio_trigger *trig)
>>> +{
>>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>> +
>>> +	if (st->trig != trig)
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#define INV_MPU6050_CHAN(_type, _channel2, _index)
>> \
>>> +	{                                                             \
>>> +		.type = _type,                                        \
>>> +		.modified = 1,                                        \
>>> +		.channel2 = _channel2,                                \
>>> +		.info_mask =  IIO_CHAN_INFO_SCALE_SHARED_BIT          \
>>> +				| IIO_CHAN_INFO_RAW_SEPARATE_BIT,     \
>>> +		.scan_index = _index,                                 \
>>> +		.scan_type = {                                        \
>>> +				.sign = 's',                          \
>>> +				.realbits = 16,                       \
>>> +				.storagebits = 16,                    \
>>> +				.shift = 0 ,                          \
>>> +				.endianness = IIO_BE,                 \
>>> +			     },                                       \
>>> +	}
>>> +
>>> +static const struct iio_chan_spec inv_mpu_channels[] = {
>>> +	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
>>> +	/* Note that temperature should only be via polled reading only,
>>> +	   not the final scan elements output. */
>>> +	{
>>> +		.type = IIO_TEMP,
>>> +		.info_mask =  IIO_CHAN_INFO_RAW_SEPARATE_BIT
>>> +				| IIO_CHAN_INFO_OFFSET_SEPARATE_BIT
>>> +				| IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>>> +		.scan_index = -1,
>>> +	},
>>> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X,
>> INV_MPU6050_SCAN_GYRO_X),
>>> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y,
>> INV_MPU6050_SCAN_GYRO_Y),
>>> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z,
>> INV_MPU6050_SCAN_GYRO_Z),
>>> +
>>> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
>>> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
>>> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
>>> +};
>>> +
>>> +/*constant IIO attribute */
>>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
>>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
>>> +	inv_mpu6050_fifo_rate_store);
>>> +static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
>>> +	ATTR_GYRO_MATRIX);
>>> +static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show,
>> NULL,
>>> +	ATTR_ACCL_MATRIX);
>>> +
>>> +static struct attribute *inv_attributes[] = {
>>> +	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,
>>> +	&iio_dev_attr_in_accel_matrix.dev_attr.attr,
>>> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +static const struct attribute_group inv_attribute_group = {
>>> +	.attrs = inv_attributes
>>> +};
>>> +
>>> +static const struct iio_info mpu_info = {
>>> +	.driver_module = THIS_MODULE,
>>> +	.read_raw = &inv_mpu6050_read_raw,
>>> +	.write_raw = &inv_mpu6050_write_raw,
>>> +	.attrs = &inv_attribute_group,
>>> +	.validate_trigger = inv_mpu6050_validate_trigger, };
>>> +
>>> +/*
>>> + *  inv_check_and_setup_chip() - check and setup chip.
>>> + */
>>> +static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>>> +		const struct i2c_device_id *id)
>>> +{
>>> +	int result;
>>> +
>>> +	st->chip_type = INV_MPU6050;
>>> +	st->hw  = &hw_info[st->chip_type];
>>> +	st->reg = hw_info[st->chip_type].reg;
>> Given st->hw is available everywhere st->reg is needed it would
>> perhaps be sensible to drop reg from struct inv_mpu6050_state.
>>
>>> +
>>> +	/* reset to make sure previous state are not there */
>>> +	result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>>> +					INV_MPU6050_BIT_H_RESET);
>>> +	if (result)
>>> +		return result;
>>> +	msleep(INV_MPU6050_POWER_UP_TIME);
>>> +	/* toggle power state. After reset, the sleep bit could be on
>>> +		or off depending on the OTP settings. Toggling power would
>>> +		make it in a definite state as well as making the hardware
>>> +		state align with the software state */
>>> +	result = inv_mpu6050_set_power_itg(st, false);
>>> +	if (result)
>>> +		return result;
>>> +	result = inv_mpu6050_set_power_itg(st, true);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	result = inv_mpu6050_switch_engine(st, false,
>>> +					INV_MPU6050_BIT_PWR_ACCL_STBY);
>>> +	if (result)
>>> +		return result;
>>> +	result = inv_mpu6050_switch_engine(st, false,
>>> +					INV_MPU6050_BIT_PWR_GYRO_STBY);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + *  inv_mpu_probe() - probe function.
>>> + *  @client:          i2c client.
>>> + *  @id:              i2c device id.
>>> + *
>>> + *  Returns 0 on success, a negative error code otherwise.
>>> + */
>>> +static int inv_mpu_probe(struct i2c_client *client,
>>> +	const struct i2c_device_id *id)
>>> +{
>>> +	struct inv_mpu6050_state *st;
>>> +	struct iio_dev *indio_dev;
>>> +	int result;
>>> +
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +					I2C_FUNC_SMBUS_READ_I2C_BLOCK |
>>> +					I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
>>> +		result = -ENOSYS;
>>> +		goto out_no_free;
>>> +	}
>>> +	indio_dev = iio_device_alloc(sizeof(*st));
>>> +	if (indio_dev == NULL) {
>>> +		result =  -ENOMEM;
>>> +		goto out_no_free;
>>> +	}
>>> +	st = iio_priv(indio_dev);
>>> +	st->client = client;
>>> +	st->plat_data = *(struct inv_mpu6050_platform_data
>>> +				*)dev_get_platdata(&client->dev);
>>> +	/* power is turned on inside check chip type*/
>>> +	result = inv_check_and_setup_chip(st, id);
>>> +	if (result)
>>> +		goto out_free;
>>> +
>>> +	result = inv_mpu6050_init_config(indio_dev);
>>> +	if (result) {
>>> +		dev_err(&client->dev,
>>> +			"Could not initialize device.\n");
>>> +		goto out_free;
>>> +	}
>>> +
>>> +	i2c_set_clientdata(client, indio_dev);
>>> +	indio_dev->dev.parent = &client->dev;
>>> +	indio_dev->name = id->name;
>>> +	indio_dev->channels = inv_mpu_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
>>> +
>>> +	indio_dev->info = &mpu_info;
>>> +	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
>>> +
>>> +	result = iio_triggered_buffer_setup(indio_dev,
>>> +					    inv_mpu6050_irq_handler,
>>> +					    inv_mpu6050_read_fifo,
>>> +					    NULL);
>>> +	if (result) {
>>> +		dev_err(&st->client->dev, "configure buffer fail %d\n",
>>> +				result);
>>> +		goto out_free;
>>> +	}
>>> +	result = inv_mpu6050_probe_trigger(indio_dev);
>>> +	if (result) {
>>> +		dev_err(&st->client->dev, "trigger probe fail %d\n",
>> result);
>>> +		goto out_unreg_ring;
>>> +	}
>>> +
>>> +	INIT_KFIFO(st->timestamps);
>>> +	spin_lock_init(&st->time_stamp_lock);
>>> +	result = iio_device_register(indio_dev);
>>> +	if (result) {
>>> +		dev_err(&st->client->dev, "IIO register fail %d\n",
>> result);
>>> +		goto out_remove_trigger;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +out_remove_trigger:
>>> +	inv_mpu6050_remove_trigger(st);
>>> +out_unreg_ring:
>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>> +out_free:
>>> +	iio_device_free(indio_dev);
>>> +out_no_free:
>>> +
>>> +	return result;
>>> +}
>>> +
>>> +static int inv_mpu_remove(struct i2c_client *client) {
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +	inv_mpu6050_remove_trigger(st);
>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>> +	iio_device_free(indio_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +#ifdef CONFIG_PM_SLEEP
>>> +
>>> +static int inv_mpu_resume(struct device *dev) {
>>> +	return inv_mpu6050_set_power_itg(
>>> +		iio_priv(i2c_get_clientdata(to_i2c_client(dev))), true); }
>>> +
>>> +static int inv_mpu_suspend(struct device *dev) {
>>> +	return inv_mpu6050_set_power_itg(
>>> +		iio_priv(i2c_get_clientdata(to_i2c_client(dev))), false); }
>>> +static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend,
>> inv_mpu_resume);
>>> +
>>> +#define INV_MPU6050_PMOPS (&inv_mpu_pmops) #else #define
>>> +INV_MPU6050_PMOPS NULL #endif /* CONFIG_PM_SLEEP */
>>> +
>> Multiline comment should be
>>
>> /*
>> * text
>> * more text4
>> */
>>> +/* device id table is used to identify what device can be
>>> + * supported by this driver
>>> + */
>>> +static const struct i2c_device_id inv_mpu_id[] = {
>>> +	{"mpu6050", INV_MPU6050},
>>> +	{}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
>>> +
>>> +static struct i2c_driver inv_mpu_driver = {
>>> +	.probe		=	inv_mpu_probe,
>>> +	.remove		=	inv_mpu_remove,
>>> +	.id_table	=	inv_mpu_id,
>>> +	.driver = {
>>> +		.owner	=	THIS_MODULE,
>>> +		.name	=	"inv-mpu6050",
>>> +		.pm     =       INV_MPU6050_PMOPS,
>>> +	},
>>> +};
>>> +
>>> +module_i2c_driver(inv_mpu_driver);
>>> +
>>> +MODULE_AUTHOR("Invensense Corporation");
>>> +MODULE_DESCRIPTION("Invensense device MPU6050 driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> new file mode 100644
>>> index 0000000..34cd054
>>> --- /dev/null
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -0,0 +1,247 @@
>>> +/*
>>> +* Copyright (C) 2012 Invensense, Inc.
>>> +*
>>> +* This software is licensed under the terms of the GNU General
>> Public
>>> +* License version 2, as published by the Free Software Foundation,
>> and
>>> +* may be copied, distributed, and modified under those terms.
>>> +*
>>> +* This program is distributed in the hope that it will be useful,
>>> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +* GNU General Public License for more details.
>>> +*/
>>> +#include <linux/i2c.h>
>>> +#include <linux/kfifo.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/iio/kfifo_buf.h>
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/iio/triggered_buffer.h> #include
>>> +<linux/iio/trigger_consumer.h> #include
>>> +<linux/platform_data/invensense_mpu6050.h>
>>> +
>>> +/**
>>> + *  struct inv_mpu6050_reg_map - Notable registers.
>>> + *  @sample_rate_div:	Divider applied to gyro output rate.
>>> + *  @lpf:		Configures internal low pass filter.
>>> + *  @user_ctrl:		Enables/resets the FIFO.
>>> + *  @fifo_en:		Determines which data will appear in FIFO.
>>> + *  @gyro_config:	gyro config register.
>>> + *  @accl_config:	accel config register
>>> + *  @fifo_count_h:	Upper byte of FIFO count.
>>> + *  @fifo_r_w:		FIFO register.
>>> + *  @raw_gyro:		Address of first gyro register.
>>> + *  @raw_accl:		Address of first accel register.
>>> + *  @temperature:	temperature register
>>> + *  @int_enable:	Interrupt enable register.
>>> + *  @pwr_mgmt_1:	Controls chip's power state and clock source.
>>> + *  @pwr_mgmt_2:	Controls power state of individual sensors.
>>> + */
>>> +struct inv_mpu6050_reg_map {
>>> +	u8 sample_rate_div;
>>> +	u8 lpf;
>>> +	u8 user_ctrl;
>>> +	u8 fifo_en;
>>> +	u8 gyro_config;
>>> +	u8 accl_config;
>>> +	u8 fifo_count_h;
>>> +	u8 fifo_r_w;
>>> +	u8 raw_gyro;
>>> +	u8 raw_accl;
>>> +	u8 temperature;
>>> +	u8 int_enable;
>>> +	u8 pwr_mgmt_1;
>>> +	u8 pwr_mgmt_2;
>>> +};
>>> +
>>> +/*device enum */
>>> +enum inv_devices {
>>> +	INV_MPU6050,
>>> +	INV_NUM_PARTS
>>> +};
>>> +
>>> +/**
>>> + *  struct inv_mpu6050_chip_config - Cached chip configuration data.
>>> + *  @fsr:		Full scale range.
>>> + *  @lpf:		Digital low pass filter f
>
