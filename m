Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <Invensense MPU6050 driver> <1342565703-10984-1-git-send-email-ggao@invensense.com>
 <500C6B30.9080306@kernel.org>
In-Reply-To: <500C6B30.9080306@kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Jul 2012 14:15:34 -0700
Message-ID: <fca1489b796a3cddaa7ebae67301338d@mail.gmail.com>
Subject: RE: [PATCH] Invensense MPU6050 device driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan,
	Thanks for the valuable comments. I will fix them.

Best Regards,

Ge GAO



-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]
Sent: Sunday, July 22, 2012 2:06 PM
To: Ge GAO
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Invensense MPU6050 device driver

On 07/17/2012 11:55 PM, Ge GAO wrote:
> From: Ge Gao <ggao@invensense.com>
I'm guessing that this was meant to also go to the list
(given previous versions have) so have cc'd linux-iio.
>
>                  --Invensense MPU6050 basic support.
>                  --Kfifo poll function fix from Jonanthan.
Fine, but just state a dependence on that patch, don't pull it directly
into yours
please.

>                  --iio_store_to_kfifo bug fix. check available space
>                    before write to Kfifo. Or Kfifo could partially
>                    fill data which cause data mis-alignment.
Please pull these out as separate patches. I've ignored them completely
here.
>                  --iio_read_first_n_kfifo bug fix. Check kfifo length
>                    before reading. Or divide by zero error could happen
>                  --industrial-buffer.c bug fix. Check stufftoread first
>                    before wait for pollq.
>
When sending new versions of patches, to make it easy for
people to keep track, please give the title
[PATCH V3] Invense MPU6050 device driver

Otherwise we end up with really confused reviewers from time to time.

A much improved submission.  It was short and clear enough that I actually
(I think) managed to grasp what was going on.

A few minor change requests inline.
Please have a look at the generic demux code.  When we merge the multiple
buffers patches, everything will route past the demux anyway (as different
client buffers will want different subsets of data) hence it will be cost
less and I think you are replicating some of it's functionality here.

Either have a look at the multiple buffer patches (on the iio mailing
list)
or in the mysterious wip branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

specifically I think...
http://git.kernel.org/?p=linux/kernel/git/jic23/iio.git;a=commit;h=19c197d
a766884a0f29c99052af3d54b62c3fbfb

Anyhow looking good.  Might be a little while before I have a chance
to review the next version but you are close enough to start adding
additional patches for the functionality I asked you to rip out of
this initial submission!  Just keep them short and sweet and
do one element at a time.

Thanks,

Jonathan
> Change-Id: I9ac2a1ce079580111938237c9a2b8779c7174b9e
> Signed-off-by: Ge Gao <ggao@invensense.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   13 +
>  drivers/iio/Kconfig                     |    1 +
>  drivers/iio/Makefile                    |    1 +
>  drivers/iio/imu/Kconfig                 |    4 +
>  drivers/iio/imu/Makefile                |    5 +
>  drivers/iio/imu/mpu6050/Kconfig         |   13 +
>  drivers/iio/imu/mpu6050/Makefile        |   10 +
>  drivers/iio/imu/mpu6050/inv_mpu_core.c  |  783
+++++++++++++++++++++++++++++++
>  drivers/iio/imu/mpu6050/inv_mpu_iio.h   |  413 ++++++++++++++++
>  drivers/iio/imu/mpu6050/inv_mpu_misc.c  |  251 ++++++++++
>  drivers/iio/imu/mpu6050/inv_mpu_ring.c  |  458 ++++++++++++++++++
>  drivers/iio/imu/mpu6050/mpu.h           |   89 ++++
>  drivers/iio/industrialio-buffer.c       |    2 +
>  drivers/iio/kfifo_buf.c                 |   23 +-
>  14 files changed, 2062 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iio/imu/Kconfig
>  create mode 100644 drivers/iio/imu/Makefile
>  create mode 100644 drivers/iio/imu/mpu6050/Kconfig
>  create mode 100644 drivers/iio/imu/mpu6050/Makefile
>  create mode 100644 drivers/iio/imu/mpu6050/inv_mpu_core.c
>  create mode 100644 drivers/iio/imu/mpu6050/inv_mpu_iio.h
>  create mode 100644 drivers/iio/imu/mpu6050/inv_mpu_misc.c
>  create mode 100644 drivers/iio/imu/mpu6050/inv_mpu_ring.c
>  create mode 100644 drivers/iio/imu/mpu6050/mpu.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
b/Documentation/ABI/testing/sysfs-bus-iio
> index 2f06d40..c974774 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -768,3 +768,16 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This attribute is used to read the amount of quadrature
error
>  		present in the device at a given time.
> +
> +What:           /sys/bus/iio/devices/iio:deviceX/gyro_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/accel_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/magn_matrix
> +KernelVersion:  2.6.39
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +                This is mounting matrix for motion sensors. Mounting
matrix
> +                is a 3x3 unitary matrix. A typical mounting matrix
would look like
> +                [1, 0, 0, 0, -1, 0, 0, 0, 1]. Using this information,
it would be
> +                easy to tell the relative positions among sensors as
well as their
> +                positions relative to the board that holds these
sensors.

