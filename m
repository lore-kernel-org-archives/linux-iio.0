Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH 16/19] staging: iio: meter: new driver for ADE7854/58/68/78 devices
Date: Sat, 23 Oct 2010 17:54:00 -0400
Message-Id: <1287870843-19835-16-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287870843-19835-1-git-send-email-vapier@gentoo.org>
References: <1287870843-19835-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/meter/Kconfig       |   27 ++
 drivers/staging/iio/meter/Makefile      |    3 +
 drivers/staging/iio/meter/ade7854-i2c.c |  272 ++++++++++++
 drivers/staging/iio/meter/ade7854-spi.c |  360 ++++++++++++++++
 drivers/staging/iio/meter/ade7854.c     |  680 +++++++++++++++++++++++++++++++
 drivers/staging/iio/meter/ade7854.h     |  244 +++++++++++
 6 files changed, 1586 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/meter/ade7854-i2c.c
 create mode 100644 drivers/staging/iio/meter/ade7854-spi.c
 create mode 100644 drivers/staging/iio/meter/ade7854.c
 create mode 100644 drivers/staging/iio/meter/ade7854.h

diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index ebc253e..12e36e4 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -32,3 +32,30 @@ config ADE7759
 	help
 	  Say yes here to build support for Analog Devices ADE7758 Active Energy
 	  Metering IC with di/dt Sensor Interface.
+
+config ADE7854
+	tristate "Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver"
+	depends on SPI || I2C
+	help
+	  Say yes here to build support for Analog Devices ADE7854/58/68/78 Polyphase
+	  Multifunction Energy Metering IC Driver.
+
+config ADE7854_I2C
+	tristate "support I2C bus connection"
+	depends on ADE7854 && I2C
+	default y
+	help
+	  Say Y here if you have ADE7854/58/68/78 hooked to an I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ade7854-i2c.
+
+config ADE7854_SPI
+	tristate "support SPI bus connection"
+	depends on ADE7854 && SPI
+	default y
+	help
+	  Say Y here if you have ADE7854/58/68/78 hooked to a SPI bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ade7854-spi.
diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
index 85e3021..0cc7d51 100644
--- a/drivers/staging/iio/meter/Makefile
+++ b/drivers/staging/iio/meter/Makefile
@@ -10,3 +10,6 @@ ade7758-$(CONFIG_IIO_RING_BUFFER) += ade7758_ring.o ade7758_trigger.o
 obj-$(CONFIG_ADE7758) += ade7758.o
 
 obj-$(CONFIG_ADE7759) += ade7759.o
