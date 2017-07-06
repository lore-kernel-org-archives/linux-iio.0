Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58524 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbdGFW4h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 18:56:37 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 5/9] staging: iio: tsl2x7x: cleaned up i2c calls in tsl2x7x_als_calibrate()
Date: Thu,  6 Jul 2017 18:56:22 -0400
Message-Id: <20170706225626.6716-6-masneyb@onstation.org>
In-Reply-To: <20170706225626.6716-1-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The calibration function calls i2c_smbus_write_byte() and
i2c_smbus_read_byte(). These two function calls are replaced with a
single call to i2c_smbus_read_byte_data() by this patch. This patch
also removes an unnecessary call that reads the CNTRL register
a second time. One of the error paths returned -1 if the ADC was not
enabled and this patch changes that return value to -EINVAL.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 6c9f06b..5734628 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -542,39 +542,29 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
 static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	u8 reg_val;
 	int gain_trim_val;
 	int ret;
 	int lux_val;
 
-	ret = i2c_smbus_write_byte(chip->client,
-				   (TSL2X7X_CMD_REG | TSL2X7X_CNTRL));
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
 	if (ret < 0) {
 		dev_err(&chip->client->dev,
-			"failed to write CNTRL register, ret=%d\n", ret);
+			"%s: failed to read from the CNTRL register\n",
+			__func__);
 		return ret;
 	}
 
-	reg_val = i2c_smbus_read_byte(chip->client);
-	if ((reg_val & (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON))
-		!= (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON)) {
-		dev_err(&chip->client->dev,
-			"%s: failed: ADC not enabled\n", __func__);
-		return -1;
-	}
-
-	ret = i2c_smbus_write_byte(chip->client,
-				   (TSL2X7X_CMD_REG | TSL2X7X_CNTRL));
-	if (ret < 0) {
+	if ((ret & (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON))
+			!= (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
-			"failed to write ctrl reg: ret=%d\n", ret);
-		return ret;
-	}
-
-	reg_val = i2c_smbus_read_byte(chip->client);
-	if ((reg_val & TSL2X7X_STA_ADC_VALID) != TSL2X7X_STA_ADC_VALID) {
+			"%s: Device is not powered on and/or ADC is not enabled\n",
+			__func__);
+		return -EINVAL;
+	} else if ((ret & TSL2X7X_STA_ADC_VALID) != TSL2X7X_STA_ADC_VALID) {
 		dev_err(&chip->client->dev,
-			"%s: failed: STATUS - ADC not valid.\n", __func__);
+			"%s: The two ADC channels have not completed an integration cycle\n",
+			__func__);
 		return -ENODATA;
 	}
 
-- 
2.9.4

