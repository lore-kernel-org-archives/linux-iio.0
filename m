Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46912 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933252AbcKHKRB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:17:01 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 05/23] staging: iio: tsl2583: remove unnecessary chip status checks in suspend/resume
Date: Tue,  8 Nov 2016 05:16:30 -0500
Message-Id: <1478600208-21153-6-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The device probing and the suspend/resume code checks a flag internal to
the driver that determines whether or not the chip is in a working
state. These checks are not needed. This patch removes the unnecessary
checks. It will do no harm to the hardware if the chip is
reinitialized if it is already powered on.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 2a3db3f..3be2213 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -412,13 +412,6 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-	/* and make sure we're not already on */
-	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
-		/* if forcing a register update - turn off, then on */
-		dev_info(&chip->client->dev, "device is already enabled\n");
-		return -EINVAL;
-	}
-
 	/* Power on the device; ADC off. */
 	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON);
 	if (ret < 0)
@@ -842,10 +835,8 @@ static int taos_suspend(struct device *dev)
 
 	mutex_lock(&chip->als_mutex);
 
-	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
-		ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
-		chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
-	}
+	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
+	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
@@ -859,8 +850,7 @@ static int taos_resume(struct device *dev)
 
 	mutex_lock(&chip->als_mutex);
 
-	if (chip->taos_chip_status == TSL258X_CHIP_SUSPENDED)
-		ret = tsl2583_chip_init_and_power_on(indio_dev);
+	ret = tsl2583_chip_init_and_power_on(indio_dev);
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
-- 
2.7.4

