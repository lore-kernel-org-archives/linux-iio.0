Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34304 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab2GNK02 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jul 2012 06:26:28 -0400
Message-ID: <5001494F.2020207@kernel.org>
Date: Sat, 14 Jul 2012 11:26:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Invensense MPU6050/9150/6500 driver submission(resubmitted)
References: <11465aef98dbd52476a33c69e1cfb5ef@mail.gmail.com> <5001343D.5080302@kernel.org>
In-Reply-To: <5001343D.5080302@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/14/2012 09:56 AM, Jonathan Cameron wrote:

Sorry, accidentally stripped off your description in the repost
as plain text.
Invensense MPU6050/MPU9150/MPU6500 device

             --secondary i2c bus for AKM8975/AKM8972/AKM8963
             --Kfifo poll function fix from Jonanthan.
             --Kfifo write bug fix. Should check available space
               before write to Kfifo.
             --Kfifo bug fix. Should check Kfifo length before
               reading from Kfifo.

Change-Id: I216e928c10e93e88758039fa733f74957ac33e3a
Signed-off-by: Ge Gao <ggao@invensense.com>

I'd be tempted to break this up more.  For example, perhaps
have an initial patch without the complex self test and add
that afterwards?

This is improving fast. Note where we want to end up is that
the secondary i2c bus is a fully fledged i2c bus with device
registered just as they are for any other i2c bus. They can
then have any additional callbacks necessary to get them
configured for your mpu to talk to them.  However they should
basically stand alone if there isn't an mpu present as well.

I know this is a bit fiddly, but it'll mean you effectively
get a lot of driver support for very little additional code.

This patch is still too big to review in a reasonable session
so please do look at ways to split it up futher.  I'm afraid
I didn't maintain focus for the last bits, so will have to
take a look closly at them in the next version.

Jonathan
---
 drivers/staging/iio/imu/Kconfig                |    1 +
 drivers/staging/iio/imu/Makefile               |    3 +
 drivers/staging/iio/imu/mpu6050/Kconfig        |   13 +
 drivers/staging/iio/imu/mpu6050/Makefile       |   10 +
 drivers/staging/iio/imu/mpu6050/inv_mpu_core.c | 1375
++++++++++++++++++++++++
 drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h  |  514 +++++++++
 drivers/staging/iio/imu/mpu6050/inv_mpu_misc.c |  771 +++++++++++++
 drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c |  452 ++++++++
 drivers/staging/iio/imu/mpu6050/mpu.h          |   89 ++
 9 files changed, 3228 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/imu/mpu6050/Kconfig
 create mode 100644 drivers/staging/iio/imu/mpu6050/Makefile
 create mode 100644 drivers/staging/iio/imu/mpu6050/inv_mpu_core.c
 create mode 100644 drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h
 create mode 100644 drivers/staging/iio/imu/mpu6050/inv_mpu_misc.c
 create mode 100644 drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c
 create mode 100644 drivers/staging/iio/imu/mpu6050/mpu.h

...

> +config INV_MPU6050_IIO
> +	tristate "Invensense MPU6050/MPU9150/MPU6500 devices"
> +	depends on I2C && SYSFS && IIO && IIO_KFIFO_BUF && !INV_MPU &&
> !INV_MPU_IIO
As I said before, for the submission don't put in dependencies not
in the mainline kernel.  Sorry but inserting these needs to be kept
in your local trees.
> +	default n
> +	help
> +	  This driver supports the Invensense MPU6050/MPU9150/MPU6500 devices.
> +	  It also supports AKM8975/AKM8963/AKM8972 in the secondary bus.
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050.
...
> diff --git a/drivers/staging/iio/imu/mpu6050/inv_mpu_core.c
> b/drivers/staging/iio/imu/mpu6050/inv_mpu_core.c

...
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

You need to start basing on the current staging/staging-next
branch. This header has long since moved.

> +#include "../../sysfs.h"
> +
> +static const short AKM8975_ST_Lower[3] = {-100, -100, -1000};
> +static const short AKM8975_ST_Upper[3] = {100, 100, -300};
> +
> +static const short AKM8972_ST_Lower[3] = {-50, -50, -500};
> +static const short AKM8972_ST_Upper[3] = {50, 50, -100};
> +
> +static const short AKM8963_ST_Lower[3] = {-200, -200, -3200};
> +static const short AKM8963_ST_Upper[3] = {200, 200, -800};
> +

I'd have been tempted to do this submission as one part first
then additional patches to add the others.  Still they don't
add that much so probably fine...

> +static const struct inv_hw_s hw_info[INV_NUM_PARTS] = {
> +	{117, "MPU6050"},
> +	{118, "MPU9150"},
> +	{119, "MPU6500"},
> +};
> +

I'd get this into constant data and then just copy it.

static const struct inv_reg_map_s reg = {
       .sample_rate_div = ...
etc
};

If you want a function pointer because more complex (e.g.
non constant) versions of this will exist later then
have a trivial wrapper that deploys memcpy.  If they
are always constant replace the function pointer with
a pointer to a const reg structure.

> +static void inv_setup_reg(struct inv_reg_map_s *reg)
> +{
> +	reg->sample_rate_div	= REG_SAMPLE_RATE_DIV;
> +	reg->lpf		= REG_CONFIG;
...
> +};
> +
> +static inline int check_enable(struct inv_mpu_iio_s  *st)
> +{
> +	return st->chip_config.is_asleep | st->chip_config.enable;
> +}
> +

lose this trivial wrapper. It just obscures what is going on for those
reading the code.

> +inline int inv_i2c_read(struct inv_mpu_iio_s *st, int reg, int len,
> char *data)
> +{
> +	int ret;
> +	ret = i2c_smbus_read_i2c_block_data(st->client, reg, len, data);
> +	if (ret == len)
> +		return 0;
> +	else
> +		return -EIO;
> +}
> +
> +inline int inv_i2c_write(struct inv_mpu_iio_s *st, int reg, int data)
> +{
> +	unsigned char d;
> +	d = data;
> +
> +	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d);
> +}
> +

Again, these wrappers don't add anything other than confusion to the
reviewer. Just call the smbus function directly in place.
(this is one of my pet hates ;)

