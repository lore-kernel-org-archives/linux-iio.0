Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:52878 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeCDBy4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 20:54:56 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 09/12] staging: iio: tsl2x7x: add missing error checks
Date: Sat,  3 Mar 2018 20:49:39 -0500
Message-Id: <20180304014942.18727-10-masneyb@onstation.org>
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The functions in_illuminance0_calibrate_store() and
in_illuminance0_lux_table_store() did not have complete error handling
in place. This patch adds the missing error handling.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8adc6db44790..da7a4e025083 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -940,8 +940,11 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 	if (strtobool(buf, &value))
 		return -EINVAL;
 
-	if (value)
-		tsl2x7x_als_calibrate(indio_dev);
+	if (value) {
+		ret = tsl2x7x_als_calibrate(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
@@ -1006,8 +1009,11 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING)
-		tsl2x7x_chip_off(indio_dev);
+	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
+		ret = tsl2x7x_chip_off(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Zero out the table */
 	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));
-- 
2.14.3

