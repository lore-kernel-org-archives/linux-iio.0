Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55870 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966663AbcKLSTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:46 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 02/26] staging: iio: tsl2583: remove unnecessary chip status check in taos_get_lux
Date: Sat, 12 Nov 2016 13:19:17 -0500
Message-Id: <1478974781-1457-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

taos_get_lux checks to see if the chip is in a working state. This
check is not necessary since it is only called from tsl2583_read_raw
and in_illuminance_calibrate_store (via taos_als_calibrate). The chip
state is already checked by these functions.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index de54e74..a550023 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -178,13 +178,6 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	u32 ch0lux = 0;
 	u32 ch1lux = 0;
 
-	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
-		/* device is not enabled */
-		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
-- 
2.7.4

