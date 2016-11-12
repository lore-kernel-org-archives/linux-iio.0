Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55904 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966688AbcKLSTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:46 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 04/26] staging: iio: tsl2583: change current chip state from a tristate to a bool
Date: Sat, 12 Nov 2016 13:19:19 -0500
Message-Id: <1478974781-1457-5-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The current chip state is represented as a tristate (working, suspended,
and unknown). The unknown state was not used. This patch changes the
chip state so that it is now represented as a single boolean value
(suspended).

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 40aa78e..5a32102 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -67,12 +67,6 @@
 #define TSL2583_CHIP_ID			0x90
 #define TSL2583_CHIP_ID_MASK		0xf0
 
-enum {
-	TSL258X_CHIP_UNKNOWN = 0,
-	TSL258X_CHIP_WORKING = 1,
-	TSL258X_CHIP_SUSPENDED = 2
-};
-
 /* Per-device data */
 struct taos_als_info {
 	u16 als_ch0;
@@ -94,7 +88,7 @@ struct tsl2583_chip {
 	struct taos_settings taos_settings;
 	int als_time_scale;
 	int als_saturation;
-	int taos_chip_status;
+	bool suspended;
 };
 
 struct taos_lux {
@@ -441,7 +435,7 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	chip->taos_chip_status = TSL258X_CHIP_WORKING;
+	chip->suspended = false;
 
 	return ret;
 }
@@ -494,7 +488,7 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 
 	mutex_lock(&chip->als_mutex);
 
-	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
+	if (chip->suspended) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -627,7 +621,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->als_mutex);
 
-	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
+	if (chip->suspended) {
 		ret = -EBUSY;
 		goto read_done;
 	}
@@ -704,7 +698,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->als_mutex);
 
-	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
+	if (chip->suspended) {
 		ret = -EBUSY;
 		goto write_done;
 	}
@@ -778,7 +772,7 @@ static int taos_probe(struct i2c_client *clientp,
 	i2c_set_clientdata(clientp, indio_dev);
 
 	mutex_init(&chip->als_mutex);
-	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
+	chip->suspended = true;
 
 	ret = i2c_smbus_read_byte_data(clientp,
 				       TSL258X_CMD_REG | TSL258X_CHIPID);
@@ -835,7 +829,7 @@ static int __maybe_unused taos_suspend(struct device *dev)
 	mutex_lock(&chip->als_mutex);
 
 	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
-	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
+	chip->suspended = true;
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
-- 
2.7.4

