Return-Path: <ggao@invensense.com>
From: Ge GAO <ggao@invensense.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Ge Gao <ggao@invensense.com>
Subject: [PATCH] [V7] Invensense MPU6050 Device Driver.
Date: Fri, 11 Jan 2013 18:28:31 -0800
Message-Id: <1357957711-7948-1-git-send-email-ggao@invensense.com>
List-ID: <linux-iio@vger.kernel.org>

From: Ge Gao <ggao@invensense.com>

--This the basic function of Invensense MPU6050 Deivce driver.
--Remove the inv_mpu_misc.c as it is not very useful.
--Remove the catch up inside interrupt routine.
--align the define names into more consistent ones.
--change data structure name into more meaningful ones.
--fix kernel-doc warnings.
--move the mutex handling into proper locations.

Change-Id: I960684f53bcc8a260506a693a21c2278150eb03b
Signed-off-by: Ge Gao <ggao@invensense.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-mpu6050  |   14 +
 drivers/iio/imu/Kconfig                          |    2 +
 drivers/iio/imu/Makefile                         |    2 +
 drivers/iio/imu/inv_mpu6050/Kconfig              |   13 +
 drivers/iio/imu/inv_mpu6050/Makefile             |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       |  754 ++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h        |  244 +++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c       |  278 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c    |   72 ++
 include/linux/platform_data/invensense_mpu6050.h |   32 +
 10 files changed, 1417 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-mpu6050
 create mode 100644 drivers/iio/imu/inv_mpu6050/Kconfig
 create mode 100644 drivers/iio/imu/inv_mpu6050/Makefile
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
 create mode 100644 include/linux/platform_data/invensense_mpu6050.h

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-mpu6050 b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
new file mode 100644
index 0000000..d4ec747
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
@@ -0,0 +1,14 @@
+What:           /sys/bus/iio/devices/iio:deviceX/in_gyro_matrix
+What:           /sys/bus/iio/devices/iio:deviceX/in_accel_matrix
+What:           /sys/bus/iio/devices/iio:deviceX/in_magn_matrix
+KernelVersion:  3.4.0
+Contact:        linux-iio@vger.kernel.org
+Description:
+		This is mounting matrix for motion sensors. Mounting matrix
+		is a 3x3 unitary matrix. A typical mounting matrix would look like
+		[0, 1, 0; 1, 0, 0; 0, 0, -1]. Using this information, it would be
+		easy to tell the relative positions among sensors as well as their
+		positions relative to the board that holds these sensors. Identity matrix
+		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and device are perfectly
+		aligned with each other. All axes are exactly the same.
+
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 3d79a40..723563b 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -25,3 +25,5 @@ config IIO_ADIS_LIB_BUFFER
 	help
 	  A set of buffer helper functions for the Analog Devices ADIS* device
 	  family.
+
+source "drivers/iio/imu/inv_mpu6050/Kconfig"
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index cfe5763..1b41584 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -8,3 +8,5 @@ adis_lib-y += adis.o
 adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
 adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
 obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
