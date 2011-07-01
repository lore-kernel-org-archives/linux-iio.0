Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 22/25] staging:iio:accel:adis16220 iio_chan_spec conversion.
Date: Fri,  1 Jul 2011 11:11:13 +0100
Message-Id: <1309515076-12323-23-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I still have numerous issues with this driver and it
needs a substantial rewrite.

Whilst doing this patch at least one bug has been fixed (temp
reading didn't have an address) and a number of missing channel
info elements added.

Untested!

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16220_core.c |  342 +++++++++++++++++-----------
 1 files changed, 211 insertions(+), 131 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index bf9ba07..075e40f 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -6,9 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -16,12 +13,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "accel.h"
-#include "../adc/adc.h"
 
 #include "adis16220.h"
 
@@ -29,16 +23,15 @@
 
 /**
  * adis16220_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16220_spi_write_reg_8(struct device *dev,
+static int adis16220_spi_write_reg_8(struct iio_dev *indio_dev,
 		u8 reg_address,
 		u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16220_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -53,18 +46,17 @@ static int adis16220_spi_write_reg_8(struct device *dev,
 
 /**
  * adis16220_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev:  iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16220_spi_write_reg_16(struct device *dev,
+static int adis16220_spi_write_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 value)
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16220_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
@@ -77,7 +69,6 @@ static int adis16220_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.delay_usecs = 35,
 		},
 	};
@@ -99,17 +90,16 @@ static int adis16220_spi_write_reg_16(struct device *dev,
 
 /**
  * adis16220_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: iio device associated with child of actual device
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16220_spi_read_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 *val)
+static int adis16220_spi_read_reg_16(struct iio_dev *indio_dev,
+				     u8 lower_reg_address,
+				     u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16220_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -149,52 +139,23 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adis16220_spi_read_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf,
-		unsigned bits)
-{
-	int ret;
-	s16 val = 0;
-	unsigned shift = 16 - bits;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16220_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (ret)
-		return ret;
-
-	val = ((s16)(val << shift) >> shift);
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t adis16220_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16220_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
 static ssize_t adis16220_read_16bit(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	ssize_t ret;
+	s16 val = 0;
 
 	/* Take the iio_dev status lock */
 	mutex_lock(&indio_dev->mlock);
-	ret =  adis16220_spi_read_signed(dev, attr, buf, 16);
+	ret = adis16220_spi_read_reg_16(indio_dev, this_attr->address,
+					(u16 *)&val);
 	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
+	if (ret)
+		return ret;
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t adis16220_write_16bit(struct device *dev,
@@ -202,6 +163,7 @@ static ssize_t adis16220_write_16bit(struct device *dev,
 		const char *buf,
 		size_t len)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	long val;
@@ -209,34 +171,34 @@ static ssize_t adis16220_write_16bit(struct device *dev,
 	ret = strict_strtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = adis16220_spi_write_reg_16(dev, this_attr->address, val);
+	ret = adis16220_spi_write_reg_16(indio_dev, this_attr->address, val);
 
 error_ret:
 	return ret ? ret : len;
 }
 
-static int adis16220_capture(struct device *dev)
+static int adis16220_capture(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16220_spi_write_reg_16(dev,
+	ret = adis16220_spi_write_reg_16(indio_dev,
 			ADIS16220_GLOB_CMD,
 			0xBF08); /* initiates a manual data capture */
 	if (ret)
-		dev_err(dev, "problem beginning capture");
+		dev_err(&indio_dev->dev, "problem beginning capture");
 
 	msleep(10); /* delay for capture to finish */
 
 	return ret;
 }
 
-static int adis16220_reset(struct device *dev)
+static int adis16220_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16220_spi_write_reg_8(dev,
+	ret = adis16220_spi_write_reg_8(indio_dev,
 			ADIS16220_GLOB_CMD,
 			ADIS16220_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&indio_dev->dev, "problem resetting device");
 
 	return ret;
 }
@@ -245,72 +207,84 @@ static ssize_t adis16220_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return adis16220_reset(dev) == 0 ? len : -EIO;
-	}
-	return -1;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+	if (!val)
+		return -EINVAL;
+
+	ret = adis16220_reset(indio_dev);
+	if (ret)
+		return ret;
+	return len;
 }
 
 static ssize_t adis16220_write_capture(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return adis16220_capture(dev) == 0 ? len : -EIO;
-	}
-	return -1;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+	if (!val)
+		return -EINVAL;
+	ret = adis16220_capture(indio_dev);
+	if (ret)
+		return ret;
+
+	return len;
 }
 
