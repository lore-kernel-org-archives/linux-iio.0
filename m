Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41458 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab3JUUx1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 21 Oct 2013 16:53:27 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Add Freescale mag3110 magnetometer driver
Date: Mon, 21 Oct 2013 22:53:22 +0200
Message-Id: <1382388802-5399-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

three-axis digital magnetometer with I2C interface

datasheet is available from
http://cache.freescale.com/files/sensors/doc/data_sheet/MAG3110.pdf

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/Kconfig   |  10 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mag3110.c | 401 +++++++++++++++++++++++++++++++++++++
 3 files changed, 412 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mag3110.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 4fa923f..0cf0963 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -16,6 +16,16 @@ config AK8975
 	  To compile this driver as a module, choose M here: the module
 	  will be called ak8975.
 
+config MAG3110
+	tristate "Freescale MAG3110 3-Axis Magnetometer"
+	depends on I2C
+	help
+	  Say yes here to build support for the Freescale MAG3110 3-Axis
+	  magnetometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mag3110.
+
 config HID_SENSOR_MAGNETOMETER_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index f91b1b6..0f5d3c9 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -4,6 +4,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AK8975)	+= ak8975.o
+obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
new file mode 100644
index 0000000..783c5b4
--- /dev/null
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -0,0 +1,401 @@
+/*
+ * mag3110.c - Support for Freescale MAG3110 magnetometer sensor
+ *
+ * Copyright (c) 2013 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * (7-bit I2C slave address 0x0e)
+ *
+ * TODO: irq, user offset, oversampling, continuous mode
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/delay.h>
+
+#define MAG3110_STATUS 0x00
+#define MAG3110_OUT_X 0x01 /* MSB first */
+#define MAG3110_OUT_Y 0x03
+#define MAG3110_OUT_Z 0x05
+#define MAG3110_WHO_AM_I 0x07
+#define MAG3110_OFF_X 0x09 /* MSB first */
+#define MAG3110_OFF_Y 0x0b
+#define MAG3110_OFF_Z 0x0d
+#define MAG3110_DIE_TEMP 0x0f
+#define MAG3110_CTRL_REG1 0x10
+#define MAG3110_CTRL_REG2 0x11
+
+#define MAG3110_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
+
+#define MAG3110_CTRL_DR_MASK (BIT(7) | BIT(6) | BIT(5))
+#define MAG3110_CTRL_DR_SHIFT 5
+#define MAG3110_CTRL_DR_DEFAULT 0
+
+#define MAG3110_CTRL_TM BIT(1) /* trigger single measurement */
+#define MAG3110_CTRL_AC BIT(0) /* continuous measurements */
+
+#define MAG3110_CTRL_AUTO_MRST_EN BIT(7) /* magnetic auto-reset */
+#define MAG3110_CTRL_RAW BIT(5) /* measurements not user-offset corrected */
+
+#define MAG3110_DEVICE_ID 0xc4
+
+/* Each client has this additional data */
+struct mag3110_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u8 ctrl_reg1;
+};
+
+static int mag3110_request(struct mag3110_data *data)
+{
+	int ret, tries = 150;
+
+	/* trigger measurement */
+	ret = i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+		data->ctrl_reg1 | MAG3110_CTRL_TM);
+	if (ret < 0)
+		return ret;
+
+	while (tries-- > 0) {
+		ret = i2c_smbus_read_byte_data(data->client, MAG3110_STATUS);
+		if (ret < 0)
+			return ret;
+		/* wait for data ready */
+		if ((ret & MAG3110_STATUS_DRDY) == MAG3110_STATUS_DRDY)
+			break;
+		msleep(20);
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev, "data not ready\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mag3110_read(struct mag3110_data *data, __be16 buf[3])
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = mag3110_request(data);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	ret = i2c_smbus_read_i2c_block_data(data->client,
+		MAG3110_OUT_X, 3 * sizeof(__be16), (u8 *) buf);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static ssize_t mag3110_show_int_plus_micros(char *buf,
+	const int (*vals)[2], int n)
+{
+	size_t len = 0;
+
+	while (n-- > 0)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+			"%d.%d ", vals[n][0], vals[n][1]);
+
+	/* replace trailing space by newline */
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static int mag3110_get_int_plus_micros_index(const int (*vals)[2], int n,
+					int val, int val2)
+{
+	while (n-- > 0)
+		if (val == vals[n][0] && val2 == vals[n][1])
+			return n;
+
+	return -EINVAL;
+}
+
+static const int mag3110_samp_freq[8][2] = {
+	{80, 0}, {40, 0}, {20, 0}, {10, 0}, {5, 0}, {2, 500000},
+	{1, 250000}, {0, 625000}
+};
+
+static ssize_t mag3110_show_samp_freq_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return mag3110_show_int_plus_micros(buf, mag3110_samp_freq, 8);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mag3110_show_samp_freq_avail);
+
+static int mag3110_get_samp_freq_index(struct mag3110_data *data,
+	int val, int val2)
+{
+	return mag3110_get_int_plus_micros_index(mag3110_samp_freq, 8, val,
+		val2);
+}
+
+static int mag3110_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct mag3110_data *data = iio_priv(indio_dev);
+	__be16 buffer[3];
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_MAGN: /* in 0.1 uT / LSB */
+			ret = mag3110_read(data, buffer);
+			if (ret < 0)
+				return ret;
+			*val = sign_extend32(
+				be16_to_cpu(buffer[chan->scan_index]), 15);
+			return IIO_VAL_INT;
+		case IIO_TEMP: /* in 1 C / LSB */
+			mutex_lock(&data->lock);
+			ret = mag3110_request(data);
+			if (ret < 0) {
+				mutex_unlock(&data->lock);
+				return ret;
+			}
+			ret = i2c_smbus_read_byte_data(data->client,
+				MAG3110_DIE_TEMP);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			*val = sign_extend32(ret, 7);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
+		*val = mag3110_samp_freq[i][0];
+		*val2 = mag3110_samp_freq[i][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
+}
+
+static int mag3110_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mag3110_data *data = iio_priv(indio_dev);
+	int rate;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rate = mag3110_get_samp_freq_index(data, val, val2);
+		if (rate < 0)
+			return -EINVAL;
+
+		data->ctrl_reg1 &= ~MAG3110_CTRL_DR_MASK;
+		data->ctrl_reg1 |= rate << MAG3110_CTRL_DR_SHIFT;
+		return i2c_smbus_write_byte_data(data->client,
+			MAG3110_CTRL_REG1, data->ctrl_reg1);
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t mag3110_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mag3110_data *data = iio_priv(indio_dev);
+	u8 buffer[16]; /* 3 16-bit channels + 1 byte temp + padding + ts */
+	int ret;
+
+	ret = mag3110_read(data, (__be16 *) buffer);
+	if (ret < 0)
+		goto done;
+
+	if (test_bit(3, indio_dev->active_scan_mask)) {
+		ret = i2c_smbus_read_byte_data(data->client,
+			MAG3110_DIE_TEMP);
+		if (ret < 0)
+			goto done;
+		buffer[6] = ret;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+		iio_get_time_ns());
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+#define MAG3110_CHANNEL(axis, idx) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_index = idx, \
+	.scan_type = IIO_ST('s', 16, 16, IIO_BE), \
+}
+
+static const struct iio_chan_spec mag3110_channels[] = {
+	MAG3110_CHANNEL(X, 0),
+	MAG3110_CHANNEL(Y, 1),
+	MAG3110_CHANNEL(Z, 2),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = 3,
+		.scan_type = IIO_ST('s', 8, 8, 0),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static struct attribute *mag3110_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mag3110_group = {
+	.attrs = mag3110_attributes,
+};
+
+static const struct iio_info mag3110_info = {
+	.attrs = &mag3110_group,
+	.read_raw = &mag3110_read_raw,
+	.write_raw = &mag3110_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const unsigned long mag3110_scan_masks[] = {0x7, 0xf, 0};
+
+static int mag3110_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct mag3110_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
+	if (ret < 0)
+		return ret;
+	if (ret != MAG3110_DEVICE_ID)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	i2c_set_clientdata(client, indio_dev);
+	indio_dev->info = &mag3110_info;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mag3110_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mag3110_channels);
+	indio_dev->available_scan_masks = mag3110_scan_masks;
+
+	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT;
+	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
+		data->ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
+		MAG3110_CTRL_AUTO_MRST_EN | MAG3110_CTRL_RAW);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+		mag3110_trigger_handler, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto buffer_cleanup;
+	return 0;
+
+buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+	return ret;
+}
+
+static int mag3110_standby(struct mag3110_data *data)
+{
+	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+		data->ctrl_reg1 & ~MAG3110_CTRL_AC);
+}
+
+static int mag3110_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	mag3110_standby(iio_priv(indio_dev));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mag3110_suspend(struct device *dev)
+{
+	return mag3110_standby(iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev))));
+}
+
+static int mag3110_resume(struct device *dev)
+{
+	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
+
+	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+		data->ctrl_reg1);
+}
+
+static SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend, mag3110_resume);
+#define MAG3110_PM_OPS (&mag3110_pm_ops)
+#else
+#define MAG3110_PM_OPS NULL
+#endif
+
+static const struct i2c_device_id mag3110_id[] = {
+	{ "mag3110", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mag3110_id);
+
+static struct i2c_driver mag3110_driver = {
+	.driver = {
+		.name	= "mag3110",
+		.pm	= MAG3110_PM_OPS,
+	},
+	.probe = mag3110_probe,
+	.remove = mag3110_remove,
+	.id_table = mag3110_id,
+};
+module_i2c_driver(mag3110_driver);
+
+MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("Freescale MAG3110 magnetometer driver");
+MODULE_LICENSE("GPL");
-- 
1.8.4.1

