Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:53384 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753099AbcLHPCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Dec 2016 10:02:22 -0500
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 6/6] iio: bmi160: Support hardware fifo
Date: Thu,  8 Dec 2016 15:22:59 +0100
Message-Id: <20161208142259.26230-7-m.niestroj@grinn-global.com>
In-Reply-To: <20161208142259.26230-1-m.niestroj@grinn-global.com>
References: <20161208142259.26230-1-m.niestroj@grinn-global.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch was developed primarily based on bmc150_accel hardware fifo
implementation.

IRQ handler was added, which for now is responsible only for handling
watermark interrupts. The BMI160 chip has two interrupt outputs. By
default INT is considered to be connected. If INT2 is used instead, the
interrupt-names device-tree property can be used to specify that.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
Depends on patch 4 in series

Changes v1 -> v2:
 * add __ prefix to all functions that should be called with mutex held
   (suggested by Peter)
 * get rid of non-constant array size (suggested by Peter)
 * disable irq on init failure and module removal (suggested by Peter)
 * make bmi160_buffer_predisable() the reverse order of the
   bmi160_buffer_postenable() (suggested by Jonathan)
 * remove realignment for iio_info structs (suggested by Jonathan)

 drivers/iio/imu/bmi160/bmi160.h      |   3 +-
 drivers/iio/imu/bmi160/bmi160_core.c | 618 ++++++++++++++++++++++++++++++++++-
 drivers/iio/imu/bmi160/bmi160_i2c.c  |   7 +-
 drivers/iio/imu/bmi160/bmi160_spi.c  |   3 +-
 4 files changed, 613 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index d2ae6ed..4a7c10e 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -4,7 +4,8 @@
 extern const struct regmap_config bmi160_regmap_config;
 
 int bmi160_core_probe(struct device *dev, struct regmap *regmap,
-		      const char *name, bool use_spi);
+		      const char *name, int irq,
+		      bool use_spi, bool block_supported);
 void bmi160_core_remove(struct device *dev);
 
 #endif  /* BMI160_H_ */
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 88bcf3f..26404b4 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -10,7 +10,7 @@
  *
  * IIO core driver for BMI160, with support for I2C/SPI busses
  *
- * TODO: magnetometer, interrupts, hardware FIFO
+ * TODO: magnetometer, interrupts
  */
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -23,8 +23,12 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
 
+#include <linux/of_irq.h>
+
 #include "bmi160.h"
 
+#define BMI160_IRQ_NAME		"bmi160_event"
+
 #define BMI160_REG_CHIP_ID	0x00
 #define BMI160_CHIP_ID_VAL	0xD1
 
@@ -35,6 +39,21 @@
 #define BMI160_REG_DATA_GYRO_XOUT_L	0x0C
 #define BMI160_REG_DATA_ACCEL_XOUT_L	0x12
 
+#define BMI160_REG_STATUS		0x1B
+#define BMI160_STATUS_MAG_MAN_OP	BIT(2)
+
+#define BMI160_REG_INT_STATUS0		0x1C
+
+#define BMI160_REG_INT_STATUS1		0x1D
+#define BMI160_INT_STATUS_FWM		BIT(6)
+
+#define BMI160_REG_INT_STATUS2		0x1E
+
+#define BMI160_REG_INT_STATUS3		0x1F
+
+#define BMI160_REG_FIFO_LENGTH		0x22
+#define BMI160_REG_FIFO_DATA		0x24
+
 #define BMI160_REG_ACCEL_CONFIG		0x40
 #define BMI160_ACCEL_CONFIG_ODR_MASK	GENMASK(3, 0)
 #define BMI160_ACCEL_CONFIG_BWP_MASK	GENMASK(6, 4)
@@ -56,6 +75,36 @@
 #define BMI160_GYRO_RANGE_250DPS	0x03
 #define BMI160_GYRO_RANGE_125DPS	0x04
 
