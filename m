Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 058/111] staging:iio:accel:adis16204 move to chan_spec based setup.
Date: Wed, 18 May 2011 14:41:48 +0100
Message-Id: <1305726161-5606-59-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

For clean drivers its easier to convert to chan_spec based
registration than to work around the scan_el attributes
going away.

Some minor cleanups done whilst here.

Untested.

V2: used IIO_CHAN macro

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16204.h         |   13 +-
 drivers/staging/iio/accel/adis16204_core.c    |  402 +++++++++++++------------
 drivers/staging/iio/accel/adis16204_ring.c    |   62 +----
 drivers/staging/iio/accel/adis16204_trigger.c |    2 +-
 4 files changed, 220 insertions(+), 259 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
index bdd20c6..5310a42 100644
--- a/drivers/staging/iio/accel/adis16204.h
+++ b/drivers/staging/iio/accel/adis16204.h
@@ -82,7 +82,7 @@ struct adis16204_state {
 	struct mutex			buf_lock;
 };
 
-int adis16204_set_irq(struct device *dev, bool enable);
+int adis16204_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 enum adis16204_scan {
@@ -103,8 +103,6 @@ ssize_t adis16204_read_data_from_ring(struct device *dev,
 int adis16204_configure_ring(struct iio_dev *indio_dev);
 void adis16204_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16204_initialize_ring(struct iio_ring_buffer *ring);
-void adis16204_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16204_remove_trigger(struct iio_dev *indio_dev)
@@ -133,14 +131,5 @@ static inline void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-static inline int adis16204_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16204_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16204_H_ */
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index a9c890d..4e4944c 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -20,28 +20,25 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "accel.h"
-#include "../gyro/gyro.h"
 #include "../adc/adc.h"
 
 #include "adis16204.h"
 
 #define DRIVER_NAME		"adis16204"
 
-static int adis16204_check_status(struct device *dev);
-
 /**
  * adis16204_spi_write_reg_8() - write single byte to a register
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16204_spi_write_reg_8(struct device *dev,
+static int adis16204_spi_write_reg_8(struct iio_dev *indio_dev,
 		u8 reg_address,
 		u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -56,18 +53,17 @@ static int adis16204_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16204_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16204_spi_write_reg_16(struct device *dev,
+static int adis16204_spi_write_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -100,17 +96,16 @@ static int adis16204_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16204_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16204_spi_read_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 *val)
+static int adis16204_spi_read_reg_16(struct iio_dev *indio_dev,
+				     u8 lower_reg_address,
+				     u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -124,7 +119,6 @@ static int adis16204_spi_read_reg_16(struct device *dev,
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 20,
 		},
 	};
@@ -149,72 +143,31 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16204_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adis16204_check_status(struct iio_dev *indio_dev)
 {
+	u16 status;
 	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16204_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16204_ERROR_ACTIVE)
-		adis16204_check_status(dev);
 
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16204_read_temp(struct device *dev,
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
-	ret = adis16204_spi_read_reg_16(dev, ADIS16204_TEMP_OUT, (u16 *)&val);
-	if (ret)
+	ret = adis16204_spi_read_reg_16(indio_dev,
+					ADIS16204_DIAG_STAT, &status);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Reading status failed\n");
 		goto error_ret;
-
-	if (val & ADIS16204_ERROR_ACTIVE)
-		adis16204_check_status(dev);
-
-	val &= 0xFFF;
-	ret = sprintf(buf, "%d\n", val);
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static ssize_t adis16204_read_12bit_signed(struct device *dev,
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
-	ret = adis16204_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (!ret) {
-		if (val & ADIS16204_ERROR_ACTIVE)
-			adis16204_check_status(dev);
-
-		val = ((s16)(val << 4) >> 4);
-		ret = sprintf(buf, "%d\n", val);
 	}
+	ret = status & 0x1F;
 
-	mutex_unlock(&indio_dev->mlock);
+	if (status & ADIS16204_DIAG_STAT_SELFTEST_FAIL)
+		dev_err(&indio_dev->dev, "Self test failure\n");
+	if (status & ADIS16204_DIAG_STAT_SPI_FAIL)
+		dev_err(&indio_dev->dev, "SPI failure\n");
+	if (status & ADIS16204_DIAG_STAT_FLASH_UPT)
+		dev_err(&indio_dev->dev, "Flash update failed\n");
+	if (status & ADIS16204_DIAG_STAT_POWER_HIGH)
+		dev_err(&indio_dev->dev, "Power supply above 3.625V\n");
+	if (status & ADIS16204_DIAG_STAT_POWER_LOW)
+		dev_err(&indio_dev->dev, "Power supply below 2.975V\n");
 
+error_ret:
 	return ret;
 }
 
@@ -229,10 +182,11 @@ static ssize_t adis16204_read_14bit_signed(struct device *dev,
 
 	mutex_lock(&indio_dev->mlock);
 
-	ret = adis16204_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	ret = adis16204_spi_read_reg_16(indio_dev,
+					this_attr->address, (u16 *)&val);
 	if (!ret) {
 		if (val & ADIS16204_ERROR_ACTIVE)
-			adis16204_check_status(dev);
+			adis16204_check_status(indio_dev);
 
 		val = ((s16)(val << 2) >> 2);
 		ret = sprintf(buf, "%d\n", val);
@@ -243,32 +197,14 @@ static ssize_t adis16204_read_14bit_signed(struct device *dev,
 	return ret;
 }
 
-static ssize_t adis16204_write_16bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static int adis16204_reset(struct iio_dev *indio_dev)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-	long val;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = adis16204_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
-static int adis16204_reset(struct device *dev)
-{
-	int ret;
-	ret = adis16204_spi_write_reg_8(dev,
+	ret = adis16204_spi_write_reg_8(indio_dev,
 			ADIS16204_GLOB_CMD,
 			ADIS16204_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -277,23 +213,25 @@ static ssize_t adis16204_write_reset(struct device *dev,
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
-		return adis16204_reset(dev);
+		return adis16204_reset(indio_dev);
 	}
 	return -EINVAL;
 }
 
-int adis16204_set_irq(struct device *dev, bool enable)
+int adis16204_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret = 0;
 	u16 msc;
 
-	ret = adis16204_spi_read_reg_16(dev, ADIS16204_MSC_CTRL, &msc);
+	ret = adis16204_spi_read_reg_16(indio_dev, ADIS16204_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -304,106 +242,63 @@ int adis16204_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16204_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16204_spi_write_reg_16(dev, ADIS16204_MSC_CTRL, msc);
+	ret = adis16204_spi_write_reg_16(indio_dev, ADIS16204_MSC_CTRL, msc);
 
 error_ret:
 	return ret;
 }
 
-static int adis16204_check_status(struct device *dev)
+static int adis16204_self_test(struct iio_dev *indio_dev)
 {
-	u16 status;
 	int ret;
-
-	ret = adis16204_spi_read_reg_16(dev, ADIS16204_DIAG_STAT, &status);
-	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
-		goto error_ret;
-	}
-	ret = status & 0x1F;
-
-	if (status & ADIS16204_DIAG_STAT_SELFTEST_FAIL)
-		dev_err(dev, "Self test failure\n");
-	if (status & ADIS16204_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
-	if (status & ADIS16204_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
-	if (status & ADIS16204_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 3.625V\n");
-	if (status & ADIS16204_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 2.975V\n");
-
-error_ret:
-	return ret;
-}
-
-static int adis16204_self_test(struct device *dev)
-{
-	int ret;
-	ret = adis16204_spi_write_reg_16(dev,
+	ret = adis16204_spi_write_reg_16(indio_dev,
 			ADIS16204_MSC_CTRL,
 			ADIS16204_MSC_CTRL_SELF_TEST_EN);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
-	adis16204_check_status(dev);
+	adis16204_check_status(indio_dev);
 
 err_ret:
 	return ret;
 }
 
-static int adis16204_initial_setup(struct adis16204_state *st)
+static int adis16204_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16204_set_irq(dev, false);
+	ret = adis16204_set_irq(indio_dev, false);
 	if (ret) {
-		dev_err(dev, "disable irq failed");
+		dev_err(&indio_dev->dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16204_self_test(dev);
+	ret = adis16204_self_test(indio_dev);
 	if (ret) {
-		dev_err(dev, "self test failure");
+		dev_err(&indio_dev->dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16204_check_status(dev);
+	ret = adis16204_check_status(indio_dev);
 	if (ret) {
-		adis16204_reset(dev);
-		dev_err(dev, "device not playing ball -> reset");
+		adis16204_reset(indio_dev);
+		dev_err(&indio_dev->dev, "device not playing ball -> reset");
 		msleep(ADIS16204_STARTUP_DELAY);
-		ret = adis16204_check_status(dev);
+		ret = adis16204_check_status(indio_dev);
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
-
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16204_read_12bit_unsigned,
-		ADIS16204_SUPPLY_OUT);
-static IIO_CONST_ATTR(in0_supply_scale, "0.00122");
-static IIO_DEV_ATTR_IN_RAW(1, adis16204_read_12bit_unsigned,
-		ADIS16204_AUX_ADC);
-static IIO_CONST_ATTR(in1_scale, "0.00061");
-
-static IIO_DEV_ATTR_ACCEL_X(adis16204_read_14bit_signed,
-		ADIS16204_XACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Y(adis16204_read_14bit_signed,
-		ADIS16204_YACCL_OUT);
 static IIO_DEV_ATTR_ACCEL_XY(adis16204_read_14bit_signed,
 		ADIS16204_XY_RSS_OUT);
 static IIO_DEV_ATTR_ACCEL_XPEAK(adis16204_read_14bit_signed,
@@ -412,43 +307,164 @@ static IIO_DEV_ATTR_ACCEL_YPEAK(adis16204_read_14bit_signed,
 		ADIS16204_Y_PEAK_OUT);
 static IIO_DEV_ATTR_ACCEL_XYPEAK(adis16204_read_14bit_signed,
 		ADIS16204_XY_PEAK_OUT);
-static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
-		adis16204_read_12bit_signed,
-		adis16204_write_16bit,
-		ADIS16204_XACCL_NULL);
-static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
-		adis16204_read_12bit_signed,
-		adis16204_write_16bit,
-		ADIS16204_YACCL_NULL);
-static IIO_CONST_ATTR(accel_x_scale, "0.017125");
-static IIO_CONST_ATTR(accel_y_scale, "0.008407");
 static IIO_CONST_ATTR(accel_xy_scale, "0.017125");
 
-static IIO_DEV_ATTR_TEMP_RAW(adis16204_read_temp);
-static IIO_CONST_ATTR(temp_offset, "25");
-static IIO_CONST_ATTR(temp_scale, "-0.47");
-
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16204_write_reset, 0);
 
+enum adis16204_channel {
+	in_supply,
+	in_aux,
+	temp,
+	accel_x,
+	accel_y,
+};
+
+static u8 adis16204_addresses[5][2] = {
+	[in_supply] = { ADIS16204_SUPPLY_OUT },
+	[in_aux] = { ADIS16204_AUX_ADC },
+	[temp] = { ADIS16204_TEMP_OUT },
+	[accel_x] = { ADIS16204_XACCL_OUT, ADIS16204_XACCL_NULL },
+	[accel_y] = { ADIS16204_XACCL_OUT, ADIS16204_YACCL_NULL },
+};
+static int adis16204_read_raw(struct iio_dev *indio_dev,
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
+		addr = adis16204_addresses[chan->address][0];
+		ret = adis16204_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret)
+			return ret;
+
+		if (val16 & ADIS16204_ERROR_ACTIVE) {
+			ret = adis16204_check_status(indio_dev);
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
+			if (chan->channel == 'x')
+				*val2 = 17125;
+			else
+				*val2 = 8407;
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
+		default:
+			return -EINVAL;
+		};
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16204_addresses[chan->address][1];
+		ret = adis16204_spi_read_reg_16(indio_dev, addr, &val16);
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
+static int adis16204_write_raw(struct iio_dev *indio_dev,
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
+		default:
+			return -EINVAL;
+		};
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16204_addresses[chan->address][1];
+		return adis16204_spi_write_reg_16(indio_dev, addr, val16);
+	}
+	return -EINVAL;
+}
+
+static struct iio_chan_spec adis16204_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 0, 0, "supply", 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_supply, ADIS16204_SCAN_SUPPLY,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_aux, ADIS16204_SCAN_AUX_ADC,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 temp, ADIS16204_SCAN_TEMP,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 accel_x, ADIS16204_SCAN_ACC_X,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 accel_y, ADIS16204_SCAN_ACC_Y,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(5),
+};
 static struct attribute *adis16204_attributes[] = {
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
 	&iio_dev_attr_accel_xy.dev_attr.attr,
 	&iio_dev_attr_accel_xpeak.dev_attr.attr,
 	&iio_dev_attr_accel_ypeak.dev_attr.attr,
 	&iio_dev_attr_accel_xypeak.dev_attr.attr,
-	&iio_dev_attr_accel_x_offset.dev_attr.attr,
-	&iio_dev_attr_accel_y_offset.dev_attr.attr,
-	&iio_const_attr_accel_x_scale.dev_attr.attr,
-	&iio_const_attr_accel_y_scale.dev_attr.attr,
 	&iio_const_attr_accel_xy_scale.dev_attr.attr,
 	NULL
 };
@@ -491,6 +507,10 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16204_attribute_group;
+	st->indio_dev->channels = adis16204_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(adis16204_channels);
+	st->indio_dev->read_raw = &adis16204_read_raw;
+	st->indio_dev->write_raw = &adis16204_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -504,7 +524,9 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16204_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  adis16204_channels,
+					  ARRAY_SIZE(adis16204_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -517,7 +539,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16204_initial_setup(st);
+	ret = adis16204_initial_setup(st->indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
@@ -525,7 +547,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16204_remove_trigger(st->indio_dev);
 error_uninitialize_ring:
-	adis16204_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16204_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -548,10 +570,8 @@ static int adis16204_remove(struct spi_device *spi)
 	struct adis16204_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
 	adis16204_remove_trigger(indio_dev);
-	adis16204_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
 	kfree(st->tx);
@@ -583,5 +603,5 @@ static __exit void adis16204_exit(void)
 module_exit(adis16204_exit);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16204 Programmable High-g Digital Impact Sensor and Recorder");
+MODULE_DESCRIPTION("ADIS16204 High-g Digital Impact Sensor and Recorder");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 035e5c4..50cd073 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -17,44 +17,6 @@
 #include "../trigger.h"
 #include "adis16204.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16204_SCAN_SUPPLY, ADIS16204_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
-static IIO_SCAN_EL_C(accel_x, ADIS16204_SCAN_ACC_X, ADIS16204_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16204_SCAN_ACC_Y, ADIS16204_YACCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
-static IIO_SCAN_EL_C(in0, ADIS16204_SCAN_AUX_ADC, ADIS16204_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16204_SCAN_TEMP, ADIS16204_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_TIMESTAMP(5);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16204_scan_el_attrs[] = {
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
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16204_scan_el_group = {
-	.attrs = adis16204_scan_el_attrs,
-	.name = "scan_elements",
-};
-
 /**
  * adis16204_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
@@ -80,7 +42,8 @@ static int adis16204_read_ring_data(struct device *dev, u8 *rx)
 		xfers[i].len = 2;
 		xfers[i].delay_usecs = 20;
 		xfers[i].tx_buf = st->tx + 2 * i;
-		st->tx[2 * i] = ADIS16204_READ_REG(ADIS16204_SUPPLY_OUT + 2 * i);
+		st->tx[2 * i]
+			= ADIS16204_READ_REG(ADIS16204_SUPPLY_OUT + 2 * i);
 		st->tx[2 * i + 1] = 0;
 		if (i >= 1)
 			xfers[i].rx_buf = rx + 2 * (i - 1);
@@ -154,7 +117,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16204_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -162,11 +124,11 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
+	iio_scan_mask_set(ring, ADIS16204_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16204_SCAN_ACC_X);
+	iio_scan_mask_set(ring, ADIS16204_SCAN_ACC_Y);
+	iio_scan_mask_set(ring, ADIS16204_SCAN_AUX_ADC);
+	iio_scan_mask_set(ring, ADIS16204_SCAN_TEMP);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
@@ -193,13 +155,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-int adis16204_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16204_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index 5f083f8..a00668c 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -33,7 +33,7 @@ static int adis16204_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16204_set_irq(&st->indio_dev->dev, state);
+	return adis16204_set_irq(st->indio_dev, state);
 }
 
 int adis16204_probe_trigger(struct iio_dev *indio_dev)
-- 
1.7.3.4
