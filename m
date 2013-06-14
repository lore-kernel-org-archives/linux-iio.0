Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1053 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751294Ab3FNP6g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:36 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] staging:iio:ad7291: Simplify threshold register lookup
Date: Fri, 14 Jun 2013 17:58:25 +0200
Message-Id: <1371225508-32190-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD7291 register map is nicely uniform and we can easily compute the
threshold register address for a certain channel using simple math instead of
using a look-up table.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 121 ++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 5bb1963..bf8d689 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -39,33 +39,9 @@
 #define AD7291_VOLTAGE			0x01
 #define AD7291_T_SENSE			0x02
 #define AD7291_T_AVERAGE		0x03
-#define AD7291_CH0_DATA_HIGH		0x04
-#define AD7291_CH0_DATA_LOW		0x05
-#define AD7291_CH0_HYST			0x06
-#define AD7291_CH1_DATA_HIGH		0x07
-#define AD7291_CH1_DATA_LOW		0x08
-#define AD7291_CH1_HYST			0x09
-#define AD7291_CH2_DATA_HIGH		0x0A
-#define AD7291_CH2_DATA_LOW		0x0B
-#define AD7291_CH2_HYST			0x0C
-#define AD7291_CH3_DATA_HIGH		0x0D
-#define AD7291_CH3_DATA_LOW		0x0E
-#define AD7291_CH3_HYST			0x0F
-#define AD7291_CH4_DATA_HIGH		0x10
-#define AD7291_CH4_DATA_LOW		0x11
-#define AD7291_CH4_HYST			0x12
-#define AD7291_CH5_DATA_HIGH		0x13
-#define AD7291_CH5_DATA_LOW		0x14
-#define AD7291_CH5_HYST			0x15
-#define AD7291_CH6_DATA_HIGH		0x16
-#define AD7291_CH6_DATA_LOW		0x17
-#define AD7291_CH6_HYST			0x18
-#define AD7291_CH7_DATA_HIGH		0x19
-#define AD7291_CH7_DATA_LOW		0x1A
-#define AD7291_CH7_HYST			0x2B
-#define AD7291_T_SENSE_HIGH		0x1C
-#define AD7291_T_SENSE_LOW		0x1D
-#define AD7291_T_SENSE_HYST		0x1E
+#define AD7291_DATA_HIGH(x)		((x) * 3 + 0x4)
+#define AD7291_DATA_LOW(x)		((x) * 3 + 0x5)
+#define AD7291_HYST(x)			((x) * 3 + 0x6)
 #define AD7291_VOLTAGE_ALERT_STATUS	0x1F
 #define AD7291_T_ALERT_STATUS		0x20
 
@@ -232,31 +208,31 @@ static inline ssize_t ad7291_set_hyst(struct device *dev,
 static IIO_DEVICE_ATTR(in_temp0_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad7291_show_hyst, ad7291_set_hyst,
-		       AD7291_T_SENSE_HYST);
+		       AD7291_HYST(8));
 static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH0_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(0));
 static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH1_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(1));
 static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH2_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(2));
 static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH3_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(3));
 static IIO_DEVICE_ATTR(in_voltage4_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH4_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(4));
 static IIO_DEVICE_ATTR(in_voltage5_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH5_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(5));
 static IIO_DEVICE_ATTR(in_voltage6_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH6_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(6));
 static IIO_DEVICE_ATTR(in_voltage7_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_CH7_HYST);
+		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(7));
 
 static struct attribute *ad7291_event_attributes[] = {
 	&iio_dev_attr_in_temp0_thresh_both_hyst_raw.dev_attr.attr,
@@ -271,52 +247,46 @@ static struct attribute *ad7291_event_attributes[] = {
 	NULL,
 };
 
-/* high / low */
-static u8 ad7291_limit_regs[9][2] = {
-	{ AD7291_CH0_DATA_HIGH, AD7291_CH0_DATA_LOW },
-	{ AD7291_CH1_DATA_HIGH, AD7291_CH1_DATA_LOW },
-	{ AD7291_CH2_DATA_HIGH, AD7291_CH2_DATA_LOW },
-	{ AD7291_CH3_DATA_HIGH, AD7291_CH3_DATA_LOW }, /* FIXME: ? */
-	{ AD7291_CH4_DATA_HIGH, AD7291_CH4_DATA_LOW },
-	{ AD7291_CH5_DATA_HIGH, AD7291_CH5_DATA_LOW },
-	{ AD7291_CH6_DATA_HIGH, AD7291_CH6_DATA_LOW },
-	{ AD7291_CH7_DATA_HIGH, AD7291_CH7_DATA_LOW },
-	/* temp */
-	{ AD7291_T_SENSE_HIGH, AD7291_T_SENSE_LOW },
-};
+static unsigned int ad7291_threshold_reg(u64 event_code)
+{
+	unsigned int offset;
+
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	case IIO_VOLTAGE:
+		offset = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+		break;
+	case IIO_TEMP:
+		offset = 8;
+		break;
+	default:
+	    return 0;
+	}
+
+	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
+		return AD7291_DATA_LOW(offset);
+	else
+		return AD7291_DATA_HIGH(offset);
+}
 
 static int ad7291_read_event_value(struct iio_dev *indio_dev,
 				   u64 event_code,
 				   int *val)
 {
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-
 	int ret;
-	u8 reg;
 	u16 uval;
 	s16 signval;
 
+	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(event_code), &uval);
+	if (ret < 0)
+		return ret;
+
 	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
-		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)]
-			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			   IIO_EV_DIR_RISING)];
-
-		ret = ad7291_i2c_read(chip, reg, &uval);
-		if (ret < 0)
-			return ret;
 		*val = uval & AD7291_VALUE_MASK;
 		return 0;
-
 	case IIO_TEMP:
-		reg = ad7291_limit_regs[8]
-			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			   IIO_EV_DIR_RISING)];
-
-		ret = ad7291_i2c_read(chip, reg, &signval);
-		if (ret < 0)
-			return ret;
-		signval = (s16)((signval & AD7291_VALUE_MASK) << 4) >> 4;
+		signval = (s16)((uval & AD7291_VALUE_MASK) << 4) >> 4;
 		*val = signval;
 		return 0;
 	default:
@@ -329,28 +299,21 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 				    int val)
 {
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-	u8 reg;
-	s16 signval;
 
 	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		if (val > AD7291_VALUE_MASK || val < 0)
 			return -EINVAL;
-		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)]
-			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			   IIO_EV_DIR_RISING)];
-		return ad7291_i2c_write(chip, reg, val);
+		break;
 	case IIO_TEMP:
 		if (val > 2047 || val < -2048)
 			return -EINVAL;
-		reg = ad7291_limit_regs[8]
-			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			   IIO_EV_DIR_RISING)];
-		signval = val;
-		return ad7291_i2c_write(chip, reg, *(u16 *)&signval);
+		break;
 	default:
 		return -EINVAL;
-	};
+	}
+
+	return ad7291_i2c_write(chip, ad7291_threshold_reg(event_code), val);
 }
 
 static int ad7291_read_event_config(struct iio_dev *indio_dev,
-- 
1.8.0