+#define BMI160_REG_FIFO_CONFIG_0	0x46
+
+#define BMI160_REG_FIFO_CONFIG_1	0x47
+#define BMI160_FIFO_GYRO_EN		BIT(7)
+#define BMI160_FIFO_ACCEL_EN		BIT(6)
+#define BMI160_FIFO_MAGN_EN		BIT(5)
+#define BMI160_FIFO_HEADER_EN		BIT(4)
+#define BMI160_FIFO_TAG_INT1_EN		BIT(3)
+#define BMI160_FIFO_TAG_INT2_EN		BIT(2)
+#define BMI160_FIFO_TIME_EN		BIT(1)
+
+#define BMI160_REG_INT_EN_1		0x51
+#define BMI160_INT_FWM_EN		BIT(6)
+#define BMI160_INT_FFULL_EN		BIT(5)
+#define BMI160_INT_DRDY_EN		BIT(4)
+
+#define BMI160_REG_INT_OUT_CTRL		0x53
+#define BMI160_INT2_OUTPUT_EN		BIT(7)
+#define BMI160_INT1_OUTPUT_EN		BIT(3)
+
+#define BMI160_REG_INT_LATCH		0x54
+
+#define BMI160_REG_INT_MAP_1		0x56
+#define BMI160_INT1_MAP_DRDY		BIT(7)
+#define BMI160_INT1_MAP_FWM		BIT(6)
+#define BMI160_INT1_MAP_FFULL		BIT(5)
+#define BMI160_INT2_MAP_DRDY		BIT(3)
+#define BMI160_INT2_MAP_FWM		BIT(2)
+#define BMI160_INT2_MAP_FFULL		BIT(1)
+
 #define BMI160_REG_CMD			0x7E
 #define BMI160_CMD_ACCEL_PM_SUSPEND	0x10
 #define BMI160_CMD_ACCEL_PM_NORMAL	0x11
@@ -67,6 +116,8 @@
 
 #define BMI160_REG_DUMMY		0x7F
 
+#define BMI160_FIFO_LENGTH		1024
+
 #define BMI160_ACCEL_PMU_MIN_USLEEP	3800
 #define BMI160_GYRO_PMU_MIN_USLEEP	80000
 #define BMI160_SOFTRESET_USLEEP		1000
@@ -109,9 +160,34 @@ enum bmi160_sensor_type {
 	BMI160_NUM_SENSORS /* must be last */
 };
 
+struct bmi160_irq_data {
+	unsigned int map_fwm;
+	unsigned int output_en;
+};
+
+static const struct bmi160_irq_data bmi160_irq1_data = {
+	.map_fwm = BMI160_INT1_MAP_FWM,
+	.output_en = BMI160_INT1_OUTPUT_EN,
+};
+
+static const struct bmi160_irq_data bmi160_irq2_data = {
+	.map_fwm = BMI160_INT2_MAP_FWM,
+	.output_en = BMI160_INT2_OUTPUT_EN,
+};
+
 struct bmi160_data {
 	struct regmap *regmap;
 	struct mutex mutex;
+	const struct bmi160_irq_data *irq_data;
+	int irq;
+	bool irq_enabled;
+	int64_t timestamp;
+	int64_t fifo_sample_period;
+	bool fifo_enabled;
+	unsigned int fifo_config;
+	unsigned int fifo_sample_size;
+	u8 *fifo_buffer;
+	unsigned int watermark;
 };
 
 const struct regmap_config bmi160_regmap_config = {
@@ -374,16 +450,20 @@ int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
 	return ret;
 }
 
