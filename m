Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1065 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756438Ab2EUITA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 04:19:00 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: Add iio_device_get()
Date: Mon, 21 May 2012 10:21:53 +0200
Message-Id: <1337588514-23938-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add the iio_device_get() function, which increases the reference
count of a iio device. The matching function to decrease the reference count -
iio_device_put() - already exists.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/iio.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3a4f6a3..3238fa3 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -438,6 +438,17 @@ static inline struct iio_dev *dev_to_iio_dev(struct device *dev)
 	return container_of(dev, struct iio_dev, dev);
 }
 
+/**
+ * iio_device_get() - increment reference count for the device
+ * @indio_dev: IIO device structure
+ *
+ * Returns: The passed IIO device
+ **/
+static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
+{
+	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
+}
+
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
-- 
1.7.10

