Return-Path: <SRS0=LOGo=DI=gmail.com=stefan.tatschner@kernel.org>
From: Stefan Tatschner <stefan.tatschner@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Stefan Tatschner <stefan.tatschner@gmail.com>
Subject: [PATCH] iio/bmp280-core.c: Read calibration data in probe
Date: Tue, 12 Dec 2017 15:34:35 +0100
Message-Id: <20171212143435.29586-1-stefan.tatschner@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch affects BME280 and BMP280. The readout of the calibration
data is moved to the probe function. Each sensor data access triggered
reading the full calibration data before this patch. According to the
datasheet, Section 4.4.2., the calibration data is stored in non-volatile
memory.

Since the calibration data does not change, and cannot be changed by the
user, we can reduce bus traffic by reading the calibration data once.
Additionally, proper organization of the data types enables removing
some odd casts in the compensation formulas.

Signed-off-by: Stefan Tatschner <stefan.tatschner@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 205 ++++++++++++++++++++++++-------------
 1 file changed, 134 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fd1da26a62e4..0316d1003d7e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -55,6 +55,28 @@ struct bmp180_calib {
 	s16 MD;
 };
 
+/* See datasheet Section 4.2.2. */
+struct bmp280_calib {
+	u16 T1;
+	s16 T2;
+	s16 T3;
+	u16 P1;
+	s16 P2;
+	s16 P3;
+	s16 P4;
+	s16 P5;
+	s16 P6;
+	s16 P7;
+	s16 P8;
+	s16 P9;
+	u8  H1;
+	s16 H2;
+	u8  H3;
+	s16 H4;
+	s16 H5;
+	s8  H6;
+};
+
 struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
@@ -62,7 +84,10 @@ struct bmp280_data {
 	struct completion done;
 	bool use_eoc;
 	const struct bmp280_chip_info *chip_info;
-	struct bmp180_calib calib;
+	union {
+		struct bmp180_calib bmp180;
+		struct bmp280_calib bmp280;
+	} calib;
 	struct regulator *vddd;
 	struct regulator *vdda;
 	unsigned int start_up_time; /* in microseconds */
@@ -120,67 +145,123 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	},
 };
 
-/*
- * Returns humidity in percent, resolution is 0.01 percent. Output value of
- * "47445" represents 47445/1024 = 46.333 %RH.
- *
- * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
- */
-
-static u32 bmp280_compensate_humidity(struct bmp280_data *data,
-				      s32 adc_humidity)
+static int bmp280_read_calib(struct bmp280_data *data,
+			     struct bmp280_calib *calib,
+			     unsigned int chip)
 {
+	int ret;
+	unsigned int tmp;
 	struct device *dev = data->dev;
-	unsigned int H1, H3, tmp;
-	int H2, H4, H5, H6, ret, var;
+	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
+	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
+
+	/* Read temperature calibration values. */
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
+			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read temperature calibration parameters\n");
+		return ret;
+	}
+
+	calib->T1 = le16_to_cpu(t_buf[T1]);
+	calib->T2 = le16_to_cpu(t_buf[T2]);
+	calib->T3 = le16_to_cpu(t_buf[T3]);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &H1);
+	/* Read pressure calibration values. */
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
+			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read pressure calibration parameters\n");
+		return ret;
+	}
+
+	calib->P1 = le16_to_cpu(p_buf[P1]);
+	calib->P2 = le16_to_cpu(p_buf[P2]);
+	calib->P3 = le16_to_cpu(p_buf[P3]);
+	calib->P4 = le16_to_cpu(p_buf[P4]);
+	calib->P5 = le16_to_cpu(p_buf[P5]);
+	calib->P6 = le16_to_cpu(p_buf[P6]);
+	calib->P7 = le16_to_cpu(p_buf[P7]);
+	calib->P8 = le16_to_cpu(p_buf[P8]);
+	calib->P9 = le16_to_cpu(p_buf[P9]);
+
+	/* Read humidity calibration values.
+	 * Due to some odd register addressing we cannot just
+	 * do a big bulk read. Instead, we have to read each HX
+	 * value separately and sometimes do some bit shifting...
+	 * Humidity data is only available on BME280.
+	 */
+	if (chip != BME280_CHIP_ID)
+		return 0;
+
+	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H1 comp value\n");
 		return ret;
 	}
