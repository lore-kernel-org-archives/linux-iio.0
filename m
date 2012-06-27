Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36274 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab2F0XQq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Jun 2012 19:16:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: add adjd_s311 I2C digital color sensor driver
Date: Thu, 28 Jun 2012 01:16:44 +0200
Message-Id: <1340839004-15731-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

sensor has 4 channels (10-bit each, R/G/B and clear), sensitivity
and gain is controlled in the driver by ext_info integration_time
and CHAN_INFO_HARDWAREGAIN

driver supports triggered buffer and IIO_CHAN_INFO_RAW to get the
sensor data

patch depends on IIO_MOD_LIGHT_RED etc, the patch providing that
(http://permalink.gmane.org/gmane.linux.kernel.iio/4354) has not been
merged yet

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/Kconfig     |   12 ++
 drivers/iio/light/Makefile    |    1 +
 drivers/iio/light/adjd_s311.c |  400 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 413 insertions(+)
 create mode 100644 drivers/iio/light/adjd_s311.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index f3ea90d..4504ef2 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -30,4 +30,16 @@ config VCNL4000
 	 To compile this driver as a module, choose M here: the
 	 module will be called vcnl4000.
 
+config ADJD_S311
+	tristate "ADJD-S311-CR999 digital color sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	depends on I2C
+	help
+	 If you say yes here you get support for the Avago ADJD-S311-CR999
+	 digital color light sensor.
+
+	 This driver can also be built as a module.  If so, the module
+	 will be called adjd_s311.
+
 endmenu
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 06fa4d3..740cfd6 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
+obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
new file mode 100644
index 0000000..8aafa18
--- /dev/null
+++ b/drivers/iio/light/adjd_s311.c
@@ -0,0 +1,400 @@
+/*
+ * adjd_s311.c - Support for ADJD-S311-CR999 digital color sensor
+ *
+ * Copyright (C) 2012 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * driver for ADJD-S311-CR999 digital color sensor (10-bit channels for
+ * red, green, blue, clear); 7-bit I2C slave address 0x74
+ *
+ * limitations: no calibration, no offset mode, no sleep mode
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/bitmap.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define ADJD_S311_DRV_NAME "adjd_s311"
+
+#define CTRL		0x00
+#define CONFIG		0x01
+#define CAP_RED		0x06
+#define CAP_GREEN	0x07
+#define CAP_BLUE	0x08
+#define CAP_CLEAR	0x09
+#define INT_RED_LO	0x0a
+#define INT_RED_HI	0x0b
+#define INT_GREEN_LO	0x0c
+#define INT_GREEN_HI	0x0d
+#define INT_BLUE_LO	0x0e
+#define INT_BLUE_HI	0x0f
+#define INT_CLEAR_LO	0x10
+#define INT_CLEAR_HI	0x11
+#define DATA_RED_LO	0x40
+#define DATA_RED_HI	0x41
+#define DATA_GREEN_LO	0x42
+#define DATA_GREEN_HI	0x43
+#define DATA_BLUE_LO	0x44
+#define DATA_BLUE_HI	0x45
+#define DATA_CLEAR_LO	0x46
+#define DATA_CLEAR_HI	0x47
+#define OFFSET_RED	0x48
+#define OFFSET_GREEN	0x49
+#define OFFSET_BLUE	0x4a
+#define OFFSET_CLEAR	0x4b
+
+#define CTRL_GOFS	0x02
+#define CTRL_GSSR	0x01
+
+#define CAP_MASK	0x0f
+#define INT_MASK	0x0fff
+#define DATA_MASK	0x03ff
+
+struct adjd_s311_data {
+	struct i2c_client *client;
+};
+
+struct adjd_s311_channel_regs {
+	u8 data_reg;
+	u8 int_reg;
+	u8 cap_reg;
+};
+
+enum adjd_s311_channel_idx {
+	IDX_RED, IDX_GREEN, IDX_BLUE, IDX_CLEAR
+};
+
+static const struct adjd_s311_channel_regs adjd_s311_regs[] = {
+	[IDX_RED] = { DATA_RED_LO, INT_RED_LO, CAP_RED },
+	[IDX_GREEN] = { DATA_GREEN_LO, INT_GREEN_LO, CAP_GREEN },
+	[IDX_BLUE] = { DATA_BLUE_LO, INT_BLUE_LO, CAP_BLUE },
+	[IDX_CLEAR] = { DATA_CLEAR_LO, INT_CLEAR_LO, CAP_CLEAR },
+};
+
+static int adjd_s311_req_data(struct iio_dev *indio_dev)
+{
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+	int tries = 10;
+
+	int ret = i2c_smbus_write_byte_data(data->client, CTRL, CTRL_GSSR);
+	if (ret < 0)
+		return ret;
+
+	while (tries--) {
+		ret = i2c_smbus_read_byte_data(data->client, CTRL);
+		if (ret < 0)
+			return ret;
+		if (!(ret & CTRL_GSSR))
+			break;
+		msleep(20);
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev,
+			"adjd_s311_req_data() failed, data not ready\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int adjd_s311_read_data(struct iio_dev *indio_dev, u8 reg, int *val)
+{
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+
+	int ret = adjd_s311_req_data(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(data->client, reg);
+	if (ret < 0)
+		return ret;
+
+	*val = ret & DATA_MASK;
+
+	return 0;
+}
+
+static ssize_t adjd_s311_read_int_time(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+{
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+	s32 ret;
+
+	ret = i2c_smbus_read_word_data(data->client,
+		adjd_s311_regs[chan->address].int_reg);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", ret & INT_MASK);
+}
+
+static ssize_t adjd_s311_write_int_time(struct iio_dev *indio_dev,
+	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	 size_t len)
+{
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+	unsigned long int_time;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &int_time);
+	if (ret)
+		return ret;
+
+	if (int_time > INT_MASK)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_word_data(data->client,
+		adjd_s311_regs[chan->address].int_reg, int_time);
+	if (ret < 0)
+		return ret;
+
+	return ret ? ret : len;
+}
+
+static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+	int len = 0;
+	u16 *buf;
+
+	int ret = adjd_s311_req_data(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
+		int i, j;
+		for (i = 0, j = 0;
+		     i < bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
+		     i++, j++) {
+			j = find_next_bit(buffer->scan_mask,
+					  indio_dev->masklength, j);
+
+			ret = i2c_smbus_read_word_data(data->client,
+				adjd_s311_regs[j].data_reg);
+			if (ret < 0) {
+				kfree(buf);
+				return ret;
+			}
+
+			buf[i] = ret & DATA_MASK;
+			len += 2;
+		}
+	}
+
+	if (indio_dev->scan_timestamp)
+		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))
+			= iio_get_time_ns();
+	buffer->access->store_to(buffer, (u8 *)buf, pf->timestamp);
+
+	kfree(buf);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_chan_spec_ext_info adjd_s311_ext_info[] = {
+	{
+		.name = "integration_time",
+		.read = adjd_s311_read_int_time,
+		.write = adjd_s311_write_int_time,
+	},
+	{ }
+};
+
+static const struct iio_chan_spec adjd_s311_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.address = IDX_RED,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,
+		.channel2 = IIO_MOD_LIGHT_RED,
+		.scan_index = 0,
+		.scan_type = IIO_ST('u', 10, 16, 0),
+		.ext_info = adjd_s311_ext_info,
+	}, {
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.address = IDX_GREEN,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,
+		.channel2 = IIO_MOD_LIGHT_GREEN,
+		.scan_index = 1,
+		.scan_type = IIO_ST('u', 10, 16, 0),
+		.ext_info = adjd_s311_ext_info,
+	}, {
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.address = IDX_GREEN,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,
+		.channel2 = IIO_MOD_LIGHT_BLUE,
+		.scan_index = 2,
+		.scan_type = IIO_ST('u', 10, 16, 0),
+		.ext_info = adjd_s311_ext_info,
+	}, {
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.address = IDX_CLEAR,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.scan_index = 3,
+		.scan_type = IIO_ST('u', 10, 16, 0),
+		.ext_info = adjd_s311_ext_info,
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static int adjd_s311_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adjd_s311_read_data(indio_dev, chan->address, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = i2c_smbus_read_byte_data(data->client,
+			adjd_s311_regs[chan->address].cap_reg);
+		if (ret < 0)
+			return ret;
+		*val = ret & CAP_MASK;
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static int adjd_s311_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct adjd_s311_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		if (val < 0 || val > CAP_MASK)
+			return -EINVAL;
+
+		ret = i2c_smbus_write_byte_data(data->client,
+			adjd_s311_regs[chan->address].cap_reg, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info adjd_s311_info = {
+	.read_raw = adjd_s311_read_raw,
+	.write_raw = adjd_s311_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int __devinit adjd_s311_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct adjd_s311_data *data;
+	struct iio_dev *indio_dev;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*data));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &adjd_s311_info;
+	indio_dev->name = ADJD_S311_DRV_NAME;
+	indio_dev->channels = adjd_s311_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adjd_s311_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	err = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
+		adjd_s311_trigger_handler, NULL);
+	if (err < 0)
+		goto exit_free_device;
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto exit_unreg_buffer;
+
+	dev_info(&client->dev, "ADJD-S311 color sensor registered\n");
+
+	return 0;
+
+exit_unreg_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+exit_free_device:
+	iio_device_free(indio_dev);
+exit:
+	return err;
+}
+
+static int __devexit adjd_s311_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_buffer_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	iio_device_unregister(indio_dev);
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id adjd_s311_id[] = {
+	{ "adjd_s311", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adjd_s311_id);
+
+static struct i2c_driver adjd_s311_driver = {
+	.driver = {
+		.name	= ADJD_S311_DRV_NAME,
+	},
+	.probe		= adjd_s311_probe,
+	.remove		= __devexit_p(adjd_s311_remove),
+	.id_table	= adjd_s311_id,
+};
+module_i2c_driver(adjd_s311_driver);
+
+MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("ADJD-S311 color sensor");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

