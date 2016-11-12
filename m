Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55856 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966533AbcKLSTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:45 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 01/26] staging: iio: tsl2583: check if chip is in a working state in in_illuminance_calibrate_store
Date: Sat, 12 Nov 2016 13:19:16 -0500
Message-Id: <1478974781-1457-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

in_illuminance_calibrate_store() did not check to see if the chip is
in a working state. This patch adds the proper check. The return value
from taos_als_calibrate() was also not checked in this function, so the
proper check was also added while changes are being made here.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 1a7be12..de54e74 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -501,16 +501,27 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int value;
+	int value, ret;
 
 	if (kstrtoint(buf, 0, &value) || value != 1)
 		return -EINVAL;
 
 	mutex_lock(&chip->als_mutex);
-	taos_als_calibrate(indio_dev);
+
+	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
+		ret = -EBUSY;
+		goto done;
+	}
+
+	ret = taos_als_calibrate(indio_dev);
+	if (ret < 0)
+		goto done;
+
+	ret = len;
+done:
 	mutex_unlock(&chip->als_mutex);
 
-	return len;
+	return ret;
 }
 
 static ssize_t in_illuminance_lux_table_show(struct device *dev,
-- 
2.7.4

