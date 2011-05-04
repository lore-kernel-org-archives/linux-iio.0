Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 69/99] staging:iio:gyro:adis16260 move to chan_spec based setup.
Date: Wed,  4 May 2011 12:58:41 +0100
Message-Id: <1304510351-10922-70-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

For clean drivers its easier to convert to chan_spec based
registration than to work around the scan_el attributes
going away.

Some minor cleanups done whilst here.

Untested.
V3: rebase fixup and make attribute_group static.

V2: IIO_CHAN macro updates.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260.h         |    2 +-
 drivers/staging/iio/gyro/adis16260_core.c    |  450 +++++++++++++-------------
 drivers/staging/iio/gyro/adis16260_ring.c    |   51 +---
 drivers/staging/iio/gyro/adis16260_trigger.c |    2 +-
 4 files changed, 239 insertions(+), 266 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index 5325c68..702dc98 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -102,7 +102,7 @@ struct adis16260_state {
 	unsigned			negate:1;
 };
 
-int adis16260_set_irq(struct device *dev, bool enable);
+int adis16260_set_irq(struct iio_dev *indio_dev, bool enable);
 
 #ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 3366bd0..cb20a8a 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -28,20 +28,19 @@
 
 #define DRIVER_NAME		"adis16260"
 
-static int adis16260_check_status(struct device *dev);
+static int adis16260_check_status(struct iio_dev *indio_dev);
 
 /**
  * adis16260_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio_dev for the device
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16260_spi_write_reg_8(struct device *dev,
+static int adis16260_spi_write_reg_8(struct iio_dev *indio_dev,
 		u8 reg_address,
 		u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -56,18 +55,17 @@ static int adis16260_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16260_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio_dev for the device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16260_spi_write_reg_16(struct device *dev,
+static int adis16260_spi_write_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -80,7 +78,6 @@ static int adis16260_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 20,
 		},
 	};
@@ -102,17 +99,16 @@ static int adis16260_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16260_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio_dev for the device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16260_spi_read_reg_16(struct device *dev,
+static int adis16260_spi_read_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -126,7 +122,6 @@ static int adis16260_spi_read_reg_16(struct device *dev,
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 30,
 		},
 	};
@@ -152,92 +147,6 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16260_spi_read_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf,
-		unsigned bits)
-{
-	int ret;
-	s16 val = 0;
-	unsigned shift = 16 - bits;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16260_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16260_ERROR_ACTIVE)
-		adis16260_check_status(dev);
-	val = ((s16)(val << shift) >> shift);
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t adis16260_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16260_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16260_ERROR_ACTIVE)
-		adis16260_check_status(dev);
-
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16260_read_12bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16260_spi_read_signed(dev, attr, buf, 12);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16260_read_14bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16260_spi_read_signed(dev, attr, buf, 14);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16260_write_16bit(struct device *dev,
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
-	ret = adis16260_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
 static ssize_t adis16260_read_frequency_available(struct device *dev,
 						  struct device_attribute *attr,
 						  char *buf)
@@ -259,7 +168,7 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 	int ret, len = 0;
 	u16 t;
 	int sps;
-	ret = adis16260_spi_read_reg_16(dev,
+	ret = adis16260_spi_read_reg_16(indio_dev,
 			ADIS16260_SMPL_PRD,
 			&t);
 	if (ret)
@@ -305,7 +214,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		st->us->max_speed_hz = ADIS16260_SPI_SLOW;
 	else
 		st->us->max_speed_hz = ADIS16260_SPI_FAST;
-	ret = adis16260_spi_write_reg_8(dev,
+	ret = adis16260_spi_write_reg_8(indio_dev,
 			ADIS16260_SMPL_PRD,
 			t);
 
@@ -314,33 +223,14 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t adis16260_read_gyro_scale(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
-	ssize_t ret = 0;
-
-	if (st->negate)
-		ret = sprintf(buf, "-");
-	/* Take the iio_dev status lock */
-	if (spi_get_device_id(st->us)->driver_data)
-		ret += sprintf(buf + ret, "%s\n", "0.00031974432");
-	else
-		ret += sprintf(buf + ret, "%s\n", "0.00127862821");
-
-	return ret;
-}
-
-static int adis16260_reset(struct device *dev)
+static int adis16260_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16260_spi_write_reg_8(dev,
+	ret = adis16260_spi_write_reg_8(indio_dev,
 			ADIS16260_GLOB_CMD,
 			ADIS16260_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -349,22 +239,23 @@ static ssize_t adis16260_write_reset(struct device *dev,
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
-		return adis16260_reset(dev);
+		return adis16260_reset(indio_dev);
 	}
 	return -EINVAL;
 }
 
-int adis16260_set_irq(struct device *dev, bool enable)
+int adis16260_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret;
 	u16 msc;
-	ret = adis16260_spi_read_reg_16(dev, ADIS16260_MSC_CTRL, &msc);
+	ret = adis16260_spi_read_reg_16(indio_dev, ADIS16260_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
 
@@ -374,7 +265,7 @@ int adis16260_set_irq(struct device *dev, bool enable)
 	else
 		msc &= ~ADIS16260_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis16260_spi_write_reg_16(dev, ADIS16260_MSC_CTRL, msc);
+	ret = adis16260_spi_write_reg_16(indio_dev, ADIS16260_MSC_CTRL, msc);
 	if (ret)
 		goto error_ret;
 
@@ -383,41 +274,44 @@ error_ret:
 }
 
 /* Power down the device */
-static int adis16260_stop_device(struct device *dev)
+static int adis16260_stop_device(struct iio_dev *indio_dev)
 {
 	int ret;
 	u16 val = ADIS16260_SLP_CNT_POWER_OFF;
 
-	ret = adis16260_spi_write_reg_16(dev, ADIS16260_SLP_CNT, val);
+	ret = adis16260_spi_write_reg_16(indio_dev, ADIS16260_SLP_CNT, val);
 	if (ret)
-		dev_err(dev, "problem with turning device off: SLP_CNT");
+		dev_err(&indio_dev->dev, "problem with turning device off: SLP_CNT");
 
 	return ret;
 }
 
-static int adis16260_self_test(struct device *dev)
+static int adis16260_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16260_spi_write_reg_16(dev,
+	ret = adis16260_spi_write_reg_16(indio_dev,
 			ADIS16260_MSC_CTRL,
 			ADIS16260_MSC_CTRL_MEM_TEST);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
-	adis16260_check_status(dev);
+	adis16260_check_status(indio_dev);
 
 err_ret:
 	return ret;
 }
 
-static int adis16260_check_status(struct device *dev)
+static int adis16260_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
 	int ret;
+	struct device *dev = &indio_dev->dev;
 
-	ret = adis16260_spi_read_reg_16(dev, ADIS16260_DIAG_STAT, &status);
+	ret = adis16260_spi_read_reg_16(indio_dev,
+					ADIS16260_DIAG_STAT,
+					&status);
 
 	if (ret < 0) {
 		dev_err(dev, "Reading status failed\n");
@@ -443,119 +337,233 @@ error_ret:
 	return ret;
 }
 
-static int adis16260_initial_setup(struct adis16260_state *st)
+static int adis16260_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16260_set_irq(dev, false);
+	ret = adis16260_set_irq(indio_dev, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16260_self_test(dev);
+	ret = adis16260_self_test(indio_dev);
 	if (ret) {
 		dev_err(dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16260_check_status(dev);
+	ret = adis16260_check_status(indio_dev);
 	if (ret) {
-		adis16260_reset(dev);
+		adis16260_reset(indio_dev);
 		dev_err(dev, "device not playing ball -> reset");
 		msleep(ADIS16260_STARTUP_DELAY);
-		ret = adis16260_check_status(dev);
+		ret = adis16260_check_status(indio_dev);
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
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply,
-				adis16260_read_12bit_unsigned,
-				ADIS16260_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.0018315");
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16260_read_12bit_unsigned);
-static IIO_CONST_ATTR_TEMP_OFFSET("25");
-static IIO_CONST_ATTR_TEMP_SCALE("0.1453");
-
-static IIO_DEV_ATTR_IN_RAW(1, adis16260_read_12bit_unsigned,
-		ADIS16260_AUX_ADC);
-static IIO_CONST_ATTR(in1_scale, "0.0006105");
-
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16260_read_frequency,
 		adis16260_write_frequency);
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 
-
 static IIO_DEVICE_ATTR(sampling_frequency_available,
 		       S_IRUGO, adis16260_read_frequency_available, NULL, 0);
 
-#define ADIS16260_GYRO_ATTR_SET(axis)					\
-	IIO_DEV_ATTR_GYRO##axis(adis16260_read_14bit_signed,		\
-				ADIS16260_GYRO_OUT);			\
-	static IIO_DEV_ATTR_GYRO##axis##_SCALE(S_IRUGO,			\
-					adis16260_read_gyro_scale,	\
-					NULL,				\
-					0);				\
-	static IIO_DEV_ATTR_GYRO##axis##_CALIBSCALE(S_IRUGO | S_IWUSR,	\
-					adis16260_read_12bit_unsigned,	\
-					adis16260_write_16bit,		\
-					ADIS16260_GYRO_SCALE);		\
-	static IIO_DEV_ATTR_GYRO##axis##_CALIBBIAS(S_IWUSR | S_IRUGO,	\
-					adis16260_read_12bit_signed,	\
-					adis16260_write_16bit,		\
-					ADIS16260_GYRO_OFF);		\
-	static IIO_DEV_ATTR_ANGL##axis(adis16260_read_14bit_signed,	\
-				       ADIS16260_ANGL_OUT);
-
-static ADIS16260_GYRO_ATTR_SET();
-static ADIS16260_GYRO_ATTR_SET(_X);
-static ADIS16260_GYRO_ATTR_SET(_Y);
-static ADIS16260_GYRO_ATTR_SET(_Z);
-
-#define ADIS16260_ATTR_GROUP(axis)					\
-	struct attribute *adis16260_attributes##axis[] = {		\
-		&iio_dev_attr_in0_supply_raw.dev_attr.attr,		\
-		&iio_const_attr_in0_supply_scale.dev_attr.attr,		\
-		&iio_dev_attr_gyro##axis##_raw.dev_attr.attr,		\
-		&iio_dev_attr_gyro##axis##_scale.dev_attr.attr,		\
-		&iio_dev_attr_gyro##axis##_calibscale.dev_attr.attr,	\
-		&iio_dev_attr_gyro##axis##_calibbias.dev_attr.attr,	\
-		&iio_dev_attr_angl##axis##_raw.dev_attr.attr,		\
-		&iio_dev_attr_temp_raw.dev_attr.attr,			\
-		&iio_const_attr_temp_offset.dev_attr.attr,		\
-		&iio_const_attr_temp_scale.dev_attr.attr,		\
-		&iio_dev_attr_in1_raw.dev_attr.attr,			\
-		&iio_const_attr_in1_scale.dev_attr.attr,		\
-		&iio_dev_attr_sampling_frequency.dev_attr.attr,		\
-		&iio_dev_attr_sampling_frequency_available.dev_attr.attr, \
-		&iio_dev_attr_reset.dev_attr.attr,			\
-		NULL							\
-	};								\
-	static const struct attribute_group adis16260_attribute_group##axis \
-	= {								\
-		.attrs = adis16260_attributes##axis,			\
-	};
+enum adis16260_channel {
+	gyro,
+	temp,
+	in_supply,
+	in_aux,
+	angle,
+};
+#define ADIS16260_GYRO_CHANNEL_SET(axis, mod)				\
+	struct iio_chan_spec adis16260_channels_##axis[] = {		\
+		IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, mod,		\
+			 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |	\
+			 (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |	\
+			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 gyro, ADIS16260_SCAN_GYRO,			\
+			 IIO_ST('s', 14, 16, 0), 0),			\
+		IIO_CHAN(IIO_ANGL, 1, 0, 0, NULL, 0, mod,			\
+			 0,						\
+			 angle, ADIS16260_SCAN_ANGL,			\
+			 IIO_ST('u', 14, 16, 0), 0),			\
+		IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,			\
+			 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |		\
+			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 temp, ADIS16260_SCAN_TEMP,			\
+			 IIO_ST('u', 12, 16, 0), 0),			\
+		IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,			\
+			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 in_supply, ADIS16260_SCAN_SUPPLY,		\
+			 IIO_ST('u', 12, 16, 0), 0),			\
+		IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,			\
+			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 in_aux, ADIS16260_SCAN_AUX_ADC,		\
+			 IIO_ST('u', 12, 16, 0), 0),			\
+		IIO_CHAN_SOFT_TIMESTAMP(5)				\
+	}
+
+static const ADIS16260_GYRO_CHANNEL_SET(x, IIO_MOD_X);
+static const ADIS16260_GYRO_CHANNEL_SET(y, IIO_MOD_Y);
+static const ADIS16260_GYRO_CHANNEL_SET(z, IIO_MOD_Z);
+
+static const u8 adis16260_addresses[5][3] = {
+	[gyro] = { ADIS16260_GYRO_OUT,
+		   ADIS16260_GYRO_OFF,
+		   ADIS16260_GYRO_SCALE },
+	[angle] = { ADIS16260_ANGL_OUT },
+	[in_supply] = { ADIS16260_SUPPLY_OUT },
+	[in_aux] = { ADIS16260_AUX_ADC },
+	[temp] = { ADIS16260_TEMP_OUT },
+};
+static int adis16260_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	int ret;
+	int bits;
+	u8 addr;
+	s16 val16;
+
+	switch (mask) {
+	case 0:
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16260_addresses[chan->address][0];
+		ret = adis16260_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret)
+			return ret;
+
+		if (val16 & ADIS16260_ERROR_ACTIVE) {
+			ret = adis16260_check_status(indio_dev);
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
+		case IIO_GYRO:
+			*val = 0;
+			if (spi_get_device_id(st->us)->driver_data)
+				*val2 = 320;
+			else
+				*val2 = 1278;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_IN:
+			*val = 0;
+			if (chan->channel == 0)
+				*val2 = 18315;
+			else
+				*val2 = 610500;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 145300;
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
+		case IIO_GYRO:
+			bits = 12;
+			break;
+		default:
+			return -EINVAL;
+		};
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16260_addresses[chan->address][1];
+		ret = adis16260_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		val16 &= (1 << bits) - 1;
+		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		*val = val16;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		switch (chan->type) {
+		case IIO_GYRO:
+			bits = 12;
+			break;
+		default:
+			return -EINVAL;
+		};
+		mutex_lock(&indio_dev->mlock);
+		addr = adis16260_addresses[chan->address][2];
+		ret = adis16260_spi_read_reg_16(indio_dev, addr, &val16);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		*val = (1 << bits) - 1;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static int adis16260_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	int bits = 12;
+	s16 val16;
+	u8 addr;
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16260_addresses[chan->address][1];
+		return adis16260_spi_write_reg_16(indio_dev, addr, val16);
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16260_addresses[chan->address][2];
+		return adis16260_spi_write_reg_16(indio_dev, addr, val16);
+	}
+	return -EINVAL;
+}
 