So the board orientation is considered the 'reference'?  If so state that
and
perhaps explicitly state that it is [1 0 0; 0 1 0; 0 0 1] (note the semi
colons
might make it slightly easier to read?

I'd like to get a few other opinions on this particular element before we
merge it.

> +
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d4984c8..ed4c057 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -59,5 +59,6 @@ source "drivers/iio/amplifiers/Kconfig"
>  source "drivers/iio/light/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/dac/Kconfig"
> +source "drivers/iio/imu/Kconfig"
>
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 34309ab..b41610a 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -15,3 +15,4 @@ obj-y += amplifiers/
>  obj-y += light/
>  obj-y += frequency/
>  obj-y += dac/
> +obj-y += imu/
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> new file mode 100644
> index 0000000..0c0692c
> --- /dev/null
> +++ b/drivers/iio/imu/Kconfig
> @@ -0,0 +1,4 @@
> +#
> +# IMU devices
> +#
> +source "drivers/iio/imu/mpu6050/Kconfig"
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> new file mode 100644
> index 0000000..c4e4ffe
> --- /dev/null
> +++ b/drivers/iio/imu/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for IMU device.
> +#
> +
> +obj-y += mpu6050/
> diff --git a/drivers/iio/imu/mpu6050/Kconfig
b/drivers/iio/imu/mpu6050/Kconfig
> new file mode 100644
> index 0000000..4f6d730
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/Kconfig
> @@ -0,0 +1,13 @@
> +#
> +# inv-mpu6050 drivers for Invensense MPU devices and combos
> +#
> +
> +config INV_MPU6050_IIO
> +	tristate "Invensense MPU6050 devices"
> +	depends on I2C && SYSFS && IIO && IIO_KFIFO_BUF
> +	default n
> +	help
> +	  This driver supports the Invensense MPU6050 devices.
> +	  It is a gyroscope/accelerometer combo device.
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050.
> diff --git a/drivers/iio/imu/mpu6050/Makefile
b/drivers/iio/imu/mpu6050/Makefile
> new file mode 100644
> index 0000000..0173e50
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/Makefile
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for Invensense MPU6050 device.
> +#
> +
> +obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
> +
> +inv-mpu6050-objs := inv_mpu_core.o
> +inv-mpu6050-objs += inv_mpu_ring.o
> +inv-mpu6050-objs += inv_mpu_misc.o
> +
> diff --git a/drivers/iio/imu/mpu6050/inv_mpu_core.c
b/drivers/iio/imu/mpu6050/inv_mpu_core.c
> new file mode 100644
> index 0000000..fffde78
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/inv_mpu_core.c
> @@ -0,0 +1,783 @@
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
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
> +#include <linux/spinlock.h>
> +#include "inv_mpu_iio.h"
> +
> +static const struct inv_hw_s hw_info[INV_NUM_PARTS] = {
> +	{117, "MPU6050"},
> +};
> +
> +static const struct inv_reg_map_s reg_set_6050 = {
> +	.sample_rate_div	= REG_SAMPLE_RATE_DIV,
> +	.lpf                    = REG_CONFIG,
> +	.bank_sel               = REG_BANK_SEL,
> +	.user_ctrl              = REG_USER_CTRL,
> +	.fifo_en                = REG_FIFO_EN,
> +	.gyro_config            = REG_GYRO_CONFIG,
> +	.accl_config            = REG_ACCEL_CONFIG,
> +	.fifo_count_h           = REG_FIFO_COUNT_H,
> +	.fifo_r_w               = REG_FIFO_R_W,
> +	.raw_gyro               = REG_RAW_GYRO,
> +	.raw_accl               = REG_RAW_ACCEL,
> +	.temperature            = REG_TEMPERATURE,
> +	.int_enable             = REG_INT_ENABLE,
> +	.int_status             = REG_INT_STATUS,
> +	.pwr_mgmt_1             = REG_PWR_MGMT_1,
> +	.pwr_mgmt_2             = REG_PWR_MGMT_2,
> +	.mem_start_addr         = REG_MEM_START_ADDR,
> +	.mem_r_w                = REG_MEM_RW,
> +	.prgm_strt_addrh        = REG_PRGM_STRT_ADDRH,
> +};
> +
> +static inline int check_enable(struct inv_mpu_iio_s  *st)
> +{
> +	return st->chip_config.is_asleep | st->chip_config.enable;
> +}
> +
> +static int set_power_itg(struct inv_mpu_iio_s *st, bool power_on)
> +{
> +	struct inv_reg_map_s *reg;
> +	u8 data;
> +	int result;
> +
> +	reg = st->reg;
> +	if (power_on)
> +		data = 0;
> +	else
> +		data = BIT_SLEEP;
> +	if (st->chip_config.gyro_enable)
> +		data |= INV_CLK_PLL;
> +	else
> +		data |= INV_CLK_INTERNAL;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->pwr_mgmt_1,
> +						1, &data);
> +	if (result)
> +		return result;
Good explanation, but I'd start with a capital C.
> +	/* clock source should use one of gyro's axis whenever possible.
> +	 * If no gyro is enabled, the clock source has to switch to
internal
> +	 * clock. This might be done automatically for MPU6500.
> +	 */
> +	if (st->chip_config.gyro_enable)
> +		st->chip_config.clk_src = INV_CLK_PLL;
> +	else
> +		st->chip_config.clk_src = INV_CLK_INTERNAL;
> +
1 blank line is almost always enough so lose one here (nitpick of the day
;)
> +
> +	if (power_on) {
> +		msleep(POWER_UP_TIME);
> +		data = 0;
> +		if (!st->chip_config.accl_enable)
> +			data |= BIT_PWR_ACCL_STBY;
> +		if (!st->chip_config.gyro_enable)
> +			data |= BIT_PWR_GYRO_STBY;
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +							reg->pwr_mgmt_2,
> +							1, &data);
> +		if (result)
> +			return result;
> +		msleep(SENSOR_UP_TIME);
> +	}
> +	st->chip_config.is_asleep = !power_on;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_init_config() - Initialize hardware, disable FIFO.
> + *  @indio_dev:	Device driver instance.
> + *  Initial configuration:
> + *  FSR: +/- 2000DPS
> + *  DLPF: 42Hz
> + *  FIFO rate: 50Hz
> + *  Clock source: Gyro PLL
> + */
> +static int inv_init_config(struct iio_dev *indio_dev)
> +{
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +
> +	if (st->chip_config.is_asleep)
> +		return -EPERM;
> +	reg = st->reg;
> +	result = set_inv_enable(indio_dev, false);
> +	if (result)
> +		return result;
> +
> +	d = (INV_FSR_2000DPS << GYRO_CONFIG_FSR_SHIFT);
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->gyro_config,
> +						1, &d);
> +	if (result)
> +		return result;
> +	st->chip_config.fsr = INV_FSR_2000DPS;
> +
> +	d = INV_FILTER_42HZ;
> +	result = i2c_smbus_write_i2c_block_data(st->client, reg->lpf, 1,
&d);
> +	if (result)
> +		return result;
> +	st->chip_config.lpf = INV_FILTER_42HZ;
> +
> +	d = ONE_K_HZ / INIT_FIFO_RATE - 1;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
> +						reg->sample_rate_div,
> +						1, &d);
> +	if (result)
> +		return result;
Just a thought, could this 'default config' be broken out to a
const static struct inv_chip_config_s and copied in here? Might be
easier to read and make it clearer what is going on here.
> +	st->chip_config.fifo_rate = INIT_FIFO_RATE;
> +	st->irq_dur_ns            = INIT_DUR_TIME;
> +	st->chip_config.gyro_enable = 1;
> +	st->chip_config.gyro_fifo_enable = 1;
> +
> +	st->chip_config.accl_enable = 1;
> +	st->chip_config.accl_fifo_enable = 1;
> +	st->chip_config.accl_fs = INV_FS_02G;
> +
> +	d = (INV_FS_02G << ACCL_CONFIG_FSR_SHIFT);
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->accl_config,
> +						1, &d);
> +	if (result)
> +		return result;
> +
> +	return 0;
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
> +	if (st->chip_config.is_asleep)
> +		return -EINVAL;
> +	switch (mask) {
> +	case 0:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val = st->raw_gyro[chan->channel2 - IIO_MOD_X];
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			*val = st->raw_accel[chan->channel2 - IIO_MOD_X];
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +		{
> +			const int gyro_scale_6050[] = {250, 500, 1000,
2000};
> +			*val = gyro_scale_6050[st->chip_config.fsr];
> +			return IIO_VAL_INT;
> +		}
> +		case IIO_ACCEL:
> +		{
> +			const int accel_scale[] = {2, 4, 8, 16};
> +			*val = accel_scale[st->chip_config.accl_fs];
> +			return IIO_VAL_INT;
> +		}
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
> +	struct inv_reg_map_s *reg;
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
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->gyro_config,
> +						1, &d);
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
> +	struct inv_reg_map_s *reg;
> +	u8 d;
> +
> +	if (fs < 0 || fs > MAX_ACCL_FS_PARAM)
> +		return -EINVAL;
> +	if (fs == st->chip_config.accl_fs)
> +		return 0;
> +
> +	reg = st->reg;
> +	d = (fs << ACCL_CONFIG_FSR_SHIFT);
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->accl_config,
> +						1, &d);
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
> +	if (check_enable(st))
> +		return -EPERM;
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
> +		return result;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + *  inv_set_lpf() - set low pass filer based on fifo rate.
Cool. Ideally explain the relationship here.
> + */
> +static int inv_set_lpf(struct inv_mpu_iio_s *st, int rate)
> +{
> +	const int hz[] = {188, 98, 42, 20, 10, 5};
> +	const int d[] = {INV_FILTER_188HZ, INV_FILTER_98HZ,
> +			INV_FILTER_42HZ, INV_FILTER_20HZ,
> +			INV_FILTER_10HZ, INV_FILTER_5HZ};
> +	int i, h, result;
> +	u8 data;
> +	struct inv_reg_map_s *reg;
> +
> +	reg = st->reg;
> +	h = (rate >> 1);
> +	i = 0;
> +	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> +		i++;
> +	data = d[i];
> +	result = i2c_smbus_write_i2c_block_data(st->client, reg->lpf, 1,
> +						&data);
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
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +	struct inv_reg_map_s *reg;
> +
> +	if (check_enable(st))
> +		return -EPERM;
> +	if (kstrtoint(buf, 10, &fifo_rate))
> +		return -EINVAL;
> +	if ((fifo_rate < MIN_FIFO_RATE) || (fifo_rate > MAX_FIFO_RATE))
> +		return -EINVAL;
> +	if (fifo_rate == st->chip_config.fifo_rate)
> +		return count;
> +
> +	reg = st->reg;
> +	data = ONE_K_HZ / fifo_rate - 1;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
> +						reg->sample_rate_div, 1,
> +						&data);
> +	if (result)
> +		return result;
> +	st->chip_config.fifo_rate = fifo_rate;
> +
> +	result = inv_set_lpf(st, fifo_rate);
> +	if (result)
> +		return result;
> +	st->irq_dur_ns = (data + 1) * NSEC_PER_MSEC;
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
> + *  inv_power_state_store() - Turn device on/off.
> + */
> +static ssize_t inv_power_state_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int result;
> +	int power_state;
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +
> +	if (kstrtoint(buf, 10, &power_state))
> +		return -EINVAL;
> +	if ((!power_state) == st->chip_config.is_asleep)
> +		return count;
> +	result = st->set_power_state(st, power_state);
> +
> +	return count;
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
> +	int result;
> +	s8 *m;
> +	u8 *key;
> +	int i;
> +
> +	switch (this_attr->address) {
> +	case ATTR_CLK_SRC:
> +		if (INV_CLK_INTERNAL == st->chip_config.clk_src)
> +			return sprintf(buf, "INTERNAL\n");
> +		else if (INV_CLK_PLL == st->chip_config.clk_src)
> +			return sprintf(buf, "Gyro PLL\n");
> +		else
> +			return -EPERM;
> +	case ATTR_KEY:
> +		key = st->plat_data.key;
> +		result = 0;
> +		for (i = 0; i < 16; i++)
> +			result += sprintf(buf + result, "%02x", key[i]);
> +		result += sprintf(buf + result, "\n");
> +
> +		return result;
> +	case ATTR_GYRO_MATRIX:
> +		m = st->plat_data.orientation;
> +
I'd prefer a format with explicity line breaks in the matrix. Perhaps semi
colons?
or commas for that and spaces between values?
> +		return sprintf(buf, "%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7],
m[8]);
> +	case ATTR_ACCL_MATRIX:
> +		m = st->plat_data.orientation;
> +
> +		return sprintf(buf, "%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7],
m[8]);
> +	case ATTR_POWER_STATE:
> +		return sprintf(buf, "%d\n", !st->chip_config.is_asleep);
> +	default:
> +		return -EPERM;
> +	}
> +}
> +
> +static int inv_q30_mult(int a, int b)
> +{
> +	long long temp;
> +	int result;
> +	temp = (long long)a * b;
> +	result = (int)(temp >> Q30_MULTI_SHIFT);
> +
> +	return result;
> +}