-static int adis16220_check_status(struct device *dev)
+static int adis16220_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
 	int ret;
 
-	ret = adis16220_spi_read_reg_16(dev, ADIS16220_DIAG_STAT, &status);
+	ret = adis16220_spi_read_reg_16(indio_dev, ADIS16220_DIAG_STAT,
+					&status);
 
 	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
+		dev_err(&indio_dev->dev, "Reading status failed\n");
 		goto error_ret;
 	}
 	ret = status & 0x7F;
 
 	if (status & ADIS16220_DIAG_STAT_VIOLATION)
-		dev_err(dev, "Capture period violation/interruption\n");
+		dev_err(&indio_dev->dev,
+			"Capture period violation/interruption\n");
 	if (status & ADIS16220_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
+		dev_err(&indio_dev->dev, "SPI failure\n");
 	if (status & ADIS16220_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
+		dev_err(&indio_dev->dev, "Flash update failed\n");
 	if (status & ADIS16220_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 3.625V\n");
+		dev_err(&indio_dev->dev, "Power supply above 3.625V\n");
 	if (status & ADIS16220_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 3.15V\n");
+		dev_err(&indio_dev->dev, "Power supply below 3.15V\n");
 
 error_ret:
 	return ret;
 }
 
-static int adis16220_self_test(struct device *dev)
+static int adis16220_self_test(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16220_spi_write_reg_16(dev,
+	ret = adis16220_spi_write_reg_16(indio_dev,
 			ADIS16220_MSC_CTRL,
 			ADIS16220_MSC_CTRL_SELF_TEST_EN);
 	if (ret) {
-		dev_err(dev, "problem starting self test");
+		dev_err(&indio_dev->dev, "problem starting self test");
 		goto err_ret;
 	}
 
-	adis16220_check_status(dev);
+	adis16220_check_status(indio_dev);
 
 err_ret:
 	return ret;
@@ -319,24 +293,23 @@ err_ret:
 static int adis16220_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &indio_dev->dev;
 
 	/* Do self test */
-	ret = adis16220_self_test(dev);
+	ret = adis16220_self_test(indio_dev);
 	if (ret) {
-		dev_err(dev, "self test failure");
+		dev_err(&indio_dev->dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16220_check_status(dev);
+	ret = adis16220_check_status(indio_dev);
 	if (ret) {
-		adis16220_reset(dev);
-		dev_err(dev, "device not playing ball -> reset");
+		adis16220_reset(indio_dev);
+		dev_err(&indio_dev->dev, "device not playing ball -> reset");
 		msleep(ADIS16220_STARTUP_DELAY);
-		ret = adis16220_check_status(dev);
+		ret = adis16220_check_status(indio_dev);
 		if (ret) {
-			dev_err(dev, "giving up");
+			dev_err(&indio_dev->dev, "giving up");
 			goto err_ret;
 		}
 	}
@@ -381,7 +354,7 @@ static ssize_t adis16220_capture_buffer_read(struct iio_dev *indio_dev,
 		count = ADIS16220_CAPTURE_SIZE - off;
 
 	/* write the begin position of capture buffer */
-	ret = adis16220_spi_write_reg_16(&indio_dev->dev,
+	ret = adis16220_spi_write_reg_16(indio_dev,
 					ADIS16220_CAPT_PNTR,
 					off > 1);
 	if (ret)
@@ -480,24 +453,6 @@ static struct bin_attribute adc2_bin = {
 	.size = ADIS16220_CAPTURE_SIZE,
 };
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16220_read_12bit_unsigned,
-		ADIS16220_CAPT_SUPPLY);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(0, supply, "0.0012207");
-static IIO_DEV_ATTR_ACCEL(adis16220_read_16bit, ADIS16220_CAPT_BUFA);
-static IIO_DEVICE_ATTR(accel_peak_raw, S_IRUGO, adis16220_read_16bit,
-		NULL, ADIS16220_CAPT_PEAKA);
-static IIO_DEV_ATTR_ACCEL_OFFSET(S_IWUSR | S_IRUGO,
-		adis16220_read_16bit,
-		adis16220_write_16bit,
-		ADIS16220_ACCL_NULL);
-static IIO_CONST_ATTR_ACCEL_SCALE("0.18704223545");
-static IIO_DEV_ATTR_TEMP_RAW(adis16220_read_12bit_unsigned);
-static IIO_CONST_ATTR_TEMP_OFFSET("25");
-static IIO_CONST_ATTR_TEMP_SCALE("-0.47");
-
-static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF1);
-static IIO_DEV_ATTR_IN_RAW(2, adis16220_read_16bit, ADIS16220_CAPT_BUF2);
-
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
 		adis16220_write_reset, 0);
 
@@ -514,21 +469,142 @@ static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
 		adis16220_write_16bit,
 		ADIS16220_CAPT_PNTR);
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100200");
+enum adis16220_channel {
+	in_supply, in_1, in_2, accel, temp
+};
+
+struct adis16220_address_spec {
+	u8 addr;
+	u8 bits;
+	bool sign;
+};
+
+/* Address / bits / signed */
+static const struct adis16220_address_spec adis16220_addresses[][3] = {
+	[in_supply] =	{ { ADIS16220_CAPT_SUPPLY,	12, 0 }, },
+	[in_1] =	{ { ADIS16220_CAPT_BUF1,	16, 1 },
+			  { ADIS16220_AIN1_NULL,	16, 1 },
+			  { ADIS16220_CAPT_PEAK1,	16, 1 }, },
+	[in_2] =	{ { ADIS16220_CAPT_BUF2,	16, 1 },
+			  { ADIS16220_AIN2_NULL,	16, 1 },
+			  { ADIS16220_CAPT_PEAK2,	16, 1 }, },
+	[accel] =	{ { ADIS16220_CAPT_BUFA,	16, 1 },
+			  { ADIS16220_ACCL_NULL,	16, 1 },
+			  { ADIS16220_CAPT_PEAKA,	16, 1 }, },
+	[temp] =	{ { ADIS16220_CAPT_TEMP,	12, 0 }, }
+};
+
+static int adis16220_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	int ret = -EINVAL;
+	int addrind = 0;
+	u16 uval;
+	s16 sval;
+	u8 bits;
+
+	switch (mask) {
+	case 0:
+		addrind = 0;
+		break;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		if (chan->type == IIO_TEMP) {
+			*val = 25;
+			return IIO_VAL_INT;
+		}
+		addrind = 1;
+		break;
+	case (1 << IIO_CHAN_INFO_PEAK_SEPARATE):
+		addrind = 2;
+		break;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		*val = 0;
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val2 = -470000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val2 = 1887042;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_IN:
+			if (chan->channel == 0)
+				*val2 = 0012221;
+			else /* Should really be dependent on VDD */
+				*val2 = 305;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+	if (adis16220_addresses[chan->address][addrind].sign) {
+		ret = adis16220_spi_read_reg_16(indio_dev,
+						adis16220_addresses[chan
+								    ->address]
+						[addrind].addr,
+						&sval);
+		if (ret)
+			return ret;
+		bits = adis16220_addresses[chan->address][addrind].bits;
+		sval &= (1 << bits) - 1;
+		sval = (s16)(sval << (16 - bits)) >> (16 - bits);
+		*val = sval;
+		return IIO_VAL_INT;
+	} else {
+		ret = adis16220_spi_read_reg_16(indio_dev,
+						adis16220_addresses[chan
+								    ->address]
+						[addrind].addr,
+						&uval);
+		if (ret)
+			return ret;
+		bits = adis16220_addresses[chan->address][addrind].bits;
+		uval &= (1 << bits) - 1;
+		*val = uval;
+		return IIO_VAL_INT;
+	}
+}
+
+static const struct iio_chan_spec adis16220_channels[] = {
+	{
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in_supply,
+	}, {
+		.type = IIO_ACCEL,
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
+			     (1 << IIO_CHAN_INFO_PEAK_SEPARATE),
+		.address = accel,
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = temp,
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in_1,
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 2,
+		.address = in_2,
+	}
+};
 
 static struct attribute *adis16220_attributes[] = {
-	&iio_dev_attr_in0_supply_raw.dev_attr.attr,
-	&iio_const_attr_in0_supply_scale.dev_attr.attr,
-	&iio_dev_attr_accel_raw.dev_attr.attr,
-	&iio_dev_attr_accel_offset.dev_attr.attr,
-	&iio_dev_attr_accel_peak_raw.dev_attr.attr,
-	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in2_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_capture.dev_attr.attr,
 	&iio_dev_attr_capture_count.dev_attr.attr,
@@ -542,7 +618,9 @@ static const struct attribute_group adis16220_attribute_group = {
 static const struct iio_info adis16220_info = {
 	.attrs = &adis16220_attribute_group,
 	.driver_module = THIS_MODULE,
+	.read_raw = &adis16220_read_raw,
 };
+
 static int __devinit adis16220_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -567,6 +645,8 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16220_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adis16220_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16220_channels);
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.3.4