-static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
-			  int *odr, int *uodr)
+static int64_t bmi160_frequency_to_period(int odr, int uodr)
 {
-	int i, val, ret;
+	uint64_t period = 1000000000000000;
+	int64_t frequency = (int64_t) odr * 1000000 + uodr;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
-	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
+	do_div(period, frequency);
+
+	return period;
+}
+
+static const struct bmi160_odr *bmi160_reg_to_odr(enum bmi160_sensor_type t,
+						unsigned int val)
+{
+	int i;
 
 	val &= bmi160_regs[t].config_odr_mask;
 
@@ -392,10 +472,52 @@ static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
 			break;
 
 	if (i >= bmi160_odr_table[t].num)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
-	*odr = bmi160_odr_table[t].tbl[i].odr;
-	*uodr = bmi160_odr_table[t].tbl[i].uodr;
+	return &bmi160_odr_table[t].tbl[i];
+}
+
+static int __bmi160_get_sample_period(struct bmi160_data *data,
+				enum bmi160_sensor_type t,
+				int64_t *sample_period)
+{
+	const struct bmi160_odr *odr_entry;
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
+	if (ret < 0)
+		return ret;
+
+	odr_entry = bmi160_reg_to_odr(t, val);
+	if (IS_ERR(odr_entry))
+		return PTR_ERR(odr_entry);
+
+	*sample_period = bmi160_frequency_to_period(odr_entry->odr,
+						odr_entry->uodr);
+
+	return 0;
+}
+
+static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
+			  int *odr, int *uodr)
+{
+	const struct bmi160_odr *odr_entry;
+	int ret;
+	unsigned int val;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
+	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		return ret;
+
+	odr_entry = bmi160_reg_to_odr(t, val);
+	if (IS_ERR(odr_entry))
+		return PTR_ERR(odr_entry);
+
+	*odr = odr_entry->odr;
+	*uodr = odr_entry->uodr;
 
 	return 0;
 }
@@ -504,6 +626,356 @@ static const struct attribute_group bmi160_attrs_group = {
 	.attrs = bmi160_attrs,
 };
 
