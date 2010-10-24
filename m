Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH 03/36] staging: iio: new adis16204 driver
Date: Sun, 24 Oct 2010 17:22:05 -0400
Message-Id: <1287955358-3153-4-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

IIO driver for Programmable High-g Digital Impact Sensor and Recorder.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/accel/Kconfig             |    9 +
 drivers/staging/iio/accel/Makefile            |    4 +
 drivers/staging/iio/accel/accel.h             |   20 +
 drivers/staging/iio/accel/adis16204.h         |  151 ++++++
 drivers/staging/iio/accel/adis16204_core.c    |  613 +++++++++++++++++++++++++
 drivers/staging/iio/accel/adis16204_ring.c    |  206 +++++++++
 drivers/staging/iio/accel/adis16204_trigger.c |  122 +++++
 7 files changed, 1125 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/accel/adis16204.h
 create mode 100644 drivers/staging/iio/accel/adis16204_core.c
 create mode 100644 drivers/staging/iio/accel/adis16204_ring.c
 create mode 100644 drivers/staging/iio/accel/adis16204_trigger.c

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index cc057c6..a34f1d3 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -21,6 +21,15 @@ config ADIS16203
 	  Say yes here to build support for Analog Devices adis16203 Programmable
 	  360 Degrees Inclinometer.
 
+config ADIS16204
+	tristate "Analog Devices ADIS16204 Programmable High-g Digital Impact Sensor and Recorder"
+	depends on SPI
+	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	help
+	  Say yes here to build support for Analog Devices adis16204 Programmable
+	  High-g Digital Impact Sensor and Recorder.
+
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 76cc92f..1b2a6d3 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -10,6 +10,10 @@ adis16203-y             := adis16203_core.o
 adis16203-$(CONFIG_IIO_RING_BUFFER) += adis16203_ring.o adis16203_trigger.o
 obj-$(CONFIG_ADIS16203) += adis16203.o
 
+adis16204-y             := adis16204_core.o
+adis16204-$(CONFIG_IIO_RING_BUFFER) += adis16204_ring.o adis16204_trigger.o
+obj-$(CONFIG_ADIS16204) += adis16204.o
+
 adis16209-y             := adis16209_core.o
 adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/accel/accel.h
index f5f61b2..50651f8 100644
--- a/drivers/staging/iio/accel/accel.h
+++ b/drivers/staging/iio/accel/accel.h
@@ -65,3 +65,23 @@
 #define IIO_DEV_ATTR_ACCEL_Z(_show, _addr)			\
 	IIO_DEVICE_ATTR(accel_z_raw, S_IRUGO, _show, NULL, _addr)
 
