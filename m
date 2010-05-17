Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Barry Song <Barry.Song@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: adis16360 imu driver
Date: Mon, 17 May 2010 11:32:04 +0100
Message-Id: <1274092324-8298-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <Barry.Song@analog.com>

Signed-off-by: Barry Song <Barry.Song@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
Another driver from Barry at Analog.  Again, I've lifted
if from the blackfin tree and done the usual sparse
and checkpatch fixes + the abi changes.  I actually
have one of these, so am particularly pleased to see
it supported!

 drivers/staging/iio/imu/Kconfig             |    9 +
 drivers/staging/iio/imu/Makefile            |    4 +
 drivers/staging/iio/imu/adis16350.h         |  193 +++++++
 drivers/staging/iio/imu/adis16350_core.c    |  736 +++++++++++++++++++++++++++
 drivers/staging/iio/imu/adis16350_ring.c    |  286 +++++++++++
 drivers/staging/iio/imu/adis16350_trigger.c |  127 +++++
 6 files changed, 1355 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 411804f..6308d6f 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -13,6 +13,15 @@ config ADIS16300
 	  Say yes here to build support for Analog Devices adis16300 four degrees
 	  of freedom inertial sensor.
 
+config ADIS16350
+	tristate "Analog Devices ADIS16350/54/55/60/62/64/65 IMU SPI driver"
+	depends on SPI
+	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	help
+	  Say yes here to build support for Analog Devices adis16350/54/55/60/62/64/65
+	  high precision tri-axis inertial sensor.
+
 config ADIS16400
 	tristate "Analog Devices ADIS16400/5 IMU SPI driver"
  	depends on SPI
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index de454dd..31df735 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -5,6 +5,10 @@ adis16300-y             := adis16300_core.o
 adis16300-$(CONFIG_IIO_RING_BUFFER) += adis16300_ring.o adis16300_trigger.o
 obj-$(CONFIG_ADIS16300) += adis16300.o
 
+adis16350-y             := adis16350_core.o
+adis16350-$(CONFIG_IIO_RING_BUFFER) += adis16350_ring.o adis16350_trigger.o
+obj-$(CONFIG_ADIS16350) += adis16350.o
+
 adis16400-y             := adis16400_core.o
 adis16400-$(CONFIG_IIO_RING_BUFFER) += adis16400_ring.o adis16400_trigger.o
 obj-$(CONFIG_ADIS16400) += adis16400.o
