Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:59308 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0ELUxw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2010 16:53:52 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry Song <Barry.Song@analog.com>
Subject: [PATCH 1/2] staging:iio: adis16220 vibration sensor driver
Date: Wed, 12 May 2010 21:53:44 +0100
Message-Id: <1273697625-9685-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273697625-9685-1-git-send-email-jic23@cam.ac.uk>
References: <1273697625-9685-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Barry Song <Barry.Song@analog.com>

---
 drivers/staging/iio/accel/Kconfig          |    7 +
 drivers/staging/iio/accel/Makefile         |    3 +
 drivers/staging/iio/accel/accel.h          |    6 +
 drivers/staging/iio/accel/adis16220.h      |  150 +++++++
 drivers/staging/iio/accel/adis16220_core.c |  664 ++++++++++++++++++++++++++++
 5 files changed, 830 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 8f3f70f..b4e57d1 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -12,6 +12,13 @@ config ADIS16209
          Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
 	 and accelerometer.
 
+config ADIS16220
+       tristate "Analog Devices ADIS16220 Programmable Digital Vibration Sensor driver"
+       depends on SPI
+       help
+         Say yes here to build support for Analog Devices adis16220 programmable
+         digital vibration sensor.
+
 config ADIS16240
        tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
        depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 0e6762c..c34b136 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -5,6 +5,9 @@ adis16209-y             := adis16209_core.o
 adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 
+adis16220-y             := adis16220_core.o
+obj-$(CONFIG_ADIS16220) += adis16220.o
+
 adis16240-y             := adis16240_core.o
 adis16240-$(CONFIG_IIO_RING_BUFFER) += adis16240_ring.o adis16240_trigger.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/accel/accel.h
index 059209c..1b6e37f 100644
--- a/drivers/staging/iio/accel/accel.h
+++ b/drivers/staging/iio/accel/accel.h
@@ -2,6 +2,9 @@
 #include "../sysfs.h"
 
 /* Accelerometer types of attribute */
+#define IIO_DEV_ATTR_ACCEL_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(accel_offset, _mode, _show, _store, _addr)
+
 #define IIO_DEV_ATTR_ACCEL_X_OFFSET(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(accel_x_offset, _mode, _show, _store, _addr)
 
@@ -20,6 +23,9 @@
 #define IIO_DEV_ATTR_ACCEL_Z_GAIN(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(accel_z_gain, _mode, _show, _store, _addr)
 
+#define IIO_DEV_ATTR_ACCEL(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_raw, S_IRUGO, _show, NULL, _addr)
+
 #define IIO_DEV_ATTR_ACCEL_X(_show, _addr)			\
 	IIO_DEVICE_ATTR(accel_x_raw, S_IRUGO, _show, NULL, _addr)
 
diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/accel/adis16220.h
new file mode 100644
index 0000000..6b49f70
--- /dev/null
+++ b/drivers/staging/iio/accel/adis16220.h
@@ -0,0 +1,150 @@
+#ifndef SPI_ADIS16220_H_
+#define SPI_ADIS16220_H_
+
+#define ADIS16220_STARTUP_DELAY	220 /* ms */
+
+#define ADIS16220_READ_REG(a)    a
+#define ADIS16220_WRITE_REG(a) ((a) | 0x80)
+
+/* Flash memory write count */
+#define ADIS16220_FLASH_CNT     0x00
+/* Control, acceleration offset adjustment control */
+#define ADIS16220_ACCL_NULL     0x02
+/* Control, AIN1 offset adjustment control */
+#define ADIS16220_AIN1_NULL     0x04
+/* Control, AIN2 offset adjustment control */
+#define ADIS16220_AIN2_NULL     0x06
+/* Output, power supply during capture */
+#define ADIS16220_CAPT_SUPPLY   0x0A
+/* Output, temperature during capture */
+#define ADIS16220_CAPT_TEMP     0x0C
+/* Output, peak acceleration during capture */
+#define ADIS16220_CAPT_PEAKA    0x0E
+/* Output, peak AIN1 level during capture */
+#define ADIS16220_CAPT_PEAK1    0x10
+/* Output, peak AIN2 level during capture */
+#define ADIS16220_CAPT_PEAK2    0x12
+/* Output, capture buffer for acceleration */
+#define ADIS16220_CAPT_BUFA     0x14
+/* Output, capture buffer for AIN1 */
+#define ADIS16220_CAPT_BUF1     0x16
+/* Output, capture buffer for AIN2 */
+#define ADIS16220_CAPT_BUF2     0x18
+/* Control, capture buffer address pointer */
+#define ADIS16220_CAPT_PNTR     0x1A
+/* Control, capture control register */
+#define ADIS16220_CAPT_CTRL     0x1C
+/* Control, capture period (automatic mode) */
+#define ADIS16220_CAPT_PRD      0x1E
+/* Control, Alarm A, acceleration peak threshold */
+#define ADIS16220_ALM_MAGA      0x20
+/* Control, Alarm 1, AIN1 peak threshold */
+#define ADIS16220_ALM_MAG1      0x22
+/* Control, Alarm 2, AIN2 peak threshold */
+#define ADIS16220_ALM_MAG2      0x24
+/* Control, Alarm S, peak threshold */
+#define ADIS16220_ALM_MAGS      0x26
+/* Control, alarm configuration register */
+#define ADIS16220_ALM_CTRL      0x28
+/* Control, general I/O configuration */
+#define ADIS16220_GPIO_CTRL     0x32
+/* Control, self-test control, AIN configuration */
+#define ADIS16220_MSC_CTRL      0x34
+/* Control, digital I/O configuration */
+#define ADIS16220_DIO_CTRL      0x36
+/* Control, filter configuration */
+#define ADIS16220_AVG_CNT       0x38
+/* Status, system status */
+#define ADIS16220_DIAG_STAT     0x3C
+/* Control, system commands */
+#define ADIS16220_GLOB_CMD      0x3E
+/* Status, self-test response */
+#define ADIS16220_ST_DELTA      0x40
+/* Lot Identification Code 1 */
+#define ADIS16220_LOT_ID1       0x52
+/* Lot Identification Code 2 */
+#define ADIS16220_LOT_ID2       0x54
+/* Product identifier; convert to decimal = 16220 */
+#define ADIS16220_PROD_ID       0x56
+/* Serial number */
+#define ADIS16220_SERIAL_NUM    0x58
+
+#define ADIS16220_CAPTURE_SIZE  2048
+
+/* MSC_CTRL */
+#define ADIS16220_MSC_CTRL_SELF_TEST_EN	        (1 << 8)
+#define ADIS16220_MSC_CTRL_POWER_SUP_COM_AIN1	(1 << 1)
+#define ADIS16220_MSC_CTRL_POWER_SUP_COM_AIN2	(1 << 0)
+
+/* DIO_CTRL */
+#define ADIS16220_MSC_CTRL_DIO2_BUSY_IND     (3<<4)
+#define ADIS16220_MSC_CTRL_DIO1_BUSY_IND     (3<<2)
+#define ADIS16220_MSC_CTRL_DIO2_ACT_HIGH     (1<<1)
+#define ADIS16220_MSC_CTRL_DIO1_ACT_HIGH     (1<<0)
+
+/* DIAG_STAT */
+/* AIN2 sample > ALM_MAG2 */
+#define ADIS16220_DIAG_STAT_ALM_MAG2    (1<<14)
+/* AIN1 sample > ALM_MAG1 */
+#define ADIS16220_DIAG_STAT_ALM_MAG1    (1<<13)
+/* Acceleration sample > ALM_MAGA */
+#define ADIS16220_DIAG_STAT_ALM_MAGA    (1<<12)
+/* Error condition programmed into ALM_MAGS[11:0] and ALM_CTRL[5:4] is true */
+#define ADIS16220_DIAG_STAT_ALM_MAGS    (1<<11)
+/* |Peak value in AIN2 data capture| > ALM_MAG2 */
+#define ADIS16220_DIAG_STAT_PEAK_AIN2   (1<<10)
+/* |Peak value in AIN1 data capture| > ALM_MAG1 */
+#define ADIS16220_DIAG_STAT_PEAK_AIN1   (1<<9)
+/* |Peak value in acceleration data capture| > ALM_MAGA */
+#define ADIS16220_DIAG_STAT_PEAK_ACCEL  (1<<8)
+/* Data ready, capture complete */
+#define ADIS16220_DIAG_STAT_DATA_RDY    (1<<7)
+#define ADIS16220_DIAG_STAT_FLASH_CHK	(1<<6)
+#define ADIS16220_DIAG_STAT_SELF_TEST	(1<<5)
+/* Capture period violation/interruption */
+#define ADIS16220_DIAG_STAT_VIOLATION	(1<<4)
+/* SPI communications failure */
+#define ADIS16220_DIAG_STAT_SPI_FAIL	(1<<3)
+/* Flash update failure */
+#define ADIS16220_DIAG_STAT_FLASH_UPT	(1<<2)
+/* Power supply above 3.625 V */
+#define ADIS16220_DIAG_STAT_POWER_HIGH	(1<<1)
+/* Power supply below 3.15 V */
+#define ADIS16220_DIAG_STAT_POWER_LOW	(1<<0)
+
+/* GLOB_CMD */
+#define ADIS16220_GLOB_CMD_SW_RESET	(1<<7)
+#define ADIS16220_GLOB_CMD_SELF_TEST	(1<<2)
+#define ADIS16220_GLOB_CMD_PWR_DOWN	(1<<1)
+
+#define ADIS16220_MAX_TX 2048
+#define ADIS16220_MAX_RX 2048
+
+#define ADIS16220_SPI_BURST	(u32)(1000 * 1000)
+#define ADIS16220_SPI_FAST	(u32)(2000 * 1000)
+
+/**
+ * struct adis16220_state - device instance specific data
+ * @us:			actual spi_device
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @work_cont_thresh: CLEAN
+ * @inter:		used to check if new interrupt has been triggered
+ * @last_timestamp:	passing timestamp from th to bh of interrupt handler
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @tx:			transmit buffer
+ * @rx:			recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct adis16220_state {
+	struct spi_device		*us;
+	struct iio_dev			*indio_dev;
+	u8				*tx;
+	u8				*rx;
+	struct bin_attribute            accel_bin;
+	struct bin_attribute            adc1_bin;
+	struct bin_attribute            adc2_bin;
+	struct mutex			buf_lock;
+};
+
+#endif /* SPI_ADIS16220_H_ */
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
new file mode 100644
index 0000000..8b845d9
--- /dev/null
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -0,0 +1,664 @@
+/*
+ * ADIS16220 Programmable Digital Vibration Sensor driver
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
+
+#include <linux/sysfs.h>
+#include <linux/list.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "accel.h"
+#include "../adc/adc.h"
+
+#include "adis16220.h"
+
+#define DRIVER_NAME		"adis16220"
+
+static int adis16220_check_status(struct device *dev);
+
+/**
+ * adis16220_spi_write_reg_8() - write single byte to a register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the register to be written
+ * @val: the value to write
+ **/
+static int adis16220_spi_write_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16220_WRITE_REG(reg_address);
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/**
+ * adis16220_spi_write_reg_16() - write 2 bytes to a pair of registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: value to be written
+ **/
+static int adis16220_spi_write_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 25,
+		}, {
+			.tx_buf = st->tx + 2,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 25,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16220_WRITE_REG(lower_reg_address);
+	st->tx[1] = value & 0xFF;
+	st->tx[2] = ADIS16220_WRITE_REG(lower_reg_address + 1);
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
+ * adis16220_spi_read_reg_16() - read 2 bytes from a 16-bit register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: somewhere to pass back the value read
+ **/
+static int adis16220_spi_read_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 25,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 25,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16220_READ_REG(lower_reg_address);
+	st->tx[1] = 0;
+	st->tx[2] = 0;
+	st->tx[3] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+		dev_err(&st->us->dev,
+			"problem when reading 16 bit register 0x%02X",
+			lower_reg_address);
+		goto error_ret;
+	}
+	*val = (st->rx[0] << 8) | st->rx[1];
+
+error_ret:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static ssize_t adis16220_spi_read_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf,
+		unsigned bits)
+{
+	int ret;
+	s16 val = 0;
+	unsigned shift = 16 - bits;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16220_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	if (ret)
+		return ret;
+
+	val = ((s16)(val << shift) >> shift);
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t adis16220_read_12bit_unsigned(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16220_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", val & 0x0FFF);
+}
+
+static ssize_t adis16220_read_16bit(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16220_spi_read_signed(dev, attr, buf, 16);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16220_write_16bit(struct device *dev,
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
+	ret = adis16220_spi_write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static int adis16220_capture(struct device *dev)
+{
+	int ret;
+	ret = adis16220_spi_write_reg_16(dev,
+			ADIS16220_GLOB_CMD,
+			0xBF08); /* initiates a manual data capture */
+	if (ret)
+		dev_err(dev, "problem beginning capture");
+
+	msleep(10); /* delay for capture to finish */
+
+	return ret;
+}
+
+static int adis16220_reset(struct device *dev)
+{
+	int ret;
+	ret = adis16220_spi_write_reg_8(dev,
+			ADIS16220_GLOB_CMD,
+			ADIS16220_GLOB_CMD_SW_RESET);
+	if (ret)
+		dev_err(dev, "problem resetting device");
+
+	return ret;
+}
+
+static ssize_t adis16220_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return adis16220_reset(dev) == 0 ? len : -EIO;
+	}
+	return -1;
+}
+
+static ssize_t adis16220_write_capture(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return adis16220_capture(dev) == 0 ? len : -EIO;
+	}
+	return -1;
+}
+
+static int adis16220_self_test(struct device *dev)
+{
+	int ret;
+	ret = adis16220_spi_write_reg_16(dev,
+			ADIS16220_MSC_CTRL,
+			ADIS16220_MSC_CTRL_SELF_TEST_EN);
+	if (ret) {
+		dev_err(dev, "problem starting self test");
+		goto err_ret;
+	}
+
+	adis16220_check_status(dev);
+
+err_ret:
+	return ret;
+}
+
+static int adis16220_check_status(struct device *dev)
+{
+	u16 status;
+	int ret;
+
+	ret = adis16220_spi_read_reg_16(dev, ADIS16220_DIAG_STAT, &status);
+
+	if (ret < 0) {
+		dev_err(dev, "Reading status failed\n");
+		goto error_ret;
+	}
+	ret = status & 0x7F;
+
+	if (status & ADIS16220_DIAG_STAT_VIOLATION)
+		dev_err(dev, "Capture period violation/interruption\n");
+	if (status & ADIS16220_DIAG_STAT_SPI_FAIL)
+		dev_err(dev, "SPI failure\n");
+	if (status & ADIS16220_DIAG_STAT_FLASH_UPT)
+		dev_err(dev, "Flash update failed\n");
+	if (status & ADIS16220_DIAG_STAT_POWER_HIGH)
+		dev_err(dev, "Power supply above 5.25V\n");
+	if (status & ADIS16220_DIAG_STAT_POWER_LOW)
+		dev_err(dev, "Power supply below 4.75V\n");
+
+error_ret:
+	return ret;
+}
+
+static int adis16220_initial_setup(struct adis16220_state *st)
+{
+	int ret;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* Do self test */
+	ret = adis16220_self_test(dev);
+	if (ret) {
+		dev_err(dev, "self test failure");
+		goto err_ret;
+	}
+
+	/* Read status register to check the result */
+	ret = adis16220_check_status(dev);
+	if (ret) {
+		adis16220_reset(dev);
+		dev_err(dev, "device not playing ball -> reset");
+		msleep(ADIS16220_STARTUP_DELAY);
+		ret = adis16220_check_status(dev);
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
+static ssize_t adis16220_capture_buffer_read(struct adis16220_state *st,
+					char *buf,
+					loff_t off,
+					size_t count,
+					int addr)
+{
+	struct spi_message msg;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 1,
+			.delay_usecs = 25,
+		}, {
+			.tx_buf = st->tx,
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.cs_change = 1,
+			.delay_usecs = 25,
+		},
+	};
+	int ret;
+	int i;
+
+	if (unlikely(!count))
+		return count;
+
+	if ((off >= ADIS16220_CAPTURE_SIZE) || (count & 1) || (off & 1))
+		return -EINVAL;
+
+	if (off + count > ADIS16220_CAPTURE_SIZE)
+		count = ADIS16220_CAPTURE_SIZE - off;
+
+	/* write the begin position of capture buffer */
+	ret = adis16220_spi_write_reg_16(&st->indio_dev->dev,
+					ADIS16220_CAPT_PNTR,
+					off > 1);
+	if (ret)
+		return -EIO;
+
+	/* read count/2 values from capture buffer */
+	mutex_lock(&st->buf_lock);
+
+	for (i = 0; i < count; i += 2) {
+		st->tx[i] = ADIS16220_READ_REG(addr);
+		st->tx[i + 1] = 0;
+	}
+	xfers[1].len = count;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+
+		mutex_unlock(&st->buf_lock);
+		return -EIO;
+	}
+
+	memcpy(buf, st->rx, count);
+
+	mutex_unlock(&st->buf_lock);
+	return count;
+}
+
+static ssize_t adis16220_accel_bin_read(struct kobject *kobj,
+					struct bin_attribute *attr,
+					char *buf,
+					loff_t off,
+					size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+
+	return adis16220_capture_buffer_read(st, buf,
+					off, count,
+					ADIS16220_CAPT_BUFA);
+}
+
+static ssize_t adis16220_adc1_bin_read(struct kobject *kobj,
+				struct bin_attribute *attr,
+				char *buf, loff_t off,
+				size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+
+	return adis16220_capture_buffer_read(st, buf,
+					off, count,
+					ADIS16220_CAPT_BUF1);
+}
+
+static ssize_t adis16220_adc2_bin_read(struct kobject *kobj,
+				struct bin_attribute *attr,
+				char *buf, loff_t off,
+				size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+
+	return adis16220_capture_buffer_read(st, buf,
+					off, count,
+					ADIS16220_CAPT_BUF2);
+}
+
+static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16220_read_12bit_unsigned,
+		ADIS16220_CAPT_SUPPLY);
+static IIO_CONST_ATTR(in_supply_scale, "0.0012207");
+static IIO_DEV_ATTR_ACCEL(adis16220_read_16bit, ADIS16220_CAPT_BUFA);
+static IIO_DEVICE_ATTR(accel_peak_raw, S_IRUGO, adis16220_read_16bit,
+		NULL, ADIS16220_CAPT_PEAKA);
+static IIO_DEV_ATTR_ACCEL_OFFSET(S_IWUSR | S_IRUGO,
+		adis16220_read_16bit,
+		adis16220_write_16bit,
+		ADIS16220_ACCL_NULL);
+static IIO_DEV_ATTR_TEMP_RAW(adis16220_read_12bit_unsigned);
+static IIO_CONST_ATTR(temp_offset, "25");
+static IIO_CONST_ATTR(temp_scale, "-0.47");
+
+static IIO_DEV_ATTR_IN_RAW(0, adis16220_read_16bit, ADIS16220_CAPT_BUF1);
+static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF2);
+
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
+		adis16220_write_reset, 0);
+
+#define IIO_DEV_ATTR_CAPTURE(_store)			\
+	IIO_DEVICE_ATTR(capture, S_IWUGO, NULL, _store, 0)
+
+static IIO_DEV_ATTR_CAPTURE(adis16220_write_capture);
+
+#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(capture_count, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
+		adis16220_read_16bit,
+		adis16220_write_16bit,
+		ADIS16220_CAPT_PNTR);
+
+static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("100200");
+
+static IIO_CONST_ATTR(name, "adis16220");
+
+static struct attribute *adis16220_attributes[] = {
+	&iio_dev_attr_in_supply_raw.dev_attr.attr,
+	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_accel_raw.dev_attr.attr,
+	&iio_dev_attr_accel_offset.dev_attr.attr,
+	&iio_dev_attr_accel_peak_raw.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_dev_attr_capture.dev_attr.attr,
+	&iio_dev_attr_capture_count.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16220_attribute_group = {
+	.attrs = adis16220_attributes,
+};
+
+static int __devinit adis16220_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16220_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16220_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16220_MAX_TX, GFP_KERNEL);
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
+	st->indio_dev->attrs = &adis16220_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+	regdone = 1;
+
+	st->accel_bin.attr.name = "accel_bin";
+	st->accel_bin.attr.mode = S_IRUGO;
+	st->accel_bin.attr.owner = THIS_MODULE;
+	st->accel_bin.read = adis16220_accel_bin_read;
+	st->accel_bin.size = ADIS16220_CAPTURE_SIZE;
+
+	ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &st->accel_bin);
+	if (ret)
+		goto error_free_dev;
+
+	st->adc1_bin.attr.name = "adc1_bin";
+	st->adc1_bin.attr.mode = S_IRUGO;
+	st->adc1_bin.attr.owner = THIS_MODULE;
+	st->adc1_bin.read = adis16220_adc1_bin_read;
+	st->adc1_bin.size = ADIS16220_CAPTURE_SIZE;
+
+	ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &st->adc1_bin);
+	if (ret)
+		goto error_rm_accel_bin;
+
+	st->adc2_bin.attr.name = "adc2_bin";
+	st->adc2_bin.attr.mode = S_IRUGO;
+	st->adc2_bin.attr.owner = THIS_MODULE;
+	st->adc2_bin.read = adis16220_adc2_bin_read;
+	st->adc2_bin.size = ADIS16220_CAPTURE_SIZE;
+
+	ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &st->adc2_bin);
+	if (ret)
+		goto error_rm_adc1_bin;
+
+	/* Get the device into a sane initial state */
+	ret = adis16220_initial_setup(st);
+	if (ret)
+		goto error_rm_adc2_bin;
+	return 0;
+
+error_rm_adc2_bin:
+	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc2_bin);
+error_rm_adc1_bin:
+	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc1_bin);
+error_rm_accel_bin:
+	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->accel_bin);
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
+static int adis16220_remove(struct spi_device *spi)
+{
+	struct adis16220_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	flush_scheduled_work();
+
+	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc2_bin);
+	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc1_bin);
+	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->accel_bin);
+	iio_device_unregister(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+}
+
+static struct spi_driver adis16220_driver = {
+	.driver = {
+		.name = "adis16220",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16220_probe,
+	.remove = __devexit_p(adis16220_remove),
+};
+
+static __init int adis16220_init(void)
+{
+	return spi_register_driver(&adis16220_driver);
+}
+module_init(adis16220_init);
+
+static __exit void adis16220_exit(void)
+{
+	spi_unregister_driver(&adis16220_driver);
+}
+module_exit(adis16220_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16220 Digital Vibration Sensor");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4