Definitely do this temperature through read_raw.  That way the abi
will be enforced as well. Should be
in_tempX_input probably...
> +
> +/**
> + *  inv_temperature_show() - Read temperature data directly from
registers.
> + */
> +static ssize_t inv_temperature_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	s16 temp;
> +	long scale_t;
> +	u8 data[2];
> +	reg = st->reg;
> +
> +	if (st->chip_config.is_asleep)
> +		return -EPERM;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->temperature, 2, data);
> +	if (result != 2) {
> +		pr_err("Could not read temperature register.\n");
> +		return result;
> +	}
> +	temp = (s16)(be16_to_cpup((s16 *)&data[0]));
> +
> +	scale_t = MPU6050_TEMP_OFFSET +
> +			inv_q30_mult((int)temp << MPU_TEMP_SHIFT,
> +				     MPU6050_TEMP_SCALE);
> +
> +	return sprintf(buf, "%ld\n", scale_t);
> +}
> +
> +#define INV_MPU_CHAN(_type, _channel2, _index)                        \
> +	{                                                             \
> +		.type = _type,                                        \
> +		.modified = 1,                                        \
> +		.channel2 = _channel2,                                \
> +		.info_mask =  IIO_CHAN_INFO_SCALE_SHARED_BIT,         \
> +		.scan_index = _index,                                 \
> +		.scan_type  = IIO_ST('s', 16, 16, 0)                  \
I think your data is big endian?  Hence you can't use this IIO_ST macro
(I've been meaning to kill it off as this sort of macro always bites
when it comes to maintenance - people warned me but I had to learn the
hard way).  Anyhow, set the endianness explicity.
> +	}
> +
> +static const struct iio_chan_spec inv_mpu_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU_SCAN_TIMESTAMP),
> +
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
> +static DEVICE_ATTR(temperature, S_IRUGO, inv_temperature_show, NULL);
> +/* clock source is the clock used to power the sensor. If gyro is
enabled,
> + * it is recommended to use gyro for maximum accuracy.
> + */
> +static IIO_DEVICE_ATTR(clock_source, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_CLK_SRC);
> +static IIO_DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_power_state_store, ATTR_POWER_STATE);
> +static IIO_DEVICE_ATTR(key, S_IRUGO, inv_attr_show, NULL, ATTR_KEY);
> +static IIO_DEVICE_ATTR(gyro_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_GYRO_MATRIX);
> +static IIO_DEVICE_ATTR(accel_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_ACCL_MATRIX);
> +
> +static const struct attribute *inv_gyro_attributes[] = {
> +	&dev_attr_temperature.attr,
temperature is fully supported by the abi, please do it that way.
It is straight forward to have non buffered channels registered
just the same as the others.
> +	&iio_dev_attr_clock_source.dev_attr.attr,
> +	&iio_dev_attr_power_state.dev_attr.attr,
> +	&iio_dev_attr_key.dev_attr.attr,
key needs documentation I think...
> +	&iio_dev_attr_gyro_matrix.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +};
> +
> +static const struct attribute *inv_mpu6050_attributes[] = {
> +	&iio_dev_attr_accel_matrix.dev_attr.attr,
> +};
> +
> +static struct attribute *inv_attributes[ARRAY_SIZE(inv_gyro_attributes)
+
> +				ARRAY_SIZE(inv_mpu6050_attributes) + 1];
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
Why is this broken out?  I guess it's because there are varients
to be added later with more part support?  If so I'd put it
inline for now and break the function out only when those others
come along.

> +static void inv_setup_func_ptr(struct inv_mpu_iio_s *st)
> +{
> +	st->set_power_state    = set_power_itg;
> +	st->init_config        = inv_init_config;
> +}
> +

