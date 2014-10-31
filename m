Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52220 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422778AbaJaB0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 30 Oct 2014 21:26:20 -0400
Message-ID: <5452E495.2020705@gmx.de>
Date: Fri, 31 Oct 2014 02:23:33 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: vlad.dogaru@intel.com
Subject: [PATCH 2/3]iio:pressure:bmp280: cleanup
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The calculations for temperature and pressure compensation were already slightly
optimized in comparison to the data sheet. So, it makes sense to optimize even a
bit more, making proper use of C operators:
  - variable t in bmp280_compensate_temp() can be eliminated by directly
    returning the result of the relevant equation.
  - make use of the += operator, eliminate an unnecessary parenthesis level and
    directly return the result of the last equation in
    bmp280_compensate_press().
When the initialization of the ctrl_meas register fails, the error message will
now mention the right register name.
During probe, i2c_set_clientdata() is called, although it is not necessary. Drop
it.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 75038da..4f6ae4d 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -200,7 +200,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 				  struct bmp280_comp_temp *comp,
 				  s32 adc_temp)
 {
-	s32 var1, var2, t;
+	s32 var1, var2;
 
 	var1 = (((adc_temp >> 3) - ((s32) comp->dig_t1 << 1)) *
 		((s32) comp->dig_t2)) >> 11;
@@ -209,9 +209,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 		((s32) comp->dig_t3)) >> 14;
 
 	data->t_fine = var1 + var2;
-	t = (data->t_fine * 5 + 128) >> 8;
-
-	return t;
+	return (data->t_fine * 5 + 128) >> 8;
 }
 
 /*
@@ -229,11 +227,11 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 
 	var1 = ((s64) data->t_fine) - 128000;
 	var2 = var1 * var1 * (s64) comp->dig_p6;
-	var2 = var2 + ((var1 * (s64) comp->dig_p5) << 17);
-	var2 = var2 + (((s64) comp->dig_p4) << 35);
+	var2 += ((var1 * (s64) comp->dig_p5) << 17);
+	var2 += (((s64) comp->dig_p4) << 35);
 	var1 = ((var1 * var1 * (s64) comp->dig_p3) >> 8) +
 		((var1 * (s64) comp->dig_p2) << 12);
-	var1 = (((((s64) 1) << 47) + var1)) * ((s64) comp->dig_p1) >> 33;
+	var1 = ((((s64) 1) << 47) + var1) * ((s64) comp->dig_p1) >> 33;
 
 	if (var1 == 0)
 		return 0;
@@ -242,9 +240,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	p = div64_s64(p, var1);
 	var1 = (((s64) comp->dig_p9) * (p >> 13) * (p >> 13)) >> 25;
 	var2 = (((s64) comp->dig_p8) * p) >> 19;
-	p = ((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
-
-	return (u32) p;
+	return (u32)((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
 }
 
 static int bmp280_read_temp(struct bmp280_data *data,
@@ -366,7 +362,7 @@ static int bmp280_chip_init(struct bmp280_data *data)
 				 BMP280_MODE_NORMAL);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
-			"failed to write config register\n");
+			"failed to write ctrl_meas register\n");
 		return ret;
 	}
 
@@ -394,7 +390,6 @@ static int bmp280_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, indio_dev);
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
 	data->client = client;
