Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 37/70] staging:iio:adis16400 move to irq based triggers and channel spec channel registration.
Date: Sun, 17 Apr 2011 20:06:10 +0100
Message-Id: <1303067203-4894-38-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400.h         |    7 +-
 drivers/staging/iio/imu/adis16400_core.c    |  424 ++++++++++++++-------------
 drivers/staging/iio/imu/adis16400_ring.c    |  160 +++--------
 drivers/staging/iio/imu/adis16400_trigger.c |   56 ++---
 4 files changed, 282 insertions(+), 365 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index e328bcc..1a7e23e 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -126,9 +126,6 @@
 /**
  * struct adis16400_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -137,8 +134,6 @@
  **/
 struct adis16400_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
@@ -146,7 +141,7 @@ struct adis16400_state {
 	struct mutex			buf_lock;
 };
 
-int adis16400_set_irq(struct device *dev, bool enable);
+int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 33c5f3c..fe7ccfd 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -38,7 +38,7 @@
 
 #define DRIVER_NAME		"adis16400"
 
-static int adis16400_check_status(struct device *dev);
+static int adis16400_check_status(struct iio_dev *indio_dev);
 
 /* At the moment the spi framework doesn't allow global setting of cs_change.
  * It's in the likely to be added comment at the top of spi.h.
@@ -51,12 +51,11 @@ static int adis16400_check_status(struct device *dev);
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16400_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
+static int adis16400_spi_write_reg_8(struct iio_dev *indio_dev,
+				     u8 reg_address,
+				     u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -76,13 +75,12 @@ static int adis16400_spi_write_reg_8(struct device *dev,
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16400_spi_write_reg_16(struct device *dev,
+static int adis16400_spi_write_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -114,17 +112,16 @@ static int adis16400_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16400_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16400_spi_read_reg_16(struct device *dev,
+static int adis16400_spi_read_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -163,100 +160,15 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16400_spi_read_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf,
-		unsigned bits)
-{
-	int ret;
-	s16 val = 0;
-	unsigned shift = 16 - bits;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16400_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16400_ERROR_ACTIVE)
-		adis16400_check_status(dev);
-	val = ((s16)(val << shift) >> shift);
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t adis16400_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16400_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16400_ERROR_ACTIVE)
-		adis16400_check_status(dev);
-
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16400_read_14bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16400_spi_read_signed(dev, attr, buf, 14);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16400_read_12bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16400_spi_read_signed(dev, attr, buf, 12);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16400_write_16bit(struct device *dev,
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
-	ret = adis16400_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
 static ssize_t adis16400_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	int ret, len = 0;
 	u16 t;
 	int sps;
-	ret = adis16400_spi_read_reg_16(dev,
+	ret = adis16400_spi_read_reg_16(indio_dev,
 			ADIS16400_SMPL_PRD,
 			&t);
 	if (ret)
@@ -293,7 +205,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 	else
 		st->us->max_speed_hz = ADIS16400_SPI_FAST;
 
-	ret = adis16400_spi_write_reg_8(dev,
+	ret = adis16400_spi_write_reg_8(indio_dev,
 			ADIS16400_SMPL_PRD,
 			t);
 
@@ -302,14 +214,14 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
-static int adis16400_reset(struct device *dev)
+static int adis16400_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16400_spi_write_reg_8(dev,
+	ret = adis16400_spi_write_reg_8(indio_dev,
 			ADIS16400_GLOB_CMD,
 			ADIS16400_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -318,22 +230,24 @@ static ssize_t adis16400_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
 	if (len < 1)
 		return -1;
 	switch (buf[0]) {
 	case '1':
 	case 'y':
 	case 'Y':
-		return adis16400_reset(dev);
+		return adis16400_reset(indio_dev);
 	}
 	return -1;
 }
 
-int adis16400_set_irq(struct device *dev, bool enable)
+int adis16400_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret;
 	u16 msc;
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_MSC_CTRL, &msc);
+	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -343,7 +257,7 @@ int adis16400_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16400_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16400_spi_write_reg_16(dev, ADIS16400_MSC_CTRL, msc);
+	ret = adis16400_spi_write_reg_16(indio_dev, ADIS16400_MSC_CTRL, msc);
 	if (ret)
 		goto error_ret;
 
@@ -352,41 +266,45 @@ error_ret:
 }
 
 /* Power down the device */
