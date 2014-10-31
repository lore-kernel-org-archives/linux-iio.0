Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54118 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422714AbaJaB0T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 30 Oct 2014 21:26:19 -0400
Message-ID: <5452E454.8040607@gmx.de>
Date: Fri, 31 Oct 2014 02:22:28 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: vlad.dogaru@intel.com
Subject: [PATCH 1/3]iio:pressure:bmp280: fix pressure calculation
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to the datasheet and as defined in struct bmp280_comp_press, dig_p1 is
of type u16, while dig_p2 to dig_p9 are of type s16. In
bmp280_read_compensation_press(), values read from the device were treated as
the wrong type.
In bmp280_read_press() the fractional part of the measured pressure is
calculated wrong. A better way is to use *val for the raw pressure and *val2 for
the quotient and let the core do the proper conversion using IIO_VAL_FRACTIONAL.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index ce29ff9..75038da 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -176,15 +176,15 @@ static int bmp280_read_compensation_press(struct bmp280_data *data,
 		return ret;
 	}
 
-	comp->dig_p1 = (s16) le16_to_cpu(buf[0]);
-	comp->dig_p2 = (u16) le16_to_cpu(buf[1]);
-	comp->dig_p3 = (u16) le16_to_cpu(buf[2]);
-	comp->dig_p4 = (u16) le16_to_cpu(buf[3]);
-	comp->dig_p5 = (u16) le16_to_cpu(buf[4]);
-	comp->dig_p6 = (u16) le16_to_cpu(buf[5]);
-	comp->dig_p7 = (u16) le16_to_cpu(buf[6]);
-	comp->dig_p8 = (u16) le16_to_cpu(buf[7]);
-	comp->dig_p9 = (u16) le16_to_cpu(buf[8]);
+	comp->dig_p1 = (u16) le16_to_cpu(buf[0]);
+	comp->dig_p2 = (s16) le16_to_cpu(buf[1]);
+	comp->dig_p3 = (s16) le16_to_cpu(buf[2]);
+	comp->dig_p4 = (s16) le16_to_cpu(buf[3]);
+	comp->dig_p5 = (s16) le16_to_cpu(buf[4]);
+	comp->dig_p6 = (s16) le16_to_cpu(buf[5]);
+	comp->dig_p7 = (s16) le16_to_cpu(buf[6]);
+	comp->dig_p8 = (s16) le16_to_cpu(buf[7]);
+	comp->dig_p9 = (s16) le16_to_cpu(buf[8]);
 
 	return 0;
 }
@@ -309,10 +309,10 @@ static int bmp280_read_press(struct bmp280_data *data,
 	adc_press = be32_to_cpu(tmp) >> 12;
 	comp_press = bmp280_compensate_press(data, &comp, adc_press);
 
-	*val = comp_press / 256000;
-	*val2 = comp_press * 1000000 / 256000;
+	*val = comp_press;
+	*val2 = 256000;
 
-	return IIO_VAL_INT_PLUS_MICRO;
+	return IIO_VAL_FRACTIONAL;
 }
 
 static int bmp280_read_raw(struct iio_dev *indio_dev,
