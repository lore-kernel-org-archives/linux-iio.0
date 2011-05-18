Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 059/111] staging:iio:accel:adis16209 move to chan_spec based setup.
Date: Wed, 18 May 2011 14:41:49 +0100
Message-Id: <1305726161-5606-60-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

For clean drivers its easier to convert to chan_spec based
registration than to work around the scan_el attributes
going away.

Some minor cleanups done whilst here.

Untested.

V2: IIO_CHAN macro used.
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209.h         |    2 +-
 drivers/staging/iio/accel/adis16209_core.c    |  434 +++++++++++++------------
 drivers/staging/iio/accel/adis16209_ring.c    |   71 +----
 drivers/staging/iio/accel/adis16209_trigger.c |    2 +-
 4 files changed, 232 insertions(+), 277 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index 9ef596f..58d08db 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -119,7 +119,7 @@ struct adis16209_state {
 	struct mutex			buf_lock;
 };
 
-int adis16209_set_irq(struct device *dev, bool enable);
+int adis16209_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index fa0a3ad..d48babe 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -6,9 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -23,27 +20,23 @@
 #include "../ring_generic.h"
 #include "accel.h"
 #include "inclinometer.h"
-#include "../gyro/gyro.h"
 #include "../adc/adc.h"
 
 #include "adis16209.h"
 
 #define DRIVER_NAME		"adis16209"
 
