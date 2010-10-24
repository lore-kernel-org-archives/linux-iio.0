Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH 31/36] staging: iio: meter: new driver for ADE7758 devices
Date: Sun, 24 Oct 2010 17:22:33 -0400
Message-Id: <1287955358-3153-32-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/meter/Kconfig           |    9 +
 drivers/staging/iio/meter/Makefile          |    4 +
 drivers/staging/iio/meter/ade7758.h         |  171 ++++++
 drivers/staging/iio/meter/ade7758_core.c    |  866 +++++++++++++++++++++++++++
 drivers/staging/iio/meter/ade7758_ring.c    |  212 +++++++
 drivers/staging/iio/meter/ade7758_trigger.c |  125 ++++
 6 files changed, 1387 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/meter/ade7758.h
 create mode 100644 drivers/staging/iio/meter/ade7758_core.c
 create mode 100644 drivers/staging/iio/meter/ade7758_ring.c
 create mode 100644 drivers/staging/iio/meter/ade7758_trigger.c

diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index 19f20f4..be88bb8 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -16,3 +16,12 @@ config ADE7754
 	help
 	  Say yes here to build support for Analog Devices ADE7754 Polyphase
 	  Multifunction Energy Metering IC Driver.
+
+config ADE7758
+	tristate "Analog Devices ADE7758 Poly Phase Multifunction Energy Metering IC Driver"
+	depends on SPI
+	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	help
+	  Say yes here to build support for Analog Devices ADE7758 Polyphase
+	  Multifunction Energy Metering IC with Per Phase Information Driver.
diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
index 7f65b99..8e1a71d 100644
--- a/drivers/staging/iio/meter/Makefile
+++ b/drivers/staging/iio/meter/Makefile
@@ -4,3 +4,7 @@
 
 obj-$(CONFIG_ADE7753) += ade7753.o
 obj-$(CONFIG_ADE7754) += ade7754.o
