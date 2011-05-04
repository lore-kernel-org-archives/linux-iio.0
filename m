Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 56/99] staging:iio:accel:adis16201 move to chan_spec based setup.
Date: Wed,  4 May 2011 12:58:28 +0100
Message-Id: <1304510351-10922-57-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Mainly motivated by wish to remove the remaing users of the
scan helpers.

Some minor cleanups done whilst here.

Untested.

V2: IIO_CHAN macro used.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201.h         |    4 +-
 drivers/staging/iio/accel/adis16201_core.c    |  454 +++++++++++--------------
 drivers/staging/iio/accel/adis16201_ring.c    |   87 +----
 drivers/staging/iio/accel/adis16201_trigger.c |    3 +-
 4 files changed, 220 insertions(+), 328 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.h b/drivers/staging/iio/accel/adis16201.h
index 6296a4f..0b9b854 100644
--- a/drivers/staging/iio/accel/adis16201.h
+++ b/drivers/staging/iio/accel/adis16201.h
@@ -79,7 +79,7 @@ struct adis16201_state {
 	struct mutex			buf_lock;
 };
 
-int adis16201_set_irq(struct device *dev, bool enable);
+int adis16201_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 enum adis16201_scan {
@@ -102,8 +102,6 @@ ssize_t adis16201_read_data_from_ring(struct device *dev,
 int adis16201_configure_ring(struct iio_dev *indio_dev);
 void adis16201_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16201_initialize_ring(struct iio_ring_buffer *ring);
-void adis16201_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16201_remove_trigger(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index f45eb8f..59b6ac2 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -6,9 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -16,20 +13,28 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
+
 #include "accel.h"
 #include "inclinometer.h"
-#include "../gyro/gyro.h"
 #include "../adc/adc.h"
 
 #include "adis16201.h"
 
 #define DRIVER_NAME		"adis16201"
 
-static int adis16201_check_status(struct device *dev);
+enum adis16201_chan {
+	in_supply,
+	temp,
+	accel_x,
+	accel_y,
+	incli_x,
+	incli_y,
+	in_aux,
+};
 
 /**
  * adis16201_spi_write_reg_8() - write single byte to a register
@@ -57,18 +62,17 @@ static int adis16201_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16201_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16201_spi_write_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 value)
+static int adis16201_spi_write_reg_16(struct iio_dev *indio_dev,
+				      u8 lower_reg_address,
+				      u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -80,7 +84,6 @@ static int adis16201_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		},
 	};
 
@@ -101,17 +104,16 @@ static int adis16201_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16201_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16201_spi_read_reg_16(struct device *dev,
+static int adis16201_spi_read_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -125,7 +127,6 @@ static int adis16201_spi_read_reg_16(struct device *dev,
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 20,
 		},
 	};
@@ -150,160 +151,6 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16201_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16201_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16201_ERROR_ACTIVE) {
-		ret = adis16201_check_status(dev);
-		if (ret)
-			return ret;
-	}
-
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16201_read_temp(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-	u16 val;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-
-	ret = adis16201_spi_read_reg_16(dev, ADIS16201_TEMP_OUT, (u16 *)&val);
-	if (ret)
-		goto error_ret;
-
-	if (val & ADIS16201_ERROR_ACTIVE) {
-		ret = adis16201_check_status(dev);
-		if (ret)
-			goto error_ret;
-	}
-
-	val &= 0xFFF;
-	ret = sprintf(buf, "%d\n", val);
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static ssize_t adis16201_read_9bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	s16 val = 0;
-	ssize_t ret;
-
-	mutex_lock(&indio_dev->mlock);
-
-	ret = adis16201_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (!ret) {
-		if (val & ADIS16201_ERROR_ACTIVE) {
-			ret = adis16201_check_status(dev);
-			if (ret)
-				goto error_ret;
-		}
-		val = ((s16)(val << 7) >> 7);
-		ret = sprintf(buf, "%d\n", val);
-	}
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16201_read_12bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	s16 val = 0;
-	ssize_t ret;
-
-	mutex_lock(&indio_dev->mlock);
-
-	ret = adis16201_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (!ret) {
-		if (val & ADIS16201_ERROR_ACTIVE) {
-			ret = adis16201_check_status(dev);
-			if (ret)
-				goto error_ret;
-		}
-
-		val = ((s16)(val << 4) >> 4);
-		ret = sprintf(buf, "%d\n", val);
-	}
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16201_read_14bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	s16 val = 0;
-	ssize_t ret;
-
-	mutex_lock(&indio_dev->mlock);
-
-	ret = adis16201_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (!ret) {
-		if (val & ADIS16201_ERROR_ACTIVE) {
-			ret = adis16201_check_status(dev);
-			if (ret)
-				goto error_ret;
-		}
-
-		val = ((s16)(val << 2) >> 2);
-		ret = sprintf(buf, "%d\n", val);
-	}
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16201_write_16bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
-	long val;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = adis16201_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
 static int adis16201_reset(struct device *dev)
 {
 	int ret;
@@ -331,12 +178,12 @@ static ssize_t adis16201_write_reset(struct device *dev,
 	return -EINVAL;
 }
 
-int adis16201_set_irq(struct device *dev, bool enable)
+int adis16201_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret = 0;
 	u16 msc;
 
-	ret = adis16201_spi_read_reg_16(dev, ADIS16201_MSC_CTRL, &msc);
+	ret = adis16201_spi_read_reg_16(indio_dev, ADIS16201_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -347,20 +194,21 @@ int adis16201_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16201_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16201_spi_write_reg_16(dev, ADIS16201_MSC_CTRL, msc);
+	ret = adis16201_spi_write_reg_16(indio_dev, ADIS16201_MSC_CTRL, msc);
 
 error_ret:
 	return ret;
 }
 
-static int adis16201_check_status(struct device *dev)
+static int adis16201_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
 	int ret;
 
-	ret = adis16201_spi_read_reg_16(dev, ADIS16201_DIAG_STAT, &status);
+	ret = adis16201_spi_read_reg_16(indio_dev,
+					ADIS16201_DIAG_STAT, &status);
 	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
+		dev_err(&indio_dev->dev, "Reading status failed\n");
 		goto error_ret;
 	}
 	ret = status & 0xF;
@@ -368,30 +216,30 @@ static int adis16201_check_status(struct device *dev)
 		ret = -EFAULT;
 
 	if (status & ADIS16201_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
+		dev_err(&indio_dev->dev, "SPI failure\n");
 	if (status & ADIS16201_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
+		dev_err(&indio_dev->dev, "Flash update failed\n");
 	if (status & ADIS16201_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 3.625V\n");
+		dev_err(&indio_dev->dev, "Power supply above 3.625V\n");
 	if (status & ADIS16201_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 3.15V\n");
+		dev_err(&indio_dev->dev, "Power supply below 3.15V\n");
 
 error_ret:
 	return ret;
 }
 
-static int adis16201_self_test(struct device *dev)
+static int adis16201_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16201_spi_write_reg_16(dev,
+	ret = adis16201_spi_write_reg_16(indio_dev,
 			ADIS16201_MSC_CTRL,
 			ADIS16201_MSC_CTRL_SELF_TEST_EN);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
-	ret = adis16201_check_status(dev);
+	ret = adis16201_check_status(indio_dev);
 
 err_ret:
 	return ret;
@@ -403,26 +251,26 @@ static int adis16201_initial_setup(struct adis16201_state *st)
 	struct device *dev = &st->indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16201_set_irq(dev, false);
+	ret = adis16201_set_irq(st->indio_dev, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16201_self_test(dev);
+	ret = adis16201_self_test(st->indio_dev);
 	if (ret) {
 		dev_err(dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16201_check_status(dev);
+	ret = adis16201_check_status(st->indio_dev);
 	if (ret) {
 		adis16201_reset(dev);
 		dev_err(dev, "device not playing ball -> reset");
 		msleep(ADIS16201_STARTUP_DELAY);
-		ret = adis16201_check_status(dev);
+		ret = adis16201_check_status(st->indio_dev);
 		if (ret) {
 			dev_err(dev, "giving up");
 			goto err_ret;
@@ -436,66 +284,172 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16201_read_12bit_unsigned,
-		ADIS16201_SUPPLY_OUT);
-static IIO_CONST_ATTR(in0_supply_scale, "0.00122");
-static IIO_DEV_ATTR_IN_RAW(1, adis16201_read_12bit_unsigned,
-		ADIS16201_AUX_ADC);
-static IIO_CONST_ATTR(in1_scale, "0.00061");
-
-static IIO_DEV_ATTR_ACCEL_X(adis16201_read_14bit_signed,
-		ADIS16201_XACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Y(adis16201_read_14bit_signed,
-		ADIS16201_YACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
-		adis16201_read_12bit_signed,
-		adis16201_write_16bit,
-		ADIS16201_XACCL_OFFS);
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
-		adis16201_read_12bit_signed,
-		adis16201_write_16bit,
-		ADIS16201_YACCL_OFFS);
-static IIO_CONST_ATTR(accel_scale, "0.4625");
-
-static IIO_DEV_ATTR_INCLI_X(adis16201_read_14bit_signed,
-		ADIS16201_XINCL_OUT);
-static IIO_DEV_ATTR_INCLI_Y(adis16201_read_14bit_signed,
-		ADIS16201_YINCL_OUT);
-static IIO_DEV_ATTR_INCLI_X_OFFSET(S_IWUSR | S_IRUGO,
-		adis16201_read_9bit_signed,
-		adis16201_write_16bit,
-		ADIS16201_XACCL_OFFS);
-static IIO_DEV_ATTR_INCLI_Y_OFFSET(S_IWUSR | S_IRUGO,
-		adis16201_read_9bit_signed,
-		adis16201_write_16bit,
-		ADIS16201_YACCL_OFFS);
-static IIO_CONST_ATTR(incli_scale, "0.1");
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16201_read_temp);
-static IIO_CONST_ATTR(temp_offset, "25");
-static IIO_CONST_ATTR(temp_scale, "-0.47");
+static u8 adis16201_addresses[7][2] = {
+	[in_supply] = { ADIS16201_SUPPLY_OUT, },
+	[temp] = { ADIS16201_TEMP_OUT },
+	[accel_x] = { ADIS16201_XACCL_OUT, ADIS16201_XACCL_OFFS },
+	[accel_y] = { ADIS16201_YACCL_OUT, ADIS16201_YACCL_OFFS },
+	[in_aux] = { ADIS16201_AUX_ADC },
+	[incli_x] = { ADIS16201_XINCL_OUT },
+	[incli_y] = { ADIS16201_YINCL_OUT },
+};
+
+static int adis16201_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	int ret;
+	int bits;
+	u8 addr;
+	s16 val16;
+
+	switch (mask) {
+	case 0:
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16201_addresses[chan->address][0];
+		ret = adis16201_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret)
+			return ret;
+
+		if (val16 & ADIS16201_ERROR_ACTIVE) {
+			ret = adis16201_check_status(indio_dev);
+			if (ret)
+				return ret;
+		}
+		val16 = val16 & ((1 << chan->scan_type.realbits) - 1);
+		if (chan->scan_type.sign == 's')
+			val16 = (s16)(val16 <<
+				      (16 - chan->scan_type.realbits)) >>
+				(16 - chan->scan_type.realbits);
+		*val = val16;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		switch (chan->type) {
+		case IIO_IN:
+			*val = 0;
+			if (chan->channel == 0)
+				*val2 = 1220;
+			else
+				*val2 = 610;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = -470000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = 462500;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = 100000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		*val = 25;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		switch (chan->type) {
+		case IIO_ACCEL:
+			bits = 12;
+			break;
+		case IIO_INCLI:
+			bits = 9;
+			break;
+		default:
+			return -EINVAL;
+		};
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16201_addresses[chan->address][1];
+		ret = adis16201_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		val16 &= (1 << bits) - 1;
+		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		*val = val16;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static int adis16201_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	int bits;
+	s16 val16;
+	u8 addr;
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		switch (chan->type) {
+		case IIO_ACCEL:
+			bits = 12;
+			break;
+		case IIO_INCLI:
+			bits = 9;
+			break;
+		default:
+			return -EINVAL;
+		};
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16201_addresses[chan->address][1];
+		return adis16201_spi_write_reg_16(indio_dev, addr, val16);
+	}
+	return -EINVAL;
+}
+
+static struct iio_chan_spec adis16201_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_supply, ADIS16201_SCAN_SUPPLY,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 temp, ADIS16201_SCAN_TEMP,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 accel_x, ADIS16201_SCAN_ACC_X,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 accel_y, ADIS16201_SCAN_ACC_Y,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_aux, ADIS16201_SCAN_AUX_ADC,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 incli_x, ADIS16201_SCAN_INCLI_X,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 incli_y, ADIS16201_SCAN_INCLI_Y,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(7)
+};
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16201_write_reset, 0);
 
 static struct attribute *adis16201_attributes[] = {
-	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
-	&iio_const_attr_in0_supply_scale.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_const_attr_in1_scale.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
-	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_incli_x_raw.dev_attr.attr,
-	&iio_dev_attr_incli_y_raw.dev_attr.attr,
-	&iio_dev_attr_incli_x_offset.dev_attr.attr,
-	&iio_dev_attr_incli_y_offset.dev_attr.attr,
-	&iio_const_attr_incli_scale.dev_attr.attr,
 	NULL
 };
 
@@ -537,6 +491,10 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16201_attribute_group;
+	st->indio_dev->channels = adis16201_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
+	st->indio_dev->read_raw = &adis16201_read_raw;
+	st->indio_dev->write_raw = &adis16201_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -550,7 +508,9 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16201_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  adis16201_channels,
+					  ARRAY_SIZE(adis16201_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -571,7 +531,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16201_remove_trigger(st->indio_dev);
 error_uninitialize_ring:
-	adis16201_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16201_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -594,10 +554,8 @@ static int adis16201_remove(struct spi_device *spi)
 	struct adis16201_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
 	adis16201_remove_trigger(indio_dev);
-	adis16201_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index d0998b2..5405a38 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -1,14 +1,11 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -17,63 +14,15 @@
 #include "../trigger.h"
 #include "adis16201.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16201_SCAN_SUPPLY, ADIS16201_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
-static IIO_SCAN_EL_C(accel_x, ADIS16201_SCAN_ACC_X, ADIS16201_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16201_SCAN_ACC_Y, ADIS16201_YACCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
-static IIO_SCAN_EL_C(in0, ADIS16201_SCAN_AUX_ADC, ADIS16201_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16201_SCAN_TEMP, ADIS16201_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_C(incli_x, ADIS16201_SCAN_INCLI_X,
-		     ADIS16201_XINCL_OUT, NULL);
-static IIO_SCAN_EL_C(incli_y, ADIS16201_SCAN_INCLI_Y,
-		     ADIS16201_YINCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(incli, s, 14, 16);
-static IIO_SCAN_EL_TIMESTAMP(7);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16201_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
-	&iio_scan_el_accel_x.dev_attr.attr,
-	&iio_const_attr_accel_x_index.dev_attr.attr,
-	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_const_attr_accel_y_index.dev_attr.attr,
-	&iio_const_attr_accel_type.dev_attr.attr,
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_const_attr_in0_type.dev_attr.attr,
-	&iio_scan_el_temp.dev_attr.attr,
-	&iio_const_attr_temp_index.dev_attr.attr,
-	&iio_const_attr_temp_type.dev_attr.attr,
-	&iio_scan_el_incli_x.dev_attr.attr,
-	&iio_const_attr_incli_x_index.dev_attr.attr,
-	&iio_scan_el_incli_y.dev_attr.attr,
-	&iio_const_attr_incli_y_index.dev_attr.attr,
-	&iio_const_attr_incli_type.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16201_scan_el_group = {
-	.attrs = adis16201_scan_el_attrs,
-	.name = "scan_elements",
-};
 
 /**
  * adis16201_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @rx: somewhere to pass back the value read
  **/
-static int adis16201_read_ring_data(struct device *dev, u8 *rx)
+static int adis16201_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[ADIS16201_OUTPUTS + 1];
 	int ret;
@@ -90,7 +39,8 @@ static int adis16201_read_ring_data(struct device *dev, u8 *rx)
 		xfers[i].len = 2;
 		xfers[i].delay_usecs = 20;
 		xfers[i].tx_buf = st->tx + 2 * i;
-		st->tx[2 * i] = ADIS16201_READ_REG(ADIS16201_SUPPLY_OUT + 2 * i);
+		st->tx[2 * i] = ADIS16201_READ_REG(ADIS16201_SUPPLY_OUT +
+						   2 * i);
 		st->tx[2 * i + 1] = 0;
 		if (i >= 1)
 			xfers[i].rx_buf = rx + 2 * (i - 1);
@@ -127,7 +77,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count)
-		if (adis16201_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+		if (adis16201_read_ring_data(st->indio_dev, st->rx) >= 0)
 			for (; i < ring->scan_count; i++)
 				data[i] = be16_to_cpup(
 					(__be16 *)&(st->rx[i*2]));
@@ -136,9 +86,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
 
-	ring->access.store_to(ring,
-			      (u8 *)data,
-			      pf->timestamp);
+	ring->access.store_to(ring, (u8 *)data, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
 	kfree(data);
@@ -167,7 +115,6 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16201_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -175,13 +122,13 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
-	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
+	iio_scan_mask_set(ring,	ADIS16201_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16201_SCAN_ACC_X);
+	iio_scan_mask_set(ring, ADIS16201_SCAN_ACC_Y);
+	iio_scan_mask_set(ring, ADIS16201_SCAN_AUX_ADC);
+	iio_scan_mask_set(ring, ADIS16201_SCAN_TEMP);
+	iio_scan_mask_set(ring, ADIS16201_SCAN_INCLI_X);
+	iio_scan_mask_set(ring, ADIS16201_SCAN_INCLI_Y);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
@@ -207,13 +154,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-int adis16201_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16201_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index a4fb410..bfd43c5 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -4,7 +4,6 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
@@ -33,7 +32,7 @@ static int adis16201_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16201_set_irq(&st->indio_dev->dev, state);
+	return adis16201_set_irq(st->indio_dev, state);
 }
 
 int adis16201_probe_trigger(struct iio_dev *indio_dev)
-- 
1.7.3.4