+#define IIO_DEV_ATTR_ACCEL_XY(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_xy, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_PEAK(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_peak, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_XPEAK(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_xpeak, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_YPEAK(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_ypeak, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_ZPEAK(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_zpeak, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_XYPEAK(_show, _addr)		\
+	IIO_DEVICE_ATTR(accel_xypeak, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ACCEL_XYZPEAK(_show, _addr)		\
+	IIO_DEVICE_ATTR(accel_xyzpeak, S_IRUGO, _show, NULL, _addr)
diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
new file mode 100644
index 0000000..e9ed7cb
--- /dev/null
+++ b/drivers/staging/iio/accel/adis16204.h
@@ -0,0 +1,151 @@
+#ifndef SPI_ADIS16204_H_
+#define SPI_ADIS16204_H_
+
+#define ADIS16204_STARTUP_DELAY	220 /* ms */
+
+#define ADIS16204_READ_REG(a)    a
+#define ADIS16204_WRITE_REG(a) ((a) | 0x80)
+
+#define ADIS16204_FLASH_CNT      0x00 /* Flash memory write count */
+#define ADIS16204_SUPPLY_OUT     0x02 /* Output, power supply */
+#define ADIS16204_XACCL_OUT      0x04 /* Output, x-axis accelerometer */
+#define ADIS16204_YACCL_OUT      0x06 /* Output, y-axis accelerometer */
+#define ADIS16204_AUX_ADC        0x08 /* Output, auxiliary ADC input */
+#define ADIS16204_TEMP_OUT       0x0A /* Output, temperature */
+#define ADIS16204_X_PEAK_OUT     0x0C /* Twos complement */
+#define ADIS16204_Y_PEAK_OUT     0x0E /* Twos complement */
+#define ADIS16204_XACCL_NULL     0x10 /* Calibration, x-axis acceleration offset null */
+#define ADIS16204_YACCL_NULL     0x12 /* Calibration, y-axis acceleration offset null */
+#define ADIS16204_XACCL_SCALE    0x14 /* X-axis scale factor calibration register */
+#define ADIS16204_YACCL_SCALE    0x16 /* Y-axis scale factor calibration register */
+#define ADIS16204_XY_RSS_OUT     0x18 /* XY combined acceleration (RSS) */
+#define ADIS16204_XY_PEAK_OUT    0x1A /* Peak, XY combined output (RSS) */
+#define ADIS16204_CAP_BUF_1      0x1C /* Capture buffer output register 1 */
+#define ADIS16204_CAP_BUF_2      0x1E /* Capture buffer output register 2 */
+#define ADIS16204_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
+#define ADIS16204_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
+#define ADIS16204_ALM_CTRL       0x28 /* Alarm control */
+#define ADIS16204_CAPT_PNTR      0x2A /* Capture register address pointer */
+#define ADIS16204_AUX_DAC        0x30 /* Auxiliary DAC data */
+#define ADIS16204_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
+#define ADIS16204_MSC_CTRL       0x34 /* Miscellaneous control */
+#define ADIS16204_SMPL_PRD       0x36 /* Internal sample period (rate) control */
+#define ADIS16204_AVG_CNT        0x38 /* Operation, filter configuration */
+#define ADIS16204_SLP_CNT        0x3A /* Operation, sleep mode control */
+#define ADIS16204_DIAG_STAT      0x3C /* Diagnostics, system status register */
+#define ADIS16204_GLOB_CMD       0x3E /* Operation, system command register */
+
+#define ADIS16204_OUTPUTS        5
+
+/* MSC_CTRL */
+#define ADIS16204_MSC_CTRL_PWRUP_SELF_TEST	(1 << 10) /* Self-test at power-on: 1 = disabled, 0 = enabled */
+#define ADIS16204_MSC_CTRL_SELF_TEST_EN	        (1 << 8)  /* Self-test enable */
+#define ADIS16204_MSC_CTRL_DATA_RDY_EN	        (1 << 2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
+#define ADIS16204_MSC_CTRL_ACTIVE_HIGH	        (1 << 1)  /* Data-ready polarity: 1 = active high, 0 = active low */
+#define ADIS16204_MSC_CTRL_DATA_RDY_DIO2	(1 << 0)  /* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
+
+/* DIAG_STAT */
+#define ADIS16204_DIAG_STAT_ALARM2        (1<<9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16204_DIAG_STAT_ALARM1        (1<<8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16204_DIAG_STAT_SELFTEST_FAIL (1<<5) /* Self-test diagnostic error flag: 1 = error condition,
+						0 = normal operation */
+#define ADIS16204_DIAG_STAT_SPI_FAIL	  (1<<3) /* SPI communications failure */
+#define ADIS16204_DIAG_STAT_FLASH_UPT	  (1<<2) /* Flash update failure */
+#define ADIS16204_DIAG_STAT_POWER_HIGH	  (1<<1) /* Power supply above 3.625 V */
+#define ADIS16204_DIAG_STAT_POWER_LOW	  (1<<0) /* Power supply below 2.975 V */
+
+/* GLOB_CMD */
+#define ADIS16204_GLOB_CMD_SW_RESET	(1<<7)
+#define ADIS16204_GLOB_CMD_CLEAR_STAT	(1<<4)
+#define ADIS16204_GLOB_CMD_FACTORY_CAL	(1<<1)
+
+#define ADIS16204_MAX_TX 24
+#define ADIS16204_MAX_RX 24
+
+#define ADIS16204_ERROR_ACTIVE          (1<<14)
+
+/**
+ * struct adis16204_state - device instance specific data
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
+struct adis16204_state {
+	struct spi_device		*us;
+	struct work_struct		work_trigger_to_ring;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	struct mutex			buf_lock;
+};
+
+int adis16204_set_irq(struct device *dev, bool enable);
+
+#ifdef CONFIG_IIO_RING_BUFFER
+enum adis16204_scan {
+	ADIS16204_SCAN_SUPPLY,
+	ADIS16204_SCAN_ACC_X,
+	ADIS16204_SCAN_ACC_Y,
+	ADIS16204_SCAN_AUX_ADC,
+	ADIS16204_SCAN_TEMP,
+};
+
+void adis16204_remove_trigger(struct iio_dev *indio_dev);
+int adis16204_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t adis16204_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+int adis16204_configure_ring(struct iio_dev *indio_dev);
+void adis16204_unconfigure_ring(struct iio_dev *indio_dev);
+
+int adis16204_initialize_ring(struct iio_ring_buffer *ring);
+void adis16204_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void adis16204_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16204_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+adis16204_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int adis16204_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16204_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+
+static inline void adis16204_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* SPI_ADIS16204_H_ */
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
new file mode 100644
index 0000000..cc15e40
--- /dev/null
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -0,0 +1,613 @@
+/*
+ * ADIS16204 Programmable High-g Digital Impact Sensor and Recorder
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
+#include "accel.h"
+#include "../gyro/gyro.h"
+#include "../adc/adc.h"
+
+#include "adis16204.h"
+
+#define DRIVER_NAME		"adis16204"
+
+static int adis16204_check_status(struct device *dev);
+
+/**
+ * adis16204_spi_write_reg_8() - write single byte to a register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the register to be written
+ * @val: the value to write
+ **/
+static int adis16204_spi_write_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16204_WRITE_REG(reg_address);
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/**
+ * adis16204_spi_write_reg_16() - write 2 bytes to a pair of registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: value to be written
+ **/
+static int adis16204_spi_write_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+		}, {
+			.tx_buf = st->tx + 2,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16204_WRITE_REG(lower_reg_address);
+	st->tx[1] = value & 0xFF;
+	st->tx[2] = ADIS16204_WRITE_REG(lower_reg_address + 1);
+	st->tx[3] = (value >> 8) & 0xFF;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	ret = spi_sync(st->us, &msg);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/**
+ * adis16204_spi_read_reg_16() - read 2 bytes from a 16-bit register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: somewhere to pass back the value read
+ **/
+static int adis16204_spi_read_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 20,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 20,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16204_READ_REG(lower_reg_address);
+	st->tx[1] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
+				lower_reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[0] << 8) | st->rx[1];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static ssize_t adis16204_read_12bit_unsigned(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16204_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16204_ERROR_ACTIVE)
+		adis16204_check_status(dev);
+
+	return sprintf(buf, "%u\n", val & 0x0FFF);
+}
+
+static ssize_t adis16204_read_temp(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+	u16 val;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+
+	ret = adis16204_spi_read_reg_16(dev, ADIS16204_TEMP_OUT, (u16 *)&val);
+	if (ret)
+		goto error_ret;
+
+	if (val & ADIS16204_ERROR_ACTIVE)
+		adis16204_check_status(dev);
+
+	val &= 0xFFF;
+	ret = sprintf(buf, "%d\n", val);
+
+error_ret:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+static ssize_t adis16204_read_12bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	s16 val = 0;
+	ssize_t ret;
+
+	mutex_lock(&indio_dev->mlock);
+
+	ret = adis16204_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	if (!ret) {
+		if (val & ADIS16204_ERROR_ACTIVE)
+			adis16204_check_status(dev);
+
+		val = ((s16)(val << 4) >> 4);
+		ret = sprintf(buf, "%d\n", val);
+	}
+
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16204_read_14bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	s16 val = 0;
+	ssize_t ret;
+
+	mutex_lock(&indio_dev->mlock);
+
+	ret = adis16204_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	if (!ret) {
+		if (val & ADIS16204_ERROR_ACTIVE)
+			adis16204_check_status(dev);
+
+		val = ((s16)(val << 2) >> 2);
+		ret = sprintf(buf, "%d\n", val);
+	}
+
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16204_write_16bit(struct device *dev,
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
+	ret = adis16204_spi_write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static int adis16204_reset(struct device *dev)
+{
+	int ret;
+	ret = adis16204_spi_write_reg_8(dev,
+			ADIS16204_GLOB_CMD,
+			ADIS16204_GLOB_CMD_SW_RESET);
+	if (ret)
+		dev_err(dev, "problem resetting device");
+
+	return ret;
+}
+
+static ssize_t adis16204_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -EINVAL;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return adis16204_reset(dev);
+	}
+	return -EINVAL;
+}
+
+int adis16204_set_irq(struct device *dev, bool enable)
+{
+	int ret = 0;
+	u16 msc;
+
+	ret = adis16204_spi_read_reg_16(dev, ADIS16204_MSC_CTRL, &msc);
+	if (ret)
+		goto error_ret;
+
+	msc |= ADIS16204_MSC_CTRL_ACTIVE_HIGH;
+	msc &= ~ADIS16204_MSC_CTRL_DATA_RDY_DIO2;
+	if (enable)
+		msc |= ADIS16204_MSC_CTRL_DATA_RDY_EN;
+	else
+		msc &= ~ADIS16204_MSC_CTRL_DATA_RDY_EN;
+
+	ret = adis16204_spi_write_reg_16(dev, ADIS16204_MSC_CTRL, msc);
+
+error_ret:
+	return ret;
+}
+
+static int adis16204_check_status(struct device *dev)
+{
+	u16 status;
+	int ret;
+
+	ret = adis16204_spi_read_reg_16(dev, ADIS16204_DIAG_STAT, &status);
+	if (ret < 0) {
+		dev_err(dev, "Reading status failed\n");
+		goto error_ret;
+	}
+	ret = status & 0x1F;
+
+	if (status & ADIS16204_DIAG_STAT_SELFTEST_FAIL)
+		dev_err(dev, "Self test failure\n");
+	if (status & ADIS16204_DIAG_STAT_SPI_FAIL)
+		dev_err(dev, "SPI failure\n");
+	if (status & ADIS16204_DIAG_STAT_FLASH_UPT)
+		dev_err(dev, "Flash update failed\n");
+	if (status & ADIS16204_DIAG_STAT_POWER_HIGH)
+		dev_err(dev, "Power supply above 3.625V\n");
+	if (status & ADIS16204_DIAG_STAT_POWER_LOW)
+		dev_err(dev, "Power supply below 2.975V\n");
+
+error_ret:
+	return ret;
+}
+
+static int adis16204_self_test(struct device *dev)
+{
+	int ret;
+	ret = adis16204_spi_write_reg_16(dev,
+			ADIS16204_MSC_CTRL,
+			ADIS16204_MSC_CTRL_SELF_TEST_EN);
+	if (ret) {
+		dev_err(dev, "problem starting self test");
+		goto err_ret;
+	}
+
+	adis16204_check_status(dev);
+
+err_ret:
+	return ret;
+}
+
+static int adis16204_initial_setup(struct adis16204_state *st)
+{
+	int ret;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* Disable IRQ */
+	ret = adis16204_set_irq(dev, false);
+	if (ret) {
+		dev_err(dev, "disable irq failed");
+		goto err_ret;
+	}
+
+	/* Do self test */
+	ret = adis16204_self_test(dev);
+	if (ret) {
+		dev_err(dev, "self test failure");
+		goto err_ret;
+	}
+
+	/* Read status register to check the result */
+	ret = adis16204_check_status(dev);
+	if (ret) {
+		adis16204_reset(dev);
+		dev_err(dev, "device not playing ball -> reset");
+		msleep(ADIS16204_STARTUP_DELAY);
+		ret = adis16204_check_status(dev);
+		if (ret) {
+			dev_err(dev, "giving up");
+			goto err_ret;
+		}
+	}
+
+	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
+			st->us->chip_select, st->us->irq);
+
+err_ret:
+	return ret;
+}
+
+static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16204_read_12bit_unsigned,
+		ADIS16204_SUPPLY_OUT);
+static IIO_CONST_ATTR(in0_supply_scale, "0.00122");
+static IIO_DEV_ATTR_IN_RAW(1, adis16204_read_12bit_unsigned,
+		ADIS16204_AUX_ADC);
+static IIO_CONST_ATTR(in1_scale, "0.00061");
+
+static IIO_DEV_ATTR_ACCEL_X(adis16204_read_14bit_signed,
+		ADIS16204_XACCL_OUT);
+static IIO_DEV_ATTR_ACCEL_Y(adis16204_read_14bit_signed,
+		ADIS16204_YACCL_OUT);
+static IIO_DEV_ATTR_ACCEL_XY(adis16204_read_14bit_signed,
+		ADIS16204_XY_RSS_OUT);
+static IIO_DEV_ATTR_ACCEL_XPEAK(adis16204_read_14bit_signed,
+		ADIS16204_X_PEAK_OUT);
+static IIO_DEV_ATTR_ACCEL_YPEAK(adis16204_read_14bit_signed,
+		ADIS16204_Y_PEAK_OUT);
+static IIO_DEV_ATTR_ACCEL_XYPEAK(adis16204_read_14bit_signed,
+		ADIS16204_XY_PEAK_OUT);
+static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+		adis16204_read_12bit_signed,
+		adis16204_write_16bit,
+		ADIS16204_XACCL_NULL);
+static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+		adis16204_read_12bit_signed,
+		adis16204_write_16bit,
+		ADIS16204_YACCL_NULL);
+static IIO_CONST_ATTR(accel_x_scale, "0.017125");
+static IIO_CONST_ATTR(accel_y_scale, "0.008407");
+static IIO_CONST_ATTR(accel_xy_scale, "0.017125");
+
+static IIO_DEV_ATTR_TEMP_RAW(adis16204_read_temp);
+static IIO_CONST_ATTR(temp_offset, "25");
+static IIO_CONST_ATTR(temp_scale, "-0.47");
+
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16204_write_reset, 0);
+
+static IIO_CONST_ATTR(name, "adis16204");
+
+static struct attribute *adis16204_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group adis16204_event_attribute_group = {
+	.attrs = adis16204_event_attributes,
+};
+
+static struct attribute *adis16204_attributes[] = {
+	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
+	&iio_const_attr_in0_supply_scale.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_in1_scale.dev_attr.attr,
+	&iio_dev_attr_accel_x_raw.dev_attr.attr,
+	&iio_dev_attr_accel_y_raw.dev_attr.attr,
+	&iio_dev_attr_accel_xy.dev_attr.attr,
+	&iio_dev_attr_accel_xpeak.dev_attr.attr,
+	&iio_dev_attr_accel_ypeak.dev_attr.attr,
+	&iio_dev_attr_accel_xypeak.dev_attr.attr,
+	&iio_dev_attr_accel_x_offset.dev_attr.attr,
+	&iio_dev_attr_accel_y_offset.dev_attr.attr,
+	&iio_const_attr_accel_x_scale.dev_attr.attr,
+	&iio_const_attr_accel_y_scale.dev_attr.attr,
+	&iio_const_attr_accel_xy_scale.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16204_attribute_group = {
+	.attrs = adis16204_attributes,
+};
+
+static int __devinit adis16204_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16204_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16204_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16204_MAX_TX, GFP_KERNEL);
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
+	st->indio_dev->event_attrs = &adis16204_event_attribute_group;
+	st->indio_dev->attrs = &adis16204_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16204_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = adis16204_initialize_ring(st->indio_dev->ring);
+	if (ret) {
+		printk(KERN_ERR "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+
+	if (spi->irq) {
+		ret = iio_register_interrupt_line(spi->irq,
+				st->indio_dev,
+				0,
+				IRQF_TRIGGER_RISING,
+				"adis16204");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = adis16204_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	/* Get the device into a sane initial state */
+	ret = adis16204_initial_setup(st);
+	if (ret)
+		goto error_remove_trigger;
+	return 0;
+
+error_remove_trigger:
+	adis16204_remove_trigger(st->indio_dev);
+error_unregister_line:
+	if (spi->irq)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	adis16204_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	adis16204_unconfigure_ring(st->indio_dev);
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
+static int adis16204_remove(struct spi_device *spi)
+{
+	struct adis16204_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	flush_scheduled_work();
+
+	adis16204_remove_trigger(indio_dev);
+	if (spi->irq)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	adis16204_uninitialize_ring(indio_dev->ring);
+	iio_device_unregister(indio_dev);
+	adis16204_unconfigure_ring(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+}
+
+static struct spi_driver adis16204_driver = {
+	.driver = {
+		.name = "adis16204",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16204_probe,
+	.remove = __devexit_p(adis16204_remove),
+};
+
+static __init int adis16204_init(void)
+{
+	return spi_register_driver(&adis16204_driver);
+}
+module_init(adis16204_init);
+
+static __exit void adis16204_exit(void)
+{
+	spi_unregister_driver(&adis16204_driver);
+}
+module_exit(adis16204_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16204 Programmable High-g Digital Impact Sensor and Recorder");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
new file mode 100644
index 0000000..420b160
--- /dev/null
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -0,0 +1,206 @@
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
+#include "accel.h"
+#include "../trigger.h"
+#include "adis16204.h"
+
+static IIO_SCAN_EL_C(in_supply, ADIS16204_SCAN_SUPPLY, ADIS16204_SUPPLY_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
+static IIO_SCAN_EL_C(accel_x, ADIS16204_SCAN_ACC_X, ADIS16204_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16204_SCAN_ACC_Y, ADIS16204_YACCL_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
+static IIO_SCAN_EL_C(in0, ADIS16204_SCAN_AUX_ADC, ADIS16204_AUX_ADC, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
+static IIO_SCAN_EL_C(temp, ADIS16204_SCAN_TEMP, ADIS16204_TEMP_OUT, NULL);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
+static IIO_SCAN_EL_TIMESTAMP(5);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
+
+static struct attribute *adis16204_scan_el_attrs[] = {
+	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_const_attr_in_supply_index.dev_attr.attr,
+	&iio_const_attr_in_supply_type.dev_attr.attr,
+	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_const_attr_accel_x_index.dev_attr.attr,
+	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_const_attr_accel_y_index.dev_attr.attr,
+	&iio_const_attr_accel_type.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
+	&iio_const_attr_in0_type.dev_attr.attr,
+	&iio_scan_el_temp.dev_attr.attr,
+	&iio_const_attr_temp_index.dev_attr.attr,
+	&iio_const_attr_temp_type.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group adis16204_scan_el_group = {
+	.attrs = adis16204_scan_el_attrs,
+	.name = "scan_elements",
+};
+
+/**
+ * adis16204_poll_func_th() top half interrupt handler called by trigger
+ * @private_data:	iio_dev
+ **/
+static void adis16204_poll_func_th(struct iio_dev *indio_dev, s64 timestamp)
+{
+	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	st->last_timestamp = timestamp;
+	schedule_work(&st->work_trigger_to_ring);
+}
+
+/**
+ * adis16204_read_ring_data() read data registers which will be placed into ring
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @rx: somewhere to pass back the value read
+ **/
+static int adis16204_read_ring_data(struct device *dev, u8 *rx)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[ADIS16204_OUTPUTS + 1];
+	int ret;
+	int i;
+
+	mutex_lock(&st->buf_lock);
+
+	spi_message_init(&msg);
+
+	memset(xfers, 0, sizeof(xfers));
+	for (i = 0; i <= ADIS16204_OUTPUTS; i++) {
+		xfers[i].bits_per_word = 8;
+		xfers[i].cs_change = 1;
+		xfers[i].len = 2;
+		xfers[i].delay_usecs = 20;
+		xfers[i].tx_buf = st->tx + 2 * i;
+		st->tx[2 * i] = ADIS16204_READ_REG(ADIS16204_SUPPLY_OUT + 2 * i);
+		st->tx[2 * i + 1] = 0;
+		if (i >= 1)
+			xfers[i].rx_buf = rx + 2 * (i - 1);
+		spi_message_add_tail(&xfers[i], &msg);
+	}
+
+	ret = spi_sync(st->us, &msg);
+	if (ret)
+		dev_err(&st->us->dev, "problem when burst reading");
+
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
+ * specific to be rolled into the core.
+ */
+static void adis16204_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct adis16204_state *st
+		= container_of(work_s, struct adis16204_state,
+			       work_trigger_to_ring);
+	struct iio_ring_buffer *ring = st->indio_dev->ring;
+
+	int i = 0;
+	s16 *data;
+	size_t datasize = ring->access.get_bytes_per_datum(ring);
+
+	data = kmalloc(datasize, GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(&st->us->dev, "memory alloc failed in ring bh");
+		return;
+	}
+
+	if (ring->scan_count)
+		if (adis16204_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+			for (; i < ring->scan_count; i++)
+				data[i] = be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
+
+	/* Guaranteed to be aligned with 8 byte boundary */
+	if (ring->scan_timestamp)
+		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
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
+void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
+{
+	kfree(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
+
+int adis16204_configure_ring(struct iio_dev *indio_dev)
+{
+	int ret = 0;
+	struct adis16204_state *st = indio_dev->dev_data;
+	struct iio_ring_buffer *ring;
+	INIT_WORK(&st->work_trigger_to_ring, adis16204_trigger_bh_to_ring);
+
+	ring = iio_sw_rb_allocate(indio_dev);
+	if (!ring) {
+		ret = -ENOMEM;
+		return ret;
+	}
+	indio_dev->ring = ring;
+	/* Effectively select the ring buffer implementation */
+	iio_ring_sw_register_funcs(&ring->access);
+	ring->bpe = 2;
+	ring->scan_el_attrs = &adis16204_scan_el_group;
+	ring->scan_timestamp = true;
+	ring->preenable = &iio_sw_ring_preenable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
+	ring->owner = THIS_MODULE;
+
+	/* Set default scan mode */
+	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
+	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
+	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
+	iio_scan_mask_set(ring, iio_scan_el_temp.number);
+	iio_scan_mask_set(ring, iio_scan_el_in0.number);
+
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16204_poll_func_th);
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
+int adis16204_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return iio_ring_buffer_register(ring, 0);
+}
+
+void adis16204_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+	iio_ring_buffer_unregister(ring);
+}
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
new file mode 100644
index 0000000..8e9db90
--- /dev/null
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -0,0 +1,122 @@
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
+#include "adis16204.h"
+
+/**
+ * adis16204_data_rdy_trig_poll() the event handler for the data rdy trig
+ **/
+static int adis16204_data_rdy_trig_poll(struct iio_dev *dev_info,
+				       int index,
+				       s64 timestamp,
+				       int no_test)
+{
+	struct adis16204_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_trigger *trig = st->trig;
+
+	iio_trigger_poll(trig, timestamp);
+
+	return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(data_rdy_trig, &adis16204_data_rdy_trig_poll);
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static struct attribute *adis16204_trigger_attrs[] = {
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group adis16204_trigger_attr_group = {
+	.attrs = adis16204_trigger_attrs,
+};
+
+/**
+ * adis16204_data_rdy_trigger_set_state() set datardy interrupt state
+ **/
+static int adis16204_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct adis16204_state *st = trig->private_data;
+	struct iio_dev *indio_dev = st->indio_dev;
+	int ret = 0;
+
+	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	ret = adis16204_set_irq(&st->indio_dev->dev, state);
+	if (state == false) {
+		iio_remove_event_from_list(&iio_event_data_rdy_trig,
+					   &indio_dev->interrupts[0]
+					   ->ev_list);
+		flush_scheduled_work();
+	} else {
+		iio_add_event_to_list(&iio_event_data_rdy_trig,
+				      &indio_dev->interrupts[0]->ev_list);
+	}
+	return ret;
+}
+
+/**
+ * adis16204_trig_try_reen() try renabling irq for data rdy trigger
+ * @trig:	the datardy trigger
+ **/
+static int adis16204_trig_try_reen(struct iio_trigger *trig)
+{
+	struct adis16204_state *st = trig->private_data;
+	enable_irq(st->us->irq);
+	return 0;
+}
+
+int adis16204_probe_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct adis16204_state *st = indio_dev->dev_data;
+
+	st->trig = iio_allocate_trigger();
+	st->trig->name = kasprintf(GFP_KERNEL,
+				"adis16204-dev%d",
+				indio_dev->id);
+	if (!st->trig->name) {
+		ret = -ENOMEM;
+		goto error_free_trig;
+	}
+	st->trig->dev.parent = &st->us->dev;
+	st->trig->owner = THIS_MODULE;
+	st->trig->private_data = st;
+	st->trig->set_trigger_state = &adis16204_data_rdy_trigger_set_state;
+	st->trig->try_reenable = &adis16204_trig_try_reen;
+	st->trig->control_attrs = &adis16204_trigger_attr_group;
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
+void adis16204_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct adis16204_state *state = indio_dev->dev_data;
+
+	iio_trigger_unregister(state->trig);
+	kfree(state->trig->name);
+	iio_free_trigger(state->trig);
+}
-- 
1.7.3.2