+
+ade7758-y             := ade7758_core.o
+ade7758-$(CONFIG_IIO_RING_BUFFER) += ade7758_ring.o ade7758_trigger.o
+obj-$(CONFIG_ADE7758) += ade7758.o
diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
new file mode 100644
index 0000000..df5bb7b
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -0,0 +1,171 @@
+#ifndef _ADE7758_H
+#define _ADE7758_H
+
+#define ADE7758_AWATTHR   0x01
+#define ADE7758_BWATTHR   0x02
+#define ADE7758_CWATTHR   0x03
+#define ADE7758_AVARHR    0x04
+#define ADE7758_BVARHR    0x05
+#define ADE7758_CVARHR    0x06
+#define ADE7758_AVAHR     0x07
+#define ADE7758_BVAHR     0x08
+#define ADE7758_CVAHR     0x09
+#define ADE7758_AIRMS     0x0A
+#define ADE7758_BIRMS     0x0B
+#define ADE7758_CIRMS     0x0C
+#define ADE7758_AVRMS     0x0D
+#define ADE7758_BVRMS     0x0E
+#define ADE7758_CVRMS     0x0F
+#define ADE7758_FREQ      0x10
+#define ADE7758_TEMP      0x11
+#define ADE7758_WFORM     0x12
+#define ADE7758_OPMODE    0x13
+#define ADE7758_MMODE     0x14
+#define ADE7758_WAVMODE   0x15
+#define ADE7758_COMPMODE  0x16
+#define ADE7758_LCYCMODE  0x17
+#define ADE7758_MASK      0x18
+#define ADE7758_STATUS    0x19
+#define ADE7758_RSTATUS   0x1A
+#define ADE7758_ZXTOUT    0x1B
+#define ADE7758_LINECYC   0x1C
+#define ADE7758_SAGCYC    0x1D
+#define ADE7758_SAGLVL    0x1E
+#define ADE7758_VPINTLVL  0x1F
+#define ADE7758_IPINTLVL  0x20
+#define ADE7758_VPEAK     0x21
+#define ADE7758_IPEAK     0x22
+#define ADE7758_GAIN      0x23
+#define ADE7758_AVRMSGAIN 0x24
+#define ADE7758_BVRMSGAIN 0x25
+#define ADE7758_CVRMSGAIN 0x26
+#define ADE7758_AIGAIN    0x27
+#define ADE7758_BIGAIN    0x28
+#define ADE7758_CIGAIN    0x29
+#define ADE7758_AWG       0x2A
+#define ADE7758_BWG       0x2B
+#define ADE7758_CWG       0x2C
+#define ADE7758_AVARG     0x2D
+#define ADE7758_BVARG     0x2E
+#define ADE7758_CVARG     0x2F
+#define ADE7758_AVAG      0x30
+#define ADE7758_BVAG      0x31
+#define ADE7758_CVAG      0x32
+#define ADE7758_AVRMSOS   0x33
+#define ADE7758_BVRMSOS   0x34
+#define ADE7758_CVRMSOS   0x35
+#define ADE7758_AIRMSOS   0x36
+#define ADE7758_BIRMSOS   0x37
+#define ADE7758_CIRMSOS   0x38
+#define ADE7758_AWAITOS   0x39
+#define ADE7758_BWAITOS   0x3A
+#define ADE7758_CWAITOS   0x3B
+#define ADE7758_AVAROS    0x3C
+#define ADE7758_BVAROS    0x3D
+#define ADE7758_CVAROS    0x3E
+#define ADE7758_APHCAL    0x3F
+#define ADE7758_BPHCAL    0x40
+#define ADE7758_CPHCAL    0x41
+#define ADE7758_WDIV      0x42
+#define ADE7758_VADIV     0x44
+#define ADE7758_VARDIV    0x43
+#define ADE7758_APCFNUM   0x45
+#define ADE7758_APCFDEN   0x46
+#define ADE7758_VARCFNUM  0x47
+#define ADE7758_VARCFDEN  0x48
+#define ADE7758_CHKSUM    0x7E
+#define ADE7758_VERSION   0x7F
+
+#define ADE7758_READ_REG(a)    a
+#define ADE7758_WRITE_REG(a) ((a) | 0x80)
+
+#define ADE7758_MAX_TX    8
+#define ADE7758_MAX_RX    4
+#define ADE7758_STARTUP_DELAY 1
+
+#define ADE7758_SPI_SLOW	(u32)(300 * 1000)
+#define ADE7758_SPI_BURST	(u32)(1000 * 1000)
+#define ADE7758_SPI_FAST	(u32)(2000 * 1000)
+
+#define DRIVER_NAME		"ade7758"
+
+/**
+ * struct ade7758_state - device instance specific data
+ * @us:			actual spi_device
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @inter:		used to check if new interrupt has been triggered
+ * @last_timestamp:	passing timestamp from th to bh of interrupt handler
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @tx:			transmit buffer
+ * @rx:			recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct ade7758_state {
+	struct spi_device		*us;
+	struct work_struct		work_trigger_to_ring;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	struct mutex			buf_lock;
+};
+#ifdef CONFIG_IIO_RING_BUFFER
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum ade7758_scan {
+	ADE7758_SCAN_WFORM,
+};
+
+void ade7758_remove_trigger(struct iio_dev *indio_dev);
+int ade7758_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t ade7758_read_data_from_ring(struct device *dev,
+		struct device_attribute *attr,
+		char *buf);
+
+
+int ade7758_configure_ring(struct iio_dev *indio_dev);
+void ade7758_unconfigure_ring(struct iio_dev *indio_dev);
+
+int ade7758_initialize_ring(struct iio_ring_buffer *ring);
+void ade7758_uninitialize_ring(struct iio_ring_buffer *ring);
+int ade7758_set_irq(struct device *dev, bool enable);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void ade7758_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+static inline int ade7758_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+ade7758_read_data_from_ring(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return 0;
+}
+
+static int ade7758_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+static inline int ade7758_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+static inline void ade7758_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+#endif /* CONFIG_IIO_RING_BUFFER */
+
+#endif
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
new file mode 100644
index 0000000..b7634cb
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -0,0 +1,866 @@
+/*
+ * ADE7758 Polyphase Multifunction Energy Metering IC Driver
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
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "meter.h"
+#include "ade7758.h"
+
+int ade7758_spi_write_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_WRITE_REG(reg_address);
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7758_spi_write_reg_16(struct device *dev,
+		u8 reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 3,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_WRITE_REG(reg_address);
+	st->tx[1] = (value >> 8) & 0xFF;
+	st->tx[2] = value & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->us, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7758_spi_write_reg_24(struct device *dev,
+		u8 reg_address,
+		u32 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 4,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_WRITE_REG(reg_address);
+	st->tx[1] = (value >> 16) & 0xFF;
+	st->tx[2] = (value >> 8) & 0xFF;
+	st->tx[3] = value & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->us, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7758_spi_read_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 2,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_READ_REG(reg_address);
+	st->tx[1] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = st->rx[1];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7758_spi_read_reg_16(struct device *dev,
+		u8 reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 3,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_READ_REG(reg_address);
+	st->tx[1] = 0;
+	st->tx[2] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[1] << 8) | st->rx[2];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7758_spi_read_reg_24(struct device *dev,
+		u8 reg_address,
+		u32 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 4,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_READ_REG(reg_address);
+	st->tx[1] = 0;
+	st->tx[2] = 0;
+	st->tx[3] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(xfers, &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+		dev_err(&st->us->dev, "problem when reading 24 bit register 0x%02X",
+				reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static ssize_t ade7758_read_8bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u8 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = ade7758_spi_read_reg_8(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7758_read_16bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = ade7758_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7758_read_24bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u32 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = ade7758_spi_read_reg_24(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val & 0xFFFFFF);
+}
+
+static ssize_t ade7758_write_8bit(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = ade7758_spi_write_reg_8(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t ade7758_write_16bit(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = ade7758_spi_write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+int ade7758_reset(struct device *dev)
+{
+	int ret;
+	u8 val;
+	ade7758_spi_read_reg_8(dev,
+			ADE7758_OPMODE,
+			&val);
+	val |= 1 << 6; /* Software Chip Reset */
+	ret = ade7758_spi_write_reg_8(dev,
+			ADE7758_OPMODE,
+			val);
+
+	return ret;
+}
+
+static ssize_t ade7758_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return ade7758_reset(dev);
+	}
+	return -1;
+}
+
+static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_VPEAK);
+static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_VPEAK);
+static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_APHCAL);
+static IIO_DEV_ATTR_BPHCAL(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_BPHCAL);
+static IIO_DEV_ATTR_CPHCAL(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_CPHCAL);
+static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_WDIV);
+static IIO_DEV_ATTR_VADIV(S_IWUSR | S_IRUGO,
+		ade7758_read_8bit,
+		ade7758_write_8bit,
+		ADE7758_VADIV);
+static IIO_DEV_ATTR_AIRMS(S_IRUGO,
+		ade7758_read_24bit,
+		NULL,
+		ADE7758_AIRMS);
+static IIO_DEV_ATTR_BIRMS(S_IRUGO,
+		ade7758_read_24bit,
+		NULL,
+		ADE7758_BIRMS);
+static IIO_DEV_ATTR_CIRMS(S_IRUGO,
+		ade7758_read_24bit,
+		NULL,
+		ADE7758_CIRMS);
+static IIO_DEV_ATTR_AVRMS(S_IRUGO,
+		ade7758_read_24bit,
+		NULL,
+		ADE7758_AVRMS);
+static IIO_DEV_ATTR_BVRMS(S_IRUGO,
+		ade7758_read_24bit,
+		NULL,
+		ADE7758_BVRMS);
+static IIO_DEV_ATTR_CVRMS(S_IRUGO,
+		ade7758_read_24bit,
+		NULL,
+		ADE7758_CVRMS);
+static IIO_DEV_ATTR_AIRMSOS(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_AIRMSOS);
+static IIO_DEV_ATTR_BIRMSOS(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_BIRMSOS);
+static IIO_DEV_ATTR_CIRMSOS(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_CIRMSOS);
+static IIO_DEV_ATTR_AVRMSOS(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_AVRMSOS);
+static IIO_DEV_ATTR_BVRMSOS(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_BVRMSOS);
+static IIO_DEV_ATTR_CVRMSOS(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_CVRMSOS);
+static IIO_DEV_ATTR_AIGAIN(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_AIGAIN);
+static IIO_DEV_ATTR_BIGAIN(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_BIGAIN);
+static IIO_DEV_ATTR_CIGAIN(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_CIGAIN);
+static IIO_DEV_ATTR_AVRMSGAIN(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_AVRMSGAIN);
+static IIO_DEV_ATTR_BVRMSGAIN(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_BVRMSGAIN);
+static IIO_DEV_ATTR_CVRMSGAIN(S_IWUSR | S_IRUGO,
+		ade7758_read_16bit,
+		ade7758_write_16bit,
+		ADE7758_CVRMSGAIN);
+
+int ade7758_set_irq(struct device *dev, bool enable)
+{
+	int ret;
+	u32 irqen;
+	ret = ade7758_spi_read_reg_24(dev, ADE7758_MASK, &irqen);
+	if (ret)
+		goto error_ret;
+
+	if (enable)
+		irqen |= 1 << 16; /* Enables an interrupt when a data is
+				     present in the waveform register */
+	else
+		irqen &= ~(1 << 16);
+
+	ret = ade7758_spi_write_reg_24(dev, ADE7758_MASK, irqen);
+	if (ret)
+		goto error_ret;
+
+error_ret:
+	return ret;
+}
+
+/* Power down the device */
+static int ade7758_stop_device(struct device *dev)
+{
+	int ret;
+	u8 val;
+	ade7758_spi_read_reg_8(dev,
+			ADE7758_OPMODE,
+			&val);
+	val |= 7 << 3;  /* ADE7758 powered down */
+	ret = ade7758_spi_write_reg_8(dev,
+			ADE7758_OPMODE,
+			val);
+
+	return ret;
+}
+
+static int ade7758_initial_setup(struct ade7758_state *st)
+{
+	int ret;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* use low spi speed for init */
+	st->us->mode = SPI_MODE_3;
+	spi_setup(st->us);
+
+	/* Disable IRQ */
+	ret = ade7758_set_irq(dev, false);
+	if (ret) {
+		dev_err(dev, "disable irq failed");
+		goto err_ret;
+	}
+
+	ade7758_reset(dev);
+	msleep(ADE7758_STARTUP_DELAY);
+
+err_ret:
+	return ret;
+}
+
+static ssize_t ade7758_read_frequency(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret, len = 0;
+	u8 t;
+	int sps;
+	ret = ade7758_spi_read_reg_8(dev,
+			ADE7758_WAVMODE,
+			&t);
+	if (ret)
+		return ret;
+
+	t = (t >> 5) & 0x3;
+	sps = 26040 / (1 << t);
+
+	len = sprintf(buf, "%d SPS\n", sps);
+	return len;
+}
+
+static ssize_t ade7758_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	unsigned long val;
+	int ret;
+	u8 reg, t;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+
+	t = (26040 / val);
+	if (t > 0)
+		t >>= 1;
+
+	if (t > 1)
+		st->us->max_speed_hz = ADE7758_SPI_SLOW;
+	else
+		st->us->max_speed_hz = ADE7758_SPI_FAST;
+
+	ret = ade7758_spi_read_reg_8(dev,
+			ADE7758_WAVMODE,
+			&reg);
+	if (ret)
+		goto out;
+
+	reg &= ~(5 << 3);
+	reg |= t << 5;
+
+	ret = ade7758_spi_write_reg_8(dev,
+			ADE7758_WAVMODE,
+			reg);
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+static ssize_t ade7758_read_waveform_type(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret, len = 0;
+	u8 t;
+	ret = ade7758_spi_read_reg_8(dev,
+			ADE7758_WAVMODE,
+			&t);
+	if (ret)
+		return ret;
+
+	t = (t >> 2) & 0x7;
+
+	len = sprintf(buf, "%d\n", t);
+
+	return len;
+}
+
+static ssize_t ade7758_write_waveform_type(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+	u8 reg;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 4)
+		return -EINVAL;
+
+	mutex_lock(&indio_dev->mlock);
+
+	ret = ade7758_spi_read_reg_8(dev,
+			ADE7758_WAVMODE,
+			&reg);
+	if (ret)
+		goto out;
+
+	reg &= ~(7 << 2);
+	reg |= val << 2;
+
+	ret = ade7758_spi_write_reg_8(dev,
+			ADE7758_WAVMODE,
+			reg);
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_TEMP_RAW(ade7758_read_8bit);
+static IIO_CONST_ATTR(temp_offset, "129 C");
+static IIO_CONST_ATTR(temp_scale, "4 C");
+
+static IIO_DEV_ATTR_AWATTHR(ade7758_read_16bit,
+		ADE7758_AWATTHR);
+static IIO_DEV_ATTR_BWATTHR(ade7758_read_16bit,
+		ADE7758_BWATTHR);
+static IIO_DEV_ATTR_CWATTHR(ade7758_read_16bit,
+		ADE7758_CWATTHR);
+static IIO_DEV_ATTR_AVARHR(ade7758_read_16bit,
+		ADE7758_AVARHR);
+static IIO_DEV_ATTR_BVARHR(ade7758_read_16bit,
+		ADE7758_BVARHR);
+static IIO_DEV_ATTR_CVARHR(ade7758_read_16bit,
+		ADE7758_CVARHR);
+static IIO_DEV_ATTR_AVAHR(ade7758_read_16bit,
+		ADE7758_AVAHR);
+static IIO_DEV_ATTR_BVAHR(ade7758_read_16bit,
+		ADE7758_BVAHR);
+static IIO_DEV_ATTR_CVAHR(ade7758_read_16bit,
+		ADE7758_CVAHR);
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+		ade7758_read_frequency,
+		ade7758_write_frequency);
+
+/**
+ * IIO_DEV_ATTR_WAVEFORM_TYPE - set the type of waveform.
+ * @_mode: sysfs file mode/permissions
+ * @_show: output method for the attribute
+ * @_store: input method for the attribute
+ **/
+#define IIO_DEV_ATTR_WAVEFORM_TYPE(_mode, _show, _store)			\
+	IIO_DEVICE_ATTR(waveform_type, _mode, _show, _store, 0)
+
+static IIO_DEV_ATTR_WAVEFORM_TYPE(S_IWUSR | S_IRUGO,
+		ade7758_read_waveform_type,
+		ade7758_write_waveform_type);
+
+static IIO_DEV_ATTR_RESET(ade7758_write_reset);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
+
+static IIO_CONST_ATTR(name, "ade7758");
+
+static struct attribute *ade7758_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group ade7758_event_attribute_group = {
+	.attrs = ade7758_event_attributes,
+};
+
+static struct attribute *ade7758_attributes[] = {
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_waveform_type.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_awatthr.dev_attr.attr,
+	&iio_dev_attr_bwatthr.dev_attr.attr,
+	&iio_dev_attr_cwatthr.dev_attr.attr,
+	&iio_dev_attr_avarhr.dev_attr.attr,
+	&iio_dev_attr_bvarhr.dev_attr.attr,
+	&iio_dev_attr_cvarhr.dev_attr.attr,
+	&iio_dev_attr_avahr.dev_attr.attr,
+	&iio_dev_attr_bvahr.dev_attr.attr,
+	&iio_dev_attr_cvahr.dev_attr.attr,
+	&iio_dev_attr_vpeak.dev_attr.attr,
+	&iio_dev_attr_ipeak.dev_attr.attr,
+	&iio_dev_attr_aphcal.dev_attr.attr,
+	&iio_dev_attr_bphcal.dev_attr.attr,
+	&iio_dev_attr_cphcal.dev_attr.attr,
+	&iio_dev_attr_wdiv.dev_attr.attr,
+	&iio_dev_attr_vadiv.dev_attr.attr,
+	&iio_dev_attr_airms.dev_attr.attr,
+	&iio_dev_attr_birms.dev_attr.attr,
+	&iio_dev_attr_cirms.dev_attr.attr,
+	&iio_dev_attr_avrms.dev_attr.attr,
+	&iio_dev_attr_bvrms.dev_attr.attr,
+	&iio_dev_attr_cvrms.dev_attr.attr,
+	&iio_dev_attr_aigain.dev_attr.attr,
+	&iio_dev_attr_bigain.dev_attr.attr,
+	&iio_dev_attr_cigain.dev_attr.attr,
+	&iio_dev_attr_avrmsgain.dev_attr.attr,
+	&iio_dev_attr_bvrmsgain.dev_attr.attr,
+	&iio_dev_attr_cvrmsgain.dev_attr.attr,
+	&iio_dev_attr_airmsos.dev_attr.attr,
+	&iio_dev_attr_birmsos.dev_attr.attr,
+	&iio_dev_attr_cirmsos.dev_attr.attr,
+	&iio_dev_attr_avrmsos.dev_attr.attr,
+	&iio_dev_attr_bvrmsos.dev_attr.attr,
+	&iio_dev_attr_cvrmsos.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ade7758_attribute_group = {
+	.attrs = ade7758_attributes,
+};
+
+
+
+static int __devinit ade7758_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct ade7758_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADE7758_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADE7758_MAX_TX, GFP_KERNEL);
+	if (st->tx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_rx;
+	}
+	st->us = spi;
+	mutex_init(&st->buf_lock);
+	/* setup the industrialio driver allocated elements */
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_tx;
+	}
+
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->num_interrupt_lines = 1;
+	st->indio_dev->event_attrs = &ade7758_event_attribute_group;
+	st->indio_dev->attrs = &ade7758_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = ade7758_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = ade7758_initialize_ring(st->indio_dev->ring);
+	if (ret) {
+		printk(KERN_ERR "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+
+	if (spi->irq) {
+		ret = iio_register_interrupt_line(spi->irq,
+				st->indio_dev,
+				0,
+				IRQF_TRIGGER_FALLING,
+				"ade7758");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = ade7758_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	/* Get the device into a sane initial state */
+	ret = ade7758_initial_setup(st);
+	if (ret)
+		goto error_remove_trigger;
+	return 0;
+
+error_remove_trigger:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		ade7758_remove_trigger(st->indio_dev);
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	ade7758_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	ade7758_unconfigure_ring(st->indio_dev);
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
+error_ret:
+	return ret;
+}
+
+static int ade7758_remove(struct spi_device *spi)
+{
+	int ret;
+	struct ade7758_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	ret = ade7758_stop_device(&(indio_dev->dev));
+	if (ret)
+		goto err_ret;
+
+	flush_scheduled_work();
+
+	ade7758_remove_trigger(indio_dev);
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	ade7758_uninitialize_ring(indio_dev->ring);
+	iio_device_unregister(indio_dev);
+	ade7758_unconfigure_ring(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+
+err_ret:
+	return ret;
+}
+
+static struct spi_driver ade7758_driver = {
+	.driver = {
+		.name = "ade7758",
+		.owner = THIS_MODULE,
+	},
+	.probe = ade7758_probe,
+	.remove = __devexit_p(ade7758_remove),
+};
+
+static __init int ade7758_init(void)
+{
+	return spi_register_driver(&ade7758_driver);
+}
+module_init(ade7758_init);
+
+static __exit void ade7758_exit(void)
+{
+	spi_unregister_driver(&ade7758_driver);
+}
+module_exit(ade7758_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADE7758 Polyphase Multifunction Energy Metering IC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
new file mode 100644
index 0000000..274b4a0
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -0,0 +1,212 @@
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../ring_sw.h"
+#include "../accel/accel.h"
+#include "../trigger.h"
+#include "ade7758.h"
+
+/**
+ * combine_8_to_32() utility function to munge to u8s into u32
+ **/
+static inline u32 combine_8_to_32(u8 lower, u8 mid, u8 upper)
+{
+	u32 _lower = lower;
+	u32 _mid = mid;
+	u32 _upper = upper;
+
+	return _lower | (_mid << 8) | (_upper << 16);
+}
+
+static IIO_SCAN_EL_C(wform, ADE7758_SCAN_WFORM, ADE7758_WFORM, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(wform, s, 24, 32);
+static IIO_SCAN_EL_TIMESTAMP(1);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
+
+static struct attribute *ade7758_scan_el_attrs[] = {
+	&iio_scan_el_wform.dev_attr.attr,
+	&iio_const_attr_wform_index.dev_attr.attr,
+	&iio_const_attr_wform_type.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ade7758_scan_el_group = {
+	.attrs = ade7758_scan_el_attrs,
+	.name = "scan_elements",
+};
+
+/**
+ * ade7758_poll_func_th() top half interrupt handler called by trigger
+ * @private_data:	iio_dev
+ **/
+static void ade7758_poll_func_th(struct iio_dev *indio_dev, s64 time)
+{
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	st->last_timestamp = time;
+	schedule_work(&st->work_trigger_to_ring);
+	/* Indicate that this interrupt is being handled */
+
+	/* Technically this is trigger related, but without this
+	 * handler running there is currently no way for the interrupt
+	 * to clear.
+	 */
+}
+
+/**
+ * ade7758_spi_read_burst() - read all data registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @rx: somewhere to pass back the value read (min size is 24 bytes)
+ **/
+static int ade7758_spi_read_burst(struct device *dev, u8 *rx)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.rx_buf = rx,
+			.bits_per_word = 8,
+			.len = 4,
+		}, {
+			.tx_buf = st->tx + 4,
+			.rx_buf = rx,
+			.bits_per_word = 8,
+			.len = 4,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
+	st->tx[1] = 0;
+	st->tx[2] = 0;
+	st->tx[3] = 0;
+	st->tx[4] = ADE7758_READ_REG(ADE7758_WFORM);
+	st->tx[5] = 0;
+	st->tx[6] = 0;
+	st->tx[7] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret)
+		dev_err(&st->us->dev, "problem when reading WFORM value\n");
+
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
+ * specific to be rolled into the core.
+ */
+static void ade7758_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct ade7758_state *st
+		= container_of(work_s, struct ade7758_state,
+			       work_trigger_to_ring);
+	struct iio_ring_buffer *ring = st->indio_dev->ring;
+
+	int i = 0;
+	s32 *data;
+	size_t datasize = ring->access.get_bytes_per_datum(ring);
+
+	data = kmalloc(datasize, GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(&st->us->dev, "memory alloc failed in ring bh");
+		return;
+	}
+
+	if (ring->scan_count)
+		if (ade7758_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
+			for (; i < ring->scan_count; i++)
+				data[i] = combine_8_to_32(st->rx[i*2+2],
+						st->rx[i*2+1],
+						st->rx[i*2]);
+
+	/* Guaranteed to be aligned with 8 byte boundary */
+	if (ring->scan_timestamp)
+		*((s64 *)
+		(((u32)data + 4 * ring->scan_count + 4) & ~0x7)) =
+			st->last_timestamp;
+
+	ring->access.store_to(ring,
+			      (u8 *)data,
+			      st->last_timestamp);
+
+	iio_trigger_notify_done(st->indio_dev->trig);
+	kfree(data);
+
+	return;
+}
+
+void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
+{
+	kfree(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
+
+int ade7758_configure_ring(struct iio_dev *indio_dev)
+{
+	int ret = 0;
+	struct ade7758_state *st = indio_dev->dev_data;
+	struct iio_ring_buffer *ring;
+	INIT_WORK(&st->work_trigger_to_ring, ade7758_trigger_bh_to_ring);
+
+	ring = iio_sw_rb_allocate(indio_dev);
+	if (!ring) {
+		ret = -ENOMEM;
+		return ret;
+	}
+	indio_dev->ring = ring;
+	/* Effectively select the ring buffer implementation */
+	iio_ring_sw_register_funcs(&ring->access);
+	ring->bpe = 4;
+	ring->scan_el_attrs = &ade7758_scan_el_group;
+	ring->scan_timestamp = true;
+	ring->preenable = &iio_sw_ring_preenable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
+	ring->owner = THIS_MODULE;
+
+	/* Set default scan mode */
+	iio_scan_mask_set(ring, iio_scan_el_wform.number);
+
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &ade7758_poll_func_th);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
+	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	return 0;
+
+error_iio_sw_rb_free:
+	iio_sw_rb_free(indio_dev->ring);
+	return ret;
+}
+
+int ade7758_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return iio_ring_buffer_register(ring, 0);
+}
+
+void ade7758_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+	iio_ring_buffer_unregister(ring);
+}
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
new file mode 100644
index 0000000..60abca0
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -0,0 +1,125 @@
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/spi/spi.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../trigger.h"
+#include "ade7758.h"
+
+/**
+ * ade7758_data_rdy_trig_poll() the event handler for the data rdy trig
+ **/
+static int ade7758_data_rdy_trig_poll(struct iio_dev *dev_info,
+				       int index,
+				       s64 timestamp,
+				       int no_test)
+{
+	struct ade7758_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_trigger *trig = st->trig;
+
+	iio_trigger_poll(trig, timestamp);
+
+	return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(data_rdy_trig, &ade7758_data_rdy_trig_poll);
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static struct attribute *ade7758_trigger_attrs[] = {
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group ade7758_trigger_attr_group = {
+	.attrs = ade7758_trigger_attrs,
+};
+
+/**
+ * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
+ **/
+static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct ade7758_state *st = trig->private_data;
+	struct iio_dev *indio_dev = st->indio_dev;
+	int ret = 0;
+
+	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	ret = ade7758_set_irq(&st->indio_dev->dev, state);
+	if (state == false) {
+		iio_remove_event_from_list(&iio_event_data_rdy_trig,
+					   &indio_dev->interrupts[0]
+					   ->ev_list);
+		/* possible quirk with handler currently worked around
+		   by ensuring the work queue is empty */
+		flush_scheduled_work();
+	} else {
+		iio_add_event_to_list(&iio_event_data_rdy_trig,
+				      &indio_dev->interrupts[0]->ev_list);
+	}
+	return ret;
+}
+
+/**
+ * ade7758_trig_try_reen() try renabling irq for data rdy trigger
+ * @trig:	the datardy trigger
+ **/
+static int ade7758_trig_try_reen(struct iio_trigger *trig)
+{
+	struct ade7758_state *st = trig->private_data;
+	enable_irq(st->us->irq);
+	/* irq reenabled so success! */
+	return 0;
+}
+
+int ade7758_probe_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct ade7758_state *st = indio_dev->dev_data;
+
+	st->trig = iio_allocate_trigger();
+	st->trig->name = kasprintf(GFP_KERNEL,
+				"ade7758-dev%d",
+				indio_dev->id);
+	if (!st->trig->name) {
+		ret = -ENOMEM;
+		goto error_free_trig;
+	}
+	st->trig->dev.parent = &st->us->dev;
+	st->trig->owner = THIS_MODULE;
+	st->trig->private_data = st;
+	st->trig->set_trigger_state = &ade7758_data_rdy_trigger_set_state;
+	st->trig->try_reenable = &ade7758_trig_try_reen;
+	st->trig->control_attrs = &ade7758_trigger_attr_group;
+	ret = iio_trigger_register(st->trig);
+
+	/* select default trigger */
+	indio_dev->trig = st->trig;
+	if (ret)
+		goto error_free_trig_name;
+
+	return 0;
+
+error_free_trig_name:
+	kfree(st->trig->name);
+error_free_trig:
+	iio_free_trigger(st->trig);
+
+	return ret;
+}
+
+void ade7758_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct ade7758_state *state = indio_dev->dev_data;
+
+	iio_trigger_unregister(state->trig);
+	kfree(state->trig->name);
+	iio_free_trigger(state->trig);
+}
-- 
1.7.3.2