+static int __bmi160_read_sample_period(struct bmi160_data *data,
+				enum bmi160_sensor_type sensor_type)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int64_t uninitialized_var(sample_period);
+	int ret;
+
+	ret = __bmi160_get_sample_period(data, sensor_type, &sample_period);
+	if (ret < 0)
+		return ret;
+
+	if (data->fifo_sample_period) {
+		if (data->fifo_sample_period != sample_period) {
+			dev_warn(dev, "Enabled sensors have unequal ODR values\n");
+			return -EINVAL;
+		}
+	} else {
+		data->fifo_sample_period = sample_period;
+	}
+
+	return 0;
+}
+
+static int __bmi160_fifo_enable(struct iio_dev *indio_dev,
+			struct bmi160_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	int ret;
+	int i;
+	unsigned int val;
+	unsigned int fifo_config = 0;
+
+	/* Set fifo sample size and period */
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+			indio_dev->masklength) {
+		if (i <= BMI160_SCAN_GYRO_Z)
+			fifo_config |= BMI160_FIFO_GYRO_EN;
+		else if (i <= BMI160_SCAN_ACCEL_Z)
+			fifo_config |= BMI160_FIFO_ACCEL_EN;
+	}
+
+	data->fifo_sample_period = 0;
+	data->fifo_sample_size = 0;
+	if (fifo_config & BMI160_FIFO_GYRO_EN) {
+		data->fifo_sample_size += 6;
+		ret = __bmi160_read_sample_period(data, BMI160_GYRO);
+		if (ret < 0)
+			return ret;
+	}
+	if (fifo_config & BMI160_FIFO_ACCEL_EN) {
+		data->fifo_sample_size += 6;
+		ret = __bmi160_read_sample_period(data, BMI160_ACCEL);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * Set watermark level and write real value back, as it will be used
+	 * in timestamp calculation.
+	 */
+	val = data->watermark * data->fifo_sample_size;
+	if (val > BMI160_FIFO_LENGTH - 1) {
+		val = BMI160_FIFO_LENGTH - 1;
+		data->watermark = val / data->fifo_sample_size;
+	}
+	val = data->watermark * data->fifo_sample_size / 4;
+
+	ret = regmap_write(regmap, BMI160_REG_FIFO_CONFIG_0, val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set watermark\n");
+		return ret;
+	}
+
+	/* Enable FIFO channels */
+	ret = regmap_write(regmap, BMI160_REG_FIFO_CONFIG_1,
+			fifo_config);
+	if (ret < 0) {
+		dev_err(dev, "Failed to write FIFO_CONFIG_1\n");
+		return ret;
+	}
+
+	data->fifo_config = fifo_config;
+	data->fifo_enabled = true;
+
+	return 0;
+}
+
+static int __bmi160_fifo_disable(struct bmi160_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	int ret;
+
+	/* Disable all FIFO channels */
+	ret = regmap_write(regmap, BMI160_REG_FIFO_CONFIG_1, 0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to write FIFO_CONFIG_1\n");
+		return ret;
+	}
+
+	data->fifo_enabled = false;
+
+	return 0;
+}
+
+static int bmi160_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		return iio_triggered_buffer_postenable(indio_dev);
+
+	mutex_lock(&data->mutex);
+	ret = __bmi160_fifo_enable(indio_dev, data);
+	if (ret < 0)
+		goto unlock;
+
+	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_MAP_1,
+			data->irq_data->map_fwm, data->irq_data->map_fwm);
+	if (ret < 0)
+		goto unlock;
+
+	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_EN_1,
+				BMI160_INT_FWM_EN, BMI160_INT_FWM_EN);
+
+unlock:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bmi160_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	int ret = 0;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		return iio_triggered_buffer_predisable(indio_dev);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(regmap, BMI160_REG_INT_EN_1,
+				BMI160_INT_FWM_EN, 0);
+	if (ret < 0)
+		goto unlock;
+
+	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_MAP_1,
+				data->irq_data->map_fwm, 0);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __bmi160_fifo_disable(data);
+
+unlock:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops bmi160_buffer_ops = {
+	.postenable = bmi160_buffer_postenable,
+	.predisable = bmi160_buffer_predisable,
+};
+
+static ssize_t bmi160_get_fifo_state(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi160_data *data = iio_priv(indio_dev);
+	bool state;
+
+	mutex_lock(&data->mutex);
+	state = data->fifo_enabled;
+	mutex_unlock(&data->mutex);
+
+	return sprintf(buf, "%d\n", (int) state);
+}
+
+static ssize_t bmi160_get_fifo_watermark(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi160_data *data = iio_priv(indio_dev);
+	int wm;
+
+	mutex_lock(&data->mutex);
+	wm = data->watermark;
+	mutex_unlock(&data->mutex);
+
+	return sprintf(buf, "%d\n", wm);
+}
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_CONST_ATTR(hwfifo_watermark_max,
+		      __stringify(BMI160_FIFO_LENGTH));
+static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
+		       bmi160_get_fifo_state, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
+		       bmi160_get_fifo_watermark, NULL, 0);
+
+static const struct attribute *bmi160_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int bmi160_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+
+	if (val > BMI160_FIFO_LENGTH)
+		val = BMI160_FIFO_LENGTH;
+
+	mutex_lock(&data->mutex);
+	data->watermark = val;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int __bmi160_fifo_transfer(struct bmi160_data *data,
+				char *buffer, int num_bytes)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	size_t step = regmap_get_raw_read_max(regmap);
+	int ret = 0;
+	int i;
+
+	if (!step || step > num_bytes)
+		step = num_bytes;
+	else if (step < num_bytes)
+		step = data->fifo_sample_size;
+
+	for (i = 0; i < num_bytes; i += step) {
+		ret = regmap_raw_read(regmap, BMI160_REG_FIFO_DATA,
+				&buffer[i], step);
+
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		dev_err(dev,
+			"Error transferring data from fifo in single steps of %zu\n",
+			step);
+
+	return ret;
+}
+
+static int __bmi160_fifo_flush(struct iio_dev *indio_dev,
+			unsigned int samples, bool irq)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	int ret;
+	__le16 fifo_length;
+	unsigned int fifo_samples;
+	unsigned int fifo_bytes;
+	u8 *buffer = data->fifo_buffer;
+	u8 *buffer_iter;
+	int64_t last_timestamp, timestamp;
+	unsigned int last_samples;
+	unsigned int i;
+
+	/* Get the current FIFO length */
+	ret = regmap_bulk_read(regmap, BMI160_REG_FIFO_LENGTH,
+			&fifo_length, sizeof(__le16));
+	if (ret < 0) {
+		dev_err(dev, "Error reading FIFO_LENGTH\n");
+		return ret;
+	}
+
+	fifo_bytes = le16_to_cpu(fifo_length);
+	fifo_samples = fifo_bytes / data->fifo_sample_size;
+
+	if (fifo_bytes % data->fifo_sample_size)
+		dev_warn(dev, "fifo_bytes %u is not dividable by %u\n",
+			fifo_bytes, data->fifo_sample_size);
+
+	if (!fifo_samples)
+		return 0;
+
+	if (samples && fifo_samples > samples) {
+		fifo_samples = samples;
+		fifo_bytes = fifo_samples * data->fifo_sample_size;
+	}
+
+	/*
+	 * If we are not called from IRQ, it means that we are flushing data
+	 * on demand. In that case we do not have latest timestamp saved in
+	 * data->timestamp. Get the time now instead.
+	 *
+	 * In case of IRQ flush, saved timestamp shows the time when number
+	 * of samples configured by watermark were ready. Currently there might
+	 * be more samples already.
+	 * If we are not called from IRQ, than we are getting the current fifo
+	 * length, as we are setting timestamp just after getting it.
+	 */
+	if (!irq) {
+		last_timestamp = iio_get_time_ns(indio_dev);
+		last_samples = fifo_samples;
+	} else {
+		last_timestamp = data->timestamp;
+		last_samples = data->watermark;
+	}
+
+	/* Get all measurements */
+	ret = __bmi160_fifo_transfer(data, buffer, fifo_bytes);
+	if (ret)
+		return ret;
+
+	/* Handle demux */
+	timestamp = last_timestamp - (last_samples * data->fifo_sample_period);
+	buffer_iter = buffer;
+	for (i = 0; i < fifo_samples; i++) {
+		u8 tmp_buf[32];
+
+		memcpy(tmp_buf, buffer_iter, data->fifo_sample_size);
+
+		timestamp += data->fifo_sample_period;
+		iio_push_to_buffers_with_timestamp(indio_dev,
+						tmp_buf,
+						timestamp);
+
+		buffer_iter += data->fifo_sample_size;
+	}
+
+	return fifo_samples;
+}
+
+static int bmi160_fifo_flush(struct iio_dev *indio_dev, unsigned int samples)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = __bmi160_fifo_flush(indio_dev, samples, false);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
 static const struct iio_info bmi160_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = bmi160_read_raw,
