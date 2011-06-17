Return-Path: <cwolfe@google.com>
From: Chris Wolfe <cwolfe@chromium.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Chris Wolfe <cwolfe@chromium.org>
Subject: [RFC][PATCH] staging:iio:kxtf9 accelerometer minimal support
Date: Fri, 17 Jun 2011 10:22:59 -0400
Message-Id: <1308320579-12922-1-git-send-email-cwolfe@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

This provides minimal support for a Kionix KXTF9 accelerometer on I2C.

Against staging-next@dc5a189. Fairly RFC as this does not yet use iio_priv or
channels, and does not hold any locks when interacting with the state or device.
In particular for the locking, should I reuse indio->mlock or add state->lock?

Signed-off-by: Chris Wolfe <cwolfe@chromium.org>
---
 drivers/staging/iio/accel/Kconfig  |   10 +
 drivers/staging/iio/accel/Makefile |    1 +
 drivers/staging/iio/accel/kxtf9.c  |  394 ++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/accel/kxtf9.c

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 81a33b6..b54863a 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -62,6 +62,16 @@ config KXSD9
 	  Say yes here to build support for the Kionix KXSD9 accelerometer.
 	  Currently this only supports the device via an SPI interface.
 
+config KXTF9
+	tristate "Kionix KXTF9 Accelerometer Driver"
+	depends on I2C
+	help
+	  Say Y here if you have a Kionix KXTF9 accelerometer.
+	  Currently this only supports the device on an I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called kxtf9.
+
 config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 1b2a6d3..8e6d804 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -26,6 +26,7 @@ adis16240-$(CONFIG_IIO_RING_BUFFER) += adis16240_ring.o adis16240_trigger.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
 
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
+obj-$(CONFIG_KXTF9)	+= kxtf9.o
 
 lis3l02dq-y		:= lis3l02dq_core.o
 lis3l02dq-$(CONFIG_IIO_RING_BUFFER) += lis3l02dq_ring.o
