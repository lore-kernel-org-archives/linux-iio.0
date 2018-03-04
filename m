Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:52826 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbeCDByy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 20:54:54 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 01/12] staging: iio: tsl2x7x: remove power functions from tsl2X7X_platform_data
Date: Sat,  3 Mar 2018 20:49:31 -0500
Message-Id: <20180304014942.18727-2-masneyb@onstation.org>
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The tsl2X7X_platform_data structure contains the platform_power,
power_on, and power_off function pointers. These power management
functions should not be in the platform data. These functions were
likely used before the regulator framework was put in place. There are
no users of these functions in the mainline kernel.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 18 ------------------
 drivers/staging/iio/light/tsl2x7x.h |  4 ----
 2 files changed, 22 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 126e11530ce0..b7e3f966c3a6 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -588,9 +588,6 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	u8 reg_val = 0;
 
-	if (chip->pdata && chip->pdata->power_on)
-		chip->pdata->power_on(indio_dev);
-
 	/* Non calculated parameters */
 	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
 	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
@@ -736,9 +733,6 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, 0x00);
 
-	if (chip->pdata && chip->pdata->power_off)
-		chip->pdata->power_off(chip->client);
-
 	return ret;
 }
 
@@ -1792,12 +1786,6 @@ static int tsl2x7x_suspend(struct device *dev)
 		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
 	}
 
-	if (chip->pdata && chip->pdata->platform_power) {
-		pm_message_t pmm = {PM_EVENT_SUSPEND};
-
-		chip->pdata->platform_power(dev, pmm);
-	}
-
 	return ret;
 }
 
@@ -1807,12 +1795,6 @@ static int tsl2x7x_resume(struct device *dev)
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 
-	if (chip->pdata && chip->pdata->platform_power) {
-		pm_message_t pmm = {PM_EVENT_RESUME};
-
-		chip->pdata->platform_power(dev, pmm);
-	}
-
 	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
 		ret = tsl2x7x_chip_on(indio_dev);
 
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index df00f2ec1719..6624cbca7a83 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -21,7 +21,6 @@
 
 #ifndef __TSL2X7X_H
 #define __TSL2X7X_H
-#include <linux/pm.h>
 
 struct tsl2x7x_lux {
 	unsigned int ratio;
@@ -91,9 +90,6 @@ struct tsl2x7x_settings {
  *
  */
 struct tsl2X7X_platform_data {
-	int (*platform_power)(struct device *dev, pm_message_t);
-	int (*power_on)(struct iio_dev *indio_dev);
-	int (*power_off)(struct i2c_client *dev);
 	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];
 	struct tsl2x7x_settings *platform_default_settings;
 };
-- 
2.14.3

