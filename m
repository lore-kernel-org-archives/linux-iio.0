Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35474 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755636AbcHSUgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2016 16:36:19 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so3863884pad.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Aug 2016 13:36:18 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/3] iio: chemical: atlas-ph-sensor: switch to iio_device_*_direct_mode helpers
Date: Fri, 19 Aug 2016 13:36:09 -0700
Message-Id: <1471638971-23039-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
References: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index ae038a59d256..696875413d10 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -402,15 +402,13 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 		case IIO_PH:
 		case IIO_CONCENTRATION:
 		case IIO_ELECTRICALCONDUCTIVITY:
-			mutex_lock(&indio_dev->mlock);
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
 
-			if (iio_buffer_enabled(indio_dev))
-				ret = -EBUSY;
-			else
-				ret = atlas_read_measurement(data,
-							chan->address, &reg);
+			ret = atlas_read_measurement(data, chan->address, &reg);
 
-			mutex_unlock(&indio_dev->mlock);
+			iio_device_release_direct_mode(indio_dev);
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.7.4

