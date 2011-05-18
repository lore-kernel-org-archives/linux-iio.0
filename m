Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 057/111] staging:iio:accel:adis16203 move to chan_spec based setup.
Date: Wed, 18 May 2011 14:41:47 +0100
Message-Id: <1305726161-5606-58-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Mainly motivated by wish to remove the remaing users of the
scan helpers.

Some minor cleanups done whilst here.

Untested.

V2: Use IIO_CHAN macro
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16203.h         |   13 +-
 drivers/staging/iio/accel/adis16203_core.c    |  376 ++++++++++++------------
 drivers/staging/iio/accel/adis16203_ring.c    |   61 +----
 drivers/staging/iio/accel/adis16203_trigger.c |    2 +-
 4 files changed, 195 insertions(+), 257 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.h b/drivers/staging/iio/accel/adis16203.h
index 49fce30..8bb8ce5 100644
--- a/drivers/staging/iio/accel/adis16203.h
+++ b/drivers/staging/iio/accel/adis16203.h
@@ -74,7 +74,7 @@ struct adis16203_state {
 	struct mutex			buf_lock;
 };
 
-int adis16203_set_irq(struct device *dev, bool enable);
+int adis16203_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 enum adis16203_scan {
@@ -95,8 +95,6 @@ ssize_t adis16203_read_data_from_ring(struct device *dev,
 int adis16203_configure_ring(struct iio_dev *indio_dev);
 void adis16203_unconfigure_ring(struct iio_dev *indio_dev);
 
-int adis16203_initialize_ring(struct iio_ring_buffer *ring);
-void adis16203_uninitialize_ring(struct iio_ring_buffer *ring);
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void adis16203_remove_trigger(struct iio_dev *indio_dev)
@@ -125,14 +123,5 @@ static inline void adis16203_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-static inline int adis16203_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16203_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16203_H_ */
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 6162311..1694a0c 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -6,9 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -16,33 +13,29 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
 #include "accel.h"
 #include "inclinometer.h"
-#include "../gyro/gyro.h"
+#include "../ring_generic.h"
 #include "../adc/adc.h"
 
 #include "adis16203.h"
 
 #define DRIVER_NAME		"adis16203"
 
-static int adis16203_check_status(struct device *dev);
-
 /**
  * adis16203_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16203_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
+static int adis16203_spi_write_reg_8(struct iio_dev *indio_dev,
+				     u8 reg_address,
+				     u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -57,18 +50,17 @@ static int adis16203_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16203_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16203_spi_write_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 value)
+static int adis16203_spi_write_reg_16(struct iio_dev *indio_dev,
+				      u8 lower_reg_address,
+				      u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -80,7 +72,6 @@ static int adis16203_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		},
 	};
 
@@ -101,17 +92,16 @@ static int adis16203_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16203_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16203_spi_read_reg_16(struct device *dev,
+static int adis16203_spi_read_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -125,7 +115,6 @@ static int adis16203_spi_read_reg_16(struct device *dev,
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 20,
 		},
 	};
@@ -150,101 +139,43 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16203_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adis16203_check_status(struct iio_dev *indio_dev)
 {
+	u16 status;
 	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16203_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16203_ERROR_ACTIVE)
-		adis16203_check_status(dev);
 
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16203_read_temp(struct device *dev,
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
-	ret = adis16203_spi_read_reg_16(dev, ADIS16203_TEMP_OUT, (u16 *)&val);
-	if (ret)
+	ret = adis16203_spi_read_reg_16(indio_dev,
+					ADIS16203_DIAG_STAT,
+					&status);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Reading status failed\n");
 		goto error_ret;
-
-	if (val & ADIS16203_ERROR_ACTIVE)
-		adis16203_check_status(dev);
-
-	val &= 0xFFF;
-	ret = sprintf(buf, "%d\n", val);
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static ssize_t adis16203_read_14bit_signed(struct device *dev,
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
-	ret = adis16203_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (!ret) {
-		if (val & ADIS16203_ERROR_ACTIVE)
-			adis16203_check_status(dev);
-
-		val = ((s16)(val << 2) >> 2);
-		ret = sprintf(buf, "%d\n", val);
 	}
+	ret = status & 0x1F;
 
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16203_write_16bit(struct device *dev,
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
-	ret = adis16203_spi_write_reg_16(dev, this_attr->address, val);
+	if (status & ADIS16203_DIAG_STAT_SELFTEST_FAIL)
+		dev_err(&indio_dev->dev, "Self test failure\n");
+	if (status & ADIS16203_DIAG_STAT_SPI_FAIL)
+		dev_err(&indio_dev->dev, "SPI failure\n");
+	if (status & ADIS16203_DIAG_STAT_FLASH_UPT)
+		dev_err(&indio_dev->dev, "Flash update failed\n");
+	if (status & ADIS16203_DIAG_STAT_POWER_HIGH)
+		dev_err(&indio_dev->dev, "Power supply above 3.625V\n");
+	if (status & ADIS16203_DIAG_STAT_POWER_LOW)
+		dev_err(&indio_dev->dev, "Power supply below 3.15V\n");
 
 error_ret:
-	return ret ? ret : len;
+	return ret;
 }
 
-static int adis16203_reset(struct device *dev)
+static int adis16203_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16203_spi_write_reg_8(dev,
+	ret = adis16203_spi_write_reg_8(indio_dev,
 			ADIS16203_GLOB_CMD,
 			ADIS16203_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -253,23 +184,24 @@ static ssize_t adis16203_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	if (len < 1)
 		return -EINVAL;
 	switch (buf[0]) {
 	case '1':
 	case 'y':
 	case 'Y':
-		return adis16203_reset(dev);
+		return adis16203_reset(indio_dev);
 	}
 	return -EINVAL;
 }
 
-int adis16203_set_irq(struct device *dev, bool enable)
+int adis16203_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret = 0;
 	u16 msc;
 
-	ret = adis16203_spi_read_reg_16(dev, ADIS16203_MSC_CTRL, &msc);
+	ret = adis16203_spi_read_reg_16(indio_dev, ADIS16203_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -280,131 +212,195 @@ int adis16203_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16203_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16203_spi_write_reg_16(dev, ADIS16203_MSC_CTRL, msc);
-
-error_ret:
-	return ret;
-}
-
-static int adis16203_check_status(struct device *dev)
-{
-	u16 status;
-	int ret;
-
-	ret = adis16203_spi_read_reg_16(dev, ADIS16203_DIAG_STAT, &status);
-	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
-		goto error_ret;
-	}
-	ret = status & 0x1F;
-
-	if (status & ADIS16203_DIAG_STAT_SELFTEST_FAIL)
-		dev_err(dev, "Self test failure\n");
-	if (status & ADIS16203_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
-	if (status & ADIS16203_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
-	if (status & ADIS16203_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 3.625V\n");
-	if (status & ADIS16203_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 3.15V\n");
+	ret = adis16203_spi_write_reg_16(indio_dev, ADIS16203_MSC_CTRL, msc);
 
 error_ret:
 	return ret;
 }
 
-static int adis16203_self_test(struct device *dev)
+static int adis16203_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16203_spi_write_reg_16(dev,
+	ret = adis16203_spi_write_reg_16(indio_dev,
 			ADIS16203_MSC_CTRL,
 			ADIS16203_MSC_CTRL_SELF_TEST_EN);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
-	adis16203_check_status(dev);
+	adis16203_check_status(indio_dev);
 
 err_ret:
 	return ret;
 }
 
-static int adis16203_initial_setup(struct adis16203_state *st)
+static int adis16203_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16203_set_irq(dev, false);
+	ret = adis16203_set_irq(indio_dev, false);
 	if (ret) {
-		dev_err(dev, "disable irq failed");
+		dev_err(&indio_dev->dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16203_self_test(dev);
+	ret = adis16203_self_test(indio_dev);
 	if (ret) {
-		dev_err(dev, "self test failure");
+		dev_err(&indio_dev->dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16203_check_status(dev);
+	ret = adis16203_check_status(indio_dev);
 	if (ret) {
-		adis16203_reset(dev);
-		dev_err(dev, "device not playing ball -> reset");
+		adis16203_reset(indio_dev);
+		dev_err(&indio_dev->dev, "device not playing ball -> reset");
 		msleep(ADIS16203_STARTUP_DELAY);
-		ret = adis16203_check_status(dev);
+		ret = adis16203_check_status(indio_dev);
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
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16203_read_12bit_unsigned,
-		ADIS16203_SUPPLY_OUT);
-static IIO_CONST_ATTR(in0_supply_scale, "0.00122");
-static IIO_DEV_ATTR_IN_RAW(1, adis16203_read_12bit_unsigned,
-		ADIS16203_AUX_ADC);
-static IIO_CONST_ATTR(in1_scale, "0.00061");
-
-static IIO_DEV_ATTR_INCLI_X(adis16203_read_14bit_signed,
-		ADIS16203_XINCL_OUT);
-static IIO_DEV_ATTR_INCLI_Y(adis16203_read_14bit_signed,
-		ADIS16203_YINCL_OUT);
-static IIO_DEV_ATTR_INCLI_X_OFFSET(S_IWUSR | S_IRUGO,
-		adis16203_read_14bit_signed,
-		adis16203_write_16bit,
-		ADIS16203_INCL_NULL);
-static IIO_CONST_ATTR(incli_scale, "0.025");
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16203_read_temp);
-static IIO_CONST_ATTR(temp_offset, "25");
-static IIO_CONST_ATTR(temp_scale, "-0.47");
+enum adis16203_chan {
+	in_supply,
+	in_aux,
+	incli_x,
+	incli_y,
+	temp,
+};
+
+static u8 adis16203_addresses[5][2] = {
+	[in_supply] = { ADIS16203_SUPPLY_OUT },
+	[in_aux] = { ADIS16203_AUX_ADC },
+	[incli_x] = { ADIS16203_XINCL_OUT, ADIS16203_INCL_NULL},
+	[incli_y] = { ADIS16203_YINCL_OUT },
+	[temp] = { ADIS16203_TEMP_OUT }
+};
+
+static int adis16203_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	/* currently only one writable parameter which keeps this simple */
+	u8 addr = adis16203_addresses[chan->address][1];
+	return adis16203_spi_write_reg_16(indio_dev, addr, val & 0x3FFF);
+}
+
+static int adis16203_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	int ret;
+	int bits;
+	u8 addr;
+	s16 val16;
+	switch (mask) {
+	case 0:
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16203_addresses[chan->address][0];
+		ret = adis16203_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret)
+			return ret;
+
+		if (val16 & ADIS16203_ERROR_ACTIVE) {
+			ret = adis16203_check_status(indio_dev);
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
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = 25000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		*val = 25;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		bits = 14;
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16203_addresses[chan->address][1];
+		ret = adis16203_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		val16 &= (1 << bits) - 1;
+		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		*val = val16;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct iio_chan_spec adis16203_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_supply, ADIS16203_SCAN_SUPPLY,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 in_aux, ADIS16203_SCAN_AUX_ADC,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 incli_x, ADIS16203_SCAN_INCLI_X,
+		 IIO_ST('s', 14, 16, 0), 0),
+	/* Fixme: Not what it appears to be - see data sheet */
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 incli_y, ADIS16203_SCAN_INCLI_Y,
+		 IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 temp, ADIS16203_SCAN_TEMP,
+		 IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(5),
+};
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16203_write_reset, 0);
 
 static struct attribute *adis16203_attributes[] = {
-	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
-	&iio_const_attr_in0_supply_scale.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_const_attr_in1_scale.dev_attr.attr,
-	&iio_dev_attr_incli_x_raw.dev_attr.attr,
-	&iio_dev_attr_incli_y_raw.dev_attr.attr,
-	&iio_dev_attr_incli_x_offset.dev_attr.attr,
-	&iio_const_attr_incli_scale.dev_attr.attr,
 	NULL
 };
 
