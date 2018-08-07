Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36351 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGWTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 18:19:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so9102841pfo.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Aug 2018 13:03:42 -0700 (PDT)
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org, himanshujha199640@gmail.com
Cc: David Frey <dpfrey@gmail.com>
Subject: [PATCH 1/2] iio: bme680: perform cosmetic cleanup
Date: Tue,  7 Aug 2018 13:07:20 -0700
Message-Id: <20180807200721.22033-2-dpfrey@gmail.com>
In-Reply-To: <20180807200721.22033-1-dpfrey@gmail.com>
References: <20180807200721.22033-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 * use consistent naming for masks. _MSK -> _MASK
 * use GEN_MASK to define masks rather than hex constants
 * consistently indent masks and values under the corresponding register
   define
 * use FIELD_GET instead of explicit mask and shift
 * Join split lines in bme680_read_calib() which can fit in 80 chars
 * Make use clamp macro

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680.h      | 17 +++++++-------
 drivers/iio/chemical/bme680_core.c | 45 +++++++++++++-------------------------
 2 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index e049323f209a..a9f2a9a6abc5 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -4,10 +4,10 @@
 
 #define BME680_REG_CHIP_I2C_ID			0xD0
 #define BME680_REG_CHIP_SPI_ID			0x50
-#define BME680_CHIP_ID_VAL			0x61
+#define   BME680_CHIP_ID_VAL			0x61
 #define BME680_REG_SOFT_RESET_I2C		0xE0
 #define BME680_REG_SOFT_RESET_SPI		0x60
-#define BME680_CMD_SOFTRESET			0xB6
+#define   BME680_CMD_SOFTRESET			0xB6
 #define BME680_REG_STATUS			0x73
 #define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
 #define     BME680_SPI_MEM_PAGE_1_VAL		1
@@ -18,6 +18,7 @@
 #define BME680_REG_GAS_MSB			0x2A
 #define BME680_REG_GAS_R_LSB			0x2B
 #define   BME680_GAS_STAB_BIT			BIT(4)
+#define   BME680_GAS_RANGE_MASK			GENMASK(3, 0)
 
 #define BME680_REG_CTRL_HUMIDITY		0x72
 #define   BME680_OSRS_HUMIDITY_MASK		GENMASK(2, 0)
@@ -26,9 +27,8 @@
 #define   BME680_OSRS_TEMP_MASK			GENMASK(7, 5)
 #define   BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
 #define   BME680_MODE_MASK			GENMASK(1, 0)
-
-#define BME680_MODE_FORCED			1
-#define BME680_MODE_SLEEP			0
+#define     BME680_MODE_FORCED			1
+#define     BME680_MODE_SLEEP			0
 
 #define BME680_REG_CONFIG			0x75
 #define   BME680_FILTER_MASK			GENMASK(4, 2)
@@ -39,16 +39,15 @@
 
 #define BME680_MAX_OVERFLOW_VAL			0x40000000
 #define BME680_HUM_REG_SHIFT_VAL		4
-#define BME680_BIT_H1_DATA_MSK			0x0F
+#define BME680_BIT_H1_DATA_MASK			GENMASK(3, 0)
 
 #define BME680_REG_RES_HEAT_RANGE		0x02
-#define BME680_RHRANGE_MSK			0x30
+#define   BME680_RHRANGE_MASK			GENMASK(5, 4)
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define BME680_REG_RANGE_SW_ERR			0x04
-#define BME680_RSERROR_MSK			0xF0
+#define   BME680_RSERROR_MASK			GENMASK(7, 4)
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
-#define BME680_GAS_RANGE_MASK			0x0F
 #define BME680_ADC_GAS_RES_SHIFT		6
 #define BME680_AMB_TEMP				25
 
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7d9bb62baa3f..0e79d03ecc40 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -102,16 +102,14 @@ static int bme680_read_calib(struct bme680_data *data,
 	__le16 buf;
 
 	/* Temperature related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_T1_LSB_REG\n");
 		return ret;
 	}
 	calib->par_t1 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_T2_LSB_REG\n");
 		return ret;
@@ -126,16 +124,14 @@ static int bme680_read_calib(struct bme680_data *data,
 	calib->par_t3 = tmp;
 
 	/* Pressure related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P1_LSB_REG\n");
 		return ret;
 	}
 	calib->par_p1 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P2_LSB_REG\n");
 		return ret;
@@ -149,16 +145,14 @@ static int bme680_read_calib(struct bme680_data *data,
 	}
 	calib->par_p3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P4_LSB_REG\n");
 		return ret;
 	}
 	calib->par_p4 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P5_LSB_REG\n");
 		return ret;
@@ -179,16 +173,14 @@ static int bme680_read_calib(struct bme680_data *data,
 	}
 	calib->par_p7 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P8_LSB_REG\n");
 		return ret;
 	}
 	calib->par_p8 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG, (u8 *) &buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P9_LSB_REG\n");
 		return ret;
@@ -208,30 +200,26 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read BME680_H1_MSB_REG\n");
 		return ret;
 	}
-
 	ret = regmap_read(data->regmap, BME680_H1_LSB_REG, &tmp_lsb);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_H1_LSB_REG\n");
 		return ret;
 	}
-
 	calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
-				(tmp_lsb & BME680_BIT_H1_DATA_MSK);
+	                (tmp_lsb & BME680_BIT_H1_DATA_MASK);
 
 	ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_H2_MSB_REG\n");
 		return ret;
 	}
-
 	ret = regmap_read(data->regmap, BME680_H2_LSB_REG, &tmp_lsb);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_H2_LSB_REG\n");
 		return ret;
 	}
-
 	calib->par_h2 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
-				(tmp_lsb >> BME680_HUM_REG_SHIFT_VAL);
+	                (tmp_lsb >> BME680_HUM_REG_SHIFT_VAL);
 
 	ret = regmap_read(data->regmap, BME680_H3_REG, &tmp);
 	if (ret < 0) {
@@ -276,8 +264,8 @@ static int bme680_read_calib(struct bme680_data *data,
 	}
 	calib->par_gh1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG,
-			       (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG, (u8 *) &buf,
+	                       2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_GH2_LSB_REG\n");
 		return ret;
@@ -297,7 +285,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read resistance heat range\n");
 		return ret;
 	}
-	calib->res_heat_range = (tmp & BME680_RHRANGE_MSK) / 16;
+	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK, tmp);
 
 	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_VAL, &tmp);
 	if (ret < 0) {
@@ -311,7 +299,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read range software error\n");
 		return ret;
 	}
-	calib->range_sw_err = (tmp & BME680_RSERROR_MSK) / 16;
+	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK, tmp);
 
 	return 0;
 }
@@ -408,10 +396,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 	var6 = (var4 * var5) >> 1;
 	calc_hum = (((var3 + var6) >> 10) * 1000) >> 12;
 
-	if (calc_hum > 100000) /* Cap at 100%rH */
-		calc_hum = 100000;
-	else if (calc_hum < 0)
-		calc_hum = 0;
+	calc_hum = clamp(calc_hum, 0, 100000); /* clamp between 0-100 %rH */
 
 	return calc_hum;
 }
-- 
2.11.0

