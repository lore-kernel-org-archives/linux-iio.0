Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 61/70] staging:iio:accel:adis16240 move to chan_spec based setup.
Date: Sun, 17 Apr 2011 20:06:34 +0100
Message-Id: <1303067203-4894-62-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

For clean drivers its easier to convert to chan_spec based
registration than to work around the scan_el attributes
going away.

Some minor cleanups done whilst here.

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16240.h         |    2 +-
 drivers/staging/iio/accel/adis16240_core.c    |  360 +++++++++++++++----------
 drivers/staging/iio/accel/adis16240_ring.c    |   55 +----
 drivers/staging/iio/accel/adis16240_trigger.c |    2 +-
 4 files changed, 220 insertions(+), 199 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index 364aabf..162b1f4 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -141,7 +141,7 @@ struct adis16240_state {
 	struct mutex			buf_lock;
 };
 
-int adis16240_set_irq(struct device *dev, bool enable);
+int adis16240_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 6350c7c..80a571a 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -28,20 +28,19 @@
 
 #define DRIVER_NAME		"adis16240"
 
-static int adis16240_check_status(struct device *dev);
+static int adis16240_check_status(struct iio_dev *indio_dev);
 
 /**
  * adis16240_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio_dev associated with device
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16240_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
+static int adis16240_spi_write_reg_8(struct iio_dev *indio_dev,
+				     u8 reg_address,
+				     u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -56,18 +55,17 @@ static int adis16240_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16240_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio_dev for this device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16240_spi_write_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 value)
+static int adis16240_spi_write_reg_16(struct iio_dev *indio_dev,
+				      u8 lower_reg_address,
+				      u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -80,7 +78,6 @@ static int adis16240_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 35,
 		},
 	};
@@ -102,17 +99,16 @@ static int adis16240_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16240_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio_dev for this device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16240_spi_read_reg_16(struct device *dev,
+static int adis16240_spi_read_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -159,61 +155,30 @@ static ssize_t adis16240_spi_read_signed(struct device *dev,
 		char *buf,
 		unsigned bits)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	int ret;
 	s16 val = 0;
 	unsigned shift = 16 - bits;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = adis16240_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
+	ret = adis16240_spi_read_reg_16(indio_dev,
+					this_attr->address, (u16 *)&val);
 	if (ret)
 		return ret;
 
 	if (val & ADIS16240_ERROR_ACTIVE)
-		adis16240_check_status(dev);
+		adis16240_check_status(indio_dev);
 
 	val = ((s16)(val << shift) >> shift);
 	return sprintf(buf, "%d\n", val);
 }
 
-static ssize_t adis16240_read_10bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16240_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16240_ERROR_ACTIVE)
-		adis16240_check_status(dev);
-
-	return sprintf(buf, "%u\n", val & 0x03FF);
-}
-
-static ssize_t adis16240_read_10bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16240_spi_read_signed(dev, attr, buf, 10);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
 static ssize_t adis16240_read_12bit_signed(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	ssize_t ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
 	/* Take the iio_dev status lock */
 	mutex_lock(&indio_dev->mlock);
@@ -223,32 +188,14 @@ static ssize_t adis16240_read_12bit_signed(struct device *dev,
 	return ret;
 }
 