-static ADIS16260_ATTR_GROUP();
-static ADIS16260_ATTR_GROUP(_x);
-static ADIS16260_ATTR_GROUP(_y);
-static ADIS16260_ATTR_GROUP(_z);
+static struct attribute *adis16260_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16260_attribute_group = {
+	.attrs = adis16260_attributes,
+};
 
 static int __devinit adis16260_probe(struct spi_device *spi)
 {
@@ -593,24 +601,28 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi_get_device_id(st->us)->name;
 	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->attrs = &adis16260_attribute_group;
+	st->indio_dev->num_channels
+		= ARRAY_SIZE(adis16260_channels_x);
 	if (pd && pd->direction)
 		switch (pd->direction) {
 		case 'x':
-			st->indio_dev->attrs = &adis16260_attribute_group_x;
+			st->indio_dev->channels = adis16260_channels_x;
 			break;
 		case 'y':
-			st->indio_dev->attrs = &adis16260_attribute_group_y;
+			st->indio_dev->channels = adis16260_channels_y;
 			break;
 		case 'z':
-			st->indio_dev->attrs = &adis16260_attribute_group_z;
+			st->indio_dev->channels = adis16260_channels_z;
 			break;
 		default:
-			st->indio_dev->attrs = &adis16260_attribute_group;
-			break;
+			return -EINVAL;
 		}
 	else
-		st->indio_dev->attrs = &adis16260_attribute_group;
+		st->indio_dev->channels = adis16260_channels_x;
 
+	st->indio_dev->read_raw = &adis16260_read_raw;
+	st->indio_dev->write_raw = &adis16260_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -623,7 +635,9 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  st->indio_dev->channels,
+					  ARRAY_SIZE(adis16260_channels_x));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -636,7 +650,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16260_initial_setup(st);
+	ret = adis16260_initial_setup(st->indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
@@ -668,7 +682,7 @@ static int adis16260_remove(struct spi_device *spi)
 	struct adis16260_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	ret = adis16260_stop_device(&(indio_dev->dev));
+	ret = adis16260_stop_device(indio_dev);
 	if (ret)
 		goto err_ret;
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 2806d83..12fbbf2 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -17,46 +17,6 @@
 #include "../trigger.h"
 #include "adis16260.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16260_SCAN_SUPPLY,
-		ADIS16260_SUPPLY_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
-static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, ADIS16260_GYRO_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
-static IIO_SCAN_EL_C(in0, ADIS16260_SCAN_AUX_ADC, ADIS16260_AUX_ADC, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
-static IIO_SCAN_EL_C(temp, ADIS16260_SCAN_TEMP, ADIS16260_TEMP_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, u, 12, 16);
-static IIO_SCAN_EL_C(angl, ADIS16260_SCAN_ANGL, ADIS16260_ANGL_OUT, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(angl, u, 14, 16);
-static IIO_SCAN_EL_TIMESTAMP(5);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *adis16260_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_const_attr_in_supply_index.dev_attr.attr,
-	&iio_const_attr_in_supply_type.dev_attr.attr,
-	&iio_scan_el_gyro.dev_attr.attr,
-	&iio_const_attr_gyro_index.dev_attr.attr,
-	&iio_const_attr_gyro_type.dev_attr.attr,
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_const_attr_in0_type.dev_attr.attr,
-	&iio_scan_el_temp.dev_attr.attr,
-	&iio_const_attr_temp_index.dev_attr.attr,
-	&iio_const_attr_temp_type.dev_attr.attr,
-	&iio_scan_el_angl.dev_attr.attr,
-	&iio_const_attr_angl_index.dev_attr.attr,
-	&iio_const_attr_angl_type.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16260_scan_el_group = {
-	.attrs = adis16260_scan_el_attrs,
-	.name = "scan_elements",
-};
 
 /**
  * adis16260_read_ring_data() read data registers which will be placed into ring
@@ -160,7 +120,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
 	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16260_scan_el_group;
 	ring->scan_timestamp = true;
 	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
@@ -168,11 +127,11 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	ring->owner = THIS_MODULE;
 
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_angl.number);
+	iio_scan_mask_set(ring, ADIS16260_SCAN_SUPPLY);
+	iio_scan_mask_set(ring, ADIS16260_SCAN_GYRO);
+	iio_scan_mask_set(ring, ADIS16260_SCAN_AUX_ADC);
+	iio_scan_mask_set(ring, ADIS16260_SCAN_TEMP);
+	iio_scan_mask_set(ring, ADIS16260_SCAN_ANGL);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 6b73927..228272e 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -33,7 +33,7 @@ static int adis16260_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16260_set_irq(&st->indio_dev->dev, state);
+	return adis16260_set_irq(indio_dev, state);
 }
 
 int adis16260_probe_trigger(struct iio_dev *indio_dev)
-- 
1.7.3.4
