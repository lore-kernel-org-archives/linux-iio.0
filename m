Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32788 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbbKJQHy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2015 11:07:54 -0500
Received: by wmec201 with SMTP id c201so141204282wme.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2015 08:07:53 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com, Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 2/4] iio: ina2xx: add SAMP_FREQ attribute.
Date: Tue, 10 Nov 2015 17:07:31 +0100
Message-Id: <1447171653-12756-3-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-iio.c | 51 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-iio.c b/drivers/iio/adc/ina2xx-iio.c
index 257d8d5..92169e1 100644
--- a/drivers/iio/adc/ina2xx-iio.c
+++ b/drivers/iio/adc/ina2xx-iio.c
@@ -42,7 +42,8 @@
 /* settings - depend on use case */
 #define INA219_CONFIG_DEFAULT           0x399F	/* PGA=8 */
 #define INA226_CONFIG_DEFAULT           0x4327
-#define INA226_DEFAULT_AVG		4
+#define INA226_DEFAULT_AVG              4
+#define INA226_DEFAULT_FREQ             454
 
 #define INA2XX_RSHUNT_DEFAULT           10000
 
@@ -51,6 +52,8 @@
 #define INA226_READ_AVG(reg)            (((reg) & INA226_AVG_RD_MASK) >> 9)
 #define INA226_SHIFT_AVG(val)           ((val) << 9)
 
+#define INA226_SFREQ_RD_MASK            0x01f8
+
 static struct regmap_config ina2xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -172,6 +175,10 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 		return ina2xx_get_value(chip, INA2XX_CALIBRATION, regval,
 					val, val2);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = chip->freq;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -216,6 +223,38 @@ static unsigned int ina226_set_average(struct ina2xx_chip_info *chip,
 	return 0;
 }
 
+/*
+ * Conversion times in uS
+ */
+static const int ina226_conv_time_tab[] = { 140, 204, 332, 588, 1100,
+	2116, 4156, 8244};
+
+static unsigned int ina226_set_frequency(struct ina2xx_chip_info *chip,
+					 unsigned int val,
+					 unsigned int *config)
+{
+	int bits;
+
+	if (val > 3550  || val < 50)
+		return -EINVAL;
+
+	/* integration time in uS, for both voltage channels */
+	val = DIV_ROUND_CLOSEST(1000000, 2 * val);
+
+	bits = find_closest(val, ina226_conv_time_tab,
+			    ARRAY_SIZE(ina226_conv_time_tab));
+
+	chip->period_us = 2 * ina226_conv_time_tab[bits];
+
+	chip->freq = DIV_ROUND_CLOSEST(1000000, chip->period_us);
+
+	*config &= ~INA226_SFREQ_RD_MASK;
+	*config |= (bits << 3) | (bits << 6);
+
+	return 0;
+}
+
+
 static int ina2xx_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -238,6 +277,11 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
 		ret = ina226_set_average(chip, val, &tmp);
 		break;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+
+		ret = ina226_set_frequency(chip, val, &tmp);
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
@@ -257,6 +301,7 @@ _err:
 	.channel = (_index), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
+					BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 				   BIT(IIO_CHAN_INFO_CALIBSCALE), \
 	.scan_index = (_index), \
 	.scan_type = { \
@@ -355,8 +400,10 @@ static int ina2xx_probe(struct i2c_client *client,
 
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
-	if (id->driver_data == ina226)
+	if (id->driver_data == ina226) {
 		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
+		ina226_set_frequency(chip, INA226_DEFAULT_FREQ, &val);
+	}
 
 	ret = ina2xx_init(chip, val);
 	if (ret < 0) {
-- 
1.9.1

