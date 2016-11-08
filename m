Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46916 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933250AbcKHKRB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:17:01 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 06/23] staging: iio: tsl2583: change current chip state from a tristate to a bool
Date: Tue,  8 Nov 2016 05:16:31 -0500
Message-Id: <1478600208-21153-7-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The current chip state is represented as a tristate (working, suspended,
and unknown). The unknown state was not used. This patch changes the
chip state so that it is now represented as a single boolean value
(suspended).

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 3be2213..9880e41 100644
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
@@ -836,7 +830,7 @@ static int taos_suspend(struct device *dev)
 	mutex_lock(&chip->als_mutex);
 
 	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
-	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
+	chip->suspended = true;
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
-- 
2.7.4

