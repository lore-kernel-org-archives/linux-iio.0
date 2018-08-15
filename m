Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:29:17 -0400
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 2/7] iio: chemical: bme680: cleanup bme680_read_calib formatting
Date: Wed, 15 Aug 2018 13:38:30 -0700
Message-Id: <20180815203835.21079-3-dpfrey@gmail.com>
In-Reply-To: <20180815203835.21079-1-dpfrey@gmail.com>
References: <20180815203835.21079-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index b4c012bc0a82..49bb6b84f181 100644
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
+	                (tmp_lsb & BME680_BIT_H1_DATA_MSK);
 
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
-- 
2.11.0