\ No newline at end of file
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
new file mode 100644
index 0000000..334b18a
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -0,0 +1,193 @@
+#ifndef SPI_ADIS16350_H_
+#define SPI_ADIS16350_H_
+
+#define ADIS16350_STARTUP_DELAY	220 /* ms */
+
+#define ADIS16350_READ_REG(a)    a
+#define ADIS16350_WRITE_REG(a) ((a) | 0x80)
+
+#define ADIS16350_FLASH_CNT  0x00 /* Flash memory write count */
+#define ADIS16350_SUPPLY_OUT 0x02 /* Power supply measurement */
+#define ADIS16350_XGYRO_OUT 0x04 /* X-axis gyroscope output */
+#define ADIS16350_YGYRO_OUT 0x06 /* Y-axis gyroscope output */
+#define ADIS16350_ZGYRO_OUT 0x08 /* Z-axis gyroscope output */
+#define ADIS16350_XACCL_OUT 0x0A /* X-axis accelerometer output */
+#define ADIS16350_YACCL_OUT 0x0C /* Y-axis accelerometer output */
+#define ADIS16350_ZACCL_OUT 0x0E /* Z-axis accelerometer output */
+#define ADIS16350_XTEMP_OUT 0x10 /* X-axis gyroscope temperature measurement */
+#define ADIS16350_YTEMP_OUT 0x12 /* Y-axis gyroscope temperature measurement */
+#define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
+#define ADIS16350_AUX_ADC   0x16 /* Auxiliary ADC measurement */
+
+/* Calibration parameters */
+#define ADIS16350_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
+#define ADIS16350_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
+#define ADIS16350_ZGYRO_OFF 0x1E /* Z-axis gyroscope bias offset factor */
+#define ADIS16350_XACCL_OFF 0x20 /* X-axis acceleration bias offset factor */
+#define ADIS16350_YACCL_OFF 0x22 /* Y-axis acceleration bias offset factor */
+#define ADIS16350_ZACCL_OFF 0x24 /* Z-axis acceleration bias offset factor */
+
+#define ADIS16350_GPIO_CTRL 0x32 /* Auxiliary digital input/output control */
+#define ADIS16350_MSC_CTRL  0x34 /* Miscellaneous control */
+#define ADIS16350_SMPL_PRD  0x36 /* Internal sample period (rate) control */
+#define ADIS16350_SENS_AVG  0x38 /* Dynamic range and digital filter control */
+#define ADIS16350_SLP_CNT   0x3A /* Sleep mode control */
+#define ADIS16350_DIAG_STAT 0x3C /* System status */
+
+/* Alarm functions */
+#define ADIS16350_GLOB_CMD  0x3E /* System command */
+#define ADIS16350_ALM_MAG1  0x26 /* Alarm 1 amplitude threshold */
+#define ADIS16350_ALM_MAG2  0x28 /* Alarm 2 amplitude threshold */
+#define ADIS16350_ALM_SMPL1 0x2A /* Alarm 1 sample size */
+#define ADIS16350_ALM_SMPL2 0x2C /* Alarm 2 sample size */
+#define ADIS16350_ALM_CTRL  0x2E /* Alarm control */
+#define ADIS16350_AUX_DAC   0x30 /* Auxiliary DAC data */
+
+#define ADIS16350_ERROR_ACTIVE			(1<<14)
+#define ADIS16350_NEW_DATA			(1<<15)
+
+/* MSC_CTRL */
+#define ADIS16350_MSC_CTRL_MEM_TEST		(1<<11)
+#define ADIS16350_MSC_CTRL_INT_SELF_TEST	(1<<10)
+#define ADIS16350_MSC_CTRL_NEG_SELF_TEST	(1<<9)
+#define ADIS16350_MSC_CTRL_POS_SELF_TEST	(1<<8)
+#define ADIS16350_MSC_CTRL_GYRO_BIAS		(1<<7)
+#define ADIS16350_MSC_CTRL_ACCL_ALIGN		(1<<6)
+#define ADIS16350_MSC_CTRL_DATA_RDY_EN		(1<<2)
+#define ADIS16350_MSC_CTRL_DATA_RDY_POL_HIGH	(1<<1)
+#define ADIS16350_MSC_CTRL_DATA_RDY_DIO2	(1<<0)
+
+/* SMPL_PRD */
+#define ADIS16350_SMPL_PRD_TIME_BASE	(1<<7)
+#define ADIS16350_SMPL_PRD_DIV_MASK	0x7F
+
+/* DIAG_STAT */
+#define ADIS16350_DIAG_STAT_ZACCL_FAIL	(1<<15)
+#define ADIS16350_DIAG_STAT_YACCL_FAIL	(1<<14)
+#define ADIS16350_DIAG_STAT_XACCL_FAIL	(1<<13)
+#define ADIS16350_DIAG_STAT_XGYRO_FAIL	(1<<12)
+#define ADIS16350_DIAG_STAT_YGYRO_FAIL	(1<<11)
+#define ADIS16350_DIAG_STAT_ZGYRO_FAIL	(1<<10)
+#define ADIS16350_DIAG_STAT_ALARM2	(1<<9)
+#define ADIS16350_DIAG_STAT_ALARM1	(1<<8)
+#define ADIS16350_DIAG_STAT_FLASH_CHK	(1<<6)
+#define ADIS16350_DIAG_STAT_SELF_TEST	(1<<5)
+#define ADIS16350_DIAG_STAT_OVERFLOW	(1<<4)
+#define ADIS16350_DIAG_STAT_SPI_FAIL	(1<<3)
+#define ADIS16350_DIAG_STAT_FLASH_UPT	(1<<2)
+#define ADIS16350_DIAG_STAT_POWER_HIGH	(1<<1)
+#define ADIS16350_DIAG_STAT_POWER_LOW	(1<<0)
+
+/* GLOB_CMD */
+#define ADIS16350_GLOB_CMD_SW_RESET	(1<<7)
+#define ADIS16350_GLOB_CMD_P_AUTO_NULL	(1<<4)
+#define ADIS16350_GLOB_CMD_FLASH_UPD	(1<<3)
+#define ADIS16350_GLOB_CMD_DAC_LATCH	(1<<2)
+#define ADIS16350_GLOB_CMD_FAC_CALIB	(1<<1)
+#define ADIS16350_GLOB_CMD_AUTO_NULL	(1<<0)
+
+/* SLP_CNT */
+#define ADIS16350_SLP_CNT_POWER_OFF	(1<<8)
+
+#define ADIS16350_MAX_TX 24
+#define ADIS16350_MAX_RX 24
+
+#define ADIS16350_SPI_SLOW	(u32)(300 * 1000)
+#define ADIS16350_SPI_BURST	(u32)(1000 * 1000)
+#define ADIS16350_SPI_FAST	(u32)(2000 * 1000)
+
+/**
+ * struct adis16350_state - device instance specific data
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
+struct adis16350_state {
+	struct spi_device		*us;
+	struct work_struct		work_trigger_to_ring;
+	struct iio_work_cont		work_cont_data_rdy;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	struct mutex			buf_lock;
+};
+
+int adis16350_set_irq(struct device *dev, bool enable);
+
+#ifdef CONFIG_IIO_RING_BUFFER
+
+enum adis16350_scan {
+	ADIS16350_SCAN_SUPPLY,
+	ADIS16350_SCAN_GYRO_X,
+	ADIS16350_SCAN_GYRO_Y,
+	ADIS16350_SCAN_GYRO_Z,
+	ADIS16350_SCAN_ACC_X,
+	ADIS16350_SCAN_ACC_Y,
+	ADIS16350_SCAN_ACC_Z,
+	ADIS16350_SCAN_TEMP_X,
+	ADIS16350_SCAN_TEMP_Y,
+	ADIS16350_SCAN_TEMP_Z,
+	ADIS16350_SCAN_ADC_0
+};
+
+void adis16350_remove_trigger(struct iio_dev *indio_dev);
+int adis16350_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t adis16350_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+
+int adis16350_configure_ring(struct iio_dev *indio_dev);
+void adis16350_unconfigure_ring(struct iio_dev *indio_dev);
+
+int adis16350_initialize_ring(struct iio_ring_buffer *ring);
+void adis16350_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void adis16350_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16350_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+adis16350_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int adis16350_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16350_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+
+static inline void adis16350_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* SPI_ADIS16350_H_ */
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
new file mode 100644
index 0000000..0edde73
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -0,0 +1,736 @@
+/*
+ * ADIS16350/54/55/60/62/64/65 high precision tri-axis inertial sensor
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
+#include "../adc/adc.h"
+#include "../gyro/gyro.h"
+
+#include "adis16350.h"
+
+#define DRIVER_NAME		"adis16350"
+
+static int adis16350_check_status(struct device *dev);
+
+/**
+ * adis16350_spi_write_reg_8() - write single byte to a register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the register to be written
+ * @val: the value to write
+ **/
+static int adis16350_spi_write_reg_8(struct device *dev,
+		u8 reg_address,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16350_WRITE_REG(reg_address);
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+/**
+ * adis16350_spi_write_reg_16() - write 2 bytes to a pair of registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: value to be written
+ **/
+static int adis16350_spi_write_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 value)
+{
+	int ret;
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
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
+	st->tx[0] = ADIS16350_WRITE_REG(lower_reg_address);
+	st->tx[1] = value & 0xFF;
+	st->tx[2] = ADIS16350_WRITE_REG(lower_reg_address + 1);
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
+ * adis16350_spi_read_reg_16() - read 2 bytes from a 16-bit register
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @reg_address: the address of the lower of the two registers. Second register
+ *               is assumed to have address one greater.
+ * @val: somewhere to pass back the value read
+ **/
+static int adis16350_spi_read_reg_16(struct device *dev,
+		u8 lower_reg_address,
+		u16 *val)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
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
+	st->tx[0] = ADIS16350_READ_REG(lower_reg_address);
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
+
+static ssize_t adis16350_spi_read_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf,
+		unsigned bits)
+{
+	int ret;
+	s16 val = 0;
+	unsigned shift = 16 - bits;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16350_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16350_ERROR_ACTIVE)
+		adis16350_check_status(dev);
+	val = ((s16)(val << shift) >> shift);
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t adis16350_read_12bit_unsigned(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16350_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16350_ERROR_ACTIVE)
+		adis16350_check_status(dev);
+
+	return sprintf(buf, "%u\n", val & 0x0FFF);
+}
+
+static ssize_t adis16350_read_14bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16350_spi_read_signed(dev, attr, buf, 14);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16350_read_12bit_signed(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16350_spi_read_signed(dev, attr, buf, 12);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static ssize_t adis16350_write_16bit(struct device *dev,
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
+	ret = adis16350_spi_write_reg_16(dev, this_attr->address, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t adis16350_read_frequency(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret, len = 0;
+	u16 t;
+	int sps;
+	ret = adis16350_spi_read_reg_16(dev,
+			ADIS16350_SMPL_PRD,
+			&t);
+	if (ret)
+		return ret;
+	sps =  (t & ADIS16350_SMPL_PRD_TIME_BASE) ? 53 : 1638;
+	sps /= (t & ADIS16350_SMPL_PRD_DIV_MASK) + 1;
+	len = sprintf(buf, "%d SPS\n", sps);
+	return len;
+}
+
+static ssize_t adis16350_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
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
+	t &= ADIS16350_SMPL_PRD_DIV_MASK;
+	if ((t & ADIS16350_SMPL_PRD_DIV_MASK) >= 0x0A)
+		st->us->max_speed_hz = ADIS16350_SPI_SLOW;
+	else
+		st->us->max_speed_hz = ADIS16350_SPI_FAST;
+
+	ret = adis16350_spi_write_reg_8(dev,
+			ADIS16350_SMPL_PRD,
+			t);
+
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+static int adis16350_reset(struct device *dev)
+{
+	int ret;
+	ret = adis16350_spi_write_reg_8(dev,
+			ADIS16350_GLOB_CMD,
+			ADIS16350_GLOB_CMD_SW_RESET);
+	if (ret)
+		dev_err(dev, "problem resetting device");
+
+	return ret;
+}
+
+static ssize_t adis16350_write_reset(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	if (len < 1)
+		return -1;
+	switch (buf[0]) {
+	case '1':
+	case 'y':
+	case 'Y':
+		return adis16350_reset(dev);
+	}
+	return -1;
+}
+
+int adis16350_set_irq(struct device *dev, bool enable)
+{
+	int ret;
+	u16 msc;
+	ret = adis16350_spi_read_reg_16(dev, ADIS16350_MSC_CTRL, &msc);
+	if (ret)
+		goto error_ret;
+
+	msc |= ADIS16350_MSC_CTRL_DATA_RDY_POL_HIGH;
+	msc &= ~ADIS16350_MSC_CTRL_DATA_RDY_DIO2;
+
+	if (enable)
+		msc |= ADIS16350_MSC_CTRL_DATA_RDY_EN;
+	else
+		msc &= ~ADIS16350_MSC_CTRL_DATA_RDY_EN;
+
+	ret = adis16350_spi_write_reg_16(dev, ADIS16350_MSC_CTRL, msc);
+	if (ret)
+		goto error_ret;
+
+error_ret:
+	return ret;
+}
+
+/* Power down the device */
+static int adis16350_stop_device(struct device *dev)
+{
+	int ret;
+	u16 val = ADIS16350_SLP_CNT_POWER_OFF;
+
+	ret = adis16350_spi_write_reg_16(dev, ADIS16350_SLP_CNT, val);
+	if (ret)
+		dev_err(dev, "problem with turning device off: SLP_CNT");
+
+	return ret;
+}
+
+static int adis16350_self_test(struct device *dev)
+{
+	int ret;
+	ret = adis16350_spi_write_reg_16(dev,
+			ADIS16350_MSC_CTRL,
+			ADIS16350_MSC_CTRL_MEM_TEST);
+	if (ret) {
+		dev_err(dev, "problem starting self test");
+		goto err_ret;
+	}
+
+	adis16350_check_status(dev);
+
+err_ret:
+	return ret;
+}
+
+static int adis16350_check_status(struct device *dev)
+{
+	u16 status;
+	int ret;
+
+	ret = adis16350_spi_read_reg_16(dev, ADIS16350_DIAG_STAT, &status);
+
+	if (ret < 0) {
+		dev_err(dev, "Reading status failed\n");
+		goto error_ret;
+	}
+	ret = status;
+	if (status & ADIS16350_DIAG_STAT_ZACCL_FAIL)
+		dev_err(dev, "Z-axis accelerometer self-test failure\n");
+	if (status & ADIS16350_DIAG_STAT_YACCL_FAIL)
+		dev_err(dev, "Y-axis accelerometer self-test failure\n");
+	if (status & ADIS16350_DIAG_STAT_XACCL_FAIL)
+		dev_err(dev, "X-axis accelerometer self-test failure\n");
+	if (status & ADIS16350_DIAG_STAT_XGYRO_FAIL)
+		dev_err(dev, "X-axis gyroscope self-test failure\n");
+	if (status & ADIS16350_DIAG_STAT_YGYRO_FAIL)
+		dev_err(dev, "Y-axis gyroscope self-test failure\n");
+	if (status & ADIS16350_DIAG_STAT_ZGYRO_FAIL)
+		dev_err(dev, "Z-axis gyroscope self-test failure\n");
+	if (status & ADIS16350_DIAG_STAT_ALARM2)
+		dev_err(dev, "Alarm 2 active\n");
+	if (status & ADIS16350_DIAG_STAT_ALARM1)
+		dev_err(dev, "Alarm 1 active\n");
+	if (status & ADIS16350_DIAG_STAT_FLASH_CHK)
+		dev_err(dev, "Flash checksum error\n");
+	if (status & ADIS16350_DIAG_STAT_SELF_TEST)
+		dev_err(dev, "Self test error\n");
+	if (status & ADIS16350_DIAG_STAT_OVERFLOW)
+		dev_err(dev, "Sensor overrange\n");
+	if (status & ADIS16350_DIAG_STAT_SPI_FAIL)
+		dev_err(dev, "SPI failure\n");
+	if (status & ADIS16350_DIAG_STAT_FLASH_UPT)
+		dev_err(dev, "Flash update failed\n");
+	if (status & ADIS16350_DIAG_STAT_POWER_HIGH)
+		dev_err(dev, "Power supply above 5.25V\n");
+	if (status & ADIS16350_DIAG_STAT_POWER_LOW)
+		dev_err(dev, "Power supply below 4.75V\n");
+
+error_ret:
+	return ret;
+}
+
+static int adis16350_initial_setup(struct adis16350_state *st)
+{
+	int ret;
+	u16 smp_prd;
+	struct device *dev = &st->indio_dev->dev;
+
+	/* use low spi speed for init */
+	st->us->max_speed_hz = ADIS16350_SPI_SLOW;
+	st->us->mode = SPI_MODE_3;
+	spi_setup(st->us);
+
+	/* Disable IRQ */
+	ret = adis16350_set_irq(dev, false);
+	if (ret) {
+		dev_err(dev, "disable irq failed");
+		goto err_ret;
+	}
+
+	/* Do self test */
+	ret = adis16350_self_test(dev);
+	if (ret) {
+		dev_err(dev, "self test failure");
+		goto err_ret;
+	}
+
+	/* Read status register to check the result */
+	ret = adis16350_check_status(dev);
+	if (ret) {
+		adis16350_reset(dev);
+		dev_err(dev, "device not playing ball -> reset");
+		msleep(ADIS16350_STARTUP_DELAY);
+		ret = adis16350_check_status(dev);
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
+	ret = adis16350_spi_read_reg_16(dev, ADIS16350_SMPL_PRD, &smp_prd);
+	if (!ret && (smp_prd & ADIS16350_SMPL_PRD_DIV_MASK) < 0x0A) {
+		st->us->max_speed_hz = ADIS16350_SPI_SLOW;
+		spi_setup(st->us);
+	}
+
+err_ret:
+	return ret;
+}
+
+static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
+		adis16350_read_12bit_signed,
+		adis16350_write_16bit,
+		ADIS16350_XACCL_OFF);
+
+static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
+		adis16350_read_12bit_signed,
+		adis16350_write_16bit,
+		ADIS16350_YACCL_OFF);
+
+static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
+		adis16350_read_12bit_signed,
+		adis16350_write_16bit,
+		ADIS16350_ZACCL_OFF);
+
+static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16350_read_12bit_unsigned,
+		ADIS16350_SUPPLY_OUT);
+static IIO_CONST_ATTR(in_supply_scale, "0.002418");
+
+static IIO_DEV_ATTR_GYRO_X(adis16350_read_14bit_signed,
+		ADIS16350_XGYRO_OUT);
+static IIO_DEV_ATTR_GYRO_Y(adis16350_read_14bit_signed,
+		ADIS16350_YGYRO_OUT);
+static IIO_DEV_ATTR_GYRO_Z(adis16350_read_14bit_signed,
+		ADIS16350_ZGYRO_OUT);
+static IIO_CONST_ATTR(gyro_scale, "0.05");
+
+static IIO_DEV_ATTR_ACCEL_X(adis16350_read_14bit_signed,
+		ADIS16350_XACCL_OUT);
+static IIO_DEV_ATTR_ACCEL_Y(adis16350_read_14bit_signed,
+		ADIS16350_YACCL_OUT);
+static IIO_DEV_ATTR_ACCEL_Z(adis16350_read_14bit_signed,
+		ADIS16350_ZACCL_OUT);
+static IIO_CONST_ATTR(accel_scale, "0.00333");
+
+static IIO_DEVICE_ATTR(temp_x_raw, S_IRUGO, adis16350_read_12bit_signed,
+		NULL, ADIS16350_XTEMP_OUT);
+static IIO_DEVICE_ATTR(temp_y_raw, S_IRUGO, adis16350_read_12bit_signed,
+		NULL, ADIS16350_YTEMP_OUT);
+static IIO_DEVICE_ATTR(temp_z_raw, S_IRUGO, adis16350_read_12bit_signed,
+		NULL, ADIS16350_ZTEMP_OUT);
+static IIO_CONST_ATTR(temp_scale, "0.0005");
+
+static IIO_DEV_ATTR_IN_RAW(0, adis16350_read_12bit_unsigned,
+		ADIS16350_AUX_ADC);
+static IIO_CONST_ATTR(in0_scale, "0.000806");
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+		adis16350_read_frequency,
+		adis16350_write_frequency);
+
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
+		adis16350_write_reset, 0);
+
+static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
+
+static IIO_CONST_ATTR(name, "adis16350");
+
+static struct attribute *adis16350_attributes[] = {
+	&iio_dev_attr_accel_x_offset.dev_attr.attr,
+	&iio_dev_attr_accel_y_offset.dev_attr.attr,
+	&iio_dev_attr_accel_z_offset.dev_attr.attr,
+	&iio_dev_attr_in_supply_raw.dev_attr.attr,
+	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
+	&iio_const_attr_gyro_scale.dev_attr.attr,
+	&iio_dev_attr_accel_x_raw.dev_attr.attr,
+	&iio_dev_attr_accel_y_raw.dev_attr.attr,
+	&iio_dev_attr_accel_z_raw.dev_attr.attr,
+	&iio_const_attr_accel_scale.dev_attr.attr,
+	&iio_dev_attr_temp_x_raw.dev_attr.attr,
+	&iio_dev_attr_temp_y_raw.dev_attr.attr,
+	&iio_dev_attr_temp_z_raw.dev_attr.attr,
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
+static const struct attribute_group adis16350_attribute_group = {
+	.attrs = adis16350_attributes,
+};
+
+static struct attribute *adis16350_event_attributes[] = {
+	NULL,
+};
+
+static struct attribute_group adis16350_event_attribute_group = {
+	.attrs = adis16350_event_attributes,
+};
+
+static int __devinit adis16350_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16350_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16350_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16350_MAX_TX, GFP_KERNEL);
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
+	st->indio_dev->event_attrs = &adis16350_event_attribute_group;
+	st->indio_dev->attrs = &adis16350_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16350_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = adis16350_initialize_ring(st->indio_dev->ring);
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
+				"adis16350");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = adis16350_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	/* Get the device into a sane initial state */
+	ret = adis16350_initial_setup(st);
+	if (ret)
+		goto error_remove_trigger;
+	return 0;
+
+error_remove_trigger:
+	adis16350_remove_trigger(st->indio_dev);
+error_unregister_line:
+	if (spi->irq)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	adis16350_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	adis16350_unconfigure_ring(st->indio_dev);
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
+static int adis16350_remove(struct spi_device *spi)
+{
+	int ret;
+	struct adis16350_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	ret = adis16350_stop_device(&(indio_dev->dev));
+	if (ret)
+		goto err_ret;
+
+	flush_scheduled_work();
+
+	adis16350_remove_trigger(indio_dev);
+	if (spi->irq)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	adis16350_uninitialize_ring(indio_dev->ring);
+	iio_device_unregister(indio_dev);
+	adis16350_unconfigure_ring(indio_dev);
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
+static const struct spi_device_id adis16350_id[] = {
+	{"adis16350", 0},
+	{"adis16354", 0},
+	{"adis16355", 0},
+	{"adis16360", 0},
+	{"adis16362", 0},
+	{"adis16364", 0},
+	{"adis16365", 0},
+	{}
+};
+
+static struct spi_driver adis16350_driver = {
+	.driver = {
+		.name = "adis16350",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16350_probe,
+	.remove = __devexit_p(adis16350_remove),
+	.id_table = adis16350_id,
+};
+
+static __init int adis16350_init(void)
+{
+	return spi_register_driver(&adis16350_driver);
+}
+module_init(adis16350_init);
+
+static __exit void adis16350_exit(void)
+{
+	spi_unregister_driver(&adis16350_driver);
+}
+module_exit(adis16350_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16350/54/55/60/62/64/65 IMU SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
new file mode 100644
index 0000000..5e9716e
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -0,0 +1,286 @@
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
+#include "adis16350.h"
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
+static IIO_SCAN_EL_C(supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12),
+		ADIS16350_SUPPLY_OUT, NULL);
+
+static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, IIO_SIGNED(14),
+		ADIS16350_XGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_y, ADIS16350_SCAN_GYRO_Y, IIO_SIGNED(14),
+		ADIS16350_YGYRO_OUT, NULL);
+static IIO_SCAN_EL_C(gyro_z, ADIS16350_SCAN_GYRO_Z, IIO_SIGNED(14),
+		ADIS16350_ZGYRO_OUT, NULL);
+
+static IIO_SCAN_EL_C(accel_x, ADIS16350_SCAN_ACC_X, IIO_SIGNED(14),
+		ADIS16350_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACC_Y, IIO_SIGNED(14),
+		ADIS16350_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACC_Z, IIO_SIGNED(14),
+		ADIS16350_ZACCL_OUT, NULL);
+
+static IIO_SCAN_EL_C(temp_x, ADIS16350_SCAN_TEMP_X, IIO_SIGNED(12),
+		ADIS16350_XTEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, IIO_SIGNED(12),
+		ADIS16350_YTEMP_OUT, NULL);
+static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, IIO_SIGNED(12),
+		ADIS16350_ZTEMP_OUT, NULL);
+
+static IIO_SCAN_EL_C(adc_0, ADIS16350_SCAN_ADC_0, IIO_UNSIGNED(12),
+		ADIS16350_AUX_ADC, NULL);
+
+static IIO_SCAN_EL_TIMESTAMP(11);
+
+static struct attribute *adis16350_scan_el_attrs[] = {
+	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_gyro_x.dev_attr.attr,
+	&iio_scan_el_gyro_y.dev_attr.attr,
+	&iio_scan_el_gyro_z.dev_attr.attr,
+	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_scan_el_temp_x.dev_attr.attr,
+	&iio_scan_el_temp_y.dev_attr.attr,
+	&iio_scan_el_temp_z.dev_attr.attr,
+	&iio_scan_el_adc_0.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group adis16350_scan_el_group = {
+	.attrs = adis16350_scan_el_attrs,
+	.name = "scan_elements",
+};
+
+/**
+ * adis16350_poll_func_th() top half interrupt handler called by trigger
+ * @private_data:	iio_dev
+ **/
+static void adis16350_poll_func_th(struct iio_dev *indio_dev)
+{
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	st->last_timestamp = indio_dev->trig->timestamp;
+	schedule_work(&st->work_trigger_to_ring);
+}
+
+/**
+ * adis16350_spi_read_burst() - read all data registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @rx: somewhere to pass back the value read (min size is 24 bytes)
+ **/
+static int adis16350_spi_read_burst(struct device *dev, u8 *rx)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
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
+			.len = 22,
+			.cs_change = 0,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16350_READ_REG(ADIS16350_GLOB_CMD);
+	st->tx[1] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+
+	st->us->max_speed_hz = ADIS16350_SPI_BURST;
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
+/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
+ * specific to be rolled into the core.
+ */
+static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct adis16350_state *st
+		= container_of(work_s, struct adis16350_state,
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
+		if (adis16350_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
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
+
+static int adis16350_data_rdy_ring_preenable(struct iio_dev *indio_dev)
+{
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
+		return -EINVAL;
+
+	if (indio_dev->ring->access.set_bpd) {
+		if (indio_dev->scan_timestamp)
+			if (indio_dev->scan_count)
+				/* Timestamp (aligned sizeof(s64) and data */
+				size = (((indio_dev->scan_count * sizeof(s16))
+						+ sizeof(s64) - 1)
+					& ~(sizeof(s64) - 1))
+					+ sizeof(s64);
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
+static int adis16350_data_rdy_ring_postenable(struct iio_dev *indio_dev)
+{
+	return indio_dev->trig
+		? iio_trigger_attach_poll_func(indio_dev->trig,
+					       indio_dev->pollfunc)
+		: 0;
+}
+
+static int adis16350_data_rdy_ring_predisable(struct iio_dev *indio_dev)
+{
+	return indio_dev->trig
+		? iio_trigger_dettach_poll_func(indio_dev->trig,
+						indio_dev->pollfunc)
+		: 0;
+}
+
+void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
+{
+	kfree(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
+
+int adis16350_configure_ring(struct iio_dev *indio_dev)
+{
+	int ret = 0;
+	struct adis16350_state *st = indio_dev->dev_data;
+	struct iio_ring_buffer *ring;
+	INIT_WORK(&st->work_trigger_to_ring, adis16350_trigger_bh_to_ring);
+	/* Set default scan mode */
+
+	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_x.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_y.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_z.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_temp_x.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_temp_y.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_temp_z.number);
+	iio_scan_mask_set(indio_dev, iio_scan_el_adc_0.number);
+	indio_dev->scan_timestamp = true;
+
+	indio_dev->scan_el_attrs = &adis16350_scan_el_group;
+
+	ring = iio_sw_rb_allocate(indio_dev);
+	if (!ring) {
+		ret = -ENOMEM;
+		return ret;
+	}
+	indio_dev->ring = ring;
+	/* Effectively select the ring buffer implementation */
+	iio_ring_sw_register_funcs(&ring->access);
+	ring->preenable = &adis16350_data_rdy_ring_preenable;
+	ring->postenable = &adis16350_data_rdy_ring_postenable;
+	ring->predisable = &adis16350_data_rdy_ring_predisable;
+	ring->owner = THIS_MODULE;
+
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_iio_sw_rb_free;;
+	}
+	indio_dev->pollfunc->poll_func_main = &adis16350_poll_func_th;
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	return 0;
+
+error_iio_sw_rb_free:
+	iio_sw_rb_free(indio_dev->ring);
+	return ret;
+}
+
+int adis16350_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return iio_ring_buffer_register(ring, 0);
+}
+
+void adis16350_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+	iio_ring_buffer_unregister(ring);
+}
diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/staging/iio/imu/adis16350_trigger.c
new file mode 100644
index 0000000..1ffa75d
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16350_trigger.c
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
+#include "adis16350.h"
+
+/**
+ * adis16350_data_rdy_trig_poll() the event handler for the data rdy trig
+ **/
+static int adis16350_data_rdy_trig_poll(struct iio_dev *dev_info,
+				       int index,
+				       s64 timestamp,
+				       int no_test)
+{
+	struct adis16350_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_trigger *trig = st->trig;
+
+	trig->timestamp = timestamp;
+	iio_trigger_poll(trig);
+
+	return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(data_rdy_trig, &adis16350_data_rdy_trig_poll);
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static struct attribute *adis16350_trigger_attrs[] = {
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group adis16350_trigger_attr_group = {
+	.attrs = adis16350_trigger_attrs,
+};
+
+/**
+ * adis16350_data_rdy_trigger_set_state() set datardy interrupt state
+ **/
+static int adis16350_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct adis16350_state *st = trig->private_data;
+	struct iio_dev *indio_dev = st->indio_dev;
+	int ret = 0;
+
+	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	ret = adis16350_set_irq(&st->indio_dev->dev, state);
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
+ * adis16350_trig_try_reen() try renabling irq for data rdy trigger
+ * @trig:	the datardy trigger
+ **/
+static int adis16350_trig_try_reen(struct iio_trigger *trig)
+{
+	struct adis16350_state *st = trig->private_data;
+	enable_irq(st->us->irq);
+	/* irq reenabled so success! */
+	return 0;
+}
+
+int adis16350_probe_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct adis16350_state *st = indio_dev->dev_data;
+
+	st->trig = iio_allocate_trigger();
+	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	if (!st->trig->name) {
+		ret = -ENOMEM;
+		goto error_free_trig;
+	}
+	snprintf((char *)st->trig->name,
+		 IIO_TRIGGER_NAME_LENGTH,
+		 "adis16350-dev%d", indio_dev->id);
+	st->trig->dev.parent = &st->us->dev;
+	st->trig->owner = THIS_MODULE;
+	st->trig->private_data = st;
+	st->trig->set_trigger_state = &adis16350_data_rdy_trigger_set_state;
+	st->trig->try_reenable = &adis16350_trig_try_reen;
+	st->trig->control_attrs = &adis16350_trigger_attr_group;
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
+void adis16350_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct adis16350_state *state = indio_dev->dev_data;
+
+	iio_trigger_unregister(state->trig);
+	kfree(state->trig->name);
+	iio_free_trigger(state->trig);
+}
-- 
1.7.0.4