-static int adis16400_stop_device(struct device *dev)
+static int adis16400_stop_device(struct iio_dev *indio_dev)
 {
 	int ret;
 	u16 val = ADIS16400_SLP_CNT_POWER_OFF;
 
-	ret = adis16400_spi_write_reg_16(dev, ADIS16400_SLP_CNT, val);
+	ret = adis16400_spi_write_reg_16(indio_dev, ADIS16400_SLP_CNT, val);
 	if (ret)
-		dev_err(dev, "problem with turning device off: SLP_CNT");
+		dev_err(&indio_dev->dev,
+			"problem with turning device off: SLP_CNT");
 
 	return ret;
 }
 
-static int adis16400_self_test(struct device *dev)
+static int adis16400_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16400_spi_write_reg_16(dev,
+	ret = adis16400_spi_write_reg_16(indio_dev,
 			ADIS16400_MSC_CTRL,
 			ADIS16400_MSC_CTRL_MEM_TEST);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
+
 	msleep(ADIS16400_MTEST_DELAY);
-	adis16400_check_status(dev);
+	adis16400_check_status(indio_dev);
 
 err_ret:
 	return ret;
 }
 
-static int adis16400_check_status(struct device *dev)
+static int adis16400_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
 	int ret;
+	struct device *dev = &indio_dev->dev;
 
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_DIAG_STAT, &status);
+	ret = adis16400_spi_read_reg_16(indio_dev,
+					ADIS16400_DIAG_STAT, &status);
 
 	if (ret < 0) {
 		dev_err(dev, "Reading status failed\n");
@@ -440,33 +358,34 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 	spi_setup(st->us);
 
 	/* Disable IRQ */
-	ret = adis16400_set_irq(dev, false);
+	ret = adis16400_set_irq(st->indio_dev, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16400_self_test(dev);
+	ret = adis16400_self_test(st->indio_dev);
 	if (ret) {
 		dev_err(dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16400_check_status(dev);
+	ret = adis16400_check_status(st->indio_dev);
 	if (ret) {
-		adis16400_reset(dev);
+		adis16400_reset(st->indio_dev);
 		dev_err(dev, "device not playing ball -> reset");
 		msleep(ADIS16400_STARTUP_DELAY);
-		ret = adis16400_check_status(dev);
+		ret = adis16400_check_status(st->indio_dev);
 		if (ret) {
 			dev_err(dev, "giving up");
 			goto err_ret;
 		}
 	}
 
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_PRODUCT_ID, &prod_id);
+	ret = adis16400_spi_read_reg_16(st->indio_dev,
+					ADIS16400_PRODUCT_ID, &prod_id);
 	if (ret)
 		goto err_ret;
 
@@ -478,7 +397,8 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 			prod_id, st->us->chip_select, st->us->irq);
 
 	/* use high spi speed if possible */
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_SMPL_PRD, &smp_prd);
+	ret = adis16400_spi_read_reg_16(st->indio_dev,
+					ADIS16400_SMPL_PRD, &smp_prd);
 	if (!ret && (smp_prd & ADIS16400_SMPL_PRD_DIV_MASK) < 0x0A) {
 		st->us->max_speed_hz = ADIS16400_SPI_SLOW;
 		spi_setup(st->us);
@@ -490,58 +410,6 @@ err_ret:
 	return ret;
 }
 
-#define ADIS16400_DEV_ATTR_CALIBBIAS(_channel, _reg)		\
-	IIO_DEV_ATTR_##_channel##_CALIBBIAS(S_IWUSR | S_IRUGO,	\
-			adis16400_read_12bit_signed,		\
-			adis16400_write_16bit,			\
-			_reg)
-
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_X, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_YGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_ZGYRO_OFF);
-
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_X, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_YACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_ZACCL_OFF);
-
-
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16400_read_14bit_signed,
-		ADIS16400_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.002418 V");
-
-static IIO_DEV_ATTR_GYRO_X(adis16400_read_14bit_signed,
-		ADIS16400_XGYRO_OUT);
-static IIO_DEV_ATTR_GYRO_Y(adis16400_read_14bit_signed,
-		ADIS16400_YGYRO_OUT);
-static IIO_DEV_ATTR_GYRO_Z(adis16400_read_14bit_signed,
-		ADIS16400_ZGYRO_OUT);
-static IIO_CONST_ATTR(gyro_scale, "0.0008726646");
-
-static IIO_DEV_ATTR_ACCEL_X(adis16400_read_14bit_signed,
-		ADIS16400_XACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Y(adis16400_read_14bit_signed,
-		ADIS16400_YACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Z(adis16400_read_14bit_signed,
-		ADIS16400_ZACCL_OUT);
-static IIO_CONST_ATTR(accel_scale, "0.0326561445");
-
-static IIO_DEV_ATTR_MAGN_X(adis16400_read_14bit_signed,
-		ADIS16400_XMAGN_OUT);
-static IIO_DEV_ATTR_MAGN_Y(adis16400_read_14bit_signed,
-		ADIS16400_YMAGN_OUT);
-static IIO_DEV_ATTR_MAGN_Z(adis16400_read_14bit_signed,
-		ADIS16400_ZMAGN_OUT);
-static IIO_CONST_ATTR(magn_scale, "0.0005 Gs");
-
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16400_read_12bit_signed);
-static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
-static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
-
-static IIO_DEV_ATTR_IN_RAW(1, adis16400_read_12bit_unsigned,
-		ADIS16400_AUX_ADC);
-static IIO_CONST_ATTR(in1_scale, "0.000806 V");
-
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16400_read_frequency,
 		adis16400_write_frequency);
