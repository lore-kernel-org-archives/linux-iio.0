Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46737 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeDMQik (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:38:40 -0400
Received: by mail-qk0-f194.google.com with SMTP id l16so8812553qke.13
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:38:40 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 10/14] staging: iio: ad7746: Add comments
Date: Fri, 13 Apr 2018 13:36:47 -0300
Message-Id: <1523637411-8531-11-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add comments to clarify some of the calculations made, specially when
reading or writing values.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 05506bf9..ef0ebb5 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -429,6 +429,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
+		/* 2^16 in micro */
 		val = (val2 * 1024) / 15625;
 
 		switch (chan->type) {
@@ -554,6 +555,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			goto out;
 
+		/*
+		 * Either for Capacitance, Voltage or Temperature,
+		 * the 0x000000 code represents negative full scale,
+		 * the 0x800000 code represents zero scale, and
+		 * the 0xFFFFFF code represents positive full scale.
+		 */
+
 		*val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
 
 		switch (chan->type) {
@@ -565,7 +573,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 			*val = (*val * 125) / 256;
 			break;
 		case IIO_VOLTAGE:
-			if (chan->channel == 1) /* supply_raw*/
+
+			/*
+			 * The voltage from the VDD pin is internally
+			 * attenuated by 6.
+			 */
+
+			if (chan->channel == 1) /* supply_raw */
 				*val = *val * 6;
 			break;
 		default:
@@ -606,6 +620,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
+
+		/*
+		 * CAPDAC Scale = 21pF_typ / 127
+		 * CIN Scale = 8.192pF / 2^24
+		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
+		 */
+
 		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
 					  [chan->differential]) * 338646;
 
@@ -614,13 +635,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
-			/* 8.192pf / 2^24 */
+			/* CIN Scale: 8.192pf / 2^24 */
 			*val =  0;
 			*val2 = 488;
 			ret = IIO_VAL_INT_PLUS_NANO;
 			break;
 		case IIO_VOLTAGE:
-			/* 1170mV / 2^23 */
+			/* VIN Scale: 1170mV / 2^23 */
 			*val = 1170;
 			*val2 = 23;
 			ret = IIO_VAL_FRACTIONAL_LOG2;
@@ -674,7 +695,8 @@ static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
 	unsigned int tmp;
 	int ret;
 
-	/* The default excitation outputs are not inverted, it should be stated
+	/*
+	 * The default excitation outputs are not inverted, it should be stated
 	 * in the dt if needed.
 	 */
 
@@ -685,7 +707,7 @@ static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
 	ret = of_property_read_u32(np, "adi,exclvl", &tmp);
 	if (ret || tmp > 3) {
 		dev_warn(dev, "Wrong exclvl value, using default\n");
-		pdata->exclvl = 3; /* default value */
+		pdata->exclvl = 3;
 	} else {
 		pdata->exclvl = tmp;
 	}
-- 
2.7.4

