Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35878 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbcFHESg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 00:18:36 -0400
Received: by mail-pa0-f67.google.com with SMTP id fg1so15551871pad.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jun 2016 21:18:36 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: proximity: lidar: switch to iio_device_claim_*_mode helpers
Date: Tue,  7 Jun 2016 21:18:04 -0700
Message-Id: <1465359484-26568-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch from using indio_dev->mlock to the iio_device_claim_*_mode
helper functions.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 4f502386..c0b0e82 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -203,22 +203,19 @@ static int lidar_read_raw(struct iio_dev *indio_dev,
 	struct lidar_data *data = iio_priv(indio_dev);
 	int ret = -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
-
-	if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW) {
-		ret = -EBUSY;
-		goto error_busy;
-	}
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
 		u16 reg;
 
+		if (iio_device_claim_direct_mode(indio_dev))
+			return -EBUSY;
+
 		ret = lidar_get_measurement(data, &reg);
 		if (!ret) {
 			*val = reg;
 			ret = IIO_VAL_INT;
 		}
+		iio_device_release_direct_mode(indio_dev);
 		break;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -228,9 +225,6 @@ static int lidar_read_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-error_busy:
-	mutex_unlock(&indio_dev->mlock);
-
 	return ret;
 }
 
-- 
2.7.4