+
+obj-y += inv_mpu6050/
diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
new file mode 100644
index 0000000..938a870
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -0,0 +1,13 @@
+#
+# inv-mpu6050 drivers for Invensense MPU devices and combos
+#
+
+config INV_MPU6050_IIO
+	tristate "Invensense MPU6050 devices"
+	depends on I2C && SYSFS && IIO
+	select IIO_TRIGGERED_BUFFER
+	help
+	  This driver supports the Invensense MPU6050 devices.
+	  It is a gyroscope/accelerometer combo device.
+	  This driver can be built as a module. The module will be called
+	  inv-mpu6050.
diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
new file mode 100644
index 0000000..3a677c7
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for Invensense MPU6050 device.
+#
+
+obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
+inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
new file mode 100644
index 0000000..4f2bd93
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -0,0 +1,754 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include "inv_mpu_iio.h"
+
+static const struct inv_hw_s hw_info[INV_NUM_PARTS] = {
+	{117, "MPU6050"},
+};
+static const int gyro_scale_6050[] = {250, 500, 1000, 2000};
+static const int accel_scale[] = {2, 4, 8, 16};
+
+static const struct inv_reg_map_s reg_set_6050 = {
+	.sample_rate_div	= MPU_REG_SAMPLE_RATE_DIV,
+	.lpf                    = MPU_REG_CONFIG,
+	.user_ctrl              = MPU_REG_USER_CTRL,
+	.fifo_en                = MPU_REG_FIFO_EN,
+	.gyro_config            = MPU_REG_GYRO_CONFIG,
+	.accl_config            = MPU_REG_ACCEL_CONFIG,
+	.fifo_count_h           = MPU_REG_FIFO_COUNT_H,
+	.fifo_r_w               = MPU_REG_FIFO_R_W,
+	.raw_gyro               = MPU_REG_RAW_GYRO,
+	.raw_accl               = MPU_REG_RAW_ACCEL,
+	.temperature            = MPU_REG_TEMPERATURE,
+	.int_enable             = MPU_REG_INT_ENABLE,
+	.pwr_mgmt_1             = MPU_REG_PWR_MGMT_1,
+	.pwr_mgmt_2             = MPU_REG_PWR_MGMT_2,
+};
+
+static const struct inv_chip_config chip_config_6050 = {
+	.fsr = INV_FSR_2000DPS,
+	.lpf = INV_FILTER_20HZ,
+	.fifo_rate = MPU_INIT_FIFO_RATE,
+	.gyro_fifo_enable = true,
+	.accl_fifo_enable = true,
+	.accl_fs = INV_FS_02G,
+};
+
+int mpu_write_reg(struct inv_mpu_state *st, int reg, u8 d)
+{
+	return i2c_smbus_write_i2c_block_data(st->client,
+					reg, 1, &d);
+}
+
+int inv_switch_engine(struct inv_mpu_state *st, bool en, u32 mask)
+{
+	const struct inv_reg_map_s *reg;
+	u8 data, mgmt_1;
+	int result;
+
+	reg = st->reg;
+	/* switch clock needs to be careful. Only when gyro is on, can
+	   clock source be switched to gyro. Otherwise, it must be set to
+	   internal clock */
+	if (MPU_BIT_PWR_GYRO_STBY == mask) {
+		result = i2c_smbus_read_i2c_block_data(st->client,
+					       reg->pwr_mgmt_1, 1, &mgmt_1);
+		if (result != 1)
+			return result;
+
+		mgmt_1 &= ~MPU_BIT_CLK_MASK;
+	}
+
+	if ((MPU_BIT_PWR_GYRO_STBY == mask) && (!en)) {
+		/* turning off gyro requires switch to internal clock first.
+		   Then turn off gyro engine */
+		mgmt_1 |= INV_CLK_INTERNAL;
+		result = mpu_write_reg(st, reg->pwr_mgmt_1, mgmt_1);
+		if (result)
+			return result;
+	}
+
+	result = i2c_smbus_read_i2c_block_data(st->client,
+					       reg->pwr_mgmt_2, 1, &data);
+	if (result != 1)
+		return result;
+	if (en)
+		data &= ~mask;
+	else
+		data |= mask;
+	result = mpu_write_reg(st, reg->pwr_mgmt_2, data);
+	if (result)
+		return result;
+
+	if ((MPU_BIT_PWR_GYRO_STBY == mask) && en) {
+		/* only gyro on needs sensor up time */
+		msleep(MPU_SENSOR_UP_TIME);
+		/* after gyro is on & stable, switch internal clock to PLL */
+		mgmt_1 |= INV_CLK_PLL;
+		result = mpu_write_reg(st, reg->pwr_mgmt_1, mgmt_1);
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
+
+int inv_set_power_itg(struct inv_mpu_state *st, bool power_on)
+{
+	const struct inv_reg_map_s *reg;
+	u8 data;
+	int result;
+
+	reg = st->reg;
+	if (power_on)
+		data = 0;
+	else
+		data = MPU_BIT_SLEEP;
+	result = mpu_write_reg(st, reg->pwr_mgmt_1, data);
+	if (result)
+		return result;
+
+	if (power_on)
+		msleep(MPU_REG_UP_TIME);
+
+	return 0;
+}
+
+/*
+ *  inv_init_config() - Initialize hardware, disable FIFO.
+ *
+ *  Initial configuration:
+ *  FSR: +/- 2000DPS
+ *  DLPF: 20Hz
+ *  FIFO rate: 50Hz
+ *  Clock source: Gyro PLL
+ */
+static int inv_init_config(struct iio_dev *indio_dev)
+{
+	const struct inv_reg_map_s *reg;
+	int result;
+	u8 d;
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+
+	reg = st->reg;
+	result = inv_set_power_itg(st, true);
+	if (result)
+		return result;
+	d = (INV_FSR_2000DPS << MPU_GYRO_CONFIG_FSR_SHIFT);
+	result = mpu_write_reg(st, reg->gyro_config, d);
+	if (result)
+		return result;
+
+	d = INV_FILTER_20HZ;
+	result = mpu_write_reg(st, reg->lpf, d);
+	if (result)
+		return result;
+
+	d = MPU_ONE_K_HZ / MPU_INIT_FIFO_RATE - 1;
+	result = mpu_write_reg(st, reg->sample_rate_div, d);
+	if (result)
+		return result;
+
+	d = (INV_FS_02G << MPU_ACCL_CONFIG_FSR_SHIFT);
+	result = mpu_write_reg(st, reg->accl_config, d);
+	if (result)
+		return result;
+
+	memcpy(&st->chip_config, &chip_config_6050,
+	       sizeof(struct inv_chip_config));
+	result = inv_set_power_itg(st, false);
+	if (result)
+		return result;
+
+	return 0;
+}
+
+/*
+ *  inv_temperature_show() - Read temperature data directly from registers.
+ *              the temperature is calculated by the following
+ *		formula:
+ *		temp_offset + q30_mult(temp << temp_shift, temp_scale).
+ *		q30_mult is defined as:
+ *		q30_mult(a, b) = (a * b) >> 30;
+ */
+static int inv_temperature_show(struct inv_mpu_state  *st, int *val)
+{
+	const struct inv_reg_map_s *reg;
+	int result;
+	s16 temp;
+	__be16 d;
+
+	reg = st->reg;
+	result = i2c_smbus_read_i2c_block_data(st->client,
+				       reg->temperature, 2, (u8 *)&d);
+	if (result != 2) {
+		dev_err(&st->client->adapter->dev, "%s failed %d\n", __func__,
+			result);
+		return -EINVAL;
+	}
+	temp = (s16)(be16_to_cpup(&d));
+	*val = temp;
+
+	return IIO_VAL_INT;
+}
+
+static int inv_sensor_show(struct inv_mpu_state  *st, int reg,
+				int axis, int *val)
+{
+	int ind, result;
+	__be16 d;
+
+	ind = (axis - IIO_MOD_X) * 2;
+	result = i2c_smbus_read_i2c_block_data(st->client, reg + ind,  2,
+						(u8 *)&d);
+	if (result != 2)
+		return -EINVAL;
+	*val = (short)be16_to_cpup(&d);
+
+	return IIO_VAL_INT;
+}
+
+static int mpu_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val,
+			      int *val2,
+			      long mask) {
+	struct inv_mpu_state  *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case 0:
+	{
+		int ret, result;
+
+		ret = IIO_VAL_INT;
+		result = 0;
+		mutex_lock(&indio_dev->mlock);
+		if (!st->chip_config.enable) {
+			result = inv_set_power_itg(st, true);
+			if (result)
+				goto error_read_raw;
+		}
+		/* when enable is on, power is already on */
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			ret =  inv_sensor_show(st, st->reg->raw_gyro,
+						chan->channel2, val);
+		case IIO_ACCEL:
+			ret = inv_sensor_show(st, st->reg->raw_accl,
+						chan->channel2, val);
+		case IIO_TEMP:
+			ret = inv_temperature_show(st, val);
+		default:
+			ret = -EINVAL;
+		}
+error_read_raw:
+		if (!st->chip_config.enable)
+			result |= inv_set_power_itg(st, false);
+		mutex_unlock(&indio_dev->mlock);
+		if (result)
+			return result;
+
+		return ret;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = gyro_scale_6050[st->chip_config.fsr];
+
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = accel_scale[st->chip_config.accl_fs];
+
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = MPU6050_TEMP_SCALE;
+
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MPU6050_TEMP_OFFSET;
+
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_write_fsr(struct inv_mpu_state *st, int fsr)
+{
+	const struct inv_reg_map_s *reg;
+	int result;
+	u8 d;
+
+	reg = st->reg;
+	if ((fsr < 0) || (fsr > MPU_MAX_GYRO_FS_PARAM))
+		return -EINVAL;
+	if (fsr == st->chip_config.fsr)
+		return 0;
+
+	d = (fsr << MPU_GYRO_CONFIG_FSR_SHIFT);
+	result = mpu_write_reg(st, reg->gyro_config, d);
+	if (result)
+		return result;
+	st->chip_config.fsr = fsr;
+
+	return 0;
+}
+
+static int inv_write_accel_fs(struct inv_mpu_state *st, int fs)
+{
+	int result;
+	const struct inv_reg_map_s *reg;
+	u8 d;
+
+	if (fs < 0 || fs > MPU_MAX_ACCL_FS_PARAM)
+		return -EINVAL;
+	if (fs == st->chip_config.accl_fs)
+		return 0;
+
+	reg = st->reg;
+	d = (fs << MPU_ACCL_CONFIG_FSR_SHIFT);
+	result = mpu_write_reg(st, reg->accl_config, d);
+	if (result)
+		return result;
+	st->chip_config.accl_fs = fs;
+
+	return 0;
+}
+
+static int mpu_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask) {
+	struct inv_mpu_state  *st = iio_priv(indio_dev);
+	int result;
+
+	mutex_lock(&indio_dev->mlock);
+	/* we should only update scale when the chip is disabled, i.e.,
+		not running */
+	if (st->chip_config.enable) {
+		result = -EBUSY;
+		goto error_write_raw;
+	}
+	result = inv_set_power_itg(st, true);
+	if (result)
+		goto error_write_raw;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			result = inv_write_fsr(st, val);
+			break;
+		case IIO_ACCEL:
+			result = inv_write_accel_fs(st, val);
+			break;
+		default:
+			result = -EINVAL;
+			break;
+		}
+	default:
+		result = -EINVAL;
+	}
+
+error_write_raw:
+	result |= inv_set_power_itg(st, false);
+	mutex_unlock(&indio_dev->mlock);
+
+	return result;
+}
+
+
+ /*  inv_set_lpf() - set low pass filer based on fifo rate.
+ *                  Based on the Nyquist principle, the sampling rate must
+ *                  exceed twice of the bandwidth of the signal, or there
+ *                  would be alising. This function basically search for the
+ *                  correct low pass parameters based on the fifo rate, e.g,
+ *                  sampling frequency.
+ */
+static int inv_set_lpf(struct inv_mpu_state *st, int rate)
+{
+	const int hz[] = {188, 98, 42, 20, 10, 5};
+	const int d[] = {INV_FILTER_188HZ, INV_FILTER_98HZ,
+			INV_FILTER_42HZ, INV_FILTER_20HZ,
+			INV_FILTER_10HZ, INV_FILTER_5HZ};
+	int i, h, result;
+	u8 data;
+	const struct inv_reg_map_s *reg;
+
+	reg = st->reg;
+	h = (rate >> 1);
+	i = 0;
+	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
+		i++;
+	data = d[i];
+	result = mpu_write_reg(st, reg->lpf, data);
+	if (result)
+		return result;
+	st->chip_config.lpf = data;
+
+	return 0;
+}
+
+/*
+ *  inv_fifo_rate_store() - Set fifo rate.
+ */
+static ssize_t inv_fifo_rate_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	s32 fifo_rate;
+	u8 data;
+	int result;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+	const struct inv_reg_map_s *reg;
+
+	if (kstrtoint(buf, 10, &fifo_rate))
+		return -EINVAL;
+	if ((fifo_rate < MPU_MIN_FIFO_RATE) || (fifo_rate > MPU_MAX_FIFO_RATE))
+		return -EINVAL;
+	if (fifo_rate == st->chip_config.fifo_rate)
+		return count;
+
+	mutex_lock(&indio_dev->mlock);
+	if (st->chip_config.enable) {
+		result = -EBUSY;
+		goto fifo_rate_fail;
+	}
+	result = inv_set_power_itg(st, true);
+	if (result)
+		goto fifo_rate_fail;
+	reg = st->reg;
+	data = MPU_ONE_K_HZ / fifo_rate - 1;
+	result = mpu_write_reg(st, reg->sample_rate_div, data);
+	if (result)
+		goto fifo_rate_fail;
+	st->chip_config.fifo_rate = fifo_rate;
+
+	result = inv_set_lpf(st, fifo_rate);
+	if (result)
+		goto fifo_rate_fail;
+
+fifo_rate_fail:
+	result |= inv_set_power_itg(st, false);
+	mutex_unlock(&indio_dev->mlock);
+	if (result)
+		return result;
+
+	return count;
+}
+
+/*
+ *  inv_fifo_rate_show() - Get the current sampling rate.
+ */
+static ssize_t inv_fifo_rate_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct inv_mpu_state *st = iio_priv(dev_get_drvdata(dev));
+
+	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
+}
+
+/*
+ * inv_attr_show() -  calling this function will show current
+ *                     parameters.
+ */
+static ssize_t inv_attr_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct inv_mpu_state *st = iio_priv(dev_get_drvdata(dev));
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	s8 *m;
+
+	switch (this_attr->address) {
+	case ATTR_GYRO_MATRIX:
+		m = st->plat_data.orientation;
+
+		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
+			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
+	case ATTR_ACCL_MATRIX:
+		m = st->plat_data.orientation;
+
+		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
+			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
+	default:
+		return -EPERM;
+	}
+}
+
+#define INV_MPU_CHAN(_type, _channel2, _index)                        \
+	{                                                             \
+		.type = _type,                                        \
+		.modified = 1,                                        \
+		.channel2 = _channel2,                                \
+		.info_mask =  IIO_CHAN_INFO_SCALE_SHARED_BIT          \
+				| IIO_CHAN_INFO_RAW_SEPARATE_BIT,     \
+		.scan_index = _index,                                 \
+		.scan_type = {                                        \
+				.sign = 's',                           \
+				.realbits = 16,                       \
+				.storagebits = 16,                    \
+				.shift = 0 ,                          \
+				.endianness = IIO_BE,                \
+			     },                                       \
+	}
+
+static const struct iio_chan_spec inv_mpu_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU_SCAN_TIMESTAMP),
+	/* Note that temperature should only appear in the raw format,
+	   not the final scan elements output. */
+	{
+		.type = IIO_TEMP,
+		.info_mask =  IIO_CHAN_INFO_RAW_SEPARATE_BIT
+				| IIO_CHAN_INFO_OFFSET_SEPARATE_BIT
+				| IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.scan_index = -1,
+	},
+	INV_MPU_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU_SCAN_GYRO_X),
+	INV_MPU_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU_SCAN_GYRO_Y),
+	INV_MPU_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU_SCAN_GYRO_Z),
+
+	INV_MPU_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU_SCAN_ACCL_X),
+	INV_MPU_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU_SCAN_ACCL_Y),
+	INV_MPU_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU_SCAN_ACCL_Z),
+};
+
+/*constant IIO attribute */
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
+	inv_fifo_rate_store);
+static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
+	ATTR_GYRO_MATRIX);
+static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
+	ATTR_ACCL_MATRIX);
+
+static struct attribute *inv_attributes[] = {
+	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,
+	&iio_dev_attr_in_accel_matrix.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group inv_attribute_group = {
+	.attrs = inv_attributes
+};
+
+static const struct iio_info mpu_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &mpu_read_raw,
+	.write_raw = &mpu_write_raw,
+	.attrs = &inv_attribute_group,
+};
+
+/*
+ *  inv_check_setup_chip() - check and setup chip.
+ */
+static int inv_check_and_setup_chip(struct inv_mpu_state *st,
+		const struct i2c_device_id *id)
+{
+	const struct inv_reg_map_s *reg;
+	int result;
+
+	st->chip_type = INV_MPU6050;
+	st->hw  = &hw_info[st->chip_type];
+	st->reg = &reg_set_6050;
+	reg     = st->reg;
+	/* reset to make sure previous state are not there */
+	result = mpu_write_reg(st, reg->pwr_mgmt_1, MPU_BIT_H_RESET);
+	if (result)
+		return result;
+	msleep(MPU_POWER_UP_TIME);
+	/* toggle power state. After reset, the sleep bit could be on
+		or off depending on the OTP settings. Toggling power would
+		make it in a definite state as well as making the hardware
+		state align with the software state */
+	result = inv_set_power_itg(st, false);
+	if (result)
+		return result;
+	result = inv_set_power_itg(st, true);
+	if (result)
+		return result;
+
+	/* turn off gyro engine at start up */
+	result = inv_switch_engine(st, false, MPU_BIT_PWR_ACCL_STBY);
+	if (result)
+		return result;
+	result = inv_switch_engine(st, false, MPU_BIT_PWR_GYRO_STBY);
+	if (result)
+		return result;
+
+	return 0;
+}
+
+/**
+ *  inv_mpu_probe() - probe function.
+ *  @client:          i2c client.
+ *  @id:              i2c device id.
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_mpu_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct inv_mpu_state *st;
+	struct iio_dev *indio_dev;
+	int result;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		result = -ENOSYS;
+		goto out_no_free;
+	}
+	indio_dev = iio_device_alloc(sizeof(*st));
+	if (indio_dev == NULL) {
+		result =  -ENOMEM;
+		goto out_no_free;
+	}
+	st = iio_priv(indio_dev);
+	st->client = client;
+	/* put cast here to avoid compilation warning */
+	st->plat_data =
+		*(struct mpu_platform_data *)dev_get_platdata(&client->dev);
+	/* power is turned on inside check chip type*/
+	result = inv_check_and_setup_chip(st, id);
+	if (result)
+		goto out_free;
+
+	result = inv_init_config(indio_dev);
+	if (result) {
+		dev_err(&client->dev,
+			"Could not initialize device.\n");
+		goto out_free;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->channels = inv_mpu_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
+
+	indio_dev->info = &mpu_info;
+	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
+
+	result = inv_mpu_configure_ring(indio_dev);
+	if (result) {
+		dev_err(&st->client->dev, "configure buffer fail %d\n",
+			result);
+		goto out_free;
+	}
+	result = inv_mpu_probe_trigger(indio_dev);
+	if (result) {
+		dev_err(&st->client->dev, "trigger probe fail %d\n", result);
+		goto out_unreg_ring;
+	}
+
+	INIT_KFIFO(st->timestamps);
+	spin_lock_init(&st->time_stamp_lock);
+	result = iio_device_register(indio_dev);
+	if (result) {
+		dev_err(&st->client->dev, "IIO register fail %d\n", result);
+		goto out_remove_trigger;
+	}
+
+	return 0;
+
+out_remove_trigger:
+	inv_mpu_remove_trigger(st);
+out_unreg_ring:
+	iio_triggered_buffer_cleanup(indio_dev);
+out_free:
+	iio_device_free(indio_dev);
+out_no_free:
+
+	return result;
+}
+
+static int inv_mpu_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	inv_mpu_remove_trigger(st);
+	iio_triggered_buffer_cleanup(indio_dev);
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+#ifdef CONFIG_PM_SLEEP
+
+static int inv_mpu_resume(struct device *dev)
+{
+	return inv_set_power_itg(
+		iio_priv(i2c_get_clientdata(to_i2c_client(dev))), true);
+}
+
+static int inv_mpu_suspend(struct device *dev)
+{
+	return inv_set_power_itg(
+		iio_priv(i2c_get_clientdata(to_i2c_client(dev))), false);
+}
+static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
+
+#define INV_MPU_PMOPS (&inv_mpu_pmops)
+#else
+#define INV_MPU_PMOPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
+/* device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct i2c_device_id inv_mpu_id[] = {
+	{"mpu6050", INV_MPU6050},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
+
+static struct i2c_driver inv_mpu_driver = {
+	.probe		=	inv_mpu_probe,
+	.remove		=	inv_mpu_remove,
+	.id_table	=	inv_mpu_id,
+	.driver = {
+		.owner	=	THIS_MODULE,
+		.name	=	"inv-mpu6050",
+		.pm     =       INV_MPU_PMOPS,
+	},
+};
+
+module_i2c_driver(inv_mpu_driver);
+
+MODULE_AUTHOR("Invensense Corporation");
+MODULE_DESCRIPTION("Invensense device driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
new file mode 100644
index 0000000..d5950de
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -0,0 +1,244 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+#include <linux/i2c.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/platform_data/invensense_mpu6050.h>
+
+/**
+ *  struct inv_reg_map_s - Notable slave registers.
+ *  @sample_rate_div:	Divider applied to gyro output rate.
+ *  @lpf:		Configures internal low pass filter.
+ *  @user_ctrl:		Enables/resets the FIFO.
+ *  @fifo_en:		Determines which data will appear in FIFO.
+ *  @gyro_config:	gyro config register.
+ *  @accl_config:	accel config register
+ *  @fifo_count_h:	Upper byte of FIFO count.
+ *  @fifo_r_w:		FIFO register.
+ *  @raw_gyro:		Address of first gyro register.
+ *  @raw_accl:		Address of first accel register.
+ *  @temperature:	temperature register
+ *  @int_enable:	Interrupt enable register.
+ *  @pwr_mgmt_1:	Controls chip's power state and clock source.
+ *  @pwr_mgmt_2:	Controls power state of individual sensors.
+ */
+struct inv_reg_map_s {
+	u8 sample_rate_div;
+	u8 lpf;
+	u8 user_ctrl;
+	u8 fifo_en;
+	u8 gyro_config;
+	u8 accl_config;
+	u8 fifo_count_h;
+	u8 fifo_r_w;
+	u8 raw_gyro;
+	u8 raw_accl;
+	u8 temperature;
+	u8 int_enable;
+	u8 pwr_mgmt_1;
+	u8 pwr_mgmt_2;
+};
+
+/*device enum */
+enum inv_devices {
+	INV_MPU6050,
+	INV_NUM_PARTS
+};
+
+/**
+ *  struct inv_hw_s - Other important hardware information.
+ *  @num_reg:	Number of registers on device.
+ *  @name:      name of the chip
+ */
+struct inv_hw_s {
+	u8 num_reg;
+	u8 *name;
+};
+
+/**
+ *  struct inv_chip_config_s - Cached chip configuration data.
+ *  @fsr:		Full scale range.
+ *  @lpf:		Digital low pass filter frequency.
+ *  @accl_fs:		accel full scale range.
+ *  @enable:		master enable state.
+ *  @accl_fifo_enable:	enable accel data output
+ *  @gyro_fifo_enable:	enable gyro data output
+ *  @fifo_rate:		FIFO update rate.
+ */
+struct inv_chip_config {
+	unsigned int fsr:2;
+	unsigned int lpf:3;
+	unsigned int accl_fs:2;
+	unsigned int enable:1;
+	unsigned int accl_fifo_enable:1;
+	unsigned int gyro_fifo_enable:1;
+	u16 fifo_rate;
+};
+
+/*
+ *  struct inv_mpu_state - Driver state variables.
+ *  @TIMESTAMP_FIFO_SIZE: fifo size for timestamp.
+ *  @trig:              IIO trigger.
+ *  @chip_config:	Cached attribute information.
+ *  @reg:		Map of important registers.
+ *  @hw:		Other hardware-specific information.
+ *  @chip_type:		chip type.
+ *  @time_stamp_lock:	spin lock to time stamp.
+ *  @client:		i2c client handle.
+ *  @plat_data:		platform data.
+ *  @timestamps:        kfifo queue to store time stamp.
+ */
+struct inv_mpu_state {
+#define TIMESTAMP_FIFO_SIZE 16
+	struct iio_trigger  *trig;
+	struct inv_chip_config chip_config;
+	const struct inv_reg_map_s *reg;
+	const struct inv_hw_s *hw;
+	enum   inv_devices chip_type;
+	spinlock_t time_stamp_lock;
+	struct i2c_client *client;
+	struct mpu_platform_data plat_data;
+	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
+};
+
+/*register and associated bit definition*/
+#define MPU_REG_SAMPLE_RATE_DIV     0x19
+#define MPU_REG_CONFIG              0x1A
+#define MPU_REG_GYRO_CONFIG         0x1B
+#define MPU_REG_ACCEL_CONFIG	    0x1C
+
+#define MPU_REG_FIFO_EN             0x23
+#define MPU_BIT_ACCEL_OUT                   0x08
+#define MPU_BITS_GYRO_OUT                   0x70
+
+#define MPU_REG_INT_ENABLE          0x38
+#define MPU_BIT_DATA_RDY_EN                 0x01
+#define MPU_BIT_DMP_INT_EN                  0x02
+
+#define MPU_REG_RAW_ACCEL           0x3B
+#define MPU_REG_TEMPERATURE         0x41
+#define MPU_REG_RAW_GYRO            0x43
+
+#define MPU_REG_USER_CTRL           0x6A
+#define MPU_BIT_FIFO_RST                    0x04
+#define MPU_BIT_DMP_RST                     0x08
+#define MPU_BIT_I2C_MST_EN                  0x20
+#define MPU_BIT_FIFO_EN                     0x40
+#define MPU_BIT_DMP_EN                      0x80
+
+#define MPU_REG_PWR_MGMT_1          0x6B
+#define MPU_BIT_H_RESET                     0x80
+#define MPU_BIT_SLEEP                       0x40
+#define MPU_BIT_CLK_MASK                    0x7
+
+#define MPU_REG_PWR_MGMT_2          0x6C
+#define MPU_BIT_PWR_ACCL_STBY               0x38
+#define MPU_BIT_PWR_GYRO_STBY               0x07
+
+#define MPU_REG_FIFO_COUNT_H        0x72
+#define MPU_REG_FIFO_R_W            0x74
+
+#define MPU_BYTES_PER_3AXIS_SENSOR   6
+#define MPU_FIFO_COUNT_BYTE          2
+#define MPU_FIFO_THRESHOLD           500
+#define MPU_POWER_UP_TIME            100
+#define MPU_SENSOR_UP_TIME           30
+#define MPU_REG_UP_TIME              5
+
+#define MPU6050_TEMP_OFFSET	 2462307L
+#define MPU6050_TEMP_SCALE       2977653L
+#define MPU_TEMP_SHIFT           16
+#define MPU_MAX_GYRO_FS_PARAM        3
+#define MPU_MAX_ACCL_FS_PARAM        3
+#define MPU_THREE_AXIS               3
+#define MPU_GYRO_CONFIG_FSR_SHIFT    3
+#define MPU_ACCL_CONFIG_FSR_SHIFT    3
+
+/* 6 + 6 round up and plus 8 */
+#define MPU_OUTPUT_DATA_SIZE         24
+
+/* init parameters */
+#define MPU_INIT_FIFO_RATE           50
+#define MPU_INIT_DUR_TIME           ((1000 / MPU_INIT_FIFO_RATE) *\
+					NSEC_PER_MSEC)
+#define MPU_TIME_STAMP_TOR                        5
+#define MPU_MAX_FIFO_RATE                         1000
+#define MPU_MIN_FIFO_RATE                         4
+#define MPU_ONE_K_HZ                              1000
+
+/* scan element definition */
+enum inv_mpu_scan {
+	INV_MPU_SCAN_ACCL_X,
+	INV_MPU_SCAN_ACCL_Y,
+	INV_MPU_SCAN_ACCL_Z,
+	INV_MPU_SCAN_GYRO_X,
+	INV_MPU_SCAN_GYRO_Y,
+	INV_MPU_SCAN_GYRO_Z,
+	INV_MPU_SCAN_TIMESTAMP,
+};
+
+enum inv_filter_e {
+	INV_FILTER_256HZ_NOLPF2 = 0,
+	INV_FILTER_188HZ,
+	INV_FILTER_98HZ,
+	INV_FILTER_42HZ,
+	INV_FILTER_20HZ,
+	INV_FILTER_10HZ,
+	INV_FILTER_5HZ,
+	INV_FILTER_2100HZ_NOLPF,
+	NUM_FILTER
+};
+
+/* IIO attribute address */
+enum MPU_IIO_ATTR_ADDR {
+	ATTR_GYRO_MATRIX,
+	ATTR_ACCL_MATRIX,
+};
+
+enum inv_accl_fs_e {
+	INV_FS_02G = 0,
+	INV_FS_04G,
+	INV_FS_08G,
+	INV_FS_16G,
+	NUM_ACCL_FSR
+};
+
+enum inv_fsr_e {
+	INV_FSR_250DPS = 0,
+	INV_FSR_500DPS,
+	INV_FSR_1000DPS,
+	INV_FSR_2000DPS,
+	NUM_FSR
+};
+
+enum inv_clock_sel_e {
+	INV_CLK_INTERNAL = 0,
+	INV_CLK_PLL,
+	NUM_CLK
+};
+
+int inv_mpu_configure_ring(struct iio_dev *indio_dev);
+int inv_mpu_probe_trigger(struct iio_dev *indio_dev);
+void inv_mpu_remove_trigger(struct inv_mpu_state *st);
+int inv_set_enable(struct iio_dev *indio_dev, bool enable);
+int inv_switch_engine(struct inv_mpu_state *st, bool en, u32 mask);
+int mpu_write_reg(struct inv_mpu_state *st, int reg, u8 val);
+int inv_set_power_itg(struct inv_mpu_state *st, bool power_on);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
new file mode 100644
index 0000000..3519e00
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -0,0 +1,278 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <linux/poll.h>
+#include "inv_mpu_iio.h"
+
+static void inv_scan_query(struct iio_dev *indio_dev)
+{
+	struct inv_mpu_state  *st = iio_priv(indio_dev);
+
+	st->chip_config.gyro_fifo_enable =
+		test_bit(INV_MPU_SCAN_GYRO_X, indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU_SCAN_GYRO_Y, indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU_SCAN_GYRO_Z, indio_dev->active_scan_mask);
+
+	st->chip_config.accl_fifo_enable =
+		test_bit(INV_MPU_SCAN_ACCL_X, indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU_SCAN_ACCL_Y, indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU_SCAN_ACCL_Z, indio_dev->active_scan_mask);
+}
+
+static int inv_reset_fifo(struct iio_dev *indio_dev)
+{
+	const struct inv_reg_map_s *reg;
+	int result;
+	u8 d;
+	struct inv_mpu_state  *st = iio_priv(indio_dev);
+
+	reg = st->reg;
+	/* disable interrupt */
+	result = mpu_write_reg(st, reg->int_enable, 0);
+	if (result) {
+		dev_err(&st->client->dev, "int_enable failed %d\n", result);
+		return result;
+	}
+	/* disable the sensor output to FIFO */
+	result = mpu_write_reg(st, reg->fifo_en, 0);
+	if (result)
+		goto reset_fifo_fail;
+	/* disable fifo reading */
+	result = mpu_write_reg(st, reg->user_ctrl, 0);
+	if (result)
+		goto reset_fifo_fail;
+
+	/* reset FIFO*/
+	result = mpu_write_reg(st, reg->user_ctrl, MPU_BIT_FIFO_RST);
+	if (result)
+		goto reset_fifo_fail;
+	/* enable interrupt */
+	if (st->chip_config.accl_fifo_enable ||
+	    st->chip_config.gyro_fifo_enable) {
+		result = mpu_write_reg(st, reg->int_enable,
+					MPU_BIT_DATA_RDY_EN);
+		if (result)
+			return result;
+	}
+	/* enable FIFO reading and I2C master interface*/
+	result = mpu_write_reg(st, reg->user_ctrl, MPU_BIT_FIFO_EN);
+	if (result)
+		goto reset_fifo_fail;
+	/* enable sensor output to FIFO */
+	d = 0;
+	if (st->chip_config.gyro_fifo_enable)
+		d |= MPU_BITS_GYRO_OUT;
+	if (st->chip_config.accl_fifo_enable)
+		d |= MPU_BIT_ACCEL_OUT;
+	result = mpu_write_reg(st, reg->fifo_en, d);
+	if (result)
+		goto reset_fifo_fail;
+
+	return 0;
+
+reset_fifo_fail:
+	dev_err(&st->client->dev, "reset fifo failed %d\n", result);
+	result = mpu_write_reg(st, reg->int_enable, MPU_BIT_DATA_RDY_EN);
+
+	return result;
+}
+
+/**
+ *  inv_set_enable() - enable chip functions.
+ *  @indio_dev:	Device driver instance.
+ *  @enable: enable/disable
+ */
+int inv_set_enable(struct iio_dev *indio_dev, bool enable)
+{
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+	const struct inv_reg_map_s *reg;
+	int result;
+	u8 d;
+
+	reg = st->reg;
+	if (enable) {
+		result = inv_set_power_itg(st, true);
+		if (result)
+			return result;
+		inv_scan_query(indio_dev);
+		if (st->chip_config.gyro_fifo_enable) {
+			result = inv_switch_engine(st, true,
+					MPU_BIT_PWR_GYRO_STBY);
+			if (result)
+				return result;
+		}
+		if (st->chip_config.accl_fifo_enable) {
+			result = inv_switch_engine(st, true,
+					MPU_BIT_PWR_ACCL_STBY);
+			if (result)
+				return result;
+		}
+		result = inv_reset_fifo(indio_dev);
+		if (result)
+			return result;
+	} else {
+		d = 0;
+		result = mpu_write_reg(st, reg->fifo_en, d);
+		if (result)
+			return result;
+
+		result = mpu_write_reg(st, reg->int_enable, d);
+		if (result)
+			return result;
+
+		result = mpu_write_reg(st, reg->user_ctrl, d);
+		if (result)
+			return result;
+
+		result = inv_switch_engine(st, false, MPU_BIT_PWR_GYRO_STBY);
+		if (result)
+			return result;
+
+		result = inv_switch_engine(st, false, MPU_BIT_PWR_ACCL_STBY);
+		if (result)
+			return result;
+		result = inv_set_power_itg(st, false);
+		if (result)
+			return result;
+	}
+	st->chip_config.enable = enable;
+
+	return 0;
+}
+
+static void inv_clear_kfifo(struct inv_mpu_state *st)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&st->time_stamp_lock, flags);
+	kfifo_reset(&st->timestamps);
+	spin_unlock_irqrestore(&st->time_stamp_lock, flags);
+}
+
+/*
+ *  inv_irq_handler() - Cache a timestamp at each data ready interrupt.
+ */
+static irqreturn_t inv_irq_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+	s64 timestamp;
+
+	timestamp = iio_get_time_ns();
+	spin_lock(&st->time_stamp_lock);
+	kfifo_in(&st->timestamps, &timestamp, 1);
+	spin_unlock(&st->time_stamp_lock);
+
+	return IRQ_WAKE_THREAD;
+}
+
+/*
+ *  inv_read_fifo() - Transfer data from hardware FIFO to KFIFO.
+ */
+static irqreturn_t inv_read_fifo(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+	size_t bytes_per_datum;
+	int result;
+	u8 data[MPU_OUTPUT_DATA_SIZE];
+	u16 fifo_count;
+	s64 timestamp;
+	u64 *tmp;
+	const struct inv_reg_map_s *reg;
+
+	reg = st->reg;
+	mutex_lock(&indio_dev->mlock);
+	if (!(st->chip_config.accl_fifo_enable |
+		st->chip_config.gyro_fifo_enable))
+		goto end_session;
+	bytes_per_datum = 0;
+	if (st->chip_config.accl_fifo_enable)
+		bytes_per_datum += MPU_BYTES_PER_3AXIS_SENSOR;
+
+	if (st->chip_config.gyro_fifo_enable)
+		bytes_per_datum += MPU_BYTES_PER_3AXIS_SENSOR;
+
+	/* read fifo_count register to know how many bytes inside FIFO
+	   right now */
+	result = i2c_smbus_read_i2c_block_data(st->client,
+					       reg->fifo_count_h,
+					       MPU_FIFO_COUNT_BYTE, data);
+	if (result != MPU_FIFO_COUNT_BYTE)
+		goto end_session;
+	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
+	if (fifo_count < bytes_per_datum)
+		goto end_session;
+	/* fifo count can't be odd number, if it is odd, reset fifo*/
+	if (fifo_count & 1)
+		goto flush_fifo;
+	if (fifo_count >  MPU_FIFO_THRESHOLD)
+		goto flush_fifo;
+	/* Timestamp mismatch. */
+	if (kfifo_len(&st->timestamps) >
+		fifo_count / bytes_per_datum + MPU_TIME_STAMP_TOR)
+			goto flush_fifo;
+	while (fifo_count >= bytes_per_datum) {
+		result = i2c_smbus_read_i2c_block_data(st->client,
+						       reg->fifo_r_w,
+						       bytes_per_datum, data);
+		if (result != bytes_per_datum)
+			goto flush_fifo;
+
+		result = kfifo_out(&st->timestamps, &timestamp, 1);
+		/* when there is no timestamp, put timestamp as 0 */
+		if (0 == result)
+			timestamp = 0;
+
+		tmp = (u64 *)data;
+		tmp[DIV_ROUND_UP(bytes_per_datum, 8)] = timestamp;
+		iio_push_to_buffers(indio_dev, data);
+		fifo_count -= bytes_per_datum;
+	}
+
+end_session:
+	mutex_unlock(&indio_dev->mlock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+
+flush_fifo:
+	/* Flush HW and SW FIFOs. */
+	inv_reset_fifo(indio_dev);
+	inv_clear_kfifo(st);
+	mutex_unlock(&indio_dev->mlock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+int inv_mpu_configure_ring(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev,
+					inv_irq_handler,
+					inv_read_fifo,
+					NULL);
+}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
new file mode 100644
index 0000000..a2fe010
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -0,0 +1,72 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+#include "inv_mpu_iio.h"
+
+/*
+ * inv_mpu_data_rdy_trigger_set_state() set data ready interrupt state
+ */
+static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	return inv_set_enable(trig->private_data, state);
+}
+
+static const struct iio_trigger_ops inv_mpu_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
+};
+
+int inv_mpu_probe_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct inv_mpu_state *st = iio_priv(indio_dev);
+
+	st->trig = iio_trigger_alloc("%s-dev%d",
+					indio_dev->name,
+					indio_dev->id);
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = request_irq(st->client->irq, &iio_trigger_generic_data_rdy_poll,
+				IRQF_TRIGGER_RISING,
+				"inv_mpu",
+				st->trig);
+	if (ret)
+		goto error_free_trig;
+	st->trig->dev.parent = &st->client->dev;
+	st->trig->private_data = indio_dev;
+	st->trig->ops = &inv_mpu_trigger_ops;
+	ret = iio_trigger_register(st->trig);
+	if (ret)
+		goto error_free_irq;
+	indio_dev->trig = st->trig;
+
+	return 0;
+
+error_free_irq:
+	free_irq(st->client->irq, st->trig);
+error_free_trig:
+	iio_trigger_free(st->trig);
+error_ret:
+	return ret;
+	return 0;
+}
+
+void inv_mpu_remove_trigger(struct inv_mpu_state *st)
+{
+	iio_trigger_unregister(st->trig);
+	iio_trigger_free(st->trig);
+}
diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
new file mode 100644
index 0000000..6a368c1
--- /dev/null
+++ b/include/linux/platform_data/invensense_mpu6050.h
@@ -0,0 +1,32 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+#ifndef __MPU_H_
+#define __MPU_H_
+
+/**
+ * struct mpu_platform_data - Platform data for the mpu driver
+ * @orientation:	Orientation matrix of the chip
+ *
+ * Contains platform specific information on how to configure the MPU6050 to
+ * work on this platform.  The orientation matricies are 3x3 rotation matricies
+ * that are applied to the data to rotate from the mounting orientation to the
+ * platform orientation.  The values must be one of 0, 1, or -1 and each row and
+ * column should have exactly 1 non-zero value.
+ */
+struct mpu_platform_data {
+	__s8 orientation[9];
+};
+
+#endif	/* __MPU_H_ */
-- 
1.7.0.4
