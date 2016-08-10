Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35089 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbcHJDYR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2016 23:24:17 -0400
Received: by mail-pa0-f65.google.com with SMTP id cf3so1990237pad.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Aug 2016 20:24:16 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 1/3] iio: chemical: atlas-ph-sensor: switch to iio_device_*_direct_mode helpers
Date: Tue,  9 Aug 2016 20:05:57 -0700
Message-Id: <1470798359-4919-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1470798359-4919-1-git-send-email-mranostay@gmail.com>
References: <1470798359-4919-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index ae038a59d256..8e39b37a5385 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -402,7 +402,9 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 		case IIO_PH:
 		case IIO_CONCENTRATION:
 		case IIO_ELECTRICALCONDUCTIVITY:
-			mutex_lock(&indio_dev->mlock);
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
 
 			if (iio_buffer_enabled(indio_dev))
 				ret = -EBUSY;
@@ -410,7 +412,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 				ret = atlas_read_measurement(data,
 							chan->address, &reg);
 
-			mutex_unlock(&indio_dev->mlock);
+			iio_device_release_direct_mode(indio_dev);
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.7.4