> +inline int inv_secondary_read(struct inv_mpu_iio_s *st, int reg,
> +			      int len, char *data)
> +{
> +	int ret;
> +	ret = i2c_smbus_read_i2c_block_data(&st->secondary_client, reg,
> +					    len, data);
> +	if (ret == len)
> +		return 0;
> +	else
> +		return -EIO;
> +}
> +
> +inline int inv_secondary_write(struct inv_mpu_iio_s *st, int reg, int data)
> +{
> +	unsigned char d;
> +	d = data;
> +
> +	return i2c_smbus_write_i2c_block_data(&st->secondary_client, reg,
> +					      1, &d);
> +}
> +
> +static int set_power_itg(struct inv_mpu_iio_s *st, bool power_on)
> +{
> +	struct inv_reg_map_s *reg;
> +	unsigned char data;
> +	int result;
> +
> +	reg = &st->reg;
> +	if (power_on)
> +		data = 0;
> +	else
> +		data = BIT_SLEEP;
> +	if (st->chip_config.lpa_mode)
> +		data |= BIT_CYCLE;
This could do with a comment. No immediately obvious that
changing the clock pll source is related to gyro being enabled!
> +	if (st->chip_config.gyro_enable) {
> +		result = inv_i2c_write(st,
> +			reg->pwr_mgmt_1, data | INV_CLK_PLL);
> +		if (result)
> +			return result;
> +		st->chip_config.clk_src = INV_CLK_PLL;
> +	} else {
> +		result = inv_i2c_write(st,
> +			reg->pwr_mgmt_1, data | INV_CLK_INTERNAL);
> +		if (result)
> +			return result;
> +		st->chip_config.clk_src = INV_CLK_INTERNAL;
> +	}
> +
> +	if (power_on) {
> +		msleep(POWER_UP_TIME);
> +		data = 0;
> +		if (!st->chip_config.accl_enable)
> +			data |= BIT_PWR_ACCL_STBY;
> +		if (!st->chip_config.gyro_enable)
> +			data |= BIT_PWR_GYRO_STBY;
> +		if (INV_MPU6500 != st->chip_type)
> +			data |= (st->chip_config.lpa_freq << LPA_FREQ_SHIFT);
> +
> +		result = inv_i2c_write(st, reg->pwr_mgmt_2, data);
> +		if (result) {
This needs an explanation. If the i2c write has failed, likelihood is
comms are
dead, so under what circumstances does this make sense?
> +			inv_i2c_write(st, reg->pwr_mgmt_1, BIT_SLEEP);
> +			return result;
> +		}
> +		msleep(SENSOR_UP_TIME);
> +	}
> +	st->chip_config.is_asleep = !power_on;
> +
> +	return 0;
> +}
> +
...
> +/**
> + *  inv_compass_scale_show() - show compass scale.
> + */
> +static int inv_compass_scale_show(struct inv_mpu_iio_s *st, int *scale)
> +{
switch (st->plat_data.sec_slave_id) {
case COMPASS_ID_AK8975:
...

Are these scales applied by the mpu or are they from the underlying
chip?  If underlying chip I'd suggest these should be callbacks
into that driver... (thus avoiding you having to keep extending this
function). New 'sub' devices would ideally need minimal changes
to this core driver.  Ideally nothing at all would be in here...

> +	if (COMPASS_ID_AK8975 == st->plat_data.sec_slave_id)
> +		*scale = DATA_AKM8975_SCALE;
> +	else if (COMPASS_ID_AK8972 == st->plat_data.sec_slave_id)
> +		*scale = DATA_AKM8972_SCALE;
> +	else if (COMPASS_ID_AK8963 == st->plat_data.sec_slave_id)
...
> +/**
> + *  mpu_read_raw() - read raw method.
> + */
> +static int mpu_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val,
> +			      int *val2,
> +			      long mask) {
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +	int result;
> +	if (st->chip_config.is_asleep)
> +		return -EINVAL;
> +	switch (mask) {
> +	case 0:
switch (chan->type) please. It's easier for the eye to follow!
> +		if (chan->type == IIO_ANGL_VEL) {
> +			*val = st->raw_gyro[chan->channel2 - IIO_MOD_X];
> +			return IIO_VAL_INT;
> +		}
> +		if (chan->type == IIO_ACCEL) {
> +			*val = st->raw_accel[chan->channel2 - IIO_MOD_X];
> +			return IIO_VAL_INT;
> +		}
> +		if (chan->type == IIO_MAGN) {
> +			*val = st->raw_compass[chan->channel2 - IIO_MOD_X];
> +			return IIO_VAL_INT;
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SCALE:
switch here as well.

> +		if (chan->type == IIO_ANGL_VEL) {
> +			const short gyro_scale_6050[] = {250, 500, 1000, 2000};
I wouldn't bother making these 'short'. Just go with int and let the
compiler deal
with it...

> +			const short gyro_scale_6500[] = {250, 1000, 2000, 4000};
switch is probably easier to follow here as well.

> +			if (INV_MPU6500 == st->chip_type)
> +				*val = gyro_scale_6500[st->chip_config.fsr];
> +			else
> +				*val = gyro_scale_6050[st->chip_config.fsr];
> +			return IIO_VAL_INT;
> +		}
> +		if (chan->type == IIO_ACCEL) {
> +			const short accel_scale[] = {2, 4, 8, 16};
> +			*val = accel_scale[st->chip_config.accl_fs];
> +			return IIO_VAL_INT;
> +		}
> +		if (chan->type == IIO_MAGN)
> +			return inv_compass_scale_show(st, val);
> +		return -EINVAL;
...

> +/**
> + *  inv_write_compass_scale() - Configure the compass's scale range.
> + */
> +static int inv_write_compass_scale(struct inv_mpu_iio_s  *st, int data)
> +{
> +	char d, en;
> +	int result;
blank line here. (got to have a few nitpicks and the rest of this is so
nicely formatted ;)
> +	if (COMPASS_ID_AK8963 != st->plat_data.sec_slave_id)
> +		return 0;
> +	en = !!data;
> +	if (st->compass_scale == en)
> +		return 0;
> +	d = (DATA_AKM_MODE_SM | (st->compass_scale << AKM8963_SCALE_SHIFT));
> +	result = inv_i2c_write(st, REG_I2C_SLV1_DO, d);
> +	if (result)
> +		return result;
> +	st->compass_scale = en;
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
> +	if (check_enable(st))
> +		return -EPERM;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		result = -EINVAL;
switch (chan->type)...
> +		if (chan->type == IIO_ANGL_VEL)
> +			result = inv_write_fsr(st, val);
> +		if (chan->type == IIO_ACCEL)
> +			result = inv_write_accel_fs(st, val);
> +		if (chan->type == IIO_MAGN)
> +			result = inv_write_compass_scale(st, val);
> +		return result;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_set_lpf() - set low pass filer based on fifo rate.
> + */
> +static int inv_set_lpf(struct inv_mpu_iio_s *st, int rate)
> +{
> +	const short hz[] = {188, 98, 42, 20, 10, 5};
> +	const int   d[] = {INV_FILTER_188HZ, INV_FILTER_98HZ,
> +			INV_FILTER_42HZ, INV_FILTER_20HZ,
> +			INV_FILTER_10HZ, INV_FILTER_5HZ};
> +	int i, h, data, result;
> +	struct inv_reg_map_s *reg;
> +	reg = &st->reg;
> +	h = (rate >> 1);
> +	i = 0;
> +	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> +		i++;
> +	data = d[i];
> +	result = inv_i2c_write(st, reg->lpf, data);
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
> +	unsigned long fifo_rate;
> +	unsigned char data;
> +	int result;
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +	struct inv_reg_map_s *reg;
blank line here.
> +	reg = &st->reg;
...

> +/**
> + *  inv_reg_dump_show() - Register dump for testing.
Either put this into debugfs (with appropriate ifdefs
or drop it entirely before posting this driver again.
As you say, it's for testing. Hence should be gone
by time of submission...

> + */
> +static ssize_t inv_reg_dump_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int ii;
> +	char data;
> +	ssize_t bytes_printed = 0;
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +
> +	for (ii = 0; ii < st->hw->num_reg; ii++) {
> +		/* don't read fifo r/w register */
> +		if (ii == st->reg.fifo_r_w)
> +			data = 0;
> +		else
> +			inv_i2c_read(st, ii, 1, &data);
> +		bytes_printed += sprintf(buf + bytes_printed, "%#2x: %#2x\n",
> +					 ii, data);
> +	}
> +
> +	return bytes_printed;
> +}
> +

I thought we'd agreed on taking dmp out of this first patch?
Also this looks like the sort of function that is there for
debugging and hence shouldn't be here at all? It is definitely
reporting more than one 'value' and hence can't be one sysfs
attribute...
> +/**
> + * inv_attr_show() -  calling this function will show current
> + *                        dmp parameters.
> + */
> +static ssize_t inv_attr_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int result;
> +	signed char *m;
> +	unsigned char *key;
> +	int i;
> +
> +	switch (this_attr->address) {
> +	case ATTR_LPA_MODE:
> +		return sprintf(buf, "%d\n", st->chip_config.lpa_mode);
> +	case ATTR_LPA_FREQ:{
> +		const char *f[] = {"1.25", "5", "20", "40"};
> +		const char *f_6500[] = {"0.3125", "0.625", "1.25",
> +					       "2.5", "5", "10", "20", "40",
> +					       "80", "160", "320", "640"};
> +		if (INV_MPU6500 == st->chip_type)
> +			return sprintf(buf, "%s\n",
> +				       f_6500[st->chip_config.lpa_freq]);
> +		else
> +			return sprintf(buf, "%s\n",
> +				       f[st->chip_config.lpa_freq]);
> +	}
> +	case ATTR_CLK_SRC:
> +		if (INV_CLK_INTERNAL == st->chip_config.clk_src)
> +			return sprintf(buf, "INTERNAL\n");
> +		else if (INV_CLK_PLL == st->chip_config.clk_src)
> +			return sprintf(buf, "Gyro PLL\n");
> +		else
> +			return -EPERM;
> +	case ATTR_SELF_TEST:
> +		if (INV_MPU6500 == st->chip_type)
> +			result = inv_hw_self_test_6500(st);
> +		else
> +			result = inv_hw_self_test(st);
> +		return sprintf(buf, "%d\n", result);
> +	case ATTR_KEY:
> +		key = st->plat_data.key;
> +		result = 0;
> +		for (i = 0; i < 16; i++)
> +			result += sprintf(buf + result, "%02x", key[i]);
> +		result += sprintf(buf + result, "\n");
> +		return result;
> +
> +	case ATTR_GYRO_MATRIX:
> +		m = st->plat_data.orientation;
> +		return sprintf(buf, "%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> +	case ATTR_ACCL_MATRIX:
> +		if (st->plat_data.sec_slave_type == SECONDARY_SLAVE_TYPE_ACCEL)
> +			m = st->plat_data.secondary_orientation;
> +		else
> +			m = st->plat_data.orientation;
> +		return sprintf(buf, "%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> +	case ATTR_COMPASS_MATRIX:
> +		if (st->plat_data.sec_slave_type ==
> +				SECONDARY_SLAVE_TYPE_COMPASS)
> +			m = st->plat_data.secondary_orientation;
> +		else
> +			return -ENODEV;
> +		return sprintf(buf, "%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> +	case ATTR_GYRO_ENABLE:
> +		return sprintf(buf, "%d\n", st->chip_config.gyro_enable);
> +	case ATTR_ACCL_ENABLE:
> +		return sprintf(buf, "%d\n", st->chip_config.accl_enable);
> +	case ATTR_COMPASS_ENABLE:
> +		return sprintf(buf, "%d\n", st->chip_config.compass_enable);
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
> +
> +/**
> + *  inv_temperature_show() - Read temperature data directly from registers.
> + */
> +static ssize_t inv_temperature_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct inv_mpu_iio_s *st = iio_priv(dev_get_drvdata(dev));
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	short temp;
> +	long scale_t;
> +	unsigned char data[2];
> +	reg = &st->reg;
> +
> +	if (st->chip_config.is_asleep)
> +		return -EPERM;
> +	result = inv_i2c_read(st, reg->temperature, 2, data);
> +	if (result) {
> +		pr_err("Could not read temperature register.\n");
> +		return result;
> +	}
> +	temp = (signed short)(be16_to_cpup((short *)&data[0]));
> +
> +	scale_t = MPU6050_TEMP_OFFSET +
> +			inv_q30_mult((int)temp << MPU_TEMP_SHIFT,
> +				     MPU6050_TEMP_SCALE);
Don't tack a timestamp on this please.

> +	return sprintf(buf, "%ld %lld\n", scale_t, iio_get_time_ns());
> +}
> +

I'd be tempted to break the low power stuff out into a follow up
patch. It separates off fairly nicely and the shorter the
main patch the more chance of quick reviews!
> +/**
> + *  inv_lpa_mode() - store current low power mode settings
> + */
> +static int inv_lpa_mode(struct inv_mpu_iio_s *st, int lpa_mode)
> +{
> +	unsigned long result;
> +	unsigned char d;
> +	struct inv_reg_map_s *reg;
> +
> +	reg = &st->reg;
> +	result = inv_i2c_read(st, reg->pwr_mgmt_1, 1, &d);
> +	if (result)
> +		return result;
> +	d &= ~BIT_CYCLE;
> +	if (lpa_mode)
> +		d |= BIT_CYCLE;
> +	result = inv_i2c_write(st, reg->pwr_mgmt_1, d);
> +	if (result)
> +		return result;
> +	if (INV_MPU6500 == st->chip_type) {
> +		result = inv_i2c_write(st, REG_6500_ACCEL_CONFIG2,
> +					      BIT_ACCEL_FCHOCIE_B);
> +		if (result)
> +			return result;
> +	}
> +	st->chip_config.lpa_mode = !!lpa_mode;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_lpa_freq() - store current low power frequency setting.
> + */
> +static int inv_lpa_freq(struct inv_mpu_iio_s *st, int lpa_freq)
> +{
> +	unsigned long result;
> +	unsigned char d;
> +	struct inv_reg_map_s *reg;
> +
> +	if (INV_MPU6500 == st->chip_type) {
> +		if (lpa_freq > MAX_6500_LPA_FREQ_PARAM)
> +			return -EINVAL;
> +		result = inv_i2c_write(st, REG_6500_LP_ACCEL_ODR,
> +					      lpa_freq);
> +		if (result)
> +			return result;
> +	} else {
> +		if (lpa_freq > MAX_LPA_FREQ_PARAM)
> +			return -EINVAL;
> +		reg = &st->reg;
> +		result = inv_i2c_read(st, reg->pwr_mgmt_2, 1, &d);
> +		if (result)
> +			return result;
> +		d &= ~BIT_LPA_FREQ;
> +		d |= (unsigned char)(lpa_freq << LPA_FREQ_SHIFT);
> +		result = inv_i2c_write(st, reg->pwr_mgmt_2, d);
> +		if (result)
> +			return result;
> +	}
> +	st->chip_config.lpa_freq = lpa_freq;
> +
> +	return 0;
> +}
> +
What does this do?  Not immediately obvious from the name...

Also feels like iwth a bit of effort the next two could make use
of a shared utility function to cut down on code repition.

static int __inv_switch_x_engine(struct inv_mpu_iio_s *st, bool en, int
mask)
{
	struct inv_reg_map_s *reg;
	unsigned char data;
	int result;
	reg = &st->reg;
	result = inv_i2c_read(st, reg->pwr_mgmt_2, 1, &data);
	if (result)
		return result;
	if (en)
		data &= (~mask);
	else
		data |= mask;
	result = inv_i2c_write(st, reg->pwr_mgmt_2, data);
	if (result)
		return result;
	msleep(SENSOR_UP_TIME);
	return 0;
}
> +static int inv_switch_gyro_engine(struct inv_mpu_iio_s *st, bool en)
> +{
	__inv_switch_x_engine(st, en, BIT_PWR_GYRO_STBY);
> +}
> +
> +static int inv_switch_accl_engine(struct inv_mpu_iio_s *st, bool en)
> +{
> +	struct inv_reg_map_s *reg;
> +	unsigned char data;
> +	int result;
> +	reg = &st->reg;
> +	result = inv_i2c_read(st, reg->pwr_mgmt_2, 1, &data);
> +	if (result)
> +		return result;
> +	if (en)
> +		data &= (~BIT_PWR_ACCL_STBY);
> +	else
> +		data |= BIT_PWR_ACCL_STBY;
> +	result = inv_i2c_write(st, reg->pwr_mgmt_2, data);
> +	if (result)
> +		return result;
> +	msleep(SENSOR_UP_TIME);
> +
> +	return 0;
> +}
> +
...
> +/**
> + * inv_attr_store() -  calling this function will store current
> + *                        non-dmp parameter settings
> + */
> +static ssize_t inv_attr_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	struct iio_buffer *ring = indio_dev->buffer;
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int data;
> +	int result;
blank line.
> +	if (check_enable(st))
> +		return -EPERM;
> +	result = kstrtoint(buf, 10, &data);
> +	if (result)
> +		return -EINVAL;
> +
> +	switch (this_attr->address) {
> +	case ATTR_GYRO_ENABLE:
> +		result = inv_gyro_enable(st, ring, !!data);
> +		break;
> +	case ATTR_ACCL_ENABLE:
> +		result = inv_accl_enable(st, ring, !!data);
> +		break;
> +	case ATTR_COMPASS_ENABLE:
> +		result = inv_compass_enable(st, ring, !!data);
> +		break;
> +	case ATTR_LPA_FREQ:
> +		result = inv_lpa_freq(st, data);
> +		break;
> +	case ATTR_LPA_MODE:
> +		result = inv_lpa_mode(st, data);
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +	if (result)
> +		return result;
> +
> +	return count;
> +}
> +
> +#define INV_MPU_CHAN(_type, _channel2, _index)                        \
> +	{                                                             \
> +		.type = _type,                                        \
> +		.modified = 1,                                        \
> +		.channel2 = _channel2,                                \
> +		.info_mask =  (IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
> +				IIO_CHAN_INFO_SCALE_SHARED_BIT),      \
> +		.scan_index = _index,                                 \
> +		.scan_type  = IIO_ST('s', 16, 16, 0)                  \
> +	}
> +
> +#define INV_MPU_MAGN_CHAN(_channel2, _index)                          \
> +	{                                                             \
> +		.type = IIO_MAGN,                                     \
> +		.modified = 1,                                        \
> +		.channel2 = _channel2,                                \
> +		.info_mask =  IIO_CHAN_INFO_SCALE_SHARED_BIT,         \
> +		.scan_index = _index,                                 \
> +		.scan_type  = IIO_ST('s', 16, 16, 0)                  \
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
> +
> +	INV_MPU_MAGN_CHAN(IIO_MOD_X, INV_MPU_SCAN_MAGN_X),
> +	INV_MPU_MAGN_CHAN(IIO_MOD_Y, INV_MPU_SCAN_MAGN_Y),
> +	INV_MPU_MAGN_CHAN(IIO_MOD_Z, INV_MPU_SCAN_MAGN_Z),
> +};
> +
> +/*constant IIO attribute */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
> +	inv_fifo_rate_store);

in_temp_input - this is in the abi so please use it.
> +static DEVICE_ATTR(temperature, S_IRUGO, inv_temperature_show, NULL);

This needs documenting.
> +static IIO_DEVICE_ATTR(clock_source, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_CLK_SRC);
> +static IIO_DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_power_state_store, ATTR_POWER_STATE);

These do not generalise at all well.
> +static IIO_DEVICE_ATTR(lpa_mode, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_attr_store, ATTR_LPA_MODE);

Is there any reason not to automate this?  If the frequency is apropriate,
always use low power mode. If it isn't, don't.
> +static IIO_DEVICE_ATTR(lpa_freq, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_attr_store, ATTR_LPA_FREQ);
kill this off.
> +static DEVICE_ATTR(reg_dump, S_IRUGO, inv_reg_dump_show, NULL);

Most devices do this on start up only.  Reason to do it explicitly?
> +static IIO_DEVICE_ATTR(self_test, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_SELF_TEST);


> +static IIO_DEVICE_ATTR(key, S_IRUGO, inv_attr_show, NULL, ATTR_KEY);

This is useful stuff to generalize.  Please propose extensions to
Documentation/ABI/testing/sysfs-bus-iio to cover these.

> +static IIO_DEVICE_ATTR(gyro_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_GYRO_MATRIX);
> +static IIO_DEVICE_ATTR(accl_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_ACCL_MATRIX);
> +static IIO_DEVICE_ATTR(compass_matrix, S_IRUGO, inv_attr_show, NULL,
> +	ATTR_COMPASS_MATRIX);

I'm not really keen on doing this like this.  Ideal would be that these
were enabled on demand when a reading is requested (wait for one reading
then turn off again), or if they are being streamed out to a buffer.

> +static IIO_DEVICE_ATTR(gyro_enable, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_attr_store, ATTR_GYRO_ENABLE);
> +static IIO_DEVICE_ATTR(accl_enable, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_attr_store, ATTR_ACCL_ENABLE);
> +static IIO_DEVICE_ATTR(compass_enable, S_IRUGO | S_IWUSR, inv_attr_show,
> +	inv_attr_store, ATTR_COMPASS_ENABLE);
> +
> +static const struct attribute *inv_gyro_attributes[] = {
> +	&iio_dev_attr_gyro_enable.dev_attr.attr,
> +	&dev_attr_temperature.attr,
> +	&iio_dev_attr_clock_source.dev_attr.attr,
> +	&iio_dev_attr_power_state.dev_attr.attr,
> +	&dev_attr_reg_dump.attr,
> +	&iio_dev_attr_self_test.dev_attr.attr,
> +	&iio_dev_attr_key.dev_attr.attr,
> +	&iio_dev_attr_gyro_matrix.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +};
> +
> +static const struct attribute *inv_mpu6050_attributes[] = {
> +	&iio_dev_attr_accl_enable.dev_attr.attr,
> +	&iio_dev_attr_accl_matrix.dev_attr.attr,
> +	&iio_dev_attr_lpa_mode.dev_attr.attr,
> +	&iio_dev_attr_lpa_freq.dev_attr.attr,
> +};
> +
> +static const struct attribute *inv_compass_attributes[] = {
> +	&iio_dev_attr_compass_matrix.dev_attr.attr,
> +	&iio_dev_attr_compass_enable.dev_attr.attr,
> +};
> +
> +static struct attribute *inv_attributes[ARRAY_SIZE(inv_gyro_attributes) +
> +				ARRAY_SIZE(inv_mpu6050_attributes) +
> +				ARRAY_SIZE(inv_compass_attributes) + 1];
Don't do this. You have just limited yourself to only have one device
attached
to a given machine.  Please just have the relevant combinations statically
defined.

> +
> +static const struct attribute_group inv_attribute_group = {
Why are these in there own group? Should be in the base group.
> +	.name = "mpu",
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
> + *  inv_setup_compass() - Configure compass.
> + */
> +static int inv_setup_compass(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	unsigned char data[4];
> +
> +	result = inv_i2c_read(st, REG_YGOFFS_TC, 1, data);
> +	if (result)
> +		return result;
> +	data[0] &= ~BIT_I2C_MST_VDDIO;
> +	if (st->plat_data.level_shifter)
> +		data[0] |= BIT_I2C_MST_VDDIO;
> +	/*set up VDDIO register */
> +	result = inv_i2c_write(st, REG_YGOFFS_TC, data[0]);
> +	if (result)
> +		return result;
> +	/* set to bypass mode */
> +	result = inv_i2c_write(st, REG_INT_PIN_CFG,
> +				st->plat_data.int_config | BIT_BYPASS_EN);
> +	if (result)
> +		return result;
> +	/*read secondary i2c ID register */
This is something that ought to be broken out to a callback.
As far as I can tell this core code should not know anything at
all about the secondary devices other than one reference to tell
it what is connected. Everything else should be off in the driver
supporting them.

> +	result = inv_secondary_read(st, REG_AKM_ID, 1, data);
> +	if (result)
> +		return result;
> +	if (data[0] != DATA_AKM_ID)
> +		return -ENXIO;

This stuff is setup for the akm. Should again be via function in that driver
not here.
> +	/*set AKM to Fuse ROM access mode */
> +	result = inv_secondary_write(st, REG_AKM_MODE, DATA_AKM_MODE_FR);
> +	if (result)
> +		return result;
> +	result = inv_secondary_read(st, REG_AKM_SENSITIVITY, THREE_AXIS,
> +					st->chip_info.compass_sens);
> +	if (result)
> +		return result;
> +	/*revert to power down mode */
> +	result = inv_secondary_write(st, REG_AKM_MODE, DATA_AKM_MODE_PD);
> +	if (result)
> +		return result;
> +	pr_info("senx=%d, seny=%d,senz=%d\n",
> +		st->chip_info.compass_sens[0],
> +		st->chip_info.compass_sens[1],
> +		st->chip_info.compass_sens[2]);
> +	/*restore to non-bypass mode */
> +	result = inv_i2c_write(st, REG_INT_PIN_CFG,
> +			st->plat_data.int_config);
> +	if (result)
> +		return result;
> +
> +	/*setup master mode and master clock and ES bit*/
> +	result = inv_i2c_write(st, REG_I2C_MST_CTRL, BIT_WAIT_FOR_ES);
> +	if (result)
> +		return result;
> +	/* slave 0 is used to read data from compass */
> +	/*read mode */
> +	result = inv_i2c_write(st, REG_I2C_SLV0_ADDR, BIT_I2C_READ|
> +		st->plat_data.secondary_i2c_addr);
> +	if (result)
> +		return result;
> +	/* AKM status register address is 2 */
> +	result = inv_i2c_write(st, REG_I2C_SLV0_REG, REG_AKM_STATUS);
> +	if (result)
> +		return result;
> +	/* slave 0 is enabled at the beginning, read 8 bytes from here */
> +	result = inv_i2c_write(st, REG_I2C_SLV0_CTRL, BIT_SLV_EN |
> +				NUM_BYTES_COMPASS_SLAVE);
> +	if (result)
> +		return result;
> +	/*slave 1 is used for AKM mode change only*/
> +	result = inv_i2c_write(st, REG_I2C_SLV1_ADDR,
> +		st->plat_data.secondary_i2c_addr);
> +	if (result)
> +		return result;
> +	/* AKM mode register address is 0x0A */
> +	result = inv_i2c_write(st, REG_I2C_SLV1_REG, REG_AKM_MODE);
> +	if (result)
> +		return result;
> +	/* slave 1 is enabled, byte length is 1 */
> +	result = inv_i2c_write(st, REG_I2C_SLV1_CTRL, BIT_SLV_EN | 1);
> +	if (result)
> +		return result;
> +	/* output data for slave 1 is fixed, single measure mode*/
> +	st->compass_scale = 1;
More stuff this core shouldn't have access to or care about.
> +	if (COMPASS_ID_AK8975 == st->plat_data.sec_slave_id) {
> +		st->compass_st_upper = AKM8975_ST_Upper;
> +		st->compass_st_lower = AKM8975_ST_Lower;
> +		data[0] = DATA_AKM_MODE_SM;
> +	} else if (COMPASS_ID_AK8972 == st->plat_data.sec_slave_id) {
> +		st->compass_st_upper = AKM8972_ST_Upper;
> +		st->compass_st_lower = AKM8972_ST_Lower;
> +		data[0] = DATA_AKM_MODE_SM;
> +	} else if (COMPASS_ID_AK8963 == st->plat_data.sec_slave_id) {
> +		st->compass_st_upper = AKM8963_ST_Upper;
> +		st->compass_st_lower = AKM8963_ST_Lower;
> +		data[0] = DATA_AKM_MODE_SM |
> +			  (st->compass_scale << AKM8963_SCALE_SHIFT);
> +	}
> +	result = inv_i2c_write(st, REG_I2C_SLV1_DO, data[0]);
> +	if (result)
> +		return result;
> +	/* slave 0 and 1 timer action is enabled every sample*/
> +	result = inv_i2c_write(st, REG_I2C_MST_DELAY_CTRL,
> +				BIT_SLV0_DLY_EN | BIT_SLV1_DLY_EN);
> +	return result;
> +}
> +
> +static void inv_setup_func_ptr(struct inv_mpu_iio_s *st)
> +{
> +	st->set_power_state    = set_power_itg;
> +	st->switch_gyro_engine = inv_switch_gyro_engine;
> +	st->switch_accl_engine = inv_switch_accl_engine;
> +	st->init_config        = inv_init_config;
> +	st->setup_reg          = inv_setup_reg;
> +}
> +
> +/**
> + *  inv_check_chip_type() - check and setup chip type.
> + */
> +static int inv_check_chip_type(struct inv_mpu_iio_s *st,
> +		const struct i2c_device_id *id)
> +{


This next bit is a very bad idea for the reasons stated above.
You've ended up with more complex code and reduced flexibility.
There will be people who will attach several of your devices
to one machine, so please cater for them (it's the sort of thing
I'd do for starters ;)
> +	t_ind = 0;
> +	memcpy(&inv_attributes[t_ind], inv_gyro_attributes,
> +		sizeof(inv_gyro_attributes));
> +	t_ind += ARRAY_SIZE(inv_gyro_attributes);
> +
> +	memcpy(&inv_attributes[t_ind], inv_mpu6050_attributes,
> +		       sizeof(inv_mpu6050_attributes));
> +	t_ind += ARRAY_SIZE(inv_mpu6050_attributes);
> +
> +	if (st->chip_config.has_compass) {
> +		memcpy(&inv_attributes[t_ind], inv_compass_attributes,
> +		       sizeof(inv_compass_attributes));
> +		t_ind += ARRAY_SIZE(inv_compass_attributes);
> +	}
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
blank line.
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		result = -ENOSYS;
> +		pr_err("I2c function error\n");
> +		goto out_no_free;
> +	}
> +	indio_dev = iio_allocate_device(sizeof(*st));
> +	if (indio_dev == NULL) {
> +		pr_err("memory allocation failed\n");
> +		result =  -ENOMEM;
> +		goto out_no_free;
> +	}
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	st->secondary_client = *client;
really? That's 'interesting'... the secondary client is the same as
the primary one (up to a dereference).

> +	st->plat_data =
> +		*(struct mpu_platform_data *)dev_get_platdata(&client->dev);
> +	st->secondary_client.addr = st->plat_data.secondary_i2c_addr;
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
> +	result = st->set_power_state(st, false);
> +	if (result) {
> +		dev_err(&client->adapter->dev,
> +			"%s could not be turned off.\n", st->hw->name);
> +		goto out_free;
> +	}
> +
> +	/* Make state variables available to all _show and _store functions. */
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
> +	INIT_KFIFO(st->timestamps);
> +	spin_lock_init(&st->time_stamp_lock);
> +	pr_info("Probe name %s\n", id->name);
hmm.
> +	dev_info(&client->adapter->dev, "%s is ready to go!\n", st->hw->name);
> +
> +	return 0;
> +out_remove_ring:
> +	iio_buffer_unregister(indio_dev);
> +out_unreg_ring:
> +	inv_mpu_unconfigure_ring(indio_dev);
> +out_free:
> +	iio_free_device(indio_dev);
> +out_no_free:
> +	dev_err(&client->adapter->dev, "%s failed %d\n", __func__, result);
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
> +	iio_free_device(indio_dev);
> +
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
> +	{"mpu9150", INV_MPU9150},
> +	{"mpu6500", INV_MPU6500},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
> +
> +static struct i2c_driver inv_mpu_driver = {
> +	.class = I2C_CLASS_HWMON,
really? hwmon driver?
> +	.probe		=	inv_mpu_probe,

> +static int __init inv_mpu_init(void)
> +{
> +	int result = i2c_add_driver(&inv_mpu_driver);
> +	if (result) {
> +		pr_err("failed\n");
> +		return result;
Chances of this failing are tiny so don't bother with the error message.
Particularly as then you can use module_i2c_driver to loose the boiler
plate.
> +	}
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
> +
> +MODULE_AUTHOR("Invensense Corporation");
> +MODULE_DESCRIPTION("Invensense device driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("inv-mpu6050");
left over bit of documentation from somewhere?
> +/**
> + *  @}
> + */
> diff --git a/drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h
> b/drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h
> new file mode 100644
> index 0000000..0fc6d77
> --- /dev/null
> +++ b/drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h
> @@ -0,0 +1,514 @@
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
> +#include <linux/i2c.h>
> +#include <linux/kfifo.h>
> +#include <linux/miscdevice.h>
> +#include <linux/input.h>
> +#include <linux/spinlock.h>
> +#include "./mpu.h"
> +#include "../../iio.h"
> +#include "../../buffer.h"
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
u8 shorter and lack of implication that it's a character...
> +	unsigned char sample_rate_div;
> +	unsigned char lpf;
> +	unsigned char bank_sel;
> +	unsigned char user_ctrl;
> +	unsigned char fifo_en;
> +	unsigned char gyro_config;
> +	unsigned char accl_config;
> +	unsigned char fifo_count_h;
> +	unsigned char fifo_r_w;
> +	unsigned char raw_gyro;
> +	unsigned char raw_accl;
> +	unsigned char temperature;
> +	unsigned char int_enable;
> +	unsigned char int_status;
> +	unsigned char pwr_mgmt_1;
> +	unsigned char pwr_mgmt_2;
> +	unsigned char mem_start_addr;
> +	unsigned char mem_r_w;
> +	unsigned char prgm_strt_addrh;
> +};
> +/*device enum */
> +enum inv_devices {
> +	INV_MPU6050,
> +	INV_MPU9150,
> +	INV_MPU6500,
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
> +	unsigned int accl_sens[3];
> +};
> +
> +/**
> + *  struct inv_hw_s - Other important hardware information.
> + *  @num_reg:	Number of registers on device.
> + *  @name:      name of the chip
> + */
> +struct inv_hw_s {
> +	unsigned char num_reg;
> +	unsigned char *name;
> +};
> +
> +/**
> + *  struct inv_chip_config_s - Cached chip configuration data.
> + *  @fsr:		Full scale range.
> + *  @lpf:		Digital low pass filter frequency.
> + *  @clk_src:		Clock source.
> + *  @accl_fs:		accel full scale range.
> + *  @self_test_run_once flag for self test run ever.
> + *  @has_compass:	has compass or not.
> + *  @enable:		master enable to enable output
> + *  @accl_enable:	enable accel functionality
> + *  @accl_fifo_enable:	enable accel data output
> + *  @gyro_enable:	enable gyro functionality
> + *  @gyro_fifo_enable:	enable gyro data output
> + *  @compass_enable:	enable compass
> + *  @compass_fifo_enable: enable compass data output
> + *  @is_asleep:		1 if chip is powered down.
> + *  @lpa_mode:		low power mode.
> + *  @lpa_freq:		low power frequency
> + *  @fifo_rate:		FIFO update rate.
> + */
> +struct inv_chip_config_s {
> +	unsigned int fsr:2;
> +	unsigned int lpf:3;
> +	unsigned int clk_src:1;
> +	unsigned int accl_fs:2;
> +	unsigned int self_test_run_once:1;
> +	unsigned int has_compass:1;
> +	unsigned int enable:1;
> +	unsigned int accl_enable:1;
> +	unsigned int accl_fifo_enable:1;
> +	unsigned int gyro_enable:1;
> +	unsigned int gyro_fifo_enable:1;
> +	unsigned int compass_enable:1;
> +	unsigned int compass_fifo_enable:1;
> +	unsigned int is_asleep:1;
> +	unsigned int lpa_mode:1;
> +	unsigned short lpa_freq;
> +	unsigned short fifo_rate;
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
> +	unsigned char product_id;
> +	unsigned char product_revision;
> +	unsigned char silicon_revision;
> +	unsigned char software_revision;
> +	unsigned char multi;
> +	unsigned char compass_sens[3];
> +	unsigned long gyro_sens_trim;
> +	unsigned long accl_sens_trim;
> +};
> +
> +enum inv_channel_num {
> +	INV_CHANNEL_NUM_GYRO = 4,
> +	INV_CHANNEL_NUM_GYRO_ACCL = 7,
> +	INV_CHANNEL_NUM_GYRO_ACCL_MAGN = 10,
> +};
> +
Bit inconsistent on the capitalization...
> +/**
> + *  struct inv_mpu_iio_s - Driver state variables.
> + *  @chip_config:	Cached attribute information.
> + *  @chip_info:		Chip information from read-only registers.
> + *  @trig;              iio trigger.
* @trig:
> + *  @reg:		Map of important registers.
> + *  @hw:		Other hardware-specific information.
> + *  @chip_type:		chip type.
> + *  @time_stamp_lock:	spin lock to time stamp.
> + *  @client:		i2c client handle.
> + *  @secondary_client:  secondary i2c client data structure.
> + *  @plat_data:		platform data.
> + *  int (*set_power_state)(struct inv_mpu_iio_s *, int on): function ptr
> + *  int (*switch_gyro_engine)(struct inv_mpu_iio_s *, int on): function ptr
> + *  int (*switch_accl_engine)(struct inv_mpu_iio_s *, int on): function ptr
> + *  int (*init_config)(struct iio_dev *indio_dev): function ptr
> + *  void (*setup_reg)(struct inv_reg_map_s *reg): function ptr
> + *  @timestamps:        kfifo queue to store time stamp.
> + *  @compass_st_upper:  compass self test upper limit.
> + *  @compass_st_lower:  compass self test lower limit.
> + *  @irq:               irq number store.
> + *  @accel_bias:        accel bias store.
> + *  @gyro_bias:         gyro bias store.
> + *  @raw_gyro:          raw gyro data.
> + *  @raw_accel:         raw accel data.
> + *  @raw_compass:       raw compass.
> + *  @compass_scale:     compass scale.
> + *  @compass_divider:   slow down compass rate.
> + *  @compass_counter:   slow down compass rate.
> + *  @num_channels:      number of channels for current chip.
> + *  @irq_dur_ns:        duration between each irq.
> + *  @last_isr_time:     last isr time.
> + */
> +struct inv_mpu_iio_s {
> +#define TIMESTAMP_FIFO_SIZE 16
> +	struct inv_chip_config_s chip_config;
> +	struct inv_chip_info_s chip_info;
> +	struct iio_trigger  *trig;
> +	struct inv_reg_map_s reg;
> +	const struct inv_hw_s *hw;
> +	enum   inv_devices chip_type;
> +	spinlock_t time_stamp_lock;
> +	struct i2c_client *client;
> +	struct i2c_client secondary_client;
> +	struct mpu_platform_data plat_data;
> +	int (*set_power_state)(struct inv_mpu_iio_s *, bool on);
> +	int (*switch_gyro_engine)(struct inv_mpu_iio_s *, bool on);
> +	int (*switch_accl_engine)(struct inv_mpu_iio_s *, bool on);
> +	int (*init_config)(struct iio_dev *indio_dev);
> +	void (*setup_reg)(struct inv_reg_map_s *reg);
> +	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
> +	const short *compass_st_upper;
> +	const short *compass_st_lower;
> +	short irq;
> +	int accel_bias[3];
> +	int gyro_bias[3];
eplicit lengths would probaby be sensible here.
s16 I guess?
> +	short raw_gyro[3];
> +	short raw_accel[3];
> +	short raw_compass[3];
> +	unsigned char compass_scale;
> +	unsigned char compass_divider;
> +	unsigned char compass_counter;
> +	enum inv_channel_num num_channels;
> +	unsigned int irq_dur_ns;
s64. We are in kernel land so typically use kernel types.
> +	long long last_isr_time;
> +};
> +
> +/* produces an unique identifier for each device based on the
> +   combination of product version and product revision */
> +struct prod_rev_map_t {
> +	unsigned short mpl_product_key;
> +	unsigned char silicon_rev;
> +	unsigned short gyro_trim;
> +	unsigned short accel_trim;
> +};
> +
> +/* AKM definitions */
> +#define REG_AKM_ID               0x00
> +#define REG_AKM_STATUS           0x02
> +#define REG_AKM_MEASURE_DATA     0x03
> +#define REG_AKM_MODE             0x0A
> +#define REG_AKM_ST_CTRL          0x0C
> +#define REG_AKM_SENSITIVITY      0x10
> +#define REG_AKM8963_CNTL1        0x0A
> +
> +#define DATA_AKM_ID              0x48
> +#define DATA_AKM_MODE_PD	 0x00
> +#define DATA_AKM_MODE_SM	 0x01
> +#define DATA_AKM_MODE_ST	 0x08
> +#define DATA_AKM_MODE_FR	 0x0F
> +#define DATA_AKM_SELF_TEST       0x40
> +#define DATA_AKM_DRDY            0x01
> +#define DATA_AKM8963_BIT         0x10
> +#define DATA_AKM_STAT_MASK       0x0C
> +
> +#define DATA_AKM8975_SCALE       (9830 * (1L << 15))
> +#define DATA_AKM8972_SCALE       (19661 * (1L << 15))
> +#define DATA_AKM8963_SCALE0      (19661 * (1L << 15))
> +#define DATA_AKM8963_SCALE1      (4915 * (1L << 15))
> +#define AKM8963_SCALE_SHIFT      4
> +#define NUM_BYTES_COMPASS_SLAVE  8
> +
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
> +#define REG_6500_ACCEL_CONFIG2  0x1D
> +#define BIT_ACCEL_FCHOCIE_B              0x08
> +
> +#define REG_6500_LP_ACCEL_ODR   0x1E
> +
> +/* data definitions */
> +#define Q30_MULTI_SHIFT          30
> +
> +#define BYTES_PER_SENSOR         6
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
> +#define MAX_6500_LPA_FREQ_PARAM  11
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
> +#define INIT_DUR_TIME           ((1000 / INIT_FIFO_RATE) * NSEC_PER_MSEC)
> +#define MPL_PROD_KEY(ver, rev) (ver * 100 + rev)
> +#define NUM_OF_PROD_REVS (ARRAY_SIZE(prod_rev_map))
> +/*---- MPU6050 Silicon Revisions ----*/
> +#define MPU_SILICON_REV_A2                    1       /* MPU6050A2
> Device */
> +#define MPU_SILICON_REV_B1                    2       /* MPU6050B1
> Device */
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
> +/* scan element definition */
> +enum inv_mpu_scan {
> +	INV_MPU_SCAN_GYRO_X,
> +	INV_MPU_SCAN_GYRO_Y,
> +	INV_MPU_SCAN_GYRO_Z,
> +	INV_MPU_SCAN_ACCL_X,
> +	INV_MPU_SCAN_ACCL_Y,
> +	INV_MPU_SCAN_ACCL_Z,
> +	INV_MPU_SCAN_MAGN_X,
> +	INV_MPU_SCAN_MAGN_Y,
> +	INV_MPU_SCAN_MAGN_Z,
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
> +enum inv_slave_mode {
> +	INV_MODE_SUSPEND,
> +	INV_MODE_NORMAL,
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
> +	ATTR_LPA_MODE,
> +	ATTR_LPA_FREQ,
> +	ATTR_CLK_SRC,
> +	ATTR_SELF_TEST,
> +	ATTR_KEY,
> +	ATTR_GYRO_MATRIX,
> +	ATTR_ACCL_MATRIX,
> +	ATTR_COMPASS_MATRIX,
> +	ATTR_GYRO_ENABLE,
> +	ATTR_ACCL_ENABLE,
> +	ATTR_COMPASS_ENABLE,
> +	ATTR_POWER_STATE,
> +	ATTR_FIRMWARE_LOADED,
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
> +void inv_mpu_unconfigure_ring(struct iio_dev *indio_dev);
> +void inv_mpu_remove_trigger(struct iio_dev *indio_dev);
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st);
> +int set_inv_enable(struct iio_dev *indio_dev, bool enable);
> +int inv_set_interrupt_on_gesture_event(struct inv_mpu_iio_s *st, bool on);
> +int inv_i2c_read_base(struct inv_mpu_iio_s *st, unsigned short i2c_addr,
> +	unsigned char reg, unsigned short length, unsigned char *data);
> +int inv_i2c_single_write_base(struct inv_mpu_iio_s *st,
> +	unsigned short i2c_addr, unsigned char reg, unsigned char data);
> +int inv_do_test(struct inv_mpu_iio_s *st, int self_test_flag,
> +		int *gyro_result, int *accl_result);
> +int inv_hw_self_test(struct inv_mpu_iio_s *st);
> +int inv_hw_self_test_6500(struct inv_mpu_iio_s *st);
> +
> +inline int inv_i2c_read(struct inv_mpu_iio_s *st, int reg, int len,
> +			char *data);
> +inline int inv_i2c_write(struct inv_mpu_iio_s *st, int reg, int data);
> +inline int inv_secondary_read(struct inv_mpu_iio_s *st, int reg, int len,
> +			      char *data);
> +inline int inv_secondary_write(struct inv_mpu_iio_s *st, int reg, int
> data);
> +
> diff --git a/drivers/staging/iio/imu/mpu6050/inv_mpu_misc.c
> b/drivers/staging/iio/imu/mpu6050/inv_mpu_misc.c
> new file mode 100644
> index 0000000..345918a
> --- /dev/null
> +++ b/drivers/staging/iio/imu/mpu6050/inv_mpu_misc.c
> @@ -0,0 +1,771 @@
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
Maybe a brief statement of what is misc?
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
> +#include <linux/crc32.h>
why this header?
> +
> +#include "inv_mpu_iio.h"
> +/*--- Test parameters defaults --- */
> +#define DEF_OLDEST_SUPP_PROD_REV    8
> +#define DEF_OLDEST_SUPP_SW_REV      2
> +
> +/* sample rate */
> +#define DEF_SELFTEST_SAMPLE_RATE             0
> +/* LPF parameter */
> +#define DEF_SELFTEST_LPF_PARA                1
> +/* full scale setting dps */
> +#define DEF_SELFTEST_GYRO_FULL_SCALE         (0 << 3)
> +#define DEF_SELFTEST_ACCL_FULL_SCALE         (2 << 3)
> +#define DEF_SELFTEST_GYRO_SENS            (32768 / 250)
> +/* wait time before collecting data */
> +#define DEF_GYRO_WAIT_TIME          50
> +#define DEF_ST_STABLE_TIME          200
> +#define DEF_GYRO_PACKET_THRESH      DEF_GYRO_WAIT_TIME
> +#define DEF_GYRO_THRESH             10
> +#define DEF_GYRO_SCALE              131
> +#define DEF_ST_PRECISION            1000
> +#define DEF_ST_ACCL_FULL_SCALE      8000UL
> +#define DEF_ST_SCALE                (1L << 15)
> +#define DEF_ST_TRY_TIMES            2
> +#define DEF_ST_COMPASS_RESULT_SHIFT 2
> +#define DEF_ST_ACCEL_RESULT_SHIFT   1
> +
> +#define DEF_ST_COMPASS_WAIT_MIN     (10 * 1000)
> +#define DEF_ST_COMPASS_WAIT_MAX     (15 * 1000)
> +#define DEF_ST_COMPASS_TRY_TIMES    10
> +#define DEF_ST_COMPASS_8963_SHIFT   2
> +
> +#define X                           0
> +#define Y                           1
> +#define Z                           2
> +/*---- MPU6050 notable product revisions ----*/
> +#define MPU_PRODUCT_KEY_B1_E1_5      105
> +#define MPU_PRODUCT_KEY_B2_F1        431
> +/* accelerometer Hw self test min and max bias shift (mg) */
> +#define DEF_ACCEL_ST_SHIFT_MIN       300
> +#define DEF_ACCEL_ST_SHIFT_MAX       950
> +
> +#define DEF_ACCEL_ST_SHIFT_DELTA     140
> +#define DEF_GYRO_CT_SHIFT_DELTA      140
> +/* gyroscope Coriolis self test min and max bias shift (dps) */
> +#define DEF_GYRO_CT_SHIFT_MIN        10
> +#define DEF_GYRO_CT_SHIFT_MAX        105
> +
> +static struct test_setup_t test_setup = {
> +	.gyro_sens     = DEF_SELFTEST_GYRO_SENS,
> +	.sample_rate   = DEF_SELFTEST_SAMPLE_RATE,
> +	.lpf           = DEF_SELFTEST_LPF_PARA,
> +	.fsr           = DEF_SELFTEST_GYRO_FULL_SCALE,
> +	.accl_fs      = DEF_SELFTEST_ACCL_FULL_SCALE
> +};
> +
> +/* NOTE: product entries are in chronological order */
> +static const struct prod_rev_map_t prod_rev_map[] = {
> +	/* prod_ver = 0 */
> +	{MPL_PROD_KEY(0,   1), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   2), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   3), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   4), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   5), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   6), MPU_SILICON_REV_A2, 131, 16384},	/* (A2/C2-1) */
> +	/* prod_ver = 1, forced to 0 for MPU6050 A2 */
> +	{MPL_PROD_KEY(0,   7), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   8), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,   9), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  10), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  11), MPU_SILICON_REV_A2, 131, 16384},	/* (A2/D2-1) */
> +	{MPL_PROD_KEY(0,  12), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  13), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  14), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  15), MPU_SILICON_REV_A2, 131, 16384},
> +	{MPL_PROD_KEY(0,  27), MPU_SILICON_REV_A2, 131, 16384},	/* (A2/D4)   */
> +	/* prod_ver = 1 */
> +	{MPL_PROD_KEY(1,  16), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D2-1) */
> +	{MPL_PROD_KEY(1,  17), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D2-2) */
> +	{MPL_PROD_KEY(1,  18), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D2-3) */
> +	{MPL_PROD_KEY(1,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D2-4) */
> +	{MPL_PROD_KEY(1,  20), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D2-5) */
> +	{MPL_PROD_KEY(1,  28), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/D4)   */
> +	{MPL_PROD_KEY(1,   1), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/E1-1) */
> +	{MPL_PROD_KEY(1,   2), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/E1-2) */
> +	{MPL_PROD_KEY(1,   3), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/E1-3) */
> +	{MPL_PROD_KEY(1,   4), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/E1-4) */
> +	{MPL_PROD_KEY(1,   5), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/E1-5) */
> +	{MPL_PROD_KEY(1,   6), MPU_SILICON_REV_B1, 131, 16384},	/* (B1/E1-6) */
> +	/* prod_ver = 2 */
> +	{MPL_PROD_KEY(2,   7), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E1-1) */
> +	{MPL_PROD_KEY(2,   8), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E1-2) */
> +	{MPL_PROD_KEY(2,   9), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E1-3) */
> +	{MPL_PROD_KEY(2,  10), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E1-4) */
> +	{MPL_PROD_KEY(2,  11), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E1-5) */
> +	{MPL_PROD_KEY(2,  12), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E1-6) */
> +	{MPL_PROD_KEY(2,  29), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/D4)   */
> +	/* prod_ver = 3 */
> +	{MPL_PROD_KEY(3,  30), MPU_SILICON_REV_B1, 131, 16384},	/* (B2/E2)   */
> +	/* prod_ver = 4 */
> +	{MPL_PROD_KEY(4,  31), MPU_SILICON_REV_B1, 131,  8192},	/* (B2/F1)   */
> +	{MPL_PROD_KEY(4,   1), MPU_SILICON_REV_B1, 131,  8192},	/* (B3/F1)   */
> +	{MPL_PROD_KEY(4,   3), MPU_SILICON_REV_B1, 131,  8192},	/* (B4/F1)   */
> +	/* prod_ver = 5 */
> +	{MPL_PROD_KEY(5,   3), MPU_SILICON_REV_B1, 131, 16384},	/* (B4/F1)   */
> +	/* prod_ver = 6 */
> +	{MPL_PROD_KEY(6,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)   */
> +	/* prod_ver = 7 */
> +	{MPL_PROD_KEY(7,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)   */
> +	/* prod_ver = 8 */
> +	{MPL_PROD_KEY(8,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)   */
> +	/* prod_ver = 9 */
> +	{MPL_PROD_KEY(9,  19), MPU_SILICON_REV_B1, 131, 16384},	/* (B5/E2)   */
> +	/* prod_ver = 10 */
> +	{MPL_PROD_KEY(10, 19), MPU_SILICON_REV_B1, 131, 16384}	/* (B5/E2)   */
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
> +static const int accl_st_tb[31] = {
> +	340, 351, 363, 375, 388, 401, 414, 428,
> +	443, 458, 473, 489, 506, 523, 541, 559,
> +	578, 597, 617, 638, 660, 682, 705, 729,
> +	753, 779, 805, 832, 860, 889, 919};
> +static const int gyro_6050_st_tb[31] = {
> +	3275, 3425, 3583, 3748, 3920, 4100, 4289, 4486,
> +	4693, 4909, 5134, 5371, 5618, 5876, 6146, 6429,
> +	6725, 7034, 7358, 7696, 8050, 8421, 8808, 9213,
> +	9637, 10080, 10544, 11029, 11537, 12067, 12622};
> +
> +int mpu_memory_read(struct inv_mpu_iio_s *st,
> +			   unsigned short mem_addr,
> +			   unsigned int len, unsigned char *data)
> +{
> +	unsigned char bank[2];
> +	unsigned char addr[2];
> +	unsigned char buf;
> +
> +	struct i2c_msg msgs[4];
use some c99 stuff here for clarity.
struct i2c_msg msgs[4] = {
{
	.addr = st->client->addr,
	.buf = bank,
	.len = sizeof(bank),
},{
	.addr = st->client->addr,
	.buf = addr,
	.len = sizeof(addr),
etc...
> +	int res;
> +
> +	bank[0] = REG_BANK_SEL;
> +	bank[1] = mem_addr >> 8;
> +
> +	addr[0] = REG_MEM_START_ADDR;
> +	addr[1] = mem_addr & 0xFF;
> +
> +	buf = REG_MEM_RW;
It's constant so just have it where buf is defined.
> +
> +	msgs[0].addr = st->client->addr;
> +	msgs[0].flags = 0;
> +	msgs[0].buf = bank;
> +	msgs[0].len = sizeof(bank);
> +
> +	msgs[1].addr = st->client->addr;
> +	msgs[1].flags = 0;
> +	msgs[1].buf = addr;
> +	msgs[1].len = sizeof(addr);
> +
> +	msgs[2].addr = st->client->addr;
> +	msgs[2].flags = 0;
> +	msgs[2].buf = &buf;
> +	msgs[2].len = 1;
> +
> +	msgs[3].addr = st->client->addr;
> +	msgs[3].flags = I2C_M_RD;
> +	msgs[3].buf = data;
> +	msgs[3].len = len;
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
Not kernel doc...
> + *  @internal
> + *  @brief  Inverse lookup of the index of an MPL product key .
> + *  @param  key
> + *              the MPL product indentifier also referred to as 'key'.
> + *  @return the index position of the key in the array.
> + */
> +static short index_of_key(unsigned short key)
> +{
> +	int i;
> +	for (i = 0; i < NUM_OF_PROD_REVS; i++)
> +		if (prod_rev_map[i].mpl_product_key == key)
> +			return (short)i;
> +	return -EINVAL;
> +}
> +
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	struct inv_reg_map_s *reg;
> +	unsigned char prod_ver = 0x00, prod_rev = 0x00;
> +	struct prod_rev_map_t *p_rev;
> +	unsigned char bank =
> +	    (BIT_PRFTCH_EN | BIT_CFG_USER_BANK | MPU_MEM_OTP_BANK_0);
> +	unsigned short mem_addr = ((bank << 8) | MEM_ADDR_PROD_REV);
> +	unsigned short key;
> +	unsigned char regs[5];
> +	unsigned short sw_rev;
> +	short index;
> +	struct inv_chip_info_s *chip_info = &st->chip_info;
> +	reg = &st->reg;
> +
> +	result = inv_i2c_read(st, REG_PRODUCT_ID, 1, &prod_ver);
> +	if (result)
> +		return result;
> +	prod_ver &= 0xf;
> +	/*memory read need more time after power up */
> +	msleep(POWER_UP_TIME);
> +	result = mpu_memory_read(st, mem_addr, 1, &prod_rev);
> +	if (result)
> +		return result;
> +	prod_rev >>= 2;
> +	/* clean the prefetch and cfg user bank bits */
> +	result = inv_i2c_write(st, reg->bank_sel, 0);
> +	if (result)
> +		return result;
> +	/* get the software-product version, read from XA_OFFS_L */
> +	result = inv_i2c_read(st, REG_XA_OFFS_L_TC,
> +				SOFT_PROD_VER_BYTES, regs);
> +	if (result)
> +		return result;
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
> +	return result;
> +}
> +
> +/**
> + *  @internal
> + *  @brief  read the accelerometer hardware self-test bias shift calculated
> + *          during final production test and stored in chip
> non-volatile memory.
> + *  @param  st
> + *              main data structure.
> + *  @param  ct_shift_prod
> + *              A pointer to an array of 3 elements to hold the values
> + *              for production hardware self-test bias shifts returned
> to the
> + *              user.
> + *  @return 0 on success, or a non-zero error code otherwise.
> + */
> +static int read_accel_hw_self_test_prod_shift(struct inv_mpu_iio_s *st,
> +					int *st_prod)
> +{
> +	unsigned char regs[4];
> +	unsigned char shift_code[3];
> +	int result, i;
> +	st_prod[0] = 0;
> +	st_prod[1] = 0;
> +	st_prod[2] = 0;
> +	result = inv_i2c_read(st, REG_ST_GCT_X, ARRAY_SIZE(regs), regs);
> +	if (result)
> +		return result;
> +	if ((0 == regs[0])  && (0 == regs[1]) &&
> +	    (0 == regs[2]) && (0 == regs[3]))
> +		return -EINVAL;
> +	shift_code[X] = ((regs[0] & 0xE0) >> 3) | ((regs[3] & 0x30) >> 4);
> +	shift_code[Y] = ((regs[1] & 0xE0) >> 3) | ((regs[3] & 0x0C) >> 2);
> +	shift_code[Z] = ((regs[2] & 0xE0) >> 3) |  (regs[3] & 0x03);
> +	for (i = 0; i < 3; i++) {
> +		if (shift_code[i] != 0)
> +			st_prod[i] = test_setup.accl_sens[i]*
> +				accl_st_tb[shift_code[i] - 1];
> +	}
> +
> +	return 0;
> +}
> +/**
> +* @brief check accel self test.
> +*        this function returns zero as success. A non-zero
> +*        return value indicates failure in self test.
> +*  @param *st main data structure.
> +*  @param *reg_avg average value of normal test.
> +*  @param *st_avg  average value of self test
> +*/
> +static int inv_check_accl_self_test(struct inv_mpu_iio_s *st,
> +	int *reg_avg, int *st_avg){
> +	int gravity, reg_z_avg, g_z_sign, fs, j, ret_val;
> +	int tmp1;
> +	int st_shift_prod[THREE_AXIS], st_shift_cust[THREE_AXIS];
> +	int st_shift_ratio[THREE_AXIS];
> +	if (st->chip_info.software_revision < DEF_OLDEST_SUPP_SW_REV &&
> +	    st->chip_info.product_revision < DEF_OLDEST_SUPP_PROD_REV)
> +		return 0;
> +	fs = DEF_ST_ACCL_FULL_SCALE;    /* assume +/- 2 mg as typical */
> +	g_z_sign = 1;
> +	ret_val = 0;
> +	test_setup.accl_sens[X] = (unsigned int)(DEF_ST_SCALE *
> +						DEF_ST_PRECISION / fs);
> +	test_setup.accl_sens[Y] = (unsigned int)(DEF_ST_SCALE *
> +						DEF_ST_PRECISION / fs);
> +	test_setup.accl_sens[Z] = (unsigned int)(DEF_ST_SCALE *
> +						DEF_ST_PRECISION / fs);
> +
> +	if (MPL_PROD_KEY(st->chip_info.product_id,
> +			 st->chip_info.product_revision) ==
> +	    MPU_PRODUCT_KEY_B1_E1_5) {
> +		/* half sensitivity Z accelerometer parts */
> +		test_setup.accl_sens[Z] /= 2;
> +	} else {
> +		/* half sensitivity X, Y, Z accelerometer parts */
> +		test_setup.accl_sens[X] /= st->chip_info.multi;
> +		test_setup.accl_sens[Y] /= st->chip_info.multi;
> +		test_setup.accl_sens[Z] /= st->chip_info.multi;
> +	}
> +	gravity = test_setup.accl_sens[Z];
> +	reg_z_avg = reg_avg[Z] - g_z_sign * gravity*DEF_ST_PRECISION;
> +	read_accel_hw_self_test_prod_shift(st, st_shift_prod);
> +	for (j = 0; j < 3; j++) {
> +		st_shift_cust[j] = abs(reg_avg[j] - st_avg[j]);
> +		if (st_shift_prod[j]) {
> +			tmp1 = st_shift_prod[j]/DEF_ST_PRECISION;
> +			st_shift_ratio[j] = st_shift_cust[j]/tmp1
> +				- DEF_ST_PRECISION;
> +			if (st_shift_ratio[j] > DEF_ACCEL_ST_SHIFT_DELTA)
> +				ret_val |= 1 << j;
> +			if (st_shift_ratio[j] < -DEF_ACCEL_ST_SHIFT_DELTA)
> +				ret_val |= 1 << j;
> +		} else {
> +			if (st_shift_cust[j] <
> +				DEF_ACCEL_ST_SHIFT_MIN*gravity)
> +				ret_val |= 1 << j;
> +			if (st_shift_cust[j] >
> +				DEF_ACCEL_ST_SHIFT_MAX*gravity)
> +				ret_val |= 1 << j;
> +		}
> +	}
> +
> +	return ret_val;
> +}
> +/**
> +* @brief check 6050 gyro self test.
> +*        this function returns zero as success. A non-zero
> +*        return value indicates failure in self test.
> +*  @param st main data structure.
> +*  @param *reg_avg average value of normal test.
> +*  @param *st_avg  average value of self test
> +*/
> +static int inv_check_6050_gyro_self_test(struct inv_mpu_iio_s *st,
> +	int *reg_avg, int *st_avg){
> +	int result;
> +	int ret_val;
> +	int ct_shift_prod[3], st_shift_cust[3], st_shift_ratio[3], i;
> +	unsigned char regs[3];
> +	if (st->chip_info.software_revision < DEF_OLDEST_SUPP_SW_REV &&
> +	    st->chip_info.product_revision < DEF_OLDEST_SUPP_PROD_REV)
> +		return 0;
> +
> +	ret_val = 0;
> +	result = inv_i2c_read(st, REG_ST_GCT_X, 3, regs);
> +	if (result)
> +		return result;
> +	regs[X] &= 0x1f;
> +	regs[Y] &= 0x1f;
> +	regs[Z] &= 0x1f;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (regs[i] != 0)
> +			ct_shift_prod[i] = gyro_6050_st_tb[regs[i] - 1];
> +		else
> +			ct_shift_prod[i] = 0;
> +	}
> +	for (i = 0; i < 3; i++) {
> +		st_shift_cust[i] = abs(reg_avg[i] - st_avg[i]);
> +		if (ct_shift_prod[i]) {
> +			st_shift_ratio[i] = st_shift_cust[i] /
> +				ct_shift_prod[i] - DEF_ST_PRECISION;
> +			if (st_shift_ratio[i] > DEF_GYRO_CT_SHIFT_DELTA)
> +				ret_val |= 1 << i;
> +			if (st_shift_ratio[i] < -DEF_GYRO_CT_SHIFT_DELTA)
> +				ret_val |= 1 << i;
> +		} else {
> +			if (st_shift_cust[i] < DEF_ST_PRECISION *
> +				DEF_GYRO_CT_SHIFT_MIN * test_setup.gyro_sens)
> +				ret_val |= 1 << i;
> +			if (st_shift_cust[i] > DEF_ST_PRECISION *
> +				DEF_GYRO_CT_SHIFT_MAX * test_setup.gyro_sens)
> +				ret_val |= 1 << i;
> +		}
> +	}
> +	for (i = 0; i < 3; i++) {
> +		if (abs(reg_avg[i]) * 4 > 20 * 2 *
> +		    DEF_ST_PRECISION * DEF_GYRO_SCALE)
> +			ret_val |= (1 << i);
> +	}
> +
> +	return ret_val;
> +}
> +
> +/**
> + *  inv_do_test() - do the actual test of self testing
> + */
> +int inv_do_test(struct inv_mpu_iio_s *st, int self_test_flag,
> +		int *gyro_result, int *accl_result)
> +{
> +	struct inv_reg_map_s *reg;
> +	int result, i, j, packet_size;
> +	unsigned char data[BYTES_PER_SENSOR * 2], has_accl;
> +	int fifo_count, packet_count, ind;
> +
> +	reg = &st->reg;
> +	has_accl = 1;
> +	packet_size = BYTES_PER_SENSOR*(1 + has_accl);
> +
> +	result = inv_i2c_write(st, reg->int_enable, 0);
> +	if (result)
> +		return result;
> +	/* disable the sensor output to FIFO */
> +	result = inv_i2c_write(st, reg->fifo_en, 0);
> +	if (result)
> +		return result;
> +	/* disable fifo reading */
> +	result = inv_i2c_write(st, reg->user_ctrl, 0);
> +	if (result)
> +		return result;
> +	/* clear FIFO */
> +	result = inv_i2c_write(st, reg->user_ctrl, BIT_FIFO_RST);
> +	if (result)
> +		return result;
> +	/* setup parameters */
> +	result = inv_i2c_write(st, reg->lpf, test_setup.lpf);
> +	if (result)
> +		return result;
> +	result = inv_i2c_write(st, reg->sample_rate_div,
> +		test_setup.sample_rate);
> +	if (result)
> +		return result;
> +	result = inv_i2c_write(st, reg->gyro_config,
> +		self_test_flag | test_setup.fsr);
> +	if (result)
> +		return result;
> +	if (has_accl) {
> +		result = inv_i2c_write(st, reg->accl_config,
> +			self_test_flag | test_setup.accl_fs);
> +		if (result)
> +			return result;
> +	}
> +	/*wait for the output to stable*/
> +	if (self_test_flag)
> +		msleep(DEF_ST_STABLE_TIME);
> +
> +	/* enable FIFO reading */
> +	result = inv_i2c_write(st, reg->user_ctrl, BIT_FIFO_EN);
> +	if (result)
> +		return result;
> +	/* enable sensor output to FIFO */
> +	result = inv_i2c_write(st, reg->fifo_en, BITS_GYRO_OUT
> +		| (has_accl << 3));
> +	if (result)
> +		return result;
> +	mdelay(DEF_GYRO_WAIT_TIME);
> +	/* stop sending data to FIFO */
> +	result = inv_i2c_write(st, reg->fifo_en, 0);
> +	if (result)
> +		return result;
> +	result = inv_i2c_read(st, reg->fifo_count_h, FIFO_COUNT_BYTE, data);
> +	if (result)
> +		return result;
> +	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
> +	packet_count = fifo_count / packet_size;
> +	for (i = 0; i < 3; i++) {
> +		gyro_result[i] = 0;
> +		accl_result[i] = 0;
> +	}
> +	if (abs(packet_count - DEF_GYRO_PACKET_THRESH) > DEF_GYRO_THRESH)
> +		return -EAGAIN;
> +
> +	for (i = 0; i < packet_count; i++) {
> +		/* getting FIFO data */
> +		result = inv_i2c_read(st, reg->fifo_r_w,
> +			packet_size, data);
> +		if (result)
> +				return result;
> +		ind = 0;
> +		if (has_accl) {
> +			for (j = 0; j < THREE_AXIS; j++)
> +				accl_result[j] +=
> +					(short)be16_to_cpup((__be16
> +					*)(&data[ind + 2 * j]));
> +				ind += BYTES_PER_SENSOR;
> +		}
> +		for (j = 0; j < THREE_AXIS; j++)
> +			gyro_result[j] +=
> +			(short)be16_to_cpup((__be16 *)(&data[ind + 2 * j]));
> +	}
> +
> +	gyro_result[0] = gyro_result[0] * DEF_ST_PRECISION / packet_count;
> +	gyro_result[1] = gyro_result[1] * DEF_ST_PRECISION / packet_count;
> +	gyro_result[2] = gyro_result[2] * DEF_ST_PRECISION / packet_count;
> +	if (has_accl) {
> +		accl_result[0] =
> +			accl_result[0] * DEF_ST_PRECISION / packet_count;
> +		accl_result[1] =
> +			accl_result[1] * DEF_ST_PRECISION / packet_count;
> +		accl_result[2] =
> +			accl_result[2] * DEF_ST_PRECISION / packet_count;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_recover_setting() recover the old settings after everything is done
> + */
> +static void inv_recover_setting(struct inv_mpu_iio_s *st)
> +{
> +	struct inv_reg_map_s *reg;
> +	int data;
> +	struct iio_dev *indio = iio_priv_to_dev(st);
> +
> +	reg = &st->reg;
> +	set_inv_enable(indio, st->chip_config.enable);
> +	inv_i2c_write(st, reg->gyro_config,
> +			     st->chip_config.fsr << GYRO_CONFIG_FSR_SHIFT);
> +	inv_i2c_write(st, reg->lpf, st->chip_config.lpf);
> +	data = ONE_K_HZ/st->chip_config.fifo_rate - 1;
> +	inv_i2c_write(st, reg->sample_rate_div, data);
> +	inv_i2c_write(st, reg->accl_config,
> +			     (st->chip_config.accl_fs <<
> +			     ACCL_CONFIG_FSR_SHIFT));
> +	st->set_power_state(st, !st->chip_config.is_asleep);
> +}
> +
> +static int inv_check_compass_self_test(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	unsigned char data[6];
> +	unsigned char counter, cntl;
> +	short x, y, z;
> +	unsigned char *sens;
> +	sens = st->chip_info.compass_sens;
> +
> +	/*set to bypass mode */
> +	result = inv_i2c_write(st, REG_INT_PIN_CFG,
> +				st->plat_data.int_config | BIT_BYPASS_EN);
> +	if (result) {
> +		result = inv_i2c_write(st, REG_INT_PIN_CFG,
> +				st->plat_data.int_config);
> +		return result;
> +	}
> +	/*set to power down mode */
> +	result = inv_secondary_write(st, REG_AKM_MODE, DATA_AKM_MODE_PD);
> +	if (result)
> +		goto AKM_fail;
> +
> +	/*write 1 to ASTC register */
> +	result = inv_secondary_write(st, REG_AKM_ST_CTRL, DATA_AKM_SELF_TEST);
> +	if (result)
> +		goto AKM_fail;
> +	/*set self test mode */
> +	result = inv_secondary_write(st, REG_AKM_MODE, DATA_AKM_MODE_ST);
> +	if (result)
> +		goto AKM_fail;
> +	counter = DEF_ST_COMPASS_TRY_TIMES;
> +	while (counter > 0) {
> +		usleep_range(DEF_ST_COMPASS_WAIT_MIN, DEF_ST_COMPASS_WAIT_MAX);
> +		result = inv_secondary_read(st, REG_AKM_STATUS, 1, data);
> +		if (result)
> +			goto AKM_fail;
> +		if ((data[0] & DATA_AKM_DRDY) == 0)
> +			counter--;
> +		else
> +			counter = 0;
> +	}
> +	if ((data[0] & DATA_AKM_DRDY) == 0) {
> +		result = -EINVAL;
> +		goto AKM_fail;
> +	}
> +	result = inv_secondary_read(st, REG_AKM_MEASURE_DATA,
> +					BYTES_PER_SENSOR, data);
> +	if (result)
> +		goto AKM_fail;
> +
> +	x =	le16_to_cpup((__le16 *)(&data[0]));
> +	y =	le16_to_cpup((__le16 *)(&data[2]));
> +	z =	le16_to_cpup((__le16 *)(&data[4]));
> +	x = ((x * (sens[0] + 128)) >> 8);
> +	y = ((y * (sens[1] + 128)) >> 8);
> +	z = ((z * (sens[2] + 128)) >> 8);
> +	if (COMPASS_ID_AK8963 == st->plat_data.sec_slave_id) {
> +		result = inv_secondary_read(st, REG_AKM8963_CNTL1, 1, &cntl);
> +		if (result)
> +			goto AKM_fail;
> +		if (0 == (cntl & DATA_AKM8963_BIT)) {
> +			x <<= DEF_ST_COMPASS_8963_SHIFT;
> +			y <<= DEF_ST_COMPASS_8963_SHIFT;
> +			z <<= DEF_ST_COMPASS_8963_SHIFT;
> +		}
> +	}
> +	result = -EINVAL;
> +	if (x > st->compass_st_upper[X] || x < st->compass_st_lower[X])
> +		goto AKM_fail;
> +	if (y > st->compass_st_upper[Y] || y < st->compass_st_lower[Y])
> +		goto AKM_fail;
> +	if (z > st->compass_st_upper[Z] || z < st->compass_st_lower[Z])
> +		goto AKM_fail;
> +	result = 0;
> +AKM_fail:
> +	/*write 0 to ASTC register */
> +	result |= inv_secondary_write(st, REG_AKM_ST_CTRL, 0);
> +	/*set to power down mode */
> +	result |= inv_secondary_write(st, REG_AKM_MODE, DATA_AKM_MODE_PD);
> +	/*restore to non-bypass mode */
> +	result |= inv_i2c_write(st, REG_INT_PIN_CFG,
> +			st->plat_data.int_config);
> +	return result;
> +}
> +
> +static int inv_power_up_self_test(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	result = inv_i2c_write(st, st->reg.pwr_mgmt_1, INV_CLK_PLL);
> +	if (result)
> +		return result;
> +	msleep(POWER_UP_TIME);
> +	result = inv_i2c_write(st, st->reg.pwr_mgmt_2, 0);
> +	if (result)
> +		return result;
> +	msleep(SENSOR_UP_TIME);
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_hw_self_test() - main function to do hardware self test
> + */
> +int inv_hw_self_test(struct inv_mpu_iio_s *st)
> +{
> +	int result;
> +	int gyro_bias_st[THREE_AXIS], gyro_bias_regular[THREE_AXIS];
> +	int accl_bias_st[THREE_AXIS], accl_bias_regular[THREE_AXIS];
> +	int test_times;
> +	char compass_result, accel_result, gyro_result;
> +	if (st->chip_config.is_asleep      ||
> +	    st->chip_config.lpa_mode       ||
> +	    (!st->chip_config.gyro_enable) ||
> +	    (!st->chip_config.accl_enable)) {
> +		result = inv_power_up_self_test(st);
> +		if (result)
> +			return result;
> +	}
> +	compass_result = 0;
> +	accel_result   = 0;
> +	gyro_result    = 0;
> +	test_times = DEF_ST_TRY_TIMES;
> +	while (test_times > 0) {
> +		result = inv_do_test(st, 0,  gyro_bias_regular,
> +			accl_bias_regular);
> +		if (result == -EAGAIN)
> +			test_times--;
> +		else
> +			test_times = 0;
> +	}
> +	if (result)
> +		goto test_fail;
> +
> +	test_times = DEF_ST_TRY_TIMES;
> +	while (test_times > 0) {
> +		result = inv_do_test(st, BITS_SELF_TEST_EN, gyro_bias_st,
> +					accl_bias_st);
> +		if (result == -EAGAIN)
> +			test_times--;
> +		else
> +			break;
> +	}
> +	if (result)
> +		goto test_fail;
> +	if (st->chip_config.has_compass)
> +			compass_result = !inv_check_compass_self_test(st);
> +	accel_result = !inv_check_accl_self_test(st,
> +			accl_bias_regular, accl_bias_st);
> +	gyro_result = !inv_check_6050_gyro_self_test(st,
> +			gyro_bias_regular, gyro_bias_st);
> +test_fail:
> +	inv_recover_setting(st);
> +
> +	return (compass_result << DEF_ST_COMPASS_RESULT_SHIFT) |
> +		(accel_result << DEF_ST_ACCEL_RESULT_SHIFT) | gyro_result;
> +}
> +
> +/**
> + *  inv_hw_self_test_6500() - main function to do hardware self test
> for 6500
> + */
> +int inv_hw_self_test_6500(struct inv_mpu_iio_s *st)
> +{
> +	int compass_result;
> +	compass_result = !inv_check_compass_self_test(st);
> +	return (compass_result << DEF_ST_COMPASS_RESULT_SHIFT) |
> +		(SELF_TEST_SUCCESS << DEF_ST_ACCEL_RESULT_SHIFT) |
> +		SELF_TEST_SUCCESS;
> +}
> +
> diff --git a/drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c
> b/drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c
> new file mode 100644
> index 0000000..66ecadb
> --- /dev/null
> +++ b/drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c
> @@ -0,0 +1,452 @@
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
Again, please move to a current tree...
> +#include "../../iio.h"
> +#include "../../kfifo_buf.h"
> +#include "../../trigger_consumer.h"
> +#include "../../sysfs.h"
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
> +
> +	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_MAGN_X) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_MAGN_Y) ||
> +	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_MAGN_Z))
> +		st->chip_config.compass_fifo_enable = 1;
> +	else
> +		st->chip_config.compass_fifo_enable = 0;
> +}
> +
...

> +
> +/**
> + *  inv_read_fifo() - Transfer data from FIFO to ring buffer.
> + */
> +irqreturn_t inv_read_fifo(int irq, void *dev_id)
> +{
> +
> +	struct inv_mpu_iio_s *st = (struct inv_mpu_iio_s *)dev_id;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	size_t bytes_per_datum;
> +	int result;
Please just use kernel data types, u8 u16 etc. They are short
and precise.
> +	unsigned char data[BYTES_PER_SENSOR * 2];
> +	unsigned short fifo_count;
> +	unsigned int copied;
> +	s64 timestamp;
> +	struct inv_reg_map_s *reg;
> +	s64 buf[8];
> +	unsigned char *tmp;
> +	reg = &st->reg;
> +	if (!(st->chip_config.accl_fifo_enable |
> +		st->chip_config.gyro_fifo_enable |
> +		st->chip_config.compass_fifo_enable))
> +		goto end_session;
> +	if (st->chip_config.lpa_mode) {
> +		result = inv_i2c_read(st, reg->raw_accl,
> +				      BYTES_PER_SENSOR, data);
> +		if (result)
> +			goto end_session;
> +		inv_report_gyro_accl_compass(indio_dev, data,
> +					     iio_get_time_ns());
> +		goto end_session;
> +	}
> +
> +	bytes_per_datum = (st->chip_config.accl_fifo_enable +
> +		st->chip_config.gyro_fifo_enable) * BYTES_PER_SENSOR;
> +	fifo_count = 0;
> +	if (bytes_per_datum != 0) {
> +		result = inv_i2c_read(st, reg->fifo_count_h,
> +				FIFO_COUNT_BYTE, data);
> +		if (result)
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
> +		if (kfifo_len(&st->timestamps) <
> +			fifo_count / bytes_per_datum)
> +			goto flush_fifo;
> +		if (kfifo_len(&st->timestamps) >
> +			fifo_count / bytes_per_datum + TIME_STAMP_TOR)
> +				goto flush_fifo;
> +	} else {
> +		result = kfifo_to_user(&st->timestamps,
> +			&timestamp, sizeof(timestamp), &copied);
> +		if (result)
> +			goto flush_fifo;
> +	}
> +	tmp = (char *)buf;
> +	while ((bytes_per_datum != 0) && (fifo_count >= bytes_per_datum)) {
> +		result = inv_i2c_read(st, reg->fifo_r_w, bytes_per_datum,
> +			data);
> +		if (result)
> +			goto flush_fifo;
> +
> +		result = kfifo_to_user(&st->timestamps,
> +			&timestamp, sizeof(timestamp), &copied);
> +		if (result)
> +			goto flush_fifo;
> +		inv_report_gyro_accl_compass(indio_dev, data, timestamp);
> +		fifo_count -= bytes_per_datum;
> +	}
> +	if (bytes_per_datum == 0)
> +		inv_report_gyro_accl_compass(indio_dev, data, timestamp);
> +end_session:
> +	return IRQ_HANDLED;
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
> +	return ret;
> +}
> +
> diff --git a/drivers/staging/iio/imu/mpu6050/mpu.h
> b/drivers/staging/iio/imu/mpu6050/mpu.h
> new file mode 100644
> index 0000000..1413191
> --- /dev/null
> +++ b/drivers/staging/iio/imu/mpu6050/mpu.h
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
> accel, etc
> + * @sec_slave_id:       id of the secondary slave device
> + * @secondary_i2c_address: secondary device's i2c address
> + * @secondary_orientation: secondary device's orientation matrix
> + * @key: key to identify the driver
> + *
> + */

why the __ form of these types?  u8 etc should be fine...
> +struct mpu_platform_data {
> +	__u8 int_config;
> +	__u8 level_shifter;
> +	__s8 orientation[9];
> +	enum secondary_slave_type sec_slave_type;
> +	enum ext_slave_id sec_slave_id;
> +	__u16 secondary_i2c_addr;
> +	__s8 secondary_orientation[9];
> +	__u8 key[16];
> +};
> +
> 


