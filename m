Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1099 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3APMsJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:09 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/15] staging:iio:adis16400: Use adis library
Date: Wed, 16 Jan 2013 13:48:40 +0100
Message-Id: <1358340531-31350-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new adis library for the adis16400 driver. This allows us to completely
scrap the adis16400 trigger code and more than half of the core driver code. For
now we can not make use of the generic adis buffer implementation since the
adis16400 driver has special requirements due to its burst mode support. But
we will eventually get to this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/Kconfig             |   4 +-
 drivers/staging/iio/imu/Makefile            |   2 +-
 drivers/staging/iio/imu/adis16400.h         | 109 +++---
 drivers/staging/iio/imu/adis16400_core.c    | 535 ++++++++--------------------
 drivers/staging/iio/imu/adis16400_ring.c    |  59 +--
 drivers/staging/iio/imu/adis16400_trigger.c |  74 ----
 6 files changed, 225 insertions(+), 558 deletions(-)
 delete mode 100644 drivers/staging/iio/imu/adis16400_trigger.c

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 2c2f47d..096afc8 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -6,8 +6,8 @@ menu "Inertial measurement units"
 config ADIS16400
 	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
 	depends on SPI
-	select IIO_SW_RING if IIO_BUFFER
-	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16300, adis16344,
 	  adis16350, adis16354, adis16355, adis16360, adis16362, adis16364,
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index 3400a13..c9988f6 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -3,5 +3,5 @@
 #
 
 adis16400-y             := adis16400_core.o
-adis16400-$(CONFIG_IIO_BUFFER) += adis16400_ring.o adis16400_trigger.o
+adis16400-$(CONFIG_IIO_BUFFER) += adis16400_ring.o
 obj-$(CONFIG_ADIS16400) += adis16400.o
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 3efafcb..ce63ced 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -17,12 +17,11 @@
 #ifndef SPI_ADIS16400_H_
 #define SPI_ADIS16400_H_
 
+#include <linux/iio/imu/adis.h>
+
 #define ADIS16400_STARTUP_DELAY	290 /* ms */
 #define ADIS16400_MTEST_DELAY 90 /* ms */
 
-#define ADIS16400_READ_REG(a)    a
-#define ADIS16400_WRITE_REG(a) ((a) | 0x80)
-
 #define ADIS16400_FLASH_CNT  0x00 /* Flash memory write count */
 #define ADIS16400_SUPPLY_OUT 0x02 /* Power supply measurement */
 #define ADIS16400_XGYRO_OUT 0x04 /* X-axis gyroscope output */
@@ -96,21 +95,21 @@
 #define ADIS16400_SMPL_PRD_DIV_MASK	0x7F
 
 /* DIAG_STAT */
-#define ADIS16400_DIAG_STAT_ZACCL_FAIL	(1<<15)
-#define ADIS16400_DIAG_STAT_YACCL_FAIL	(1<<14)
-#define ADIS16400_DIAG_STAT_XACCL_FAIL	(1<<13)
-#define ADIS16400_DIAG_STAT_XGYRO_FAIL	(1<<12)
-#define ADIS16400_DIAG_STAT_YGYRO_FAIL	(1<<11)
-#define ADIS16400_DIAG_STAT_ZGYRO_FAIL	(1<<10)
-#define ADIS16400_DIAG_STAT_ALARM2	(1<<9)
-#define ADIS16400_DIAG_STAT_ALARM1	(1<<8)
-#define ADIS16400_DIAG_STAT_FLASH_CHK	(1<<6)
-#define ADIS16400_DIAG_STAT_SELF_TEST	(1<<5)
-#define ADIS16400_DIAG_STAT_OVERFLOW	(1<<4)
-#define ADIS16400_DIAG_STAT_SPI_FAIL	(1<<3)
-#define ADIS16400_DIAG_STAT_FLASH_UPT	(1<<2)
-#define ADIS16400_DIAG_STAT_POWER_HIGH	(1<<1)
-#define ADIS16400_DIAG_STAT_POWER_LOW	(1<<0)
+#define ADIS16400_DIAG_STAT_ZACCL_FAIL	15
+#define ADIS16400_DIAG_STAT_YACCL_FAIL	14
+#define ADIS16400_DIAG_STAT_XACCL_FAIL	13
+#define ADIS16400_DIAG_STAT_XGYRO_FAIL	12
+#define ADIS16400_DIAG_STAT_YGYRO_FAIL	11
+#define ADIS16400_DIAG_STAT_ZGYRO_FAIL	10
+#define ADIS16400_DIAG_STAT_ALARM2	9
+#define ADIS16400_DIAG_STAT_ALARM1	8
+#define ADIS16400_DIAG_STAT_FLASH_CHK	6
+#define ADIS16400_DIAG_STAT_SELF_TEST	5
+#define ADIS16400_DIAG_STAT_OVERFLOW	4
+#define ADIS16400_DIAG_STAT_SPI_FAIL	3
+#define ADIS16400_DIAG_STAT_FLASH_UPT	2
+#define ADIS16400_DIAG_STAT_POWER_HIGH	1
+#define ADIS16400_DIAG_STAT_POWER_LOW	0
 
 /* GLOB_CMD */
 #define ADIS16400_GLOB_CMD_SW_RESET	(1<<7)
@@ -126,9 +125,6 @@
 #define ADIS16334_RATE_DIV_SHIFT 8
 #define ADIS16334_RATE_INT_CLK BIT(0)
 
