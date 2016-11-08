Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47270 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbcKHK1P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:27:15 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 17/23] staging: iio: tsl2583: moved code block inside else statement
Date: Tue,  8 Nov 2016 05:16:42 -0500
Message-Id: <1478600208-21153-18-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The check for ch1lux > ch0lux inside tsl2583_get_lux is only valid if
the ratio is not equal to zero. Move the code block inside the else
statement. This does away with the need to initialize the variables to
zero.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 8d9176d..5cdfe06 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -167,8 +167,6 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 	struct tsl2583_lux *p;
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int i, ret;
-	u32 ch0lux = 0;
-	u32 ch1lux = 0;
 
 	ret = i2c_smbus_read_byte_data(chip->client, TSL2583_CMD_REG);
 	if (ret < 0) {
@@ -238,22 +236,25 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 	if (p->ratio == 0) {
 		lux = 0;
 	} else {
+		u32 ch0lux, ch1lux;
+
 		ch0lux = ((ch0 * p->ch0) +
 			  (gainadj[chip->als_settings.als_gain].ch0 >> 1))
 			 / gainadj[chip->als_settings.als_gain].ch0;
 		ch1lux = ((ch1 * p->ch1) +
 			  (gainadj[chip->als_settings.als_gain].ch1 >> 1))
 			 / gainadj[chip->als_settings.als_gain].ch1;
-		lux = ch0lux - ch1lux;
-	}
 
-	/* note: lux is 31 bit max at this point */
-	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev, "%s: No Data - Returning 0\n",
-			__func__);
-		ret = 0;
-		chip->als_cur_info.lux = 0;
-		goto done;
+		/* note: lux is 31 bit max at this point */
+		if (ch1lux > ch0lux) {
+			dev_dbg(&chip->client->dev, "%s: No Data - Returning 0\n",
+				__func__);
+			ret = 0;
+			chip->als_cur_info.lux = 0;
+			goto done;
+		}
+
+		lux = ch0lux - ch1lux;
 	}
 
 	/* adjust for active time scale */
-- 
2.7.4