-static ssize_t adis16240_write_16bit(struct device *dev,
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
-	ret = adis16240_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
-static int adis16240_reset(struct device *dev)
+static int adis16240_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16240_spi_write_reg_8(dev,
+	ret = adis16240_spi_write_reg_8(indio_dev,
 			ADIS16240_GLOB_CMD,
 			ADIS16240_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -257,23 +204,26 @@ static ssize_t adis16240_write_reset(struct device *dev,
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
-		return adis16240_reset(dev);
+		return adis16240_reset(indio_dev);
 	}
 	return -EINVAL;
 }
 
-int adis16240_set_irq(struct device *dev, bool enable)
+int adis16240_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret = 0;
 	u16 msc;
 
-	ret = adis16240_spi_read_reg_16(dev, ADIS16240_MSC_CTRL, &msc);
+	ret = adis16240_spi_read_reg_16(indio_dev,
+					ADIS16240_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -284,37 +234,40 @@ int adis16240_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16240_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16240_spi_write_reg_16(dev, ADIS16240_MSC_CTRL, msc);
+	ret = adis16240_spi_write_reg_16(indio_dev,
+					 ADIS16240_MSC_CTRL, msc);
 
 error_ret:
 	return ret;
 }
 
-static int adis16240_self_test(struct device *dev)
+static int adis16240_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16240_spi_write_reg_16(dev,
+	ret = adis16240_spi_write_reg_16(indio_dev,
 			ADIS16240_MSC_CTRL,
 			ADIS16240_MSC_CTRL_SELF_TEST_EN);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
 	msleep(ADIS16240_STARTUP_DELAY);
 
-	adis16240_check_status(dev);
+	adis16240_check_status(indio_dev);
 
 err_ret:
 	return ret;
 }
 
-static int adis16240_check_status(struct device *dev)
+static int adis16240_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
 	int ret;
+	struct device *dev = &indio_dev->dev;
 
-	ret = adis16240_spi_read_reg_16(dev, ADIS16240_DIAG_STAT, &status);
+	ret = adis16240_spi_read_reg_16(indio_dev,
+					ADIS16240_DIAG_STAT, &status);
 
 	if (ret < 0) {
 		dev_err(dev, "Reading status failed\n");
@@ -337,109 +290,214 @@ error_ret:
 	return ret;
 }
 
-static int adis16240_initial_setup(struct adis16240_state *st)
+static int adis16240_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16240_set_irq(dev, false);
+	ret = adis16240_set_irq(indio_dev, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16240_self_test(dev);
+	ret = adis16240_self_test(indio_dev);
 	if (ret) {
 		dev_err(dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16240_check_status(dev);
+	ret = adis16240_check_status(indio_dev);
 	if (ret) {
-		adis16240_reset(dev);
+		adis16240_reset(indio_dev);
 		dev_err(dev, "device not playing ball -> reset");
 		msleep(ADIS16240_STARTUP_DELAY);
-		ret = adis16240_check_status(dev);
+		ret = adis16240_check_status(indio_dev);
 		if (ret) {
 			dev_err(dev, "giving up");
 			goto err_ret;
 		}
 	}
 
-	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
-			st->us->chip_select, st->us->irq);
-
 err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16240_read_10bit_unsigned,
-		ADIS16240_SUPPLY_OUT);
-static IIO_DEV_ATTR_IN_RAW(1, adis16240_read_10bit_signed,
-		ADIS16240_AUX_ADC);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.00488");
-
-static IIO_CONST_ATTR_ACCEL_SCALE("0.50406181");
-static IIO_CONST_ATTR(accel_peak_scale, "6.6292954");
-static IIO_DEV_ATTR_ACCEL_X(adis16240_read_10bit_signed,
-		ADIS16240_XACCL_OUT);
-static IIO_DEVICE_ATTR(accel_x_peak_raw, S_IRUGO,
-		       adis16240_read_10bit_signed, NULL,
-		       ADIS16240_XPEAK_OUT);
-static IIO_DEV_ATTR_ACCEL_Y(adis16240_read_10bit_signed,
-		ADIS16240_YACCL_OUT);
-static IIO_DEVICE_ATTR(accel_y_peak_raw, S_IRUGO,
-		       adis16240_read_10bit_signed, NULL,
-		       ADIS16240_YPEAK_OUT);
-static IIO_DEV_ATTR_ACCEL_Z(adis16240_read_10bit_signed,
-		ADIS16240_ZACCL_OUT);
-static IIO_DEVICE_ATTR(accel_z_peak_raw, S_IRUGO,
-		       adis16240_read_10bit_signed, NULL,
-		       ADIS16240_ZPEAK_OUT);
-
 static IIO_DEVICE_ATTR(accel_xyz_squared_peak_raw, S_IRUGO,
 		       adis16240_read_12bit_signed, NULL,
 		       ADIS16240_XYZPEAK_OUT);
-static IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(S_IWUSR | S_IRUGO,
-		adis16240_read_10bit_signed,
-		adis16240_write_16bit,
-		ADIS16240_XACCL_OFF);
-static IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(S_IWUSR | S_IRUGO,
-		adis16240_read_10bit_signed,
-		adis16240_write_16bit,
-		ADIS16240_YACCL_OFF);
-static IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(S_IWUSR | S_IRUGO,
-		adis16240_read_10bit_signed,
-		adis16240_write_16bit,
-		ADIS16240_ZACCL_OFF);
-static IIO_DEV_ATTR_TEMP_RAW(adis16240_read_10bit_unsigned);
-static IIO_CONST_ATTR_TEMP_SCALE("0.244");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16240_write_reset, 0);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
 
+enum adis16240_chan {
+	in_supply,
+	in_aux,
+	accel_x,
+	accel_y,
+	accel_z,
+	temp,
+};
+
+static const u8 adis16240_addresses[6][3] = {
+	[in_supply] = { ADIS16240_SUPPLY_OUT },
+	[in_aux] = { ADIS16240_AUX_ADC },
+	[accel_x] = { ADIS16240_XACCL_OUT, ADIS16240_XACCL_OFF,
+		      ADIS16240_XPEAK_OUT },
+	[accel_y] = { ADIS16240_YACCL_OUT, ADIS16240_YACCL_OFF,
+		      ADIS16240_YPEAK_OUT },
+	[accel_z] = { ADIS16240_ZACCL_OUT, ADIS16240_ZACCL_OFF,
+		      ADIS16240_ZPEAK_OUT },
+	[temp] = { ADIS16240_TEMP_OUT },
+};
+
+static int adis16240_read_raw(struct iio_dev *indio_dev,
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
+		addr = adis16240_addresses[chan->address][0];
+		ret = adis16240_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret)
+			return ret;
+
+		if (val16 & ADIS16240_ERROR_ACTIVE) {
+			ret = adis16240_check_status(indio_dev);
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
+				*val2 = 4880;
+			else
+				return -EINVAL;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 244000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = 504062;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case (1 << IIO_CHAN_INFO_PEAK_SCALE_SHARED):
+		*val = 6;
+		*val2 = 629295;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		*val = 25;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		bits = 10;
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16240_addresses[chan->address][1];
+		ret = adis16240_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		val16 &= (1 << bits) - 1;
+		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		*val = val16;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_PEAK_SEPARATE):
+		bits = 10;
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16240_addresses[chan->address][2];
+		ret = adis16240_spi_read_reg_16(indio_dev, addr, &val16);
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
+static int adis16240_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	int bits = 10;
+	s16 val16;
+	u8 addr;
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16240_addresses[chan->address][1];
+		return adis16240_spi_write_reg_16(indio_dev, addr, val16);
+	}
+	return -EINVAL;
+}
+
+static struct iio_chan_spec adis16240_channels[] = {
+	IIO_CHAN_EV(IIO_IN, 0,
+		    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		    in_supply, ADIS16240_SCAN_SUPPLY,
+		    IIO_ST('u', 10, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 1,
+		    0,
+		    in_aux, ADIS16240_SCAN_AUX_ADC,
+		    IIO_ST('u', 10, 16, 0), 0),
+	IIO_CHAN_EV(IIO_ACCEL, 'x',
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		    accel_x, ADIS16240_SCAN_ACC_X,
+		    IIO_ST('s', 10, 16, 0), 0),
+	IIO_CHAN_EV(IIO_ACCEL, 'y',
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		    accel_y, ADIS16240_SCAN_ACC_Y,
+		    IIO_ST('s', 10, 16, 0), 0),
+	IIO_CHAN_EV(IIO_ACCEL, 'z',
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED) |
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		    accel_z, ADIS16240_SCAN_ACC_Z,
+		    IIO_ST('s', 10, 16, 0), 0),
+	IIO_CHAN_EV(IIO_TEMP, 0,
+		    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		    temp, ADIS16240_SCAN_TEMP,
+		    IIO_ST('u', 10, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(6)
+};
+
 static struct attribute *adis16240_attributes[] = {
-	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
-	&iio_const_attr_in0_supply_scale.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_const_attr_accel_peak_scale.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_x_peak_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_y_peak_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_z_peak_raw.dev_attr.attr,
 	&iio_dev_attr_accel_xyz_squared_peak_raw.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	NULL
@@ -483,6 +541,10 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	st->indio_dev->name = spi->dev.driver->name;
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16240_attribute_group;
+	st->indio_dev->channels = adis16240_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
+	st->indio_dev->read_raw = &adis16240_read_raw;
+	st->indio_dev->write_raw = &adis16240_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -496,7 +558,9 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  adis16240_channels,
+					  ARRAY_SIZE(adis16240_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -509,7 +573,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16240_initial_setup(st);
+	ret = adis16240_initial_setup(st->indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index c289b66..ae9100c 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -17,48 +17,6 @@
 #include "../trigger.h"
 #include "adis16240.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16240_SCAN_SUPPLY,
-		ADIS16240_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 10, 16);
-static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, ADIS16240_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, ADIS16240_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, ADIS16240_ZACCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 10, 16);
-static IIO_SCAN_EL_C(in0, ADIS16240_SCAN_AUX_ADC, ADIS16240_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 10, 16);
-static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, ADIS16240_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 10, 16);
-static IIO_SCAN_EL_TIMESTAMP(6);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16240_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
-	&iio_scan_el_accel_x.dev_attr.attr,
-	&iio_const_attr_accel_x_index.dev_attr.attr,
-	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_const_attr_accel_y_index.dev_attr.attr,
-	&iio_scan_el_accel_z.dev_attr.attr,
-	&iio_const_attr_accel_z_index.dev_attr.attr,
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
-static struct attribute_group adis16240_scan_el_group = {
-	.attrs = adis16240_scan_el_attrs,
-	.name = "scan_elements",
-};
-
 /**
  * adis16240_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
@@ -156,7 +114,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16240_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -164,12 +121,12 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
+	iio_scan_mask_set(ring, ADIS16240_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16240_SCAN_ACC_X);
+	iio_scan_mask_set(ring, ADIS16240_SCAN_ACC_Y);
+	iio_scan_mask_set(ring, ADIS16240_SCAN_ACC_Z);
+	iio_scan_mask_set(ring, ADIS16240_SCAN_AUX_ADC);
+	iio_scan_mask_set(ring, ADIS16240_SCAN_TEMP);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 55e2145..d5bda92 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -42,7 +42,7 @@ static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16240_set_irq(&st->indio_dev->dev, state);
+	return adis16240_set_irq(st->indio_dev, state);
 }
 
 int adis16240_probe_trigger(struct iio_dev *indio_dev)
-- 
1.7.3.4