@@ -445,6 +441,10 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16203_attribute_group;
+	st->indio_dev->channels = adis16203_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
+	st->indio_dev->read_raw = &adis16203_read_raw;
+	st->indio_dev->write_raw = &adis16203_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -458,7 +458,9 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = adis16203_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  adis16203_channels,
+					  ARRAY_SIZE(adis16203_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -471,7 +473,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16203_initial_setup(st);
+	ret = adis16203_initial_setup(st->indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
@@ -479,7 +481,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16203_remove_trigger(st->indio_dev);
 error_uninitialize_ring:
-	adis16203_uninitialize_ring(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unreg_ring_funcs:
 	adis16203_unconfigure_ring(st->indio_dev);
 error_free_dev:
@@ -502,10 +504,8 @@ static int adis16203_remove(struct spi_device *spi)
 	struct adis16203_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
 	adis16203_remove_trigger(indio_dev);
-	adis16203_uninitialize_ring(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
 	kfree(st->tx);
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index cdd0aff..a21a71d 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -17,46 +17,6 @@
 #include "../trigger.h"
 #include "adis16203.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16203_SCAN_SUPPLY, ADIS16203_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
-static IIO_SCAN_EL_C(in0, ADIS16203_SCAN_AUX_ADC, ADIS16203_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16203_SCAN_TEMP, ADIS16203_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_C(incli_x, ADIS16203_SCAN_INCLI_X,
-		     ADIS16203_XINCL_OUT, NULL);
-static IIO_SCAN_EL_C(incli_y, ADIS16203_SCAN_INCLI_Y,
-		     ADIS16203_YINCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(incli, s, 14, 16);
-static IIO_SCAN_EL_TIMESTAMP(5);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16203_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
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
-static struct attribute_group adis16203_scan_el_group = {
-	.attrs = adis16203_scan_el_attrs,
-	.name = "scan_elements",
-};
-
 /**
  * adis16203_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
@@ -162,7 +122,6 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16203_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -170,11 +129,11 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
-	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
+	iio_scan_mask_set(ring, ADIS16203_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16203_SCAN_TEMP);
+	iio_scan_mask_set(ring, ADIS16203_SCAN_AUX_ADC);
+	iio_scan_mask_set(ring, ADIS16203_SCAN_INCLI_X);
+	iio_scan_mask_set(ring, ADIS16203_SCAN_INCLI_Y);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
@@ -200,13 +159,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-int adis16203_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16203_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index b554049..72710f8 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -33,7 +33,7 @@ static int adis16203_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16203_set_irq(&st->indio_dev->dev, state);
+	return adis16203_set_irq(st->indio_dev, state);
 }
 
 int adis16203_probe_trigger(struct iio_dev *indio_dev)
-- 
1.7.3.4
