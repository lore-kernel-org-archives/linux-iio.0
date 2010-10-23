Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH 12/19] staging: iio: meter: new driver for ADE7753/6 devices
Date: Sat, 23 Oct 2010 17:53:56 -0400
Message-Id: <1287870843-19835-12-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287870843-19835-1-git-send-email-vapier@gentoo.org>
References: <1287870843-19835-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

This also kicks off the new meter subsection.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/Kconfig         |    2 +-
 drivers/staging/iio/Makefile        |    3 +-
 drivers/staging/iio/meter/Kconfig   |   11 +
 drivers/staging/iio/meter/Makefile  |    5 +
 drivers/staging/iio/meter/ade7753.c |  730 +++++++++++++++++++++++++++++++++++
 drivers/staging/iio/meter/ade7753.h |  140 +++++++
 drivers/staging/iio/meter/meter.h   |  396 +++++++++++++++++++
 7 files changed, 1285 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/iio/meter/Kconfig
 create mode 100644 drivers/staging/iio/meter/Makefile
 create mode 100644 drivers/staging/iio/meter/ade7753.c
 create mode 100644 drivers/staging/iio/meter/ade7753.h
 create mode 100644 drivers/staging/iio/meter/meter.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 5e5bc47..ffe8912 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -49,7 +49,7 @@ source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/magnetometer/Kconfig"
-
+source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/trigger/Kconfig"
 
 endif # IIO
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 766a5d1..5b449a1 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -17,5 +17,6 @@ obj-y += dds/
 obj-y += gyro/
 obj-y += imu/
 obj-y += light/
-obj-y += trigger/
 obj-y += magnetometer/