diff --git a/drivers/staging/iio/accel/kxtf9.c b/drivers/staging/iio/accel/kxtf9.c
new file mode 100644
index 0000000..1a6b0e7
--- /dev/null
+++ b/drivers/staging/iio/accel/kxtf9.c
@@ -0,0 +1,394 @@
+/*
+ * drivers/staging/iio/accel/kxtf9.c
+ *
+ * Copyright (C) 2011 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "accel.h"
+
+/*** REGISTERS ****************************************************************/
+
+/* These constants are based on the datasheet published by Kionix for the
+ * KXTF9-4100 (Rev 5, March 2011). For more information see:
+ * http://www.kionix.com/accelerometers/accelerometer-KXTF9.html
+ */
+
+#define KXTF9_REG_X			0x06 /* signed le16 */
+#define KXTF9_REG_Y			0x08 /* signed le16 */
+#define KXTF9_REG_Z			0x0A /* signed le16 */
+#define KXTF9_REG_WIA			0x0F
+#define KXTF9_REG_CTRL1			0x1B
+#define KXTF9_REG_CTRL2			0x1C
+#define KXTF9_REG_CTRL3			0x1D
+#define KXTF9_REG_DATA			0x21
+
+#define KXTF9_WIA_EXPECT		0x01
+
+#define KXTF9_CTRL1_ACTIVE		(1<<7)
+#define KXTF9_CTRL1_PRECISE		(1<<6)
+#define KXTF9_CTRL1_RANGE_2G		(0<<3)
+#define KXTF9_CTRL1_RANGE_4G		(1<<3)
+#define KXTF9_CTRL1_RANGE_8G		(2<<3)
+#define KXTF9_CTRL1_RANGE_MASK		(3<<3)
+
+#define KXTF9_CTRL3_RESET		(1<<7)
+
+#define KXTF9_DATA_RATE_25_HZ		(1<<0)
+#define KXTF9_DATA_RATE_50_HZ		(2<<0)
+#define KXTF9_DATA_RATE_100_HZ		(3<<0)
+#define KXTF9_DATA_RATE_200_HZ		(4<<0)
+#define KXTF9_DATA_RATE_400_HZ		(5<<0)
+#define KXTF9_DATA_RATE_800_HZ		(6<<0)
+#define KXTF9_DATA_RATE_MASK		(7<<0)
+
+/*** CONSTANTS ****************************************************************/
+
+/* Depending on the precision mode, the X/Y/Z output registers will contain
+ * either 8 or 12 bits of valid data in their high bits. The low bits are
+ * undefined, so must be zeroed by the driver.
+ *
+ * As a signed 16-bit integer, each range is mapped such that -XG is reported
+ * as -32768 and +XG would be 32768. This yields a scale of 2*X / 65536.
+ * Note that the +XG value can not actually be reported. The data sheet
+ * considers the register values as 8- and 12-bit integers, so shows a
+ * different calculation.
+ */
+
+#define KXTF9_SCALE_2G		"0.00006103515625"
+#define KXTF9_SCALE_4G		"0.0001220703125"
+#define KXTF9_SCALE_8G		"0.000244140625"
+
+/* Determines the time to wait for a reset to complete. */
+#define KXTF9_RESET_MAX_SLEEPS	10
+#define KXTF9_RESET_SLEEP	10
+
+/*** DEVICE STATE *************************************************************/
+
+struct kxtf9 {
+	struct iio_dev *iio;
+	struct i2c_client *i2c;
+
+	u8 cache_ctrl1;
+	u8 cache_ctrl2;
+	u8 cache_ctrl3;
+	u8 cache_data;
+};
+
+/*** ATTRIBUTES ***************************************************************/
+
+static int kxtf9_reset(struct kxtf9 *state);
+
+static inline struct kxtf9 *dev_get_kxtf9(struct device *dev)
+{
+	struct iio_dev *iio = dev_get_drvdata(dev);
+	return iio_dev_get_devdata(iio);
+}
+
+static ssize_t kxtf9_store_reset(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct kxtf9 *state = dev_get_kxtf9(dev);
+	long val;
+	s32 ret;
+
+	ret = strict_strtol(buf, 0, &val);
+	if (ret < 0)
+		goto error;
+
+	if (val != 1) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = kxtf9_reset(state);
+	if (ret < 0)
+		goto error;
+
+	return count;
+error:
+	return ret;
+}
+
+static ssize_t kxtf9_show_accel_raw(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct kxtf9 *state = dev_get_kxtf9(dev);
+	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
+	bool precise;
+	s32 ret;
+	s16 val;
+
+	ret = i2c_smbus_read_word_data(state->i2c, iio_attr->address);
+	if (ret < 0)
+		goto error;
+
+	precise = (state->cache_ctrl1 & KXTF9_CTRL1_PRECISE) != 0;
+	val = __le16_to_cpu((__le16)(s16)ret);
+	val &= (precise ? 0xFFF0 : 0xFF00);
+
+	return sprintf(buf, "%d\n", (int)val);
+
+error:
+	return ret;
+}
+
+static ssize_t kxtf9_show_accel_scale(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct kxtf9 *state = dev_get_kxtf9(dev);
+	const char *scale;
+
+	switch (state->cache_ctrl1 & KXTF9_CTRL1_RANGE_MASK) {
+	case KXTF9_CTRL1_RANGE_2G:
+		scale = KXTF9_SCALE_2G;
+		break;
+	case KXTF9_CTRL1_RANGE_4G:
+		scale = KXTF9_SCALE_4G;
+		break;
+	case KXTF9_CTRL1_RANGE_8G:
+		scale = KXTF9_SCALE_8G;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return sprintf(buf, "%s\n", scale);
+}
+
+static IIO_CONST_ATTR_NAME("kxtf9");
+static IIO_DEV_ATTR_RESET(kxtf9_store_reset);
+static IIO_DEV_ATTR_ACCEL_SCALE(S_IRUGO, kxtf9_show_accel_scale, NULL, -1);
+static IIO_DEV_ATTR_ACCEL_X(kxtf9_show_accel_raw, KXTF9_REG_X);
+static IIO_DEV_ATTR_ACCEL_Y(kxtf9_show_accel_raw, KXTF9_REG_Y);
+static IIO_DEV_ATTR_ACCEL_Z(kxtf9_show_accel_raw, KXTF9_REG_Z);
+
+static struct attribute *kxtf9_attributes[] = {
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_dev_attr_accel_x_raw.dev_attr.attr,
+	&iio_dev_attr_accel_y_raw.dev_attr.attr,
+	&iio_dev_attr_accel_z_raw.dev_attr.attr,
+	&iio_dev_attr_accel_scale.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group kxtf9_attribute_group = {
+	.attrs = kxtf9_attributes,
+};
+
+/*** MODULE *******************************************************************/
+
+static int kxtf9_check(struct i2c_client *i2c)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_byte_data(i2c, KXTF9_REG_WIA);
+	if (ret < 0)
+		return ret;
+
+	if (ret != KXTF9_WIA_EXPECT) {
+		dev_err(&i2c->dev, "device not found; unexpected WIA value\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void kxtf9_default_config(struct kxtf9 *state)
+{
+	state->cache_ctrl1 = KXTF9_CTRL1_ACTIVE | KXTF9_CTRL1_RANGE_2G;
+	state->cache_ctrl2 = 0x00;
+	state->cache_ctrl3 = 0x00;
+
+	/* Possible errata: 25 Hz output rate seems to produce only one sample.
+	 * Use 50 Hz as a default instead. */
+	state->cache_data = KXTF9_DATA_RATE_50_HZ;
+}
+
+/* Write out the configuration when the device is already inactive. */
+static int kxtf9_write_config_inactive(struct kxtf9 *state)
+{
+	s32 ret;
+
+	ret = i2c_smbus_write_byte_data(state->i2c, KXTF9_REG_CTRL2,
+		state->cache_ctrl2);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(state->i2c, KXTF9_REG_CTRL3,
+		state->cache_ctrl3);
+	if (ret < 0)
+		return ret;
+
+	/* Finally write out CTRL1, likely reactivating the device. */
+	ret = i2c_smbus_write_byte_data(state->i2c, KXTF9_REG_CTRL1,
+		state->cache_ctrl1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int kxtf9_reset(struct kxtf9 *state)
+{
+	int i;
+	s32 ret;
+
+	dev_info(&state->i2c->dev, "reset\n");
+
+	/* Deactivate the device so it can be reset. */
+	ret = i2c_smbus_write_byte_data(state->i2c, KXTF9_REG_CTRL1,
+		state->cache_ctrl1 & ~KXTF9_CTRL1_ACTIVE);
+	if (ret < 0)
+		return ret;
+
+	/* Start the reset. */
+	ret = i2c_smbus_write_byte_data(state->i2c, KXTF9_REG_CTRL3,
+		state->cache_ctrl3 | KXTF9_CTRL3_RESET);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < KXTF9_RESET_MAX_SLEEPS; ++i) {
+		if (i > 0)
+			msleep(KXTF9_RESET_SLEEP);
+
+		ret = i2c_smbus_read_byte_data(state->i2c, KXTF9_REG_CTRL3);
+		if (ret == -EAGAIN)
+			continue;
+		else if (ret < 0)
+			return ret;
+
+		if ((ret & KXTF9_CTRL3_RESET) == 0)
+			break;
+	}
+	if (i == KXTF9_RESET_MAX_SLEEPS) {
+		dev_err(&state->i2c->dev, "timed out while waiting for reset\n");
+		return -ETIME;
+	}
+
+	/* Restore the normal configuration and activation. */
+	return kxtf9_write_config_inactive(state);
+}
+
+static const struct iio_info kxtf9_info = {
+	.attrs = &kxtf9_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static int kxtf9_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct kxtf9 *state;
+	int ret;
+
+	ret = kxtf9_check(client);
+	if (ret < 0)
+		goto error;
+
+	state = kzalloc(sizeof(struct kxtf9), GFP_KERNEL);
+	if (!state) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
+
+	state->i2c = client;
+	i2c_set_clientdata(client, state);
+
+	kxtf9_default_config(state);
+
+	ret = kxtf9_reset(state);
+	if (ret < 0) {
+		dev_err(&state->i2c->dev, "initialization failed\n");
+		goto error_free;
+	}
+
+	state->iio = iio_allocate_device(0);
+	if (!state->iio) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
+
+	state->iio->dev.parent = &client->dev;
+	state->iio->info = &kxtf9_info;
+	state->iio->dev_data = state;
+	state->iio->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(state->iio);
+	if (ret < 0)
+		goto error_free_iio;
+
+	return 0;
+error_free_iio:
+	iio_free_device(state->iio);
+error_free:
+	i2c_set_clientdata(client, NULL);
+	kfree(state);
+error:
+	return ret;
+}
+
+static int kxtf9_remove(struct i2c_client *client)
+{
+	struct kxtf9 *state = i2c_get_clientdata(client);
+
+	iio_device_unregister(state->iio);
+	iio_free_device(state->iio);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(state);
+	return 0;
+}
+
+/******************************************************************************/
+
+static const struct i2c_device_id kxtf9_id[] = {
+	{ "kxtf9", 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, kxtf9_id);
+
+static struct i2c_driver kxtf9_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "kxtf9",
+	},
+	.id_table = kxtf9_id,
+	.probe = kxtf9_probe,
+	.remove = kxtf9_remove,
+};
+
+static int __init kxtf9_init(void)
+{
+	return i2c_add_driver(&kxtf9_driver);
+}
+
+static void __exit kxtf9_exit(void)
+{
+	i2c_del_driver(&kxtf9_driver);
+}
+
+module_init(kxtf9_init);
+module_exit(kxtf9_exit);
+
+MODULE_AUTHOR("Chris Wolfe <cwolfe@chromium.org>");
+MODULE_DESCRIPTION("Kionix KXTF9 Accelerometer Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.3.1
