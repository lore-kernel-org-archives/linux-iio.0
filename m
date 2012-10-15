Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1084 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2JOJee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:34:34 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] iio: Add some helper macros for unit conversion
Date: Mon, 15 Oct 2012 11:35:24 +0200
Message-Id: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some datasheets use a different unit to specify the channel scale than what IIO
expects it to be. This patch adds two helper macros which allow to convert units
commonly used in datasheets to IIO units:

 * acceleration: g -> meter / second**2
 * angular velocity: degree (/ second) -> rad (/ second)

This makes it much more convenient to specify and also easier to verify a
channel's scale attribute.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/iio.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index c0ae76a..7806c24 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -618,4 +618,20 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 };
 #endif
 
+/**
+ * IIO_DEGREE_TO_RAD() - Convert degree to rad
+ * @deg: A value in degree
+ *
+ * Returns the given value converted from degree to rad
+ */
+#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)
+
+/**
+ * IIO_G_TO_M_S_2() - Convert g to meter / second**2
+ * @g: A value in g
+ *
+ * Returns the given value converted from g to meter / second**2
+ */
+#define IIO_G_TO_M_S_2(g) ((g) * 980665ULL / 100000ULL)
+
 #endif /* _INDUSTRIAL_IO_H_ */
-- 
1.7.10.4

