Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:57965 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760022Ab0EDNkX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2010 09:40:23 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Barry Song <Barry.Song@analog.com>
Subject: [PATCH 19/20] staging:iio:imu ADIS16300 driver
Date: Tue,  4 May 2010 14:43:14 +0100
Message-Id: <1272980595-11033-20-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-19-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-4-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-5-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-6-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-8-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-9-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-10-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-11-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-12-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-13-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-14-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-15-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-16-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-17-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-18-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-19-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Barry Song <Barry.Song@analog.com>

Signed-off-by: Barry Song <Barry.Song@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig                 |    1 +
 drivers/staging/iio/Makefile                |    1 +
 drivers/staging/iio/adc/adc.h               |    3 +
 drivers/staging/iio/gyro/gyro.h             |   76 +++
 drivers/staging/iio/imu/Kconfig             |   14 +
 drivers/staging/iio/imu/Makefile            |    6 +
 drivers/staging/iio/imu/adis16300.h         |  203 +++++++
 drivers/staging/iio/imu/adis16300_core.c    |  833 +++++++++++++++++++++++++++
 drivers/staging/iio/imu/adis16300_ring.c    |  233 ++++++++
 drivers/staging/iio/imu/adis16300_trigger.c |  127 ++++
 10 files changed, 1497 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index ace99f6..ed38ef4 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -41,6 +41,7 @@ config IIO_TRIGGER
 
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
+source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 
 source "drivers/staging/iio/trigger/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 7ec0218..92b81c2 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += imu/
 obj-y += light/
 
 obj-y += trigger/