@@ -511,6 +983,15 @@ static const struct iio_info bmi160_info = {
 	.attrs = &bmi160_attrs_group,
 };
 
+static const struct iio_info bmi160_info_fifo = {
+	.driver_module = THIS_MODULE,
+	.read_raw = bmi160_read_raw,
+	.write_raw = bmi160_write_raw,
+	.attrs = &bmi160_attrs_group,
+	.hwfifo_set_watermark = bmi160_set_watermark,
+	.hwfifo_flush_to_buffer = bmi160_fifo_flush,
+};
+
 static const char *bmi160_match_acpi_device(struct device *dev)
 {
 	const struct acpi_device_id *id;
@@ -572,12 +1053,75 @@ static void bmi160_chip_uninit(struct bmi160_data *data)
 	bmi160_set_mode(data, BMI160_ACCEL, false);
 }
 
+static int bmi160_enable_irq(struct bmi160_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_OUT_CTRL,
+				data->irq_data->output_en,
+				data->irq_data->output_en);
+	mutex_unlock(&data->mutex);
+
+	if (ret == 0)
+		data->irq_enabled = true;
+
+	return ret;
+}
+
+static int bmi160_disable_irq(struct bmi160_data *data)
+{
+	int ret;
+
+	if (!data->irq_enabled)
+		return 0;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, BMI160_REG_INT_OUT_CTRL,
+				data->irq_data->output_en, 0);
+	mutex_unlock(&data->mutex);
+
+	if (ret == 0)
+		data->irq_enabled = false;
+
+	return ret;
+}
+
+static irqreturn_t bmi160_irq_thread_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct bmi160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	mutex_lock(&data->mutex);
+	if (data->fifo_enabled)
+		__bmi160_fifo_flush(indio_dev, BMI160_FIFO_LENGTH, true);
+	else
+		dev_warn(dev,
+			"IRQ has been triggered, but FIFO is not enabled.\n");
+	mutex_unlock(&data->mutex);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bmi160_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct bmi160_data *data = iio_priv(indio_dev);
+
+	data->timestamp = iio_get_time_ns(indio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
 int bmi160_core_probe(struct device *dev, struct regmap *regmap,
-		      const char *name, bool use_spi)
+		const char *name, int irq,
+		bool use_spi, bool block_supported)
 {
 	struct iio_dev *indio_dev;
 	struct bmi160_data *data;
 	int ret;
+	int irq2;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -585,6 +1129,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
+	data->irq = irq;
 	data->regmap = regmap;
 	mutex_init(&data->mutex);
 
@@ -603,15 +1148,57 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->info = &bmi160_info;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 bmi160_trigger_handler, NULL);
+					 bmi160_trigger_handler,
+					 &bmi160_buffer_ops);
 	if (ret < 0)
 		goto uninit;
 
