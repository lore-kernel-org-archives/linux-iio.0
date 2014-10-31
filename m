Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58263 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161570AbaJaB0W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 30 Oct 2014 21:26:22 -0400
Message-ID: <5452E502.6060609@gmx.de>
Date: Fri, 31 Oct 2014 02:25:22 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: vlad.dogaru@intel.com
Subject: [PATCH 3/3]iio:pressure:bmp280: read compensation data only at init
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Compensation data is hard coded into the sensors, so it is sufficient to just
read it once during device initialization. Therefor struct bmp280_comp should be
part of bmp280_data (since the elements of bmp280_comp_temp and
bmp280_comp_press have distinct names, they could be merged into bmp280_comp).

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 4f6ae4d..36e425c 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -68,10 +68,19 @@
 #define BMP280_CHIP_ID			0x58
 #define BMP280_SOFT_RESET_VAL		0xB6
 
+/* Compensation parameters. */
+struct bmp280_comp {
+	u16 dig_p1;
+	s16 dig_p2, dig_p3, dig_p4, dig_p5, dig_p6, dig_p7, dig_p8, dig_p9;
+	u16 dig_t1;
+	s16 dig_t2, dig_t3;
+};
+
 struct bmp280_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct regmap *regmap;
+	struct bmp280_comp comp;
 
 	/*
 	 * Carryover value from temperature conversion, used in pressure
@@ -80,17 +89,6 @@ struct bmp280_data {
 	s32 t_fine;
 };
 
-/* Compensation parameters. */
-struct bmp280_comp_temp {
-	u16 dig_t1;
-	s16 dig_t2, dig_t3;
-};
-
-struct bmp280_comp_press {
-	u16 dig_p1;
-	s16 dig_p2, dig_p3, dig_p4, dig_p5, dig_p6, dig_p7, dig_p8, dig_p9;
-};
-
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -141,11 +139,11 @@ static const struct regmap_config bmp280_regmap_config = {
 	.volatile_reg = bmp280_is_volatile_reg,
 };
 
-static int bmp280_read_compensation_temp(struct bmp280_data *data,
-					 struct bmp280_comp_temp *comp)
+static int bmp280_read_compensation_temp(struct bmp280_data *data)
 {
 	int ret;
 	__le16 buf[BMP280_COMP_TEMP_REG_COUNT / 2];
+	struct bmp280_comp *comp = &data->comp;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
 			       buf, BMP280_COMP_TEMP_REG_COUNT);
@@ -162,11 +160,11 @@ static int bmp280_read_compensation_temp(struct bmp280_data *data,
 	return 0;
 }
 
-static int bmp280_read_compensation_press(struct bmp280_data *data,
-					  struct bmp280_comp_press *comp)
+static int bmp280_read_compensation_press(struct bmp280_data *data)
 {
 	int ret;
 	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
+	struct bmp280_comp *comp = &data->comp;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
 			       buf, BMP280_COMP_PRESS_REG_COUNT);
@@ -196,11 +194,10 @@ static int bmp280_read_compensation_press(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static s32 bmp280_compensate_temp(struct bmp280_data *data,
-				  struct bmp280_comp_temp *comp,
-				  s32 adc_temp)
+static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 {
 	s32 var1, var2;
+	struct bmp280_comp *comp = &data->comp;
 
 	var1 = (((adc_temp >> 3) - ((s32) comp->dig_t1 << 1)) *
 		((s32) comp->dig_t2)) >> 11;
@@ -219,11 +216,10 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static u32 bmp280_compensate_press(struct bmp280_data *data,
-				   struct bmp280_comp_press *comp,
-				   s32 adc_press)
+static u32 bmp280_compensate_press(struct bmp280_data *data, s32 adc_press)
 {
 	s64 var1, var2, p;
+	struct bmp280_comp *comp = &data->comp;
 
 	var1 = ((s64) data->t_fine) - 128000;
 	var2 = var1 * var1 * (s64) comp->dig_p6;
@@ -249,11 +245,6 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	int ret;
 	__be32 tmp = 0;
 	s32 adc_temp, comp_temp;
-	struct bmp280_comp_temp comp;
-
-	ret = bmp280_read_compensation_temp(data, &comp);
-	if (ret < 0)
-		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
 			       (u8 *) &tmp, 3);
@@ -263,7 +254,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	}
 
 	adc_temp = be32_to_cpu(tmp) >> 12;
-	comp_temp = bmp280_compensate_temp(data, &comp, adc_temp);
+	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/*
 	 * val might be NULL if we're called by the read_press routine,
@@ -284,11 +275,6 @@ static int bmp280_read_press(struct bmp280_data *data,
 	__be32 tmp = 0;
 	s32 adc_press;
 	u32 comp_press;
-	struct bmp280_comp_press comp;
-
-	ret = bmp280_read_compensation_press(data, &comp);
-	if (ret < 0)
-		return ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL);
@@ -303,7 +289,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	}
 
 	adc_press = be32_to_cpu(tmp) >> 12;
-	comp_press = bmp280_compensate_press(data, &comp, adc_press);
+	comp_press = bmp280_compensate_press(data, adc_press);
 
 	*val = comp_press;
 	*val2 = 256000;
@@ -375,6 +361,14 @@ static int bmp280_chip_init(struct bmp280_data *data)
 		return ret;
 	}
 
+	ret = bmp280_read_compensation_temp(data);
+	if (ret < 0)
+		return ret;
+
+	ret = bmp280_read_compensation_press(data);
+	if (ret < 0)
+		return ret;
+
 	return ret;
 }
 
