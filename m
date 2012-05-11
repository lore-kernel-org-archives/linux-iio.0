Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-184.synserver.de ([212.40.185.184]:1305 "EHLO
	smtp-out-167.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754436Ab2EKLoL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 07:44:11 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: Remove unused iio_device_put()
Date: Fri, 11 May 2012 13:46:55 +0200
Message-Id: <1336736816-15678-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This function is currently unused and we do not have a matching iio_device_get()
function either, so just remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/iio.h |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 6fdbdb8..eff2a39 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -412,16 +412,6 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 
 extern struct bus_type iio_bus_type;
 
-/**
- * iio_device_put() - reference counted deallocation of struct device
- * @dev: the iio_device containing the device
- **/
-static inline void iio_device_put(struct iio_dev *indio_dev)
-{
-	if (indio_dev)
-		put_device(&indio_dev->dev);
-};
-
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
-- 
1.7.10