+	calib->H1 = tmp;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &tmp, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
-	H2 = sign_extend32(le16_to_cpu(tmp), 15);
+	calib->H2 = sign_extend32(le16_to_cpu(tmp), 15);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &H3);
+	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H3 comp value\n");
 		return ret;
 	}
+	calib->H3 = tmp;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &tmp, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
-	H4 = sign_extend32(((be16_to_cpu(tmp) >> 4) & 0xff0) |
-			  (be16_to_cpu(tmp) & 0xf), 11);
+	calib->H4 = sign_extend32(((be16_to_cpu(tmp) >> 4) & 0xff0) |
+				  (be16_to_cpu(tmp) & 0xf), 11);
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &tmp, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	H5 = sign_extend32(((le16_to_cpu(tmp) >> 4) & 0xfff), 11);
+	calib->H5 = sign_extend32(((le16_to_cpu(tmp) >> 4) & 0xfff), 11);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H6 comp value\n");
 		return ret;
 	}
-	H6 = sign_extend32(tmp, 7);
+	calib->H6 = sign_extend32(tmp, 7);
+
+	/* Toss the calibration data into the entropy pool */
+	add_device_randomness(calib, sizeof(struct bmp280_calib));
+
+	return 0;
+}
+/*
+ * Returns humidity in percent, resolution is 0.01 percent. Output value of
+ * "47445" represents 47445/1024 = 46.333 %RH.
+ *
+ * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
+ */
+static u32 bmp280_compensate_humidity(struct bmp280_data *data,
+				      s32 adc_humidity)
+{
+	s32 var;
+	struct bmp280_calib *calib = &data->calib.bmp280;
 
 	var = ((s32)data->t_fine) - (s32)76800;
-	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var))
-		+ (s32)16384) >> 15) * (((((((var * H6) >> 10)
-		* (((var * (s32)H3) >> 11) + (s32)32768)) >> 10)
-		+ (s32)2097152) * H2 + 8192) >> 14);
-	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)H1) >> 4;
+	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
+		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
+		* (((var * calib->H3) >> 11) + 32768)) >> 10)
+		+ (s32)2097152) * calib->H2 + 8192) >> 14);
+	var -= ((((var >> 15) * (var >> 15)) >> 7) * calib->H1) >> 4;
 
 	return var >> 12;
 };
@@ -195,31 +276,14 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 static s32 bmp280_compensate_temp(struct bmp280_data *data,
 				  s32 adc_temp)
 {
-	int ret;
 	s32 var1, var2;
-	__le16 buf[BMP280_COMP_TEMP_REG_COUNT / 2];
+	struct bmp280_calib *calib = &data->calib.bmp280;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
-			       buf, BMP280_COMP_TEMP_REG_COUNT);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read temperature calibration parameters\n");
-		return ret;
-	}
-
-	/*
-	 * The double casts are necessary because le16_to_cpu returns an
-	 * unsigned 16-bit value.  Casting that value directly to a
-	 * signed 32-bit will not do proper sign extension.
-	 *
-	 * Conversely, T1 and P1 are unsigned values, so they can be
-	 * cast straight to the larger type.
-	 */
-	var1 = (((adc_temp >> 3) - ((s32)le16_to_cpu(buf[T1]) << 1)) *
-		((s32)(s16)le16_to_cpu(buf[T2]))) >> 11;
-	var2 = (((((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1]))) *
-		  ((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1])))) >> 12) *
-		((s32)(s16)le16_to_cpu(buf[T3]))) >> 14;
+	var1 = (((adc_temp >> 3) - ((s32)calib->T1 << 1)) *
+		((s32)calib->T2)) >> 11;
+	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
+		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
+		((s32)calib->T3)) >> 14;
 	data->t_fine = var1 + var2;
 
 	return (data->t_fine * 5 + 128) >> 8;