+obj-$(CONFIG_ADE7854) += ade7854.o
+obj-$(CONFIG_ADE7854_I2C) += ade7854-i2c.o
+obj-$(CONFIG_ADE7854_SPI) += ade7854-spi.o
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
new file mode 100644
index 0000000..4578e7b
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -0,0 +1,272 @@
+/*
+ * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver (I2C Bus)
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+
+#include "../iio.h"
+#include "ade7854.h"
+
+static int ade7854_i2c_write_reg_8(struct device *dev,
+		u16 reg_address,
+		u8 value)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+	st->tx[2] = value;
+
+	ret = i2c_master_send(st->i2c, st->tx, 3);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_i2c_write_reg_16(struct device *dev,
+		u16 reg_address,
+		u16 value)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+	st->tx[2] = (value >> 8) & 0xFF;
+	st->tx[3] = value & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 4);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_i2c_write_reg_24(struct device *dev,
+		u16 reg_address,
+		u32 value)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+	st->tx[2] = (value >> 16) & 0xFF;
+	st->tx[3] = (value >> 8) & 0xFF;
+	st->tx[4] = value & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 5);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_i2c_write_reg_32(struct device *dev,
+		u16 reg_address,
+		u32 value)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+	st->tx[2] = (value >> 24) & 0xFF;
+	st->tx[3] = (value >> 16) & 0xFF;
+	st->tx[4] = (value >> 8) & 0xFF;
+	st->tx[5] = value & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 6);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_i2c_read_reg_8(struct device *dev,
+		u16 reg_address,
+		u8 *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 2);
+	if (ret)
+		goto out;
+
+	ret = i2c_master_recv(st->i2c, st->rx, 1);
+	if (ret)
+		goto out;
+
+	*val = st->rx[0];
+out:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7854_i2c_read_reg_16(struct device *dev,
+		u16 reg_address,
+		u16 *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 2);
+	if (ret)
+		goto out;
+
+	ret = i2c_master_recv(st->i2c, st->rx, 2);
+	if (ret)
+		goto out;
+
+	*val = (st->rx[0] << 8) | st->rx[1];
+out:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7854_i2c_read_reg_24(struct device *dev,
+		u16 reg_address,
+		u32 *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 2);
+	if (ret)
+		goto out;
+
+	ret = i2c_master_recv(st->i2c, st->rx, 3);
+	if (ret)
+		goto out;
+
+	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+out:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7854_i2c_read_reg_32(struct device *dev,
+		u16 reg_address,
+		u32 *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (reg_address >> 8) & 0xFF;
+	st->tx[1] = reg_address & 0xFF;
+
+	ret = i2c_master_send(st->i2c, st->tx, 2);
+	if (ret)
+		goto out;
+
+	ret = i2c_master_recv(st->i2c, st->rx, 3);
+	if (ret)
+		goto out;
+
+	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+out:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int __devinit ade7854_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret;
+	struct ade7854_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		return ret;
+	}
+
+	i2c_set_clientdata(client, st);
+	st->read_reg_8 = ade7854_i2c_read_reg_8;
+	st->read_reg_16 = ade7854_i2c_read_reg_16;
+	st->read_reg_24 = ade7854_i2c_read_reg_24;
+	st->read_reg_32 = ade7854_i2c_read_reg_32;
+	st->write_reg_8 = ade7854_i2c_write_reg_8;
+	st->write_reg_16 = ade7854_i2c_write_reg_16;
+	st->write_reg_24 = ade7854_i2c_write_reg_24;
+	st->write_reg_32 = ade7854_i2c_write_reg_32;
+	st->i2c = client;
+	st->irq = client->irq;
+
+	ret = ade7854_probe(st, &client->dev);
+	if (ret) {
+		kfree(st);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int __devexit ade7854_i2c_remove(struct i2c_client *client)
+{
+	return ade7854_remove(i2c_get_clientdata(client));
+}
+
+static const struct i2c_device_id ade7854_id[] = {
+	{ "ade7854", 0 },
+	{ "ade7858", 0 },
+	{ "ade7868", 0 },
+	{ "ade7878", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ade7854_id);
+
+static struct i2c_driver ade7854_i2c_driver = {
+	.driver = {
+		.name = "ade7854",
+	},
+	.probe    = ade7854_i2c_probe,
+	.remove   = __devexit_p(ade7854_i2c_remove),
+	.id_table = ade7854_id,
+};
+
+static __init int ade7854_i2c_init(void)
+{
+	return i2c_add_driver(&ade7854_i2c_driver);
+}
+module_init(ade7854_i2c_init);
+
+static __exit void ade7854_i2c_exit(void)
+{
+	i2c_del_driver(&ade7854_i2c_driver);
+}
+module_exit(ade7854_i2c_exit);
+
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC I2C Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
new file mode 100644
index 0000000..fe58103e
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -0,0 +1,360 @@
+/*
+ * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver (SPI Bus)
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+
+#include "../iio.h"
+#include "ade7854.h"
+
+static int ade7854_spi_write_reg_8(struct device *dev,
+		u16 reg_address,
+		u8 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 4,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7854_WRITE_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = value & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_spi_write_reg_16(struct device *dev,
+		u16 reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 5,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7854_WRITE_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = (value >> 8) & 0xFF;
+	st->tx[4] = value & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_spi_write_reg_24(struct device *dev,
+		u16 reg_address,
+		u32 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 6,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7854_WRITE_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = (value >> 16) & 0xFF;
+	st->tx[4] = (value >> 8) & 0xFF;
+	st->tx[5] = value & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_spi_write_reg_32(struct device *dev,
+		u16 reg_address,
+		u32 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 7,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7854_WRITE_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = (value >> 24) & 0xFF;
+	st->tx[4] = (value >> 16) & 0xFF;
+	st->tx[5] = (value >> 8) & 0xFF;
+	st->tx[6] = value & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7854_spi_read_reg_8(struct device *dev,
+		u16 reg_address,
+		u8 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 4,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+
+	st->tx[0] = ADE7854_READ_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	if (ret) {
+		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = st->rx[3];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7854_spi_read_reg_16(struct device *dev,
+		u16 reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 5,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7854_READ_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = 0;
+	st->tx[4] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	if (ret) {
+		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[3] << 8) | st->rx[4];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7854_spi_read_reg_24(struct device *dev,
+		u16 reg_address,
+		u32 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 6,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+
+	st->tx[0] = ADE7854_READ_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = 0;
+	st->tx[4] = 0;
+	st->tx[5] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	if (ret) {
+		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[3] << 16) | (st->rx[4] << 8) | st->rx[5];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7854_spi_read_reg_32(struct device *dev,
+		u16 reg_address,
+		u32 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 7,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+
+	st->tx[0] = ADE7854_READ_REG;
+	st->tx[1] = (reg_address >> 8) & 0xFF;
+	st->tx[2] = reg_address & 0xFF;
+	st->tx[3] = 0;
+	st->tx[4] = 0;
+	st->tx[5] = 0;
+	st->tx[6] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->spi, &msg);
+	if (ret) {
+		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[3] << 24) | (st->rx[4] << 16) | (st->rx[5] << 8) | st->rx[6];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int __devinit ade7854_spi_probe(struct spi_device *spi)
+{
+	int ret;
+	struct ade7854_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		return ret;
+	}
+
+	spi_set_drvdata(spi, st);
+	st->read_reg_8 = ade7854_spi_read_reg_8;
+	st->read_reg_16 = ade7854_spi_read_reg_16;
+	st->read_reg_24 = ade7854_spi_read_reg_24;
+	st->read_reg_32 = ade7854_spi_read_reg_32;
+	st->write_reg_8 = ade7854_spi_write_reg_8;
+	st->write_reg_16 = ade7854_spi_write_reg_16;
+	st->write_reg_24 = ade7854_spi_write_reg_24;
+	st->write_reg_32 = ade7854_spi_write_reg_32;
+	st->irq = spi->irq;
+	st->spi = spi;
+
+	ret = ade7854_probe(st, &spi->dev);
+	if (ret) {
+		kfree(st);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ade7854_spi_remove(struct spi_device *spi)
+{
+	ade7854_remove(spi_get_drvdata(spi));
+
+	return 0;
+}
+
+static struct spi_driver ade7854_driver = {
+	.driver = {
+		.name = "ade7854",
+		.owner = THIS_MODULE,
+	},
+	.probe = ade7854_spi_probe,
+	.remove = __devexit_p(ade7854_spi_remove),
+};
+
+static __init int ade7854_init(void)
+{
+	return spi_register_driver(&ade7854_driver);
+}
+module_init(ade7854_init);
+
+static __exit void ade7854_exit(void)
+{
+	spi_unregister_driver(&ade7854_driver);
+}
+module_exit(ade7854_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC SPI Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
new file mode 100644
index 0000000..6cc8c82
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -0,0 +1,680 @@
+/*
+ * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "meter.h"
+#include "ade7854.h"
+
+static ssize_t ade7854_read_8bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u8 val = 0;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = st->read_reg_8(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7854_read_16bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = st->read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7854_read_24bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u32 val = 0;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = st->read_reg_24(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val & 0xFFFFFF);
+}
+
+static ssize_t ade7854_read_32bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u32 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	ret = st->read_reg_32(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7854_write_8bit(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = st->write_reg_8(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t ade7854_write_16bit(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = st->write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t ade7854_write_24bit(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = st->write_reg_24(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t ade7854_write_32bit(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = st->write_reg_32(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static int ade7854_reset(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	int ret;
+	u16 val;
+
+	st->read_reg_16(dev, ADE7854_CONFIG, &val);
+	val |= 1 << 7; /* Software Chip Reset */
+	ret = st->write_reg_16(dev, ADE7854_CONFIG, val);
+
+	return ret;
+}
+
+
+static ssize_t ade7854_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return ade7854_reset(dev);
+	}
+	return -1;
+}
+
+static IIO_DEV_ATTR_AIGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_AIGAIN);
+static IIO_DEV_ATTR_BIGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_BIGAIN);
+static IIO_DEV_ATTR_CIGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_CIGAIN);
+static IIO_DEV_ATTR_NIGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_NIGAIN);
+static IIO_DEV_ATTR_AVGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_AVGAIN);
+static IIO_DEV_ATTR_BVGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_BVGAIN);
+static IIO_DEV_ATTR_CVGAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_CVGAIN);
+static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_AVAGAIN);
+static IIO_DEV_ATTR_APPARENT_POWER_B_GAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_BVAGAIN);
+static IIO_DEV_ATTR_APPARENT_POWER_C_GAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_CVAGAIN);
+static IIO_DEV_ATTR_ACTIVE_POWER_A_OFFSET(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_AWATTOS);
+static IIO_DEV_ATTR_ACTIVE_POWER_B_OFFSET(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_BWATTOS);
+static IIO_DEV_ATTR_ACTIVE_POWER_C_OFFSET(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_CWATTOS);
+static IIO_DEV_ATTR_REACTIVE_POWER_A_GAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_AVARGAIN);
+static IIO_DEV_ATTR_REACTIVE_POWER_B_GAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_BVARGAIN);
+static IIO_DEV_ATTR_REACTIVE_POWER_C_GAIN(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_CVARGAIN);
+static IIO_DEV_ATTR_REACTIVE_POWER_A_OFFSET(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_AVAROS);
+static IIO_DEV_ATTR_REACTIVE_POWER_B_OFFSET(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_BVAROS);
+static IIO_DEV_ATTR_REACTIVE_POWER_C_OFFSET(S_IWUSR | S_IRUGO,
+		ade7854_read_24bit,
+		ade7854_write_24bit,
+		ADE7854_CVAROS);
+static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
+		ade7854_read_32bit,
+		ade7854_write_32bit,
+		ADE7854_VPEAK);
+static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
+		ade7854_read_32bit,
+		ade7854_write_32bit,
+		ADE7854_VPEAK);
+static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_APHCAL);
+static IIO_DEV_ATTR_BPHCAL(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_BPHCAL);
+static IIO_DEV_ATTR_CPHCAL(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_CPHCAL);
+static IIO_DEV_ATTR_CF1DEN(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_CF1DEN);
+static IIO_DEV_ATTR_CF2DEN(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_CF2DEN);
+static IIO_DEV_ATTR_CF3DEN(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_CF3DEN);
+static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_LINECYC);
+static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
+		ade7854_read_8bit,
+		ade7854_write_8bit,
+		ADE7854_SAGCYC);
+static IIO_DEV_ATTR_CFCYC(S_IWUSR | S_IRUGO,
+		ade7854_read_8bit,
+		ade7854_write_8bit,
+		ADE7854_CFCYC);
+static IIO_DEV_ATTR_PEAKCYC(S_IWUSR | S_IRUGO,
+		ade7854_read_8bit,
+		ade7854_write_8bit,
+		ADE7854_PEAKCYC);
+static IIO_DEV_ATTR_CHKSUM(ade7854_read_24bit,
+		ADE7854_CHECKSUM);
+static IIO_DEV_ATTR_ANGLE0(ade7854_read_24bit,
+		ADE7854_ANGLE0);
+static IIO_DEV_ATTR_ANGLE1(ade7854_read_24bit,
+		ADE7854_ANGLE1);
+static IIO_DEV_ATTR_ANGLE2(ade7854_read_24bit,
+		ADE7854_ANGLE2);
+static IIO_DEV_ATTR_AIRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_AIRMS);
+static IIO_DEV_ATTR_BIRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_BIRMS);
+static IIO_DEV_ATTR_CIRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_CIRMS);
+static IIO_DEV_ATTR_NIRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_NIRMS);
+static IIO_DEV_ATTR_AVRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_AVRMS);
+static IIO_DEV_ATTR_BVRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_BVRMS);
+static IIO_DEV_ATTR_CVRMS(S_IRUGO,
+		ade7854_read_24bit,
+		NULL,
+		ADE7854_CVRMS);
+static IIO_DEV_ATTR_AIRMSOS(S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_AIRMSOS);
+static IIO_DEV_ATTR_BIRMSOS(S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_BIRMSOS);
+static IIO_DEV_ATTR_CIRMSOS(S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_CIRMSOS);
+static IIO_DEV_ATTR_AVRMSOS(S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_AVRMSOS);
+static IIO_DEV_ATTR_BVRMSOS(S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_BVRMSOS);
+static IIO_DEV_ATTR_CVRMSOS(S_IRUGO,
+		ade7854_read_16bit,
+		ade7854_write_16bit,
+		ADE7854_CVRMSOS);
+static IIO_DEV_ATTR_VOLT_A(ade7854_read_24bit,
+		ADE7854_VAWV);
+static IIO_DEV_ATTR_VOLT_B(ade7854_read_24bit,
+		ADE7854_VBWV);
+static IIO_DEV_ATTR_VOLT_C(ade7854_read_24bit,
+		ADE7854_VCWV);
+static IIO_DEV_ATTR_CURRENT_A(ade7854_read_24bit,
+		ADE7854_IAWV);
+static IIO_DEV_ATTR_CURRENT_B(ade7854_read_24bit,
+		ADE7854_IBWV);
+static IIO_DEV_ATTR_CURRENT_C(ade7854_read_24bit,
+		ADE7854_ICWV);
+static IIO_DEV_ATTR_AWATTHR(ade7854_read_32bit,
+		ADE7854_AWATTHR);
+static IIO_DEV_ATTR_BWATTHR(ade7854_read_32bit,
+		ADE7854_BWATTHR);
+static IIO_DEV_ATTR_CWATTHR(ade7854_read_32bit,
+		ADE7854_CWATTHR);
+static IIO_DEV_ATTR_AFWATTHR(ade7854_read_32bit,
+		ADE7854_AFWATTHR);
+static IIO_DEV_ATTR_BFWATTHR(ade7854_read_32bit,
+		ADE7854_BFWATTHR);
+static IIO_DEV_ATTR_CFWATTHR(ade7854_read_32bit,
+		ADE7854_CFWATTHR);
+static IIO_DEV_ATTR_AVARHR(ade7854_read_32bit,
+		ADE7854_AVARHR);
+static IIO_DEV_ATTR_BVARHR(ade7854_read_32bit,
+		ADE7854_BVARHR);
+static IIO_DEV_ATTR_CVARHR(ade7854_read_32bit,
+		ADE7854_CVARHR);
+static IIO_DEV_ATTR_AVAHR(ade7854_read_32bit,
+		ADE7854_AVAHR);
+static IIO_DEV_ATTR_BVAHR(ade7854_read_32bit,
+		ADE7854_BVAHR);
+static IIO_DEV_ATTR_CVAHR(ade7854_read_32bit,
+		ADE7854_CVAHR);
+
+static int ade7854_set_irq(struct device *dev, bool enable)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+
+	int ret;
+	u32 irqen;
+
+	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
+	if (ret)
+		goto error_ret;
+
+	if (enable)
+		irqen |= 1 << 17; /* 1: interrupt enabled when all periodical
+				     (at 8 kHz rate) DSP computations finish. */
+	else
+		irqen &= ~(1 << 17);
+
+	ret = st->write_reg_32(dev, ADE7854_MASK0, irqen);
+	if (ret)
+		goto error_ret;
+
+error_ret:
+	return ret;
+}
+
+static int ade7854_initial_setup(struct ade7854_state *st)
+{
+	int ret;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* Disable IRQ */
+	ret = ade7854_set_irq(dev, false);
+	if (ret) {
+		dev_err(dev, "disable irq failed");
+		goto err_ret;
+	}
+
+	ade7854_reset(dev);
+	msleep(ADE7854_STARTUP_DELAY);
+
+err_ret:
+	return ret;
+}
+
+static IIO_DEV_ATTR_RESET(ade7854_write_reset);
+
+static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("8000");
+
+static IIO_CONST_ATTR(name, "ade7854");
+
+static struct attribute *ade7854_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group ade7854_event_attribute_group = {
+	.attrs = ade7854_event_attributes,
+};
+
+static struct attribute *ade7854_attributes[] = {
+	&iio_dev_attr_aigain.dev_attr.attr,
+	&iio_dev_attr_bigain.dev_attr.attr,
+	&iio_dev_attr_cigain.dev_attr.attr,
+	&iio_dev_attr_nigain.dev_attr.attr,
+	&iio_dev_attr_avgain.dev_attr.attr,
+	&iio_dev_attr_bvgain.dev_attr.attr,
+	&iio_dev_attr_cvgain.dev_attr.attr,
+	&iio_dev_attr_linecyc.dev_attr.attr,
+	&iio_dev_attr_sagcyc.dev_attr.attr,
+	&iio_dev_attr_cfcyc.dev_attr.attr,
+	&iio_dev_attr_peakcyc.dev_attr.attr,
+	&iio_dev_attr_chksum.dev_attr.attr,
+	&iio_dev_attr_apparent_power_a_gain.dev_attr.attr,
+	&iio_dev_attr_apparent_power_b_gain.dev_attr.attr,
+	&iio_dev_attr_apparent_power_c_gain.dev_attr.attr,
+	&iio_dev_attr_active_power_a_offset.dev_attr.attr,
+	&iio_dev_attr_active_power_b_offset.dev_attr.attr,
+	&iio_dev_attr_active_power_c_offset.dev_attr.attr,
+	&iio_dev_attr_reactive_power_a_gain.dev_attr.attr,
+	&iio_dev_attr_reactive_power_b_gain.dev_attr.attr,
+	&iio_dev_attr_reactive_power_c_gain.dev_attr.attr,
+	&iio_dev_attr_reactive_power_a_offset.dev_attr.attr,
+	&iio_dev_attr_reactive_power_b_offset.dev_attr.attr,
+	&iio_dev_attr_reactive_power_c_offset.dev_attr.attr,
+	&iio_dev_attr_awatthr.dev_attr.attr,
+	&iio_dev_attr_bwatthr.dev_attr.attr,
+	&iio_dev_attr_cwatthr.dev_attr.attr,
+	&iio_dev_attr_afwatthr.dev_attr.attr,
+	&iio_dev_attr_bfwatthr.dev_attr.attr,
+	&iio_dev_attr_cfwatthr.dev_attr.attr,
+	&iio_dev_attr_avarhr.dev_attr.attr,
+	&iio_dev_attr_bvarhr.dev_attr.attr,
+	&iio_dev_attr_cvarhr.dev_attr.attr,
+	&iio_dev_attr_angle0.dev_attr.attr,
+	&iio_dev_attr_angle1.dev_attr.attr,
+	&iio_dev_attr_angle2.dev_attr.attr,
+	&iio_dev_attr_avahr.dev_attr.attr,
+	&iio_dev_attr_bvahr.dev_attr.attr,
+	&iio_dev_attr_cvahr.dev_attr.attr,
+	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_vpeak.dev_attr.attr,
+	&iio_dev_attr_ipeak.dev_attr.attr,
+	&iio_dev_attr_aphcal.dev_attr.attr,
+	&iio_dev_attr_bphcal.dev_attr.attr,
+	&iio_dev_attr_cphcal.dev_attr.attr,
+	&iio_dev_attr_cf1den.dev_attr.attr,
+	&iio_dev_attr_cf2den.dev_attr.attr,
+	&iio_dev_attr_cf3den.dev_attr.attr,
+	&iio_dev_attr_airms.dev_attr.attr,
+	&iio_dev_attr_birms.dev_attr.attr,
+	&iio_dev_attr_cirms.dev_attr.attr,
+	&iio_dev_attr_nirms.dev_attr.attr,
+	&iio_dev_attr_avrms.dev_attr.attr,
+	&iio_dev_attr_bvrms.dev_attr.attr,
+	&iio_dev_attr_cvrms.dev_attr.attr,
+	&iio_dev_attr_airmsos.dev_attr.attr,
+	&iio_dev_attr_birmsos.dev_attr.attr,
+	&iio_dev_attr_cirmsos.dev_attr.attr,
+	&iio_dev_attr_avrmsos.dev_attr.attr,
+	&iio_dev_attr_bvrmsos.dev_attr.attr,
+	&iio_dev_attr_cvrmsos.dev_attr.attr,
+	&iio_dev_attr_volt_a.dev_attr.attr,
+	&iio_dev_attr_volt_b.dev_attr.attr,
+	&iio_dev_attr_volt_c.dev_attr.attr,
+	&iio_dev_attr_current_a.dev_attr.attr,
+	&iio_dev_attr_current_b.dev_attr.attr,
+	&iio_dev_attr_current_c.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ade7854_attribute_group = {
+	.attrs = ade7854_attributes,
+};
+
+int ade7854_probe(struct ade7854_state *st, struct device *dev)
+{
+	int ret, regdone = 0;
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADE7854_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADE7854_MAX_TX, GFP_KERNEL);
+	if (st->tx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_rx;
+	}
+	mutex_init(&st->buf_lock);
+	/* setup the industrialio driver allocated elements */
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_tx;
+	}
+
+	st->indio_dev->dev.parent = dev;
+	st->indio_dev->num_interrupt_lines = 1;
+	st->indio_dev->event_attrs = &ade7854_event_attribute_group;
+	st->indio_dev->attrs = &ade7854_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = ade7854_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = ade7854_initialize_ring(st->indio_dev->ring);
+	if (ret) {
+		printk(KERN_ERR "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+
+	if (st->irq) {
+		ret = iio_register_interrupt_line(st->irq,
+				st->indio_dev,
+				0,
+				IRQF_TRIGGER_FALLING,
+				"ade7854");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = ade7854_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+	/* Get the device into a sane initial state */
+	ret = ade7854_initial_setup(st);
+	if (ret)
+		goto error_remove_trigger;
+
+	return 0;
+
+error_remove_trigger:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		ade7854_remove_trigger(st->indio_dev);
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	ade7854_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	ade7854_unconfigure_ring(st->indio_dev);
+error_free_dev:
+	if (regdone)
+		iio_device_unregister(st->indio_dev);
+	else
+		iio_free_device(st->indio_dev);
+error_free_tx:
+	kfree(st->tx);
+error_free_rx:
+	kfree(st->rx);
+error_free_st:
+	kfree(st);
+	return ret;
+
+}
+EXPORT_SYMBOL(ade7854_probe);
+
+int ade7854_remove(struct ade7854_state *st)
+{
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	flush_scheduled_work();
+
+	ade7854_remove_trigger(indio_dev);
+	if (st->irq)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	ade7854_uninitialize_ring(indio_dev->ring);
+	ade7854_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+}
+EXPORT_SYMBOL(ade7854_remove);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
new file mode 100644
index 0000000..69737f0
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -0,0 +1,244 @@
+#ifndef _ADE7854_H
+#define _ADE7854_H
+
+#define ADE7854_AIGAIN    0x4380
+#define ADE7854_AVGAIN    0x4381
+#define ADE7854_BIGAIN    0x4382
+#define ADE7854_BVGAIN    0x4383
+#define ADE7854_CIGAIN    0x4384
+#define ADE7854_CVGAIN    0x4385
+#define ADE7854_NIGAIN    0x4386
+#define ADE7854_AIRMSOS   0x4387
+#define ADE7854_AVRMSOS   0x4388
+#define ADE7854_BIRMSOS   0x4389
+#define ADE7854_BVRMSOS   0x438A
+#define ADE7854_CIRMSOS   0x438B
+#define ADE7854_CVRMSOS   0x438C
+#define ADE7854_NIRMSOS   0x438D
+#define ADE7854_AVAGAIN   0x438E
+#define ADE7854_BVAGAIN   0x438F
+#define ADE7854_CVAGAIN   0x4390
+#define ADE7854_AWGAIN    0x4391
+#define ADE7854_AWATTOS   0x4392
+#define ADE7854_BWGAIN    0x4393
+#define ADE7854_BWATTOS   0x4394
+#define ADE7854_CWGAIN    0x4395
+#define ADE7854_CWATTOS   0x4396
+#define ADE7854_AVARGAIN  0x4397
+#define ADE7854_AVAROS    0x4398
+#define ADE7854_BVARGAIN  0x4399
+#define ADE7854_BVAROS    0x439A
+#define ADE7854_CVARGAIN  0x439B
+#define ADE7854_CVAROS    0x439C
+#define ADE7854_AFWGAIN   0x439D
+#define ADE7854_AFWATTOS  0x439E
+#define ADE7854_BFWGAIN   0x439F
+#define ADE7854_BFWATTOS  0x43A0
+#define ADE7854_CFWGAIN   0x43A1
+#define ADE7854_CFWATTOS  0x43A2
+#define ADE7854_AFVARGAIN 0x43A3
+#define ADE7854_AFVAROS   0x43A4
+#define ADE7854_BFVARGAIN 0x43A5
+#define ADE7854_BFVAROS   0x43A6
+#define ADE7854_CFVARGAIN 0x43A7
+#define ADE7854_CFVAROS   0x43A8
+#define ADE7854_VATHR1    0x43A9
+#define ADE7854_VATHR0    0x43AA
+#define ADE7854_WTHR1     0x43AB
+#define ADE7854_WTHR0     0x43AC
+#define ADE7854_VARTHR1   0x43AD
+#define ADE7854_VARTHR0   0x43AE
+#define ADE7854_RSV       0x43AF
+#define ADE7854_VANOLOAD  0x43B0
+#define ADE7854_APNOLOAD  0x43B1
+#define ADE7854_VARNOLOAD 0x43B2
+#define ADE7854_VLEVEL    0x43B3
+#define ADE7854_DICOEFF   0x43B5
+#define ADE7854_HPFDIS    0x43B6
+#define ADE7854_ISUMLVL   0x43B8
+#define ADE7854_ISUM      0x43BF
+#define ADE7854_AIRMS     0x43C0
+#define ADE7854_AVRMS     0x43C1
+#define ADE7854_BIRMS     0x43C2
+#define ADE7854_BVRMS     0x43C3
+#define ADE7854_CIRMS     0x43C4
+#define ADE7854_CVRMS     0x43C5
+#define ADE7854_NIRMS     0x43C6
+#define ADE7854_RUN       0xE228
+#define ADE7854_AWATTHR   0xE400
+#define ADE7854_BWATTHR   0xE401
+#define ADE7854_CWATTHR   0xE402
+#define ADE7854_AFWATTHR  0xE403
+#define ADE7854_BFWATTHR  0xE404
+#define ADE7854_CFWATTHR  0xE405
+#define ADE7854_AVARHR    0xE406
+#define ADE7854_BVARHR    0xE407
+#define ADE7854_CVARHR    0xE408
+#define ADE7854_AFVARHR   0xE409
+#define ADE7854_BFVARHR   0xE40A
+#define ADE7854_CFVARHR   0xE40B
+#define ADE7854_AVAHR     0xE40C
+#define ADE7854_BVAHR     0xE40D
+#define ADE7854_CVAHR     0xE40E
+#define ADE7854_IPEAK     0xE500
+#define ADE7854_VPEAK     0xE501
+#define ADE7854_STATUS0   0xE502
+#define ADE7854_STATUS1   0xE503
+#define ADE7854_OILVL     0xE507
+#define ADE7854_OVLVL     0xE508
+#define ADE7854_SAGLVL    0xE509
+#define ADE7854_MASK0     0xE50A
+#define ADE7854_MASK1     0xE50B
+#define ADE7854_IAWV      0xE50C
+#define ADE7854_IBWV      0xE50D
+#define ADE7854_ICWV      0xE50E
+#define ADE7854_VAWV      0xE510
+#define ADE7854_VBWV      0xE511
+#define ADE7854_VCWV      0xE512
+#define ADE7854_AWATT     0xE513
+#define ADE7854_BWATT     0xE514
+#define ADE7854_CWATT     0xE515
+#define ADE7854_AVA       0xE519
+#define ADE7854_BVA       0xE51A
+#define ADE7854_CVA       0xE51B
+#define ADE7854_CHECKSUM  0xE51F
+#define ADE7854_VNOM      0xE520
+#define ADE7854_PHSTATUS  0xE600
+#define ADE7854_ANGLE0    0xE601
+#define ADE7854_ANGLE1    0xE602
+#define ADE7854_ANGLE2    0xE603
+#define ADE7854_PERIOD    0xE607
+#define ADE7854_PHNOLOAD  0xE608
+#define ADE7854_LINECYC   0xE60C
+#define ADE7854_ZXTOUT    0xE60D
+#define ADE7854_COMPMODE  0xE60E
+#define ADE7854_GAIN      0xE60F
+#define ADE7854_CFMODE    0xE610
+#define ADE7854_CF1DEN    0xE611
+#define ADE7854_CF2DEN    0xE612
+#define ADE7854_CF3DEN    0xE613
+#define ADE7854_APHCAL    0xE614
+#define ADE7854_BPHCAL    0xE615
+#define ADE7854_CPHCAL    0xE616
+#define ADE7854_PHSIGN    0xE617
+#define ADE7854_CONFIG    0xE618
+#define ADE7854_MMODE     0xE700
+#define ADE7854_ACCMODE   0xE701
+#define ADE7854_LCYCMODE  0xE702
+#define ADE7854_PEAKCYC   0xE703
+#define ADE7854_SAGCYC    0xE704
+#define ADE7854_CFCYC     0xE705
+#define ADE7854_HSDC_CFG  0xE706
+#define ADE7854_CONFIG2   0xEC01
+
+#define ADE7854_READ_REG   0x1
+#define ADE7854_WRITE_REG  0x0
+
+#define ADE7854_MAX_TX    7
+#define ADE7854_MAX_RX    7
+#define ADE7854_STARTUP_DELAY 1
+
+#define ADE7854_SPI_SLOW	(u32)(300 * 1000)
+#define ADE7854_SPI_BURST	(u32)(1000 * 1000)
+#define ADE7854_SPI_FAST	(u32)(2000 * 1000)
+
+#define DRIVER_NAME		"ade7854"
+
+/**
+ * struct ade7854_state - device instance specific data
+ * @spi:			actual spi_device
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @inter:		used to check if new interrupt has been triggered
+ * @last_timestamp:	passing timestamp from th to bh of interrupt handler
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @tx:			transmit buffer
+ * @rx:			recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct ade7854_state {
+	struct spi_device		*spi;
+	struct i2c_client               *i2c;
+	struct work_struct		work_trigger_to_ring;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	int				(*read_reg_8) (struct device *, u16, u8 *);
+	int				(*read_reg_16) (struct device *, u16, u16 *);
+	int				(*read_reg_24) (struct device *, u16, u32 *);
+	int				(*read_reg_32) (struct device *, u16, u32 *);
+	int				(*write_reg_8) (struct device *, u16, u8);
+	int				(*write_reg_16) (struct device *, u16, u16);
+	int				(*write_reg_24) (struct device *, u16, u32);
+	int				(*write_reg_32) (struct device *, u16, u32);
+	int                             irq;
+	struct mutex			buf_lock;
+};
+
+extern int ade7854_probe(struct ade7854_state *st, struct device *dev);
+extern int ade7854_remove(struct ade7854_state *st);
+
+#ifdef CONFIG_IIO_RING_BUFFER
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum ade7854_scan {
+	ADE7854_SCAN_PHA_V,
+	ADE7854_SCAN_PHB_V,
+	ADE7854_SCAN_PHC_V,
+	ADE7854_SCAN_PHA_I,
+	ADE7854_SCAN_PHB_I,
+	ADE7854_SCAN_PHC_I,
+};
+
+void ade7854_remove_trigger(struct iio_dev *indio_dev);
+int ade7854_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t ade7854_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+
+int ade7854_configure_ring(struct iio_dev *indio_dev);
+void ade7854_unconfigure_ring(struct iio_dev *indio_dev);
+
+int ade7854_initialize_ring(struct iio_ring_buffer *ring);
+void ade7854_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void ade7854_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+static inline int ade7854_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+ade7854_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int ade7854_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void ade7854_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+static inline int ade7854_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+static inline void ade7854_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+#endif /* CONFIG_IIO_RING_BUFFER */
+
+#endif
-- 
1.7.3.2