@@ -552,32 +420,184 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
 static IIO_CONST_ATTR_NAME("adis16400");
 
+enum adis16400_chan {
+	in_supply,
+	gyro_x,
+	gyro_y,
+	gyro_z,
+	accel_x,
+	accel_y,
+	accel_z,
+	magn_x,
+	magn_y,
+	magn_z,
+	temp,
+	in1
+};
+
+static u8 adis16400_addresses[12][2] = {
+	[in_supply] = { ADIS16400_SUPPLY_OUT, 0 },
+	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
+	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
+	[gyro_z] = { ADIS16400_ZGYRO_OUT, ADIS16400_ZGYRO_OFF },
+	[accel_x] = { ADIS16400_XACCL_OUT, ADIS16400_XACCL_OFF },
+	[accel_y] = { ADIS16400_YACCL_OUT, ADIS16400_YACCL_OFF },
+	[accel_z] = { ADIS16400_ZACCL_OUT, ADIS16400_ZACCL_OFF },
+	[magn_x] = { ADIS16400_XMAGN_OUT, 0 },
+	[magn_y] = { ADIS16400_YMAGN_OUT, 0 },
+	[magn_z] = { ADIS16400_ZMAGN_OUT, 0 },
+	[temp] = { ADIS16400_TEMP_OUT, 0 },
+	[in1] = { ADIS16400_AUX_ADC , 0 },
+};
+
+static int adis16400_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	int ret;
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		mutex_lock(&indio_dev->mlock);
+		ret = adis16400_spi_write_reg_16(indio_dev,
+				adis16400_addresses[chan->address][1],
+				val);
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adis16400_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val,
+			      int *val2,
+			      long mask)
+{
+	int ret;
+	s16 val16;
+	int shift;
+
+	switch (mask) {
+	case 0:
+		mutex_lock(&indio_dev->mlock);
+		ret = adis16400_spi_read_reg_16(indio_dev,
+				adis16400_addresses[chan->address][0],
+				&val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		val16 &= (1 << chan->scan_type.realbits) - 1;
+		if (chan->scan_type.sign == 's') {
+			shift = 16 - chan->scan_type.realbits;
+			val16 = (s16)(val16 << shift) >> shift;
+		}
+		*val = val16;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		switch (chan->type) {
+		case IIO_GYRO:
+			*val = 0;
+			*val2 = 873;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_IN:
+			*val = 0;
+			if (chan->channel == 0)
+				*val2 = 2418;
+			else
+				*val2 = 806;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = 32656;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_MAGN:
+			*val = 0;
+			*val2 = 500;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 140000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		mutex_lock(&indio_dev->mlock);
+		ret = adis16400_spi_read_reg_16(indio_dev,
+				adis16400_addresses[chan->address][1],
+				&val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		val16 = ((val16 & 0xFFF) << 4) >> 4;
+		*val = val16;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		/* currently only temperature */
+		*val = 198;
+		*val2 = 160000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct iio_chan_spec adis16400_channels[] = {
+	IIO_CHAN_EV(IIO_IN, 0,
+		    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		    in_supply, ADIS16400_SCAN_SUPPLY,
+		    IIO_ST('u', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_GYRO, 'x',
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_GYRO, 'y',
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_GYRO, 'z',
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_ACCEL, 'x',
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_ACCEL, 'y',
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_ACCEL, 'z',
+		    (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_MAGN, 'x',
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    magn_x, ADIS16400_SCAN_MAGN_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_MAGN, 'y',
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    magn_y, ADIS16400_SCAN_MAGN_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_MAGN, 'z',
+		    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		    magn_z, ADIS16400_SCAN_MAGN_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN_EV(IIO_TEMP, 0,
+		    (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		    temp, ADIS16400_SCAN_TEMP, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 1,
+		    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		    in1, ADIS16400_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(12)
+};
+
 static struct attribute *adis16400_attributes[] = {
-	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
-	&iio_const_attr_in0_supply_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_const_attr_gyro_scale.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_magn_x_raw.dev_attr.attr,
-	&iio_dev_attr_magn_y_raw.dev_attr.attr,
-	&iio_dev_attr_magn_z_raw.dev_attr.attr,
-	&iio_const_attr_magn_scale.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
@@ -622,6 +642,10 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16400_attribute_group;
+	st->indio_dev->channels = adis16400_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(adis16400_channels);
+	st->indio_dev->read_raw = &adis16400_read_raw;
+	st->indio_dev->write_raw = &adis16400_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -682,12 +706,10 @@ static int adis16400_remove(struct spi_device *spi)
 	struct adis16400_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	ret = adis16400_stop_device(&(indio_dev->dev));
+	ret = adis16400_stop_device(indio_dev);
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
 	adis16400_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 	adis16400_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index da28cb4..f5b9bb8 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -17,93 +17,6 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-static IIO_SCAN_EL_C(in0_supply, ADIS16400_SCAN_SUPPLY,
-		     ADIS16400_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0_supply, u, 14, 16);
-
-static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, ADIS16400_XGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_y, ADIS16400_SCAN_GYRO_Y, ADIS16400_YGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_z, ADIS16400_SCAN_GYRO_Z, ADIS16400_ZGYRO_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
-
-static IIO_SCAN_EL_C(accel_x, ADIS16400_SCAN_ACC_X, ADIS16400_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16400_SCAN_ACC_Y, ADIS16400_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16400_SCAN_ACC_Z, ADIS16400_ZACCL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
-
-static IIO_SCAN_EL_C(magn_x, ADIS16400_SCAN_MAGN_X, ADIS16400_XMAGN_OUT, NULL);
-static IIO_SCAN_EL_C(magn_y, ADIS16400_SCAN_MAGN_Y, ADIS16400_YMAGN_OUT, NULL);
-static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, ADIS16400_ZMAGN_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(magn, s, 14, 16);
-
-static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, ADIS16400_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
-
-static IIO_SCAN_EL_C(in1, ADIS16400_SCAN_ADC_0, ADIS16400_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in1, u, 12, 16);
-
-static IIO_SCAN_EL_TIMESTAMP(12);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16400_scan_el_attrs[] = {
-	&iio_scan_el_in0_supply.dev_attr.attr,
-	&iio_const_attr_in0_supply_index.dev_attr.attr,
-	&iio_const_attr_in0_supply_type.dev_attr.attr,
-	&iio_scan_el_gyro_x.dev_attr.attr,
-	&iio_const_attr_gyro_x_index.dev_attr.attr,
-	&iio_scan_el_gyro_y.dev_attr.attr,
-	&iio_const_attr_gyro_y_index.dev_attr.attr,
-	&iio_scan_el_gyro_z.dev_attr.attr,
-	&iio_const_attr_gyro_z_index.dev_attr.attr,
-	&iio_const_attr_gyro_type.dev_attr.attr,
-	&iio_scan_el_accel_x.dev_attr.attr,
-	&iio_const_attr_accel_x_index.dev_attr.attr,
-	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_const_attr_accel_y_index.dev_attr.attr,
-	&iio_scan_el_accel_z.dev_attr.attr,
-	&iio_const_attr_accel_z_index.dev_attr.attr,
-	&iio_const_attr_accel_type.dev_attr.attr,
-	&iio_scan_el_magn_x.dev_attr.attr,
-	&iio_const_attr_magn_x_index.dev_attr.attr,
-	&iio_scan_el_magn_y.dev_attr.attr,
-	&iio_const_attr_magn_y_index.dev_attr.attr,
-	&iio_scan_el_magn_z.dev_attr.attr,
-	&iio_const_attr_magn_z_index.dev_attr.attr,
-	&iio_const_attr_magn_type.dev_attr.attr,
-	&iio_scan_el_temp.dev_attr.attr,
-	&iio_const_attr_temp_index.dev_attr.attr,
-	&iio_const_attr_temp_type.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_const_attr_in1_index.dev_attr.attr,
-	&iio_const_attr_in1_type.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16400_scan_el_group = {
-	.attrs = adis16400_scan_el_attrs,
-	.name = "scan_elements",
-};
-
-/**
- * adis16400_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void adis16400_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = time;
-	schedule_work(&st->work_trigger_to_ring);
-	/* Indicate that this interrupt is being handled */
-
-	/* Technically this is trigger related, but without this
-	 * handler running there is currently no way for the interrupt
-	 * to clear.
-	 */
-}
-
 /**
  * adis16400_spi_read_burst() - read all data registers
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
@@ -153,13 +66,12 @@ static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
-static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
+static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 {
-	struct adis16400_state *st
-		= container_of(work_s, struct adis16400_state,
-			       work_trigger_to_ring);
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
-
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0, j;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
@@ -168,11 +80,11 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
+		return -ENOMEM;
 	}
 
 	if (ring->scan_count)
-		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
+		if (adis16400_spi_read_burst(&indio_dev->dev, st->rx) >= 0)
 			for (; i < ring->scan_count; i++) {
 				j = __ffs(mask);
 				mask &= ~(1 << j);
@@ -182,20 +94,18 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
-
-	ring->access.store_to(ring,
-			(u8 *) data,
-			st->last_timestamp);
+		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
+	ring->access.store_to(indio_dev->ring, (u8 *) data, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
-	return;
+	return IRQ_HANDLED;
 }
 
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
@@ -203,9 +113,7 @@ void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16400_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16400_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16400_trigger_bh_to_ring);
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
@@ -216,7 +124,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16400_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -224,26 +131,37 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in0_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_magn_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_magn_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_magn_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in1.number);
-
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
-	if (ret)
+	iio_scan_mask_set(ring, ADIS16400_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_GYRO_X);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_GYRO_Y);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_GYRO_Z);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_ACC_X);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_ACC_Y);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_ACC_Z);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_MAGN_X);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_MAGN_Y);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_MAGN_Z);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_TEMP);
+	iio_scan_mask_set(ring, ADIS16400_SCAN_ADC_0);
+
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
+	indio_dev->pollfunc->thread = &adis16400_trigger_handler;
+	indio_dev->pollfunc->type = IRQF_ONESHOT;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "adis16400_consumer%d", indio_dev->id);
+	if (ret)
+		goto error_iio_free_pollfunc;
 
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-
+error_iio_free_pollfunc:
+	kfree(indio_dev->pollfunc);
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index afa5e74..b80ae94 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -12,16 +12,6 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-/**
- * adis16400_data_rdy_trig_poll() the event handler for the data rdy trig
- **/
-static irqreturn_t adis16400_data_rdy_trig_poll(int irq, void *private)
-{
-	disable_irq_nosync(irq);
-	iio_trigger_poll(private, iio_get_time_ns());
-	return IRQ_HANDLED;
-}
-
 static IIO_TRIGGER_NAME_ATTR;
 
 static struct attribute *adis16400_trigger_attrs[] = {
@@ -43,66 +33,58 @@ static int adis16400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16400_set_irq(&st->indio_dev->dev, state);
-}
-
-/**
- * adis16400_trig_try_reen() try renabling irq for data rdy trigger
- * @trig:	the datardy trigger
- **/
-static int adis16400_trig_try_reen(struct iio_trigger *trig)
-{
-	struct adis16400_state *st = trig->private_data;
-	enable_irq(st->us->irq);
-	/* irq reenabled so success! */
-	return 0;
+	return adis16400_set_irq(st->indio_dev, state);
 }
 
 int adis16400_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct adis16400_state *st = indio_dev->dev_data;
+	char *name;
 
-	st->trig = iio_allocate_trigger();
-	if (st->trig == NULL) {
+	name = kasprintf(GFP_KERNEL,
+			 "%s-dev%d",
+			 spi_get_device_id(st->us)->name,
+			 indio_dev->id);
+	if (name == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
+
+	st->trig = iio_allocate_trigger_named(name);
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_free_name;
+	}
+
 	ret = request_irq(st->us->irq,
-			  adis16400_data_rdy_trig_poll,
+			  &iio_trigger_generic_data_rdy_poll,
 			  IRQF_TRIGGER_RISING,
 			  "adis16400",
 			  st->trig);
 	if (ret)
 		goto error_free_trig;
-	st->trig->name = kasprintf(GFP_KERNEL,
-				   "adis16400-dev%d",
-				   indio_dev->id);
-	if (!st->trig->name) {
-		ret = -ENOMEM;
-		goto error_free_irq;
-	}
+
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
 	st->trig->set_trigger_state = &adis16400_data_rdy_trigger_set_state;
-	st->trig->try_reenable = &adis16400_trig_try_reen;
 	st->trig->control_attrs = &adis16400_trigger_attr_group;
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
 	indio_dev->trig = st->trig;
 	if (ret)
-		goto error_free_trig_name;
+		goto error_free_irq;
 
 	return 0;
 
-error_free_trig_name:
-	kfree(st->trig->name);
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
 	iio_free_trigger(st->trig);
+error_free_name:
+	kfree(name);
 error_ret:
 	return ret;
 }
-- 
1.7.3.4