-#define ADIS16400_MAX_TX 24
-#define ADIS16400_MAX_RX 24
-
 #define ADIS16400_SPI_SLOW	(u32)(300 * 1000)
 #define ADIS16400_SPI_BURST	(u32)(1000 * 1000)
 #define ADIS16400_SPI_FAST	(u32)(2000 * 1000)
@@ -137,6 +133,8 @@
 #define ADIS16400_NO_BURST		BIT(1)
 #define ADIS16400_HAS_SLOW_MODE		BIT(2)
 
+struct adis16400_state;
+
 struct adis16400_chip_info {
 	const struct iio_chan_spec *channels;
 	const int num_channels;
@@ -145,58 +143,47 @@ struct adis16400_chip_info {
 	unsigned int accel_scale_micro;
 	int temp_scale_nano;
 	int temp_offset;
-	int (*set_freq)(struct iio_dev *indio_dev, unsigned int freq);
-	int (*get_freq)(struct iio_dev *indio_dev);
+	int (*set_freq)(struct adis16400_state *st, unsigned int freq);
+	int (*get_freq)(struct adis16400_state *st);
 };
 
 /**
  * struct adis16400_state - device instance specific data
- * @us:			actual spi_device
- * @trig:		data ready trigger registered with iio
- * @tx:			transmit buffer
- * @rx:			receive buffer
- * @buf_lock:		mutex to protect tx and rx
- * @filt_int:		integer part of requested filter frequency
+ * @variant:	chip variant info
+ * @filt_int:	integer part of requested filter frequency
+ * @adis:	adis device
  **/
 struct adis16400_state {
-	struct spi_device		*us;
-	struct iio_trigger		*trig;
-	struct mutex			buf_lock;
 	struct adis16400_chip_info	*variant;
 	int				filt_int;
 
-	u8	tx[ADIS16400_MAX_TX] ____cacheline_aligned;
-	u8	rx[ADIS16400_MAX_RX] ____cacheline_aligned;
+	struct adis adis;
 };
 
-int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
-
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
  */
 
-#define ADIS16400_SCAN_SUPPLY	0
-#define ADIS16400_SCAN_GYRO_X	1
-#define ADIS16400_SCAN_GYRO_Y	2
-#define ADIS16400_SCAN_GYRO_Z	3
-#define ADIS16400_SCAN_ACC_X	4
-#define ADIS16400_SCAN_ACC_Y	5
-#define ADIS16400_SCAN_ACC_Z	6
-#define ADIS16400_SCAN_MAGN_X	7
-#define ADIS16350_SCAN_TEMP_X	7
-#define ADIS16400_SCAN_MAGN_Y	8
-#define ADIS16350_SCAN_TEMP_Y	8
-#define ADIS16400_SCAN_MAGN_Z	9
-#define ADIS16350_SCAN_TEMP_Z	9
-#define ADIS16400_SCAN_TEMP	10
-#define ADIS16350_SCAN_ADC_0	10
-#define ADIS16400_SCAN_ADC_0	11
-#define ADIS16300_SCAN_INCLI_X	12
-#define ADIS16300_SCAN_INCLI_Y	13
+enum {
+	ADIS16400_SCAN_SUPPLY,
+	ADIS16400_SCAN_GYRO_X,
+	ADIS16400_SCAN_GYRO_Y,
+	ADIS16400_SCAN_GYRO_Z,
+	ADIS16400_SCAN_ACC_X,
+	ADIS16400_SCAN_ACC_Y,
+	ADIS16400_SCAN_ACC_Z,
+	ADIS16400_SCAN_MAGN_X,
+	ADIS16400_SCAN_MAGN_Y,
+	ADIS16400_SCAN_MAGN_Z,
+	ADIS16350_SCAN_TEMP_X,
+	ADIS16350_SCAN_TEMP_Y,
+	ADIS16350_SCAN_TEMP_Z,
+	ADIS16300_SCAN_INCLI_X,
+	ADIS16300_SCAN_INCLI_Y,
+	ADIS16400_SCAN_ADC,
+};
 
 #ifdef CONFIG_IIO_BUFFER
-void adis16400_remove_trigger(struct iio_dev *indio_dev);
-int adis16400_probe_trigger(struct iio_dev *indio_dev);
 
 ssize_t adis16400_read_data_from_ring(struct device *dev,
 				      struct device_attribute *attr,
@@ -208,15 +195,6 @@ void adis16400_unconfigure_ring(struct iio_dev *indio_dev);
 
 #else /* CONFIG_IIO_BUFFER */
 
-static inline void adis16400_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16400_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
 static inline ssize_t
 adis16400_read_data_from_ring(struct device *dev,
 			      struct device_attribute *attr,
@@ -235,4 +213,5 @@ static inline void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 }
 
 #endif /* CONFIG_IIO_BUFFER */
+
 #endif /* SPI_ADIS16400_H_ */
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 24fca10..a948472 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -29,6 +29,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+
 #include "adis16400.h"
 
 enum adis16400_chip_variant {
@@ -41,131 +42,12 @@ enum adis16400_chip_variant {
 	ADIS16400,
 };
 
-/**
- * adis16400_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @reg_address: the address of the register to be written
- * @val: the value to write
- */
-static int adis16400_spi_write_reg_8(struct iio_dev *indio_dev,
-				     u8 reg_address,
-				     u8 val)
-{
-	int ret;
-	struct adis16400_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_WRITE_REG(reg_address);
-	st->tx[1] = val;
-
-	ret = spi_write(st->us, st->tx, 2);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-/**
- * adis16400_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @reg_address: the address of the lower of the two registers. Second register
- *               is assumed to have address one greater.
- * @val: value to be written
- *
- * At the moment the spi framework doesn't allow global setting of cs_change.
- * This means that use cannot be made of spi_write.
- */
-static int adis16400_spi_write_reg_16(struct iio_dev *indio_dev,
-		u8 lower_reg_address,
-		u16 value)
-{
-	int ret;
-	struct spi_message msg;
-	struct adis16400_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		}, {
-			.tx_buf = st->tx + 2,
-			.bits_per_word = 8,
-			.len = 2,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_WRITE_REG(lower_reg_address);
-	st->tx[1] = value & 0xFF;
-	st->tx[2] = ADIS16400_WRITE_REG(lower_reg_address + 1);
-	st->tx[3] = (value >> 8) & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-/**
- * adis16400_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @indio_dev: iio device
- * @reg_address: the address of the lower of the two registers. Second register
- *               is assumed to have address one greater.
- * @val: somewhere to pass back the value read
- *
- * At the moment the spi framework doesn't allow global setting of cs_change.
- * This means that use cannot be made of spi_read.
- **/
-static int adis16400_spi_read_reg_16(struct iio_dev *indio_dev,
-		u8 lower_reg_address,
-		u16 *val)
-{
-	struct spi_message msg;
-	struct adis16400_state *st = iio_priv(indio_dev);
-	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_READ_REG(lower_reg_address);
-	st->tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
-		dev_err(&st->us->dev,
-			"problem when reading 16 bit register 0x%02X",
-			lower_reg_address);
-		goto error_ret;
-	}
-	*val = (st->rx[0] << 8) | st->rx[1];
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
-static int adis16334_get_freq(struct iio_dev *indio_dev)
+static int adis16334_get_freq(struct adis16400_state *st)
 {
 	int ret;
 	u16 t;
 
-	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_SMPL_PRD, &t);
+	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
 	if (ret < 0)
 		return ret;
 
@@ -174,7 +56,7 @@ static int adis16334_get_freq(struct iio_dev *indio_dev)
 	return (8192 >> t) / 10;
 }
 
-static int adis16334_set_freq(struct iio_dev *indio_dev, unsigned int freq)
+static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
 {
 	unsigned int t;
 
@@ -190,15 +72,15 @@ static int adis16334_set_freq(struct iio_dev *indio_dev, unsigned int freq)
 	t <<= ADIS16334_RATE_DIV_SHIFT;
 	t |= ADIS16334_RATE_INT_CLK;
 
-	return adis16400_spi_write_reg_16(indio_dev, ADIS16400_SMPL_PRD, t);
+	return adis_write_reg_16(&st->adis, ADIS16400_SMPL_PRD, t);
 }
 
-static int adis16400_get_freq(struct iio_dev *indio_dev)
+static int adis16400_get_freq(struct adis16400_state *st)
 {
 	int sps, ret;
 	u16 t;
 
-	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_SMPL_PRD, &t);
+	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
 	if (ret < 0)
 		return ret;
 	sps =  (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
@@ -207,9 +89,8 @@ static int adis16400_get_freq(struct iio_dev *indio_dev)
 	return sps;
 }
 
-static int adis16400_set_freq(struct iio_dev *indio_dev, unsigned int freq)
+static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
 {
-	struct adis16400_state *st = iio_priv(indio_dev);
 	unsigned int t;
 
 	t = 1638 / freq;
@@ -217,12 +98,11 @@ static int adis16400_set_freq(struct iio_dev *indio_dev, unsigned int freq)
 		t--;
 	t &= ADIS16400_SMPL_PRD_DIV_MASK;
 	if ((t & ADIS16400_SMPL_PRD_DIV_MASK) >= 0x0A)
-		st->us->max_speed_hz = ADIS16400_SPI_SLOW;
+		st->adis.spi->max_speed_hz = ADIS16400_SPI_SLOW;
 	else
-		st->us->max_speed_hz = ADIS16400_SPI_FAST;
+		st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
 
-	return adis16400_spi_write_reg_8(indio_dev,
-			ADIS16400_SMPL_PRD, t);
+	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, t);
 }
 
 static ssize_t adis16400_read_frequency(struct device *dev,
@@ -233,7 +113,7 @@ static ssize_t adis16400_read_frequency(struct device *dev,
 	struct adis16400_state *st = iio_priv(indio_dev);
 	int ret, len = 0;
 
-	ret = st->variant->get_freq(indio_dev);
+	ret = st->variant->get_freq(st);
 	if (ret < 0)
 		return ret;
 	len = sprintf(buf, "%d SPS\n", ret);
@@ -253,6 +133,7 @@ static const unsigned adis16400_3db_divisors[] = {
 
 static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 {
+	struct adis16400_state *st = iio_priv(indio_dev);
 	int i, ret;
 	u16 val16;
 
@@ -261,12 +142,11 @@ static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 			break;
 	}
 
-	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_SENS_AVG,
-						&val16);
+	ret = adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
 	if (ret < 0)
 		return ret;
 
-	ret = adis16400_spi_write_reg_16(indio_dev, ADIS16400_SENS_AVG,
+	ret = adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
 					 (val16 & ~0x07) | i);
 	return ret;
 }
@@ -289,7 +169,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 
 	mutex_lock(&indio_dev->mlock);
 
-	st->variant->set_freq(indio_dev, val);
+	st->variant->set_freq(st, val);
 
 	/* Also update the filter */
 	mutex_unlock(&indio_dev->mlock);
@@ -297,48 +177,14 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
-static int adis16400_reset(struct iio_dev *indio_dev)
-{
-	int ret;
-	ret = adis16400_spi_write_reg_8(indio_dev,
-			ADIS16400_GLOB_CMD,
-			ADIS16400_GLOB_CMD_SW_RESET);
-	if (ret)
-		dev_err(&indio_dev->dev, "problem resetting device");
-
-	return ret;
-}
-
-int adis16400_set_irq(struct iio_dev *indio_dev, bool enable)
-{
-	int ret;
-	u16 msc;
-
-	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_MSC_CTRL, &msc);
-	if (ret)
-		goto error_ret;
-
-	msc |= ADIS16400_MSC_CTRL_DATA_RDY_POL_HIGH;
-	if (enable)
-		msc |= ADIS16400_MSC_CTRL_DATA_RDY_EN;
-	else
-		msc &= ~ADIS16400_MSC_CTRL_DATA_RDY_EN;
-
-	ret = adis16400_spi_write_reg_16(indio_dev, ADIS16400_MSC_CTRL, msc);
-	if (ret)
-		goto error_ret;
-
-error_ret:
-	return ret;
-}
-
 /* Power down the device */
 static int adis16400_stop_device(struct iio_dev *indio_dev)
 {
+	struct adis16400_state *st = iio_priv(indio_dev);
 	int ret;
 	u16 val = ADIS16400_SLP_CNT_POWER_OFF;
 
-	ret = adis16400_spi_write_reg_16(indio_dev, ADIS16400_SLP_CNT, val);
+	ret = adis_write_reg_16(&st->adis, ADIS16400_SLP_CNT, val);
 	if (ret)
 		dev_err(&indio_dev->dev,
 			"problem with turning device off: SLP_CNT");
@@ -346,73 +192,6 @@ static int adis16400_stop_device(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int adis16400_check_status(struct iio_dev *indio_dev)
-{
-	u16 status;
-	int ret;
-	struct device *dev = &indio_dev->dev;
-
-	ret = adis16400_spi_read_reg_16(indio_dev,
-					ADIS16400_DIAG_STAT, &status);
-
-	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
-		goto error_ret;
-	}
-	ret = status;
-	if (status & ADIS16400_DIAG_STAT_ZACCL_FAIL)
-		dev_err(dev, "Z-axis accelerometer self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_YACCL_FAIL)
-		dev_err(dev, "Y-axis accelerometer self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_XACCL_FAIL)
-		dev_err(dev, "X-axis accelerometer self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_XGYRO_FAIL)
-		dev_err(dev, "X-axis gyroscope self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_YGYRO_FAIL)
-		dev_err(dev, "Y-axis gyroscope self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_ZGYRO_FAIL)
-		dev_err(dev, "Z-axis gyroscope self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_ALARM2)
-		dev_err(dev, "Alarm 2 active\n");
-	if (status & ADIS16400_DIAG_STAT_ALARM1)
-		dev_err(dev, "Alarm 1 active\n");
-	if (status & ADIS16400_DIAG_STAT_FLASH_CHK)
-		dev_err(dev, "Flash checksum error\n");
-	if (status & ADIS16400_DIAG_STAT_SELF_TEST)
-		dev_err(dev, "Self test error\n");
-	if (status & ADIS16400_DIAG_STAT_OVERFLOW)
-		dev_err(dev, "Sensor overrange\n");
-	if (status & ADIS16400_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
-	if (status & ADIS16400_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
-	if (status & ADIS16400_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 5.25V\n");
-	if (status & ADIS16400_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 4.75V\n");
-
-error_ret:
-	return ret;
-}
-
-static int adis16400_self_test(struct iio_dev *indio_dev)
-{
-	int ret;
-	ret = adis16400_spi_write_reg_16(indio_dev,
-			ADIS16400_MSC_CTRL,
-			ADIS16400_MSC_CTRL_MEM_TEST);
-	if (ret) {
-		dev_err(&indio_dev->dev, "problem starting self test");
-		goto err_ret;
-	}
-
-	msleep(ADIS16400_MTEST_DELAY);
-	adis16400_check_status(indio_dev);
-
-err_ret:
-	return ret;
-}
-
 static int adis16400_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -422,37 +201,18 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 
 	/* use low spi speed for init if the device has a slow mode */
 	if (st->variant->flags & ADIS16400_HAS_SLOW_MODE)
-		st->us->max_speed_hz = ADIS16400_SPI_SLOW;
+		st->adis.spi->max_speed_hz = ADIS16400_SPI_SLOW;
 	else
-		st->us->max_speed_hz = ADIS16400_SPI_FAST;
-	st->us->mode = SPI_MODE_3;
-	spi_setup(st->us);
-
-	ret = adis16400_set_irq(indio_dev, false);
-	if (ret) {
-		dev_err(&indio_dev->dev, "disable irq failed");
-		goto err_ret;
-	}
+		st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
+	st->adis.spi->mode = SPI_MODE_3;
+	spi_setup(st->adis.spi);
 
-	ret = adis16400_self_test(indio_dev);
-	if (ret) {
-		dev_err(&indio_dev->dev, "self test failure");
-		goto err_ret;
-	}
+	ret = adis_initial_startup(&st->adis);
+	if (ret)
+		return ret;
 
-	ret = adis16400_check_status(indio_dev);
-	if (ret) {
-		adis16400_reset(indio_dev);
-		dev_err(&indio_dev->dev, "device not playing ball -> reset");
-		msleep(ADIS16400_STARTUP_DELAY);
-		ret = adis16400_check_status(indio_dev);
-		if (ret) {
-			dev_err(&indio_dev->dev, "giving up");
-			goto err_ret;
-		}
-	}
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID) {
-		ret = adis16400_spi_read_reg_16(indio_dev,
+		ret = adis_read_reg_16(&st->adis,
 						ADIS16400_PRODUCT_ID, &prod_id);
 		if (ret)
 			goto err_ret;
@@ -465,18 +225,17 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 
 		dev_info(&indio_dev->dev, "%s: prod_id 0x%04x at CS%d (irq %d)\n",
 		       indio_dev->name, prod_id,
-		       st->us->chip_select, st->us->irq);
+		       st->adis.spi->chip_select, st->adis.spi->irq);
 	}
 	/* use high spi speed if possible */
 	if (st->variant->flags & ADIS16400_HAS_SLOW_MODE) {
-		ret = adis16400_spi_read_reg_16(indio_dev,
-						ADIS16400_SMPL_PRD, &smp_prd);
+		ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &smp_prd);
 		if (ret)
 			goto err_ret;
 
 		if ((smp_prd & ADIS16400_SMPL_PRD_DIV_MASK) < 0x0A) {
-			st->us->max_speed_hz = ADIS16400_SPI_FAST;
-			spi_setup(st->us);
+			st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
+			spi_setup(st->adis.spi);
 		}
 	}
 
@@ -490,47 +249,15 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
-enum adis16400_chan {
-	in_supply,
-	gyro_x,
-	gyro_y,
-	gyro_z,
-	accel_x,
-	accel_y,
-	accel_z,
-	magn_x,
-	magn_y,
-	magn_z,
-	temp,
-	temp0, temp1, temp2,
-	in1,
-	in2,
-	incli_x,
-	incli_y,
-};
-
-static u8 adis16400_addresses[18][2] = {
-	[in_supply] = { ADIS16400_SUPPLY_OUT },
-	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
-	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
-	[gyro_z] = { ADIS16400_ZGYRO_OUT, ADIS16400_ZGYRO_OFF },
-	[accel_x] = { ADIS16400_XACCL_OUT, ADIS16400_XACCL_OFF },
-	[accel_y] = { ADIS16400_YACCL_OUT, ADIS16400_YACCL_OFF },
-	[accel_z] = { ADIS16400_ZACCL_OUT, ADIS16400_ZACCL_OFF },
-	[magn_x] = { ADIS16400_XMAGN_OUT },
-	[magn_y] = { ADIS16400_YMAGN_OUT },
-	[magn_z] = { ADIS16400_ZMAGN_OUT },
-	[temp] = { ADIS16400_TEMP_OUT },
-	[temp0] = { ADIS16350_XTEMP_OUT },
-	[temp1] = { ADIS16350_YTEMP_OUT },
-	[temp2] = { ADIS16350_ZTEMP_OUT },
-	[in1] = { ADIS16300_AUX_ADC },
-	[in2] = { ADIS16400_AUX_ADC },
-	[incli_x] = { ADIS16300_PITCH_OUT },
-	[incli_y] = { ADIS16300_ROLL_OUT }
+static const u8 adis16400_addresses[] = {
+	[ADIS16400_SCAN_GYRO_X] = ADIS16400_XGYRO_OFF,
+	[ADIS16400_SCAN_GYRO_Y] = ADIS16400_YGYRO_OFF,
+	[ADIS16400_SCAN_GYRO_Z] = ADIS16400_ZGYRO_OFF,
+	[ADIS16400_SCAN_ACC_X] = ADIS16400_XACCL_OFF,
+	[ADIS16400_SCAN_ACC_Y] = ADIS16400_YACCL_OFF,
+	[ADIS16400_SCAN_ACC_Z] = ADIS16400_ZACCL_OFF,
 };
 
-
 static int adis16400_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
@@ -543,9 +270,8 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&indio_dev->mlock);
-		ret = adis16400_spi_write_reg_16(indio_dev,
-				adis16400_addresses[chan->address][1],
-				val);
+		ret = adis_write_reg_16(&st->adis,
+				adis16400_addresses[chan->scan_index], val);
 		mutex_unlock(&indio_dev->mlock);
 		return ret;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -554,7 +280,7 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		st->filt_int = val;
 		/* Work out update to current value */
-		sps = st->variant->get_freq(indio_dev);
+		sps = st->variant->get_freq(st);
 		if (sps < 0) {
 			mutex_unlock(&indio_dev->mlock);
 			return sps;
@@ -575,27 +301,12 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	int ret, shift;
+	int ret;
 	s16 val16;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-		ret = adis16400_spi_read_reg_16(indio_dev,
-				adis16400_addresses[chan->address][0],
-				&val16);
-		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
-			return ret;
-		}
-		val16 &= (1 << chan->scan_type.realbits) - 1;
-		if (chan->scan_type.sign == 's') {
-			shift = 16 - chan->scan_type.realbits;
-			val16 = (s16)(val16 << shift) >> shift;
-		}
-		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
-		return IIO_VAL_INT;
+		return adis_single_conversion(indio_dev, chan, 0, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -629,9 +340,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&indio_dev->mlock);
-		ret = adis16400_spi_read_reg_16(indio_dev,
-				adis16400_addresses[chan->address][1],
-				&val16);
+		ret = adis_read_reg_16(&st->adis,
+				adis16400_addresses[chan->scan_index], &val16);
 		mutex_unlock(&indio_dev->mlock);
 		if (ret)
 			return ret;
@@ -645,14 +355,14 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		mutex_lock(&indio_dev->mlock);
 		/* Need both the number of taps and the sampling frequency */
-		ret = adis16400_spi_read_reg_16(indio_dev,
+		ret = adis_read_reg_16(&st->adis,
 						ADIS16400_SENS_AVG,
 						&val16);
 		if (ret < 0) {
 			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
-		ret = st->variant->get_freq(indio_dev);
+		ret = st->variant->get_freq(st);
 		if (ret >= 0)
 			*val = ret / adis16400_3db_divisors[val16 & 0x07];
 		*val2 = 0;
@@ -673,7 +383,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		.extend_name = "supply",
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in_supply,
+		.address = ADIS16400_SUPPLY_OUT,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 14, 16, 0),
 	}, {
@@ -684,7 +394,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_x,
+		.address = ADIS16400_XGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -695,7 +405,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_y,
+		.address = ADIS16400_YGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -706,7 +416,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_z,
+		.address = ADIS16400_ZGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -717,7 +427,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_x,
+		.address = ADIS16400_XACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -728,7 +438,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_y,
+		.address = ADIS16400_YACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -739,7 +449,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_z,
+		.address = ADIS16400_ZACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -749,7 +459,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = magn_x,
+		.address = ADIS16400_XMAGN_OUT,
 		.scan_index = ADIS16400_SCAN_MAGN_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -759,7 +469,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = magn_y,
+		.address = ADIS16400_YMAGN_OUT,
 		.scan_index = ADIS16400_SCAN_MAGN_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -769,7 +479,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = magn_z,
+		.address = ADIS16400_ZMAGN_OUT,
 		.scan_index = ADIS16400_SCAN_MAGN_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -779,8 +489,8 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = temp,
-		.scan_index = ADIS16400_SCAN_TEMP,
+		.address = ADIS16400_TEMP_OUT,
+		.scan_index = ADIS16350_SCAN_TEMP_X,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
 		.type = IIO_VOLTAGE,
@@ -788,8 +498,8 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		.channel = 1,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in2,
-		.scan_index = ADIS16400_SCAN_ADC_0,
+		.address = ADIS16400_AUX_ADC,
+		.scan_index = ADIS16400_SCAN_ADC,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(12)
@@ -803,7 +513,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		.extend_name = "supply",
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in_supply,
+		.address = ADIS16400_SUPPLY_OUT,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 12, 16, 0),
 	}, {
@@ -814,7 +524,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_x,
+		.address = ADIS16400_XGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -825,7 +535,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_y,
+		.address = ADIS16400_YGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -836,7 +546,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_z,
+		.address = ADIS16400_ZGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -847,7 +557,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_x,
+		.address = ADIS16400_XACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -858,7 +568,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_y,
+		.address = ADIS16400_YACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -869,7 +579,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_z,
+		.address = ADIS16400_ZACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -881,7 +591,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = temp0,
+		.address = ADIS16350_XTEMP_OUT,
 		.scan_index = ADIS16350_SCAN_TEMP_X,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
@@ -893,7 +603,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = temp1,
+		.address = ADIS16350_YTEMP_OUT,
 		.scan_index = ADIS16350_SCAN_TEMP_Y,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
@@ -904,7 +614,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = temp2,
+		.address = ADIS16350_ZTEMP_OUT,
 		.scan_index = ADIS16350_SCAN_TEMP_Z,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
@@ -913,8 +623,8 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		.channel = 1,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in1,
-		.scan_index = ADIS16350_SCAN_ADC_0,
+		.address = ADIS16300_AUX_ADC,
+		.scan_index = ADIS16400_SCAN_ADC,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(11)
@@ -928,7 +638,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		.extend_name = "supply",
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in_supply,
+		.address = ADIS16400_SUPPLY_OUT,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 12, 16, 0),
 	}, {
@@ -939,7 +649,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_x,
+		.address = ADIS16400_XGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -950,7 +660,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_x,
+		.address = ADIS16400_XACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -961,7 +671,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_y,
+		.address = ADIS16400_YACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -972,7 +682,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_z,
+		.address = ADIS16400_ZACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -982,8 +692,8 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = temp0,
-		.scan_index = ADIS16400_SCAN_TEMP,
+		.address = ADIS16350_XTEMP_OUT,
+		.scan_index = ADIS16350_SCAN_TEMP_X,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
 		.type = IIO_VOLTAGE,
@@ -991,8 +701,8 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		.channel = 1,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in1,
-		.scan_index = ADIS16350_SCAN_ADC_0,
+		.address = ADIS16300_AUX_ADC,
+		.scan_index = ADIS16400_SCAN_ADC,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
 		.type = IIO_INCLI,
@@ -1000,7 +710,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = incli_x,
+		.address = ADIS16300_PITCH_OUT,
 		.scan_index = ADIS16300_SCAN_INCLI_X,
 		.scan_type = IIO_ST('s', 13, 16, 0),
 	}, {
@@ -1009,7 +719,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = incli_y,
+		.address = ADIS16300_ROLL_OUT,
 		.scan_index = ADIS16300_SCAN_INCLI_Y,
 		.scan_type = IIO_ST('s', 13, 16, 0),
 	},
@@ -1025,7 +735,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_x,
+		.address = ADIS16400_XGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -1036,7 +746,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_y,
+		.address = ADIS16400_YGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -1047,7 +757,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = gyro_z,
+		.address = ADIS16400_ZGYRO_OUT,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -1058,7 +768,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_x,
+		.address = ADIS16400_XACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -1069,7 +779,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_y,
+		.address = ADIS16400_YACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -1080,7 +790,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
-		.address = accel_z,
+		.address = ADIS16400_ZACCL_OUT,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
@@ -1090,8 +800,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = temp0,
-		.scan_index = ADIS16400_SCAN_TEMP,
+		.address = ADIS16350_XTEMP_OUT,
+		.scan_index = ADIS16350_SCAN_TEMP_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(12)
@@ -1194,6 +904,53 @@ static const struct iio_info adis16400_info = {
 	.attrs = &adis16400_attribute_group,
 };
 
+static const char * const adis16400_status_error_msgs[] = {
+	[ADIS16400_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
+	[ADIS16400_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
+	[ADIS16400_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
+	[ADIS16400_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
+	[ADIS16400_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
+	[ADIS16400_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
+	[ADIS16400_DIAG_STAT_ALARM2] = "Alarm 2 active",
+	[ADIS16400_DIAG_STAT_ALARM1] = "Alarm 1 active",
+	[ADIS16400_DIAG_STAT_FLASH_CHK] = "Flash checksum error",
+	[ADIS16400_DIAG_STAT_SELF_TEST] = "Self test error",
+	[ADIS16400_DIAG_STAT_OVERFLOW] = "Sensor overrange",
+	[ADIS16400_DIAG_STAT_SPI_FAIL] = "SPI failure",
+	[ADIS16400_DIAG_STAT_FLASH_UPT] = "Flash update failed",
+	[ADIS16400_DIAG_STAT_POWER_HIGH] = "Power supply above 5.25V",
+	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
+};
+
+static const struct adis_data adis16400_data = {
+	.msc_ctrl_reg = ADIS16400_MSC_CTRL,
+	.glob_cmd_reg = ADIS16400_GLOB_CMD,
+	.diag_stat_reg = ADIS16400_DIAG_STAT,
+
+	.read_delay = 50,
+	.write_delay = 50,
+
+	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,
+	.startup_delay = ADIS16400_STARTUP_DELAY,
+
+	.status_error_msgs = adis16400_status_error_msgs,
+	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_ALARM2) |
+		BIT(ADIS16400_DIAG_STAT_ALARM1) |
+		BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |
+		BIT(ADIS16400_DIAG_STAT_SELF_TEST) |
+		BIT(ADIS16400_DIAG_STAT_OVERFLOW) |
+		BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |
+		BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |
+		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |
+		BIT(ADIS16400_DIAG_STAT_POWER_LOW),
+};
+
 static int adis16400_probe(struct spi_device *spi)
 {
 	int ret;
@@ -1207,9 +964,6 @@ static int adis16400_probe(struct spi_device *spi)
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
-	st->us = spi;
-	mutex_init(&st->buf_lock);
-
 	/* setup the industrialio driver allocated elements */
 	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
 	indio_dev->dev.parent = &spi->dev;
@@ -1219,6 +973,10 @@ static int adis16400_probe(struct spi_device *spi)
 	indio_dev->info = &adis16400_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
+	if (ret)
+		goto error_free_dev;
+
 	ret = adis16400_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
@@ -1232,7 +990,7 @@ static int adis16400_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16400_probe_trigger(indio_dev);
+		ret = adis_probe_trigger(&st->adis, indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
@@ -1249,7 +1007,7 @@ static int adis16400_probe(struct spi_device *spi)
 
 error_remove_trigger:
 	if (spi->irq)
-		adis16400_remove_trigger(indio_dev);
+		adis_remove_trigger(&st->adis);
 error_uninitialize_ring:
 	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
@@ -1264,13 +1022,16 @@ error_ret:
 static int adis16400_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev =  spi_get_drvdata(spi);
+	struct adis16400_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	adis16400_stop_device(indio_dev);
 
-	adis16400_remove_trigger(indio_dev);
+	if (spi->irq)
+		adis_remove_trigger(&st->adis);
 	iio_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
+
 	iio_device_free(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index d46c1e3..6c5b0be 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -9,6 +9,7 @@
 #include <linux/iio/iio.h>
 #include "../ring_sw.h"
 #include <linux/iio/trigger_consumer.h>
+
 #include "adis16400.h"
 
 /**
@@ -20,12 +21,12 @@ static int adis16400_spi_read_burst(struct iio_dev *indio_dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct adis16400_state *st = iio_priv(indio_dev);
-	u32 old_speed_hz = st->us->max_speed_hz;
+	u32 old_speed_hz = st->adis.spi->max_speed_hz;
 	int ret;
 
 	struct spi_transfer xfers[] = {
 		{
-			.tx_buf = st->tx,
+			.tx_buf = st->adis.tx,
 			.bits_per_word = 8,
 			.len = 2,
 		}, {
@@ -35,39 +36,39 @@ static int adis16400_spi_read_burst(struct iio_dev *indio_dev, u8 *rx)
 		},
 	};
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_READ_REG(ADIS16400_GLOB_CMD);
-	st->tx[1] = 0;
+	mutex_lock(&st->adis.txrx_lock);
+	st->adis.tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
+	st->adis.tx[1] = 0;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
 
-	st->us->max_speed_hz = min(ADIS16400_SPI_BURST, old_speed_hz);
-	spi_setup(st->us);
+	st->adis.spi->max_speed_hz = min(ADIS16400_SPI_BURST, old_speed_hz);
+	spi_setup(st->adis.spi);
 
-	ret = spi_sync(st->us, &msg);
+	ret = spi_sync(st->adis.spi, &msg);
 	if (ret)
-		dev_err(&st->us->dev, "problem when burst reading");
+		dev_err(&st->adis.spi->dev, "problem when burst reading");
 
-	st->us->max_speed_hz = old_speed_hz;
-	spi_setup(st->us);
-	mutex_unlock(&st->buf_lock);
+	st->adis.spi->max_speed_hz = old_speed_hz;
+	spi_setup(st->adis.spi);
+	mutex_unlock(&st->adis.txrx_lock);
 	return ret;
 }
 
 static const u16 read_all_tx_array[] = {
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_SUPPLY_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_XGYRO_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_YGYRO_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_ZGYRO_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_XACCL_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_YACCL_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_ZACCL_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16350_XTEMP_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16350_YTEMP_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16350_ZTEMP_OUT)),
-	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_AUX_ADC)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_SUPPLY_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_XGYRO_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_YGYRO_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_ZGYRO_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_XACCL_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_YACCL_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_ZACCL_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16350_XTEMP_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16350_YTEMP_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16350_ZTEMP_OUT)),
+	cpu_to_be16(ADIS_READ_REG(ADIS16400_AUX_ADC)),
 };
 
 static int adis16350_spi_read_all(struct iio_dev *indio_dev, u8 *rx)
@@ -100,7 +101,7 @@ static int adis16350_spi_read_all(struct iio_dev *indio_dev, u8 *rx)
 	for (j = 0; j < scan_count + 1; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
-	ret = spi_sync(st->us, &msg);
+	ret = spi_sync(st->adis.spi, &msg);
 	kfree(xfers);
 
 	return ret;
@@ -123,26 +124,26 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 				       indio_dev->masklength);
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
+		dev_err(&st->adis.spi->dev, "memory alloc failed in ring bh");
 		goto done;
 	}
 
 	if (scan_count) {
 		if (st->variant->flags & ADIS16400_NO_BURST) {
-			ret = adis16350_spi_read_all(indio_dev, st->rx);
+			ret = adis16350_spi_read_all(indio_dev, st->adis.rx);
 			if (ret < 0)
 				goto done;
 			for (; i < scan_count; i++)
-				data[i]	= *(s16 *)(st->rx + i*2);
+				data[i]	= *(s16 *)(st->adis.rx + i*2);
 		} else {
-			ret = adis16400_spi_read_burst(indio_dev, st->rx);
+			ret = adis16400_spi_read_burst(indio_dev, st->adis.rx);
 			if (ret < 0)
 				goto done;
 			for (; i < scan_count; i++) {
 				j = __ffs(mask);
 				mask &= ~(1 << j);
 				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[j*2]));
+					(__be16 *)&(st->adis.rx[j*2]));
 			}
 		}
 	}
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
deleted file mode 100644
index 42a678e..0000000
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ /dev/null
@@ -1,74 +0,0 @@
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/export.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-#include "adis16400.h"
-
-/**
- * adis16400_data_rdy_trigger_set_state() set datardy interrupt state
- **/
-static int adis16400_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
-{
-	struct iio_dev *indio_dev = trig->private_data;
-
-	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16400_set_irq(indio_dev, state);
-}
-
-static const struct iio_trigger_ops adis16400_trigger_ops = {
-	.owner = THIS_MODULE,
-	.set_trigger_state = &adis16400_data_rdy_trigger_set_state,
-};
-
-int adis16400_probe_trigger(struct iio_dev *indio_dev)
-{
-	int ret;
-	struct adis16400_state *st = iio_priv(indio_dev);
-
-	st->trig = iio_trigger_alloc("%s-dev%d",
-					indio_dev->name,
-					indio_dev->id);
-	if (st->trig == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	ret = request_irq(st->us->irq,
-			  &iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_RISING,
-			  "adis16400",
-			  st->trig);
-	if (ret)
-		goto error_free_trig;
-	st->trig->dev.parent = &st->us->dev;
-	st->trig->private_data = indio_dev;
-	st->trig->ops = &adis16400_trigger_ops;
-	ret = iio_trigger_register(st->trig);
-
-	/* select default trigger */
-	indio_dev->trig = st->trig;
-	if (ret)
-		goto error_free_irq;
-
-	return 0;
-
-error_free_irq:
-	free_irq(st->us->irq, st->trig);
-error_free_trig:
-	iio_trigger_free(st->trig);
-error_ret:
-	return ret;
-}
-
-void adis16400_remove_trigger(struct iio_dev *indio_dev)
-{
-	struct adis16400_state *st = iio_priv(indio_dev);
-
-	iio_trigger_unregister(st->trig);
-	free_irq(st->us->irq, st->trig);
-	iio_trigger_free(st->trig);
-}
-- 
1.8.0