+obj-y += meter/
+obj-y += trigger/
diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
new file mode 100644
index 0000000..0c09c39
--- /dev/null
+++ b/drivers/staging/iio/meter/Kconfig
@@ -0,0 +1,11 @@
+#
+# IIO meter drivers configuration
+#
+comment "Active energy metering IC"
+
+config ADE7753
+	tristate "Analog Devices ADE7753/6 Single-Phase Multifunction Metering IC Driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADE7753 Single-Phase Multifunction
+	  Metering IC with di/dt Sensor Interface.
diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
new file mode 100644
index 0000000..b4eac38
--- /dev/null
+++ b/drivers/staging/iio/meter/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for metering ic drivers
+#
+
+obj-$(CONFIG_ADE7753) += ade7753.o
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
new file mode 100644
index 0000000..23cb271
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -0,0 +1,730 @@
+/*
+ * ADE7753 Single-Phase Multifunction Metering IC with di/dt Sensor Interface Driver
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
+#include "ade7753.h"
+
+int ade7753_spi_write_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7753_WRITE_REG(reg_address);
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int ade7753_spi_write_reg_16(struct device *dev,
+		u8 reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 3,
+		}
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADE7753_WRITE_REG(reg_address);
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
+static int ade7753_spi_read_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
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
+	st->tx[0] = ADE7753_READ_REG(reg_address);
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
+static int ade7753_spi_read_reg_16(struct device *dev,
+		u8 reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
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
+	st->tx[0] = ADE7753_READ_REG(reg_address);
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
+static int ade7753_spi_read_reg_24(struct device *dev,
+		u8 reg_address,
+		u32 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
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
+	st->tx[0] = ADE7753_READ_REG(reg_address);
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
+static ssize_t ade7753_read_8bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u8 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = ade7753_spi_read_reg_8(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7753_read_16bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = ade7753_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t ade7753_read_24bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u32 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = ade7753_spi_read_reg_24(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val & 0xFFFFFF);
+}
+
+static ssize_t ade7753_write_8bit(struct device *dev,
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
+	ret = ade7753_spi_write_reg_8(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t ade7753_write_16bit(struct device *dev,
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
+	ret = ade7753_spi_write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static int ade7753_reset(struct device *dev)
+{
+	int ret;
+	u16 val;
+	ade7753_spi_read_reg_16(dev,
+			ADE7753_MODE,
+			&val);
+	val |= 1 << 6; /* Software Chip Reset */
+	ret = ade7753_spi_write_reg_16(dev,
+			ADE7753_MODE,
+			val);
+
+	return ret;
+}
+
+static ssize_t ade7753_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return ade7753_reset(dev);
+	}
+	return -1;
+}
+
+static IIO_DEV_ATTR_AENERGY(ade7753_read_24bit, ADE7753_AENERGY);
+static IIO_DEV_ATTR_LAENERGY(ade7753_read_24bit, ADE7753_LAENERGY);
+static IIO_DEV_ATTR_VAENERGY(ade7753_read_24bit, ADE7753_VAENERGY);
+static IIO_DEV_ATTR_LVAENERGY(ade7753_read_24bit, ADE7753_LVAENERGY);
+static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_CFDEN);
+static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_CFNUM);
+static IIO_DEV_ATTR_CHKSUM(ade7753_read_8bit, ADE7753_CHKSUM);
+static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_PHCAL);
+static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_APOS);
+static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_SAGCYC);
+static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_SAGLVL);
+static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_LINECYC);
+static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_WDIV);
+static IIO_DEV_ATTR_IRMS(S_IWUSR | S_IRUGO,
+		ade7753_read_24bit,
+		NULL,
+		ADE7753_IRMS);
+static IIO_DEV_ATTR_VRMS(S_IRUGO,
+		ade7753_read_24bit,
+		NULL,
+		ADE7753_VRMS);
+static IIO_DEV_ATTR_IRMSOS(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_IRMSOS);
+static IIO_DEV_ATTR_VRMSOS(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_VRMSOS);
+static IIO_DEV_ATTR_WGAIN(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_WGAIN);
+static IIO_DEV_ATTR_VAGAIN(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_VAGAIN);
+static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
+		ade7753_read_16bit,
+		ade7753_write_16bit,
+		ADE7753_GAIN);
+static IIO_DEV_ATTR_IPKLVL(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_IPKLVL);
+static IIO_DEV_ATTR_VPKLVL(S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_VPKLVL);
+static IIO_DEV_ATTR_IPEAK(S_IRUGO,
+		ade7753_read_24bit,
+		NULL,
+		ADE7753_IPEAK);
+static IIO_DEV_ATTR_VPEAK(S_IRUGO,
+		ade7753_read_24bit,
+		NULL,
+		ADE7753_VPEAK);
+static IIO_DEV_ATTR_VPERIOD(S_IRUGO,
+		ade7753_read_16bit,
+		NULL,
+		ADE7753_PERIOD);
+static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_CH1OS);
+static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
+		ade7753_read_8bit,
+		ade7753_write_8bit,
+		ADE7753_CH2OS);
+
+static int ade7753_set_irq(struct device *dev, bool enable)
+{
+	int ret;
+	u8 irqen;
+	ret = ade7753_spi_read_reg_8(dev, ADE7753_IRQEN, &irqen);
+	if (ret)
+		goto error_ret;
+
+	if (enable)
+		irqen |= 1 << 3; /* Enables an interrupt when a data is
+				    present in the waveform register */
+	else
+		irqen &= ~(1 << 3);
+
+	ret = ade7753_spi_write_reg_8(dev, ADE7753_IRQEN, irqen);
+	if (ret)
+		goto error_ret;
+
+error_ret:
+	return ret;
+}
+
+/* Power down the device */
+int ade7753_stop_device(struct device *dev)
+{
+	int ret;
+	u16 val;
+	ade7753_spi_read_reg_16(dev,
+			ADE7753_MODE,
+			&val);
+	val |= 1 << 4;  /* AD converters can be turned off */
+	ret = ade7753_spi_write_reg_16(dev,
+			ADE7753_MODE,
+			val);
+
+	return ret;
+}
+
+static int ade7753_initial_setup(struct ade7753_state *st)
+{
+	int ret;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* use low spi speed for init */
+	st->us->mode = SPI_MODE_3;
+	spi_setup(st->us);
+
+	/* Disable IRQ */
+	ret = ade7753_set_irq(dev, false);
+	if (ret) {
+		dev_err(dev, "disable irq failed");
+		goto err_ret;
+	}
+
+	ade7753_reset(dev);
+	msleep(ADE7753_STARTUP_DELAY);
+
+err_ret:
+	return ret;
+}
+
+static ssize_t ade7753_read_frequency(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret, len = 0;
+	u8 t;
+	int sps;
+	ret = ade7753_spi_read_reg_8(dev,
+			ADE7753_MODE,
+			&t);
+	if (ret)
+		return ret;
+
+	t = (t >> 11) & 0x3;
+	sps = 27900 / (1 + t);
+
+	len = sprintf(buf, "%d SPS\n", sps);
+	return len;
+}
+
+static ssize_t ade7753_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	unsigned long val;
+	int ret;
+	u16 reg, t;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+
+	t = (27900 / val);
+	if (t > 0)
+		t--;
+
+	if (t > 1)
+		st->us->max_speed_hz = ADE7753_SPI_SLOW;
+	else
+		st->us->max_speed_hz = ADE7753_SPI_FAST;
+
+	ret = ade7753_spi_read_reg_16(dev,
+			ADE7753_MODE,
+			&reg);
+	if (ret)
+		goto out;
+
+	reg &= ~(3 << 11);
+	reg |= t << 11;
+
+	ret = ade7753_spi_write_reg_16(dev,
+			ADE7753_MODE,
+			reg);
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+static IIO_DEV_ATTR_TEMP(ade7753_read_8bit);
+static IIO_CONST_ATTR(temp_offset, "-25 C");
+static IIO_CONST_ATTR(temp_scale, "0.67 C");
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+		ade7753_read_frequency,
+		ade7753_write_frequency);
+
+static IIO_DEV_ATTR_RESET(ade7753_write_reset);
+
+static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("27900 14000 7000 3500");
+
+static IIO_CONST_ATTR(name, "ade7753");
+
+static struct attribute *ade7753_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group ade7753_event_attribute_group = {
+	.attrs = ade7753_event_attributes,
+};
+
+static struct attribute *ade7753_attributes[] = {
+	&iio_dev_attr_temp.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_phcal.dev_attr.attr,
+	&iio_dev_attr_cfden.dev_attr.attr,
+	&iio_dev_attr_aenergy.dev_attr.attr,
+	&iio_dev_attr_laenergy.dev_attr.attr,
+	&iio_dev_attr_vaenergy.dev_attr.attr,
+	&iio_dev_attr_lvaenergy.dev_attr.attr,
+	&iio_dev_attr_cfnum.dev_attr.attr,
+	&iio_dev_attr_apos.dev_attr.attr,
+	&iio_dev_attr_sagcyc.dev_attr.attr,
+	&iio_dev_attr_saglvl.dev_attr.attr,
+	&iio_dev_attr_linecyc.dev_attr.attr,
+	&iio_dev_attr_chksum.dev_attr.attr,
+	&iio_dev_attr_pga_gain.dev_attr.attr,
+	&iio_dev_attr_wgain.dev_attr.attr,
+	&iio_dev_attr_choff_1.dev_attr.attr,
+	&iio_dev_attr_choff_2.dev_attr.attr,
+	&iio_dev_attr_wdiv.dev_attr.attr,
+	&iio_dev_attr_irms.dev_attr.attr,
+	&iio_dev_attr_vrms.dev_attr.attr,
+	&iio_dev_attr_irmsos.dev_attr.attr,
+	&iio_dev_attr_vrmsos.dev_attr.attr,
+	&iio_dev_attr_vagain.dev_attr.attr,
+	&iio_dev_attr_ipklvl.dev_attr.attr,
+	&iio_dev_attr_vpklvl.dev_attr.attr,
+	&iio_dev_attr_ipeak.dev_attr.attr,
+	&iio_dev_attr_vpeak.dev_attr.attr,
+	&iio_dev_attr_vperiod.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ade7753_attribute_group = {
+	.attrs = ade7753_attributes,
+};
+
+static int __devinit ade7753_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct ade7753_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADE7753_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADE7753_MAX_TX, GFP_KERNEL);
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
+	st->indio_dev->event_attrs = &ade7753_event_attribute_group;
+	st->indio_dev->attrs = &ade7753_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = ade7753_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = ade7753_initialize_ring(st->indio_dev->ring);
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
+				"ade7753");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = ade7753_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	/* Get the device into a sane initial state */
+	ret = ade7753_initial_setup(st);
+	if (ret)
+		goto error_remove_trigger;
+	return 0;
+
+error_remove_trigger:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		ade7753_remove_trigger(st->indio_dev);
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	ade7753_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	ade7753_unconfigure_ring(st->indio_dev);
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
+/* fixme, confirm ordering in this function */
+static int ade7753_remove(struct spi_device *spi)
+{
+	int ret;
+	struct ade7753_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	ret = ade7753_stop_device(&(indio_dev->dev));
+	if (ret)
+		goto err_ret;
+
+	flush_scheduled_work();
+
+	ade7753_remove_trigger(indio_dev);
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	ade7753_uninitialize_ring(indio_dev->ring);
+	ade7753_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
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
+static struct spi_driver ade7753_driver = {
+	.driver = {
+		.name = "ade7753",
+		.owner = THIS_MODULE,
+	},
+	.probe = ade7753_probe,
+	.remove = __devexit_p(ade7753_remove),
+};
+
+static __init int ade7753_init(void)
+{
+	return spi_register_driver(&ade7753_driver);
+}
+module_init(ade7753_init);
+
+static __exit void ade7753_exit(void)
+{
+	spi_unregister_driver(&ade7753_driver);
+}
+module_exit(ade7753_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADE7753/6 Single-Phase Multifunction Metering IC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
new file mode 100644
index 0000000..cc4a0d4
--- /dev/null
+++ b/drivers/staging/iio/meter/ade7753.h
@@ -0,0 +1,140 @@
+#ifndef _ADE7753_H
+#define _ADE7753_H
+
+#define ADE7753_WAVEFORM   0x01
+#define ADE7753_AENERGY    0x02
+#define ADE7753_RAENERGY   0x03
+#define ADE7753_LAENERGY   0x04
+#define ADE7753_VAENERGY   0x05
+#define ADE7753_RVAENERGY  0x06
+#define ADE7753_LVAENERGY  0x07
+#define ADE7753_LVARENERGY 0x08
+#define ADE7753_MODE       0x09
+#define ADE7753_IRQEN      0x0A
+#define ADE7753_STATUS     0x0B
+#define ADE7753_RSTSTATUS  0x0C
+#define ADE7753_CH1OS      0x0D
+#define ADE7753_CH2OS      0x0E
+#define ADE7753_GAIN       0x0F
+#define ADE7753_PHCAL      0x10
+#define ADE7753_APOS       0x11
+#define ADE7753_WGAIN      0x12
+#define ADE7753_WDIV       0x13
+#define ADE7753_CFNUM      0x14
+#define ADE7753_CFDEN      0x15
+#define ADE7753_IRMS       0x16
+#define ADE7753_VRMS       0x17
+#define ADE7753_IRMSOS     0x18
+#define ADE7753_VRMSOS     0x19
+#define ADE7753_VAGAIN     0x1A
+#define ADE7753_VADIV      0x1B
+#define ADE7753_LINECYC    0x1C
+#define ADE7753_ZXTOUT     0x1D
+#define ADE7753_SAGCYC     0x1E
+#define ADE7753_SAGLVL     0x1F
+#define ADE7753_IPKLVL     0x20
+#define ADE7753_VPKLVL     0x21
+#define ADE7753_IPEAK      0x22
+#define ADE7753_RSTIPEAK   0x23
+#define ADE7753_VPEAK      0x24
+#define ADE7753_RSTVPEAK   0x25
+#define ADE7753_TEMP       0x26
+#define ADE7753_PERIOD     0x27
+#define ADE7753_TMODE      0x3D
+#define ADE7753_CHKSUM     0x3E
+#define ADE7753_DIEREV     0x3F
+
+#define ADE7753_READ_REG(a)    a
+#define ADE7753_WRITE_REG(a) ((a) | 0x80)
+
+#define ADE7753_MAX_TX    4
+#define ADE7753_MAX_RX    4
+#define ADE7753_STARTUP_DELAY 1
+
+#define ADE7753_SPI_SLOW	(u32)(300 * 1000)
+#define ADE7753_SPI_BURST	(u32)(1000 * 1000)
+#define ADE7753_SPI_FAST	(u32)(2000 * 1000)
+
+#define DRIVER_NAME		"ade7753"
+
+/**
+ * struct ade7753_state - device instance specific data
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
+struct ade7753_state {
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
+enum ade7753_scan {
+	ADE7753_SCAN_ACTIVE_POWER,
+	ADE7753_SCAN_CH1,
+	ADE7753_SCAN_CH2,
+};
+
+void ade7753_remove_trigger(struct iio_dev *indio_dev);
+int ade7753_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t ade7753_read_data_from_ring(struct device *dev,
+		struct device_attribute *attr,
+		char *buf);
+
+
+int ade7753_configure_ring(struct iio_dev *indio_dev);
+void ade7753_unconfigure_ring(struct iio_dev *indio_dev);
+
+int ade7753_initialize_ring(struct iio_ring_buffer *ring);
+void ade7753_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void ade7753_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+static inline int ade7753_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+ade7753_read_data_from_ring(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return 0;
+}
+
+static int ade7753_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void ade7753_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+static inline int ade7753_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+static inline void ade7753_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+#endif /* CONFIG_IIO_RING_BUFFER */
+
+#endif
diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
new file mode 100644
index 0000000..142c50d
--- /dev/null
+++ b/drivers/staging/iio/meter/meter.h
@@ -0,0 +1,396 @@
+#include "../sysfs.h"
+
+/* metering ic types of attribute */
+
+#define IIO_DEV_ATTR_CURRENT_A_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(current_a_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_B_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(current_b_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_C_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(current_c_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VOLT_A_OFFSET(_mode, _show, _store, _addr)      \
+	IIO_DEVICE_ATTR(volt_a_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VOLT_B_OFFSET(_mode, _show, _store, _addr)      \
+	IIO_DEVICE_ATTR(volt_b_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VOLT_C_OFFSET(_mode, _show, _store, _addr)      \
+	IIO_DEVICE_ATTR(volt_c_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_REACTIVE_POWER_A_OFFSET(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(reactive_power_a_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_REACTIVE_POWER_B_OFFSET(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(reactive_power_b_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_REACTIVE_POWER_C_OFFSET(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(reactive_power_c_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_A_OFFSET(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_a_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_B_OFFSET(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_b_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_C_OFFSET(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_c_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_A_GAIN(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(current_a_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_B_GAIN(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(current_b_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_C_GAIN(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(current_c_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(apparent_power_a_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_APPARENT_POWER_B_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(apparent_power_b_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_APPARENT_POWER_C_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(apparent_power_c_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_A_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_a_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_B_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_b_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ACTIVE_POWER_C_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(active_power_c_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_REACTIVE_POWER_A_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(reactive_power_a_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_REACTIVE_POWER_B_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(reactive_power_b_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_REACTIVE_POWER_C_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(reactive_power_c_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_A(_show, _addr)			\
+	IIO_DEVICE_ATTR(current_a, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_B(_show, _addr)			\
+	IIO_DEVICE_ATTR(current_b, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CURRENT_C(_show, _addr)			\
+	IIO_DEVICE_ATTR(current_c, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_VOLT_A(_show, _addr)			\
+	IIO_DEVICE_ATTR(volt_a, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_VOLT_B(_show, _addr)			\
+	IIO_DEVICE_ATTR(volt_b, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_VOLT_C(_show, _addr)			\
+	IIO_DEVICE_ATTR(volt_c, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_AENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(aenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_LENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(lenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_RAENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(raenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_LAENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(laenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_VAENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(vaenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_LVAENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(lvaenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_RVAENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(rvaenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_LVARENERGY(_show, _addr)			\
+	IIO_DEVICE_ATTR(lvarenergy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CHKSUM(_show, _addr)                       \
+	IIO_DEVICE_ATTR(chksum, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ANGLE0(_show, _addr)                       \
+	IIO_DEVICE_ATTR(angle0, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ANGLE1(_show, _addr)                       \
+	IIO_DEVICE_ATTR(angle1, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ANGLE2(_show, _addr)                       \
+	IIO_DEVICE_ATTR(angle2, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_AWATTHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(awatthr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_BWATTHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(bwatthr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CWATTHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(cwatthr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_AFWATTHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(afwatthr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_BFWATTHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(bfwatthr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CFWATTHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(cfwatthr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_AVARHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(avarhr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_BVARHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(bvarhr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CVARHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(cvarhr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_AVAHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(avahr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_BVAHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(bvahr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_CVAHR(_show, _addr)			\
+	IIO_DEVICE_ATTR(cvahr, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_IOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(ios, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(vos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_PHCAL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(phcal, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_APHCAL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(aphcal, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BPHCAL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bphcal, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CPHCAL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cphcal, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_APOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(apos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AAPOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(aapos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BAPOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bapos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CAPOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(capos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AVRMSGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(avrmsgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BVRMSGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bvrmsgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CVRMSGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cvrmsgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AIGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(aigain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BIGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bigain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CIGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cigain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_NIGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(nigain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AVGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(avgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BVGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bvgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CVGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cvgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_WGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(wgain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_WDIV(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(wdiv, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CFNUM(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cfnum, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CFDEN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cfden, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CF1DEN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cf1den, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CF2DEN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cf2den, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CF3DEN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cf3den, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_IRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(irms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(vrms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AIRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(airms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BIRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(birms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CIRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cirms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_NIRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(nirms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AVRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(avrms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BVRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bvrms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CVRMS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cvrms, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_IRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(irmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(vrmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AIRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(airmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BIRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(birmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CIRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cirmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_AVRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(avrmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_BVRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(bvrmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CVRMSOS(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cvrmsos, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VAGAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(vagain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_PGA_GAIN(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(pga_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VADIV(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(vadiv, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_LINECYC(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(linecyc, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_SAGCYC(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(sagcyc, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CFCYC(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(cfcyc, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_PEAKCYC(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(peakcyc, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_SAGLVL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(saglvl, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_IPKLVL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(ipklvl, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VPKLVL(_mode, _show, _store, _addr)                \
+	IIO_DEVICE_ATTR(vpklvl, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_IPEAK(_mode, _show, _store, _addr)			\
+	IIO_DEVICE_ATTR(ipeak, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_RIPEAK(_mode, _show, _store, _addr)			\
+	IIO_DEVICE_ATTR(ripeak, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VPEAK(_mode, _show, _store, _addr)			\
+	IIO_DEVICE_ATTR(vpeak, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_RVPEAK(_mode, _show, _store, _addr)			\
+	IIO_DEVICE_ATTR(rvpeak, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)			\
+	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)			\
+  IIO_DEVICE_ATTR(choff_##_num, _mode, _show, _store, _addr)
+
+/* active energy register, AENERGY, is more than half full */
+#define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)
+
+/* a SAG on the line voltage */
+#define IIO_EVENT_ATTR_LINE_VOLT_SAG(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(line_volt_sag, _evlist, _show, _store, _mask)
+
+/*
+ * Indicates the end of energy accumulation over an integer number
+ * of half line cycles
+ */
+#define IIO_EVENT_ATTR_CYCEND(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(cycend, _evlist, _show, _store, _mask)
+
+/* on the rising and falling edge of the the voltage waveform */
+#define IIO_EVENT_ATTR_ZERO_CROSS(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(zero_cross, _evlist, _show, _store, _mask)
+
+/* the active energy register has overflowed */
+#define IIO_EVENT_ATTR_AENERGY_OVERFLOW(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(aenergy_overflow, _evlist, _show, _store, _mask)
+
+/* the apparent energy register has overflowed */
+#define IIO_EVENT_ATTR_VAENERGY_OVERFLOW(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(vaenergy_overflow, _evlist, _show, _store, _mask)
+
+/* the active energy register, VAENERGY, is more than half full */
+#define IIO_EVENT_ATTR_VAENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(vaenergy_half_full, _evlist, _show, _store, _mask)
+
+/* the power has gone from negative to positive */
+#define IIO_EVENT_ATTR_PPOS(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(ppos, _evlist, _show, _store, _mask)
+
+/* the power has gone from positive to negative */
+#define IIO_EVENT_ATTR_PNEG(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(pneg, _evlist, _show, _store, _mask)
+
+/* waveform sample from Channel 1 has exceeded the IPKLVL value */
+#define IIO_EVENT_ATTR_IPKLVL_EXC(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(ipklvl_exc, _evlist, _show, _store, _mask)
+
+/* waveform sample from Channel 2 has exceeded the VPKLVL value */
+#define IIO_EVENT_ATTR_VPKLVL_EXC(_evlist, _show, _store, _mask) \
+	IIO_EVENT_ATTR_SH(vpklvl_exc, _evlist, _show, _store, _mask)
+
-- 
1.7.3.2