I'd change the name to make the fact it is doing the setup
explicit.  Rather confused me when I saw the content!
> +/**
> + *  inv_check_chip_type() - check and setup chip type.
> + */
> +static int inv_check_chip_type(struct inv_mpu_iio_s *st,
> +		const struct i2c_device_id *id)
> +{
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	int t_ind;
> +	u8 d;
> +	if (!strcmp(id->name, "mpu6050"))
> +		st->chip_type = INV_MPU6050;
> +	else
> +		return -EPERM;
> +	inv_setup_func_ptr(st);
> +	st->hw  = &hw_info[st->chip_type];
> +	st->reg = (struct inv_reg_map_s *)&reg_set_6050;
> +	reg     = st->reg;
> +	st->chip_config.gyro_enable = 1;
> +	/* reset to make sure previous state are not there */
> +	d = BIT_H_RESET;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->pwr_mgmt_1,
> +						1, &d);
> +	if (result)
> +		return result;
> +	msleep(POWER_UP_TIME);
> +	/* turn off and turn on power to ensure gyro engine is on */
> +	result = st->set_power_state(st, false);
> +	if (result)
> +		return result;
> +	result = st->set_power_state(st, true);
> +	if (result)
> +		return result;
> +	st->num_channels = INV_CHANNEL_NUM_GYRO_ACCL;
> +
> +	result = inv_get_silicon_rev_mpu6050(st);
> +	if (result) {
> +		pr_err("read silicon rev error\n");
> +		st->set_power_state(st, false);
> +		return result;
> +	}
> +	t_ind = 0;
> +	memcpy(&inv_attributes[t_ind], inv_gyro_attributes,
> +		sizeof(inv_gyro_attributes));
> +	t_ind += ARRAY_SIZE(inv_gyro_attributes);
> +
> +	memcpy(&inv_attributes[t_ind], inv_mpu6050_attributes,
> +		       sizeof(inv_mpu6050_attributes));
> +	t_ind += ARRAY_SIZE(inv_mpu6050_attributes);
> +
> +	inv_attributes[t_ind] = NULL;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_mpu_probe() - probe function.
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
> +		pr_err("I2c function error\n");
> +		goto out_no_free;
> +	}
> +	indio_dev = iio_device_alloc(sizeof(*st));
> +	if (indio_dev == NULL) {
> +		pr_err("memory allocation failed\n");
> +		result =  -ENOMEM;
> +		goto out_no_free;
> +	}
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	st->plat_data =
> +		*(struct mpu_platform_data
*)dev_get_platdata(&client->dev);
> +	/* power is turned on inside check chip type*/
> +	result = inv_check_chip_type(st, id);
> +	if (result)
> +		goto out_free;
> +
> +	result = st->init_config(indio_dev);
> +	if (result) {
> +		dev_err(&client->adapter->dev,
> +			"Could not initialize device.\n");
> +		goto out_free;
> +	}
> +
> +	/* Make state variables available to all _show and _store
functions. */
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->channels = inv_mpu_channels;
> +	indio_dev->num_channels = st->num_channels;
> +
> +	indio_dev->info = &mpu_info;
> +	indio_dev->modes = INDIO_BUFFER_HARDWARE;
> +	indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
> +
> +	result = inv_mpu_configure_ring(indio_dev);
> +	if (result) {
> +		pr_err("configure ring buffer fail\n");
> +		goto out_free;
> +	}
> +	result = iio_buffer_register(indio_dev, indio_dev->channels,
> +					indio_dev->num_channels);
> +	if (result) {
> +		pr_err("ring buffer register fail\n");
> +		goto out_unreg_ring;
> +	}
> +	st->irq = client->irq;
> +	result = iio_device_register(indio_dev);
> +	if (result) {
> +		pr_err("IIO device register fail\n");
> +		goto out_remove_ring;
> +	}
> +
Mainly because I'd expect device registration to always be last, I'd
move these before it.  In theory there is a race here otherwise though
it would be impressive it anyone got the buffer running before these
last two lines ran.
> +	INIT_KFIFO(st->timestamps);
> +	spin_lock_init(&st->time_stamp_lock);
> +	dev_info(&client->adapter->dev, "%s is ready to go!\n",
st->hw->name);
> +
> +	return 0;
blank line here would make it slightly easier to read...
> +out_remove_ring:
> +	iio_buffer_unregister(indio_dev);
> +out_unreg_ring:
> +	inv_mpu_unconfigure_ring(indio_dev);
> +out_free:
> +	iio_device_free(indio_dev);
> +out_no_free:
> +	dev_err(&client->adapter->dev, "%s failed %d\n", __func__,
result);
> +
> +	return -EIO;
> +}
> +
> +/**
> + *  inv_mpu_remove() - remove function.
> + */
> +static int inv_mpu_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	kfifo_free(&st->timestamps);
> +	iio_device_unregister(indio_dev);
> +	iio_buffer_unregister(indio_dev);
> +	inv_mpu_unconfigure_ring(indio_dev);
> +	iio_device_free(indio_dev);
> +
I wouldn't bother with this message.  Useful in debugging but little use
on a production system.
> +	dev_info(&client->adapter->dev, "inv-mpu-iio module removed.\n");
> +
> +	return 0;
> +}
> +#ifdef CONFIG_PM
> +
> +static int inv_mpu_resume(struct device *dev)
> +{
> +	struct inv_mpu_iio_s *st =
> +			iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +
> +	return st->set_power_state(st, true);
> +}
> +
> +static int inv_mpu_suspend(struct device *dev)
> +{
> +	struct inv_mpu_iio_s *st =
> +			iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +
> +	return st->set_power_state(st, false);
> +}
> +static const struct dev_pm_ops inv_mpu_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)
> +};
> +#define INV_MPU_PMOPS (&inv_mpu_pmops)
> +#else
> +#define INV_MPU_PMOPS NULL
> +#endif /* CONFIG_PM */
> +
> +static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
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
> +	.address_list = normal_i2c,
> +};
> +
> +static int __init inv_mpu_init(void)
> +{
> +	int result = i2c_add_driver(&inv_mpu_driver);
> +	if (result)
> +		return result;
> +
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
module_i2c_driver in i2c.h will get rid of this boiler plate
for you.
> +
> +MODULE_AUTHOR("Invensense Corporation");
> +MODULE_DESCRIPTION("Invensense device driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("inv-mpu6050");
No blank lines at end of files.
> +
> diff --git a/drivers/iio/imu/mpu6050/inv_mpu_iio.h
b/drivers/iio/imu/mpu6050/inv_mpu_iio.h
> new file mode 100644
> index 0000000..6e033c1
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/inv_mpu_iio.h
> @@ -0,0 +1,413 @@
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
> +#include <linux/i2c.h>
> +#include <linux/kfifo.h>
> +#include <linux/miscdevice.h>
> +#include <linux/input.h>
> +#include <linux/spinlock.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +#include "mpu.h"
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
> + *  @enable:            master enable state.
> + *  @accl_fs:		accel full scale range.
> + *  @accl_enable:	enable accel functionality
> + *  @accl_fifo_enable:	enable accel data output
> + *  @gyro_enable:	enable gyro functionality
> + *  @gyro_fifo_enable:	enable gyro data output
> + *  @is_asleep:		1 if chip is powered down.
> + *  @fifo_rate:		FIFO update rate.
> + */
> +struct inv_chip_config_s {
> +	u32 fsr:2;
> +	u32 lpf:3;
> +	u32 clk_src:1;
> +	u32 enable:1;
> +	u32 accl_fs:2;
> +	u32 accl_enable:1;
> +	u32 accl_fifo_enable:1;
> +	u32 gyro_enable:1;
> +	u32 gyro_fifo_enable:1;
> +	u32 is_asleep:1;
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
> +enum inv_channel_num {
> +	INV_CHANNEL_NUM_GYRO_ACCL = 7,
> +};
> +
> +/**
> + *  struct inv_mpu_iio_s - Driver state variables.
> + *  @chip_config:	Cached attribute information.
> + *  @chip_info:		Chip information from read-only registers.
> + *  @trig;              iio trigger.
> + *  @reg:		Map of important registers.
> + *  @hw:		Other hardware-specific information.
> + *  @chip_type:		chip type.
> + *  @time_stamp_lock:	spin lock to time stamp.
> + *  @client:		i2c client handle.
> + *  @plat_data:		platform data.
> + *  int (*set_power_state)(struct inv_mpu_iio_s *, bool on): function
ptr
> + *  int (*switch_gyro_engine)(struct inv_mpu_iio_s *, bool on):
function ptr
> + *  int (*switch_accl_engine)(struct inv_mpu_iio_s *, bool on):
function ptr
> + *  int (*init_config)(struct iio_dev *indio_dev): function ptr
> + *  @timestamps:        kfifo queue to store time stamp.
> + *  @irq:               irq number store.
> + *  @raw_gyro:          raw gyro data.
> + *  @raw_accel:         raw accel data.
> + *  @num_channels:      number of channels for current chip.
> + *  @irq_dur_ns:        duration between each irq.
> + *  @last_isr_time:     last isr time.
> + */
> +struct inv_mpu_iio_s {
> +#define TIMESTAMP_FIFO_SIZE 16
> +	struct inv_chip_config_s chip_config;
> +	struct inv_chip_info_s chip_info;
> +	struct inv_reg_map_s *reg;
> +	const struct inv_hw_s *hw;
> +	enum   inv_devices chip_type;
> +	spinlock_t time_stamp_lock;
> +	struct i2c_client *client;
> +	struct mpu_platform_data plat_data;
> +	int (*set_power_state)(struct inv_mpu_iio_s *, bool on);
> +	int (*init_config)(struct iio_dev *indio_dev);
> +	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
> +	s16 irq;
> +	s16 raw_gyro[3];
> +	s16 raw_accel[3];
> +	enum inv_channel_num num_channels;
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
Good practice to add a prefix to this sort of define set.
That way if some generic header gains a define of the same
name all is fine.
Hence

MPU_REG_YGOFFS_TC would be safer.  Same is true of structures
defined here.

> +/*register and associated bit definition*/
> +#define REG_YGOFFS_TC           0x1
> +#define BIT_I2C_MST_VDDIO		0x80
> +
> +#define REG_XA_OFFS_L_TC        0x7
> +#define REG_PRODUCT_ID          0xC
> +#define REG_ST_GCT_X            0xD
> +#define REG_SAMPLE_RATE_DIV     0x19
> +#define REG_CONFIG              0x1A
> +
> +#define REG_GYRO_CONFIG         0x1B
> +#define BITS_SELF_TEST_EN		0xE0
> +
> +#define REG_ACCEL_CONFIG	0x1C
> +
> +#define REG_FIFO_EN             0x23
> +#define BIT_ACCEL_OUT			0x08
> +#define BITS_GYRO_OUT			0x70
> +
> +
> +#define REG_I2C_MST_CTRL        0x24
> +#define BIT_WAIT_FOR_ES			0x40
> +
> +#define REG_I2C_SLV0_ADDR       0x25
> +#define BIT_I2C_READ			0x80
> +
> +#define REG_I2C_SLV0_REG        0x26
> +
> +#define REG_I2C_SLV0_CTRL       0x27
> +#define BIT_SLV_EN			0x80
> +
> +#define REG_I2C_SLV1_ADDR       0x28
> +#define REG_I2C_SLV1_REG        0x29
> +#define REG_I2C_SLV1_CTRL       0x2A
> +#define REG_I2C_SLV4_CTRL       0x34
> +
> +#define REG_INT_PIN_CFG         0x37
> +#define BIT_BYPASS_EN                   0x2
> +
> +#define REG_INT_ENABLE          0x38
> +#define BIT_DATA_RDY_EN                 0x01
> +#define BIT_DMP_INT_EN                  0x02
> +
> +#define REG_DMP_INT_STATUS      0x39
> +#define REG_INT_STATUS          0x3A
> +#define REG_RAW_ACCEL           0x3B
> +#define REG_TEMPERATURE         0x41
> +#define REG_RAW_GYRO            0x43
> +#define REG_EXT_SENS_DATA_00    0x49
> +#define REG_I2C_SLV1_DO         0x64
> +
> +#define REG_I2C_MST_DELAY_CTRL  0x67
> +#define BIT_SLV0_DLY_EN                 0x01
> +#define BIT_SLV1_DLY_EN                 0x02
> +
> +#define REG_USER_CTRL           0x6A
> +#define BIT_FIFO_RST                    0x04
> +#define BIT_DMP_RST                     0x08
> +#define BIT_I2C_MST_EN                  0x20
> +#define BIT_FIFO_EN                     0x40
> +#define BIT_DMP_EN                      0x80
> +
> +#define REG_PWR_MGMT_1          0x6B
> +#define BIT_H_RESET                     0x80
> +#define BIT_SLEEP                       0x40
> +#define BIT_CYCLE                       0x20
> +
> +#define REG_PWR_MGMT_2          0x6C
> +#define BIT_PWR_ACCL_STBY               0x38
> +#define BIT_PWR_GYRO_STBY               0x07
> +#define BIT_LPA_FREQ                    0xC0
> +
> +#define REG_BANK_SEL            0x6D
> +#define REG_MEM_START_ADDR      0x6E
> +#define REG_MEM_RW              0x6F
> +#define REG_PRGM_STRT_ADDRH     0x70
> +#define REG_FIFO_COUNT_H        0x72
> +#define REG_FIFO_R_W            0x74
> +
> +/* data definitions */
> +#define Q30_MULTI_SHIFT          30
> +
> +#define BYTES_PER_SENSOR         6
I'd rename this BYTES_PER_3AXIS_SENSOR to make things a little clearer.
> +#define FIFO_COUNT_BYTE          2
> +#define FIFO_THRESHOLD           500
> +#define POWER_UP_TIME            100
> +#define SENSOR_UP_TIME           30
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
> +
> +/* init parameters */
> +#define INIT_FIFO_RATE           50
> +#define INIT_DUR_TIME           ((1000 / INIT_FIFO_RATE) *
NSEC_PER_MSEC)
> +#define MPL_PROD_KEY(ver, rev) (ver * 100 + rev)
> +#define NUM_OF_PROD_REVS (ARRAY_SIZE(prod_rev_map))
> +/*---- MPU6050 Silicon Revisions ----*/
> +#define MPU_SILICON_REV_A2                    1       /* MPU6050A2
Device */
> +#define MPU_SILICON_REV_B1                    2       /* MPU6050B1
Device */
> +
> +#define BIT_PRFTCH_EN                         0x40
> +#define BIT_CFG_USER_BANK                     0x20
> +#define BITS_MEM_SEL                          0x1f
> +
> +#define TIME_STAMP_TOR                        5
> +#define MAX_CATCH_UP                          5
> +#define DEFAULT_ACCL_TRIM                     16384
> +#define MAX_FIFO_RATE                         1000
> +#define MIN_FIFO_RATE                         4
> +#define ONE_K_HZ                              1000
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
> +	ATTR_CLK_SRC,
> +	ATTR_KEY,
> +	ATTR_GYRO_MATRIX,
> +	ATTR_ACCL_MATRIX,
> +	ATTR_POWER_STATE,
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
> +void inv_mpu_unconfigure_ring(struct iio_dev *indio_dev);
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st);
> +int set_inv_enable(struct iio_dev *indio_dev, bool enable);
> +
> diff --git a/drivers/iio/imu/mpu6050/inv_mpu_misc.c
b/drivers/iio/imu/mpu6050/inv_mpu_misc.c
> new file mode 100644
> index 0000000..9e53e55
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/inv_mpu_misc.c
> @@ -0,0 +1,251 @@
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
> +*/
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
> +	{MPL_PROD_KEY(0,   6), MPU_SILICON_REV_A2, 131, 16384},	/*
(A2/C2-1) */
> +	/* prod_ver = 1, forced to 0 for MPU6050 A2 */
> +	{MPL_PROD_KEY(0,   7), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   8), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   9), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  10), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  11), MPU_SILICON_REV_A2, 131, 16384},	/*
(A2/D2-1) */
> +	{MPL_PROD_KEY(0,  12), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  13), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  14), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  15), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  27), MPU_SILICON_REV_A2, 131, 16384},	/* (A2/D4)
*/
> +	/* prod_ver = 1 */
> +	{MPL_PROD_KEY(1,  16), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/D2-1) */
> +	{MPL_PROD_KEY(1,  17), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/D2-2) */
> +	{MPL_PROD_KEY(1,  18), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/D2-3) */
> +	{MPL_PROD_KEY(1,  19), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/D2-4) */
> +	{MPL_PROD_KEY(1,  20), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/D2-5) */
> +	{MPL_PROD_KEY(1,  28), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D4)
*/
> +	{MPL_PROD_KEY(1,   1), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/E1-1) */
> +	{MPL_PROD_KEY(1,   2), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/E1-2) */
> +	{MPL_PROD_KEY(1,   3), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/E1-3) */
> +	{MPL_PROD_KEY(1,   4), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/E1-4) */
> +	{MPL_PROD_KEY(1,   5), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/E1-5) */
> +	{MPL_PROD_KEY(1,   6), MPU_SILICON_REV_B1, 131, 16384},	/*
(B1/E1-6) */
> +	/* prod_ver = 2 */
> +	{MPL_PROD_KEY(2,   7), MPU_SILICON_REV_B1, 131, 16384},	/*
(B2/E1-1) */
> +	{MPL_PROD_KEY(2,   8), MPU_SILICON_REV_B1, 131, 16384},	/*
(B2/E1-2) */
> +	{MPL_PROD_KEY(2,   9), MPU_SILICON_REV_B1, 131, 16384},	/*
(B2/E1-3) */
> +	{MPL_PROD_KEY(2,  10), MPU_SILICON_REV_B1, 131, 16384},	/*
(B2/E1-4) */
> +	{MPL_PROD_KEY(2,  11), MPU_SILICON_REV_B1, 131, 16384},	/*
(B2/E1-5) */
> +	{MPL_PROD_KEY(2,  12), MPU_SILICON_REV_B1, 131, 16384},	/*
(B2/E1-6) */
> +	{MPL_PROD_KEY(2,  29), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/D4)
*/
> +	/* prod_ver = 3 */
> +	{MPL_PROD_KEY(3,  30), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E2)
*/
> +	/* prod_ver = 4 */
> +	{MPL_PROD_KEY(4,  31), MPU_SILICON_REV_B1, 131,  8192},	/* (B2/F1)
*/
> +	{MPL_PROD_KEY(4,   1), MPU_SILICON_REV_B1, 131,  8192},	/* (B3/F1)
*/
> +	{MPL_PROD_KEY(4,   3), MPU_SILICON_REV_B1, 131,  8192},	/* (B4/F1)
*/
> +	/* prod_ver = 5 */
> +	{MPL_PROD_KEY(5,   3), MPU_SILICON_REV_B1, 131, 16384},	/* (B4/F1)
*/
> +	/* prod_ver = 6 */
> +	{MPL_PROD_KEY(6,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)
*/
> +	/* prod_ver = 7 */
> +	{MPL_PROD_KEY(7,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)
*/
> +	/* prod_ver = 8 */
> +	{MPL_PROD_KEY(8,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)
*/
> +	/* prod_ver = 9 */
> +	{MPL_PROD_KEY(9,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)
*/
> +	/* prod_ver = 10 */
> +	{MPL_PROD_KEY(10, 19), MPU_SILICON_REV_B1, 131, 16384}	/* (B5/E2)
*/
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
> +	u8 bank[2];
fill these here as well for bonus points ;)
u8 bank[2] = { REG_BANK_SEL, mem_addr >> 8 }
> +	u8 addr[2];
> +	u8 buf = REG_MEM_RW;
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
> +	bank[0] = REG_BANK_SEL;
> +	bank[1] = mem_addr >> 8;
> +
> +	addr[0] = REG_MEM_START_ADDR;
> +	addr[1] = mem_addr & 0xFF;
> +
> +	res = i2c_transfer(st->client->adapter, msgs, 4);
> +	if (res != 4) {
> +		if (res >= 0)
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
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	struct inv_reg_map_s *reg;
> +	u8 prod_ver = 0x00, prod_rev = 0x00;
> +	struct prod_rev_map_t *p_rev;
> +	u8 d;
> +	u8 bank = (BIT_PRFTCH_EN | BIT_CFG_USER_BANK |
MPU_MEM_OTP_BANK_0);
> +	u16 mem_addr = ((bank << 8) | MEM_ADDR_PROD_REV);
> +	u16 key;
> +	u8 regs[SOFT_PROD_VER_BYTES];
> +	u16 sw_rev;
> +	s16 index;
> +	struct inv_chip_info_s *chip_info = &st->chip_info;
> +
> +	reg = st->reg;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       REG_PRODUCT_ID,
> +					       1, &prod_ver);
> +	if (result != 1)
> +		return result;
> +	prod_ver &= 0xf;
> +	/*memory read need more time after power up */
> +	msleep(POWER_UP_TIME);
> +	result = mpu_memory_read(st, mem_addr, 1, &prod_rev);
> +	if (result)
> +		return result;
> +	prod_rev >>= 2;
> +	/* clean the prefetch and cfg user bank bits */
> +	d = 0;
> +	result = i2c_smbus_write_i2c_block_data(st->client, reg->bank_sel,
> +						1, &d);
> +	if (result)
> +		return result;
> +	/* get the software-product version, read from XA_OFFS_L */
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +						REG_XA_OFFS_L_TC,
> +						SOFT_PROD_VER_BYTES,
regs);
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
> +	chip_info->product_revision = prod_rev;
> +	chip_info->silicon_revision = p_rev->silicon_rev;
> +	chip_info->software_revision = sw_rev;
> +	chip_info->gyro_sens_trim = p_rev->gyro_trim;
> +	chip_info->accl_sens_trim = p_rev->accel_trim;
> +	if (chip_info->accl_sens_trim == 0)
> +		chip_info->accl_sens_trim = DEFAULT_ACCL_TRIM;
> +	chip_info->multi = DEFAULT_ACCL_TRIM / chip_info->accl_sens_trim;
> +	if (chip_info->multi != 1)
> +		pr_info("multi is %d\n", chip_info->multi);
> +
> +	return 0;
> +}
> +
> +
> diff --git a/drivers/iio/imu/mpu6050/inv_mpu_ring.c
b/drivers/iio/imu/mpu6050/inv_mpu_ring.c
> new file mode 100644
> index 0000000..6fe16a1
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/inv_mpu_ring.c
> @@ -0,0 +1,458 @@
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
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
> +#include "inv_mpu_iio.h"
> +
> +/**
> + *  inv_switch_engine() - gyro and accel can be turned on/off according
> + *                        to requirements to save power if not all are
needed.
> + */
> +static int inv_switch_engine(struct inv_mpu_iio_s *st, bool en, int
mask)
> +{
> +	struct inv_reg_map_s *reg;
> +	u8 data;
> +	int result;
> +
> +	reg = st->reg;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->pwr_mgmt_2, 1, &data);
> +	if (result != 1)
> +		return result;
> +	if (en)
> +		data &= (~mask);
> +	else
> +		data |= mask;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->pwr_mgmt_2,
> +						1, &data);
> +	if (result)
> +		return result;
> +	msleep(SENSOR_UP_TIME);
> +
> +	return 0;
> +}
> +
> +static void inv_scan_query(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +	struct iio_buffer *ring = indio_dev->buffer;
> +
> +	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_X) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Y) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Z))
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
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +
> +	reg = st->reg;
> +	inv_scan_query(indio_dev);
> +	d = 0;
> +	/* disable interrupt */
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->int_enable,
> +						1, &d);
> +	if (result) {
> +		pr_err("int_enable write failed\n");
> +		return result;
> +	}
> +	/* disable the sensor output to FIFO */
> +	result = i2c_smbus_write_i2c_block_data(st->client, reg->fifo_en,
> +						1, &d);
> +	if (result)
> +		goto reset_fifo_fail;
> +	/* disable fifo reading */
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->user_ctrl,
> +						1, &d);
> +	if (result)
> +		goto reset_fifo_fail;
> +
> +	/* reset FIFO*/
> +	d = BIT_FIFO_RST;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->user_ctrl,
> +						1, &d);
> +	if (result)
> +		goto reset_fifo_fail;
> +	st->last_isr_time = iio_get_time_ns();
> +	/* enable interrupt */
> +	if (st->chip_config.accl_fifo_enable ||
> +	    st->chip_config.gyro_fifo_enable) {
> +		d = BIT_DATA_RDY_EN;
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +							reg->int_enable,
> +							1, &d);
> +		if (result)
> +			return result;
> +	}
> +	/* enable FIFO reading and I2C master interface*/
> +	d = BIT_FIFO_EN;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->user_ctrl,
> +						1, &d);
> +	if (result)
> +		goto reset_fifo_fail;
> +	/* enable sensor output to FIFO */
> +	d = 0;
> +	if (st->chip_config.gyro_fifo_enable)
> +		d |= BITS_GYRO_OUT;
> +	if (st->chip_config.accl_fifo_enable)
> +		d |= BIT_ACCEL_OUT;
> +	result = i2c_smbus_write_i2c_block_data(st->client, reg->fifo_en,
> +						1, &d);
> +	if (result)
> +		goto reset_fifo_fail;
> +
> +	return 0;
blank line here please.
> +reset_fifo_fail:
> +	pr_err("reset fifo failed\n");
> +	d = BIT_DATA_RDY_EN;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->int_enable,
> +						1, &d);
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
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +
> +	if (st->chip_config.is_asleep)
> +		return -EINVAL;
> +	reg = st->reg;
> +	if (enable) {
> +		inv_scan_query(indio_dev);
> +		if (st->chip_config.gyro_fifo_enable) {
> +			result = inv_switch_engine(st, 1,
BIT_PWR_GYRO_STBY);
> +			if (result)
> +				return result;
> +			st->chip_config.gyro_enable = 1;
> +			st->chip_config.clk_src = INV_CLK_PLL;
> +		}
> +		if (st->chip_config.accl_fifo_enable) {
> +			result = inv_switch_engine(st, 1,
BIT_PWR_ACCL_STBY);
> +			if (result)
> +				return result;
> +			st->chip_config.accl_enable = 1;
> +		}
> +		result = inv_reset_fifo(indio_dev);
> +		if (result)
> +			return result;
> +	} else {
> +		d = 0;
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +							reg->fifo_en, 1,
&d);
> +		if (result)
> +			return result;
> +
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +							reg->int_enable,
> +							1, &d);
> +		if (result)
> +			return result;
> +
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +							reg->user_ctrl, 1,
&d);
> +		if (result)
> +			return result;
> +
> +		result = inv_switch_engine(st, 0, BIT_PWR_GYRO_STBY);
> +		if (result)
> +			return result;
> +		st->chip_config.clk_src = INV_CLK_INTERNAL;
> +		result = inv_switch_engine(st, 0, BIT_PWR_ACCL_STBY);
> +		if (result)
> +			return result;
> +		st->chip_config.gyro_enable = 0;
> +		st->chip_config.accl_enable = 0;
> +	}
> +	st->chip_config.enable = !!enable;
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
> +static irqreturn_t inv_irq_handler(int irq, void *dev_id)
> +{
> +	struct inv_mpu_iio_s *st;
> +	s64 timestamp;
> +	int catch_up;
> +	s64 time_since_last_irq;
> +
> +	st = (struct inv_mpu_iio_s *)dev_id;
> +	timestamp = iio_get_time_ns();
> +	time_since_last_irq = timestamp - st->last_isr_time;
> +	spin_lock(&st->time_stamp_lock);
> +	catch_up = 0;
This needs an explanation.  I think I understand what is happening,
but it's far from simple!
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

This next lot is very similar to what the demux unit used by for example
the max1363 driver does (they have restricted options as to what 'scan'
sets the hardware can capture - the demux stuff drops anything no one
wants).  I wonder if using that generic code might be simpler than
rerolling
it here?
> +static int put_scan_to_buf(struct iio_dev *indio_dev, u8 *d,
> +				s16 *s, int scan_index, int d_ind)
> +{
> +	struct iio_buffer *ring = indio_dev->buffer;
> +	int st;
> +	int i;
> +
> +	for (i = 0; i < 3; i++) {
> +		st = iio_scan_mask_query(indio_dev, ring, scan_index + i);
> +		if (st) {
> +			memcpy(&d[d_ind], &s[i], sizeof(s[i]));
> +			d_ind += sizeof(s[i]);
> +		}
> +	}
> +
> +	return d_ind;
> +}
> +
> +static int inv_report_gyro_accl(struct iio_dev *indio_dev, u8 *data,
s64 t)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	struct iio_buffer *ring = indio_dev->buffer;
> +	s16 g[THREE_AXIS], a[THREE_AXIS];
> +	int ind, d_ind;
> +	s64 buf[8];
> +	u8 *tmp;
> +	struct inv_chip_config_s *conf;
> +
> +	conf = &st->chip_config;
> +	ind = 0;
> +	if (conf->accl_fifo_enable) {
for loop perhaps?

You could be cynical like pretty much every other driver and take
the view, that if buffered capture is underway you don't provide
values via sysfs. It adds load in the fast path and clearly
shown here.  If you really want to do this, howabout caching
data[ind] directly and doing the other bits only if a sysfs read
occurs?
> +		a[0] = be16_to_cpup((__be16 *)(&data[ind]));
> +		a[1] = be16_to_cpup((__be16 *)(&data[ind + 2]));
> +		a[2] = be16_to_cpup((__be16 *)(&data[ind + 4]));
> +
> +		a[0] *= st->chip_info.multi;
> +		a[1] *= st->chip_info.multi;
> +		a[2] *= st->chip_info.multi;
> +		st->raw_accel[0] = a[0];
> +		st->raw_accel[1] = a[1];
> +		st->raw_accel[2] = a[2];
> +		ind += BYTES_PER_SENSOR;
> +	}
> +	if (conf->gyro_fifo_enable) {
> +		g[0] = be16_to_cpup((__be16 *)(&data[ind]));
> +		g[1] = be16_to_cpup((__be16 *)(&data[ind + 2]));
> +		g[2] = be16_to_cpup((__be16 *)(&data[ind + 4]));
> +
> +		st->raw_gyro[0] = g[0];
> +		st->raw_gyro[1] = g[1];
> +		st->raw_gyro[2] = g[2];
> +		ind += BYTES_PER_SENSOR;
> +	}
> +	tmp = (u8 *)buf;
> +	d_ind = 0;
> +	if (conf->gyro_fifo_enable)
> +		d_ind = put_scan_to_buf(indio_dev, tmp, g,
> +				INV_MPU_SCAN_GYRO_X, d_ind);
> +	if (conf->accl_fifo_enable)
> +		d_ind = put_scan_to_buf(indio_dev, tmp, a,
> +				INV_MPU_SCAN_ACCL_X, d_ind);
> +	if (ring->scan_timestamp)
> +		buf[(d_ind + 7) / 8] = t;
> +	ring->access->store_to(indio_dev->buffer, (u8 *)buf, t);
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_read_fifo() - Transfer data from FIFO to ring buffer.
Interesting. This is the first time I've understood that you are
piping the hardware buffer into a software one.  Note however
it's no longer a ring buffer so you'll want to update the comment!
> + */
> +static irqreturn_t inv_read_fifo(int irq, void *dev_id)
> +{
> +
> +	struct inv_mpu_iio_s *st = (struct inv_mpu_iio_s *)dev_id;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	size_t bytes_per_datum;
> +	int result;
> +	u8 data[BYTES_PER_SENSOR * 2];
> +	u16 fifo_count;
> +	u32 copied;
> +	s64 timestamp;
> +	struct inv_reg_map_s *reg;
> +	s64 buf[8];
> +	u8 *tmp;
> +
> +	reg = st->reg;
> +	if (!(st->chip_config.accl_fifo_enable |
> +		st->chip_config.gyro_fifo_enable))
> +		goto end_session;
> +	bytes_per_datum = (st->chip_config.accl_fifo_enable +
> +		st->chip_config.gyro_fifo_enable) * BYTES_PER_SENSOR;
> +	fifo_count = 0;
> +	if (bytes_per_datum != 0) {

Perhaps a brief comment on what is going on here?
> +		result = i2c_smbus_read_i2c_block_data(st->client,
> +						       reg->fifo_count_h,
> +						       FIFO_COUNT_BYTE,
data);
> +
> +		if (result != FIFO_COUNT_BYTE)
> +			goto end_session;
> +		fifo_count = be16_to_cpup((__be16 *)(&data[0]));
> +		if (fifo_count < bytes_per_datum)
> +			goto end_session;
> +		/* fifo count can't be odd number */
> +		if (fifo_count & 1)
> +			goto flush_fifo;
> +		if (fifo_count >  FIFO_THRESHOLD)
> +			goto flush_fifo;
> +		/* Timestamp mismatch. */
> +		if (kfifo_len(&st->timestamps) < fifo_count /
bytes_per_datum)
> +			goto flush_fifo;
> +		if (kfifo_len(&st->timestamps) >
> +			fifo_count / bytes_per_datum + TIME_STAMP_TOR)
> +				goto flush_fifo;
> +	} else {
So in this case you are just getting timestamps? Nice to be flexible,
but is this ever useful?  I think we usually just refuse to start the
buffer if there isn't a 'real' channel being captured.

> +		result = kfifo_to_user(&st->timestamps,
> +			&timestamp, sizeof(timestamp), &copied);
why kfifo_to_user?  Are we copying into userspace?
> +		if (result)
> +			goto flush_fifo;
> +	}
> +	tmp = (u8 *)buf;
Perhaps spliting this into a 'error' condition of bytes_per_datum == 0
and the while loop would be clearer?  I'm not that fussed either way.

> +	while ((bytes_per_datum != 0) && (fifo_count >= bytes_per_datum))
{
> +		result = i2c_smbus_read_i2c_block_data(st->client,
> +						       reg->fifo_r_w,
> +						       bytes_per_datum,
data);
> +		if (result != bytes_per_datum)
> +			goto flush_fifo;
> +
Time stamps are nice, but do you actually have a usecase that demands
them?
Just curious really rather than a criticism!
> +		result = kfifo_to_user(&st->timestamps,
> +			&timestamp, sizeof(timestamp), &copied);
> +		if (result)
> +			goto flush_fifo;
> +		inv_report_gyro_accl(indio_dev, data, timestamp);
> +		fifo_count -= bytes_per_datum;
> +	}
> +end_session:
> +	return IRQ_HANDLED;
I'd use a blank line here to aid readability.
> +flush_fifo:
> +	/* Flush HW and SW FIFOs. */
> +	inv_reset_fifo(indio_dev);
> +	inv_clear_kfifo(st);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void inv_mpu_unconfigure_ring(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	free_irq(st->client->irq, st);
> +	iio_kfifo_free(indio_dev->buffer);
> +};
> +
> +static int inv_postenable(struct iio_dev *indio_dev)
> +{
> +	return set_inv_enable(indio_dev, true);
> +}
> +
> +static int inv_predisable(struct iio_dev *indio_dev)
> +{
> +	return set_inv_enable(indio_dev, false);
> +}
> +
> +static const struct iio_buffer_setup_ops inv_mpu_ring_setup_ops = {
> +	.preenable = &iio_sw_buffer_preenable,
> +	.postenable = &inv_postenable,
> +	.predisable = &inv_predisable,
> +};
> +
> +int inv_mpu_configure_ring(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	struct iio_buffer *ring;
> +
> +	ring = iio_kfifo_allocate(indio_dev);
> +	if (!ring)
> +		return -ENOMEM;
> +	indio_dev->buffer = ring;
> +	/* setup ring buffer */
> +	ring->scan_timestamp = true;
> +	indio_dev->setup_ops = &inv_mpu_ring_setup_ops;
> +
> +	ret = request_threaded_irq(st->client->irq, inv_irq_handler,
> +			inv_read_fifo,
> +			IRQF_TRIGGER_RISING | IRQF_SHARED, "inv_irq", st);
> +	if (ret)
> +		goto error_iio_sw_rb_free;
> +
> +	return 0;
> +error_iio_sw_rb_free:
> +	iio_kfifo_free(indio_dev->buffer);
> +
> +	return ret;
> +}
> +
> diff --git a/drivers/iio/imu/mpu6050/mpu.h
b/drivers/iio/imu/mpu6050/mpu.h
> new file mode 100644
> index 0000000..26dcf9a
> --- /dev/null
> +++ b/drivers/iio/imu/mpu6050/mpu.h
> @@ -0,0 +1,89 @@
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
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
Guessing ioctl is left over from something?
> +#endif
> +
> +enum secondary_slave_type {
> +	SECONDARY_SLAVE_TYPE_NONE,
> +	SECONDARY_SLAVE_TYPE_ACCEL,
> +	SECONDARY_SLAVE_TYPE_COMPASS,
> +	SECONDARY_SLAVE_TYPE_PRESSURE,
> +
> +	SECONDARY_SLAVE_TYPE_TYPES
> +};
> +
I'd be tempted to only have supported devices in here.
Then we can add to this table as and when they are
supported? Cleaner and more obvious what is going on then.

Right now this is a fasinating insight into what you have
coming, but not actually useful (usual principal of only
add stuff when it is used.)
> +enum ext_slave_id {
> +	ID_INVALID = 0,
> +	GYRO_ID_MPU3050,
> +	GYRO_ID_MPU6050A2,
> +	GYRO_ID_MPU6050B1,
> +	GYRO_ID_MPU6050B1_NO_ACCEL,
> +	GYRO_ID_ITG3500,
> +
> +	ACCEL_ID_LIS331,
> +	ACCEL_ID_LSM303DLX,
> +	ACCEL_ID_LIS3DH,
> +	ACCEL_ID_KXSD9,
> +	ACCEL_ID_KXTF9,
> +	ACCEL_ID_BMA150,
> +	ACCEL_ID_BMA222,
> +	ACCEL_ID_BMA250,
> +	ACCEL_ID_ADXL34X,
> +	ACCEL_ID_MMA8450,
> +	ACCEL_ID_MMA845X,
> +	ACCEL_ID_MPU6050,
> +
> +	COMPASS_ID_AK8963,
> +	COMPASS_ID_AK8975,
> +	COMPASS_ID_AK8972,
> +	COMPASS_ID_AMI30X,
> +	COMPASS_ID_AMI306,
> +	COMPASS_ID_YAS529,
> +	COMPASS_ID_YAS530,
> +	COMPASS_ID_HMC5883,
> +	COMPASS_ID_LSM303DLH,
> +	COMPASS_ID_LSM303DLM,
> +	COMPASS_ID_MMC314X,
> +	COMPASS_ID_HSCDTD002B,
> +	COMPASS_ID_HSCDTD004A,
> +
> +	PRESSURE_ID_BMA085,
> +};
> +
> +/**
> + * struct mpu_platform_data - Platform data for the mpu driver
> + * @int_config:		Bits [7:3] of the int config register.
> + * @level_shifter:	0: VLogic, 1: VDD
> + * @orientation:	Orientation matrix of the gyroscope
> + * @sec_slave_type:     secondary slave device type, can be compass,
accel, etc
> + * @sec_slave_id:       id of the secondary slave device
> + * @secondary_i2c_address: secondary device's i2c address
> + * @secondary_orientation: secondary device's orientation matrix
> + * @key: key to identify the driver
This is non obvious, so perhaps we need some documentation of the format?
> + *
No blank commented line please.
> + */
> +struct mpu_platform_data {
> +	u8 int_config;
> +	u8 level_shifter;
> +	s8 orientation[9];
> +	enum secondary_slave_type sec_slave_type;
> +	enum ext_slave_id sec_slave_id;
> +	u16 secondary_i2c_addr;
> +	s8 secondary_orientation[9];
> +	u8 key[16];
> +};
> +

No blank lines at end of files please.  Note that git am moans about this,
wherease
checkpatch doesn't which is odd...  There are quite a few of these in
here, so please
get them all.
> diff --git a/drivers/iio/industrialio-buffer.c
b/drivers/iio/industrialio-buffer.c
> index 4add9bb..b2c1d41 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -56,6 +56,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> +	if (rb->stufftoread)
> +		return POLLIN | POLLRDNORM;
>
>  	poll_wait(filp, &rb->pollq, wait);
>  	if (rb->stufftoread)
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 6bf9d05..68cc5b7 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/workqueue.h>
>  #include <linux/kfifo.h>
> +#include <linux/sched.h>
>  #include <linux/mutex.h>
>  #include <linux/iio/kfifo_buf.h>
>
> @@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct iio_buffer
*r)
>  	kfifo_free(&buf->kf);
>  	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> +	r->stufftoread = false;
>  error_ret:
>  	return ret;
>  }
> @@ -94,9 +96,16 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>  {
>  	int ret;
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
> -	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
> -	if (ret != r->bytes_per_datum)
> -		return -EBUSY;
> +	if (kfifo_avail(&kf->kf) >= r->bytes_per_datum) {
> +		ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
> +		if (ret != r->bytes_per_datum)
> +			return -EBUSY;
> +	} else {
> +		return -ENOMEM;
> +	}
> +	r->stufftoread = true;
> +	wake_up_interruptible(&r->pollq);
> +
>  	return 0;
>  }
>
> @@ -106,12 +115,18 @@ static int iio_read_first_n_kfifo(struct
iio_buffer *r,
>  	int ret, copied;
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
>
> -	if (n < r->bytes_per_datum)
> +	if (n < r->bytes_per_datum || r->length == 0)
>  		return -EINVAL;
>
>  	n = rounddown(n, r->bytes_per_datum);
>  	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
>
> +	if (kfifo_is_empty(&kf->kf))
> +		r->stufftoread = false;
> +	/* verify it is still empty to avoid race */
> +	if (!kfifo_is_empty(&kf->kf))
> +		r->stufftoread = true;
> +
>  	return copied;
>  }
>
>
