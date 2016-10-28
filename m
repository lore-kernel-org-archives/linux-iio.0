Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50894 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759990AbcJ1KAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Oct 2016 06:00:32 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
Subject: [PATCH 09/10] staging: iio: tsl2583: add error code to sysfs store functions
Date: Fri, 28 Oct 2016 06:00:20 -0400
Message-Id: <1477648821-3786-10-git-send-email-masneyb@onstation.org>
In-Reply-To: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

in_illuminance_input_target_store() and in_illuminance_calibrate_store()
validated the data from userspace, however it would not return an
error code to userspace if an invalid value was passed in. This patch
changes these functions so that they return -EINVAL if invalid data is
passed in.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 1462374..98afa5b 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -525,11 +525,10 @@ static ssize_t in_illuminance_input_target_store(struct device *dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value;
 
-	if (kstrtoint(buf, 0, &value))
+	if (kstrtoint(buf, 0, &value) || !value)
 		return -EINVAL;
 
-	if (value)
-		chip->taos_settings.als_cal_target = value;
+	chip->taos_settings.als_cal_target = value;
 
 	return len;
 }
@@ -541,11 +540,10 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	int value;
 
-	if (kstrtoint(buf, 0, &value))
+	if (kstrtoint(buf, 0, &value) || value != 1)
 		return -EINVAL;
 
-	if (value == 1)
-		taos_als_calibrate(indio_dev);
+	taos_als_calibrate(indio_dev);
 
 	return len;
 }
-- 
2.7.4