@@ -235,34 +299,25 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 static u32 bmp280_compensate_press(struct bmp280_data *data,
 				   s32 adc_press)
 {
-	int ret;
 	s64 var1, var2, p;
-	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
-
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
-			       buf, BMP280_COMP_PRESS_REG_COUNT);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read pressure calibration parameters\n");
-		return ret;
-	}
+	struct bmp280_calib *calib = &data->calib.bmp280;
 
 	var1 = ((s64)data->t_fine) - 128000;
-	var2 = var1 * var1 * (s64)(s16)le16_to_cpu(buf[P6]);
-	var2 += (var1 * (s64)(s16)le16_to_cpu(buf[P5])) << 17;
-	var2 += ((s64)(s16)le16_to_cpu(buf[P4])) << 35;
-	var1 = ((var1 * var1 * (s64)(s16)le16_to_cpu(buf[P3])) >> 8) +
-		((var1 * (s64)(s16)le16_to_cpu(buf[P2])) << 12);
-	var1 = ((((s64)1) << 47) + var1) * ((s64)le16_to_cpu(buf[P1])) >> 33;
+	var2 = var1 * var1 * (s64)calib->P6;
+	var2 += (var1 * (s64)calib->P5) << 17;
+	var2 += ((s64)calib->P4) << 35;
+	var1 = ((var1 * var1 * (s64)calib->P3) >> 8) +
+		((var1 * (s64)calib->P2) << 12);
+	var1 = ((((s64)1) << 47) + var1) * ((s64)calib->P1) >> 33;
 
 	if (var1 == 0)
 		return 0;
 
 	p = ((((s64)1048576 - adc_press) << 31) - var2) * 3125;
 	p = div64_s64(p, var1);
-	var1 = (((s64)(s16)le16_to_cpu(buf[P9])) * (p >> 13) * (p >> 13)) >> 25;
-	var2 = (((s64)(s16)le16_to_cpu(buf[P8])) * p) >> 19;
-	p = ((p + var1 + var2) >> 8) + (((s64)(s16)le16_to_cpu(buf[P7])) << 4);
+	var1 = (((s64)calib->P9) * (p >> 13) * (p >> 13)) >> 25;
+	var2 = ((s64)(calib->P8) * p) >> 19;
+	p = ((p + var1 + var2) >> 8) + (((s64)calib->P7) << 4);
 
 	return (u32)p;
 }
@@ -752,7 +807,7 @@ static int bmp180_read_calib(struct bmp280_data *data,
 static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 {
 	s32 x1, x2;
-	struct bmp180_calib *calib = &data->calib;
+	struct bmp180_calib *calib = &data->calib.bmp180;
 
 	x1 = ((adc_temp - calib->AC6) * calib->AC5) >> 15;
 	x2 = (calib->MC << 11) / (x1 + calib->MD);
@@ -814,7 +869,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	s32 b3, b6;
 	u32 b4, b7;
 	s32 oss = data->oversampling_press;
-	struct bmp180_calib *calib = &data->calib;
+	struct bmp180_calib *calib = &data->calib.bmp180;
 
 	b6 = data->t_fine - 4000;
 	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
@@ -1028,11 +1083,19 @@ int bmp280_common_probe(struct device *dev,
 	dev_set_drvdata(dev, indio_dev);
 
 	/*
-	 * The BMP085 and BMP180 has calibration in an E2PROM, read it out
-	 * at probe time. It will not change.
+	 * Some chips have calibration parameters "programmed into the devices'
+	 * non-volatile memory during production". Let's read them out at probe
+	 * time once. They will not change.
 	 */
 	if (chip_id  == BMP180_CHIP_ID) {
-		ret = bmp180_read_calib(data, &data->calib);
+		ret = bmp180_read_calib(data, &data->calib.bmp180);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"failed to read calibration coefficients\n");
+			goto out_disable_vdda;
+		}
+	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
+		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
-- 
2.15.1