\ No newline at end of file
diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index 46f0d08..04eb16f 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -16,6 +16,9 @@
 #define IIO_DEV_ATTR_IN_RAW(_num, _show, _addr)				\
 	IIO_DEVICE_ATTR(in##_num##_raw, S_IRUGO, _show, NULL, _addr)
 
+#define IIO_DEV_ATTR_IN_NAMED_RAW(_name, _show, _addr)			\
+	IIO_DEVICE_ATTR(in_##_name##_raw, S_IRUGO, _show, NULL, _addr)
+
 #define IIO_DEV_ATTR_IN_DIFF_RAW(_nump, _numn, _show, _addr)		\
 	IIO_DEVICE_ATTR_NAMED(in##_nump##min##_numn##_raw,		\
 			      in##_nump-in##_numn##_raw,		\
diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
new file mode 100644
index 0000000..7c4dcf2
--- /dev/null
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -0,0 +1,76 @@
+
+#include "../sysfs.h"
+
+/* Gyroscope types of attribute */
+
+#define IIO_DEV_ATTR_GYRO_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(gyro_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_X_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(gyro_x_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(gyro_y_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z_OFFSET(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(gyro_z_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_X_GAIN(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_x_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y_GAIN(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_y_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z_GAIN(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_z_gain, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_scale, S_IRUGO, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO(_show, _addr)			\
+	IIO_DEVICE_ATTR(gyro, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_GYRO_X(_show, _addr)			\
+	IIO_DEVICE_ATTR(gyro_x, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y(_show, _addr)			\
+	IIO_DEVICE_ATTR(gyro_y, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z(_show, _addr)			\
+	IIO_DEVICE_ATTR(gyro_z, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_TEMP_X(_show, _addr)			\
+	IIO_DEVICE_ATTR(temp_x, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_TEMP_Y(_show, _addr)			\
+	IIO_DEVICE_ATTR(temp_y, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_TEMP_Z(_show, _addr)			\
+	IIO_DEVICE_ATTR(temp_z, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_X(_show, _addr)			\
+	IIO_DEVICE_ATTR(incli_x, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Y(_show, _addr)			\
+	IIO_DEVICE_ATTR(incli_y, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Z(_show, _addr)			\
+	IIO_DEVICE_ATTR(incli_z, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_INCLI_X_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(incli_x_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Y_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(incli_y_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_INCLI_Z_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(incli_z_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ROT(_show, _addr)                    \
+	IIO_DEVICE_ATTR(rot, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ROT_OFFSET(_mode, _show, _store, _addr) \
+	IIO_DEVICE_ATTR(rot_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_ANGL(_show, _addr)                         \
+	IIO_DEVICE_ATTR(angl, S_IRUGO, _show, NULL, _addr)
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
new file mode 100644
index 0000000..3fe4716
--- /dev/null
+++ b/drivers/staging/iio/imu/Kconfig
@@ -0,0 +1,14 @@
+#
+# IIO imu drivers configuration
+#
+comment "Inertial measurement units"
+
+config ADIS16300
+	tristate "Analog Devices ADIS16300 IMU SPI driver"
+	depends on SPI
+	select IIO_SW_RING
+	select IIO_RING_BUFFER
+	select IIO_TRIGGER
+	help
+	  Say yes here to build support for Analog Devices adis16300 four degrees
+	  of freedom inertial sensor.
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
new file mode 100644
index 0000000..4cd5984
--- /dev/null
+++ b/drivers/staging/iio/imu/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for Inertial Measurement Units
+#
+adis16300-y             := adis16300_core.o
+adis16300-$(CONFIG_IIO_RING_BUFFER) += adis16300_ring.o adis16300_trigger.o
+obj-$(CONFIG_ADIS16300) += adis16300.o
diff --git a/drivers/staging/iio/imu/adis16300.h b/drivers/staging/iio/imu/adis16300.h
new file mode 100644
index 0000000..77d890d
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16300.h
@@ -0,0 +1,203 @@
+#ifndef SPI_ADIS16300_H_
+#define SPI_ADIS16300_H_
+
+#define ADIS16300_STARTUP_DELAY	220 /* ms */
+
+#define ADIS16300_READ_REG(a)    a
+#define ADIS16300_WRITE_REG(a) ((a) | 0x80)
+
+#define ADIS16300_FLASH_CNT  0x00 /* Flash memory write count */
+#define ADIS16300_SUPPLY_OUT 0x02 /* Power supply measurement */
+#define ADIS16300_XGYRO_OUT 0x04 /* X-axis gyroscope output */
+#define ADIS16300_XACCL_OUT 0x0A /* X-axis accelerometer output */
+#define ADIS16300_YACCL_OUT 0x0C /* Y-axis accelerometer output */
+#define ADIS16300_ZACCL_OUT 0x0E /* Z-axis accelerometer output */
+#define ADIS16300_TEMP_OUT  0x10 /* Temperature output */
+#define ADIS16300_XINCLI_OUT 0x12 /* X-axis inclinometer output measurement */
+#define ADIS16300_YINCLI_OUT 0x14 /* Y-axis inclinometer output measurement */
+#define ADIS16300_AUX_ADC   0x16 /* Auxiliary ADC measurement */
+
+/* Calibration parameters */
+#define ADIS16300_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
+#define ADIS16300_XACCL_OFF 0x20 /* X-axis acceleration bias offset factor */
+#define ADIS16300_YACCL_OFF 0x22 /* Y-axis acceleration bias offset factor */
+#define ADIS16300_ZACCL_OFF 0x24 /* Z-axis acceleration bias offset factor */
+
+#define ADIS16300_GPIO_CTRL 0x32 /* Auxiliary digital input/output control */
+#define ADIS16300_MSC_CTRL  0x34 /* Miscellaneous control */
+#define ADIS16300_SMPL_PRD  0x36 /* Internal sample period (rate) control */
+#define ADIS16300_SENS_AVG  0x38 /* Dynamic range and digital filter control */
+#define ADIS16300_SLP_CNT   0x3A /* Sleep mode control */
+#define ADIS16300_DIAG_STAT 0x3C /* System status */
+
+/* Alarm functions */
+#define ADIS16300_GLOB_CMD  0x3E /* System command */
+#define ADIS16300_ALM_MAG1  0x26 /* Alarm 1 amplitude threshold */
+#define ADIS16300_ALM_MAG2  0x28 /* Alarm 2 amplitude threshold */
+#define ADIS16300_ALM_SMPL1 0x2A /* Alarm 1 sample size */
+#define ADIS16300_ALM_SMPL2 0x2C /* Alarm 2 sample size */
+#define ADIS16300_ALM_CTRL  0x2E /* Alarm control */
+#define ADIS16300_AUX_DAC   0x30 /* Auxiliary DAC data */
+
+#define ADIS16300_ERROR_ACTIVE			(1<<14)
+#define ADIS16300_NEW_DATA			(1<<15)
+
+/* MSC_CTRL */
+#define ADIS16300_MSC_CTRL_MEM_TEST		(1<<11)
+#define ADIS16300_MSC_CTRL_INT_SELF_TEST	(1<<10)
+#define ADIS16300_MSC_CTRL_NEG_SELF_TEST	(1<<9)
+#define ADIS16300_MSC_CTRL_POS_SELF_TEST	(1<<8)
+#define ADIS16300_MSC_CTRL_GYRO_BIAS		(1<<7)
+#define ADIS16300_MSC_CTRL_ACCL_ALIGN		(1<<6)
+#define ADIS16300_MSC_CTRL_DATA_RDY_EN		(1<<2)
+#define ADIS16300_MSC_CTRL_DATA_RDY_POL_HIGH	(1<<1)
+#define ADIS16300_MSC_CTRL_DATA_RDY_DIO2	(1<<0)
+
+/* SMPL_PRD */
+#define ADIS16300_SMPL_PRD_TIME_BASE	(1<<7)
+#define ADIS16300_SMPL_PRD_DIV_MASK	0x7F
+
+/* DIAG_STAT */
+#define ADIS16300_DIAG_STAT_ZACCL_FAIL	(1<<15)
+#define ADIS16300_DIAG_STAT_YACCL_FAIL	(1<<14)
+#define ADIS16300_DIAG_STAT_XACCL_FAIL	(1<<13)
+#define ADIS16300_DIAG_STAT_XGYRO_FAIL	(1<<10)
+#define ADIS16300_DIAG_STAT_ALARM2	(1<<9)
+#define ADIS16300_DIAG_STAT_ALARM1	(1<<8)
+#define ADIS16300_DIAG_STAT_FLASH_CHK	(1<<6)
+#define ADIS16300_DIAG_STAT_SELF_TEST	(1<<5)
+#define ADIS16300_DIAG_STAT_OVERFLOW	(1<<4)
+#define ADIS16300_DIAG_STAT_SPI_FAIL	(1<<3)
+#define ADIS16300_DIAG_STAT_FLASH_UPT	(1<<2)
+#define ADIS16300_DIAG_STAT_POWER_HIGH	(1<<1)
+#define ADIS16300_DIAG_STAT_POWER_LOW	(1<<0)
+
+/* GLOB_CMD */
+#define ADIS16300_GLOB_CMD_SW_RESET	(1<<7)
+#define ADIS16300_GLOB_CMD_P_AUTO_NULL	(1<<4)
+#define ADIS16300_GLOB_CMD_FLASH_UPD	(1<<3)
+#define ADIS16300_GLOB_CMD_DAC_LATCH	(1<<2)
+#define ADIS16300_GLOB_CMD_FAC_CALIB	(1<<1)
+#define ADIS16300_GLOB_CMD_AUTO_NULL	(1<<0)
+
+/* SLP_CNT */
+#define ADIS16300_SLP_CNT_POWER_OFF	(1<<8)
+
+#define ADIS16300_MAX_TX 18
+#define ADIS16300_MAX_RX 18
+
+#define ADIS16300_SPI_SLOW	(u32)(300 * 1000)
+#define ADIS16300_SPI_BURST	(u32)(1000 * 1000)
+#define ADIS16300_SPI_FAST	(u32)(2000 * 1000)
+
+/**
+ * struct adis16300_state - device instance specific data
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
+struct adis16300_state {
+	struct spi_device		*us;
+	struct work_struct		work_trigger_to_ring;
+	struct iio_work_cont		work_cont_thresh;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	struct mutex			buf_lock;
+};
+
+int adis16300_spi_write_reg_8(struct device *dev,
+			      u8 reg_address,
+			      u8 val);
+
+int adis16300_spi_read_burst(struct device *dev, u8 *rx);
+
+int adis16300_spi_read_sequence(struct device *dev,
+				      u8 *tx, u8 *rx, int num);
+
+int adis16300_set_irq(struct device *dev, bool enable);
+
+int adis16300_reset(struct device *dev);
+
+int adis16300_stop_device(struct device *dev);
+
+int adis16300_check_status(struct device *dev);
+
+#ifdef CONFIG_IIO_RING_BUFFER
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum adis16300_scan {
+	ADIS16300_SCAN_SUPPLY,
+	ADIS16300_SCAN_GYRO_X,
+	ADIS16300_SCAN_ACC_X,
+	ADIS16300_SCAN_ACC_Y,
+	ADIS16300_SCAN_ACC_Z,
+	ADIS16300_SCAN_TEMP,
+	ADIS16300_SCAN_ADC_0,
+	ADIS16300_SCAN_INCLI_X,
+	ADIS16300_SCAN_INCLI_Y,
+};
+
+void adis16300_remove_trigger(struct iio_dev *indio_dev);
+int adis16300_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t adis16300_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+
+int adis16300_configure_ring(struct iio_dev *indio_dev);
+void adis16300_unconfigure_ring(struct iio_dev *indio_dev);
+
+int adis16300_initialize_ring(struct iio_ring_buffer *ring);
+void adis16300_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void adis16300_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16300_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+adis16300_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int adis16300_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16300_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16300_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+
+static inline void adis16300_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* SPI_ADIS16300_H_ */
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
new file mode 100644
index 0000000..9f5f8cb
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -0,0 +1,833 @@
+/*
+ * ADIS16300 Four Degrees of Freedom Inertial Sensor Driver
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
+#include "../accel/accel.h"
+#include "../gyro/gyro.h"
+#include "../adc/adc.h"
+
+#include "adis16300.h"
+
+#define DRIVER_NAME		"adis16300"
+
+/* At the moment the spi framework doesn't allow global setting of cs_change.
+ * It's in the likely to be added comment at the top of spi.h.
+ * This means that use cannot be made of spi_write etc.
+ */
+
+/**
+ * adis16300_spi_write_reg_8() - write single byte to a register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the register to be written
+ * @val: the value to write
+ **/
+int adis16300_spi_write_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16300_WRITE_REG(reg_address);
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/**
+ * adis16300_spi_write_reg_16() - write 2 bytes to a pair of registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: value to be written
+ **/
+static int adis16300_spi_write_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
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
+	st->tx[0] = ADIS16300_WRITE_REG(lower_reg_address);
+	st->tx[1] = value & 0xFF;
+	st->tx[2] = ADIS16300_WRITE_REG(lower_reg_address + 1);
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
+ * adis16300_spi_read_reg_16() - read 2 bytes from a 16-bit register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: somewhere to pass back the value read
+ **/
+static int adis16300_spi_read_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 0,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 0,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16300_READ_REG(lower_reg_address);
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
+/**
+ * adis16300_spi_read_burst() - read all data registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @rx: somewhere to pass back the value read (min size is 24 bytes)
+ **/
+int adis16300_spi_read_burst(struct device *dev, u8 *rx)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
+	u32 old_speed_hz = st->us->max_speed_hz;
+	int ret;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 0,
+		}, {
+			.rx_buf = rx,
+			.bits_per_word = 8,
+			.len = 18,
+			.cs_change = 0,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16300_READ_REG(ADIS16300_GLOB_CMD);
+	st->tx[1] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+
+	st->us->max_speed_hz = min(ADIS16300_SPI_BURST, old_speed_hz);
+	spi_setup(st->us);
+
+	ret = spi_sync(st->us, &msg);
+	if (ret)
+		dev_err(&st->us->dev, "problem when burst reading");
+
+	st->us->max_speed_hz = old_speed_hz;
+	spi_setup(st->us);
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+/**
+ * adis16300_spi_read_sequence() - read a sequence of 16-bit registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @tx: register addresses in bytes 0,2,4,6... (min size is 2*num bytes)
+ * @rx: somewhere to pass back the value read (min size is 2*num bytes)
+ **/
+int adis16300_spi_read_sequence(struct device *dev,
+		u8 *tx, u8 *rx, int num)
+{
+	struct spi_message msg;
+	struct spi_transfer *xfers;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
+	int ret, i;
+
+	xfers = kzalloc(num + 1, GFP_KERNEL);
+	if (xfers == NULL) {
+		dev_err(&st->us->dev, "memory alloc failed");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	/* tx: |add1|addr2|addr3|...|addrN |zero|
+	 * rx: |zero|res1 |res2 |...|resN-1|resN| */
+	spi_message_init(&msg);
+	for (i = 0; i < num + 1; i++) {
+		if (i > 0)
+			xfers[i].rx_buf = st->rx + 2*(i - 1);
+		if (i < num)
+			xfers[i].tx_buf = st->tx + 2*i;
+		xfers[i].bits_per_word = 8;
+		xfers[i].len = 2;
+		xfers[i].cs_change = 1;
+		spi_message_add_tail(&xfers[i], &msg);
+	}
+
+	mutex_lock(&st->buf_lock);
+
+	ret = spi_sync(st->us, &msg);
+	if (ret)
+		dev_err(&st->us->dev, "problem when reading sequence");
+
+	mutex_unlock(&st->buf_lock);
+	kfree(xfers);
+
+error_ret:
+	return ret;
+}
+
+static ssize_t adis16300_spi_read_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf,
+		unsigned bits)
+{
+	int ret;
+	s16 val = 0;
+	unsigned shift = 16 - bits;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16300_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16300_ERROR_ACTIVE)
+		adis16300_check_status(dev);
+	val = ((s16)(val << shift) >> shift);
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t adis16300_read_12bit_unsigned(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16300_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16300_ERROR_ACTIVE)
+		adis16300_check_status(dev);
+
+	return sprintf(buf, "%u\n", val & 0x0FFF);
+}
+
+static ssize_t adis16300_read_14bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16300_spi_read_signed(dev, attr, buf, 14);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16300_read_12bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16300_spi_read_signed(dev, attr, buf, 12);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16300_read_13bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16300_spi_read_signed(dev, attr, buf, 13);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16300_write_16bit(struct device *dev,
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
+	ret = adis16300_spi_write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t adis16300_read_frequency(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret, len = 0;
+	u16 t;
+	int sps;
+	ret = adis16300_spi_read_reg_16(dev,
+			ADIS16300_SMPL_PRD,
+			&t);
+	if (ret)
+		return ret;
+	sps =  (t & ADIS16300_SMPL_PRD_TIME_BASE) ? 53 : 1638;
+	sps /= (t & ADIS16300_SMPL_PRD_DIV_MASK) + 1;
+	len = sprintf(buf, "%d SPS\n", sps);
+	return len;
+}
+
+static ssize_t adis16300_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
+	long val;
+	int ret;
+	u8 t;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+
+	t = (1638 / val);
+	if (t > 0)
+		t--;
+	t &= ADIS16300_SMPL_PRD_DIV_MASK;
+	if ((t & ADIS16300_SMPL_PRD_DIV_MASK) >= 0x0A)
+		st->us->max_speed_hz = ADIS16300_SPI_SLOW;
+	else
+		st->us->max_speed_hz = ADIS16300_SPI_FAST;
+
+	ret = adis16300_spi_write_reg_8(dev,
+			ADIS16300_SMPL_PRD,
+			t);
+
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+static ssize_t adis16300_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return adis16300_reset(dev);
+	}
+	return -1;
+}
+
+
+
+int adis16300_set_irq(struct device *dev, bool enable)
+{
+	int ret;
+	u16 msc;
+	ret = adis16300_spi_read_reg_16(dev, ADIS16300_MSC_CTRL, &msc);
+	if (ret)
+		goto error_ret;
+
+	msc |= ADIS16300_MSC_CTRL_DATA_RDY_POL_HIGH;
+	msc &= ~ADIS16300_MSC_CTRL_DATA_RDY_DIO2;
+	if (enable)
+		msc |= ADIS16300_MSC_CTRL_DATA_RDY_EN;
+	else
+		msc &= ~ADIS16300_MSC_CTRL_DATA_RDY_EN;
+
+	ret = adis16300_spi_write_reg_16(dev, ADIS16300_MSC_CTRL, msc);
+	if (ret)
+		goto error_ret;
+
+error_ret:
+	return ret;
+}
+
+int adis16300_reset(struct device *dev)
+{
+	int ret;
+	ret = adis16300_spi_write_reg_8(dev,
+			ADIS16300_GLOB_CMD,
+			ADIS16300_GLOB_CMD_SW_RESET);
+	if (ret)
+		dev_err(dev, "problem resetting device");
+
+	return ret;
+}
+
+/* Power down the device */
+int adis16300_stop_device(struct device *dev)
+{
+	int ret;
+	u16 val = ADIS16300_SLP_CNT_POWER_OFF;
+
+	ret = adis16300_spi_write_reg_16(dev, ADIS16300_SLP_CNT, val);
+	if (ret)
+		dev_err(dev, "problem with turning device off: SLP_CNT");
+
+	return ret;
+}
+
+int adis16300_self_test(struct device *dev)
+{
+	int ret;
+	ret = adis16300_spi_write_reg_16(dev,
+			ADIS16300_MSC_CTRL,
+			ADIS16300_MSC_CTRL_MEM_TEST);
+	if (ret) {
+		dev_err(dev, "problem starting self test");
+		goto err_ret;
+	}
+
+	adis16300_check_status(dev);
+
+err_ret:
+	return ret;
+}
+
+int adis16300_check_status(struct device *dev)
+{
+	u16 status;
+	int ret;
+
+	ret = adis16300_spi_read_reg_16(dev, ADIS16300_DIAG_STAT, &status);
+
+	if (ret < 0) {
+		dev_err(dev, "Reading status failed\n");
+		goto error_ret;
+	}
+	ret = status;
+	if (status & ADIS16300_DIAG_STAT_ZACCL_FAIL)
+		dev_err(dev, "Z-axis accelerometer self-test failure\n");
+	if (status & ADIS16300_DIAG_STAT_YACCL_FAIL)
+		dev_err(dev, "Y-axis accelerometer self-test failure\n");
+	if (status & ADIS16300_DIAG_STAT_XACCL_FAIL)
+		dev_err(dev, "X-axis accelerometer self-test failure\n");
+	if (status & ADIS16300_DIAG_STAT_XGYRO_FAIL)
+		dev_err(dev, "X-axis gyroscope self-test failure\n");
+	if (status & ADIS16300_DIAG_STAT_ALARM2)
+		dev_err(dev, "Alarm 2 active\n");
+	if (status & ADIS16300_DIAG_STAT_ALARM1)
+		dev_err(dev, "Alarm 1 active\n");
+	if (status & ADIS16300_DIAG_STAT_FLASH_CHK)
+		dev_err(dev, "Flash checksum error\n");
+	if (status & ADIS16300_DIAG_STAT_SELF_TEST)
+		dev_err(dev, "Self test error\n");
+	if (status & ADIS16300_DIAG_STAT_OVERFLOW)
+		dev_err(dev, "Sensor overrange\n");
+	if (status & ADIS16300_DIAG_STAT_SPI_FAIL)
+		dev_err(dev, "SPI failure\n");
+	if (status & ADIS16300_DIAG_STAT_FLASH_UPT)
+		dev_err(dev, "Flash update failed\n");
+	if (status & ADIS16300_DIAG_STAT_POWER_HIGH)
+		dev_err(dev, "Power supply above 5.25V\n");
+	if (status & ADIS16300_DIAG_STAT_POWER_LOW)
+		dev_err(dev, "Power supply below 4.75V\n");
+
+error_ret:
+	return ret;
+}
+
+static int adis16300_initial_setup(struct adis16300_state *st)
+{
+	int ret;
+	u16 smp_prd;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* use low spi speed for init */
+	st->us->max_speed_hz = ADIS16300_SPI_SLOW;
+	st->us->mode = SPI_MODE_3;
+	spi_setup(st->us);
+
+	/* Disable IRQ */
+	ret = adis16300_set_irq(dev, false);
+	if (ret) {
+		dev_err(dev, "disable irq failed");
+		goto err_ret;
+	}
+
+	/* Do self test */
+
+	/* Read status register to check the result */
+	ret = adis16300_check_status(dev);
+	if (ret) {
+		adis16300_reset(dev);
+		dev_err(dev, "device not playing ball -> reset");
+		msleep(ADIS16300_STARTUP_DELAY);
+		ret = adis16300_check_status(dev);
+		if (ret) {
+			dev_err(dev, "giving up");
+			goto err_ret;
+		}
+	}
+
+	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
+			st->us->chip_select, st->us->irq);
+
+	/* use high spi speed if possible */
+	ret = adis16300_spi_read_reg_16(dev, ADIS16300_SMPL_PRD, &smp_prd);
+	if (!ret && (smp_prd & ADIS16300_SMPL_PRD_DIV_MASK) < 0x0A) {
+		st->us->max_speed_hz = ADIS16300_SPI_SLOW;
+		spi_setup(st->us);
+	}
+
+err_ret:
+	return ret;
+}
+
+static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+		adis16300_read_12bit_signed,
+		adis16300_write_16bit,
+		ADIS16300_XACCL_OFF);
+
+static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+		adis16300_read_12bit_signed,
+		adis16300_write_16bit,
+		ADIS16300_YACCL_OFF);
+
+static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
+		adis16300_read_12bit_signed,
+		adis16300_write_16bit,
+		ADIS16300_ZACCL_OFF);
+
+static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16300_read_14bit_signed,
+			   ADIS16300_SUPPLY_OUT);
+static IIO_CONST_ATTR(in_supply_scale, "0.00242");
+
+static IIO_DEV_ATTR_GYRO_X(adis16300_read_14bit_signed,
+		ADIS16300_XGYRO_OUT);
+static IIO_CONST_ATTR(gyro_scale, "0.05 deg/s");
+
+static IIO_DEV_ATTR_ACCEL_X(adis16300_read_14bit_signed,
+		ADIS16300_XACCL_OUT);
+static IIO_DEV_ATTR_ACCEL_Y(adis16300_read_14bit_signed,
+		ADIS16300_YACCL_OUT);
+static IIO_DEV_ATTR_ACCEL_Z(adis16300_read_14bit_signed,
+		ADIS16300_ZACCL_OUT);
+static IIO_CONST_ATTR(accel_scale, "0.0006 g");
+
+static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
+		ADIS16300_XINCLI_OUT);
+static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
+		ADIS16300_YINCLI_OUT);
+static IIO_CONST_ATTR(incli_scale, "0.044 d");
+
+static IIO_DEV_ATTR_TEMP(adis16300_read_12bit_signed);
+static IIO_CONST_ATTR(temp_offset, "198.16 K");
+static IIO_CONST_ATTR(temp_scale, "0.14 K");
+
+static IIO_DEV_ATTR_IN_RAW(0, adis16300_read_12bit_unsigned,
+		ADIS16300_AUX_ADC);
+static IIO_CONST_ATTR(in0_scale, "0.000806");
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+		adis16300_read_frequency,
+		adis16300_write_frequency);
+
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16300_write_reset, 0);
+
+static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
+
+static IIO_CONST_ATTR(name, "adis16300");
+
+static struct attribute *adis16300_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group adis16300_event_attribute_group = {
+	.attrs = adis16300_event_attributes,
+};
+
+static struct attribute *adis16300_attributes[] = {
+	&iio_dev_attr_accel_x_offset.dev_attr.attr,
+	&iio_dev_attr_accel_y_offset.dev_attr.attr,
+	&iio_dev_attr_accel_z_offset.dev_attr.attr,
+	&iio_dev_attr_in_supply_raw.dev_attr.attr,
+	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_gyro_x.dev_attr.attr,
+	&iio_const_attr_gyro_scale.dev_attr.attr,
+	&iio_dev_attr_accel_x_raw.dev_attr.attr,
+	&iio_dev_attr_accel_y_raw.dev_attr.attr,
+	&iio_dev_attr_accel_z_raw.dev_attr.attr,
+	&iio_const_attr_accel_scale.dev_attr.attr,
+	&iio_dev_attr_incli_x.dev_attr.attr,
+	&iio_dev_attr_incli_y.dev_attr.attr,
+	&iio_const_attr_incli_scale.dev_attr.attr,
+	&iio_dev_attr_temp.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16300_attribute_group = {
+	.attrs = adis16300_attributes,
+};
+
+static int __devinit adis16300_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16300_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16300_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16300_MAX_TX, GFP_KERNEL);
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
+	st->indio_dev->event_attrs = &adis16300_event_attribute_group;
+	st->indio_dev->attrs = &adis16300_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16300_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = adis16300_initialize_ring(st->indio_dev->ring);
+	if (ret) {
+		printk(KERN_ERR "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
+#if 0 /* fixme: here we should support */
+		iio_init_work_cont(&st->work_cont_thresh,
+				NULL,
+				adis16300_thresh_handler_bh_no_check,
+				0,
+				0,
+				st);
+#endif
+		ret = iio_register_interrupt_line(spi->irq,
+				st->indio_dev,
+				0,
+				IRQF_TRIGGER_RISING,
+				"adis16300");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = adis16300_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	/* Get the device into a sane initial state */
+	ret = adis16300_initial_setup(st);
+	if (ret)
+		goto error_remove_trigger;
+	return 0;
+
+error_remove_trigger:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		adis16300_remove_trigger(st->indio_dev);
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	adis16300_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	adis16300_unconfigure_ring(st->indio_dev);
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
+static int adis16300_remove(struct spi_device *spi)
+{
+	int ret;
+	struct adis16300_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	ret = adis16300_stop_device(&(indio_dev->dev));
+	if (ret)
+		goto err_ret;
+
+	flush_scheduled_work();
+
+	adis16300_remove_trigger(indio_dev);
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	adis16300_uninitialize_ring(indio_dev->ring);
+	adis16300_unconfigure_ring(indio_dev);
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
+static struct spi_driver adis16300_driver = {
+	.driver = {
+		.name = "adis16300",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16300_probe,
+	.remove = __devexit_p(adis16300_remove),
+};
+
+static __init int adis16300_init(void)
+{
+	return spi_register_driver(&adis16300_driver);
+}
+module_init(adis16300_init);
+
+static __exit void adis16300_exit(void)
+{
+	spi_unregister_driver(&adis16300_driver);
+}
+module_exit(adis16300_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16300 IMU SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
new file mode 100644
index 0000000..76cf8a6
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -0,0 +1,233 @@
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../ring_sw.h"
+#include "../accel/accel.h"
+#include "../trigger.h"
+#include "adis16300.h"
+
+/**
+ * combine_8_to_16() utility function to munge to u8s into u16
+ **/
+static inline u16 combine_8_to_16(u8 lower, u8 upper)
+{
+	u16 _lower = lower;
+	u16 _upper = upper;
+	return _lower | (_upper << 8);
+}
+
+static IIO_SCAN_EL_C(supply, ADIS16300_SCAN_SUPPLY, IIO_SIGNED(14),
+		     ADIS16300_SUPPLY_OUT, NULL);
+
+static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, IIO_SIGNED(14),
+		     ADIS16300_XGYRO_OUT, NULL);
+
+static IIO_SCAN_EL_C(accel_x, ADIS16300_SCAN_ACC_X, IIO_SIGNED(14),
+		     ADIS16300_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16300_SCAN_ACC_Y, IIO_SIGNED(14),
+		     ADIS16300_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16300_SCAN_ACC_Z, IIO_SIGNED(14),
+		     ADIS16300_ZACCL_OUT, NULL);
+
+static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_SIGNED(12),
+		     ADIS16300_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(adc_0, ADIS16300_SCAN_ADC_0, IIO_SIGNED(12),
+		     ADIS16300_AUX_ADC, NULL);
+
+static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, IIO_SIGNED(12),
+		     ADIS16300_XINCLI_OUT, NULL);
+static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y, IIO_SIGNED(12),
+		     ADIS16300_YINCLI_OUT, NULL);
+
+static IIO_SCAN_EL_TIMESTAMP(9);
+
+static struct attribute *adis16300_scan_el_attrs[] = {
+	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_gyro_x.dev_attr.attr,
+	&iio_scan_el_temp.dev_attr.attr,
+	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_scan_el_incli_x.dev_attr.attr,
+	&iio_scan_el_incli_y.dev_attr.attr,
+	&iio_scan_el_adc_0.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group adis16300_scan_el_group = {
+	.attrs = adis16300_scan_el_attrs,
+	.name = "scan_elements",
+};
+
+/**
+ * adis16300_poll_func_th() top half interrupt handler called by trigger
+ * @private_data:	iio_dev
+ **/
+static void adis16300_poll_func_th(struct iio_dev *indio_dev)
+{
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
+	st->last_timestamp = indio_dev->trig->timestamp;
+	schedule_work(&st->work_trigger_to_ring);
+	/* Indicate that this interrupt is being handled */
+
+	/* Technically this is trigger related, but without this
+	 * handler running there is currently no way for the interrupt
+	 * to clear.
+	 */
+}
+
+/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
+ * specific to be rolled into the core.
+ */
+static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct adis16300_state *st
+		= container_of(work_s, struct adis16300_state,
+			       work_trigger_to_ring);
+
+	int i = 0;
+	s16 *data;
+	size_t datasize = st->indio_dev
+		->ring->access.get_bpd(st->indio_dev->ring);
+
+	data = kmalloc(datasize , GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(&st->us->dev, "memory alloc failed in ring bh");
+		return;
+	}
+
+	if (st->indio_dev->scan_count)
+		if (adis16300_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
+			for (; i < st->indio_dev->scan_count; i++) {
+				data[i] = combine_8_to_16(st->rx[i*2+1],
+							  st->rx[i*2]);
+			}
+
+	/* Guaranteed to be aligned with 8 byte boundary */
+	if (st->indio_dev->scan_timestamp)
+		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
+
+	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
+					    (u8 *)data,
+					    st->last_timestamp);
+
+	iio_trigger_notify_done(st->indio_dev->trig);
+	kfree(data);
+
+	return;
+}
+/* in these circumstances is it better to go with unaligned packing and
+ * deal with the cost?*/
+static int adis16300_data_rdy_ring_preenable(struct iio_dev *indio_dev)
+{
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
+		return -EINVAL;
+
+	if (indio_dev->ring->access.set_bpd) {
+		if (indio_dev->scan_timestamp)
+			if (indio_dev->scan_count) /* Timestamp and data */
+				size = 4*sizeof(s64);
+			else /* Timestamp only  */
+				size = sizeof(s64);
+		else /* Data only */
+			size = indio_dev->scan_count*sizeof(s16);
+		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
+	}
+
+	return 0;
+}
+
+static int adis16300_data_rdy_ring_postenable(struct iio_dev *indio_dev)
+{
+	return indio_dev->trig
+		? iio_trigger_attach_poll_func(indio_dev->trig,
+					       indio_dev->pollfunc)
+		: 0;
+}
+
+static int adis16300_data_rdy_ring_predisable(struct iio_dev *indio_dev)
+{
+	return indio_dev->trig
+		? iio_trigger_dettach_poll_func(indio_dev->trig,
+						indio_dev->pollfunc)
+		: 0;
+}
+
+void adis16300_unconfigure_ring(struct iio_dev *indio_dev)
+{
+	kfree(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
+
+int adis16300_configure_ring(struct iio_dev *indio_dev)
+{
+	int ret = 0;
+	struct adis16300_state *st = indio_dev->dev_data;
+	struct iio_ring_buffer *ring;
+	INIT_WORK(&st->work_trigger_to_ring, adis16300_trigger_bh_to_ring);
+	/* Set default scan mode */
+
+	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_x.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_adc_0.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number);
+	indio_dev->scan_timestamp = true;
+
+	indio_dev->scan_el_attrs = &adis16300_scan_el_group;
+
+	ring = iio_sw_rb_allocate(indio_dev);
+	if (!ring) {
+		ret = -ENOMEM;
+		return ret;
+	}
+	indio_dev->ring = ring;
+	/* Effectively select the ring buffer implementation */
+	iio_ring_sw_register_funcs(&ring->access);
+	ring->preenable = &adis16300_data_rdy_ring_preenable;
+	ring->postenable = &adis16300_data_rdy_ring_postenable;
+	ring->predisable = &adis16300_data_rdy_ring_predisable;
+	ring->owner = THIS_MODULE;
+
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_iio_sw_rb_free;;
+	}
+	indio_dev->pollfunc->poll_func_main = &adis16300_poll_func_th;
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	return 0;
+
+error_iio_sw_rb_free:
+	iio_sw_rb_free(indio_dev->ring);
+	return ret;
+}
+
+int adis16300_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return iio_ring_buffer_register(ring, 0);
+}
+
+void adis16300_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+	iio_ring_buffer_unregister(ring);
+}
diff --git a/drivers/staging/iio/imu/adis16300_trigger.c b/drivers/staging/iio/imu/adis16300_trigger.c
new file mode 100644
index 0000000..54edb20
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16300_trigger.c
@@ -0,0 +1,127 @@
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
+#include "adis16300.h"
+
+/**
+ * adis16300_data_rdy_trig_poll() the event handler for the data rdy trig
+ **/
+static int adis16300_data_rdy_trig_poll(struct iio_dev *dev_info,
+				       int index,
+				       s64 timestamp,
+				       int no_test)
+{
+	struct adis16300_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_trigger *trig = st->trig;
+
+	trig->timestamp = timestamp;
+	iio_trigger_poll(trig);
+
+	return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(data_rdy_trig, &adis16300_data_rdy_trig_poll);
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static struct attribute *adis16300_trigger_attrs[] = {
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group adis16300_trigger_attr_group = {
+	.attrs = adis16300_trigger_attrs,
+};
+
+/**
+ * adis16300_data_rdy_trigger_set_state() set datardy interrupt state
+ **/
+static int adis16300_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct adis16300_state *st = trig->private_data;
+	struct iio_dev *indio_dev = st->indio_dev;
+	int ret = 0;
+
+	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	ret = adis16300_set_irq(&st->indio_dev->dev, state);
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
+ * adis16300_trig_try_reen() try renabling irq for data rdy trigger
+ * @trig:	the datardy trigger
+ **/
+static int adis16300_trig_try_reen(struct iio_trigger *trig)
+{
+	struct adis16300_state *st = trig->private_data;
+	enable_irq(st->us->irq);
+	/* irq reenabled so success! */
+	return 0;
+}
+
+int adis16300_probe_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct adis16300_state *st = indio_dev->dev_data;
+
+	st->trig = iio_allocate_trigger();
+	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	if (!st->trig->name) {
+		ret = -ENOMEM;
+		goto error_free_trig;
+	}
+	snprintf((char *)st->trig->name,
+		 IIO_TRIGGER_NAME_LENGTH,
+		 "adis16300-dev%d", indio_dev->id);
+	st->trig->dev.parent = &st->us->dev;
+	st->trig->owner = THIS_MODULE;
+	st->trig->private_data = st;
+	st->trig->set_trigger_state = &adis16300_data_rdy_trigger_set_state;
+	st->trig->try_reenable = &adis16300_trig_try_reen;
+	st->trig->control_attrs = &adis16300_trigger_attr_group;
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
+void adis16300_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct adis16300_state *state = indio_dev->dev_data;
+
+	iio_trigger_unregister(state->trig);
+	kfree(state->trig->name);
+	iio_free_trigger(state->trig);
+}
-- 
1.6.4.4