+	if (data->irq > 0) {
+		/* Check which interrupt pin is connected to our board */
+		irq2 = of_irq_get_byname(dev->of_node, "INT2");
+		if (irq2 == data->irq) {
+			dev_dbg(dev, "Using interrupt line INT2\n");
+			data->irq_data = &bmi160_irq2_data;
+		} else {
+			dev_dbg(dev, "Using interrupt line INT1\n");
+			data->irq_data = &bmi160_irq1_data;
+		}
+
+		ret = devm_request_threaded_irq(dev,
+						data->irq,
+						bmi160_irq_handler,
+						bmi160_irq_thread_handler,
+						IRQF_ONESHOT,
+						BMI160_IRQ_NAME,
+						indio_dev);
+		if (ret)
+			goto buffer_cleanup;
+
+		ret = bmi160_enable_irq(data);
+		if (ret < 0)
+			goto buffer_cleanup;
+
+		if (block_supported) {
+			indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+			indio_dev->info = &bmi160_info_fifo;
+			indio_dev->buffer->attrs = bmi160_fifo_attributes;
+			data->fifo_buffer = devm_kmalloc(dev,
+							BMI160_FIFO_LENGTH,
+							GFP_KERNEL);
+			if (!data->fifo_buffer) {
+				ret = -ENOMEM;
+				goto disable_irq;
+			}
+		}
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto disable_irq;
 
 	return 0;
+disable_irq:
+	bmi160_disable_irq(data);
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 uninit:
@@ -626,6 +1213,7 @@ void bmi160_core_remove(struct device *dev)
 	struct bmi160_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	bmi160_disable_irq(data);
 	iio_triggered_buffer_cleanup(indio_dev);
 	bmi160_chip_uninit(data);
 }
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 155a31f..1a3f4e1 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -24,6 +24,10 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 {
 	struct regmap *regmap;
 	const char *name = NULL;
+	bool block_supported =
+		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
+		i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
 
 	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -35,7 +39,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 	if (id)
 		name = id->name;
 
-	return bmi160_core_probe(&client->dev, regmap, name, false);
+	return bmi160_core_probe(&client->dev, regmap, name, client->irq,
+				false, block_supported);
 }
 
 static int bmi160_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index d34dfdf..5a53225 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -26,7 +26,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
 			(int)PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
-	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
+	return bmi160_core_probe(&spi->dev, regmap, id->name, spi->irq,
+				true, true);
 }
 
 static int bmi160_spi_remove(struct spi_device *spi)
-- 
2.10.2

