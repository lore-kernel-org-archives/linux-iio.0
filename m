Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56660 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdGYJLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2017 05:11:42 -0400
Date: Tue, 25 Jul 2017 11:11:14 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linus.walleij@linaro.org,
        yongjun_wei@trendmicro.com.cn, a.mathur@samsung.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bmp280: properly initialize device for humidity reading
Message-ID: <20170725091114.GA25223@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the device is not initialized at least once it happens that the humidity
reading is skipped, which means the special value 0x8000 is delivered.

For omitting this case the oversampling of the humidity must be set before
the oversampling of the temperature und pressure is set as written in the
datasheet of the BME280.

Furthermore proper error detection is added in case a skipped value is read
from the device. This is done also for pressure and temperature reading.
Especially it don't make sense to compensate this value and treat it as
regular value.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/bmp280-core.c | 27 ++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  5 +++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4d18826ac63c..d434e2c23833 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -281,6 +281,11 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	}
 
 	adc_temp = be32_to_cpu(tmp) >> 12;
+	if (adc_temp == BMP280_TEMP_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
 	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/*
@@ -316,6 +321,11 @@ static int bmp280_read_press(struct bmp280_data *data,
 	}
 
 	adc_press = be32_to_cpu(tmp) >> 12;
+	if (adc_press == BMP280_PRESS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
 	comp_press = bmp280_compensate_press(data, adc_press);
 
 	*val = comp_press;
@@ -344,6 +354,11 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	}
 
 	adc_humidity = be16_to_cpu(tmp);
+	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading humidity skipped\n");
+		return -EIO;
+	}
 	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
 
 	*val = comp_humidity;
@@ -596,14 +611,20 @@ static const struct bmp280_chip_info bmp280_chip_info = {
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	int ret = bmp280_chip_config(data);
+	int ret;
 	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
 
+	/*
+	 * Oversampling of humidity must be set before oversampling of
+	 * temperature/pressure is set to become effective.
+	 */
+	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
+				  BMP280_OSRS_HUMIDITY_MASK, osrs);
+
 	if (ret < 0)
 		return ret;
 
-	return regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
-				  BMP280_OSRS_HUMIDITY_MASK, osrs);
+	return bmp280_chip_config(data);
 }
 
 static const struct bmp280_chip_info bme280_chip_info = {
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 2c770e13be0e..61347438b779 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -96,6 +96,11 @@
 #define BME280_CHIP_ID			0x60
 #define BMP280_SOFT_RESET_VAL		0xB6
 
+/* BMP280 register skipped special values */
+#define BMP280_TEMP_SKIPPED		0x80000
+#define BMP280_PRESS_SKIPPED		0x80000
+#define BMP280_HUMIDITY_SKIPPED		0x8000
+
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
-- 
2.1.4

