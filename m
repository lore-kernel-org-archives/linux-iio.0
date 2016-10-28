Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50772 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756087AbcJ1KA1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Oct 2016 06:00:27 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
Subject: [PATCH 02/10] staging: iio: tsl2583: check for error code from i2c_smbus_read_byte()
Date: Fri, 28 Oct 2016 06:00:13 -0400
Message-Id: <1477648821-3786-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

taos_i2c_read() and taos_als_calibrate() does not check to see if the
value returned by i2c_smbus_read_byte() was an error code. This patch
adds the appropriate error handling.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index fd4b6ef..35c1696 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -171,7 +171,14 @@ taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
 			return ret;
 		}
 		/* read the data */
-		*val = i2c_smbus_read_byte(client);
+		ret = i2c_smbus_read_byte(client);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"%s failed to read byte after writing to register %x\n",
+				__func__, reg);
+			return ret;
+		}
+		*val = ret;
 		val++;
 		reg++;
 	}
@@ -355,6 +362,13 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 	}
 
 	reg_val = i2c_smbus_read_byte(chip->client);
+	if (reg_val < 0) {
+		dev_err(&chip->client->dev,
+			"%s failed to read after writing to the CNTRL register\n",
+			__func__);
+		return ret;
+	}
+
 	if ((reg_val & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
 			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
@@ -371,6 +385,12 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 		return ret;
 	}
 	reg_val = i2c_smbus_read_byte(chip->client);
+	if (reg_val < 0) {
+		dev_err(&chip->client->dev,
+			"%s failed to read after writing to the STATUS register\n",
+			__func__);
+		return ret;
+	}
 
 	if ((reg_val & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
 		dev_err(&chip->client->dev,
-- 
2.7.4

