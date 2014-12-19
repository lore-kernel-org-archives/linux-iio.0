Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:63828 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbaLSW7e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Dec 2014 17:59:34 -0500
Message-ID: <5494ADCD.2030401@gmx.de>
Date: Fri, 19 Dec 2014 23:59:25 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH V2]iio:pressure:bmp280: cleanup
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The calculations for temperature and pressure compensation were already slightly
optimized in comparison to the datasheet. So, it makes sense to optimize even a
bit more, making proper use of C operators:
  - variable t in bmp280_compensate_temp() can be eliminated by directly
    returning the result of the relevant equation.
  - make use of the += operator and eliminate an unnecessary parenthesis level in
    bmp280_compensate_press().
When the initialization of the ctrl_meas register fails, the error message will
now mention the right register name.
During probe, i2c_set_clientdata() is called, although it is not necessary. Drop
it.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
Changes in V2:
Rebase after refactoring of compensation code.

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 47dfd34..7c623e2 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -148,7 +148,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 				  s32 adc_temp)
 {
 	int ret;
-	s32 var1, var2, t;
+	s32 var1, var2;
 	__le16 buf[BMP280_COMP_TEMP_REG_COUNT / 2];
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
@@ -173,10 +173,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 		  ((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1])))) >> 12) *
 		((s32)(s16)le16_to_cpu(buf[T3]))) >> 14;
 
-	data->t_fine = var1 + var2;
-	t = (data->t_fine * 5 + 128) >> 8;
-
-	return t;
+	return (data->t_fine * 5 + 128) >> 8;
 }
 
 /*
@@ -203,8 +200,8 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 
 	var1 = ((s64)data->t_fine) - 128000;
 	var2 = var1 * var1 * (s64)(s16)le16_to_cpu(buf[P6]);
-	var2 = var2 + ((var1 * (s64)(s16)le16_to_cpu(buf[P5])) << 17);
-	var2 = var2 + (((s64)(s16)le16_to_cpu(buf[P4])) << 35);
+	var2 += (var1 * (s64)(s16)le16_to_cpu(buf[P5])) << 17;
+	var2 += ((s64)(s16)le16_to_cpu(buf[P4])) << 35;
 	var1 = ((var1 * var1 * (s64)(s16)le16_to_cpu(buf[P3])) >> 8) +
 		((var1 * (s64)(s16)le16_to_cpu(buf[P2])) << 12);
 	var1 = ((((s64)1) << 47) + var1) * ((s64)le16_to_cpu(buf[P1])) >> 33;
@@ -218,7 +215,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	var2 = (((s64)(s16)le16_to_cpu(buf[P8])) * p) >> 19;
 	p = ((p + var1 + var2) >> 8) + (((s64)(s16)le16_to_cpu(buf[P7])) << 4);
 
-	return (u32) p;
+	return (u32)p;
 }
 
 static int bmp280_read_temp(struct bmp280_data *data,
@@ -330,7 +327,7 @@ static int bmp280_chip_init(struct bmp280_data *data)
 				 BMP280_MODE_NORMAL);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
-			"failed to write config register\n");
+			"failed to write ctrl_meas register\n");
 		return ret;
 	}
 
@@ -358,7 +355,6 @@ static int bmp280_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, indio_dev);
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
 	data->client = client;