-static int adis16209_check_status(struct device *dev);
-
 /**
  * adis16209_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with actual device
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16209_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
+static int adis16209_spi_write_reg_8(struct iio_dev *indio_dev,
+				     u8 reg_address,
+				     u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -58,18 +51,17 @@ static int adis16209_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16209_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16209_spi_write_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 value)
+static int adis16209_spi_write_reg_16(struct iio_dev *indio_dev,
+				      u8 lower_reg_address,
+				      u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -82,7 +74,6 @@ static int adis16209_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 30,
 		},
 	};
@@ -104,17 +95,16 @@ static int adis16209_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16209_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16209_spi_read_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 *val)
+static int adis16209_spi_read_reg_16(struct iio_dev *indio_dev,
+				     u8 lower_reg_address,
+				     u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -128,7 +118,6 @@ static int adis16209_spi_read_reg_16(struct device *dev,
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 30,
 		},
 	};
@@ -154,119 +143,14 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16209_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16209_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16209_ERROR_ACTIVE)
-		adis16209_check_status(dev);
-
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16209_read_14bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adis16209_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16209_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16209_ERROR_ACTIVE)
-		adis16209_check_status(dev);
-
-	return sprintf(buf, "%u\n", val & 0x3FFF);
-}
-
-static ssize_t adis16209_read_temp(struct device *dev,
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
-	ret = adis16209_spi_read_reg_16(dev, ADIS16209_TEMP_OUT, (u16 *)&val);
-	if (ret)
-		goto error_ret;
-
-	if (val & ADIS16209_ERROR_ACTIVE)
-		adis16209_check_status(dev);
-
-	val &= 0xFFF;
-	ret = sprintf(buf, "%d\n", val);
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static ssize_t adis16209_read_14bit_signed(struct device *dev,
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
-	ret = adis16209_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (!ret) {
-		if (val & ADIS16209_ERROR_ACTIVE)
-			adis16209_check_status(dev);
-
-		val = ((s16)(val << 2) >> 2);
-		ret = sprintf(buf, "%d\n", val);
-	}
-
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16209_write_16bit(struct device *dev,
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
-	ret = adis16209_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
-static int adis16209_reset(struct device *dev)
-{
-	int ret;
-	ret = adis16209_spi_write_reg_8(dev,
+	ret = adis16209_spi_write_reg_8(indio_dev,
 			ADIS16209_GLOB_CMD,
 			ADIS16209_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -275,23 +159,25 @@ static ssize_t adis16209_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
 	if (len < 1)
 		return -EINVAL;
 	switch (buf[0]) {
 	case '1':
 	case 'y':
 	case 'Y':
-		return adis16209_reset(dev);
+		return adis16209_reset(indio_dev);
 	}
 	return -EINVAL;
 }
 
-int adis16209_set_irq(struct device *dev, bool enable)
+int adis16209_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret = 0;
 	u16 msc;
 
-	ret = adis16209_spi_read_reg_16(dev, ADIS16209_MSC_CTRL, &msc);
+	ret = adis16209_spi_read_reg_16(indio_dev, ADIS16209_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -302,149 +188,267 @@ int adis16209_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16209_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16209_spi_write_reg_16(dev, ADIS16209_MSC_CTRL, msc);
+	ret = adis16209_spi_write_reg_16(indio_dev, ADIS16209_MSC_CTRL, msc);
 
 error_ret:
 	return ret;
 }
 
-static int adis16209_check_status(struct device *dev)
+static int adis16209_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
 	int ret;
 
-	ret = adis16209_spi_read_reg_16(dev, ADIS16209_DIAG_STAT, &status);
+	ret = adis16209_spi_read_reg_16(indio_dev,
+					ADIS16209_DIAG_STAT, &status);
 	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
+		dev_err(&indio_dev->dev, "Reading status failed\n");
 		goto error_ret;
 	}
 	ret = status & 0x1F;
 
 	if (status & ADIS16209_DIAG_STAT_SELFTEST_FAIL)
-		dev_err(dev, "Self test failure\n");
+		dev_err(&indio_dev->dev, "Self test failure\n");
 	if (status & ADIS16209_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
+		dev_err(&indio_dev->dev, "SPI failure\n");
 	if (status & ADIS16209_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
+		dev_err(&indio_dev->dev, "Flash update failed\n");
 	if (status & ADIS16209_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 3.625V\n");
+		dev_err(&indio_dev->dev, "Power supply above 3.625V\n");
 	if (status & ADIS16209_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 3.15V\n");
+		dev_err(&indio_dev->dev, "Power supply below 3.15V\n");
 
 error_ret:
 	return ret;
 }
 
-static int adis16209_self_test(struct device *dev)
+static int adis16209_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16209_spi_write_reg_16(dev,
+	ret = adis16209_spi_write_reg_16(indio_dev,
 			ADIS16209_MSC_CTRL,
 			ADIS16209_MSC_CTRL_SELF_TEST_EN);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
-	adis16209_check_status(dev);
+	adis16209_check_status(indio_dev);
 
 err_ret:
 	return ret;
 }
 
-static int adis16209_initial_setup(struct adis16209_state *st)
+static int adis16209_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16209_set_irq(dev, false);
+	ret = adis16209_set_irq(indio_dev, false);
 	if (ret) {
-		dev_err(dev, "disable irq failed");
+		dev_err(&indio_dev->dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16209_self_test(dev);
+	ret = adis16209_self_test(indio_dev);
 	if (ret) {
-		dev_err(dev, "self test failure");
+		dev_err(&indio_dev->dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16209_check_status(dev);
+	ret = adis16209_check_status(indio_dev);
 	if (ret) {
-		adis16209_reset(dev);
-		dev_err(dev, "device not playing ball -> reset");
+		adis16209_reset(indio_dev);
+		dev_err(&indio_dev->dev, "device not playing ball -> reset");
 		msleep(ADIS16209_STARTUP_DELAY);
-		ret = adis16209_check_status(dev);
+		ret = adis16209_check_status(indio_dev);
 		if (ret) {
-			dev_err(dev, "giving up");
+			dev_err(&indio_dev->dev, "giving up");
 			goto err_ret;
 		}
 	}
 
-	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
-			st->us->chip_select, st->us->irq);
-
 err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16209_read_14bit_unsigned,
-		ADIS16209_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.30518");
-static IIO_DEV_ATTR_IN_RAW(1, adis16209_read_12bit_unsigned,
-		ADIS16209_AUX_ADC);
-static IIO_CONST_ATTR(in1_scale, "0.6105");
-
-static IIO_DEV_ATTR_ACCEL_X(adis16209_read_14bit_signed,
-		ADIS16209_XACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Y(adis16209_read_14bit_signed,
-		ADIS16209_YACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(S_IWUSR | S_IRUGO,
-		adis16209_read_14bit_signed,
-		adis16209_write_16bit,
-		ADIS16209_XACCL_NULL);
-static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
-		adis16209_read_14bit_signed,
-		adis16209_write_16bit,
-		ADIS16209_YACCL_NULL);
-static IIO_CONST_ATTR_ACCEL_SCALE("0.002394195531");
-
-static IIO_DEV_ATTR_INCLI_X(adis16209_read_14bit_signed,
-		ADIS16209_XINCL_OUT);
-static IIO_DEV_ATTR_INCLI_Y(adis16209_read_14bit_signed,
-		ADIS16209_YINCL_OUT);
-static IIO_CONST_ATTR(incli_scale, "0.00043633231");
-
-static IIO_DEVICE_ATTR(rot_raw, S_IRUGO, adis16209_read_14bit_signed,
-		       NULL, ADIS16209_ROT_OUT);
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16209_read_temp);
-static IIO_CONST_ATTR_TEMP_OFFSET("25");
-static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
+enum adis16209_chan {
+	in_supply,
+	temp,
+	accel_x,
+	accel_y,
+	incli_x,
+	incli_y,
+	in_aux,
+	rot,
+};
+
+static const u8 adis16209_addresses[8][2] = {
+	[in_supply] = { ADIS16209_SUPPLY_OUT },
+	[in_aux] = { ADIS16209_AUX_ADC },
+	[accel_x] = { ADIS16209_XACCL_OUT, ADIS16209_XACCL_NULL },
+	[accel_y] = { ADIS16209_YACCL_OUT, ADIS16209_YACCL_NULL },
+	[incli_x] = { ADIS16209_XINCL_OUT, ADIS16209_XINCL_NULL },
+	[incli_y] = { ADIS16209_YINCL_OUT, ADIS16209_YINCL_NULL },
+	[rot] = { ADIS16209_ROT_OUT },
+	[temp] = { ADIS16209_TEMP_OUT },
+};
+
+static int adis16209_write_raw(struct iio_dev *indio_dev,
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
+		case IIO_INCLI:
+			bits = 14;
+			break;
+		default:
+			return -EINVAL;
+		};
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16209_addresses[chan->address][1];
+		return adis16209_spi_write_reg_16(indio_dev, addr, val16);
+	}
+	return -EINVAL;
+}
+
+static int adis16209_read_raw(struct iio_dev *indio_dev,
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
+		addr = adis16209_addresses[chan->address][0];
+		ret = adis16209_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret)
+			return ret;
+
+		if (val16 & ADIS16209_ERROR_ACTIVE) {
+			ret = adis16209_check_status(indio_dev);
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
+				*val2 = 305180;
+			else
+				*val2 = 610500;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = -470000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = 2394;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = 436;
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
+			bits = 14;
+			break;
+		default:
+			return -EINVAL;
+		};
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16209_addresses[chan->address][1];
+		ret = adis16209_spi_read_reg_16(indio_dev, addr, &val16);
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
+static struct iio_chan_spec adis16209_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_supply, ADIS16209_SCAN_SUPPLY,
+		 IIO_ST('u', 14, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 temp, ADIS16209_SCAN_TEMP,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 accel_x, ADIS16209_SCAN_ACC_X,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 accel_y, ADIS16209_SCAN_ACC_Y,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_aux, ADIS16209_SCAN_AUX_ADC,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 0, 1, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 incli_x, ADIS16209_SCAN_INCLI_X,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 0, 1, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 incli_y, ADIS16209_SCAN_INCLI_Y,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ROT, 0, 1, 0, NULL, 0, IIO_MOD_X,
+		    0,
+		    rot, ADIS16209_SCAN_ROT,
+		    IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(8)
+};
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16209_write_reset, 0);
 
 static struct attribute *adis16209_attributes[] = {
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
-	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
-	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_incli_x_raw.dev_attr.attr,
-	&iio_dev_attr_incli_y_raw.dev_attr.attr,
-	&iio_const_attr_incli_scale.dev_attr.attr,
-	&iio_dev_attr_rot_raw.dev_attr.attr,
 	NULL
 };
 
@@ -486,6 +490,10 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16209_attribute_group;
+	st->indio_dev->channels = adis16209_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
+	st->indio_dev->read_raw = &adis16209_read_raw;
+	st->indio_dev->write_raw = &adis16209_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -499,7 +507,9 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  adis16209_channels,
+					  ARRAY_SIZE(adis16209_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -512,7 +522,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16209_initial_setup(st);
+	ret = adis16209_initial_setup(st->indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 6e66469..2c7be3b 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -17,60 +17,6 @@
 #include "../trigger.h"
 #include "adis16209.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16209_SCAN_SUPPLY,
-		     ADIS16209_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 14, 16)
-static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, ADIS16209_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, ADIS16209_YACCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
-static IIO_SCAN_EL_C(in0, ADIS16209_SCAN_AUX_ADC, ADIS16209_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, ADIS16209_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X,
-		     ADIS16209_XINCL_OUT, NULL);
-static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y,
-		     ADIS16209_YINCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(incli, s, 14, 16);
-static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, ADIS16209_ROT_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(rot, s, 14, 16);
-static IIO_SCAN_EL_TIMESTAMP(8);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16209_scan_el_attrs[] = {
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
-	&iio_scan_el_rot.dev_attr.attr,
-	&iio_const_attr_rot_index.dev_attr.attr,
-	&iio_const_attr_rot_type.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16209_scan_el_group = {
-	.attrs = adis16209_scan_el_attrs,
-	.name = "scan_elements",
-};
-
 /**
  * adis16209_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
@@ -171,7 +117,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16209_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -179,14 +124,14 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_rot.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
-	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_ACC_X);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_ACC_Y);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_AUX_ADC);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_TEMP);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_INCLI_X);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_INCLI_Y);
+	iio_scan_mask_set(ring, ADIS16209_SCAN_ROT);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 86e83c3..0847ce5 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -42,7 +42,7 @@ static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16209_set_irq(&st->indio_dev->dev, state);
+	return adis16209_set_irq(st->indio_dev, state);
 }
 
 int adis16209_probe_trigger(struct iio_dev *indio_dev)
-- 
1.7.3.4
