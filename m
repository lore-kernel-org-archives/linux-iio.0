Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 6/9] staging: iio: tsl2583: remove redudant i2c call in taos_als_calibrate()
Date: Thu,  3 Nov 2016 08:56:17 -0400
Message-Id: <1478177780-28699-7-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

taos_als_calibrate() queries the control register to determine if the
unit is powered on and has the ADC enabled. It then queries the same
register a second time to determine if the ADC reading is valid. This
patch removes the redundant i2c_smbus_read_byte_data() call.

Verified that the driver still functions correctly using a TSL2581
hooked up to a Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index af1cf9b..7eab17f 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -338,18 +338,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
 		return -EINVAL;
-	}
-
-	ret = i2c_smbus_read_byte_data(chip->client,
-				       TSL258X_CMD_REG | TSL258X_CNTRL);
-	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"%s failed to read from the CNTRL register\n",
-			__func__);
-		return ret;
-	}
-
-	if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
+	} else if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: STATUS - ADC not valid.\n");
 		return -ENODATA;
-- 
2.5.5
